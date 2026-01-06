Return-Path: <bpf+bounces-77918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92940CF6960
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 04:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C39F300766A
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 03:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3791DE8BB;
	Tue,  6 Jan 2026 03:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmJJxaFS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2360E84039
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 03:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767669321; cv=none; b=SUb2rvNThVlQHjLSKVC+907l0XGbyZiouXS5nYM6uIKIqXhBewWBWCt8rKgPPZm5zD8l7J4E6kZkvo+G/yUaPW43TCOXLt/O5yKuTqYhvRDvaMLybdx8J+x+piFnIr3gGwstjOymDsOPadgOtV4w/qsmK+OisqykzzgzcuGNolQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767669321; c=relaxed/simple;
	bh=+vJahxz5pYf8/Mk9gfXgs9KCnc9YI1E69LLVN+egx64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7QYk+CT2o1EVovgB9Xyzoi2h/IYbIAcgO1QJNc+VG63/b54WS9Fs05K20Oddf4vWbKSfGPFTEGmc3NNg43Cttgglk6MBO4L90zuNIwK43OrJYUod5/7oKn3u7zsSXnlAz7GO2GkNMeTme+KCjRarN2CKDOpIY5GbhpcPXWucmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmJJxaFS; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3e8f418e051so400399fac.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 19:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767669319; x=1768274119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUCGE8kHZlFfkm0lZ7/QOyq8NtkcJZN8VMWhJTlQlSU=;
        b=kmJJxaFSSnlCnhcwYiAWvX4zKwz8q0nnrBqg0pZwYJVWV0PdEBbtixxCNn8krfEn57
         7xx00BgxMFPo82ws6WjnEdcP/RYitd2gpkKxq+/sQvRw/xpa7d4a3M/owsymU8bBZrgx
         uEq7D4Pzue+EJn+dASHKE77qjotu1GAj5B+M1GD0nzkeQspdt+5rpna0y6k4+tg4Hrbe
         mgct2ZvzKip0/BmpzibaTOXIokvQRmSjY8JKqYecH0+tDtYewK6wrd/OOZZHfLZi6zC/
         v1+hNHS5EZLEQrI4FKpaldPmUqjrzyiQiA2+p7iSdkbJccUFRqvYxUiZacyYnKG/mCvg
         X6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767669319; x=1768274119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UUCGE8kHZlFfkm0lZ7/QOyq8NtkcJZN8VMWhJTlQlSU=;
        b=RXY4uy+b0qXGgX8ue1WBipT8d4uFCwuFyEP8TS7/2Uzgx0oisAJOduhTL0U72L9eCa
         C7ZzQwNNxbdFmIDr/s5dtcDI0pPqNpK6ElKXQ1e8ofnSSs78gwRpAP9kYXvc6wSdWGPw
         udh1ywcUmaqQ1Ud6+hFGjn8TiE8jNn3tiKNQOStnda0jZNTLHPHWwQvvwGLPmnm2S/UG
         6hRrjf0cGeJe9fdZpDsiOEoSF5r5bfOogXIbLhJyFbybKwShHrI2UiIWd0OD3qcZKuQQ
         W1dLoo+5mV+Ty+mhoehiEt9p8b5N7UjdV5nycVk3jNPPMeLkIDmPj39X7jAOB4T9SRlX
         x5aQ==
X-Gm-Message-State: AOJu0YwMEmr2F6LHy6b51hzFePYqsWLaM1X2JMWzgnyI/ScZmX8nuoLX
	FNjdDCNKX2nBXVQHldjJTm+x3sG9/T229D95gwmWaAO5Ym4jVj8P/Uv2V+Xa+aHDv6f7X8EfyT4
	6YTBGJjIQ6c0H6wExVfcNcoZ9Mkf/7LND1o6HMxHeBoG/
X-Gm-Gg: AY/fxX7CyDj91gEBtg7dg1wfhkBO00oM4OGdcYU3VZb2LJ7eGBZsCdzYmYFaDObYbDJ
	4gd4mKkAAb8VBIwDARVZqKrT/tI5WlvJbMbYr/H5LOsGFZSGYGxyXcX6z8qIo401Csi4MkiaXdB
	3Fcix8H8glfmdVjRabB1ebbuQPAc803//CpeGrb5cg6XnJ4+nJ69QvJpQy1SqtzfOlFn5GQ7z8N
	iXOsGddVEimIKfHv/nKmWQv+DwngESRor7JgomLgWxuOKotDDNm0/1u3jXd4yCECOfLKuDV
