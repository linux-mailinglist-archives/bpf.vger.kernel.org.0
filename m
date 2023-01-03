Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C894965BC16
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 09:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjACIWG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 03:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbjACIV6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 03:21:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E5E273;
        Tue,  3 Jan 2023 00:21:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8AEE611D7;
        Tue,  3 Jan 2023 08:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BD6C433D2;
        Tue,  3 Jan 2023 08:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672734117;
        bh=dqCGbesuZiSsICKd93nHojCpNBxlFGWi0BSgSMEb2pA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sBpIsLtIFN6ZpAAvncp4NPROcu9aq/ZhbboTy6pAxSq/YNT6got2j0ZNoYXyxaDjA
         eIn959uLAsLuVQgktqfl8IuQA5Y5wBcm59pMAGl7AY35WHlusiPuKfc9LwCyGHi+cw
         eqVTyM/iRFa0WtcwwB4ePCn78mcqXX28noBbCHMuUbFHCDZ/jdSOHlenB5ofbSL01E
         jBpGE2PlGurycpmFSrC591OzUqC/cuOj4cB1v5llVIt/FJGAv/CKcFezFbVqd5QdJs
         qqje8Q32aPVfIa4ZJ8llY8VX4AAu62dOZ7EJi+VAc2790Kg7+XWsg4SgVoEmwrbYOu
         BqBCMxrNobCvg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Pu Lehui <pulehui@huawei.com>, Pu Lehui <pulehui@huaweicloud.com>,
        bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [RFC PATCH bpf-next 3/4] riscv, bpf: Add bpf_arch_text_poke
 support for RV64
In-Reply-To: <713f9f26-da42-eda8-c804-338d61b1557c@huawei.com>
References: <20221219133736.1387008-1-pulehui@huaweicloud.com>
 <20221219133736.1387008-4-pulehui@huaweicloud.com>
 <87v8looypd.fsf@all.your.base.are.belong.to.us>
 <713f9f26-da42-eda8-c804-338d61b1557c@huawei.com>
Date:   Tue, 03 Jan 2023 09:21:54 +0100
Message-ID: <877cy4xc2l.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pu Lehui <pulehui@huawei.com> writes:

> On 2023/1/3 15:37, Bj=C3=B6rn T=C3=B6pel wrote:
>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>=20
>>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_c=
omp64.c
>>> index bf4721a99a09..fa8b03c52463 100644
>>> --- a/arch/riscv/net/bpf_jit_comp64.c
>>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>>=20
>>> @@ -1266,7 +1389,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn=
, struct rv_jit_context *ctx,
>>>=20=20=20
>>>   void bpf_jit_build_prologue(struct rv_jit_context *ctx)
>>>   {
>>> -	int stack_adjust =3D 0, store_offset, bpf_stack_adjust;
>>> +	int i, stack_adjust =3D 0, store_offset, bpf_stack_adjust;
>>>   	bool is_main_prog =3D ctx->prog->aux->func_idx =3D=3D 0;
>>=20
>> This line magically appeared, and makes it hard to apply the series
>> without hacking the patches manually. Going forward, please supply a
>> base tree commit to the series (or a link to a complete git tree).
>>=20
>
> A rebase version has been resend as follow:
>
> https://lore.kernel.org/bpf/20221220021319.1655871-1-pulehui@huaweicloud.=
com/

Yes, but with the same issue:
https://lore.kernel.org/bpf/20221220021319.1655871-4-pulehui@huaweicloud.co=
m/

The "is_main_prog" line is still around in the resend.


Bj=C3=B6rn
