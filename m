Return-Path: <bpf+bounces-28901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C858BE9EE
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 18:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2DA1F215A9
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 16:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723EF13D63B;
	Tue,  7 May 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT8ZsJjc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3805B43687;
	Tue,  7 May 2024 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101072; cv=none; b=dGjTdKM8w5XjVSJ/Huam0bqlqusJhMaYAAEKgHRsOnw5s4IaVXgyc0+WxrzTyxG/VjWtiAXQjRdLox0GLlG7wPVY/EKbyjB0btlP0Ayj5+pEv5Sy2u2+PpdH/JRTBkYyoTdNg58itxJoMmTIhrPpHS/zCXG5/7PuNfYhNWec7x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101072; c=relaxed/simple;
	bh=FP0ElEzdfWrFJOFrGuCbCMsFbslobdXDgrTN9rgKL8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pt7sLRFELJohEYrFQjbl70lS+DoSp11lLuwcNjCxwMnMf7XJJ2hjpwN8DQlO7yC4lvJ3rgQDumb9a0FvbyHcLPQja3HQFk7D9C7ApFZzrmM4hO8T7VsPUfwFY2oLrDrce8Zid4uSddH3IzM6w8wKTEBblAyseOBZqyxLOZwBMpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT8ZsJjc; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b432be5cc9so2403268a91.3;
        Tue, 07 May 2024 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715101070; x=1715705870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eE31Eu7TV3EXJzBcDGMth8eM0CNdcvipjciguAMPYxc=;
        b=ZT8ZsJjcYWzhA8r32jk+kosx8TGMaIPyzOmX2wbw/0ezqCrO+v/WX3ldSqd385rpaD
         LXMpU31bForGjTHelp3vddCG7+r0hiExvloDJ8jz48bnQVoC8dD216r9Cz7pQIzJkt29
         FGVM7LbF45Ltd4d+I24RyAnMZ3IUPv7JCRse8yetjaBrkP/SpSUDPeDUpXc8cJ9dChov
         L+O/QxdLwLXh7qMJtR30/Gv2xSaayD9fBDLhWK304dj2fiyOKWf7AM1l/gEKbZ3xM4uu
         /bgaGsq/D4sm8mFEqZv3eCTAGPJtz1Q0F+O1lJ6dM1cRplT7wTgRuD0jvo0bbAF6lUd5
         YlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715101070; x=1715705870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE31Eu7TV3EXJzBcDGMth8eM0CNdcvipjciguAMPYxc=;
        b=deNAfdXU5sTp++f7xTQTFZ+K9A3mR2L7Y2+vO+NJUmpWxEAlpWGaZb/IsCXQBpmivL
         6Be8/tV8z5x3K0iojq8vCv6fhtfTZt3P6UPJC5yWyhDUqr6fJZpM8GsDZzEn0BvxTBb0
         wptGynj9EG3YKrs7WD/QrUW6NYotB3r+XoHFDLzI5RYKkHrfIIEcp/+VW4ehRcFuYvdX
         7NjmuFnt9o4BN2eiINaTGThVDY2ICK+uaZUMdV5Gap5jtosrzcy1max/1bUeVtD0m+SP
         m/ETctZEiIzn8HEiJyPwI/lR/2vkz2/NZOLMIjb862UdRUjkgavINQVLdbjzwWybaCRB
         ZkxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0IPFV9MixY30R+0HGMxfw3Go2bOYnprYZKgQDMxH1XNh8eiLmRk+ppscCVqq0UqcTMhHDG9ZtQS+f6amyxkIfOvU6Vyq9mzojogCtX/tyobcmHoCayhYW4wgrVWwFrqEByChMFXtj2h4f0pDUHMXhV8XA7B29bh25ChGxOcFeMp9rlnVkh4kyNFJGN9ykJ9NTxIGH6DbJyU6HlVHu4YFB6AF25jHjHbLscBjizl2GWE2GXjdSZzVny7hZ
X-Gm-Message-State: AOJu0YxxV7kmX37664ih2r7D1vjLgZNMzE81o3AFxdhk8L8ebE8PThn9
	MV0rPWinFQ6rbRuyMlV3e+ZvJDFP8d4NvfZZG/8twR7vzn+ic/Vi1rZ5pNAkS07v2p+whaVM/7W
	tXWGWjHbVcnjC22LjXukC/+TeeSk=
X-Google-Smtp-Source: AGHT+IFCvOCTLmh+vR5MnBpK3/YRcqFHtkZuMt2ZICN4OeIQqhzuC5AVJClKepVlRCu/ozUA1GJbduUjtNqkOz5da18=
X-Received: by 2002:a17:90a:cf14:b0:2b3:ed2:1a91 with SMTP id
 98e67ed59e1d1-2b616ae2ca0mr110952a91.45.1715101070491; Tue, 07 May 2024
 09:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507105321.71524-1-jolsa@kernel.org> <20240507105321.71524-6-jolsa@kernel.org>
In-Reply-To: <20240507105321.71524-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 7 May 2024 09:57:37 -0700
Message-ID: <CAEf4Bzbb0on_GA3Gnzc09Yy-1H3hAZa+AQ9hyXgvd830cJZS4w@mail.gmail.com>
Subject: Re: [PATCHv5 bpf-next 5/8] selftests/bpf: Add uretprobe syscall call
 from user space test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	Deepak Gupta <debug@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 3:54=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test to verify that when called from outside of the
> trampoline provided by kernel, the uretprobe syscall will cause
> calling process to receive SIGILL signal and the attached bpf
> program is not executed.
>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/uprobe_syscall.c | 95 +++++++++++++++++++
>  .../bpf/progs/uprobe_syscall_executed.c       | 17 ++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_syscall_exec=
uted.c
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 1a50cd35205d..3ef324c2db50 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -7,7 +7,10 @@
>  #include <unistd.h>
>  #include <asm/ptrace.h>
>  #include <linux/compiler.h>
> +#include <linux/stringify.h>
> +#include <sys/wait.h>
>  #include "uprobe_syscall.skel.h"
> +#include "uprobe_syscall_executed.skel.h"
>

[...]

