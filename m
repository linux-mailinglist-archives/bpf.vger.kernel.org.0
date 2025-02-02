Return-Path: <bpf+bounces-50305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADB3A24EF8
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 17:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D6B37A268E
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BB71FBCB6;
	Sun,  2 Feb 2025 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR80IkuW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475491FBC9A;
	Sun,  2 Feb 2025 16:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738513786; cv=none; b=prsiLs77bzedbiU4w+Lwj6oMYXd/4iFjJAchfDggNkcs6YetelDukalQBPNosgiEx7Ddw0JcPRhSMkS1IAoh06e7jkuOy2XHAOunL63T/qPiLfRIVynkS9G6KtuBzs1ylWf5ki2xl74QSGKuRVg6tfYX06gE0rSR139CDH9JhdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738513786; c=relaxed/simple;
	bh=soVj2Oaqs8fwp2a6uDtI8XqJczblp8MvLTN44mXayQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+1nmrMwZgLPIiQG5arvAWDT0fvZ4CVJYDBHugdEg5iRT1JIeuWv2UaH3pedFMWowK+tAAghVDwpw84WALuWAHXPozEpt0RhPMaXv+XD5Fyu3yMLJu3K9EE774IMVk67nDbUnI/FQm5rRFznBOJ13o3yAB404+ar8HW6gAlnipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SR80IkuW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166651f752so66498355ad.3;
        Sun, 02 Feb 2025 08:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738513784; x=1739118584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mMNhJLAgCpr/zxXKISjydYkPPj1PemEQfBJBoS6hI0=;
        b=SR80IkuWjuwVYdadqDLC3Y6JjyVKSRuKU2dcApo09DWYRjDxubBhaSqXKwMMd2/68W
         gdWsVV9DwcAiodSSLrK56AXp62t7OMSf/9B9eU4L8fgQ0y1e9KokNTyV4jEx0hD7v6eI
         xL1u8k8cuXoqlB/LLQohSvxSkonAcLhZ1J9P7EfLBKx6saXnozQeKtjZsXEdp/EFq24P
         A8Ldjvacmd7qUSB6L37o+8j9LEw73cXYXtPLOFtZF/Ty2Zqs3PQ7xjIXmipAXaNqbS2U
         1YvhUUaPIFHvWQ96asXIyr3qxPhYiaxwiaPKPXJgXEiCC5kQXWP0t2xhs9AsvmwTk7Ba
         I8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738513784; x=1739118584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mMNhJLAgCpr/zxXKISjydYkPPj1PemEQfBJBoS6hI0=;
        b=nBGCu3nXvNgiXtJ5oGUBKkDWxTpnvXlNLvsfL+4qAInQeJH7k9qFk2vVUc+gIANtHe
         zvfDpq6juXKxnIL10ZY7BdPFDRIpFA1nVBjGL3mue2EYzJA+fGjSJa2xh3PK733SLK1E
         OQJs/ZfpAkE4eiStvAnia3MSVDqN5akMfjUngU8DAmwgk9Fhq6EJ5BgtUY85vvQhh+Ot
         nIa4TNsow7HdhtprZ5jJw8oDa9uE68CZeo+lvMgRjKcSIhSWCYpU9JCVdIl2r7kgqp1m
         bt9BggcRT26A4Y9caIVm9QdnoMmV1VPdb7r3M2QBDTdhWJ0QWVOe+c5ronJRVnfd45jX
         Sc5w==
X-Forwarded-Encrypted: i=1; AJvYcCUK2xGeufv+CcKAgpGmoJ21LoX7xGhFDcfzexdvGa+NjhBEnhno7uijn3KBYVw7N3CR1co=@vger.kernel.org, AJvYcCWFd8o6A22Yzcz93aRPdfY+TbEkAyzjuaP8/6GgqVh3CnLdn4o8k/iXNsH5V1gpKoPXHnMebM24zisf@vger.kernel.org, AJvYcCWNpPiaBcv9K78zoEXyRNAnrl9a3WfWb0poVFnsoU9oTLykwy0XsOL+ilLQEf0H/FR4jPlZGRrGO+/ccC6a@vger.kernel.org, AJvYcCX40G9IP6PtmEArcrsAKtvXJoa7muuLxFjSz2jP9HoQOAGJjLimM21BC1a9XEtQDNluuNH2YCQKNHPd+mkJcBe6uiJC@vger.kernel.org
X-Gm-Message-State: AOJu0YzPGrPXx0b5mXpnKY3tB+P41bE9WL3Eve7l8PR+2KknF+sfJcJX
	gzMW6igiCc6mNfDlM82pfyeaY5GlaPaT7KM0WqDOg/5fnbV8hJFI
