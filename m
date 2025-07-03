Return-Path: <bpf+bounces-62340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A890AF821C
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 22:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D960F1C86E5C
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 20:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FE22BEC24;
	Thu,  3 Jul 2025 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv0QYnTA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE729B8E5
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751575723; cv=none; b=ZUwXK4rvAI8l/Nw7CapOdfntA+7J37/YA/65jYUk1YOA4JvP3P5muVn1MOR9ya1GLOml/q5Cwj36KjWqsuW91mAYlWb35J8tOdAGp6cmqkD7LAXs3SYCSdw7yJ2QkkVQRzcVVIlh7GC+ujKKNPh1NxwsmGqiLapnccoDrUo1AFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751575723; c=relaxed/simple;
	bh=+SywL4i1FXK6144IiY8WPrwQfHcovBgpqtZkb3Rg0TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcX1ZJxbRLv4vJK0roOfvdOx1eXXRdnuJOuG5SD3rLnk6Lh2aV2zEwgWMfxHoamQ9x8KL8tYcgMzrjCZU2YRZrUwVGHAL9kwZs1qfitfUr/rrQHWw/i3/pC1v0YpvAIe731/eqTOAWjeJ0LKwIHAB8WgEemIA1wazWxenXZ6M4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rv0QYnTA; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-acb5ec407b1so47335266b.1
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 13:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751575719; x=1752180519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfHKfiURsJ/MjgoWT7GCTInYVnEwlxZrub602vzqVTQ=;
        b=Rv0QYnTArfcLd/Izirps+L7Fugo04FbZBbvydGNQdWKtfTkT8lpzwwLyQAPbHEdmct
         0elP+wZz7lq1F4IXImKqXOlN9rujSBqki97/5Ac8LXp1+CFLqOqmIopcSAkO8MhWEuYh
         4McJzUN5i0YAErf11lZt9THjZd/yr964JQofrkbTCjpnbPFKE9khUILZHCB3S1lKc+bg
         kIc/HSiGKsH/E3w3MKDJYbaxG0uF0TUmywHZKchh6DAZ3ertelGDRks4VVRQ6MI/uZGC
         L6rzGI8HjUmoQS3CsNyzPfZHQQnRcErq52KDCgEeGec5n+mMMllhB0mcyH6bas1fWNSh
         Hk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751575719; x=1752180519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfHKfiURsJ/MjgoWT7GCTInYVnEwlxZrub602vzqVTQ=;
        b=fMBrRYUtejbRfJEADRAILEnRcSrW78gfXB+/polz2CbZbbtwsfah326A7zYu5wtBa9
         PYshyW+QhaMHEnixJpxYHEYdUdt0Eh4Ku6fNsFCAnt4nWa6jkWDF8WK7tHTHspq1A+/a
         0gde09KPCn7VauJP4HjCCzSa24CG/n7P595u+At+rp/Rjxz5HsBJxYWP2Hes+6M2OzDp
         njp8KahGW5tG4sI6smIz2UNVeLOk+I878VvaXxx0uCiNSvttKDcIVBVOL+sdn94I6rfl
         zy+/h/NWYCBIPc7l4Ed6lYuEwhoeO2+/NdRe0ycRxPc4Kzcia+RVoMswic/FDHpaNCxX
         oIRA==
X-Gm-Message-State: AOJu0YyAkThjoneyZ7G/IQCeLIxYS47i4RwJ9Z03lLo5bwmyd0yXtkIo
	ilFdvilMijWV3V/4ubITBX0l5JPpucmo3ldF6f07HI8Ct9BJcCoSDPopa40qTqJxQpY=
X-Gm-Gg: ASbGncuk006WvFW1S/Rv4d2j0d/YIujobmqrSV/qPlVEurtpCXVvwJcO7hemD7xDou9
	HqA6AwWj8qkPc8PBeDUI1k8dpoVqJjNicV0b1QoZr5CP6csAqtI4If9r3BkZ1XZDKWB8xdQKM0J
	u6REfmy20HgmwO59fsTtyA481yklLyGZSOgSo5a1IjiSQ2/x4UlowWcb5caV4XN7Kxo5PuSkPKn
	hkRRCN9Y7h5eK7LS/93va/a4+LrOQ16u4eWns3MOq6RohcOCmwU3F8uAOXxCmmxldZWADikb/7u
	VG11F8XJM8M4NMd/gsoOmtg+x82RAFV5JcLu742W9QnSueI6HME=
