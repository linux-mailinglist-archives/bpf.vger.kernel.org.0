Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD4D69CF7E
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 15:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjBTOeu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 09:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjBTOer (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 09:34:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898191EFCD;
        Mon, 20 Feb 2023 06:34:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 415F9B80D44;
        Mon, 20 Feb 2023 14:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F6DC433EF;
        Mon, 20 Feb 2023 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676903682;
        bh=Q7xwmxAFcgiZe5wxX+YHvnpG14ZgiYhdN894N7fOwzE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=uVVEmlRRh5fcR0sE9YzM1KrFuZ6AaIZSSfoxCIWkgcWQzAmX4FhRVODb8lDI59v46
         dUQKhXFssYXhNzGkyXQFVNk2bQgO2hnvKrGlwcU1rIY2wAVLQHMCF8cc/gm+KNUpii
         7n+qghnJKHpwPPjGxNJ5VNZGdFdp5g55FcDSoxbvLm0IUsRThQQpRDR8c0qoWivCu/
         mdh6gf8w2dACAnIRHpGqZvJSIe++bZ4aTWsmXOgkub4XbowfwSfwc3gkmtqQQ5mjSL
         XyeUSgs+2k025BHAPcGnLW8ifsNrGKyDzdp+CWnzlRp5bJuQaKjk9PWJxmA/6Aal3n
         MF8YZyaErpTcg==
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
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v2] riscv, bpf: Add kfunc support for RV64
In-Reply-To: <20230220083203.2988238-1-pulehui@huaweicloud.com>
References: <20230220083203.2988238-1-pulehui@huaweicloud.com>
Date:   Mon, 20 Feb 2023 15:34:39 +0100
Message-ID: <874jrg76dc.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> As another important missing piece of RV64 JIT, kfunc allow bpf programs
> call kernel functions. For now, RV64 is sufficient to enable it.

Thanks Lehui!

Maybe we can reword/massage the commit message a bit? What do you think
about something like:

"Now that the BPF trampoline is supported by RISC-V, it is possible to
use BPF programs with kfunc calls.

Note that the trampoline functionality is only supported by RV64.

Add bpf_jit_supports_kfunc_call() to the 64-bit JIT."


Bj=C3=B6rn
