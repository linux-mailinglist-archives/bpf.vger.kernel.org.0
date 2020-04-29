Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B591BE173
	for <lists+bpf@lfdr.de>; Wed, 29 Apr 2020 16:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgD2OpS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Apr 2020 10:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726739AbgD2OpO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Apr 2020 10:45:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE03C035494
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 07:45:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 188so2327746wmc.2
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 07:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRCfBdadPVTEiQclG9/KJeo/s7dbbAmCdTeG8F+tkxA=;
        b=wUbi7mkpnNEN5zj8+u1ht0k7eGCD4TBzIziguxbHRtKxdpq702xSX1p0yi+H7Pmy79
         q/QyCXAMqlHh4OFoXREH9QVKGlfkidf+KNl7b7jbaYtb1Bd8nOggBQMOEsv3lREyI6MW
         S+7FutxSUe65+1EuBYmtb3vz9fb9y7lhiCkrT/nwY5jvx5v1qB9dfDTgsDx5FFdRhDyv
         HnxWsvajaIw9XWTics3PDB5GNkOnrIuwyfHNQcWrFYwW9eSZmR1z1ggpiD1xCEj6w/SC
         fPJKmK0cqSXBLtBrSCLvsKgdN7OPIYMha/rtVR7BpOjShPQWAZs76TUSlzcTdivjTeOj
         Rs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRCfBdadPVTEiQclG9/KJeo/s7dbbAmCdTeG8F+tkxA=;
        b=G4pIsWtSwm7UieIVZbXe/thVikfe/gmrl88pFqnB8PvhMTF2IC8Ny93AsYU+N0YWmq
         tin/Oe2sK4gB81PBoBvShJ+pGLDOLcWE66qYMrLNaUnDVfEZZQYfo7SiV6Rq7dgn8Vam
         6+X5zL/5iYfUc4Q+lrFispRYf1re3L4HV17ssjFvDuLRO2b3KSvhUYTdjdjH1WMdH9Mj
         IxAl4Jg07N9bX7h7SLpug8p4s3OGQrR0qk2/s4Le199iR5jNVZpFwFboFakULWPLy6Q3
         jGXsBqx3rCEWqkh1cUMLIV7HwKoEEONAQcyxMzO6lB5j0uQ/ymARxYdnNzPsjwJEP6VQ
         +Dhg==
X-Gm-Message-State: AGi0PuZ2uwvsNrZ7TIyUy1s5VdvaL0lLu6wwXdMxHvqIzg42B1Ca6jlK
        xlJ/eCyFw/m7lhXdQfpGGeMXdg==
X-Google-Smtp-Source: APiQypLwdrvK53EjnxC1heRJ+0O+lYXa9rz26GtDEw4NdoFZtPrvL2dF2E9fefS7WeDR/I3BG2Pkfw==
X-Received: by 2002:a05:600c:441a:: with SMTP id u26mr3883647wmn.154.1588171511003;
        Wed, 29 Apr 2020 07:45:11 -0700 (PDT)
Received: from localhost.localdomain ([194.53.185.38])
        by smtp.gmail.com with ESMTPSA id a10sm20071739wrg.32.2020.04.29.07.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:45:10 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [PATCH bpf-next v3 1/3] tools: bpftool: for "feature probe" define "full_mode" bool as global
Date:   Wed, 29 Apr 2020 15:45:04 +0100
Message-Id: <20200429144506.8999-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200429144506.8999-1-quentin@isovalent.com>
References: <20200429144506.8999-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The "full_mode" variable used for switching between full or partial
feature probing (i.e. with or without probing helpers that will log
warnings in kernel logs) was piped from the main do_probe() function
down to probe_helpers_for_progtype(), where it is needed.

Define it as a global variable: the calls will be more readable, and if
other similar flags were to be used in the future, we could use global
variables as well instead of extending again the list of arguments with
new flags.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/feature.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index 88718ee6a438..59e4cb44efbc 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -35,6 +35,8 @@ static const char * const helper_name[] = {
 
 #undef BPF_HELPER_MAKE_ENTRY
 
+static bool full_mode;
+
 /* Miscellaneous utility functions */
 
 static bool check_procfs(void)
@@ -540,8 +542,7 @@ probe_helper_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
 
 static void
 probe_helpers_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
-			   const char *define_prefix, bool full_mode,
-			   __u32 ifindex)
+			   const char *define_prefix, __u32 ifindex)
 {
 	const char *ptype_name = prog_type_name[prog_type];
 	char feat_name[128];
@@ -678,8 +679,7 @@ static void section_map_types(const char *define_prefix, __u32 ifindex)
 }
 
 static void
-section_helpers(bool *supported_types, const char *define_prefix,
-		bool full_mode, __u32 ifindex)
+section_helpers(bool *supported_types, const char *define_prefix, __u32 ifindex)
 {
 	unsigned int i;
 
@@ -704,8 +704,8 @@ section_helpers(bool *supported_types, const char *define_prefix,
 		       define_prefix, define_prefix, define_prefix,
 		       define_prefix);
 	for (i = BPF_PROG_TYPE_UNSPEC + 1; i < ARRAY_SIZE(prog_type_name); i++)
-		probe_helpers_for_progtype(i, supported_types[i],
-					   define_prefix, full_mode, ifindex);
+		probe_helpers_for_progtype(i, supported_types[i], define_prefix,
+					   ifindex);
 
 	print_end_section();
 }
@@ -725,7 +725,6 @@ static int do_probe(int argc, char **argv)
 	enum probe_component target = COMPONENT_UNSPEC;
 	const char *define_prefix = NULL;
 	bool supported_types[128] = {};
-	bool full_mode = false;
 	__u32 ifindex = 0;
 	char *ifname;
 
@@ -803,7 +802,7 @@ static int do_probe(int argc, char **argv)
 		goto exit_close_json;
 	section_program_types(supported_types, define_prefix, ifindex);
 	section_map_types(define_prefix, ifindex);
-	section_helpers(supported_types, define_prefix, full_mode, ifindex);
+	section_helpers(supported_types, define_prefix, ifindex);
 	section_misc(define_prefix, ifindex);
 
 exit_close_json:
-- 
2.20.1

