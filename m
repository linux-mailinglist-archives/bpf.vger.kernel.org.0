Return-Path: <bpf+bounces-41403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7E6996B8A
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC9528414E
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 13:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201851990AD;
	Wed,  9 Oct 2024 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i4qqYEMg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1512B198A39
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479744; cv=none; b=CDmEM8pfUUVxlbqTx5pJ4ZTGxklvoA0urE9AoM23BJH6kbIy3DaaQ6SQTW+KRQC4HRSoskh4jx47hrYGDEG00dLVDbgFCXZvM7QyjWjydlmaCAsatN1p46I2ZCvyzxAG6NcEWag/RzuUWNWQZCkNjpxGInN1Bs0u7/MInOyPSxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479744; c=relaxed/simple;
	bh=QY80xoSul4lqnRdDXy0A4DLg+iqvq8dK629KPoYYwPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NG3fvQLd6mtXCKxC5I6Pp438dbjgmhSTOufHNBYh6p/k/0PK5+oNiRfV8OvN2TY6Qo8ABWs2QJf74gAQIe3C7usPfJNkHo31558oBC6mh5wXJvM94VAthqPeaQk9Q9axw/ENGe0oEn0nECMgiV3wxBODFFs2KM+7O9FMo/A2710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i4qqYEMg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e018dfb5fso298516b3a.2
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728479742; x=1729084542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AezCl3XC5C5GQBLJAx5C4b8m0Qz1+/rCKzT+NVp/CdI=;
        b=i4qqYEMg7qA/q2N5Bsrrj+YFN3aDZSXzt4U3c5c0TLSbc7GZ+cvMFa/l8QicSOSyxt
         du0IxtX8YmSggte1hPizbPzB3P6Z+V3n9rGZ2dqRZPDvebvjlBxRIu3jpQmLUYJcEYyH
         EzQHliJJcHHfoclIGzHtV9tDUoZUxKJw0zIck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728479742; x=1729084542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AezCl3XC5C5GQBLJAx5C4b8m0Qz1+/rCKzT+NVp/CdI=;
        b=VPj+1ysi12Ap1lDWFOZ7o/zQSims3dwRYC6J332nytmImkob5I+feU0cyKL2M2oAos
         +mtTJmm6CMf0SV00bgfILDR/poF2fhvDCh7t8bYYj77+vGMn/QHICDVsyyIATeO4xq/g
         JeBzpfaJjw6B7NfZniOJWD7pGEGJ5X+hKpWeudC4Q3EW1jjmKLbUZMvlRiFN+sHdzot7
         sGcdPNxwaifSxzpPVp5Wxgpnhw/CAJV+Lg26r0YYrALDRGHc4gEe5pCzKiIw43cwpYzK
         3rrPEKH0aJnSQrxm+T+0jFXIyOE9geA2SkhXti9lFO9CjCEA+KJTWTdLmISzD4GwV5Do
         LTKg==
X-Gm-Message-State: AOJu0YwKmADk5Y4bAlDJoUgxyqnHQN9eIwMDGhDbXXkqEJcfv1RUlZNT
	pdrVNox0/lYnYZqrX7IUB0V2OiGMSELlN32nzu26wA7sXx0/+d4EKtFuxbqSlHpdxovPWXp/r4N
	w8wFx23KOAca7KHj/MEQVq3VYZLyCzNB6f+up
X-Google-Smtp-Source: AGHT+IHNYx9w82IwVnkJmInyQL+VZf6dJDDuwIW9e07G4B02vFRRBPiSt5Q1LoEoGbMj4AB5yvwijylwxjuZcRJkAUc=
X-Received: by 2002:a05:6a00:2d83:b0:71e:1499:7461 with SMTP id
 d2e1a72fcca58-71e1dbb86b5mr1682752b3a.4.1728479742454; Wed, 09 Oct 2024
 06:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9679a031-3858-4fef-bb8e-1cf436696095@mail.ru>
In-Reply-To: <9679a031-3858-4fef-bb8e-1cf436696095@mail.ru>
From: Florent Revest <revest@chromium.org>
Date: Wed, 9 Oct 2024 15:15:30 +0200
Message-ID: <CABRcYmL8=3o4T9+2O9Yr5D=qCoGM83mshj92b3H7FokqxspE9A@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix %p% runtime check in bpf_bprintf_prepare
To: Ilya Shchipletsov <rabbelkin@mail.ru>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org, 
	Nikita Marushkin <hfggklm@gmail.com>, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 12:58=E2=80=AFPM Ilya Shchipletsov <rabbelkin@mail.r=
