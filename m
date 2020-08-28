Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A0B256169
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 21:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgH1Tgq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 15:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgH1TgW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 15:36:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CCEC06123C
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 12:36:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q2so317287ybo.5
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 12:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wFIQg1RLV5oCKKfUM4Keh3rHvIex1g1mSYArquZC83w=;
        b=ky1Bkbe0DhKCHp0pTlI8am4oHipltvwyG42zSw8zxW93DvheB8QAKXsSWiA/RqljvZ
         jnp3zLeMpV3W+Tlz67LS0bG6OexGLtN7UOHxOjnc8AYkP+E6LVf3MPjGr6X6wWlXHLdi
         xnZCX3RDJD9v/1U8r7bQJH9oKxHbWxwH+r4y0J+wqL9+2DZtFL64PAR7Uklmruk4GMRL
         7CKL+G7BJkRtUzYWHLA9kc3J4fube9b39D6XBaZqmd9cfmPSL6ErXtwQfiRUY8333PHx
         epKtNugYd2XCVNTs6dmm6osPn8ZqtMzPne0qzVNq+fyVRcLtsAppW0tn+CsppPlLg28J
         1WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wFIQg1RLV5oCKKfUM4Keh3rHvIex1g1mSYArquZC83w=;
        b=a5R42ZqEucXIG+d6wJg2NSZsYO/7EHJPLddqecWhCRx6eaE3FcL49Diu9bDUN1a5ji
         EkaKdAfDfp3aKdAiEkXBxzWq5vVq+UhHUEeJF+2RdyswCH71ZfeY71g45sudbWDLcJFc
         UwsHptTfRopfT0aOWy40y7S4z33TEAcjgX8E5l13K+BtNTvd3RMxIzoiWB6f07RIznIM
         35RNuSZfixoAWSigoDufbTzl2Vk3i/VNtAG4AnfariZhvg4lJlYdL0GNg+AAXcJJeGCX
         jwO+S1lLmufTbVQTAiySj8IkdqqGR5lhiI84hMhg0RhRl0MJ7EXDM4qNlYq7Q71EaiJG
         GwAQ==
X-Gm-Message-State: AOAM5334gPYTw9CgIGh+AA+Lka5YBbWuNnvrVRSR9rT7IIh+dkhJYBQE
        93I48L8lMktyIZ/wQJLWz9XTYUE=
X-Google-Smtp-Source: ABdhPJwdFa9WDxD7u2/lAhl/5NLYzzS8JoU5EMQubhZrXDvseRIaWYh716GpHkXLDHuzPZV3ir2U80c=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a25:c6cd:: with SMTP id k196mr4600338ybf.318.1598643378783;
 Fri, 28 Aug 2020 12:36:18 -0700 (PDT)
Date:   Fri, 28 Aug 2020 12:36:02 -0700
In-Reply-To: <20200828193603.335512-1-sdf@google.com>
Message-Id: <20200828193603.335512-8-sdf@google.com>
Mime-Version: 1.0
References: <20200828193603.335512-1-sdf@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH bpf-next v3 7/8] bpftool: mention --metadata in the documentation
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Mention --metadata in the rst documentation and in the prog.c
help.

Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 5 ++++-
 tools/bpf/bpftool/prog.c                         | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 82e356b664e8..84dc47e18016 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -12,7 +12,7 @@ SYNOPSIS
 
 	**bpftool** [*OPTIONS*] **prog** *COMMAND*
 
-	*OPTIONS* := { { **-j** | **--json** } [{ **-p** | **--pretty** }] | { **-f** | **--bpffs** } }
+	*OPTIONS* := { { **-j** | **--json** } [{ **-p** | **--pretty** }] | { **-f** | **--bpffs** } | {**--metadata**} }
 
 	*COMMANDS* :=
 	{ **show** | **list** | **dump xlated** | **dump jited** | **pin** | **load**
@@ -80,6 +80,9 @@ DESCRIPTION
 		  programs. On such kernels bpftool will automatically emit this
 		  information as well.
 
+		  You can specify **--metadata** option to pretty-print
+		  read-only data from the associated *.metadata* section.
+
 	**bpftool prog dump xlated** *PROG* [{ **file** *FILE* | **opcodes** | **visual** | **linum** }]
 		  Dump eBPF instructions of the programs from the kernel. By
 		  default, eBPF will be disassembled and printed to standard
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 5d626c134e7d..4c129d6d2a0c 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2005,7 +2005,7 @@ static int do_help(int argc, char **argv)
 	}
 
 	fprintf(stderr,
-		"Usage: %1$s %2$s { show | list } [PROG]\n"
+		"Usage: %1$s %2$s { show | list } [PROG] [--metadata]\n"
 		"       %1$s %2$s dump xlated PROG [{ file FILE | opcodes | visual | linum }]\n"
 		"       %1$s %2$s dump jited  PROG [{ file FILE | opcodes | linum }]\n"
 		"       %1$s %2$s pin   PROG FILE\n"
-- 
2.28.0.402.g5ffc5be6b7-goog

