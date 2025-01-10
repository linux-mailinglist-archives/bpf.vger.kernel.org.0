Return-Path: <bpf+bounces-48565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 692A5A094BD
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 16:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42544188E309
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 15:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B228721147B;
	Fri, 10 Jan 2025 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyC0BBDI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5720DD79;
	Fri, 10 Jan 2025 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736521935; cv=none; b=TjG0oDPOHeYCw4FTUqBO0XCDK3yyFzWVLv8gUMFI7saG3buHH+UlQhKgBiErQK8nLM0LhM4+I6vMnW2kPQT+ZDsI73uAhTNtDuYXTuAqOi3QRmAHIVBltURlKM7FwEBn39rAm+29IKiqRqMzCJ7rXquF2AKwDtaob18jAwbsgmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736521935; c=relaxed/simple;
	bh=N1f/9U4z7PbA8oOWnfO0faxO0cnjZ5tqtYLeviRgBZ8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kumiMZyIuR7WUD0ycgyWVzktcyZmqtXuAfGb9djo9/lu08Mw8adMCBGORe6Ulu2tJlf9o0fzHIJPUI4FGDPHQxr1PDz+KVZdFmlQDWNL419E1x5PrUIM0Oo3cieYKMtjMBXX6jhdaHTRaUVLg/khX7B++qWrd6+9CtBMChWu8m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyC0BBDI; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f2d5b3c094so461788eaf.1;
        Fri, 10 Jan 2025 07:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736521933; x=1737126733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gH3lmLTqri9Ons+gH+WN4kUv5LZv0HAVsUGMvFVX2wQ=;
        b=XyC0BBDI0WsDSDVQfnzV9okBz2KBx3WQFH3I2PVkr1xt2MIF4aM6wgpF4bSjon+5ej
         eL7wuD8N02iUTDA1owRJzUpTz90jE2WWlPIkDLMRgNE175WqbOcRl73JC3rRCYLd1Hxc
         hep3PCDWOCxZ1BSUc0jCXmTCNBbKwPj3dviz71gAMXJjNwbPWaiqRvwExj/PY7dzKv4C
         fzeKAAfR9m0xjZZtXgU6PruXHm46uTfKgz8DbxpMFokgi9WmQRcGZfhUz87BGZYH1Y0F
         +HjHHln+t+QZHi2pNcMe01vIfY7ge/Z4kUOc5mpwZnTqlQG/0fFO2GgCoajML50XMMuL
         LMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736521933; x=1737126733;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gH3lmLTqri9Ons+gH+WN4kUv5LZv0HAVsUGMvFVX2wQ=;
        b=r+8iDoaaPj9kAl4tOwU0VeckQscbzQCuqM6XUC/fxAim63jYFfv+So6N7f6yWjB41l
         jlRb6OcRg6jdAFWH9phEqn+S1XpY/+4N66o8CQa4QbzOEyNQNa2wKLrZdSSqx4p6xcOP
         Ao8UlSI02nUDlYdNCScGtYaEABRNRF0E15CLm2EfAvKevC+2R00Z3CnnnWIgNAvKXtnE
         hOsX8QphZA5Q+lp3KI8aFHeQRJuSMamdJ5NZplRE48vT+O19hwC6RpbWiOLv8R7Nj3ZO
         5jKWAWV1LhDHlq9ZZt+mVmrIe857dhTc7NaMXoheAdmv5xVaiHI77Rqj6aSqOauLOftG
         dA+A==
X-Forwarded-Encrypted: i=1; AJvYcCUBKpLfV7RLQpVBDshjPU9kAsrFpnqgsARrag+rK1lgs/ZP4YQYe0iwv+eBZK+8emkG0odLMW7y9rwGpE3a@vger.kernel.org, AJvYcCV+I7eO0x4s9mHEtCDipOHhsemD9AguvYusNrmklf8thHmm5qMQUVP74Vta2x9c0rh4uwwyqbIS5kOvyKuKBQ+GYoHe@vger.kernel.org, AJvYcCVCOCjbXCMWH44CAc//aOsAuJDktT7D+tJFuSSxsDfebkkx4OXTJOhiXhGpRfzRXAGZdrFMb6i3AyWq@vger.kernel.org, AJvYcCW/g5ZEkUfYe2JLn0RsRFUDicLazWVzfxeZAjBFoukzG0nHBIoXH1KzcJlcUjTk5WCirCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDTeUYkGPO0W3OzjuwoHsuRyxkXWg83WDwrgfhjxKm3AjSgKBj
	E3XSuLN5T+lT9FTHpWm3gtrjqG4qtv9W8qq/LNaHg9Fd9MucQ8FtMp3d6H1JLV5501mNBwhhnCh
	0nskhx4KPklUCJhMTSxAcNW+rxS8=
X-Gm-Gg: ASbGnctN9D+9B8nQzPjlY90D5Zsr7EK+tiSgNPHP4JAxpcYYbpi4IH8Rmeqysy9hfK0
	Jy2L1ycEElVJ7QnDCjDr7fEyn5zV9cKShBi/BDA==
X-Google-Smtp-Source: AGHT+IHJX6hY0eAQy6BVLcqrhQkG6xXjLqjD1snIbj+eS7HYnsWW+fZiU6dEi26xENtEZmYY56T4IR6aCTtQtNtu7Mg=
X-Received: by 2002:a05:6871:aa13:b0:29e:6bdb:e362 with SMTP id
 586e51a60fabf-2aa066d751cmr5569053fac.17.1736521932895; Fri, 10 Jan 2025
 07:12:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eyal Birger <eyal.birger@gmail.com>
Date: Fri, 10 Jan 2025 07:12:02 -0800
X-Gm-Features: AbW1kvbvpEtL4q7Qo5p42lWx573CTzDgXCq--KEjLCX-pSwViQngpRqqL2XI6HM
Message-ID: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
Subject: Crash when attaching uretprobes to processes running in Docker
To: Jiri Olsa <jolsa@kernel.org>
Cc: olsajiri@gmail.com, mhiramat@kernel.org, oleg@redhat.com, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	BPF-dev-list <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org, tglx@linutronix.de, 
	bp@alien8.de, x86@kernel.org, linux-api@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io, 
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

When attaching uretprobes to processes running inside docker, the attached
process is segfaulted when encountering the retprobe. The offending commit
is:

ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")

To my understanding, the reason is that now that uretprobe is a system call,
the default seccomp filters in docker block it as they only allow a specific
set of known syscalls.

This behavior can be reproduced by the below bash script, which works before
this commit.

Reported-by: Rafael Buchbinder <rafi@rbk.io>

Eyal.

--- CODE ---
#!/bin/bash

cat > /tmp/x.c << EOF
#include <stdio.h>
#include <seccomp.h>

char *syscalls[] = {
"write",
"exit_group",
};

__attribute__((noinline)) int probed(void)
{
printf("Probed\n");
return 1;
}

void apply_seccomp_filter(char **syscalls, int num_syscalls)
{
scmp_filter_ctx ctx;

ctx = seccomp_init(SCMP_ACT_ERRNO(1));
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

