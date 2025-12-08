Return-Path: <bpf+bounces-76242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CD4CABD00
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 03:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCF6A300A378
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 02:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E0F2E7BAD;
	Mon,  8 Dec 2025 02:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YArWFekk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890382F3635
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 02:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159806; cv=none; b=q6c+z3rW+avuOUN8sPpEJDbScdmBqU0wuHuVa0tA0vAQ9MVGyFDIME2sx/Wrcj/x2JTUpXzLH2I2m+ATEF3LY5vyu31TcBGkhm7X/Ad9K+HKmS3kp4QhzzTr1qix87k19IDtorj56pA/v7bZEMWHZJBaiitm3oVrX7j1mB/uROk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159806; c=relaxed/simple;
	bh=4Qk47ycA3/T/9b/M0FK+Lh6ai7Lmul/pHuiJXTisqV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCGnjy6oWpKYLcEiE5q9jfVmmJxcZ+tMh4/WN3zldjKYvd5okwUOfxZ+MyzFQALlNUPXCcQ48hfeWVtb16sYE6rARIKDtjrzhJXrgYgaPaFR1GdvIIlOovV3tD+wMPnE7yloWhbieJCPpTPKsas2nhBi+whV36JeGh1Yk2H6hws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YArWFekk; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b86e0d9615so6894676b3a.0
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 18:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765159803; x=1765764603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ei1AwhkE7Jmkpr0KkNKmHYIsW2V4ZdtGUvRw5dHl2s=;
        b=YArWFekk2kW2a0pKZCCrZnHzu4snvc6ybrMVlCyLUwU0K+Q/az8AlVluS8uHaSdWSw
         8hvVQNbNuyAe7RNrUfr2mmcWS/JY0MpR9YYIbCmrIjAIe4xevev5iN+X68Yac85qcG+f
         rLVu4VjiFyijc8cDnEaD1uV1uo58cz4Zz6VFPHRy5NBCALqH1spPDXvn0MosvBPkJ+kx
         utCjccqhDxUGetbQOf9Cn6pPpcPgxZSqu2WxgCAf3v6XU1xJNCcfwNdm8chzs1OfCJG9
         mCI9FhgpYf6ntjwyTfm3oqKMYMEXtDfCII4qHVowczFbIqQuaFAIeAi+9gNm/yFWIrMp
         NhhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159803; x=1765764603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ei1AwhkE7Jmkpr0KkNKmHYIsW2V4ZdtGUvRw5dHl2s=;
        b=LAkH7MC8HlJvPicJ6l21ZXMHuk/jX18ofD13H28U7zxVrGemveVurCvzxhZ8VmDiBO
         0H7b/3CL1Sv2iVE32ll1L/Oyq3g+6r9OM4jxHNbQ5cDmK8IOfhFwnphbUpkgkD9jm1Se
         LwztZ3k8IPf+9+Dd0b/funHVx3JKC2KXqdZX5ocNoNB76EoVZSBNxhbA+gZ2wavCQpdL
         oY5kK9bk9VqjpWKpqH6/9rhmmo1nfK6WPQf9/nCVCUFeR6octxKKXDlO1N6sAirNKeQH
         xMrVve1oq/mTvYSZltAj0uhiqhkWAdNfpcnWi95HBjvutk2XPY8hzpHpN0EC4pqg8DxV
         D7eQ==
X-Gm-Message-State: AOJu0YzTQYfKGA/OImu+66SlWouMSuNtk55J7NJdSNy4QtGF7CwslPjJ
	LL/ZC1w7G/HF7fzm2CswB8A7opAHc0GMzT7lhmgk+FacgEcW20sA30SSuIQhr28q
X-Gm-Gg: ASbGncsZEaFwusqUapPm79S4xxmPG3WHBJI4ash2Pjj9XmUe4oThPvESkxYCTuriVZj
	a+uikSx9WlxHphjqLVrrKxG/NWkQgpoXY8qYzsYZaiffZ8cdJM/BWa+mNP4tKSW6OcLpcB6RToM
	R+oD5/DnMbaUm0zDdk0LCNLsJoUz8Iikb1pxCtkignRjyaVo3OaVVNwNCGC9MvhRuuyBsbc+/vc
	msoiDU/kOuoZH1WsDYeJEZEg/JGjVtun8CA5489q0ow4BCQBOoghSQ92PL5G+kyi0RYWEWwejfY
	krUjdAUSlPoEUqbNY+IyGXyGPmPqEmPiBI0jMDWhxKwZ5lPetl3R2g3Lu3XQjUbZ2cuXUf9nh9S
	5OVUnXs/IGuIBgKtkPcgbAu7m8I9Y4wiMRQ91gOT2ie23r8jJs01MTTL7/vPBwmgpP7Smv5XHkY
	ZLQE/Peg==
