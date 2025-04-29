Return-Path: <bpf+bounces-56983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED818AA3A15
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 23:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17B887B1255
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 21:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AF2257452;
	Tue, 29 Apr 2025 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpE136f5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12160214225;
	Tue, 29 Apr 2025 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745963114; cv=none; b=q9rCYPzQ1ObzX5w+nw0FWhGYCto+CaFwV3tB0wcIeJ/WDIfW2w3Q4awie7SNThtvHdscp85FXcJdeAzKRoLS83ynJaiC97OYBWgoQLA0zwB+jud/sak1Br3vpQxGKsQM8bLWTXZmBx619e4K+ee+4JEX7BbCllZIpP8gg7LJRo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745963114; c=relaxed/simple;
	bh=AjG+E2cfuG1nRkS+RGQxPmmmJUJk3KjQUSaOb9JpgY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJVUY/gapp/mzHC6wED1IYFLlmUQ5m+qgi5dZfHl16Fs5Jq87u/NED5onQgvrG5mCuT3Rji0FRDs1r7xxMcMQOBJ/N7FcfABjRfvaDdy6XVC2uWgM5i3A/TbEFrLu3MTS6pa86HzBIiSMdVQx0kNPwFVt4ONRPxpLHas7Qd5wlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpE136f5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af51596da56so5570118a12.0;
        Tue, 29 Apr 2025 14:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745963112; x=1746567912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0CnmFR3NERVJnvpIol6cRYn3z/pjgObWP0m9NwcYps=;
        b=MpE136f5zrVZfs6y4ZG5gcg8PM8hBMT/Wr3vz8yZeT7KxMY+PaBwA0NAUjNf3+OY9/
         6twiWdV8KdMuSFawlqOwz+mCR1s3XT6JI3ydA4J3sx6K04xDaQNIrLHdCMT3iAQkCb/R
         bwtTMs9No/jLhAOR3t+JVKgDnoHwwWVGbQP/E3k6IOax2ym6ArN5QtmAUhXBriRmVHOx
         r7gW+ad+/Z5AMzgSf3suvTC5+H17dxfsWGbaF1kHxsljbro89LGykSKimAUIGhpIJ8tI
         9w2ePAyE/6L7L4at3UisYzR7BsryDGYxThxURpcZXXHKhoFpQSm3XmYSOhDisH6jV5dJ
         h86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745963112; x=1746567912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0CnmFR3NERVJnvpIol6cRYn3z/pjgObWP0m9NwcYps=;
        b=HBFI9lxwl9nje7kKb9SvThbUx6uEh9Vb5dP9b7g6kiyhmtd+yLBxAQxnQIKTu03XwT
         qm4PfYc0nvm6bODuS+lZEBLcy1+LmDCks6mvCmViXid1NYY2OUpu/aXgg8HueNGtyyPN
         WrCh4wKacdzeGUEbqqlfLlmzvXKe9f/KJsjHnBx++4aBK9l5aZcw3b0RZ2UTll5lbVSG
         T+NFg2ph6H4ubY8W/obYOi/Y56Au4arkZS8+jYzUGHZC4uTVTp8RSDLDnY6wSG9q+1cX
         f0AZC0UI/DReWkdVrxvZx3VMbATGXtb8APMXwIiSvyqiXC7FUum4ptZwoQoe9gyFAacy
         4Rmw==
X-Forwarded-Encrypted: i=1; AJvYcCV1rLWBr43oOdvWJhe+IXmK3q9aQYri1Iz6+sg2Fud5cxSKcyQ8hd/fTNdlGMaDyVtsuK0=@vger.kernel.org, AJvYcCVwTaEknO/Hwt8d3mFFDirKhSZhbtYhP/diFhR0gxzAtNjAADPTheBZLHdZbdD37JhG3jk4dADGUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQIYbladu4P7140u2G3Q3AjM+t3629mR4wMJjt56+aPjySxe6n
	bLnwOQSGqn1bV4sXI8qJcPP2ko0yig3DMC10dJAudrOPcEuBiIhnCDUcKGJxB61Y3I/4jXZN1yA
	aTtdi8O3pShs+tQ23ZRpaX2BRUow=