X-Google-Smtp-Source: AGHT+IHtVzBzfQNXmzn6XJVcfjAs3rZZyW6RQIxz0ISRCS9QhVJs0+d2+JdEmmNYtGFIXa1pPyi9oQ==
X-Received: by 2002:a17:907:7ba2:b0:ae3:5e70:332b with SMTP id a640c23a62f3a-ae3d8b7ab29mr501730566b.52.1751575719096;
        Thu, 03 Jul 2025 13:48:39 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d93basm38554266b.4.2025.07.03.13.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 13:48:38 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 11/12] bpftool: Add support for dumping streams
Date: Thu,  3 Jul 2025 13:48:17 -0700
Message-ID: <20250703204818.925464-12-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703204818.925464-1-memxor@gmail.com>
References: <20250703204818.925464-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5472; h=from:subject; bh=+SywL4i1FXK6144IiY8WPrwQfHcovBgpqtZkb3Rg0TY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZudM1cBJO8iiDYlcv2/cMIteqVRvetSjW3k3VYbU mw7DzvaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGbnTAAKCRBM4MiGSL8RyikcD/ 9cEwwLgFlUTtu2PyrT0hUGc7GlY+/yq20hiR/C3rcpT+Swg/l1jfH6n1tS3BH+alxEUKaPDgF8RrZf dtPXnvTHZ5cIR3aARvAU9eS2hk5lob4rug+Q0uf8livC0NJ3VOxjiqcSXuFpEnu9xErvDPTGRbJfJh pboqsLS9YRoKNEtl1i9HsOdxxLYJmWBSZEOS2dDpAYnih2EeA54SZHkl8/KKSNf7mMMo1UaQZjaU0H dRBG6bwMLjg9Utzey/dOAqftsPeoS+jadOgu562KB2JKntgReure9fys3q5puGkXSHnL641xvQlm0t gAOLmxWJ9AJuWO0MVwDmJyOxDrZv8VUoUW2oJ2l3cHoY0XEqoBJzYF8srcwQ8paEl5paelinQhgVo1 sxaM7Z29iuvLjuSH9Hl0KRRHecJnbdr46x7jtPzBBn71PTC7xFfci79i9vGF0muEahiXc5Q1O2mY3c yzi1CD8xP0jfQJwmFwesEZz7t2FAiGO2qMai8fYq7aBA22jn4Rnat8f2IaEUF6v9H1dshXlF1SD4UO /WN6R0J7APBWdRSG5AkfPzQ1TJ92a7LUbiO76GClazA0BDuucGqAyXW7w7xLXWIb7ah00sFKekpTxs 1K8zNSF+pr35NZkfb+jUX1Zfa18eBIl8ZQzm9Iv6Ftqstbn5rYD7VMacWMyw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add support for printing the BPF stream contents of a program in
bpftool. The new bpftool prog tracelog command is extended to take
stdout and stderr arguments, and then the prog specification.

The bpf_prog_stream_read() API added in previous patch is simply reused
to grab data and then it is dumped to the respective file. The stdout
data is sent to stdout, and stderr is printed to stderr.

Cc: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpftool/Documentation/bpftool-prog.rst    |  7 +++
 tools/bpf/bpftool/bash-completion/bpftool     | 16 +++++-
 tools/bpf/bpftool/prog.c                      | 49 ++++++++++++++++++-
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index da3152c16228..f69fd92df8d8 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -35,6 +35,7 @@ PROG COMMANDS
 | **bpftool** **prog attach** *PROG* *ATTACH_TYPE* [*MAP*]
 | **bpftool** **prog detach** *PROG* *ATTACH_TYPE* [*MAP*]
 | **bpftool** **prog tracelog**
+| **bpftool** **prog tracelog** [ { **stdout** | **stderr**  } *PROG* ]
 | **bpftool** **prog run** *PROG* **data_in** *FILE* [**data_out** *FILE* [**data_size_out** *L*]] [**ctx_in** *FILE* [**ctx_out** *FILE* [**ctx_size_out** *M*]]] [**repeat** *N*]
 | **bpftool** **prog profile** *PROG* [**duration** *DURATION*] *METRICs*
 | **bpftool** **prog help**
