Return-Path: <bpf+bounces-48631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9F8A0A54C
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 19:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2032F188A6E6
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 18:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FFA1B5ED0;
	Sat, 11 Jan 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXbk5M+f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354051F16B;
	Sat, 11 Jan 2025 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736620821; cv=none; b=uyizb+51kRwHkHcFYbuMv1je+s1ypO6dygxODJmqPpMY8ryXmWwQAE7zm3NVItSMneVNWzxDh9p2/mOc+GQLnDQNaLxa0zIEo1KHBMlxKPNAiqKvMkHx3urUr4MaZdhc85pcDMQvmdYkmWkmZOPIb7A/5vrS5w+71/QMpkTZdKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736620821; c=relaxed/simple;
	bh=7DdLqMzhTpJW/Tedvh31b4USRvaXV056V3kTLIoVG2c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXQzwuGOmTS9V5OqnVVxPLhxhifH9m3km0MnMD/hhTiTcxZwSWGc2h2jtEHWAp+jIWUKlewPE5jUqZohWqzgsu8bpkHSArZXnXmZCcxU9Tsf3g7f1hnjbu5dLqIuXmRA+dHPRJvUkuXS+svCJ30wW76aMrODXI7gsJn9eJtd3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXbk5M+f; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436a39e4891so21942675e9.1;
        Sat, 11 Jan 2025 10:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736620818; x=1737225618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vRU6IkG5xqviZpog8kuGzgyGQ5yq/o+Edx/mEDzPhfY=;
        b=HXbk5M+fsTAAwUvt5qVy3YoHyBiQLWLuTs3IgxM64dpsYWkiF7KRYaIi131FyYBb3a
         G5Zt2fiDAgwKreGqyRFEwcr93A6F7lqGuvjhkTqKwp0qITppJur+wr68TMNK88XVE1ak
         lo/3cN2fCAIDGc9B+POkkjJMF2+jYr6rppxfcwYZCl5uz5zs3f9IQpQWiz8dED8f7KhN
         rRzthtYOXyHXVSMpky8kxDjAYY44BABaU3vfqpz2n+g7Qm5PnkXR+KPO3AulsyCAV9T2
         W9oIWio4QRNPf8ZN5MFCYKJIk3z/u6DGnHaw86KBppQZlVmEC0gppkJReJFIcGT5tb/B
         zt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736620818; x=1737225618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRU6IkG5xqviZpog8kuGzgyGQ5yq/o+Edx/mEDzPhfY=;
        b=NkRPpU3E0J7YPQUU+BH54lVOJqEheQy1+S9lT8QOqRc8ZXhSOo3+aJTWZyIvoSGSvz
         Kf6Pevf/TzWAbNygxgb22pz2vsMoigWMJwkM0mH6vm2CzFn+rlReJR2dnmfD2GPoQX5E
         g9K4H5jl3+aGWIs1PwDgoiT4wSXkrmKSfVxRzyCXbzLc73an6XQkM3sIX0H1oR7WNrCw
         ZEEqAdHVoYJOukr2KcbIJfa2NoVzdNLpS5CCdVlIKrERfLvyGvllC0fMi0Y+9MA0PmS1
         YiVnCbZ2CPMCRKkcb+Gn2UJsgv+/giE2qX5KcyWjQChPDXqqGxnXjdZ3QFjLG6NrjCAM
         hjhA==
X-Forwarded-Encrypted: i=1; AJvYcCUd6DxrEQe2cl26iGLLYf+iqPtCYGX/31qaWvIgwO5tGKdVSls9NhBFNV0K+V5oYXjSloiwyN/yaZ7gP8iQ@vger.kernel.org, AJvYcCV9geo6GknTIppyET9Q5GaQj60jMOqzBHX2D1D+724NQd0Npko9FC/45VbFlSzEGoQpiZHC9pu0p71+ZriARgPA6dK8@vger.kernel.org, AJvYcCVDSCF3QSXjxXT1E0vhLPGwhs8hP0zqtxvuRV6MaaE3p5PgaDo8pyQSuUyKeelrqIxM02g=@vger.kernel.org, AJvYcCWFHjbZZwZT5Kdo//BgHqfibq0PgpHiZS3XUQgG3WvwVRO8JZ80O13TI/sC8Muq1QQcTOZOqOQPnP7/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+rI2i4JFO0Cw8BXXbj4hTMlEbUWIt0Of7SKGeH4k+f2cVObU
	RYiAWg+WDjkiblx21xOYhhQbKmYc1UZ8HRGSC96Ms0m1YQ8u0JIc