X-Gm-Gg: ASbGncuaI2/GP7CyeELF13EG9NjhwF3CcPDvW/gSNwzJfVH1d2gox/Il5JPX4pol7FR
	2z2URu+gf/WF3VYHFRBlr8wX4b5uGcOAcTT30gifK39in9j8ApLPUuapXUVavs97IT6kBEqgA+m
	uEsUDYqgNrJoevBabov2misLKJAoADfZ2KFlvAyytqPMK/OYTGBfCYnHRyz9AN5eA3aU39r1izO
	k70aJmg3TxpYe9vOXoKDyz7XSN3PtaQiLaLlgXHVL/UkRwItjSO1Db5YIbYai+Xtdm7uBd+reSy
	N30b9xaUvbqi7EACuyhWki8saGAsrxruJnQFDTMRcYqrD2IRr/P4s1RGQp4bMqFkCSpMBw==
X-Google-Smtp-Source: AGHT+IE4hdli4GZLFi7g/4NN9IyaZApE9muWNkTMGv5x16cwZOqAtEl/NlPg/POdgcy7tOVuXZvIwg==
X-Received: by 2002:a05:6a00:3919:b0:725:df1a:282 with SMTP id d2e1a72fcca58-72fd0be3556mr26750487b3a.10.1738513784417;
        Sun, 02 Feb 2025 08:29:44 -0800 (PST)
Received: from localhost.localdomain (syn-104-035-026-140.res.spectrum.com. [104.35.26.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1ccd0sm6834671b3a.178.2025.02.02.08.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 08:29:44 -0800 (PST)
From: Eyal Birger <eyal.birger@gmail.com>
To: kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	oleg@redhat.com,
	mhiramat@kernel.org,
	andrii@kernel.org,
	jolsa@kernel.org
Cc: alexei.starovoitov@gmail.com,
	olsajiri@gmail.com,
	cyphar@cyphar.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	bp@alien8.de,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii.nakryiko@gmail.com,
	rostedt@goodmis.org,
	rafi@rbk.io,
	shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH v3 2/2] selftests/seccomp: validate uretprobe syscall passes through seccomp
Date: Sun,  2 Feb 2025 08:29:21 -0800
Message-ID: <20250202162921.335813-3-eyal.birger@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250202162921.335813-1-eyal.birger@gmail.com>
References: <20250202162921.335813-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uretprobe syscall is implemented as a performance enhancement on
x86_64 by having the kernel inject a call to it on function exit; User
programs cannot call this system call explicitly.

As such, this syscall is considered a kernel implementation detail and
should not be filtered by seccomp.

Enhance the seccomp bpf test suite to check that uretprobes can be
attached to processes without the killing the process regardless of
seccomp policy.

Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 195 ++++++++++++++++++
 1 file changed, 195 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 8c3a73461475..bee4f424c5c3 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -47,6 +47,7 @@
 #include <linux/kcmp.h>
 #include <sys/resource.h>
 #include <sys/capability.h>
+#include <linux/perf_event.h>
 
 #include <unistd.h>
 #include <sys/syscall.h>
@@ -68,6 +69,10 @@
 # define PR_SET_PTRACER 0x59616d61
 #endif
 
+#ifndef noinline
+#define noinline __attribute__((noinline))
+#endif
+
 #ifndef PR_SET_NO_NEW_PRIVS
 #define PR_SET_NO_NEW_PRIVS 38
 #define PR_GET_NO_NEW_PRIVS 39
@@ -4888,6 +4893,196 @@ TEST(tsync_vs_dead_thread_leader)
 	EXPECT_EQ(0, status);
 }
 
