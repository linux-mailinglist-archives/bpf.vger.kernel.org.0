Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31914D78B7
	for <lists+bpf@lfdr.de>; Mon, 14 Mar 2022 00:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbiCMXVG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Mar 2022 19:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiCMXVF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Mar 2022 19:21:05 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C51E60CE8;
        Sun, 13 Mar 2022 16:19:57 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 812F45C01B2;
        Sun, 13 Mar 2022 19:19:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 13 Mar 2022 19:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; bh=GQnfiVadh5tJPgz9kVDqRB8PL7TA82b3EqJMgiDYnGE=; b=ThRpt
        SBvrrPwL0MLX7cBs4jTHqpm9gUsSWzMFzlLO/b185o9oidsZISSF/YOX4jcEWYOz
        THfrjtFESdfaxzbQCBvpg0wNgrPSUs9zdzGrixXm1rc6kcepurbbJvrNgAlqGj75
        SyA9u7ewsHz621RCnT/hBv0hty9J14UTtnP+kJV8moi9s/8kPMPzP31PM0cNo8/7
        JQ64zTkIP56gzyIanuaKQGsktGrPHyqmiNhN0RObcuhIxxwdbeejL+Foe2wwsvDz
        AfUTdqdvtCiaadQAsw5yiVcXdqM3tOfp0HL/ByPbUmzbkR94jTRsRDWG9VaBowZ6
        Z9nFcoB7U69ulYxkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=GQnfiVadh5tJPgz9kVDqRB8PL7TA8
        2b3EqJMgiDYnGE=; b=gtaWEwGkbvdS7/i5ygDPlkZom8rLcFKhR4cphLXDI7rO2
        1dHebc0Xd63/l5hhd1Hx8aMwev+el1kVbKIxbam8ml11kVDDBdVJXGOEaCEOsJyw
        IquxVcG/xYc3RnoYrTs7zU3XziuAcnXBrmtyZasTHQYVs47aiVk1gubiGsW+ZFOQ
        HwnofgFA2dB+cH5M50Bkzmugsi6AX+Wc3A2PlMKVwagVvddXLG5s6IYF2uvmfaYY
        iTmoLzL70QTtylScPyEuXW4x5Q8MVNUUDr+hWhdyq0XT+FG/19hKSq0AnkxEGH1i
        z8TdjR/swlkqZmBUPv253bKD3rmwsmyo43m59162A==
X-ME-Sender: <xms:HHwuYs-K0OF8ByeVUAdqDTUrMwtnwgKwo9U1refrteRHUlt45vHROw>
    <xme:HHwuYkswS0NxUW_2fOzME5ZJzsW-8rC2Cjpravv8HeIvNRHH47av03HFQf2w1DFag
    scTnCggclz3xadyfg>
X-ME-Received: <xmr:HHwuYiBK67q180leylEYILm7dV15PK6GkNp5WWetfFPXD-LesauEoBqk4r1Jnv4MY4KoolQKVcui9Ev2KcORmq3q7ZVk2Ap08XjfgxtQA3jLnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvjedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeifffgledvffeitdeljedvte
    effeeivdefheeiveevjeduieeigfetieevieffffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:HHwuYse7KlVCWwVtT3p0C39ub2vKu3y3sAr_LCYegY2sNACdHk9yAg>
    <xmx:HHwuYhOCnpEWJ_U6ajTILLbBzwmVE3rouMwhmTCqxhta8GaTbo6WiQ>
    <xmx:HHwuYmkQxU0LmfhevW5pDtNDSFUX_olI0uVA5BPpFMjNsPzZFMRKPg>
    <xmx:HHwuYmqfRQKh-lwEP4kGUc4wIt1xjnkke7siwKs_Av0VCDmB8OK49A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Mar 2022 19:19:55 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpftool: man: Add missing top level docs
Date:   Sun, 13 Mar 2022 16:19:46 -0700
Message-Id: <3049ef5dc509c0d1832f0a8b2dba2ccaad0af688.1647213551.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The top-level (bpftool.8) man page was missing docs for a few
subcommands and their respective sub-sub-commands.

This commit brings the top level man page up to date. Note that I've
kept the ordering of the subcommands the same as in `bpftool help`.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/bpf/bpftool/Documentation/bpftool.rst | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool.rst b/tools/bpf/bpftool/Documentation/bpftool.rst
index 7084dd9fa2f8..6965c94dfdaf 100644
--- a/tools/bpf/bpftool/Documentation/bpftool.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool.rst
@@ -20,7 +20,8 @@ SYNOPSIS
 
 	**bpftool** **version**
 
-	*OBJECT* := { **map** | **program** | **cgroup** | **perf** | **net** | **feature** }
+	*OBJECT* := { **map** | **program** | **link** | **cgroup** | **perf** | **net** | **feature** |
+	**btf** | **gen** | **struct_ops** | **iter** }
 
 	*OPTIONS* := { { **-V** | **--version** } | |COMMON_OPTIONS| }
 
@@ -31,6 +32,8 @@ SYNOPSIS
 	*PROG-COMMANDS* := { **show** | **list** | **dump jited** | **dump xlated** | **pin** |
 	**load** | **attach** | **detach** | **help** }
 
+	*LINK-COMMANDS* := { **show** | **list** | **pin** | **detach** | **help** }
+
 	*CGROUP-COMMANDS* := { **show** | **list** | **attach** | **detach** | **help** }
 
 	*PERF-COMMANDS* := { **show** | **list** | **help** }
@@ -39,6 +42,14 @@ SYNOPSIS
 
 	*FEATURE-COMMANDS* := { **probe** | **help** }
 
+	*BTF-COMMANDS* := { **show** | **list** | **dump** | **help** }
+
+	*GEN-COMMANDS* := { **object** | **skeleton** | **min_core_btf** | **help** }
+
+	*STRUCT-OPS-COMMANDS* := { **show** | **list** | **dump** | **register** | **unregister** | **help** }
+
+	*ITER-COMMANDS* := { **pin** | **help** }
+
 DESCRIPTION
 ===========
 	*bpftool* allows for inspection and simple modification of BPF objects
-- 
2.35.1

