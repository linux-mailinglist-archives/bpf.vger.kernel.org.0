Return-Path: <bpf+bounces-49965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCE3A20C6A
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 15:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A6218848AA
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A841ACED5;
	Tue, 28 Jan 2025 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlee6Q3a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3AF9F8;
	Tue, 28 Jan 2025 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738076306; cv=none; b=q461SAU/0ouoL4c4DItk/TadqHzaDMaBDaRAG/XdTkha2XOAbVCNQR2lFHCJKnvEOSEJap6iAzppVG8RcDw0KN6cj93QGUtAH0pzxago8V+TmsKzKb08ZQjkO+9OswU3+sDZVXSA1m7sroJjNFR7AuFWxvsxIL7OHZVm2u+aO2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738076306; c=relaxed/simple;
	bh=lM67DGGiMbIMrMTUwNR8l7KiQyWcxQfJsWFW+hgxxU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ASXdoZNCqbEudWx3F+MzzRdTs3SfnYpEZ7/VFfv8RK4UH12kKvYwu3kvcWx+rN9keEclXXZ9HmEqBZbA7maskgfuhTh56ePaJSkkay/i30mLpVrNY8oP3zZ4KoZhLaKEJz6Obcmkb+glfwo1ucNrDdXMGI4TI5hP5O9hf1xreoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlee6Q3a; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so8031926a91.2;
        Tue, 28 Jan 2025 06:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738076304; x=1738681104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5NgK1PyzlgcgU3jbjx+DyDukT7QBmAGxcdaN+SPDB1Y=;
        b=dlee6Q3a7RszllPDFz/TD5+8jVb30OuY9K0CargqegNTRvGqmebdZC81Alatqg22mw
         svmD/zn4RrVIdU4gLGbLsxQ9nUJBUCAc511l7Byq8rv9QHCi0miCGPRRwYH1usvD2xcD
         Iv3CUJujuTFf1hieSn3JY2RJgCgeU9GZKWGnNMMcyEnh6QeBBzLY6Fm1c4Wuw28bmdm7
         WWDedAlYpzND0o20FHjQyONbON4Psn6ejBa2gNJ40R8PWrzInpUjKPeo5KNiY08ubptu
         qoyQhwsvykWHo8O55oaEydNnrBiO+Awm0bNRAK9GmSh7V8i1HkQ2NopRk0G1zvGKmX0w
         SrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738076304; x=1738681104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NgK1PyzlgcgU3jbjx+DyDukT7QBmAGxcdaN+SPDB1Y=;
        b=hhHpgVQlEmpYgPfEqrSnZrUlRHEDaAORqpNoaAwY8XTMGnPZG1LgRFUnScJH8d4ePU
         42KtULOxKCcImnSLKCY2lZl8BSQg30Cb1xntJfn3X7rQodb3i6CqgDXmrYItcNXDIkOw
         KahPaE3WIZ56kYdPB82/PCeRxVY3ndzFE0S5JDKrin38d3n4USc3HtbBzIYEo+aR4LNT
         /mA/3Vj6X0j9HdTQrzKRibe4fbZf59iJGRJpruC8cSritCgq6iZTNhmT/McGgqCC3ghN
         C3DNQdriqLsbchdjGOYu8WA17KnXRASKm1MgqZc1leT8UsT5/hH0BZeI9iLIsPFbckOE
         IerA==
X-Forwarded-Encrypted: i=1; AJvYcCU7rwxBXTOswj9b44zZE6etqwUhKZfFijf619GP01hMcZnub+TVtdixilxAcvJp0F3h/WLV3zsWLS0u@vger.kernel.org, AJvYcCUYRAWfmu9Cg6vPjbKAeCjZRmW3RHGtPQXYvK+FbPrTlGCC4JEC7fT5qmGKyaBRe9WS6rs=@vger.kernel.org, AJvYcCVl1KdcbOA7iWDYyK/n6th3rWMg7lzTTcJkmvxGAdQ9l+RZG7dCk0DN4m5/1CGLPXf4yPAAj5A9NS9ROYnjoi03UlEd@vger.kernel.org, AJvYcCX7POaLecgnmqPruLlzqOSOnXl4ruTh9ryCmkZUK/n0WVAOE5FZvU5Ta3s48izmNubu8J+cIA/n@vger.kernel.org, AJvYcCXwKiV9tWMvbgikAX7DwXl/VIXPVm33nUsVb0c/EGazX7MN2YfJRhprQ6TTh1fCPd+WGX98BzqMC7Q8/y9p@vger.kernel.org
X-Gm-Message-State: AOJu0YyNKoRfqd1cSpQOFfMaGiLTV7+74b77W+myLJp0LcL/GmWz83dT
	DicDolPtv5B070mD8HbJXpqLLY3hZpQ/i/kUYxi7gMf0/XJq3WmB
X-Gm-Gg: ASbGncuYLKwLA0KO04qICMeMMLxA18Xtee4nT3CaCPrz2RJzibVsVzY3tfErcfWs8Fs
	XwJQhkulHbmaVmO9JsnVeIdJ1WL0o2Jg3tcfbaDmKeDRRR9mfkVKQvBJRyirYWb6xtsfyqJAGBh
	HNROybV5nYn2fDTw32kKLNFn1yvIkAIJgiCNMnLJPRMyxbvS29p+vYsW4aFOvyO4hz6xMf9HQpm
	OhL/HMpmKsCxbW17hMwlxJNHssmGXDn5iqGbZvJH+mL/Vcgu6mqmaeOETUSZp6/Wi1iTrIeE1cQ
	xPPv69CLY9Ht/6IHJZa9FWNxmKU/8yenmAlYTjm/oc0CwYrmjUjYyS0Ji60JiZt/7yycyg==