u> wrote:
>
> Fuzzing reports a warning in format_decode()
>
> Please remove unsupported %=EF=BF=BD in format string
> WARNING: CPU: 0 PID: 5091 at lib/vsprintf.c:2680 format_decode+0x1193/0x1=
bb0 lib/vsprintf.c:2680
> Modules linked in:
> CPU: 0 PID: 5091 Comm: syz-executor879 Not tainted 6.10.0-rc1-syzkaller-0=
0021-ge0cce98fe279 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 04/02/2024
> RIP: 0010:format_decode+0x1193/0x1bb0 lib/vsprintf.c:2680
> Call Trace:
>  <TASK>
>  bstr_printf+0x137/0x1210 lib/vsprintf.c:3253
>  ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
>  bpf_trace_printk+0x1a1/0x230 kernel/trace/bpf_trace.c:375
>  bpf_prog_21da1b68f62e1237+0x36/0x41
>  bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
>  __bpf_prog_run include/linux/filter.h:691 [inline]
>  bpf_prog_run include/linux/filter.h:698 [inline]
>  bpf_test_run+0x40b/0x910 net/bpf/test_run.c:425
>  bpf_prog_test_run_skb+0xafa/0x13a0 net/bpf/test_run.c:1066
>  bpf_prog_test_run+0x33c/0x3b0 kernel/bpf/syscall.c:4291
>  __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5705
>  __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The problem occurs when trying to pass %p% at the end of format string,
> which would result in skipping last % and passing invalid format string
> down to format_decode() that would cause warning because of invalid
> character after %.
>
> Fix issue by advancing pointer only if next char is format modifier.
> If next char is null/space/punct, then just accept formatting as is,
> without advancing the pointer.
>
> Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_p=
rintf")
> Co-developed-by: Nikita Marushkin <hfggklm@gmail.com>
> Signed-off-by: Nikita Marushkin <hfggklm@gmail.com>
> Signed-off-by: Ilya Shchipletsov <rabbelkin@mail.ru>

This looks like
https://syzkaller.appspot.com/bug?extid=3De2c932aec5c8a6e1d31c could you
add:

Reported-by: syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com

> ---
>  kernel/bpf/helpers.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index c9e235807cac..bd771d6aacdb 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -892,14 +892,19 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, co=
nst u64 *raw_args,
>                                 goto fmt_str;
>                         }
>
> +                       if (fmt[i + 1] =3D=3D 'K' || fmt[i + 1] =3D=3D 'x=
' ||
> +                           fmt[i + 1] =3D=3D 's' || fmt[i + 1] =3D=3D 'S=
') {
> +                               if (tmp_buf)
> +                                       cur_arg =3D raw_args[num_spec];
> +                               i++;
> +                               goto nocopy_fmt;
> +                       }
> +
>                         if (fmt[i + 1] =3D=3D 0 || isspace(fmt[i + 1]) ||
> -                           ispunct(fmt[i + 1]) || fmt[i + 1] =3D=3D 'K' =
||
> -                           fmt[i + 1] =3D=3D 'x' || fmt[i + 1] =3D=3D 's=
' ||
> -                           fmt[i + 1] =3D=3D 'S') {
> +                           ispunct(fmt[i + 1])) {
>                                 /* just kernel pointers */

Maybe we should duplicate or drop this comment ? The intent there was
to say "we only have to copy from raw_args" which apply to both blocks
now. In hindsight it doesn't seem to be a very useful comment though
so maybe it's not worth keeping around.

>                                 if (tmp_buf)
>                                         cur_arg =3D raw_args[num_spec];
> -                               i++;
>                                 goto nocopy_fmt;
>                         }
>
> --
> 2.43.0
>

Could you extend test_snprintf_negative() in
tools/testing/selftests/bpf/prog_tests/snprintf.c to cover %p% ? FWIW:
This exact same problem already happened in a previous life of this
code https://lkml.kernel.org/netdev/85a08645-453b-78ad-e401-55d2894fa64a@io=
gearbox.net/T/
so it would be interesting to add more thorough test cases to convince
ourselves that everything works well now, like %pB% too or others
maybe ?

Thanks!

