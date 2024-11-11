Return-Path: <bpf+bounces-44533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1EC9C4405
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 18:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB2928611A
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70251A4F0A;
	Mon, 11 Nov 2024 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuK5ImwB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84680034;
	Mon, 11 Nov 2024 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347196; cv=none; b=RaFGdoGayp9iEi2VORF8wAuMjrxKw/97OCf/W9R+6lbPehkytRb0vKmo+va3ZXYtpQGBe7SipxTuYkAg9cKxnqDrKDxxgpCnpuM3HMSxkmbLQ3mmh8ET7u7LK5d/januVnviJA+LrrUdK22gmMNJuoyadTm3z4G7zBc+0+ZUKyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347196; c=relaxed/simple;
	bh=Uvy1hy1bQj9r0tIzsOEt9DjNrnJZeWszrhoeObuOThk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWdo5HvXxoN0M4UMImCpzsWh8sD1xD7CFDRVQFxyas0jfNXonLhOmC6NEt9n/ARXrzaqvoKiRV5dMDWoVni23cc+hJwz7bNg2MOd4fDt9djIQn836IGVHQqSja0vZcvzNbPC82ZznBQRHY86KOLvaVAgTcXytJnhuRSS630n6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuK5ImwB; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so3225423a12.0;
        Mon, 11 Nov 2024 09:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731347194; x=1731951994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNnRv6FCZv3G0yCwYWLNtBrQZjpFv6nErAyUKI/DJOw=;
        b=ZuK5ImwBw38Ck9c7Oi8l5sIuF0Yu39/MEm/WCV/F7PqsZYBJiU5HkHxAA9XlOBaZ9z
         9PvpqgOLhU/8OdfTHoUhDaYzoNZZk8fB1s2p00oefFCLxeLu4hD1p4kX2jkkeOuIfODA
         lsI5OWMBpwTOCUKD7XiIyrIADSXb+gjDtoR+cHFvRRUg5AbvZIFJMf1epaNgkDZHFleI
         t5cGx8O+BW69dd0i5RESRus1OgFDmCi4xz1yJV31wZUKR8ekMPwXW39w44znD7sdqD9j
         MWmJlWAOjaOr/7K48QAALkryeKRXBwT4GeTudCuRikPWjzp975s7FC9t7xOYf/wwDksW
         fh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731347194; x=1731951994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNnRv6FCZv3G0yCwYWLNtBrQZjpFv6nErAyUKI/DJOw=;
        b=u3WHBROfGRr7Caqob6x5RYPO+ypB9WcBPh/12ltgf+T/xsvNJBVpLE7EpRKOaZVaE6
         xOfyAXQxIhAk40OW8PeQbzClJxtJVceQseLvPcwFPOdFF+pduG9S5NseEKXpBCkihAFY
         ZNWoPxv2UYZ0bxQQmJ8158G59RDHp/jkbv1rRNWd+eT7dyMEWkxZ88ZmNdQ/ViC1Qhn2
         ymIOXTziu09N3uNFn4xTu+5e4+W3Wq6uJd/h3WWdOf6F8E/1luvPU1ER6lEuhnlsoYlV
         HfTwBFz2uTSqT2RS3zTijrbIzTTD94hWo/QQ8ukKxkFIMuzlBz6eAHVHRzrk/9+UvTsD
         A8BQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Ps4sWEH2bU4QC64q5liYH/Fcc5oTdJW6mQ5mG3q0PyxWSiltQhINSpJyppgzKGSsBRfz7Zn9sg2KI3fW@vger.kernel.org, AJvYcCW2VccuZEeWwHXeumV5dz7WVqHDQP5MDJN0ZMvI07OI0Hl7G9/AKqKMuAs9xkelucc6cuw=@vger.kernel.org, AJvYcCXW95I/cyrpp1uI3ZF8gO5fpN3QbVYdOArgZJ/7QKnz2heB0CVNkLGqLcHzj9UkxGRsOr+M@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy6+7AAAg2VsIIhD3YVZ9SICQvcQ20W0wNk5pBr6mblJoD5vVx
	6Rwohh12E8soiQF2S2XhIc+lpZWSRw5FBzvASqvsVSoC2REqLlKrrKUUQJSVHCWutZeCsVpMLMY
	VY+iHvdYkOcThtvZ0hlzJB26IP4s=
X-Google-Smtp-Source: AGHT+IEkredzTHGvNu2cgp0NfIFrEETDoWm4DHSF750wk5P6B1mhfq+2K8EhZ1F+aU4dGRxDwbeSi6eRPKQLjaoiZG0=
X-Received: by 2002:a17:90b:4d0d:b0:2e2:b6ef:1611 with SMTP id
 98e67ed59e1d1-2e9b16aa91cmr19699154a91.18.1731347194411; Mon, 11 Nov 2024
 09:46:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ddf64299-de71-41a2-b575-56ec173faf75@paulmck-laptop>
 <20241015161112.442758-8-paulmck@kernel.org> <d07e8f4a-d5ff-4c8e-8e61-50db285c57e9@amd.com>
 <0726384d-fe56-4f2d-822b-5e94458aa28a@paulmck-laptop>
In-Reply-To: <0726384d-fe56-4f2d-822b-5e94458aa28a@paulmck-laptop>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Nov 2024 09:46:22 -0800
Message-ID: <CAEf4BzbMOSfQ3gdhujUyz_NuiDG7w74n7n52ZO5VCyc-XKOeQg@mail.gmail.com>
Subject: Re: [PATCH rcu 08/15] srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()
To: paulmck@kernel.org
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org, 
	kernel test robot <oliver.sang@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 7:17=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Mon, Nov 11, 2024 at 04:47:49PM +0530, Neeraj Upadhyay wrote:
> >
> > > +/**
> > > + * srcu_read_unlock_lite - unregister a old reader from an SRCU-prot=
ected structure.
> > > + * @ssp: srcu_struct in which to unregister the old reader.
> > > + * @idx: return value from corresponding srcu_read_lock().
> > > + *
> > > + * Exit a light-weight SRCU read-side critical section.
> > > + */
> > > +static inline void srcu_read_unlock_lite(struct srcu_struct *ssp, in=
t idx)
> > > +   __releases(ssp)
> > > +{
> > > +   WARN_ON_ONCE(idx & ~0x1);
> > > +   srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
> > > +   srcu_lock_release(&ssp->dep_map);
> > > +   __srcu_read_unlock(ssp, idx);
> >
> > s/__srcu_read_unlock/__srcu_read_unlock_lite/ ?
>
> Right you are!  I am testing the patch.
>
> The effect of this bug is that srcu_read_unlock_lite() has a needless
> memory barrier and fails to check for RCU watching, so not a blazing
> emergency.  But it does mean that Andrii was only seeing half of the
> performance benefit of using _lite().

That's exciting, happy to re-test once we have fixed patches.

>
>                                                         Thanx, Paul