X-Google-Smtp-Source: AGHT+IF4WOMe+E1ASphpyPufkPOsl65YTCva6RW3RPHB5aOPWPoVqJdw41Y0NpAQQaSz7q4qYh/Kcg==
X-Received: by 2002:a17:90b:4c43:b0:2ee:c5ea:bd91 with SMTP id 98e67ed59e1d1-2f782d65adbmr61068210a91.29.1738076304080;
        Tue, 28 Jan 2025 06:58:24 -0800 (PST)
Received: from localhost.localdomain (syn-104-035-026-140.res.spectrum.com. [104.35.26.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffac2807sm9485398a91.20.2025.01.28.06.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 06:58:23 -0800 (PST)
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
	Eyal Birger <eyal.birger@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] seccomp: passthrough uretprobe systemcall without filtering
Date: Tue, 28 Jan 2025 06:58:06 -0800
Message-ID: <20250128145806.1849977-1-eyal.birger@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When attaching uretprobes to processes running inside docker, the attached
process is segfaulted when encountering the retprobe.

The reason is that now that uretprobe is a system call the default seccomp
filters in docker block it as they only allow a specific set of known
syscalls. This is true for other userspace applications which use seccomp
to control their syscall surface.

Since uretprobe is a "kernel implementation detail" system call which is
not used by userspace application code directly, it is impractical and
there's very little point in forcing all userspace applications to
explicitly allow it in order to avoid crashing tracked processes.

Pass this systemcall through seccomp without depending on configuration.

Note: uretprobe isn't supported in i386 and __NR_ia32_rt_tgsigqueueinfo
uses the same number as __NR_uretprobe so the syscall isn't forced in the
compat bitmap.

Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
Reported-by: Rafael Buchbinder <rafi@rbk.io>
Link: https://lore.kernel.org/lkml/CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com/
Link: https://lore.kernel.org/lkml/20250121182939.33d05470@gandalf.local.home/T/#me2676c378eff2d6a33f3054fed4a5f3afa64e65b
Cc: stable@vger.kernel.org
Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
---
v2: use action_cache bitmap and mode1 array to check the syscall

The following reproduction script synthetically demonstrates the problem
for seccomp filters:

cat > /tmp/x.c << EOF

char *syscalls[] = {
	"write",
	"exit_group",
	"fstat",
};

__attribute__((noinline)) int probed(void)
{
	printf("Probed\n");
	return 1;
}

void apply_seccomp_filter(char **syscalls, int num_syscalls)
{
	scmp_filter_ctx ctx;

	ctx = seccomp_init(SCMP_ACT_KILL);
	for (int i = 0; i < num_syscalls; i++) {
		seccomp_rule_add(ctx, SCMP_ACT_ALLOW,
				 seccomp_syscall_resolve_name(syscalls[i]), 0);
	}
	seccomp_load(ctx);
	seccomp_release(ctx);
}

int main(int argc, char *argv[])
{
	int num_syscalls = sizeof(syscalls) / sizeof(syscalls[0]);

	apply_seccomp_filter(syscalls, num_syscalls);

	probed();

	return 0;
}
EOF

cat > /tmp/trace.bt << EOF
uretprobe:/tmp/x:probed
{
    printf("ret=%d\n", retval);
}
EOF

gcc -o /tmp/x /tmp/x.c -lseccomp

/usr/bin/bpftrace /tmp/trace.bt &

sleep 5 # wait for uretprobe attach
/tmp/x

pkill bpftrace

rm /tmp/x /tmp/x.c /tmp/trace.bt
---
 kernel/seccomp.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 385d48293a5f..23b594a68bc0 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -734,13 +734,13 @@ seccomp_prepare_user_filter(const char __user *user_filter)
 
 #ifdef SECCOMP_ARCH_NATIVE
 /**
- * seccomp_is_const_allow - check if filter is constant allow with given data
+ * seccomp_is_filter_const_allow - check if filter is constant allow with given data
  * @fprog: The BPF programs
  * @sd: The seccomp data to check against, only syscall number and arch
  *      number are considered constant.
  */
-static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
-				   struct seccomp_data *sd)
+static bool seccomp_is_filter_const_allow(struct sock_fprog_kern *fprog,
+					  struct seccomp_data *sd)
 {
 	unsigned int reg_value = 0;
 	unsigned int pc;
@@ -812,6 +812,21 @@ static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
 	return false;
 }
 
+static bool seccomp_is_const_allow(struct sock_fprog_kern *fprog,
+				   struct seccomp_data *sd)
+{
+#ifdef __NR_uretprobe
+	if (sd->nr == __NR_uretprobe
+#ifdef SECCOMP_ARCH_COMPAT
+	    && sd->arch != SECCOMP_ARCH_COMPAT
+#endif
+	   )
+		return true;
+#endif
+
+	return seccomp_is_filter_const_allow(fprog, sd);
+}
+
 static void seccomp_cache_prepare_bitmap(struct seccomp_filter *sfilter,
 					 void *bitmap, const void *bitmap_prev,
 					 size_t bitmap_size, int arch)
@@ -1023,6 +1038,9 @@ static inline void seccomp_log(unsigned long syscall, long signr, u32 action,
  */
 static const int mode1_syscalls[] = {
 	__NR_seccomp_read, __NR_seccomp_write, __NR_seccomp_exit, __NR_seccomp_sigreturn,
+#ifdef __NR_uretprobe
+	__NR_uretprobe,
+#endif
 	-1, /* negative terminated */
 };
 
-- 
2.43.0


