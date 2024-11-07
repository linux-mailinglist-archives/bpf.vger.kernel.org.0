Return-Path: <bpf+bounces-44250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A2D9C0AB3
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98155B22206
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBA0213132;
	Thu,  7 Nov 2024 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWihIlVX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BF820FAAB
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 16:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995428; cv=none; b=pgArh6vXZT7OscDdf9kSkG860XSZVKS7aar8AEm0hIvmsp11w1ChXfF5TB49Ral7GrN5r66iVb915v94G0s8EmY2yThaE3yTnB1CA3Po3/eeDFIEDhut85DtUMzrZauToCadiAqY1BMZ2u3NxjszTADVrpUpQ0XrdSXHHRJVJV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995428; c=relaxed/simple;
	bh=DDhuRttTMdP+BfSvUowmngf/Tltu98lGAIMGNwI6Uu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hDErYCN4hOP5ltT1DfDFYLvy0wNUZhoS1R1Mh87Z8zIxbaGSD/il1DI4iPwOby6a3wMZAYtnYbQBl3RtKHJwhPCC9aCdRMyGDkxqe06Sy131sbWu3bJ8rX8cR2Tnq/Gvu+W1U2yuKf7bafsNrSsC486WIQSciZQOw5aYhmBSgTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWihIlVX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ce65c8e13so12967845ad.1
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2024 08:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730995426; x=1731600226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6q0LhvpuL9/8Hyfc05HCzRTvQ4bGlTTg7SP7RmTzlc=;
        b=cWihIlVX4QsFpUw6/TnFNyCgtgLRSbOOOs84K/t+D4NBIQVI06oYDxhMjlH7lPFnh4
         wTBXNaLPm6dlhRehgWvN+EShfjLL6yTU4R1r7dyz9VvNM6EXW+obMUjrkg/2Qh+Vzp+a
         tHLWxjt0gzUXKT7bcPZkNVs2/qBwNNMpN1Nj2hhVmEsBjx56lAgKfFJZiYxIFBteBZ5/
         SKVj/9SZ6m+74fdIHaTAxTs8gju/TSqjapc7B+oZFNYGdK/a9CxjcH3YatFU1zhdFlRz
         otuevmwyl2+Vlbhyh7gyDd+UKZ/cRikAyWPa9NT7B8vMrCR9ZaT3BOYJFqEvB+K8wM0k
         /1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730995426; x=1731600226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6q0LhvpuL9/8Hyfc05HCzRTvQ4bGlTTg7SP7RmTzlc=;
        b=nryTE/2Td23wx89QjPX9gKixjFIpIh7gaurASwPVPCJ4UxQm0FbSrDNbp2q4CVaM6J
         FDUXO6LWT3q9UxWc8syTHWniR2bZ7rhIakyc4Qe2v+mPUu43ed9nwDeGOsVoyv9Hihw1
         +YUneDMSa1ZXkQO2iAlNLLjUWKfKJuYJ3gmHkFR3mZzCyBs6zY6YPqr7SpJoUL24UwXO
         K3lWTBuSOkdcifB8ZHtNAG0qTViahl7cG6Jp+uDzWRe4lhM1jUrA3cmzQ3qfTxw6LFav
         XcPNK0usWUBisYus83Y16fp/5iwNcSBZR8vjq5fQQ2OIAE9IJsR7XoUE94RlA6sghS8G
         2iHA==
X-Gm-Message-State: AOJu0YzgOX8IjR8oZvgcgiIlAYu+vG2IOgKC/lnpoME9WIj7kTVceXIv
	vemg/bmypcuGGEhqnBEM3Q+q7VcIMj/oT0LabOy+4eQYkM0EGM/gq5ZOIyLnXQX5tdBdTT3z38X
	muWM9Bud0xler9bvbMkxbreqspj4=
