Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9FE5649F5
	for <lists+bpf@lfdr.de>; Sun,  3 Jul 2022 23:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiGCV0B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Jul 2022 17:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiGCVZ7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Jul 2022 17:25:59 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AD95F53;
        Sun,  3 Jul 2022 14:25:56 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B3465C00BC;
        Sun,  3 Jul 2022 17:25:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 03 Jul 2022 17:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1656883553; x=1656969953; bh=Vi
        Snpy4uk304FzVxK+VUDVRrSojSFguSsD9Qyx6622M=; b=EaRV3RiG5dnuDaSzcj
        iBQyDAyvWgJB7y/wkrAPHuPR9M4clHJKXIxL0glbOuwun4LiSqfwrMLznzEEcNAc
        OZI1w2OF2ZY0kYX6w0qNOjAeQyhPHZRnYjmlrjW2tLY2X506OyldRgP1goCG86Oh
        l/LEKXkENeUcJR6E97D99g1IbBPgXWchxhTlnbiau1xysfBEz06RupZ0VoU2tX0f
        e8XWL/GwTaO1DUKledfzMQyYX68Vimms8av0UHLBIRSAUwjV88Xr4at8+i8K05tm
        tcyLqEOjZEBDNMQ1gaxE7hulppFbf1p9RY+Y+21WgDhB/lLjErP7HZZaoGaTC29N
        T8Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1656883553; x=1656969953; bh=ViSnpy4uk304F
        zVxK+VUDVRrSojSFguSsD9Qyx6622M=; b=lmJstbcbeTrNalagF6MS2M1wCOLxy
        vWVZwmVEJ062X/tkKDEufG02g7c+e4N1+RaFCgsmD9mO7+lUY+KzRdMbxmmEEtQ7
        s7XCNErMM+nVQMiTt9UpC7D3y6ZIQ6MsAEP0EVzhw43dhVZfRIUO5jmAPCBhCHN3
        YTP5vz8m/MtDCc9B+2VJiuWiiMw94JfXyUCj7PmGSXaBD7nCCg/hxWcXosz66u+H
        fo0hxBvt4XcMx3KpmR9ewq79lfq4aiQPu46hesT0+1thb+f48YHpN7J++42DHu5a
        okk8sxk4dlTfITuH9zaxNn/6ywO7+be5q37yby2vM/L0wQXhagnBAvrXA==
X-ME-Sender: <xms:YQnCYh9VxLYeY3Wp1j0CgnV6uVY7UUy_Nt1RktQaws4rTwsOEh719Q>
    <xme:YQnCYls0nNjpK-9MNed8IzPFOnd2lPl9rOMEbdJ6eHG0WTXU_AkTbthyzI2_MUCl1
    IoeqWD_oaFNVYs1Ig>
X-ME-Received: <xmr:YQnCYvBk0LbGw1ZiQ2A4GGW07F_yOn2-V2k1C2aEdUsYBrbUYj1R9MboOWhusV7aQrCKp2U1X-inP-23wW70K2hpa2BrR1Xj5leideQcKqxFqM8OevYFS2Ym1suu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehjedgudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgu
    rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
    frrghtthgvrhhnpeeljefgvdefhfdukedttdevgedtkeeigefftdekleejteduveffledt
    ieefueegieenucffohhmrghinhepshhouhhrtggvfigrrhgvrdhorhhgpdhkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:YQnCYlcGjoNWsY7c9qEW3Em8ma8hTibc4dI46wzh8PLFPPfY-5_Qrw>
    <xmx:YQnCYmOhoiOG9aJR-9yAOCeq9EdvfuWGDlos5CoXjqZCUjuhlk_W6Q>
    <xmx:YQnCYnlFaGtZc_nGk3BLlJ2yMmNI_k_oawWWlps3JfRngtLarjKUlg>
    <xmx:YQnCYt1X9ferRUlyf4ymKdWZ5WWKVWlBm-EZ1WqIiSMBlPZSMpwdKQ>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Jul 2022 17:25:52 -0400 (EDT)
From:   Andres Freund <andres@anarazel.de>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH v2 0/5] tools: fix compilation failure caused by init_disassemble_info API changes
Date:   Sun,  3 Jul 2022 14:25:46 -0700
Message-Id: <20220703212551.1114923-1-andres@anarazel.de>
X-Mailer: git-send-email 2.37.0.3.g30cc8d0f14
In-Reply-To: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

binutils changed the signature of init_disassemble_info(), which now causes
compilation failures for tools/{perf,bpf} on e.g. debian unstable. Relevant
binutils commit:
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07

I first fixed this without introducing the compat header, as suggested by
Quentin, but I thought the amount of repeated boilerplate was a bit too
much. So instead I introduced a compat header to wrap the API changes. Even
tools/bpf/bpftool/jit_disasm.c, which needs its own callbacks for json, imo
looks nicer this way.

I'm not regular contributor, so it very well might be my procedures are a
bit off...

I am not sure I added the right [number of] people to CC?

WRT the feature test: Not sure what the point of the -DPACKAGE='"perf"' is,
nor why tools/perf/Makefile.config sets some LDFLAGS/CFLAGS that are also
in feature/Makefile and why -ldl isn't needed in the other places. But...

V2:
- split patches further, so that tools/bpf and tools/perf part are entirely
  separate
- included a bit more information about tests I did in commit messages
- add a maybe_unused to fprintf_json_styled's style argument

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>
To: bpf@vger.kernel.org
To: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Link: https://lore.kernel.org/lkml/CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com

Andres Freund (5):
  tools build: add feature test for init_disassemble_info API changes
  tools include: add dis-asm-compat.h to handle version differences
  tools perf: Fix compilation error with new binutils
  tools bpf_jit_disasm: Fix compilation error with new binutils
  tools bpftool: Fix compilation error with new binutils

 tools/bpf/Makefile                            |  7 ++-
 tools/bpf/bpf_jit_disasm.c                    |  5 +-
 tools/bpf/bpftool/Makefile                    |  7 ++-
 tools/bpf/bpftool/jit_disasm.c                | 42 ++++++++++++---
 tools/build/Makefile.feature                  |  4 +-
 tools/build/feature/Makefile                  |  4 ++
 tools/build/feature/test-all.c                |  4 ++
 .../feature/test-disassembler-init-styled.c   | 13 +++++
 tools/include/tools/dis-asm-compat.h          | 53 +++++++++++++++++++
 tools/perf/Makefile.config                    |  8 +++
 tools/perf/util/annotate.c                    |  7 +--
 11 files changed, 137 insertions(+), 17 deletions(-)
 create mode 100644 tools/build/feature/test-disassembler-init-styled.c
 create mode 100644 tools/include/tools/dis-asm-compat.h

-- 
2.37.0.3.g30cc8d0f14