X-Google-Smtp-Source: AGHT+IF+9HKua83BozViFs/5nLL9RQOL+ZNxVs3tv3bf2LrejVq54O4ap2lb7+/aUxQ3kcu5BMyGoDqLluOyjDTblNs=
X-Received: by 2002:a05:6820:1503:b0:659:9a49:9016 with SMTP id
 006d021491bc7-65f47a50047mr1027992eaf.67.1767669318811; Mon, 05 Jan 2026
 19:15:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADNPQri-onx+S+PqHKsOJwgwRKT6YBPyBt+U1hkDKgUr=05sPw@mail.gmail.com>
 <CAEf4BzY8gDnZCNCGL=_hXXNwXkJmHdaJ8acFFrwU=Lm5Ht6FEA@mail.gmail.com>
In-Reply-To: <CAEf4BzY8gDnZCNCGL=_hXXNwXkJmHdaJ8acFFrwU=Lm5Ht6FEA@mail.gmail.com>
From: Hui Fei <feihui.ustc@gmail.com>
Date: Tue, 6 Jan 2026 11:15:07 +0800
X-Gm-Features: AQt7F2o1P-MjcHzRj9xLMQk36tdqc7qoQo8rnr6ff6LoHk901eJ4DHlf7t9o_L0
Message-ID: <CADNPQrjk0-38ke6Nq31Xyhb=yNJuZd0=ZhRfPC1B-A11HmshAQ@mail.gmail.com>
Subject: Re: [BUG] bpf/verifier: kernel crash in is_state_visited() during
 bpf_prog_load (5.4.139 elrepo)
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, 
	songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrii,
Thanks for your help, I will check it.

Andrii Nakryiko <andrii.nakryiko@gmail.com> =E4=BA=8E2026=E5=B9=B41=E6=9C=
=886=E6=97=A5=E5=91=A8=E4=BA=8C 05:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Jan 4, 2026 at 2:01=E2=80=AFAM Hui Fei <feihui.ustc@gmail.com> wr=
ote:
> >
> > Hi BPF folks,
> >
> > Sorry, please ignore the previous email. I forgot to disable HTML
> > formatting. I=E2=80=99m resending the message in plain text.
> >
> > We hit a kernel crash while loading/using BPF programs. The crash happe=
ns in the
> > BPF verifier path during bpf_prog_load() and takes down the server.
> >
> > Kernel:
> >   5.4.139-1.el7.elrepo.x86_64 #1 SMP Sat Aug 7 08:29:46 EDT 2021
> >   x86_64 GNU/Linux
> >
> > Hardware:
> >   KAYTUS KR4276-X2-A0-R0-00, BIOS 06.07.00 (10/14/2024)
> >   processor : 63
> >   vendor_id : GenuineIntel
> >   cpu family : 6
> >   model : 143
> >   model name : Intel(R) Xeon(R) Gold 5416S
> >
> > Workload:
> >   - BPF is used by: parca-agent which is a profiling tool
> >
> > Crash / oops (key parts):
> >   BUG: unable to handle page fault for address: 00000e4900000e48
> >   #PF: supervisor read access in kernel mode
> >   RIP: __kmalloc_track_caller+0xa6/0x270
> >   ...
> >   Call Trace:
> >     push_jmp_history.isra.0+0x3e/0x80
> >     krealloc+0x84/0xb0
> >     push_jmp_history.isra.0+0x3e/0x80
> >     is_state_visited+0x48b/0x930
> >     do_check+0x136/0x15a0
> >     bpf_check+0x357/0x1440
> >     bpf_prog_load+0x3fd/0x6f0
> >     __do_sys_bpf+0x16a/0x11c0
> >     __x64_sys_bpf+0x1a/0x20
> >     entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >   CR2: 00000e4900000e48
> >
> > Tainted: G        W         5.4.139-1.el7.elrepo.x86_64
> >
> > We can provide:
> >   - full dmesg around the crash
> >   - the BPF program / verifier log (if you tell us which knobs you want=
)
> >   - a vmcore if needed
> >
> > Questions:
> >   1) Is this a known issue in 5.4.y verifier (is_state_visited /
> > push_jmp_history)?
>
> 5.4 is quite old, no one will remember by now. But we did have some
> fixes for push_jmp_history, which all should be in the bpf tree. Can
> you check git blame and see if there are any relevant commits in that
> area?
>
> >   2) What additional info would be most useful to collect (verifier
> > logs, config,
> >      reproducer, etc.) to narrow this down?
> >   3) Any workaround to avoid the crash?
> >
> > Thanks,
> > Hui Fei
> >

