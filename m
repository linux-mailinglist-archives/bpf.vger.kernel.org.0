Return-Path: <bpf+bounces-31260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F588D8B54
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 23:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FEE3B227B7
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 21:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1C613B5A6;
	Mon,  3 Jun 2024 21:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW+zwNn9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09920ED
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449381; cv=none; b=pVw3xXiuW3/KA1h5hTizN2sLSRgOFdj98oKUYRo+0pateMyQG+mdD0UKKUJHiV+2AZ08YuRUdbSUwvHWzy5Tk2RECbCtzyIqttu1iqhwFbt1gBXLJHSAoPkytIlzJRBzmzwRyr8TeavvvrNyxxmsjeJdB0wYm4P06hno4DYa2XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449381; c=relaxed/simple;
	bh=hIx6t0nhYLMHdaO37b8asuLHTkVl5VC2MQxa6fAcbz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwByWLDcOUlG4K0Sqy3dO9I9ogQKwdpRtucL9Z1bSFvt6nX0Dvf271ruQef+kJvd+WfWZvKDXebQ2SFFqmahY7+8ZGBcKyHNOhfu6Piqi4GcKgMejkfyaOZZOCjf0LaE7ET4CLOuWPP++J+DZtKV9zqZ3TIILFXv3c4PGoCn65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW+zwNn9; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-66afccbee0cso3373886a12.1
        for <bpf@vger.kernel.org>; Mon, 03 Jun 2024 14:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717449379; x=1718054179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLZI3X1KE6eJTWWQKNq7hBt6UB9x8TVy8NAM+R20QaY=;
        b=NW+zwNn9ZfgxUVXn24C5oM4nZ4/OoQ6lu9EB8i9pzi3pY4rYA+Nt0p7wYtsEkUc/g/
         WLlD/9tE/NsZWha5wTABstuitabL2GemimBXeiFfB/8SNktDsBoAQNRjXOnsU+P0YvEu
         0MziWjRj45gHCahIPWbLUoXwkniwYZSkoZYSzIIH6SxuOj6dG3VSCKWfaUhsABm9sqmt
         2do198F3ueZPsM1cGuSZCdbliU2OcD0geYryBF3PjpVfuws7OCZoSK4qPOzpDaz0NMcF
         Q6X79D7UdL9SGf/f5H+sp7vvQdQpVlLVg7TwuOTLjNJGI3e8rDIJJMUneq2qSqV1Gsqj
         6wHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717449379; x=1718054179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLZI3X1KE6eJTWWQKNq7hBt6UB9x8TVy8NAM+R20QaY=;
        b=MfGs3M0WlkQ5Ayl31OUsWio8NvVQrAAV6xfzcRjKBVvXI5HEpONzUIQTu7Z/AUkLD0
         NMNtWh9Z1SMHto7dea5YwUI0t7hNswtRoqcEzK4d7K5JTKVLBomqPYSvK+fLNEkqIkfU
         W1R2AZX0Q0FIFE2VBbcFNqJjJgDhnh1yXR1FR1OLJ5YtEdpahcKPCPj+qznnw5yAV5eR
         udG0rkipxfYTsqfUCcoWtq9WUDa9nrDtrq1acuIwA8XC6KXgpoKHB3bmbHwBg6+W2fSF
         ysmtGaKymf85/B+ixrouXew1inmn036IV49kdKZJOlSFmKnhim9DOCc4iJYcJjobdmjR
         119w==
X-Forwarded-Encrypted: i=1; AJvYcCV5AondUyuugnuvHvLKiM4WoW6Z7l47NycweDUU31wECcNs4IvXB7A84mEgaX1Fl6g9H0UDmyVsGiTMHbWpmD2kUkb4
X-Gm-Message-State: AOJu0YwXwz31RGGvHmbiHOVHrWLKhf2cKrVfWBfKfhtX1LNYQN+QbRJ7
	EaDtKWAEq29H1XR/sim5uLwMfAWRpb/3fNHuUtmvcnSK1xHLaQBZhQYVYIQ2lnUkkQTa60j1icn
	6K/8LrIZQMoj7r7xPksCUozI4D/0=
X-Google-Smtp-Source: AGHT+IEN08Y3Hs4Vghg6W2uYSnJc2fHHJaHUrdnqnI/xS1ROsb0sBHaKTFjIqhXLPo9ybLjCwBVicvS/1o6tIY9+EAg=
X-Received: by 2002:a17:90a:5296:b0:2c1:9048:4d95 with SMTP id
 98e67ed59e1d1-2c1dc58edd9mr8856789a91.20.1717449378689; Mon, 03 Jun 2024
 14:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529223239.504241-1-andrii@kernel.org> <Zlg_Wrcj-nN8Gine@gardel-login>
In-Reply-To: <Zlg_Wrcj-nN8Gine@gardel-login>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 3 Jun 2024 14:16:06 -0700
Message-ID: <CAEf4BzZgGhBJSzq_iJxXhKJAuvNBP995WBSAx2VUqM_=NR6bAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: keep FD_CLOEXEC flag when dup()'ing FD
To: Lennart Poettering <lennart@poettering.net>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 1:57=E2=80=AFAM Lennart Poettering
<lennart@poettering.net> wrote:
>
> On Mi, 29.05.24 15:32, Andrii Nakryiko (andrii@kernel.org) wrote:
>
> > Make sure to preserve and/or enforce FD_CLOEXEC flag on duped FDs.
> > Use dup3() with O_CLOEXEC flag for that.
> >
> > Without this fix libbpf effectively clears FD_CLOEXEC flag on each of B=
PF
> > map/prog FD, which is definitely not the right or expected behavior.
>
> Thanks!
>
> lgtm, superficially.

This is now in libbpf v1.4.3 bug fix release ([0])

  [0] https://github.com/libbpf/libbpf/releases/tag/v1.4.3

>
> > Reported-by: Lennart Poettering <lennart@poettering.net>
> > Fixes: bc308d011ab8 ("libbpf: call dup2() syscall directly")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf_internal.h | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_int=
ernal.h
> > index a0dcfb82e455..7e7e686008c6 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -597,13 +597,9 @@ static inline int ensure_good_fd(int fd)
> >       return fd;
> >  }
> >
> > -static inline int sys_dup2(int oldfd, int newfd)
> > +static inline int sys_dup3(int oldfd, int newfd, int flags)
> >  {
> > -#ifdef __NR_dup2
> > -     return syscall(__NR_dup2, oldfd, newfd);
> > -#else
> > -     return syscall(__NR_dup3, oldfd, newfd, 0);
> > -#endif
> > +     return syscall(__NR_dup3, oldfd, newfd, flags);
> >  }
> >
> >  /* Point *fixed_fd* to the same file that *tmp_fd* points to.
> > @@ -614,7 +610,7 @@ static inline int reuse_fd(int fixed_fd, int tmp_fd=
)
> >  {
> >       int err;
> >
> > -     err =3D sys_dup2(tmp_fd, fixed_fd);
> > +     err =3D sys_dup3(tmp_fd, fixed_fd, O_CLOEXEC);
> >       err =3D err < 0 ? -errno : 0;
> >       close(tmp_fd); /* clean up temporary FD */
> >       return err;
> > --
> > 2.43.0
> >
> >
>
> Lennart
>
> --
> Lennart Poettering, Berlin

