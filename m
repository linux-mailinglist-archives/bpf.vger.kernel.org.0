Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BEE643EED
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 09:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiLFInA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 03:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiLFIm5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 03:42:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE1663A5;
        Tue,  6 Dec 2022 00:42:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3902F615C5;
        Tue,  6 Dec 2022 08:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21606C433D6;
        Tue,  6 Dec 2022 08:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670316175;
        bh=/uuvuXgxZ5ZLrdsqrg9NhzM2RQM4AhSfL3k25vRXOq4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=K5Fx+UCPvzDZ57iIqGv6A6/V0/YFagMy6dGQhsdNCzNkO15+X6FCQs76HvbjnaJiz
         J7oTopzvH1whEtTzfGHU4+Dt2TUlk7ZAFnBVSRvygwYlvjzw77vVZj5+AVLzJ7pG/L
         6mcAc2pT+q7s21NSTcItegl5mFfjJBr/x/YTfyGGgm05rVqrnTQKCY1g2GfgnX+2Os
         92FdTONc0qM+aNYRrBNx4ZGw9dNU0tA3POc57D3D0YW4BEoTbFUZK1XuFx67naeIC+
         j7hdpiJSUhqfzHVT99if05sDidfeh29Wa+qAbhNoyWFIElyHzIXFnrmuIW6G5Q7boP
         Ah9uc7fabHHuA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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
        Albert Ou <aou@eecs.berkeley.edu>,
        Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf v2] riscv, bpf: Emit fixed-length instructions for
 BPF_PSEUDO_FUNC
In-Reply-To: <0620000f-4d06-de15-09d9-24b5b0c47410@huaweicloud.com>
References: <20221202094837.3872444-1-pulehui@huaweicloud.com>
 <87y1rq848x.fsf@all.your.base.are.belong.to.us>
 <0ade59ea-6863-4d68-607c-22e4b9405a0d@huaweicloud.com>
 <87359t3r0h.fsf@all.your.base.are.belong.to.us>
 <0620000f-4d06-de15-09d9-24b5b0c47410@huaweicloud.com>
Date:   Tue, 06 Dec 2022 09:42:52 +0100
Message-ID: <87359szzw3.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pu Lehui <pulehui@huaweicloud.com> writes:

>> Wouldn't that work?
>> 
>
> It definitely works. But auipc+addi may be some holes, while 
> lui+addi+slli support all the address of kernel and module. And this 
> might be help for the future feature porting.

We're already using auipc/jalr for calls, and I'd say it *very* unlikely
that we'll hit the non-covered range. I'd say go with auipc/addi +
error, and we can change if this really is a problem.
