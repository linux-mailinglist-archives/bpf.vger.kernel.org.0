Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DB86772A6
	for <lists+bpf@lfdr.de>; Sun, 22 Jan 2023 22:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjAVV0P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 22 Jan 2023 16:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjAVV0O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 22 Jan 2023 16:26:14 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966C21350B
        for <bpf@vger.kernel.org>; Sun, 22 Jan 2023 13:26:11 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id F1DA85C008E;
        Sun, 22 Jan 2023 16:26:08 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute1.internal (MEProxy); Sun, 22 Jan 2023 16:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674422768; x=1674509168; bh=Fo6mBFrWR1
        3canRuCwb1uAwn+xRoql2kUKT/KiEqy8o=; b=U+Gw0TO/wO7B/DTwTSTxPuEbLz
        Pcqh4KRqtNX1IBUSbxtnZnW92g5Kwut9MbTL7ZoCz1re22ZKBLttX5DkLuXXgNcL
        2csxW1+SGLMGtPOA8+xDD3lL28Xt6pA3tqSv14539ZqG96Xte0ZnhT8L6DztKuph
        Fdi9M+FPV6GKYwwlRExpqPjGXQGl0rMjM0fdDHlMInU393DJry+q9jVakRvWxPgj
        b1NmMknNAEo4HVyHPzE0h0tkTBatQuicmM64KS3XVhinZzpJ+aiDILANVkkGlAoC
        BZfwsrfF5c73H9s4Yr7LudgNoTvhyj+l9kJEYiWWi971Qo3apiHFil2Bh+OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674422768; x=1674509168; bh=Fo6mBFrWR13canRuCwb1uAwn+xRo
        ql2kUKT/KiEqy8o=; b=QTA/GGFMhLjkl/efyRn6zFS1B17G4lz2VzHLCNuo47JF
        3yjt8nvH/0PuqyP5oQareVRnp2Bxr07zWhD4yV4q5NxDftK/KlxUbV/fCviWR7b5
        lRTwZyqfhbG3wiluVR8KQDPG0XJXMsuRENsR/GTEYtsJ1M7IK6knMA8JTl/ScR/D
        5bAVZGW+KwBQrSruUH8SVqjpud8YV9gziumJ9gdGuYcnKeWyena3+/vwIckLcW9T
        RsKlwV1Xhvs6SB8URhNwsoBr/rbvbCxDnZOuQMFQnT44mmDXsEh3lpeGGPhDeCdY
        rnqG96IHR/OLnQUpQHhsu7tQ+cT7XBnq/vxOLz/7Rw==
X-ME-Sender: <xms:8KnNYxDAOanF94QXsREDqSBYCgCcBmeafbWF5fKAbHeKkPd0ReBFtg>
    <xme:8KnNY_hC2yYyFYaT-_BXlcnvD824pvjIrdlRA9SCeJCNTyC5nSkkPbDICkJb5Dani
    Ug6QhW8-J_Vma8YaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduiedgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhepof
    gfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfffgrnhhivghlucgi
    uhdfuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhephffhgedtke
    duheekueejfefgkeejffegtdekveeifedvjeffheejkeduiedugedtnecuffhomhgrihhn
    pehkrghllhhshihmshdurdhsrghspdhkrghllhhshihmshdvrdhsrghspdhkrghllhhshi
    hmshefrdhsrghsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:8KnNY8mrhk14U0az0YfQUxMNyQB4g7qwvJDEsngY2zrtN5g7GCH3nQ>
    <xmx:8KnNY7wm3fDWyH2VBsHqBdBx7YY1cE-JQVY9aMkSuXmzHiREp56Ygg>
    <xmx:8KnNY2Qqiji-n0O4KExDaWCzs7URu38O53WT_0VT6aM9dF3bOZU61A>
    <xmx:8KnNY9Pcd1b1umZ5FLAy8u7VmL0fDd_M9IafADcnIHhbZkTU4vHAFQ>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AB590BC0078; Sun, 22 Jan 2023 16:26:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <cf0f4f1f-b2b4-40e8-bc51-ef1e1771e1e2@app.fastmail.com>
In-Reply-To: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
References: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
Date:   Sun, 22 Jan 2023 14:25:47 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     "Arnaldo Carvalho de Melo" <acme@kernel.org>
Subject: Re: Kernel build fail with 'btf_encoder__encode: btf__dedup failed!'
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_PDS_OTHER_BAD_TLD,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 22, 2023, at 10:48 AM, Daniel Xu wrote:
> Hi,
>
> I'm getting the following error during build:
>
>         $ ./tools/testing/selftests/bpf/vmtest.sh -j30
>         [...]
>           BTF     .btf.vmlinux.bin.o
>         btf_encoder__encode: btf__dedup failed!
>         Failed to encode BTF
>           LD      .tmp_vmlinux.kallsyms1
>           NM      .tmp_vmlinux.kallsyms1.syms
>           KSYMS   .tmp_vmlinux.kallsyms1.S
>           AS      .tmp_vmlinux.kallsyms1.S
>           LD      .tmp_vmlinux.kallsyms2
>           NM      .tmp_vmlinux.kallsyms2.syms
>           KSYMS   .tmp_vmlinux.kallsyms2.S
>           AS      .tmp_vmlinux.kallsyms2.S
>           LD      .tmp_vmlinux.kallsyms3
>           NM      .tmp_vmlinux.kallsyms3.syms
>           KSYMS   .tmp_vmlinux.kallsyms3.S
>           AS      .tmp_vmlinux.kallsyms3.S
>           LD      vmlinux
>           BTFIDS  vmlinux
>         FAILED: load BTF from vmlinux: No such file or directory
>         make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
>         make[1]: *** Deleting file 'vmlinux'
>         make: *** [Makefile:1264: vmlinux] Error 2
>
> This happens on both bpf-next/master (84150795a49) and 6.2-rc5
> (2241ab53cb).
>
> I've also tried arch linux pahole 1:1.24+r29+g02d67c5-1 as well as
> upstream pahole on master (02d67c5176) and upstream pahole on
> next (2ca56f4c6f659).
>
> Of the above 6 combinations, I think I've tried all of them (maybe
> missing 1 or 2).
>
> Looks like GCC got updated recently on my machine, so perhaps
> it's related?
>
>         CONFIG_CC_VERSION_TEXT="gcc (GCC) 12.2.1 20230111"
>
> I'll try some debugging, but just wanted to report it first.
>
> Thanks,
> Daniel

Applying the following diff:

diff --git a/src/btf.c b/src/btf.c
index ae1520f..8a2fa36 100644
--- a/src/btf.c
+++ b/src/btf.c
@@ -4576,8 +4576,11 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
        int ref_type_id;
        long h;

-       if (d->map[type_id] == BTF_IN_PROGRESS_ID)
+       if (d->map[type_id] == BTF_IN_PROGRESS_ID) {
+               struct btf_type *t = btf_type_by_id(d->btf, type_id);
+               pr_warn("eloop type_id=%d, kind=%d, type=%d\n", type_id, btf_kind(t), t->type);
                return -ELOOP;
+       }
        if (d->map[type_id] <= BTF_MAX_NR_TYPES)
                return resolve_type_id(d, type_id);

Yields:

          BTF     .btf.vmlinux.bin.o
        libbpf: eloop type_id=2, kind=10, type=2
        btf_encoder__encode: btf__dedup failed!
        Failed to encode BTF

So it's a CONST pointing to itself?

I'm somewhat out of ideas here.
