Return-Path: <bpf+bounces-45679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1959DA01C
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 01:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B238283118
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 00:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AE379CF;
	Wed, 27 Nov 2024 00:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnIY1usE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4908F49;
	Wed, 27 Nov 2024 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732668759; cv=none; b=Cg2clysKT5l58nKCpAqnzKhcsFGXug89eecUk1JK2TImIIMqj+PUPtmMEM5ukfSaNFags28SSb3mAjhnKca/PhhPacxmVHn9nSvfx/E0169MglH8pvs1XfuA3ZCd1g/Nmq4Ls5VXkOx3hxHWbU5pLsxo3YWGzHNwAVsOhqn7/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732668759; c=relaxed/simple;
	bh=4PsApXP8sXU7gF8b0yzHPzWru0EeL0tGYpYvBWNvyzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oW/AV3nIFAwuFYjFOIM8SDFrBM9IOc2XrdSrQW3wtAwDZctpqwFMtsbH/+R//R08Y8CkWVT5cNGBLUhfIBB9rsmIpQ33Y8KAlsX8kqIZY4t6XubE5UpveexjiXLpIis6lYh2Qp4LAJDV/+ssPp3omb2TDWbA79mEDiUN+utOlBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnIY1usE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3825a721ae5so170652f8f.1;
        Tue, 26 Nov 2024 16:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732668756; x=1733273556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjRRCxwGmW1KZp8fE5HVHe1CX+qRVInoZebEpE8YP/k=;
        b=PnIY1usEWw4WsAZiQWF5yLfiO5ThGBkYQ8KEqsx0KMU1EperXC5bdUyI5R9IBu4xvm
         5hQSRoB+MEaAa2xPMDxf/4CnGNJE0iNIVBnscYBzFqJY/HS0m2AHCnFrPBt5W1m/xgAg
         NU1HqeGztmGE2iFUqHYORuXKGdzBWR+5chmr+pWZ5d7g0DVdbltfFO4YWqqWvQwjT0xl
         1EDpJ3MoHb8HNTPZLhY0PQ0Znf7zPWZbxGwmqunEdCvSRA1FH9W4fAUpjtvoBwaRf9pp
         m0TKNN+33bJHZLPOpLea8o8SOOZvg0y1YoXaM5ANHK3IJA+138Nt1W0mEF1NXqTf9+yb
         /Qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732668756; x=1733273556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjRRCxwGmW1KZp8fE5HVHe1CX+qRVInoZebEpE8YP/k=;
        b=cLkBqezqwDR2P4J4OY5GhcgD3LdNDAbSvMu8Zi50cY13DALxAKXiALrLiyDg3Td3GO
         iiQXNpOR7ATr+OHEC/nhKhnXOgkK3rjSlpCRR7tiXa6ymfdZes+rilUhjFAL4Gi1G42X
         QMEwYdyHEqtdHV7dcuuqIALgI0JlvkSwHyd6RBE5y0DVwuPyw8TClg0Z+W6smULq7/Gi
         IOaObh89XwfQpFvaFRkfgiNTs7yrxsTaB+bDXHVmIoai6XNUsi8CC1XmYbvqVlv0gjFW
         mMV6H8SRS6mcKQe7x5OZP0vjHMY4fFiVz4ETF4RsSIANluKV7/gObX65PogpsBQn5ufv
         AINw==
X-Forwarded-Encrypted: i=1; AJvYcCVxvJoDbkg/1Ug3ZB8PXlGmF8OKzXWPWsvi72yIJQQBQitLF4uGk2Wk5mRMoCz5+9UcrUI=@vger.kernel.org, AJvYcCWarC2A8c+gRtc1CF9r1Q4n7tRi0+kzVjHSRS0jCnA7Iols+/40Qx4YvrfzSWVQAeM76HLjamgaosJCFcYZ@vger.kernel.org, AJvYcCXWTzTUzY5r+3vcy2KTkSUNkezSNpUC2N0SHz5OCSjVSYqzE9nfUJXOdMoSvngKJL2JSIIy7JUlsfDl8avAiOrGB/Rx@vger.kernel.org
X-Gm-Message-State: AOJu0YzSddwrmYOfBCk3mNELNsmzazI1ckkxxIu2OZT7iX/u4cjSMbUO
	MlzggapFDPwaSxozuMDGLfbWR5NTWsOpPFA3COoogPx5OE3WIJOypYhaKj4Hf1c54pjkA7/+cP+
	JEXJO3lPUxGsbAUEMev3l2kowDAM=
X-Gm-Gg: ASbGncskCcuww7NbLLFU9HE4k8tetaVWFMMOlJn5O38B5o8jvA3T2wfrFY8j5gnypUo
	aRwKVrkYsqBwP43uzcw9vq1niNw+HDQ3iG2ZlfLNUEh3bflI=
