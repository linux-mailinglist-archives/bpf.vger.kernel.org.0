Return-Path: <bpf+bounces-46907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932B89F1836
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC30E167E5D
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 21:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA95194C86;
	Fri, 13 Dec 2024 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDmEwuRI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C4192D9A;
	Fri, 13 Dec 2024 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734127091; cv=none; b=dvrAGgddiuMToRPFKUaG6jF6GjXLCdtTcPLccWCXJ1xFDo1oxwYIylOwsaNBo/q2M5zgNCtmTU+c2SR4UIHDXY+923bH+83AZvKb7d3G6I0Jyl9a/dPGCLu/HK+LAJoretkyJ/opiHUKP8YWXhLDOEinvxG5BrHXipBsDeSeXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734127091; c=relaxed/simple;
	bh=hrOMY4Mfp1mTyWOapXYYwvWkYv4Al6PgVi1cl3XVRQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pshUsN7Qe/cuTJhbxupKariZvNTnKXGL9MlfsH71s29QZe91nuIyZLzayNmhUTA6kPd/f94+maPDiq5rPakEj0pMoxzdaarvcdwvWYkdFB/6ABkY6VjwUW1AShhgdNvgfPl1cNR02MDUzAFdfxPfoaiyqRzuKsO88Pd6QChmEBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDmEwuRI; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so1947157a91.1;
        Fri, 13 Dec 2024 13:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734127089; x=1734731889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9joODY5IOWuY5Sk7lEDYqOk1qJVMi/mA0wV9LlQ6Ra0=;
        b=mDmEwuRIruDHjYzLvaGoxFeZ/5u2jCQZ4bIyTE986v+WCZ8SANaVD7JGuOQqZBUqsx
         fIfixjQCwWHLT+5Y9vZjELl3dM/N0gPNOMY3WlxERAM/4ReIdlZ9hr35yaRJ+K5Baw7i
         cFJE/jtAfgnlV6oUaAryBLDjM0Y05Ihbp+BDHLTmaLRXqKzdkYHSZ0o+kVttRoaRp51T
         azxXKdAtM0Ytop9BPRptpHjTYAwjn5qQUyoOZTBOYmWEUC+gnlGCJC63HLqQNp0NrLob
         Sa8C+wxHeOrnDYSzbc2e0HNk0q3WJpPP4JmO0q1UlmOfKdM0MgrPmkl8cnaOzbBNakmc
         umOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734127089; x=1734731889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9joODY5IOWuY5Sk7lEDYqOk1qJVMi/mA0wV9LlQ6Ra0=;
        b=u2ngZWEhsJX5RQa78ffAZkudkgZ+hjd7q4KwTkSZY2cPmo08r+RYr7ChAfOUlITV1y
         ehmRRWqoURPNavcYY0oqNOR4BqLEN7popbjzRUgQcAQ8KISf5Ps08eIfq0ip6R7RCBmM
         CapZZZjunLbv7nQsJdF2K8ajvzloU0Xcas8c5qrZyPBa0R0SOnx+HxcBgVJBAqXrhfdF
         t1ype8k3e8eJ+gEbzGp7/Sf1Tmq2wR4anbnDyZ4IpasK3og3aNvncY8wRfEYzvBKSaA3
         3eEQN2z5UBQRzS1q5kpfVQscgk2ydbIf1kTU1Wo3ORbsQtbBsAhg0+CBU3gtsdA73pbc
         1yFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkTPL1esElWip6NvykplJkSJ4AA1ELvt2jrLvCQkFJhhzJnvK3Jf3QKzyBOn2/5+izOrA47HyzuNP/yLpJ0C528W5H@vger.kernel.org, AJvYcCW2Zd8BpMbyQXENQdiRrLBmD9vnQhbJDRIArbHf1+uYLyB+SwAPu8ecLhQvgmTAByE07fk=@vger.kernel.org, AJvYcCWQjNtA6qJOpoob5TMI997/vCgeyyraNZkpBBLE9SFGNENtkmcZUFuOqLuNdij7GnDeIrCLNpsqXsXOXV0B@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyjf4iFNvVSjVcc5oOMe26x7ZiQC+9YFaLoVrrMkCFZJXutGsj
	JJTZGZ/UJejBXynth+9v613hVM7/FQUj5u6XrBb4GMc7RN3O8xfYb2KTiy/qQSiU1i7I8YO+jlZ
	xCIisC7n1t8vLTwK3JhZ/+CasJOU=
X-Gm-Gg: ASbGncstltuG2TSD1Du+zNwha3adeF9aem+HkfGiZf+Cl9MxuA/ZO8CqUAaFd0sSZCX
	MKk5XSJSy+4+aAbwqoIoXopM+piGd+9Z5M50PpKOKvxgU845Zls4q0A==
X-Google-Smtp-Source: AGHT+IFMs/Ib4YLj9SiwztkuJAUnKH/dHadPUJCRlDC35bss40vRZx3h+c+yNCnfOc78z6jahVPjyiIkEik2pwWgL3I=
X-Received: by 2002:a17:90b:2652:b0:2ea:4a6b:79d1 with SMTP id
 98e67ed59e1d1-2f28fb6e8dbmr6322561a91.11.1734127089478; Fri, 13 Dec 2024
 13:58:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211133403.208920-1-jolsa@kernel.org> <20241211133403.208920-14-jolsa@kernel.org>
In-Reply-To: <20241211133403.208920-14-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Dec 2024 13:57:56 -0800
Message-ID: <CAEf4BzZPCdRPyXH1xDed2m3VvNkzzpY33Gbd_vWxivxLZQCdLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 13/13] selftests/bpf: Add 5-byte nop uprobe
 trigger bench
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 5:36=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add 5-byte nop uprobe trigger bench (x86_64 specific) to measure
> uprobes/uretprobes on top of nop5 instruction.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/bench.c           | 12 ++++++
>  .../selftests/bpf/benchs/bench_trigger.c      | 42 +++++++++++++++++++
>  .../selftests/bpf/benchs/run_bench_uprobes.sh |  2 +-
>  3 files changed, 55 insertions(+), 1 deletion(-)
>

[...]

>  static void usetup(bool use_retprobe, bool use_multi, void *target_addr)
>  {
>         size_t uprobe_offset;
> @@ -448,6 +462,28 @@ static void uretprobe_multi_ret_setup(void)
>         usetup(true, true /* use_multi */, &uprobe_target_ret);
>  }
>
> +#ifdef __x86_64__
> +static void uprobe_nop5_setup(void)
> +{
> +       usetup(false, false /* !use_multi */, &uprobe_target_nop5);
> +}
> +
> +static void uretprobe_nop5_setup(void)
> +{
> +       usetup(false, false /* !use_multi */, &uprobe_target_nop5);
> +}

true /* use_retprobe */

that's the problem with bench setup, right?

> +
> +static void uprobe_multi_nop5_setup(void)
> +{
> +       usetup(false, true /* use_multi */, &uprobe_target_nop5);
> +}
> +
> +static void uretprobe_multi_nop5_setup(void)
> +{
> +       usetup(false, true /* use_multi */, &uprobe_target_nop5);
> +}
> +#endif
> +
>  const struct bench bench_trig_syscall_count =3D {
>         .name =3D "trig-syscall-count",
>         .validate =3D trigger_validate,

[...]

