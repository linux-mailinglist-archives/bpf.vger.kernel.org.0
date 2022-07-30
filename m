Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5BB585BCD
	for <lists+bpf@lfdr.de>; Sat, 30 Jul 2022 21:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbiG3Tkq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Jul 2022 15:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbiG3Tko (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Jul 2022 15:40:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66485167EF;
        Sat, 30 Jul 2022 12:40:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id F2F5A5C0095;
        Sat, 30 Jul 2022 15:40:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 30 Jul 2022 15:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1659210039; x=1659296439; bh=xOBsPksCdqcov7JXxKD8topM8
        +c6rpsTvLZgx6AhQ0s=; b=lbHDM+gtO+eqKdhMcQ2TK2stBTVaKgo5REnFwDBaz
        wYTlVojJDT96vX3RSS69TuvZSmUe/qfaayngWhJkUw8a35+fpEifr9N8J1A/z7BW
        GlZiCySZ9BhkcOtmAKoaOPhFZtMSMcLjWnuZmVnm36gh7R3EyT0wE3yO8Q2n1OxT
        TwjsU/s5m1eMejjafbqb2eNOohMdxwfJOfxxXE59+wribqQjW81TcPj+tBK0/gep
        KxB0lwv1NMkdAR5qhfwR+5frxGGvG7nEsun2jWMejtSPnjaBcWPA8kW95O9tJfuM
        c9HL5gwLEOGk7TfRbBE9/0KMCPcwKFvvmsmJPfCMQgZTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1659210039; x=1659296439; bh=xOBsPksCdqcov7JXxKD8topM8+c6rpsTvLZ
        gx6AhQ0s=; b=zL8KWZv4BMajxJCG+1mY/jjj99YJuqsuuu4qo9FD85NtuZQ66Np
        jR2nYEYLp/Kmedp2dm7Dz7dwUn8p+Jmz4mxMg3PZLmC3SbxGUcVZ5GOAZ7rPwKh6
        chvwoAWo7jbl8+EBCuRV20ylvcbm8MXuMYb5IJzPy3nBNXn9qcr847Rc4vOerxh6
        F52nMvBkWxpv2WQXELQvxvKFRdQB3cIBR64aZ6DE4IbyCc0SZRt9c4revKmy6+4Z
        jsifinUT/yJAgNIxiUSlBMi20uoIhxjvBX8qiioPrtlndq+gMX6t6HTCq8zZ32KS
        BQQCO/timaM4aX8c9XWlSw+8kl1x4We+W3w==
X-ME-Sender: <xms:N4nlYvtkxsJ3B-Ilkle6sJ0ha2hJO0McLpBy3lVTvXaukSsy25QfPw>
    <xme:N4nlYgedjDY41wdBkF1hZqao6Dr4HJaHaAXbOOaAv-90HjdnjXpJM34c22KqoAA2k
    srh_Gq3LlFgo7AkiQ>
X-ME-Received: <xmr:N4nlYix-x1p2dytMk-O0W-OpOOa1WDUPIYkARgEcPlLlEMkj8bqsoyHxJu5rYNo465Hz4WM6vDx7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduledgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvgefgtefgleehhfeufe
    ekuddvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:N4nlYuOsv5-84pfZOjPG-Rm6HMJwaD001Dv91X16qyzYsUS7xZ0XPw>
    <xmx:N4nlYv9SeLHtHhgxn0D4GmTchuEfAdKntyocF8Tp5fXk_y-BI4OCCg>
    <xmx:N4nlYuUMx9Dy6cAcBdO3RfcYcQauv3c8MHjcYYs0sZrpMpYmHitnhg>
    <xmx:N4nlYqn4Z8OfMOYSN8zGCXvO8HcKLd4RvtElYhkxcwj_GclyVlFo3A>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Jul 2022 15:40:38 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, memxor@gmail.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 0/2] Add more bpf_*_ct_lookup() selftests
Date:   Sat, 30 Jul 2022 14:40:28 -0500
Message-Id: <cover.1659209738.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds more bpf_*_ct_lookup() selftests. The goal is to test
interaction with netfilter subsystem as well as reading and writing from
`struct nf_conn`. The first is important when migrating legacy systems
towards bpf. The latter is important in general to take full advantage
of connection tracking.

This change will require two changes to BPF CI kconfig:

* CONFIG_NF_CONNTRACK_MARK=y
* CONFIG_NETFILTER_XT_CONNMARK=y

I can put up the PR if this patchset looks good.

Daniel Xu (2):
  selftests/bpf: Add existing connection bpf_*_ct_lookup() test
  selftests/bpf: Add connmark read/write test

 .../testing/selftests/bpf/prog_tests/bpf_nf.c | 60 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_bpf_nf.c | 21 +++++++
 2 files changed, 81 insertions(+)

-- 
2.37.1

