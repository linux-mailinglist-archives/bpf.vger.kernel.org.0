Return-Path: <bpf+bounces-52544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F01A4482C
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CBF386817C
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB45B19C543;
	Tue, 25 Feb 2025 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMQfWGp+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DAC199FA2
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503984; cv=none; b=PtHx4dZkeR+RQ550PKYrZl4jKjHPbtERKcdujmjDHqqd2HTBEDRdaYQh08kn1meNxJGL0LorSfKMeLJLkVkkLe/3egvfCOYOoQaM+JyTqs+cejjNQL0GyVv0OKqRM1XQVPNiJtD4oXohfmhU9hb0wKPs6zvzMs+XnB4isuMI+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503984; c=relaxed/simple;
	bh=rRzDH5VwHUbYzNaKz4X7qPAPozuChwn+B5mTuDo9t7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qc9wo5zo4ApwgGv/0b3fXVBiLZz+dwBVWblEFuI0i4u0VKWjq+ESB+ULYQ7kI70o08bmAYHHia2qie1gBoPq20oV/RuflLY9QQ3n8K0N17FyWez50dUJ6/sCjashXkRnxAr8GoTBSgud7YV6MsTCRaV0d1ZOOzU/L4i3RqkmMtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMQfWGp+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso53132a91.0
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 09:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740503981; x=1741108781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AfgbnJpVuARMkT2ZqK6ljnDXLLTHFtPPfWBf9VVHoA=;
        b=fMQfWGp+u/jO+pLqq7jD26YmJkIXI5ZBarV5VTsG58IkyxGK+FgKqAiK74JxsfnjNn
         nQXiywTaCl8iu3FzuL+kfdNDMeSxaURAUoSjDrwRnfy60k8jIrKmJmu1Nkjc1ERMRaO6
         +g7AqetSUazMimgepvpATcXTwPqdFVJHBFL7PzfG0Vn+XfjUJ+C33G2NHsxVZ3xL7CR/
         ebeFvnZKJFHdCBBEGbKLGV1BZ5DFQoCe/cJ0nWRWG8vjyAZgKQkXMGxV89srtnZPSn8D
         T7JYhRJOMfcTNc5MRI3T9c4qL66xZj6hS8ZhA4eGu+NEkY8FAe3D1LIhqLtO8FEyztJt
         keNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740503981; x=1741108781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5AfgbnJpVuARMkT2ZqK6ljnDXLLTHFtPPfWBf9VVHoA=;
        b=SXwn3+xnqdneRpJDw6g69hjGLdDm3nwoMtOKUJeHaonF8an6XUos4Eqm9/WslFatkz
         jkqpd2xhf+0vDiGuKh4XxG3x7dvEntdWr3r/oDQO1ZvC9msi/TPtFZ+nehj9vtByuKZe
         Q7d1ZXqVfx4ZtISW7WWnSpOrtzXXfAIiuAUSjph2ndQTW3NWXi72sxNYyyuW313q+bw8
         e8l9o+J+8a8rr3nQXG0Yu3e8eKF0DlT5f0O6KwxRrhtdwuICLw1AHrM2Ci8JuiBoQTTA
         YT9EY2dpMcNr6GN3NjHgs3sKlsiXwPFjtgvuBzGlijIZ4gvdqKsHGVCjWU9Ddv2shIbK
         0IMA==
X-Forwarded-Encrypted: i=1; AJvYcCWxOaALpAW9SDEE8UOiWpuIXxqj9ewqJVoEOOS0DPKBG8IVhgqLZDnqjFRoCyjdh1ogPho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Ijouo0uR30fwAyb+V+0lLG16fXWN0WsPZQMOkHHslH5yC7Q7
	hAxLzH0BUgZGlyqDbw2O5am/031y/w+ZQNx8Bf9wHXisPWhd0k+aH2W39ECT0C2JUonRZ61FoEo
	QDtG2E/pvJeBKrSAheJK3N9i1LFM=
