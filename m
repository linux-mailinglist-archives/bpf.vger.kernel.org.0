Return-Path: <bpf+bounces-50301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFFCA24DA7
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 12:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A84D51884B85
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 11:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D8C1D63F2;
	Sun,  2 Feb 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImTSyQRV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFBC1F5E6;
	Sun,  2 Feb 2025 11:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738494502; cv=none; b=blwXkL3qtMLCS0EU8pGveSR16cIkcDp+sLp5HB+5f5Z4IC4OKNb8kiNqorR/d1NBMjKRxJjpjqKMTvput0E5sPR+pgpS+y2ttg3jd/VVuqpOyBweUKq1aHT4bACNiW4QlFZO2OffpPkjdn/ADJBlFeOSF3iLiKXNUqOUXYfImKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738494502; c=relaxed/simple;
	bh=7Ti7bLf/nUZeZLYb1OPmcuwU/6UuzijbSYfVPN/jWBc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fx8ezHVupCH2rOBkpGCphVX2d3pLjdPvedI0OPmhoAQQxb9707ZR5hmn4k/m02xyEllbTpmFC5wArhQp7kMr3982+1lCgkB4iH1seutH4cr0BQeVxqO1BGfAnyGUBff7Sfw52vYuk5rL4KANZZXhgc3ZMWhSeBA9N0rrcP2DDN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImTSyQRV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf60d85238so538182766b.0;
        Sun, 02 Feb 2025 03:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738494499; x=1739099299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5JzXeM0bk8T85dqhtElwChalRxMx7DtA9IYgnOT7SBY=;
        b=ImTSyQRVuM6DuRicCm3tKx4dQ34B93Od+ZuqhKzj12FNRuhCvuuAHuTSFmFCxb/j6O
         M39hKtlKm5zQ/TNT0xulWkZg4oKoOXIz3iDC245LVCCh9FBO1rfkmTHlbDH4reiXkJ2a
         oEJzvze3hhPS2ZAsaWZUa/lcFH9NnjJ5J4f+5zGIO6UGUSkEMH6KaMGs0DEiawkHUX2R
         F0n2lg3lsPEMvGw4SXMkS1c7L7grmkuFHArU4HfI3N78gijpKYnz15ylTCInHfkUep2l
         jvj3PrxQtPEy/h45bGmo2tdON2TSN5tFFlLv6g4AIWeBnm14DLyNkpvNHTopXue5kJWV
         TxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738494499; x=1739099299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JzXeM0bk8T85dqhtElwChalRxMx7DtA9IYgnOT7SBY=;
        b=j57O8DCd1QA/bQhEQFnH5pxLJ07XUaG8OzLlfiqIp7b1LLOcFSsvO820YnAnNYqz9t
         W4+jM5P7bUvhLa1pRiO41KSD22YI9gT8+D+eDjRAbCJ8GyRcMz3YH5i3Ara//BbHYhCU
         2betiN3dMPsU4vUs1GxV5PJ7e78eGwETHrnCaO0PdXw3vTUnWaD0QrMtcAf5/x1HBd4o
         CNfQr8lpVoXV8MOpFoV6KYvmQW1rHU6ove7Lp2Y42/fYXefE9Aszs5SC3mh08aANDFHR
         +roh3KsoveoDvV1lbvTXz0ZRWU2uf0Xl/Nd6YJF7aNzSfr6d+lF+E7+5EGs7uLmvaZE6
         IWGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6urfQX1LT0gjb0gk21+EfcEy7NRoJ3zZ9osS8nPZNdoGuNkihhJAmTxec5HO3R5n95Yj1D4xR@vger.kernel.org, AJvYcCUok04yXz8O1smOOdTFp3IHWf+YenPPFd8nlBFcKmQ0clCa3NmjdwYrVwkAIUTBTwb6//KuLbmONh5lTf7v@vger.kernel.org, AJvYcCUwQwP9fQX7ihrw2ZpSl4Z+HRSqGNEr9j6W8jSsm8cCWHqW7NHdWPxpRCcBI4GPAd18kRIsN+z0UxZS@vger.kernel.org, AJvYcCVFDYm+X5Jz2+5nJ9CBrFxUmcogZC6jWdGpXd+bMT+wm0Dl5PB7hiDUGvj56aI9zZp1Z78=@vger.kernel.org, AJvYcCWbXBs/nHA8L9HX6/Bmtitv3D1RZx75Tu3rSihj/DzHcgMOEs4/u5jO78SePRIiakL3nD/OaiH7AvEzJ20kta5pypPL@vger.kernel.org
X-Gm-Message-State: AOJu0YzYZnCMQvOpKNUO4sqVsYDAqj1LNc60PxgQHiJxPEFXK2QNfb7y
	7xAiAskSe60gsb7nh1QX8H+13eGZWAb419AZhihM6I8BNGbZho8p
X-Gm-Gg: ASbGnctFrFU/rox5FdzvP17JeJKpALkoDmMFc4eUVXpFQD/61UHhzAAD6x0l6emkIHa
	269bW9WuO5FYQroe9JETxIfX80H8BZmspOf1eEl3P2XR+mVvJ7S4FMF0LsjNQBgouWf5vM/yrO3
	UQUaDDRSFQuN+0QxX8bd7UG38Gh3c1w3BjxOHSklYF+ByjBLjqXUz99lTt1gd2bH93LmjFxVwmu
	M3J19ZzQTnge/T0FLeEl1EeQ+AvFZGP59qAWjK23AkwuRQTYn2U4U10nojgQrU9rRypqrVi9c+L
	qKzQP2nPp+T74zjrzHm8Bg==