X-Gm-Gg: ASbGncsEpinOrMHp8nAznW8OFxCfQFdJYsuCR12m3ck3apDA7tuWSloCllNA3GCSpnt
	3YwV1S0h33KI6CGSuyBjVzPRwA+kRZz7NITthP36K+j2Sha+PM6VXnwQXMHvnyG1aOe8PvqGXrS
	2gTSwS9NAYR95kP9G6fx+f6Nl9Z8wt1zTkid+viwksVhBi6lFZOKkHdOOM59wDM29+GUbXJHPZE
	yk47ovdzjCJml08zfFaQH2i/q2HtxYUNFQBvLbOb7g=
X-Google-Smtp-Source: AGHT+IHPbxB34Z6ANoOJIDCWUBTh+3epyhf4nGI+8yF/HEI8u4kppeSeWkZ9l+ORgztBkJ+Nif1PjA==
X-Received: by 2002:a5d:47a3:0:b0:38a:4184:2510 with SMTP id ffacd0b85a97d-38a872db629mr15346290f8f.23.1736620818193;
        Sat, 11 Jan 2025 10:40:18 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e8bea5sm123979515e9.31.2025.01.11.10.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 10:40:17 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 11 Jan 2025 19:40:15 +0100
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Eyal Birger <eyal.birger@gmail.com>, olsajiri@gmail.com,
	mhiramat@kernel.org, oleg@redhat.com,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <Z4K7D10rjuVeRCKq@krava>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>

On Sat, Jan 11, 2025 at 02:25:37AM +1100, Aleksa Sarai wrote:
> On 2025-01-10, Eyal Birger <eyal.birger@gmail.com> wrote:
> > Hi,
> > 
> > When attaching uretprobes to processes running inside docker, the attached
> > process is segfaulted when encountering the retprobe. The offending commit
> > is:
> > 
> > ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
> > 
> > To my understanding, the reason is that now that uretprobe is a system call,
> > the default seccomp filters in docker block it as they only allow a specific
> > set of known syscalls.
> 
> FWIW, the default seccomp profile of Docker _should_ return -ENOSYS for
> uretprobe (runc has a bunch of ugly logic to try to guarantee this if
> Docker hasn't updated their profile to include it). Though I guess that
> isn't sufficient for the magic that uretprobe(2) does...
> 
> > This behavior can be reproduced by the below bash script, which works before
> > this commit.
> > 
> > Reported-by: Rafael Buchbinder <rafi@rbk.io>

hi,
nice ;-) thanks for the report, the problem seems to be that uretprobe syscall
is blocked and uretprobe trampoline does not expect that

I think we could add code to the uretprobe trampoline to detect this and
execute standard int3 as fallback to process uretprobe, I'm checking on that

jirka


> > 
> > Eyal.
> > 
> > --- CODE ---
> > #!/bin/bash
> > 
> > cat > /tmp/x.c << EOF
> > #include <stdio.h>
> > #include <seccomp.h>
> > 
> > char *syscalls[] = {
> > "write",
> > "exit_group",
> > };
> > 
> > __attribute__((noinline)) int probed(void)
> > {
> > printf("Probed\n");
> > return 1;
> > }
> > 
> > void apply_seccomp_filter(char **syscalls, int num_syscalls)
> > {
> > scmp_filter_ctx ctx;
> > 
> > ctx = seccomp_init(SCMP_ACT_ERRNO(1));
> > for (int i = 0; i < num_syscalls; i++) {
> > seccomp_rule_add(ctx, SCMP_ACT_ALLOW,
> > seccomp_syscall_resolve_name(syscalls[i]), 0);
> > }
> > seccomp_load(ctx);
> > seccomp_release(ctx);
> > }
> > 
> > int main(int argc, char *argv[])
> > {
> > int num_syscalls = sizeof(syscalls) / sizeof(syscalls[0]);
> > 
> > apply_seccomp_filter(syscalls, num_syscalls);
> > 
> > probed();
> > 
> > return 0;
> > }
> > EOF
> > 
> > cat > /tmp/trace.bt << EOF
> > uretprobe:/tmp/x:probed
> > {
> >     printf("ret=%d\n", retval);
> > }
> > EOF
> > 
> > gcc -o /tmp/x /tmp/x.c -lseccomp
> > 
> > /usr/bin/bpftrace /tmp/trace.bt &
> > 
> > sleep 5 # wait for uretprobe attach
> > /tmp/x
> > 
> > pkill bpftrace
> > 
> > rm /tmp/x /tmp/x.c /tmp/trace.bt
> > 
> 
> -- 
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> https://www.cyphar.com/



