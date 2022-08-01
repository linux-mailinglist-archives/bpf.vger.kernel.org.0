Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EE158623D
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 03:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbiHABim (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 21:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiHABil (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 21:38:41 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B4ECE3C;
        Sun, 31 Jul 2022 18:38:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 466F93200564;
        Sun, 31 Jul 2022 21:38:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 31 Jul 2022 21:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1659317916; x=1659404316; bh=vp
        RNAfXL5V1zkx9Mm9VRQDJhTTBwYjQW/+wuIgKwrR4=; b=C/rVRaw3pMfjaDU97z
        NV7nbF4UiODq23yETZyiKixJofijwcbLI5f7s5Ml7Eba0dFEWWoxfrB+GSC3Akqx
        WyBS6180X3ke22n7tUPiVTdvFPrWCFkK+o44p36pbXXu+eBTbEF2Z7Lr7TpgJ1DI
        FkSYthdmmV/tLkozMgoeDDuzah0wLScOsPuIUfoCbtm/yf756ovblYzLnmisAtOo
        CkShatdjXohBy6xbWonR5BCcEBxKBVgZaqGvB2f/mZqLOY14aEgrQBxnwPgYQ7vy
        OCgQdLRzHHJqxy7FUGBIS99KPgoqeiCbGKeOHbNEyzlC4vhFjbtnSvlWIUrXQnH5
        YNRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659317916; x=1659404316; bh=vpRNAfXL5V1zk
        x9Mm9VRQDJhTTBwYjQW/+wuIgKwrR4=; b=ZeeaYOJDJYE6CCjqV8mniAQm9DKH6
        dYv2QCt/t0fnbOOkHzI/pH//dyn7jHndx5F43hdbRt/YSB9iICshrlMecAKpltEE
        zp30WDego10UxvcWK/kVRQ9BctkiXA4gRqGYrE3nNQo128eVnclOEFolfD/UsVUQ
        VDOCC6XKNgrutWUg5q+iEv9S5fwD4OQq4r/VRRDBjV55w4smQSX7M6CjYNxEgtZo
        8zSs0TyOy50rmvKOc9+oxrN3ZdtlVjJEl/c8hLkKqVZ5nTCD8dRBuqXIpP3hEORk
        ZmQfQ+ipa+xDtCfGiMqchnzwLpTDxofh1B+KcCw7J9G43eRVxS7dyH8Ew==
X-ME-Sender: <xms:nC7nYlBO8La7XorR0d1gxOS-hooMcOMQZsUxrElU9QQbLFH9v4jraw>
    <xme:nC7nYjhUY6QDP76LCaeiOn1amfYhwZQlvyVRnerzil2jq8XvljjLPr2fQE1OpNnnK
    e7kRir4jrT2aNLSUQ>
X-ME-Received: <xmr:nC7nYgmE9WY_wJw23cDVMAkamF_dCGml7Ylvo603laEyLjRMhoRAuAMj9WqxgfKF2nFYSIXxQyQCUefzIjTA2Et9iMDKyCtwqpOFE6ZSSoQFndFk6fmt54nocdi0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepleejgfdvfefhudektddtveegtdekieegffdtkeeljeetudevffeltdei
    feeugeeinecuffhomhgrihhnpehsohhurhgtvgifrghrvgdrohhrghdpkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    rghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:nC7nYvy5WDb6OlAoIXb8FdaRiCgXzOv9v_S2oT1SQE9PiclKG7iatQ>
    <xmx:nC7nYqRccxNffOlpDuwYEEzmwwo6FRPvTsGyBrpy7dqCLsFo12waag>
    <xmx:nC7nYiZmcA3l8KUdFR2wN_tcJxUTMS0o6070FCAC6PUfx2LnLDjvOg>
    <xmx:nC7nYpHnTXu3wd3Np36Ub1zwmXjohu0hhbdaBF_n0o4JIYRRcRRmrw>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 21:38:36 -0400 (EDT)
From:   Andres Freund <andres@anarazel.de>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Ben Hutchings <benh@debian.org>
Subject: [PATCH v3 0/8] tools: fix compilation failure caused by init_disassemble_info API changes
Date:   Sun, 31 Jul 2022 18:38:26 -0700
Message-Id: <20220801013834.156015-1-andres@anarazel.de>
X-Mailer: git-send-email 2.37.0.3.g30cc8d0f14
In-Reply-To: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

V3:
- don't include dis-asm-compat.h when building without libbfd
  (Ben Hutchings)
- don't include compiler.h in dis-asm-compat.h, use (void) casts instead,
  to avoid compiler.h include due to potential licensing conflict
- dual-license dis-asm-compat.h, for better compatibility with the rest of
  bpftool's code (suggested by Quentin Monnet)
- don't display feature-disassembler-init-styled test
  (suggested by Jiri Olsa)
- don't display feature-disassembler-four-args test, I split this for the
  different subsystems, but maybe that's overkill? (suggested by Jiri Olsa)

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>
CC: Ben Hutchings <benh@debian.org>
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
Link: https://lore.kernel.org/lkml/CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com

Andres Freund (8):
  tools build: Add feature test for init_disassemble_info API changes
  tools build: Don't display disassembler-four-args feature test
  tools include: add dis-asm-compat.h to handle version differences
  tools perf: Fix compilation error with new binutils
  tools bpf_jit_disasm: Fix compilation error with new binutils
  tools bpf_jit_disasm: Don't display disassembler-four-args feature
    test
  tools bpftool: Fix compilation error with new binutils
  tools bpftool: Don't display disassembler-four-args feature test

 tools/bpf/Makefile                            |  7 ++-
 tools/bpf/bpf_jit_disasm.c                    |  5 +-
 tools/bpf/bpftool/Makefile                    |  8 ++-
 tools/bpf/bpftool/jit_disasm.c                | 42 +++++++++++---
 tools/build/Makefile.feature                  |  4 +-
 tools/build/feature/Makefile                  |  4 ++
 tools/build/feature/test-all.c                |  4 ++
 .../feature/test-disassembler-init-styled.c   | 13 +++++
 tools/include/tools/dis-asm-compat.h          | 55 +++++++++++++++++++
 tools/perf/Makefile.config                    |  8 +++
 tools/perf/util/annotate.c                    |  7 ++-
 11 files changed, 138 insertions(+), 19 deletions(-)
 create mode 100644 tools/build/feature/test-disassembler-init-styled.c
 create mode 100644 tools/include/tools/dis-asm-compat.h

-- 
2.37.0.3.g30cc8d0f14

