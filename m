Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9138165BF9C
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 13:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjACMF5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 07:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237540AbjACMFs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 07:05:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D5BE10;
        Tue,  3 Jan 2023 04:05:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 358C1612DC;
        Tue,  3 Jan 2023 12:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206C2C433EF;
        Tue,  3 Jan 2023 12:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672747545;
        bh=BbSLY1b6byZmGQc05X5BN64zeh0YRGMAJP0/SbbU3JU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QhE+NRBZq8OrNylqPT9lvf38CgQQGCh6husWdu5HCVnrg3JWvzVTCaaNSDcM1vjks
         f/vqySnXb/jFVLAhQS2L5uLPOKD9KeYvB4KWjbmu8zpqTGsBTtx8bb5gpsEjlvl9Lk
         YZaZBf2GvzBaC+evUCRbnwuJ5M3NWEUu82sNp4viBDnty0SVfFF4vZM1k5y9thCqOk
         Pqc9JIIPF/R7jkbejKV81jirEGe6bwGHFC1400jG89Q/BpFzrzS3N3I7iislA+9EcC
         Px5Y/8DX0w0KomRHDR582K3vYJlJKk8J/fCeAf4G+EhRj/Hr4qtS60feVPAlRurRbX
         GIqN3WFiVDYnw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Pu Lehui <pulehui@huaweicloud.com>,
        Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
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
        Albert Ou <aou@eecs.berkeley.edu>,
        Pu Lehui <pulehui@huawei.com>
Subject: Re: [RFC PATCH RESEND bpf-next 1/4] bpf: Rollback to text_poke when
 arch not supported ftrace direct call
In-Reply-To: <0039743b-5837-c0d3-7574-7719698f9dc1@huaweicloud.com>
References: <20221220021319.1655871-1-pulehui@huaweicloud.com>
 <20221220021319.1655871-2-pulehui@huaweicloud.com>
 <a2bf7ed9-4977-608c-d5a5-8ee6a520cf52@huawei.com>
 <0039743b-5837-c0d3-7574-7719698f9dc1@huaweicloud.com>
Date:   Tue, 03 Jan 2023 13:05:42 +0100
Message-ID: <87k023u8kp.fsf@all.your.base.are.belong.to.us>
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

Pu Lehui <pulehui@huaweicloud.com> writes:

> On 2022/12/20 10:32, Xu Kuohai wrote:
>> On 12/20/2022 10:13 AM, Pu Lehui wrote:
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> The current bpf trampoline attach to kernel functions via ftrace direct
>>> call API, while text_poke is applied for bpf2bpf attach and tail call
>>> optimization. For architectures that do not support ftrace direct call,
>>> text_poke is still able to attach bpf trampoline to kernel functions.
>>> Let's relax it by rollback to text_poke when architecture not supported.
>>>
>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>> ---
>>> =C2=A0 kernel/bpf/trampoline.c | 8 ++------
>>> =C2=A0 1 file changed, 2 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>>> index d6395215b849..386197a7952c 100644
>>> --- a/kernel/bpf/trampoline.c
>>> +++ b/kernel/bpf/trampoline.c
>>> @@ -228,15 +228,11 @@ static int modify_fentry(struct bpf_trampoline=20
>>> *tr, void *old_addr, void *new_ad
>>> =C2=A0 static int register_fentry(struct bpf_trampoline *tr, void *new_=
addr)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *ip =3D tr->func.addr;
>>> -=C2=A0=C2=A0=C2=A0 unsigned long faddr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> -=C2=A0=C2=A0=C2=A0 faddr =3D ftrace_location((unsigned long)ip);
>>> -=C2=A0=C2=A0=C2=A0 if (faddr) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!tr->fops)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn -ENOTSUPP;
>>> +=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CA=
LLS) &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !!ftrace_location((unsigned=
 long)ip))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tr->func.ftrace_=
managed =3D true;
>>> -=C2=A0=C2=A0=C2=A0 }
>>>
>>=20
>> After this patch, a kernel function with true trace_location will be=20
>> patched
>> by bpf when CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS is disabled, which=20
>> means
>> that a kernel function may be patched by both bpf and ftrace in a mutual=
ly
>> unaware way. This will cause ftrace and bpf_arch_text_poke to fail in a
>> somewhat random way if the function to be patched was already patched
>> by the other.
>
> Thanks for your review. And yes, this is a backward compatible solution=20
> for architectures that not support DYNAMIC_FTRACE_WITH_DIRECT_CALLS.

It's not "backward compatible". Reiterating what Kuohai said; The BPF
trampoline must be aware of ftrace's state -- with this patch, the
trampoline can't blindly poke the text managed my ftrace.

I'd recommend to remove this patch from the series.


Bj=C3=B6rn
