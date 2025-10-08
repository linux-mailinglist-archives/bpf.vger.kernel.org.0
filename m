Return-Path: <bpf+bounces-70595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD1BBC6046
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 18:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CD2935181A
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 16:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B9F291C1E;
	Wed,  8 Oct 2025 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktKijQ2Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EEC10957
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940841; cv=none; b=fXy2lEyrUxAEBXOZnEVW7dxpHq17hMdEHYPT7eyKB2wloV7zgIJA/IMS7d74T7ZzVsuywe1JHijAbadNlJvlJs3H70gohnCPc2rnuH9fkLYX9+FlCMD86uc/l8veLFuAZFadrC4XBKcHJBogUMq0F/7vhltbw97qcQ7DUHBl/Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940841; c=relaxed/simple;
	bh=ESYUvIrXIZf8LOINPbGCLLFX0IwDLy3Yro+8H8/WXj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOQOQOWqnP4OldRkaaYb/B6K/ZE9Ic8JV5Wk9u/F5++RylhesbDLGspT43ok0jMIl8yg5qvogsvbRRgf5jqGJF3eWZsgX726lHtrInrpXnwGYcVLIcsuuzj0bq9V4yihGVO/dD+GJyRs1O5Zhk5jHwPyI0LFbqDJHaay1bq8z6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktKijQ2Z; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e52279279so317405e9.3
        for <bpf@vger.kernel.org>; Wed, 08 Oct 2025 09:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759940838; x=1760545638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMmT0yBvVqJ1w9268h9UX0+UvY7Ypnz5qKgFPlEn+l4=;
        b=ktKijQ2Zz61w+9Nb65gDjpEk7FqIES4Vs7UEtdWcb1yuqrDQmiGLWaU++F5+xO3mL6
         9w8OgLBWH63jLJdGb6AAVn81KE9aExlZ/Z+mU34bAVfb1FpMym95A1KD5msOPDtkya1I
         12//hGl9Xx+eOWhTH7MFL4q+xwtFkijLLzCigSTnYKgztpYfo9xhc04WpfQJLArGLXtv
         Wvl80hcH9mAE4e85d05k2yvtG2/Gq4y+XRFKSP5ktgBy1z3n22QfeND6khI3IezBkZ4N
         TIwvOWXazNv4zqXu1lB/ZpOVUvBItlAvMP6dmQxGaWhYIIeNPiiyN7pHQYwV6iY8d0br
         dHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940838; x=1760545638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMmT0yBvVqJ1w9268h9UX0+UvY7Ypnz5qKgFPlEn+l4=;
        b=qSDd2ZRLsi8D2uArwgAl7RheSXKEb2XIMgOhMnj2PgEUIme7secCBZJ9sbaE0UbxJj
         cDOVVz445ki9QtLPwXh4zReMpZaknOtx/9LGccl3zVG66CumcnTePmQeXg6nMxsC/fmF
         mTRfMdtZs/g1xLefToh9z912oH9n9cU/kn0/L5zxYDIZZOfUFYYUWZMuKih1AfoAbDrL
         Lbx/41km82qXqt9MBtLXwCM+5VJwB3hnaEqINXwokFeBPlYhFYetpgzUjIkR9w04/BbE
         +Y8YcYUI7odR1MbDJ9ezAgUbVINoLxZQVJfyupK9Nhi3eCS2XiSqogmJmBQyDCXuRCOB
         RI3g==
X-Forwarded-Encrypted: i=1; AJvYcCVZ59JUd4Rx98+S9MtETR02y2/xzzvmH2CDCnOEXRQyeuM8jpeUkL1H1ef1lhy/ZzS/nrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGH6EVi5fKAGMwHcBL/+eMn7GCVfR7ZK02Z1SayfrDFMKkCbul
	RHI42/QIyjHB9rKCGaoxjeiuqU7PnbvOd+J4TsPLineaKKPu1X6x8SxqOHDFb7mXnXhoLZiEXfi
	pkxSw7kkvs/Yoxp588ZAFzsnAWkeqzqKLvw==
X-Gm-Gg: ASbGncuOJsLgDbgEpbKhgNDZ5iieIfL1jWydgyWns7JOtcR1E/55x+kf/GaNz8u62SR
	ecb61DU2rATVG//ObMSPFdxWHBsLqp6Zmq6OvSebOhHB9XbspFUVSunsfU2QR3pdSCOFq/XADIX
	Vfk3Ob11Gv9iBcitUg7SLdhjYslGG8rqpT99+SokECfWVI50CwKkxOG7piZn829xz+2eMy82jwX
	Zc01UvdSsjOjn29FGCzOUTjK8un7NjdweixlkFDAwKz7A0/1s+m08EzrA==
