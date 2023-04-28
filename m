Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE22A6F1056
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 04:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjD1Cau (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 22:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjD1Cau (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 22:30:50 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAFD268D
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 19:30:49 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-763da065494so129423239f.0
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 19:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1682649049; x=1685241049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYwNvXZaxB4vZWX2EvdHZffQN1IDGrc+NuKcwr6Ont4=;
        b=HtmLDba9+vr1FqLwEilkMCqRPBgGIgUIUXbS9h95yb3bRb2LFfjq4m18oX/fVBCukH
         kWWy/Mc41/Q9sDU9TN4z/idyZeKfdPu7wBGr/zrIJCb0z6VMXnuDLIZz5TcmudOLhKA4
         QPWCcohBUPmGEcXLhixns8Fta/PlVO3oKEKGJGwHyEQashl8BoxfrYBUwfGTB+dNAKR/
         4pMr81FYCn7+udWwJmsvq2f75lPBKc/ENcRJqxuANpi4DvqRQNHXfar3Yh482uYQfKjD
         FGeiaICuJeprSSq6gZpsz2kOGyF5kThn5LG1hJduRf+QyBsgnyGOWNmYgGmrwVFlqeOJ
         gsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682649049; x=1685241049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYwNvXZaxB4vZWX2EvdHZffQN1IDGrc+NuKcwr6Ont4=;
        b=cDEDKzUX9qNPMvgsTqXGgbsV2cIQagcOdauZ3gRpMAZPLrTrBG+rLbrPgTRr9R9PbG
         /Y0cFpdVoJeeLoV2H/BN0Fx5d1QyXuLALc/I4EAwmuYE9oKZ8OFKDmgRhzUHKK0PUOVU
         kgcRkDutrsJ/GhiUgdLWNb3CPLRtVb70mBkmwOtoPVWb3h5L9SomPfJDq0XlS9KS2nxL
         ihGs+Ra5Tk6FC0p7WhfF5gBJba3wTL8U5sG3W7+slYTagow8kl6gkrdN0lV5WDm5mxwt
         n5hTN1ntvqBcsSKzXxm0YDt8bTjKlXr9BHfEvS0paZCPPGCPOnU/ruflqM40GBYHWsK0
         vAZQ==
X-Gm-Message-State: AC+VfDx3yTmq+K/5Twxl+1saSoKMSFmaBS8ygUlOQJ/1FO0ZzXUtaDdT
        rMS1wNg0S2Ca729TedsBcKWNnzYihbZobIW0wZo=
X-Google-Smtp-Source: ACHHUZ5hnJMCJKa365YZR9QJDnOvnt4JvoZnVmuIa23bjIvNiv2HuSDLkq6waRBstu5j64jMmFRbaA==
X-Received: by 2002:a6b:d906:0:b0:763:5f51:aff7 with SMTP id r6-20020a6bd906000000b007635f51aff7mr2451397ioc.5.1682649048794;
        Thu, 27 Apr 2023 19:30:48 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
        by smtp.gmail.com with ESMTPSA id x20-20020a6bda14000000b007635e44126bsm5486259iob.53.2023.04.27.19.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 19:30:48 -0700 (PDT)
From:   Will Hawkins <hawkinsw@obs.cr>
To:     bpf@vger.kernel.org
Cc:     Will Hawkins <whh8b@obs.cr>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH 1/1] bpf, docs: Update llvm_relocs.rst with typo fixes
Date:   Thu, 27 Apr 2023 22:30:15 -0400
Message-Id: <20230428023015.1698072-2-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428023015.1698072-1-hawkinsw@obs.cr>
References: <20230428023015.1698072-1-hawkinsw@obs.cr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Will Hawkins <whh8b@obs.cr>

Correct a few typographical errors and fix some mistakes in examples.

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---
 Documentation/bpf/llvm_reloc.rst | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_reloc.rst
index ca8957d5b671..e4a777a6a3a2 100644
--- a/Documentation/bpf/llvm_reloc.rst
+++ b/Documentation/bpf/llvm_reloc.rst
@@ -48,7 +48,7 @@ the code with ``llvm-objdump -dr test.o``::
       14:       0f 10 00 00 00 00 00 00 r0 += r1
       15:       95 00 00 00 00 00 00 00 exit
 
-There are four relations in the above for four ``LD_imm64`` instructions.
+There are four relocations in the above for four ``LD_imm64`` instructions.
 The following ``llvm-readelf -r test.o`` shows the binary values of the four
 relocations::
 
@@ -79,14 +79,16 @@ The following is the symbol table with ``llvm-readelf -s test.o``::
 The 6th entry is global variable ``g1`` with value 0.
 
 Similarly, the second relocation is at ``.text`` offset ``0x18``, instruction 3,
-for global variable ``g2`` which has a symbol value 4, the offset
-from the start of ``.data`` section.
-
-The third and fourth relocations refers to static variables ``l1``
-and ``l2``. From ``.rel.text`` section above, it is not clear
-which symbols they really refers to as they both refers to
+has a type of ``R_BPF_64_64`` and refers to entry 7 in the symbol table.
+The second relocation resolves to global variable ``g2`` which has a symbol
+value 4. The symbol value represents the offset from the start of ``.data``
+section where the initial value of the global variable ``g2`` is stored.
+
+The third and fourth relocations refer to static variables ``l1``
+and ``l2``. From the ``.rel.text`` section above, it is not clear
+to which symbols they really refer as they both refer to
 symbol table entry 4, symbol ``sec``, which has ``STT_SECTION`` type
-and represents a section. So for static variable or function,
+and represents a section. So for a static variable or function,
 the section offset is written to the original insn
 buffer, which is called ``A`` (addend). Looking at
 above insn ``7`` and ``11``, they have section offset ``8`` and ``12``.
-- 
2.39.2