X-Gm-Gg: ASbGncsx6JAWAQNJec0DinUNDujcIego/chrb+rRugB1B4TYvmfqRu6CdrNqWlXijly
	SKBMNup3tJXJdujffHe3X4eCy0fTlWHvHPziypba+4sv6RvnCrA356t5bI/qHXOR4/FuwVp7QO5
	W0NCqS8tEnO1Yzd1nx8/Y5ElY=
X-Google-Smtp-Source: AGHT+IGdHeehGBhhEEGguVdVY3FRD3dp2xQ4h5X6YYI0HD/5woaJJGQ9El0/tdy0r5JX1hX0jMY2a4Wk02QAYSzbJPs=
X-Received: by 2002:a17:90b:3ec3:b0:2fa:603e:905c with SMTP id
 98e67ed59e1d1-2fccc0f96d4mr37738776a91.2.1740503981103; Tue, 25 Feb 2025
 09:19:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224153352.64689-1-leon.hwang@linux.dev> <20250224153352.64689-3-leon.hwang@linux.dev>
 <CAADnVQKOeKfxL_3tCw1xWNS1CpXz-6pVUG-1UWhZwpPjRy+32A@mail.gmail.com>
 <CAEf4BzaE+sRmnPMN_ePQ1sa7wHuRNn9zktu85Z5=BRyyVEXM=A@mail.gmail.com> <f6a428a0-9016-4c38-b03f-f47504d08826@linux.dev>
In-Reply-To: <f6a428a0-9016-4c38-b03f-f47504d08826@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Feb 2025 09:19:28 -0800
X-Gm-Features: AWEUYZl380CkMLX5jnFF9hZla5Ug-u-zeavoBht2ZSLHjN7p9eDPixH9dfG56Ic
Message-ID: <CAEf4BzYQuX_+sz+0jsD_YHdoH7S4ROja28nhQH4ixzDcyW94PA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Improve error reporting for freplace
 attachment failure
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Eddy Z <eddyz87@gmail.com>, Manjusaka <me@manjusaka.me>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:59=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2025/2/25 06:08, Andrii Nakryiko wrote:
> > On Mon, Feb 24, 2025 at 11:41=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Mon, Feb 24, 2025 at 7:34=E2=80=AFAM Leon Hwang <leon.hwang@linux.d=
ev> wrote:
> >>>
> >>> @@ -3539,7 +3540,7 @@ static int bpf_tracing_prog_attach(struct bpf_p=
rog *prog,
> >>>                  */
> >>>                 struct bpf_attach_target_info tgt_info =3D {};
> >>>
> >>> -               err =3D bpf_check_attach_target(NULL, prog, tgt_prog,=
 btf_id,
> >>> +               err =3D bpf_check_attach_target(log, prog, tgt_prog, =
btf_id,
> >>>                                               &tgt_info);
> >>
> >> I still don't like this uapi addition.
> >>
> >> It only helps a rare corner case of freplace usage:
> >>                 /* If there is no saved target, or the specified targe=
t is
> >>                  * different from the destination specified at load ti=
me, we
> >>                  * need a new trampoline and a check for compatibility
> >>                  */
> >>
> >> If it was useful in more than one case we could consider it,
> >> but uapi addition for a single rare use, is imo wrong trade off.
> >
> > Agreed. I think the idea of verbose log is useful for bpf() syscall,
> > given how complicated some of its conditions are. But it should be
> > done more generically, ideally at syscall (or at least the entire BPF
> > command) level, not for one particular kind of link.
> >
>
> Cool!
>
> But, how can we achieve it?

There is no *elegant* way to do this, but I think we could retrofit
this as extra common bpf_attrs into existing bpf() syscall. Something
along the lines of:

struct bpf_common_attr {
    __u64 log_buf;
    __u32 log_size;
}

#define BPF_COMMON_ATTRS 0x80000000

static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int
size, bpfptr_t uattr_common, unsigned int size_common)
{
    if (cmd & BPF_COMMON_ATTRS) {
        cmd &=3D ~BPF_COMMON_ATTRS;
        /* read out bpf_common_attr from uattr_common */
    }
}


i.e., we add two extra arguments to bpf() syscall, but only look at
them if we have an extra flag set in cmd.

>
> Thanks,
> Leon
>

