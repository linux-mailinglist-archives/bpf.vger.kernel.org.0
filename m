Return-Path: <bpf+bounces-75612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F041C8C1D9
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 22:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 750F54E757D
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 21:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE7C3314AC;
	Wed, 26 Nov 2025 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRUIgrGG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE93128CA
	for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764193958; cv=none; b=PIIMiI54UZ47f6bvOMYXUB3rno+T64KFzv16gOMr0dxH2FrbEKNiZGxEL2UVKNMYQ5oOglOFOq/K0EH5xuJT3ZFWOlCV798Eks52OIvCx339/GOonfml2idEajfD94QUL0c9mH3TiSu/voGfi6X5PGldRVWJbPnt/fgqjAoBUrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764193958; c=relaxed/simple;
	bh=OA9IH37zSCd2RwtlrUotNgXyzNqRut+Yy0Urpo38jUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1nwAMADrAsmuFF0sBkdyGLpJ1e37iQLwKM3GSv53jnp+KdCN9Wt7hNVi4pW+HyADqPHGQRo17YcOVe7v9YK5w4DxM7HVKDgNjNxAlFmrm9xqOsrItr/eblqiVc/A9/CvYUj9fBMRD0Z6/5BWBYcxRCpbHGap2pv2luKCip+ep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRUIgrGG; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63f97ab5cfcso217988d50.0
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 13:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764193956; x=1764798756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWVBfG7V5vG8Nex2eHRPfQjXlHORQXw1wNWDWwMJmrY=;
        b=lRUIgrGGGNhj3o5qKGPiQNdufe1wAwgDGhqj7SEp1k0S9rhFRf+m3eLkt8TTUU2aL+
         CV18ATx1rEqaMYVU6/+xnqs07hS4tqKCgTP8WpI9ry16ugFSP0Ilf2puV7lZJpVRJHul
         jJQvFttAAYKlPEj/wBr0uCAY8kPMfB73KZIWytfVAMeTMCSnUQG+fcu2eHF2v28IOKnv
         gqxNFG28+bsJFQIy+9P0Ix93RJPbPd8vVgRBwJ8uYjM65/sh4BGOKerqVsKxrJLR09gb
         dN7zXdUyKBEp2zo7HRgxMUEdi4YK1/ng5WCpkbgc8VcTXSmgV3GGYnD2McBVfUIEdPzY
         mh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764193956; x=1764798756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KWVBfG7V5vG8Nex2eHRPfQjXlHORQXw1wNWDWwMJmrY=;
        b=fRt+cRQFScnCrhb6TN3Ojq1IGMEoUB2NwiqM0NxpsTQU1lY9Meb2bomX+Txj3QGcZ9
         ovSxw1iMo6oJSrfeWWoIjhDBD1OrfXxKldd+zRyBQdH6jDckjCC+cGVL9+HycHowsvGV
         jB3QGNhp2bbSPcH47rPBcB6t83pdhqV0lvNZ4SCWHHyb04LVyEQjlfR9N5sQS7SE5noC
         BRW7ka6xbdTgAWIeqJzqYPSc1VyNMFGs0FVDqe8uV9vHUPZXsWctsrSvbQ58D8jhuj12
         8RcSSLliv0Swvc2TpjorY9aVFKGVGqknKNkR5aR0seGDdAZxQsM7jbcwj5dN1MDJrNpw
         Upmg==
X-Forwarded-Encrypted: i=1; AJvYcCU8OXf0ONMH7TIXZBIE1pgA0eainRt+Kbgh5kZDkpzvKGeYu4TbKrG/0fXGgg+akIl7qPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzylbfUbNeLluxBI3q6nvJ0aYAJp9UkCDn7Sfo63a/1GE/TBeIO
	pxSjX/j4l4R1flCiMFVP8UZHta8iZcaMqRjxgWcwP6W2/MJbtXgrtObfg4tSl63CAlFXKgZxH4I
	nkCtdkF4ptbKgigqr3iSD/ynTrXDTyPw=