X-Google-Smtp-Source: AGHT+IEFnl7xbWyoK0kDCJ0s5pAWZKU6d9diZFfAyXhbRqgI/Td34XdMrFu68OmDsdJi/cvzUi8DIMI4Nb6vJc/O/O8=
X-Received: by 2002:a5d:64c7:0:b0:382:4a92:7943 with SMTP id
 ffacd0b85a97d-385bfb14b71mr4837851f8f.20.1732668755332; Tue, 26 Nov 2024
 16:52:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126165414.1378338-1-elver@google.com> <CAEf4Bzb4D_=zuJrg3PawMOW3KqF8JvJm9SwF81_XHR2+u5hkUg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb4D_=zuJrg3PawMOW3KqF8JvJm9SwF81_XHR2+u5hkUg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Nov 2024 16:52:24 -0800
Message-ID: <CAADnVQLv+iDgH9bAFrEMUCxVBnRGJq1si0W7xsjrd6DZmNkxxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Improve bpf_probe_write_user() warning message
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Marco Elver <elver@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Nikola Grcevski <nikola.grcevski@grafana.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 1:32=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 26, 2024 at 8:54=E2=80=AFAM Marco Elver <elver@google.com> wr=
ote:
> >
> > The warning message for bpf_probe_write_user() was introduced in
> > 96ae52279594 ("bpf: Add bpf_probe_write_user BPF helper to be called in
> > tracers"), with the following in the commit message:
> >
> >     Given this feature is meant for experiments, and it has a risk of
> >     crashing the system, and running programs, we print a warning on
> >     when a proglet that attempts to use this helper is installed,
> >     along with the pid and process name.
> >
> > After 8 years since 96ae52279594, bpf_probe_write_user() has found
> > successful applications beyond experiments [1, 2], with no other good
> > alternatives. Despite its intended purpose for "experiments", that
> > doesn't stop Hyrum's law, and there are likely many more users dependin=
g
> > on this helper: "[..] it does not matter what you promise [..] all
> > observable behaviors of your system will be depended on by somebody."
> >
> > As such, the warning message can be improved:
> >
> > 1. The ominous "helper that may corrupt user memory!" offers no real
> >    benefit, and has been found to lead to confusion where the system
> >    administrator is loading programs with valid use cases.  Remove it.
> >    No information is lost, and administrators who know their system
> >    should not load eBPF programs that use bpf_probe_write_user() know
> >    what they are looking for.
> >
> > 2. If multiple programs with bpf_probe_write_user() are loaded by the
> >    same task/PID consecutively, only print the message once. If another
> >    task loads a program with the helper, the message is printed once
> >    more, and so on. This also makes the need for rate limiting
> >    redundant.
> >
> > 3. Every printk line needs to be concluded with "\n" to be flushed. Wit=
h
> >    the old version the warning message only appeared after any followin=
g
> >    printk. Fix this.
> >
> > Link: https://lore.kernel.org/lkml/20240404190146.1898103-1-elver@googl=
e.com/ [1]
> > Link: https://lore.kernel.org/r/lkml/CAAn3qOUMD81-vxLLfep0H6rRd74ho2Vae=
kdL4HjKq+Y1t9KdXQ@mail.gmail.com/ [2]
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  kernel/trace/bpf_trace.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 630b763e5240..0ead3d66f8db 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -359,11 +359,16 @@ static const struct bpf_func_proto bpf_probe_writ=
e_user_proto =3D {
> >
> >  static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
> >  {
> > +       static pid_t last_warn_pid =3D -1;
> > +
> >         if (!capable(CAP_SYS_ADMIN))
> >                 return NULL;
> >
> > -       pr_warn_ratelimited("%s[%d] is installing a program with bpf_pr=
obe_write_user helper that may corrupt user memory!",
> > -                           current->comm, task_pid_nr(current));
> > +       if (READ_ONCE(last_warn_pid) !=3D task_pid_nr(current)) {
> > +               pr_warn("%s[%d] is installing a program with bpf_probe_=
write_user\n",
> > +                       current->comm, task_pid_nr(current));
> > +               WRITE_ONCE(last_warn_pid, task_pid_nr(current));
> > +       }
>
> should we just drop this warning altogether? After all, we can call
> crash_kexec() without any warnings, if we have the right capabilities.
> bpf_probe_write_user() is much less destructive and at worst will
> cause memory corruption within a single process (assuming
> CAP_SYS_ADMIN, of course). If yes, I think we should drop
> bpf_get_probe_write_proto() function altogether and refactor
> bpf_tracing_func_proto() to have
> bpf_token_capable(CAP_SYS_ADMIN)-guarded section, just like
> bpf_base_func_proto() has.

+1
Let's just remove this warn. It didn't stop anyone from using it so far.