X-Google-Smtp-Source: AGHT+IGydoa+Uq4878Yb/9h/myuPsA/hLU+ClnU6wU58PGmdNNA/S+SuciJyS4EWhUfyI1GnU9R2Dc7R6qET/aovPX4=
X-Received: by 2002:a05:6000:1449:b0:425:8559:5d17 with SMTP id
 ffacd0b85a97d-4266e7dfebfmr2645912f8f.30.1759940837904; Wed, 08 Oct 2025
 09:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927061210.194502-1-menglong.dong@linux.dev>
 <20250927061210.194502-2-menglong.dong@linux.dev> <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
 <3571660.QJadu78ljV@7950hx> <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
In-Reply-To: <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Oct 2025 09:27:04 -0700
X-Gm-Features: AS18NWBNt40LsuCSwzLCuqapaMgwYyUIMoVcfLF6Ag31yVFMBDU-uVz2cE-RisI
Message-ID: <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com>
Subject: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault to
 BPF stderr
To: Leon Hwang <hffilwlqm@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 7:41=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wro=
te:
>
>
>
> On 2025/10/7 14:14, Menglong Dong wrote:
> > On 2025/10/2 10:03, Alexei Starovoitov wrote:
> >> On Fri, Sep 26, 2025 at 11:12=E2=80=AFPM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> >>>
> >>> Introduce the function bpf_prog_report_probe_violation(), which is us=
ed
> >>> to report the memory probe fault to the user by the BPF stderr.
> >>>
> >>> Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
>
> [...]
>
> >>
> >> Interesting idea, but the above message is not helpful.
> >> Users cannot decipher a fault_ip within a bpf prog.
> >> It's just a random number.
> >
> > Yeah, I have noticed this too. What useful is the
> > bpf_stream_dump_stack(), which will print the code
> > line that trigger the fault.
> >
> >> But stepping back... just faults are common in tracing.
> >> If we start printing them we will just fill the stream to the max,
> >> but users won't know that the message is there, since no one
> >
> > You are right, we definitely can't output this message
> > to STDERR directly. We can add an extra flag for it, as you
> > said below.
> >
> > Or, maybe we can introduce a enum stream_type, and
> > the users can subscribe what kind of messages they
> > want to receive.
> >
> >> expects it. arena and lock errors are rare and arena faults
> >> were specifically requested by folks who develop progs that use arena.
> >> This one is different. These faults have been around for a long time
> >> and I don't recall people asking for more verbosity.
> >> We can add them with an extra flag specified at prog load time,
> >> but even then. Doesn't feel that useful.
> >
> > Generally speaking, users can do invalid checking before
> > they do the memory reading, such as NULL checking. And
> > the pointer in function arguments that we hook is initialized
> > in most case. So the fault is someting that can be prevented.
> >
> > I have a BPF tools which is writed for 4.X kernel and kprobe
> > based BPF is used. Now I'm planing to migrate it to 6.X kernel
> > and replace bpf_probe_read_kernel() with bpf_core_cast() to
> > obtain better performance. Then I find that I can't check if the
> > memory reading is success, which can lead to potential risk.
> > So my tool will be happy to get such fault event :)
> >
> > Leon suggested to add a global errno for each BPF programs,
> > and I haven't dig deeply on this idea yet.
> >
>
> Yeah, as we discussed, a global errno would be a much more lightweight
> approach for handling such faults.
>
> The idea would look like this:
>
> DEFINE_PER_CPU(int, bpf_errno);
>
> __bpf_kfunc void bpf_errno_clear(void);
> __bpf_kfunc void bpf_errno_set(int errno);
> __bpf_kfunc int bpf_errno_get(void);
>
> When a fault occurs, the kernel can simply call
> 'bpf_errno_set(-EFAULT);'.
>
> If users want to detect whether a fault happened, they can do:
>
> bpf_errno_clear();
> header =3D READ_ONCE(skb->network_header);
> if (header =3D=3D 0 && bpf_errno_get() =3D=3D -EFAULT)
>         /* handle fault */;
>
> This way, users can identify faults immediately and handle them gracefull=
y.
>
> Furthermore, these kfuncs can be inlined by the verifier, so there would
> be no runtime function call overhead.

Interesting idea, but errno as-is doesn't quite fit,
since we only have 2 (or 3 ?) cases without explicit error return:
probe_read_kernel above, arena read, arena write.
I guess we can add may_goto to this set as well.
But in all these cases we'll struggle to find an appropriate errno code,
so it probably should be a custom enum and not called "errno".

