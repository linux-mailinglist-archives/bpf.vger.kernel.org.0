Return-Path: <bpf+bounces-49146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453FDA1472F
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 01:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453E73A4D9A
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9D31DFD8;
	Fri, 17 Jan 2025 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q00RBPA/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A3F4964F;
	Fri, 17 Jan 2025 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737075368; cv=none; b=jm/nEOeAbpFtu/72/lPUfQbQXSGP1ptINevn+yc5uqBC2IQdj/VLWweEp95/47aMzQDKmpVadYF13Xnj4RAUa0SEGXKhEuC4/Lt88EVWnkF5fP4F3hoBCTvncgAFWCiFT2W9SOHJufXAqUozgHcwSgfJLxkVOgxJd/RHXdUPjsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737075368; c=relaxed/simple;
	bh=PGk5/lCOi9wTekGEhHL7fo0Q7bQDZyPdu1q0dSW//1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQJjEdIhRHyHJtdIZIe6gQ3uVDC3QhKalppqsQY3FrcBihjn+yH3eSCxTM2PyzlYyjW+ot7mjpT22WQdW0MPIesBRL6qAtPWcd38bT3MAmd6P+ZNc80Trz7126Yxoe2pfHCg6A1gJuGzfwP2xq8HQX/U9vB8lkAu3BAodQJf4+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q00RBPA/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2166022c5caso26272065ad.2;
        Thu, 16 Jan 2025 16:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737075365; x=1737680165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hdCX1//PgvcYP6WT8gI6Zs/4LZU9YR455bPkJDbqlLc=;
        b=Q00RBPA/khuX/bevtbH98jTPRNLxrj64QhbsQfcVhrgpnzjEZZz6b+mLhvm28H/s2I
         qrQti3MS2bkTWVfOhR7EO144Ip0TgyV2g3zTCQblAes/Aff7+KXslDS1S/5ooWGBzB54
         SXgLVbhg5HA+uVjl/4cSx2be5sIrGr9wu3iS9WklEg5b3XluHYG4CnahCsCnsabkMbO5
         x+6NWqdVUsqrC70t2rCxphl44JzKnE8l+hlV/7WnNNrpIhKCKy2nhRqqbuUGHzj0Dx42
         e/23mkXdwzYAlddB+ziLpUEUX2FxpPqBkvqc4s8ptqO7kIg5CiEMFqxoR9iSXke/kHVe
         vvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737075365; x=1737680165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdCX1//PgvcYP6WT8gI6Zs/4LZU9YR455bPkJDbqlLc=;
        b=mxtWIoRNedowMO30veTNKeKCJ55adxhrZKLYQFaGZpcnpKkz+GF2IRhzPFNBiAc8k5
         3/5J2NIvVb7flYWHkHmEBdCjWuxcKDpvNMqyL2CW6gqf8b1L7B4T2Udo7vPFAPltgM5V
         WztLqs7y8WQME+Uu0nDPZS0r2RnHUF3IWouqjj3LKG2GveGwPIiAkAT1hh5exa8UsT4o
         ha6cfXhSwTNR91g3K/Wt/WR59k6CiSChPf+vFtZLMcrH1AxwTW5WZ1NdmTv5qxDJ2dSu
         hUVacsMhQQ+Tt1iRGslqo96fvryDk5tYgswcfaURSz/6YD1ezKZqfe/8h+NvYtiOy856
         pdhg==
X-Forwarded-Encrypted: i=1; AJvYcCUT0w5KaCK69aSHMf6igrYmxKIkVC52MbXHhkL/blg8pQlAELLosOIOs2dOZZt26IGTs0lGOA5jg4B7I8Ce@vger.kernel.org, AJvYcCUwK5etVZhuo8z1N1O9uKbWU8gfcQdSVSt3LVaeL6VMQzGdznS2xDfdwZDuzY88PtviK7K8lm7QJrSJ@vger.kernel.org, AJvYcCV38WXmIa2uhDZvVZgx25ZY9WCFQhZAX4lLTLvrrccOycFxM8GM0qgtmz+VDmYdEbNqspH6jD4b@vger.kernel.org, AJvYcCV6dKrybKV7DUrVHftBh8Sr/EkOJAClgOKgXb4guMf9oGBinShP/9Usl8O4HxJjxcDeLJ0=@vger.kernel.org, AJvYcCVsbHYCA+Cj0rhEa6BjKgDHJ155zMTbN12r8sIDmcCFbRxloSMNi5KeVdOg69eg3VoMl98TiPQ/a4txmTUxUtuF3iwi@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJAIrWF42rX2spiGYPYVAKFT2ke/yiUi2LLWP10qNmP3pMmtN
	PUkDsr2sJH3Qrb6OFPKQ8+vmH7SifTA7cjPXhN9zwHYq3c+8SgPT
X-Gm-Gg: ASbGncs1Zrm/BSc2GSoZvq52M5wzH6OvsiHcB3b8brAFvZYtu2ynMhPnDTX6FQgs464
	j5PX1F3xSjGd+GcvtqC0m99OLcGy4lr4L9Eypx2vPnAuz0GOMKLS12r7a3vYzfhEG3P621vulcZ
	ECeJ456oESrU+6TqocAIvMIFxKpQy5bi+5VeksVqtHeAhHQBOY6OC7TLvgLHCUwppAcQMgblPX1
	1iZEvkT5VH5rMZvMEEIB6rvK7mZZegmjIUw4ENqdIZNgROOleSadRIAPtnQUhQSPU1PN8PDfV5G
	wet2R8GVwt4Rh18pWM3fgdtQ0FnsIYikviE=
X-Google-Smtp-Source: AGHT+IHoJpMYIXYH3nxRztqBwdpCEHhGf+y+6GJm/RpzISEj+zDi9VRw6CEEz1vrk9IWLcJdshDxtA==
X-Received: by 2002:a17:902:d4c8:b0:216:725c:a11a with SMTP id d9443c01a7336-21c352c8145mr13843345ad.10.1737075365064;
        Thu, 16 Jan 2025 16:56:05 -0800 (PST)
Received: from localhost.localdomain (syn-104-035-026-140.res.spectrum.com. [104.35.26.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea2d70sm5765665ad.15.2025.01.16.16.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 16:56:04 -0800 (PST)
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
Subject: [PATCH] seccomp: passthrough uretprobe systemcall without filtering
Date: Thu, 16 Jan 2025 16:55:39 -0800
Message-ID: <20250117005539.325887-1-eyal.birger@gmail.com>
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

Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
Reported-by: Rafael Buchbinder <rafi@rbk.io>
Link: https://lore.kernel.org/lkml/CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
---

The following reproduction script synthetically demonstrates the problem:

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
 kernel/seccomp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 385d48293a5f..10a55c9b5c18 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1359,6 +1359,11 @@ int __secure_computing(const struct seccomp_data *sd)
 	this_syscall = sd ? sd->nr :
 		syscall_get_nr(current, current_pt_regs());
 
+#ifdef CONFIG_X86_64
+	if (unlikely(this_syscall == __NR_uretprobe) && !in_ia32_syscall())
+		return 0;
+#endif
+
 	switch (mode) {
 	case SECCOMP_MODE_STRICT:
 		__secure_computing_strict(this_syscall);  /* may call do_exit */
-- 
2.43.0