X-Google-Smtp-Source: AGHT+IFiN3MR93XDwL4+DHubbtiLUwACXBEaT7GBkANburSctoGlwfBIDFuOf/XRDEsxHvkfVGbS7g==
X-Received: by 2002:a05:6a00:802:b0:7ba:13f4:a985 with SMTP id d2e1a72fcca58-7e8c18502c0mr5803641b3a.23.1765159802581;
        Sun, 07 Dec 2025 18:10:02 -0800 (PST)
Received: from Tunnel ([64.104.44.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2ae9db68fsm11259274b3a.50.2025.12.07.18.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:10:01 -0800 (PST)
Date: Mon, 8 Dec 2025 11:09:56 +0900
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 8/8] bpftool: Dump oracle maps
Message-ID: <1d3538ac04ce5ff4b44ecfefcb685913e4c7ee1b.1765158925.git.paul.chaignon@gmail.com>
References: <cover.1765158924.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765158924.git.paul.chaignon@gmail.com>

This patch introduces minimum support in bpftool to dump and format the
contents of inner oracle maps. This new "bpftool oracle dump" command is
only meant to help demo and debug previous commits and is at the very
least missing support for JSON output.

The current output looks like:

    # ./bpftool oracle dump id 22
    State 0:
    R0=scalar(u64=[0; 18446744073709551615], s64=[-9223372036854775808; 9223372036854775807], u32=[0; 4294967295], s32=[-2147483648; 2147483647], var_off=(0; 0xffffffffffffffff)
    R6=scalar(u64=[4294967252; 4294967252], s64=[4294967252; 4294967252], u32=[4294967252; 4294967252], s32=[-44; -44], var_off=(0xffffffd4; 0)

    Found 1 state

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/bpf/bpftool/main.c       |   3 +-
 tools/bpf/bpftool/main.h       |   1 +
 tools/bpf/bpftool/oracle.c     | 154 +++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  10 +++
 4 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 tools/bpf/bpftool/oracle.c

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index a829a6a49037..c4101d7ae965 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -64,7 +64,7 @@ static int do_help(int argc, char **argv)
 		"       %s batch file FILE\n"
 		"       %s version\n"
 		"\n"
-		"       OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter | token }\n"
+		"       OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter | token | oracle }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-V|--version} }\n"
 		"",
@@ -81,6 +81,7 @@ static const struct cmd commands[] = {
 	{ "batch",	do_batch },
 	{ "prog",	do_prog },
 	{ "map",	do_map },
+	{ "oracle",	do_oracle },
 	{ "link",	do_link },
 	{ "cgroup",	do_cgroup },
 	{ "perf",	do_perf },
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 1130299cede0..9ee613d351a4 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -166,6 +166,7 @@ int do_btf(int argc, char **argv);
 /* non-bootstrap only commands */
 int do_prog(int argc, char **arg) __weak;
 int do_map(int argc, char **arg) __weak;
+int do_oracle(int argc, char **arg) __weak;
 int do_link(int argc, char **arg) __weak;
 int do_event_pipe(int argc, char **argv) __weak;
 int do_cgroup(int argc, char **arg) __weak;
diff --git a/tools/bpf/bpftool/oracle.c b/tools/bpf/bpftool/oracle.c
new file mode 100644
index 000000000000..c0a518ff5ee2
--- /dev/null
+++ b/tools/bpf/bpftool/oracle.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include "main.h"
+
+struct tnum {
+	__u64 value;
+	__u64 mask;
+};
+
+struct bpf_reg_oracle_state {
+	bool scalar;
+	bool ptr_not_null;
+
+	struct tnum var_off;
+	__s64 smin_value;
+	__s64 smax_value;
+	__u64 umin_value;
+	__u64 umax_value;
+	__s32 s32_min_value;
+	__s32 s32_max_value;
+	__u32 u32_min_value;
+	__u32 u32_max_value;
+};
+
+struct bpf_oracle_state {
+	struct bpf_reg_oracle_state regs[MAX_BPF_REG - 1];
+};
+
+static void print_register_state(int i, struct bpf_reg_oracle_state *reg)
+{
+	if (!reg->scalar && !reg->ptr_not_null)
+		return;
+
+	printf("R%d=", i);
+	if (reg->scalar) {
+		printf("scalar(u64=[%llu; %llu], s64=[%lld; %lld], u32=[%u; %u], s32=[%d; %d]",
+		       reg->umin_value, reg->umax_value, reg->smin_value, reg->smax_value,
+		       reg->u32_min_value, reg->u32_max_value, reg->s32_min_value,
+		       reg->s32_max_value);
+		printf(", var_off=(%#llx; %#llx)", reg->var_off.value, reg->var_off.mask);
+	} else if (reg->ptr_not_null) {
+		printf("ptr");
+	} else {
+		printf("unknown");
+	}
+	printf("\n");
+}
+
+static int
+oracle_map_dump(int fd, struct bpf_map_info *info, bool show_header)
+{
+	struct bpf_oracle_state value = {};
+	unsigned int num_elems = 0;
+	__u32 key, *prev_key = NULL;
+	int err, i;
+
+	while (true) {
+		err = bpf_map_get_next_key(fd, prev_key, &key);
+		if (err) {
+			if (errno == ENOENT)
+				err = 0;
+			break;
+		}
+		if (bpf_map_lookup_elem(fd, &key, &value)) {
+			printf("<no entry>");
+			continue;
+		}
+		printf("State %u:\n", key);
+		for (i = 0; i < MAX_BPF_REG - 1; i++)
+			print_register_state(i, &value.regs[i]);
+		printf("\n");
+		num_elems++;
+		prev_key = &key;
+	}
+
+	printf("Found %u state%s\n", num_elems,
+	       num_elems != 1 ? "s" : "");
+
+	close(fd);
+	return err;
+}
+
+static int do_dump(int argc, char **argv)
+{
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
+	int nb_fds, i, err;
+	int *fds = NULL;
+
+	fds = malloc(sizeof(int));
+	if (!fds) {
+		p_err("mem alloc failed");
+		return -1;
+	}
+	nb_fds = map_parse_fds(&argc, &argv, &fds, BPF_F_RDONLY);
+	if (nb_fds < 1)
+		goto exit_free;
+
+	for (i = 0; i < nb_fds; i++) {
+		if (bpf_map_get_info_by_fd(fds[i], &info, &len)) {
+			p_err("can't get map info: %s", strerror(errno));
+			break;
+		}
+		if (info.type != BPF_MAP_TYPE_ARRAY || info.key_size != sizeof(__u32) ||
+		    info.value_size != sizeof(struct bpf_oracle_state)) {
+			p_err("not an oracle map");
+			break;
+		}
+		err = oracle_map_dump(fds[i], &info, nb_fds > 1);
+		if (i != nb_fds - 1)
+			printf("\n");
+
+		if (err)
+			break;
+		close(fds[i]);
+	}
+
+	for (; i < nb_fds; i++)
+		close(fds[i]);
+exit_free:
+	free(fds);
+	return 0;
+}
+
+static int do_help(int argc, char **argv)
+{
+	if (json_output) {
+		jsonw_null(json_wtr);
+		return 0;
+	}
+
+	fprintf(stderr,
+		"Usage: %1$s %2$s dump       MAP\n"
+		"       %1$s %2$s help\n"
+		"\n"
+		"       " HELP_SPEC_MAP "\n"
+		"       " HELP_SPEC_OPTIONS " |\n"
+		"                    {-f|--bpffs} | {-n|--nomount} }\n"
+		"",
+		bin_name, argv[-2]);
+
+	return 0;
+}
+
+static const struct cmd cmds[] = {
+	{ "help",	do_help },
+	{ "dump",	do_dump },
+	{ 0 }
+};
+
+int do_oracle(int argc, char **argv)
+{
+	return cmd_select(cmds, argc, argv, do_help);
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6b92b0847ec2..f19dba37ea7d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1345,6 +1345,16 @@ enum {
 #define BPF_PSEUDO_MAP_VALUE		2
 #define BPF_PSEUDO_MAP_IDX_VALUE	6
 
+/* Internal only.
+ * insn[0].dst_reg:  0
+ * insn[0].src_reg:  BPF_PSEUDO_MAP_ORACLE
+ * insn[0].imm:      address of oracle state list
+ * insn[1].imm:      address of oracle state list
+ * insn[0].off:      0
+ * insn[1].off:      0
+ */
+#define BPF_PSEUDO_MAP_ORACLE 7
+
 /* insn[0].src_reg:  BPF_PSEUDO_BTF_ID
  * insn[0].imm:      kernel btd id of VAR
  * insn[1].imm:      0
-- 
2.43.0


