Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44D83F3C2C
	for <lists+bpf@lfdr.de>; Sat, 21 Aug 2021 20:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhHUStR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 21 Aug 2021 14:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhHUStQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 21 Aug 2021 14:49:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE67C061575;
        Sat, 21 Aug 2021 11:48:36 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r2so12530189pgl.10;
        Sat, 21 Aug 2021 11:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQ8X68+agmo/9YIuGhT9zb0QxYHN2zLKWc/jICvz7q0=;
        b=lE0IRB8OG2q5j/tYcPIEDzgS3giaqAJfQKgv3P2bSqhtqmtMtd8ZQItdWp3WnvroQg
         rcgPpHBq+IA+V+T4Viq0yuHd759GJPMFDgb4cxMyJA/2cPjTVLWZqiVWxHfuy0/S4PoG
         8a5BxScww1mucJ5mC5wYNSFAYFpn2RaLNioHe5MVO20y6DhSN41Ibc2Ztjgk9RcKHiFG
         vMc8hATZzT0MandcXWf7D0Lo4CtesJwtXdy/8jVpPA2RmOZ2y9ZXzkqQgeDSE9cegob1
         1CT1/hp/g1053Y5KEAAPmKKZbnUblDE0tRHg/ixA3sOynglvufYSNi06wqioBOT/hGCN
         wC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQ8X68+agmo/9YIuGhT9zb0QxYHN2zLKWc/jICvz7q0=;
        b=SoG+Ofja5J6jm9Fxp3aBsgQnYJXgEQX8PKFouBq/WOM56fG9JDHlvl8qBgUEhejQ9j
         hCI2Ec2Hq7DiJ+zujrdIk3XsDaPseveufLM8Ulw3PTWbLXmoQ3uGijf/sMAMywSxm/Jy
         BmimNwuRhOMzkx5aMT0sTTmmeoyDr27wquYYmBJqNlQPi97NC/IH6Tr6taJMqep471F0
         F28lhY2h5UOsyLCHv4LoUuLdq+y2IUOccFBVp68TqPfYf0MiQ0GaAZwHRHMSQbjw6nPc
         eQZuRPKSIbawhoc57hx6smqgeHBnzUPjOGjHkeg+TWNH28F5c9magfSPqV2tgTBc52gQ
         sdIA==
X-Gm-Message-State: AOAM5329bsvksNPcG9zBlr4KYJqkv3992Gc91Zy6pfNAEaGgACMx+wCx
        bDzf9BpuVZmqYOqGcC+DcX9zUjpPbig=
X-Google-Smtp-Source: ABdhPJyD7hQIC2+w9JKiP3Uk6xHcsU+fZOTkz8/NmcQHPP2gYr09/AUYSsDl/EoaBmZLbCkmvN0qLg==
X-Received: by 2002:a63:6c5:: with SMTP id 188mr24870073pgg.39.1629571716387;
        Sat, 21 Aug 2021 11:48:36 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id pc11sm14729093pjb.17.2021.08.21.11.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 11:48:36 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Spencer Baugh <sbaugh@catern.com>,
        Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next RFC v1 3/5] libbpf: Add bpf_probe_map_type support for file local storage
Date:   Sun, 22 Aug 2021 00:18:22 +0530
Message-Id: <20210821184824.2052643-4-memxor@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210821184824.2052643-1-memxor@gmail.com>
References: <20210821184824.2052643-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/libbpf_probes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index cd8c703dde71..a97f2088c53a 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -233,6 +233,7 @@ bool bpf_probe_map_type(enum bpf_map_type map_type, __u32 ifindex)
 	case BPF_MAP_TYPE_SK_STORAGE:
 	case BPF_MAP_TYPE_INODE_STORAGE:
 	case BPF_MAP_TYPE_TASK_STORAGE:
+	case BPF_MAP_TYPE_FILE_STORAGE:
 		btf_key_type_id = 1;
 		btf_value_type_id = 3;
 		value_size = 8;
-- 
2.33.0

