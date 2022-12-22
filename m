Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BF965416E
	for <lists+bpf@lfdr.de>; Thu, 22 Dec 2022 14:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiLVNAk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Dec 2022 08:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiLVNAk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Dec 2022 08:00:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C1BC09;
        Thu, 22 Dec 2022 05:00:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7726DB81D2D;
        Thu, 22 Dec 2022 13:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D61C433D2;
        Thu, 22 Dec 2022 13:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671714036;
        bh=9W5wvIsudxlyGWjHXQF4tUGsiSCy97rCYsCSM77Fg00=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dcnzhC9r1DlFOf5fxMK6qAK/mWD0n9P52cyC6lX/n411r5np52AZp3mrqa6wAnRNR
         plT+6Mo/k5/VMd7IsD+D0UrZeTmKXhiqypuVaWuj9Uj/EHedpLogBWQ85eUhscJYVb
         4/6UL3dLJB2O4Y8Jg2/UKJ+2snswaQhAVvVbYJUVsyOLpoA+2cNXsbUAn/3BSg20dP
         HBiipcUVhQtcXkIyHkwDJiMdG5OoOjsFvKQ43S2L0gctF2n7XUkf5qRlPA+Hwy7Wd7
         qB31vpwGubOk0lfVBs7e8IJTtxUczi4wA6YvYyuKEsi6xvzS3Caez5j5NShZGQC3Iu
         +k02QLKYRa/Qg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
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
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [RFC PATCH RESEND bpf-next 0/4] Support bpf trampoline for RV64
In-Reply-To: <20221220021319.1655871-1-pulehui@huaweicloud.com>
References: <20221220021319.1655871-1-pulehui@huaweicloud.com>
Date:   Thu, 22 Dec 2022 14:00:33 +0100
Message-ID: <87ili3a8zy.fsf@all.your.base.are.belong.to.us>
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

> BPF trampoline is the critical infrastructure of the bpf
> subsystem, acting as a mediator between kernel functions
> and BPF programs. Numerous important features, such as
> using ebpf program for zero overhead kernel introspection,
> rely on this key component. We can't wait to support bpf
> trampoline on RV64. The implementation of bpf trampoline
> was closely to x86 and arm64 for future development.

Thank you for working on this! BPF trampoline is the "missing piece"
from getting proper kfunc support.

Unfortunately, I wont be able to do a proper review until next week.


Happy holidays,
Bj=C3=B6rn