X-Gm-Gg: ASbGncvDuxbcZCCsf/tqCpFCnT1+sJRvSp/5M5GqKAkYrSTsc+TUHJ2dYE7MYgp8m1c
	/iMMVmnl4hdsvn4DGTF4gJ7snvR7vS4gQ78Px4P29qvPNJAXLIW02OfK7GouM7hCg9rJjRzADUh
	RtkUku3a+K4bZ+el1kgociK5WDWMgMHbeoDKU0og==
X-Google-Smtp-Source: AGHT+IGoGjWI8G9nl8VlipQj3A/hCzHazcDMvzTc1zD2fKnvy438ZNdtm1jylLoyGxeTxA3YNnk8T/3aHT1uLBTGlNw=
X-Received: by 2002:a17:90b:540f:b0:2ee:ab29:1a63 with SMTP id
 98e67ed59e1d1-30a332d5c8emr829374a91.3.1745963112048; Tue, 29 Apr 2025
 14:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com> <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
 <4aa02e25-7231-40f4-a0ba-e10db3833d81@oracle.com> <CAEf4BzYRnNGGafWS8XoXRHd3zje=8xY1o5_8aVw6vxrUSbEehg@mail.gmail.com>
 <c8c4dc05-7fa3-4c1f-a652-a470dd6985c7@oracle.com> <e279abde-f4c1-42d2-bcc0-4df174057431@oracle.com>
 <CAADnVQKi4DARfzQJguZyDQsfXHq7A=QM2FwRwpZe-LJzj+Ujrg@mail.gmail.com>
 <CAEf4BzYt2sUxRPAR5AbAAXVcOeC2UqgkR24WDEZAAd+kEz=g-w@mail.gmail.com>
 <CAEf4Bzays+8g7kj4fNS0rBLPTQWzYb_maFkyHyij4ky1xm_GAg@mail.gmail.com>
 <CAEf4BzZgQMV+Gtiob_K-uuizyuqajyLjnGbKOJLyiGB=DxmY2Q@mail.gmail.com>
 <m2ldrihikq.fsf@gmail.com> <CAEf4Bzb_-Wk8eWZyPc7_r2Oq_o_Tgg+2CE+nTom2wOhjcpDw4A@mail.gmail.com>
 <CAADnVQJ3FYSVbjRKTs8NaPp6Gvq=HdrmDmf+=rP87TNJiSL2kw@mail.gmail.com>
In-Reply-To: <CAADnVQJ3FYSVbjRKTs8NaPp6Gvq=HdrmDmf+=rP87TNJiSL2kw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 29 Apr 2025 14:44:59 -0700
X-Gm-Features: ATxdqUEh9R9DOC8Tp51F_N0J1UVWJvhS4XMVVa5TTI7Drp2YXV2VSLCkMw-FJvg
Message-ID: <CAEf4BzYECYxn8GjkczkTZnRDPq_M81+GfMLXZzkYOHcv48G7TQ@mail.gmail.com>
Subject: Re: pahole and gcc-14 issues
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 1:56=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Apr 29, 2025 at 12:50=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> >
> > But here you go if you want to play with it ([0]).
> >
> > And yes, "visited" marks are the solution, but I was thinking that if
> > we implement a pre-processing deduplication step as we discussed
> > offline, we won't need to do any of this, so didn't want to pursue
> > this further. But we can talk about this, of course. So far this
> > generality doesn't buy us anything, I got byte-for-byte identical
> > bpf_testmod.ko with Alan's and my changes all the same.
> >
> >   [0] https://gist.github.com/anakryiko/fd1c84dcad91141d27d8bd33453521d=
1
>
> I like it. I think it's worth following up with that.
> Why do you think max_depth is not enough?
> Because of
> btf_dedup_identical_types ->
>   btf_dedup_identical_structs ->
>     btf_dedup_identical_types
> ?
> Then pass &max_depth from btf_dedup_is_equiv() ?
>

yep, that was another option I considered, just have a "global max depth".

OK, I'll update my patch and do a bit more benchmarking. I want to see
if this doesn't add much to the overall dedup time. Will post
something later (probably tomorrow)

> The visited mark seems overkill.