@@ -179,6 +180,12 @@ bpftool prog tracelog
     purposes. For streaming data from BPF programs to user space, one can use
     perf events (see also **bpftool-map**\ (8)).
 
+bpftool prog tracelog { stdout | stderr } *PROG*
+    Dump the BPF stream of the program. BPF programs can write to these streams
+    at runtime with the **bpf_stream_vprintk**\ () kfunc. The kernel may write
+    error messages to the standard error stream. This facility should be used
+    only for debugging purposes.
+
 bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ctx_in *FILE* [ctx_out *FILE* [ctx_size_out *M*]]] [repeat *N*]
     Run BPF program *PROG* in the kernel testing infrastructure for BPF,
     meaning that the program works on the data and context provided by the
diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index 27512feb5c70..a759ba24471d 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -518,7 +518,21 @@ _bpftool()
                     esac
                     ;;
                 tracelog)
-                    return 0
+                    case $prev in
+                        $command)
+                            COMPREPLY+=( $( compgen -W "stdout stderr" -- \
+                                "$cur" ) )
+                            return 0
+                            ;;
+                        stdout|stderr)
+                            COMPREPLY=( $( compgen -W "$PROG_TYPE" -- \
+                                "$cur" ) )
+                            return 0
+                            ;;
+                        *)
+                            return 0
+                            ;;
+                    esac
                     ;;
                 profile)
                     case $cword in
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index deeaa5c1ed7d..9722d841abc0 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1113,6 +1113,52 @@ static int do_detach(int argc, char **argv)
 	return 0;
 }
 
+enum prog_tracelog_mode {
+	TRACE_STDOUT,
+	TRACE_STDERR,
+};
+
+static int
+prog_tracelog_stream(int prog_fd, enum prog_tracelog_mode mode)
+{
+	FILE *file = mode == TRACE_STDOUT ? stdout : stderr;
+	int stream_id = mode == TRACE_STDOUT ? 1 : 2;
+	char buf[512];
+	int ret;
+
+	ret = 0;
+	do {
+		ret = bpf_prog_stream_read(prog_fd, stream_id, buf, sizeof(buf), NULL);
+		if (ret > 0)
+			fwrite(buf, sizeof(buf[0]), ret, file);
+	} while (ret > 0);
+
+	fflush(file);
+	return ret ? -1 : 0;
+}
+
+static int do_tracelog_any(int argc, char **argv)
+{
+	enum prog_tracelog_mode mode;
+	int fd;
+
+	if (argc == 0)
+		return do_tracelog(argc, argv);
+	if (!is_prefix(*argv, "stdout") && !is_prefix(*argv, "stderr"))
+		usage();
+	mode = is_prefix(*argv, "stdout") ? TRACE_STDOUT : TRACE_STDERR;
+	NEXT_ARG();
+
+	if (!REQ_ARGS(2))
+		return -1;
+
+	fd = prog_parse_fd(&argc, &argv);
+	if (fd < 0)
+		return -1;
+
+	return prog_tracelog_stream(fd, mode);
+}
+
 static int check_single_stdin(char *file_data_in, char *file_ctx_in)
 {
 	if (file_data_in && file_ctx_in &&
@@ -2493,6 +2539,7 @@ static int do_help(int argc, char **argv)
 		"                         [repeat N]\n"
 		"       %1$s %2$s profile PROG [duration DURATION] METRICs\n"
 		"       %1$s %2$s tracelog\n"
+		"       %1$s %2$s tracelog { stdout | stderr } PROG\n"
 		"       %1$s %2$s help\n"
 		"\n"
 		"       " HELP_SPEC_MAP "\n"
@@ -2532,7 +2579,7 @@ static const struct cmd cmds[] = {
 	{ "loadall",	do_loadall },
 	{ "attach",	do_attach },
 	{ "detach",	do_detach },
-	{ "tracelog",	do_tracelog },
+	{ "tracelog",	do_tracelog_any },
 	{ "run",	do_run },
 	{ "profile",	do_profile },
 	{ 0 }
-- 
2.47.1