X-Google-Smtp-Source: AGHT+IF3QIxVqstzt7kbzFsj1mb+uFadRK07ZMT0XR0Azfv46RHBNEKzufNoK/M/YIlBMZMJljlxsQ==
X-Received: by 2002:a17:906:c113:b0:aab:eefc:92e5 with SMTP id a640c23a62f3a-ab6cfcde0f6mr1843984766b.14.1738494498690;
        Sun, 02 Feb 2025 03:08:18 -0800 (PST)
Received: from krava (37-188-150-0.red.o2.cz. [37.188.150.0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e49ff2c6sm571736366b.96.2025.02.02.03.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 03:08:18 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 2 Feb 2025 12:08:13 +0100
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Jiri Olsa <olsajiri@gmail.com>,
	luto@amacapital.net, wad@chromium.org, oleg@redhat.com,
	mhiramat@kernel.org, andrii@kernel.org,
	alexei.starovoitov@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <Z59SHdsme3qlx8UZ@krava>
References: <20250128145806.1849977-1-eyal.birger@gmail.com>
 <202501281634.7F398CEA87@keescook>
 <CAHsH6Gsv3DB0O5oiEDsf2+Go4O1+tnKm-Ab0QPyohKSaroSxxA@mail.gmail.com>
 <Z5s3S5X8FYJDAHfR@krava>
 <CAHsH6GvsGbZ4a=-oSpD1j8jx11T=Y4SysAtkzAu+H4_Gh7v3Qg@mail.gmail.com>
 <Z5v063xNVJfXCnKV@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5v063xNVJfXCnKV@krava>

On Thu, Jan 30, 2025 at 10:53:47PM +0100, Jiri Olsa wrote:

SNIP

> > > > I think this would mean that this test suite would need to run as
> > > > privileged. Is that Ok? or maybe it'd be better to have a new suite?
> > > >
> > > > > With at least these cases combinations below. Check each of:
> > > > >
> > > > >         - not using uretprobe passes
> > > > >         - using uretprobe passes (and validates that uretprobe did work)
> > > > >
> > > > > in each of the following conditions:
> > > > >
> > > > >         - default-allow filter
> > > > >         - default-block filter
> > > > >         - filter explicitly blocking __NR_uretprobe and nothing else
> > > > >         - filter explicitly allowing __NR_uretprobe (and only other
> > > > >           required syscalls)
> > > >
> > > > Ok.
> > >
> > > please let me know if I can help in any way with tests
> > 
> > Thanks! Is there a way to partition this work? I'd appreciate the help
> > if we can find some way of doing so.
> 
> sure, I'll check the seccomp selftests and let you know

hi,
if it's any help, feel free to use the code below that creates uretprobe,
it could be bit simpler if we use libbpf, but I think that's not an option

jirka


---
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 8c3a73461475..1f99d31d05a1 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -47,6 +47,7 @@
 #include <linux/kcmp.h>
 #include <sys/resource.h>
 #include <sys/capability.h>
+#include <linux/perf_event.h>
 
 #include <unistd.h>
 #include <sys/syscall.h>
@@ -4888,6 +4889,130 @@ TEST(tsync_vs_dead_thread_leader)
 	EXPECT_EQ(0, status);
 }
 
+__attribute__((noinline)) int probed(void)
+{
+        return 1;
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
+static int create_uretprobe(void *addr)
+{
+	const size_t attr_sz = sizeof(struct perf_event_attr);
+	struct perf_event_attr attr;
+	ssize_t offset;
+	int type, bit;
+
+	memset(&attr, 0, attr_sz);
+
+	type = determine_uprobe_perf_type();
+	if (type < 0)
+		return -1;
+	bit = determine_uprobe_retprobe_bit();
+	if (bit < 0)
+		return -1;
+	offset = get_uprobe_offset(probed);
+	if (offset < 0)
+		return -1;
+
+	attr.config |= 1 << bit;
+	attr.size = attr_sz;
+	attr.type = type;
+	attr.config1 = ptr_to_u64("/proc/self/exe");
+	attr.config2 = offset;
+
+	return syscall(__NR_perf_event_open, &attr,
+			getpid() /* pid */, -1 /* cpu */, -1 /* group_fd */,
+			PERF_FLAG_FD_CLOEXEC);
+}
+
+TEST(uretprobe)
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
+	long ret;
+	int fd;
+
+	fd = create_uretprobe(probed);
+	ASSERT_GE(fd, 0) {
+		TH_LOG("Failed to create uretprobe!!");
+	}
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, NULL, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	ret = seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog);
+	ASSERT_NE(ENOSYS, errno) {
+		TH_LOG("Kernel does not support seccomp syscall!");
+	}
+	EXPECT_EQ(0, ret) {
+		TH_LOG("Could not install filter!");
+	}
+
+	/* should not explode */
+	probed();
+
+	/* we could call close(fd), but we'd need extra filter for
+	 * that and since we we are calling _exit right away.. */
+}
+
 /*
  * TODO:
  * - expand NNP testing