+noinline int probed(void)
+{
+	return 1;
+}
+
+static int parse_uint_from_file(const char *file, const char *fmt)
+{
+	int err = -1, ret;
+	FILE *f;
+
+	f = fopen(file, "re");
+	if (f) {
+		err = fscanf(f, fmt, &ret);
+		fclose(f);
+	}
+	return err == 1 ? ret : err;
+}
+
+static int determine_uprobe_perf_type(void)
+{
+	const char *file = "/sys/bus/event_source/devices/uprobe/type";
+
+	return parse_uint_from_file(file, "%d\n");
+}
+
+static int determine_uprobe_retprobe_bit(void)
+{
+	const char *file = "/sys/bus/event_source/devices/uprobe/format/retprobe";
+
+	return parse_uint_from_file(file, "config:%d\n");
+}
+
+static ssize_t get_uprobe_offset(const void *addr)
+{
+	size_t start, base, end;
+	bool found = false;
+	char buf[256];
+	FILE *f;
+
+	f = fopen("/proc/self/maps", "r");
+	if (!f)
+		return -1;
+
+	while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &base) == 4) {
+		if (buf[2] == 'x' && (uintptr_t)addr >= start && (uintptr_t)addr < end) {
+			found = true;
+			break;
+		}
+	}
+	fclose(f);
+	return found ? (uintptr_t)addr - start + base : -1;
+}
+
+FIXTURE(URETPROBE) {
+	int fd;
+};
+
+FIXTURE_VARIANT(URETPROBE) {
+	/*
+	 * All of the URETPROBE behaviors can be tested with either
+	 * uretprobe attached or not
+	 */
+	bool attach;
+};
+
+FIXTURE_VARIANT_ADD(URETPROBE, attached) {
+	.attach = true,
+};
+
+FIXTURE_VARIANT_ADD(URETPROBE, not_attached) {
+	.attach = false,
+};
+
+FIXTURE_SETUP(URETPROBE)
+{
+	const size_t attr_sz = sizeof(struct perf_event_attr);
+	struct perf_event_attr attr;
+	ssize_t offset;
+	int type, bit;
+
+	if (!variant->attach)
+		return;
+
+	memset(&attr, 0, attr_sz);
+
+	type = determine_uprobe_perf_type();
+	ASSERT_GE(type, 0);
+	bit = determine_uprobe_retprobe_bit();
+	ASSERT_GE(bit, 0);
+	offset = get_uprobe_offset(probed);
+	ASSERT_GE(offset, 0);
+
+	attr.config |= 1 << bit;
+	attr.size = attr_sz;
+	attr.type = type;
+	attr.config1 = ptr_to_u64("/proc/self/exe");
+	attr.config2 = offset;
+
+	self->fd = syscall(__NR_perf_event_open, &attr,
+			   getpid() /* pid */, -1 /* cpu */, -1 /* group_fd */,
+			   PERF_FLAG_FD_CLOEXEC);
+}
+
+FIXTURE_TEARDOWN(URETPROBE)
+{
+	/* we could call close(self->fd), but we'd need extra filter for
+	 * that and since we are calling _exit right away..
+	 */
+}
+
+static int run_probed_with_filter(struct sock_fprog *prog)
+{
+	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) ||
+	    seccomp(SECCOMP_SET_MODE_FILTER, 0, prog)) {
+		return -1;
+	}
+
+	probed();
+	return 0;
+}
+
+TEST_F(URETPROBE, uretprobe_default_allow)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	ASSERT_EQ(0, run_probed_with_filter(&prog));
+}
+
+TEST_F(URETPROBE, uretprobe_default_block)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_exit_group, 1, 0),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	ASSERT_EQ(0, run_probed_with_filter(&prog));
+}
+
+TEST_F(URETPROBE, uretprobe_block_uretprobe_syscall)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+#ifdef __NR_uretprobe
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_uretprobe, 0, 1),
+#endif
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	ASSERT_EQ(0, run_probed_with_filter(&prog));
+}
+
+TEST_F(URETPROBE, uretprobe_default_block_with_uretprobe_syscall)
+{
+	struct sock_filter filter[] = {
+		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
+			offsetof(struct seccomp_data, nr)),
+#ifdef __NR_uretprobe
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_uretprobe, 2, 0),
+#endif
+		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_exit_group, 1, 0),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
+		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
+	};
+	struct sock_fprog prog = {
+		.len = (unsigned short)ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	ASSERT_EQ(0, run_probed_with_filter(&prog));
+}
+
 /*
  * TODO:
  * - expand NNP testing
-- 
2.43.0