X-Gm-Gg: ASbGnctfldhlwYXrsdIlhfZylQy3maMeL6Okz8R+qTBXVr79d4pFyAApLg5HbZL7L4Q
	pkNBQN6v69pGIKkRGo4yzmWaIJ11fpnvZcJeJitOWZ7KvC1NVKobXGVmZ0Vm0o6XJcFg5jUHgFQ
	t4PnZuMQMC2MNcRqgMpu9csZvZaHrnLGf4oHQJ7iax/Qj20uB+wY0Z63LBglp8M34965fLpdFn5
	MZI3EA8V2Pjpp0KoEY/wCntxecd3WeranTEXNQCPhg+VPbzYHzW5UXokGMsLWVJN2siWBI=
X-Google-Smtp-Source: AGHT+IFsbDsdBbQPlYbOXdmpEUQUAZMmeapjcBh7uxFrCAUP+guyuTT4S34owbxZk0R7VvNTUpcy0DM8OxvGbYnnVqM=
X-Received: by 2002:a05:690e:4182:b0:640:cc09:b7c8 with SMTP id
 956f58d0204a3-64329320a59mr5250531d50.23.1764193955965; Wed, 26 Nov 2025
 13:52:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117191515.2934026-1-ameryhung@gmail.com> <CAP01T74CcZqt9W8Y5T3NYheU8HyGataKXFw99cnLC46ZV9oFPQ@mail.gmail.com>
 <20251118104247.0bf0b17d@pumpkin> <CAMB2axPqr6bw-MgH-QqSRz+1LOuByytOwHj8KWQc-4cG8ykz7g@mail.gmail.com>
 <CAEf4BzYmi=wJLpz18_K1Kqc-9Q4UKbq+GsyVH_N+3-+_ka0uwg@mail.gmail.com>
In-Reply-To: <CAEf4BzYmi=wJLpz18_K1Kqc-9Q4UKbq+GsyVH_N+3-+_ka0uwg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 26 Nov 2025 13:52:25 -0800
X-Gm-Features: AWmQ_bkYE45o4Eofaaf7jqxeVL278vqXILvL1HWnLZTKzWLJZO1yDFg-KTqB2Yw
Message-ID: <CAMB2axO4hmeRtGFWW58Rx6PCLgLi3Dr+Uiq6JScw+Wm5AcrkLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Annotate rqspinlock lock acquiring
 functions with __must_check
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 20, 2025 at 12:12=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > On Tue, Nov 18, 2025 at 2:42=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Tue, 18 Nov 2025 05:16:50 -0500
> > > Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > >
> > > > On Mon, 17 Nov 2025 at 14:15, Amery Hung <ameryhung@gmail.com> wrot=
e:
> > > > >
> > > > > Locking a resilient queued spinlock can fail when deadlock or tim=
eout
> > > > > happen. Mark the lock acquring functions with __must_check to mak=
e sure
> > > > > callers always handle the returned error.
> > > > >
> > > > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > > > ---
> > > >
> > > > Looks like it's working :)
> > > > I would just explicitly ignore with (void) cast the locktorture cas=
e.
> > >
> > > I'm not sure that works - I usually have to try a lot harder to ignor=
e
> > > a '__must_check' result.
> >
> > Thanks for the heads up.
> >
> > Indeed, gcc still complains about it even casting the return to (void)
> > while clang does not.
> >
> > I have to silence the warning by:
> >
> > #pragma GCC diagnostic push
> > #pragma GCC diagnostic ignored "-Wunused-result"
> >        raw_res_spin_lock(&rqspinlock);
> > #pragma GCC diagnostic pop
> >
>
> For BPF selftests we have
>
> #define __sink(expr) asm volatile("" : "+g"(expr))
>
> Try if that works here?

Thanks for the tip.

In v2, I decided to return the error to the caller to align with
another test case, where the lock (ww_mutex) can also fail and has
__must_check annotation.

>
> > Thanks!
> > Amery
> >
> > >
> > >         David