X-Google-Smtp-Source: AGHT+IECmtHzk7keGXaP0NQpddZ+dfFGmJcNQNHYKivzRfPiAMVBeQMhWDWpr3EgHTfk8Ug6f4TXW+Pmw7zTYhsrM8k=
X-Received: by 2002:a17:90b:28c5:b0:2e2:e4d3:3401 with SMTP id
 98e67ed59e1d1-2e9af9d63bemr670013a91.20.1730995426348; Thu, 07 Nov 2024
 08:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104170048.1158254-1-mykyta.yatsenko5@gmail.com>
 <CAEf4BzbB_PuJOKq-QuuS8ztBcAaMEZT3bte0QavXze2HT=2epA@mail.gmail.com> <0e4dd72d-ac35-4c26-9ed9-9da32046eac9@gmail.com>
In-Reply-To: <0e4dd72d-ac35-4c26-9ed9-9da32046eac9@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 7 Nov 2024 08:03:33 -0800
Message-ID: <CAEf4BzYDSKMc4Wyw5p6EgA2=CT6FnLA9bPF_eUUgH=r_Wc2Jhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: stringify error codes in warning messages
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 5:40=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 07/11/2024 00:39, Andrii Nakryiko wrote:
> > On Mon, Nov 4, 2024 at 9:01=E2=80=AFAM Mykyta Yatsenko
> > <mykyta.yatsenko5@gmail.com> wrote:
> >> From: Mykyta Yatsenko <yatsenko@meta.com>
> >>
> >> Libbpf may report error in 2 ways:
> >>   1. Numeric errno
> >>   2. Errno's text representation, returned by strerror
> >> Both ways may be confusing for users: numeric code requires people to
> >> know how to find its meaning and strerror may be too generic and
> >> unclear.
> >>
> >> This patch modifies libbpf error reporting by swapping numeric codes a=
nd
> >> strerror with the standard short error name, for example:
> >> "failed to attach: -22" becomes "failed to attach: EINVAL".
> >>
> >> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> >> ---
> >>   tools/lib/bpf/libbpf.c | 429 ++++++++++++++++++++++-----------------=
--
> > We have use cases for strerr() in all of libbpf .c files, let's do the
> > conversion there as well. But I'd probably split adding strerr()
> > helper into first separate patch, and then would do the rest of
> > conversions in either one gigantic patch or split into some logical
> > groups of a few .c files (like, linker.c separate from libbpf.c,
> > separate from bpf.c, if we have any strerr() uses there). We have tons
> > of error message prints :)
> >
> > pw-bot: cr
> >
> >>   1 file changed, 231 insertions(+), 198 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >> index 711173acbcef..26608d8585ec 100644
> >> --- a/tools/lib/bpf/libbpf.c
> >> +++ b/tools/lib/bpf/libbpf.c
> >> @@ -336,6 +336,83 @@ static inline __u64 ptr_to_u64(const void *ptr)
> >>          return (__u64) (unsigned long) ptr;
> >>   }
> >>
> >> +/*
> >> + ** string returned from errstr() is invalidated upon the next call
> >> + */
> > keep it as single-line comment, but if you needed multi-line, it
> > should be formatted like so:
> >
> > /*
> >   * blah blah blah lorem ipsum
> >   */
> >
> >> +static const char *errstr(int err)
> > let's move this function into str_error.c, it doesn't have to live in
> > already huge libbpf.c (and you'll need to "expose" it in str_error.h
> > to use from not just libbpf.c anyways)
> >
> >> +{
> >> +       static __thread char buf[11];
> > nit: make it buf[12] to technically handle "-2000000000" ?
> >
> >> +       const char *str;
> >> +       bool neg;
> >> +
> >> +       if (err < 0) {
> >> +               err =3D -err;
> >> +               neg =3D true;
> >> +       }
> > honestly, thinking about this a bit more, I think it's ok to always
> > emit negative error in the buffer (because that's what it should
> > always be, at least when this is used internally in libbpf).
> >
> > So let's have, just:
> >
> > if (err > 0)
> >      err =3D -err;
> >
> > to make it explicit that negative error is the common/expected way
> >
> >
> >> +
> >> +       switch (err) {
> >> +       case EINVAL:
> >> +               str =3D "-EINVAL"; break;
> > then for all of these we can have a nice and compact style:
> >
> > case -EINVAL: return "-EINVAL";
> > case -EPERM: return "-PERM";
> >
> >> +       case EPERM:
> >> +               str =3D "-EPERM"; break;
> >> +       case ENOMEM:
> >> +               str =3D "-ENOMEM"; break;
> >> +       case ENOENT:
> >> +               str =3D "-ENOENT"; break;
> >> +       case E2BIG:
> >> +               str =3D "-E2BIG"; break;
> >> +       case EEXIST:
> >> +               str =3D "-EEXIST"; break;
> >> +       case EFAULT:
> >> +               str =3D "-EFAULT"; break;
> >> +       case ENOSPC:
> >> +               str =3D "-ENOSPC"; break;
> >> +       case EACCES:
> >> +               str =3D "-EACCES"; break;
> >> +       case EAGAIN:
> >> +               str =3D "-EAGAIN"; break;
> >> +       case EBADF:
> >> +               str =3D "-EBADF"; break;
> >> +       case ENAMETOOLONG:
> >> +               str =3D "-ENAMETOOLONG"; break;
> >> +       case ESRCH:
> >> +               str =3D "-ESRCH"; break;
> >> +       case EBUSY:
> >> +               str =3D "-EBUSY"; break;
> >> +       case ENOTSUP:
> > Is this one coming from public UAPI header? I don't think so.
> > include/linux/errno.h is not exported to user-space. This means that
> > Github version of libbpf will have trouble with compiling this. This
> > works ok inside kernel repo, but we should be careful about relying on
> > internal headers.
> Got it.
> >
> >
> > Please check all the other ones. BTW, how did you end up with this
> > exact set of errors?
> First I took all errors that bpf syscall sets, then just grepped for
> uppercase strings
> starting with E in tools/lib/bpf.
> The number of items very roughly matches what you suggested it to be
> (10-20), I have around 26.

Ok, I was going to suggest to at least search across main BPF code
base in kernel (kernel/bpf/...) and maybe tracing stuff as well
(kernel/trace/... and kernel/events/...). That should cover a lot of
relevant grounds. Check net/... but that might use a lot of niche
error codes that won't ever come up from BPF side of things, so I'm
not sure about that. We shall use our best judgement for that.

> >
> >> +               str =3D "-ENOTSUP"; break;
> >> +       case EPROTO:
> >> +               str =3D "-EPROTO"; break;
> >> +       case ERANGE:
> >> +               str =3D "-ERANGE"; break;
> >> +       case EMSGSIZE:
> >> +               str =3D "-EMSGSIZE"; break;
> >> +       case EINTR:
> >> +               str =3D "-EINTR"; break;
> >> +       case ENODATA:
> >> +               str =3D "-ENODATA"; break;
> >> +       case EIO:
> >> +               str =3D "-EIO"; break;
> >> +       case EUCLEAN:
> >> +               str =3D "-EUCLEAN"; break;
> >> +       case EDOM:
> >> +               str =3D "-EDOM"; break;
> >> +       case EPROTONOSUPPORT:
> >> +               str =3D "-EPROTONOSUPPORT"; break;
> >> +       case EDEADLK:
> >> +               str =3D "-EDEADLK"; break;
> >> +       case EOVERFLOW:
> >> +               str =3D "-EOVERFLOW"; break;
> >> +       default:
> >> +               snprintf(buf, sizeof(buf), "%d", err);
> >> +               return buf;
> > and then here we'll just
> >
> > snprintf(buf, sizeof(buf), "%d", err);
> > return buf;
> >
> >> +       }
> >> +       if (!neg)
> >> +               ++str;
> >> +
> >> +       return str;
> >> +}
> >> +
> > [...]
>
>

