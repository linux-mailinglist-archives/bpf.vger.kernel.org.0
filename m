Return-Path: <bpf+bounces-34675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB44993007B
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 20:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F521F23FEF
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 18:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886131BDC8;
	Fri, 12 Jul 2024 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOrHni/0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2DD1B964;
	Fri, 12 Jul 2024 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720808865; cv=none; b=CjvT6Xyr42V/gUJlzBr/qaRnbsAh2Irf3Qk1ulZcqXVM31VSEAxHELZadcDV4payesZlqnIlbi9TeqqWy+nm6/YQAL2lXR8I9KOqyKBGeEMcF16hlcnnbbI691QZShxlGzlwW/lG8TbvO5gIvMVSaFg4CKYCWXfXf6wdOuGveMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720808865; c=relaxed/simple;
	bh=iwsBykJTfwtEHmY1cRlF9Ks9CabeLpmZUbIc6lAapJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rqr1UGVLhVFjQ97NljxS92dBj4QFzdrBCdgshwcoPZ1pVeLlLNmAjWu9GUjXkUZYfK88UL6Xk5SfYrbB/vZ+gxcyMqvTxJouSA8fV8sj+c7sQW7UNo1PJy32Hv43eXltQd/Fdrf81aZRBJTEuRMGVKBHD5t02rDt9GDW3MpGHGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOrHni/0; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c9a10728abso1790891a91.0;
        Fri, 12 Jul 2024 11:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720808863; x=1721413663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6y/+mRSgdTXCwfuZp4ON2SVKhMv+FKJLXV4Rynx6Hs=;
        b=SOrHni/0AMylrBKydwyo4gT8fsLyofaZxsGQD7JPXE0wdkh/AoAoY50qH+FLFqoA7U
         0iJE9yY39+Dsm/qQyIOAHUDnOqCVIm3Nyehzvycq/qjA02HHrb2JiLzTaND2s/BvNUQ5
         wzY6YliauQzDOCfdV+NqoLJ8lyFiqGGZcC8xHfG0u61P/0KIpbPtRamnC1lxRT900vta
         MbHOxEZJVe7mMNjgeGMtJeSWoliP7doJzS5rhEgHhOV4tEuGQpbsejxGqLv5iuFRqEdy
         i+pHH1NCDlJgStIydXSm4u45pI1mbR32gcOfZAbIIO4yb9U3povAVa9Fy86pF1LS7ZO7
         +yAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720808863; x=1721413663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6y/+mRSgdTXCwfuZp4ON2SVKhMv+FKJLXV4Rynx6Hs=;
        b=qrrPUwU1cupnY2jPTJkRQzhSVWXvDo9aVVnO3RL2ZEQEb3uLYIq1Dbtrqn0OMW7697
         Buw0QxGaGIa01bRC0g+X87CNF41KZqpy29nww66jdSCdJGfi5D7HqgIec+w7iwICkpFb
         xOWvrdgEnQcBY1qo9Q/YP3uhwraDnH2Ssa+8Cki4+NHdSAcULdts+ytCqsvUdBFTZjNF
         BUG07zvCjyBMzE15AlDg5Y0+OvqtGnBxTqNTZP87dITVbzqxQm+DmFsuJeMpJFLi3/vH
         glDO7k6d5C+cAvXi4x/nY65WfHD8QIUt9+2v4zF7+M0IAVYvJiZTkAA/ySSASud8HDWd
         3mTA==
X-Forwarded-Encrypted: i=1; AJvYcCX4Ww0uv1rdspNBVnk10ec9SP4N0d2AZVz/sPoIME65A6DDi8Q/fFHZeGdxjfJxCO7kArAYF9z+OtDBIMtOyEaYmh3lC9IMQNWqdfuvjwODfcGi0a4j/1w5L2huLrKX6DGjM+0s7PzzXa1r42DkL+HXXccZc+fHWRuaT2ksvdKaPbAHSYM54ANTXfM2c6QZKmD7qAxeMObAxppq2COYwCHN
X-Gm-Message-State: AOJu0Yz6dVCjF6sbg+VoQVysB9CF/6g4OItIZtdbHpp8D/0iFKLC4gbV
	ctb/LnmIuvu+Z7vYiWuhFNBP+2FHqw1tBAdM3YlqgbJ2YMs9qVGL1t7A5zcQlr+dkseUSabjvUD
	+Yc7zHa6csh0FRKqovs28WMznsAA=
X-Google-Smtp-Source: AGHT+IEgPvVUeUuSA/CFzcUIMNoQSffZuPeFhoBZLglEOIBkRC4i01xNCVM817RR+WIaf0eumMJMhcZMKgX3FoAPWwA=
X-Received: by 2002:a17:90b:3ccd:b0:2c9:6f03:6fd6 with SMTP id
 98e67ed59e1d1-2ca35c2e8ddmr9595383a91.17.1720808862979; Fri, 12 Jul 2024
 11:27:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712135228.1619332-1-jolsa@kernel.org> <20240712135228.1619332-3-jolsa@kernel.org>
In-Reply-To: <20240712135228.1619332-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 12 Jul 2024 11:27:30 -0700
Message-ID: <CAEf4BzY3Xo-g02r9TY9tHq49JLrrYoUNoXN=WXhJ02q4xUbGbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/bpf: Change uretprobe syscall number in
 uprobe_syscall test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	bpf@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Deepak Gupta <debug@rivosinc.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 6:53=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Fixing the syscall number value.
>
> Fixes: 9e7f74e64ae5 ("selftests/bpf: Add uretprobe syscall call from user=
 space test")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

is this selftest in probes/for-next already? If yes, I'd combine these
two patches to avoid any bisection problems

but either way

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index c8517c8f5313..bd8c75b620c2 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -216,7 +216,7 @@ static void test_uretprobe_regs_change(void)
>  }
>
>  #ifndef __NR_uretprobe
> -#define __NR_uretprobe 463
> +#define __NR_uretprobe 467
>  #endif
>
>  __naked unsigned long uretprobe_syscall_call_1(void)
> --
> 2.45.2
>

