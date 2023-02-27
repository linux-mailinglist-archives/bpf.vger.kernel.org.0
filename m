Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2216A4F62
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 00:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjB0XCN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 18:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjB0XCL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 18:02:11 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F7225953
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 15:02:09 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1FE8632009B2;
        Mon, 27 Feb 2023 18:02:09 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute1.internal (MEProxy); Mon, 27 Feb 2023 18:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1677538928; x=1677625328; bh=R96LQlv1vR70+5TPDcH/Kwf8wTOl/FYb7u1
        LEZx6w+I=; b=coDW07OPK3s9BNY3s0xccSPdH+N5LzX3TtkFez2Ty4MwDTcgjs+
        xDoNhZ1ktshgBCXwALNpTZn+hxzHqvHXyFFtqHjAwaHHVwE+RlDfCCx4nhN9e9hX
        mnVzf8zul9cv0FzjkrWJrtDCS5ofJdUgy2FmtJgx0FAzDIEUBScMWWAMVvNS0+1E
        vV7+A2Y24OnmLMpmQNVfirvlTZFMVW35zKLKx7edoHO3Yvxv1ryLVXnDK3Zy8Zx6
        KI85rJ2H7sOLTZmv0KQ1IUbsXyR5YjKJjaxdTz/DU+Losa3nMCY/jjmjpKCfUVIF
        0iYVlI1FUFR79z8R5+2XUqXBt9uwvKHXr8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1677538928; x=
        1677625328; bh=R96LQlv1vR70+5TPDcH/Kwf8wTOl/FYb7u1LEZx6w+I=; b=h
        rL4jjNipfUtq/h4WSbMF/n1RwI+hJFDLwUrRz+TjbT0H/YEsL0g1xRzeI3DTzp11
        qqZSnnjvsfu3aLd3K+RtrOtQ1lyK1Qdr6FfBm8gpA6E37QejWFjhRfMhZKY6DQj0
        41BA/9qnhGLZNEbszwzzjYh1oEL4T6wQBDQk7RgOUMFCKYfK49EC2KYGJ4uok6Gg
        NVvtN0naP0DMRoyn3VrpVIwCusjtyd+q/9oGb2mB95BFXK6Ki/T9w5ynhf4ASimP
        8WbCNqMwFz82hsRkZlaTWEjdWDLcW+Zcz0RXe8r2aQTxkvmc+PyU+cW3O/9UqHCA
        28SnKWoOapnImgJxJRH9Q==
X-ME-Sender: <xms:cDb9Y-ij0GQjB7mtGjoYKG5qOVAsYDWOstDo11wDGx2tqTJUTzptHw>
    <xme:cDb9Y_BV7vExWZKpgX5-M5WELHArL6fJTaIV5yK57H3Iw-iaFgXAvoN9kDmeLX4fZ
    Q5A3fgZswtHp6j1bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeluddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefofg
    ggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdffrghnihgvlhcuighufdcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeifffgteduheette
    fhheeiffefffdtleduvefggefhgeehffekjeeuhedugfeiieenucffohhmrghinhepghhi
    thhhuhgsrdgtohhmpdhruhhnqdhtvghsthhsrdhshhdprhhunhdrshhhpdhvmhhtvghsth
    drshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:cDb9Y2GPUHRYbYh7LeqEOixTGfJR_KTs1LgLKWIPk0GDm9y1tz3Dyw>
    <xmx:cDb9Y3SebXd6cj-vctjV8qrPwfhTlKWi5WvCo5OLCJc97GKOdGLCQQ>
    <xmx:cDb9Y7xzPD2oJ7JTNyd0lY2jBPrK9ekuTPEEU3aoCzL0W4re8V79EA>
    <xmx:cDb9Y8tWjSL7cO9WxH8v8xmazDfQwXjwJDEvdS1rIiMA2QqtOTwhXg>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 525A9BC007C; Mon, 27 Feb 2023 18:02:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <f1ea109c-5f07-4734-83f5-12c4252fa5ae@app.fastmail.com>
Date:   Mon, 27 Feb 2023 16:01:48 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] vmtest: Reusable virtual machine testing infrastructure
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

=== Introduction ===

Testing is paradoxically one of BPF's great strengths as well as one of it's
current weaknesses. Fortunately, this weakness is not too far from being
corrected.

BPF_PROG_RUN is somewhat of a double edged sword. On the one hand, you can run
reproducibly run progs in near-production context. On the other hand, since BPF
is so deeply intertwined with the running kernel, you must make the kernel you
run tests on as close to your production kernel as possible to get full testing
benefits.

This is going to be more of an issue going forward through the growth of kfuncs
because kfuncs do not possess a stable ABI [5]. Proper testing should be
encouraged at a community-wide level in order to avoid accidental surprises and
potential loss of faith in BPF "stability".

Most successful kernel-dependent projects deploy some form of
virtual-machine-based testing [1][2][3][4] to solve the above issues. However,
there are two problems with this:

1. VM-based testing is not quite common knowledge yet and remains somewhat of
   a dark art to successfully implement.

2. Multiple implementations of what is essentially the same thing is somewhat
   of a drain on resources.

(These are not necessarily bad things -- it is useful and necessary to explore a
problem space before settling on best practices)

vmtest [0] aims to solve both problems.

=== Goals ===

I'd like to do a short presentation on the design and ideas behind vmtest. I'd
also like to show a quick demo. It shouldn't take very long. I'll probably
also share what I'd like to implement next. I don't know what that's going
to be at time of writing b/c I'm probably going to get to it before LSFMMBPF.

For the rest of the time I'd like to discuss what the community would like to
see in vmtest. And to hear what it'd take to see adoption from other projects.
Obviously no one can be required to adopt vmtest but I think it'll save everyone
a good deal of effort if done correctly.

Thanks,
Daniel


[0]: https://github.com/danobi/vmtest
[1]: https://github.com/cilium/ebpf/blob/master/run-tests.sh
[2]: https://github.com/osandov/drgn/tree/main/vmtest
[3]: https://github.com/libbpf/ci/blob/master/run-qemu/run.sh
[4]: https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/vmtest.sh
[5]: https://github.com/torvalds/linux/commit/16c294a6aad86
