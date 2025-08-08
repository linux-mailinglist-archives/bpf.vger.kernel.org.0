Return-Path: <bpf+bounces-65269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8E6B1EC4D
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 17:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B99565C22
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 15:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C17280004;
	Fri,  8 Aug 2025 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD/0dcXA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDAD7FD;
	Fri,  8 Aug 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668041; cv=none; b=STDMzkcJsHNUas5i0KKYSnVIHhn74RGSurSG6sT9KJWnaUgdgOK+JclZA+2SmPhPgwv2WLtndgOrJX/v7d0+ULkRXthqJGo1Q3AP9sdbmSE1jJHpfnHuq4Du1Vx/ZCJvpwR5RPhO6AM06VHJcvFJi+6EgO+UgSlX7NRV1LQ4mIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668041; c=relaxed/simple;
	bh=nmnDbiwZkr2/9FT78hG2hwnwzQER2I3Sap4n4j/fqKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlyHQpDJYAl1On4SdSzSihHhul+ShF87y5+o/Utpw0KUBmHBGPWrQZbOt6Z7RoJYQ+vEtDSp4G2cfX1Z1TyfZM02Pj3DnZMLeqWZ+7NXWThW42z63fYWYkkH1Xn2U/hzPGFxCTw6MRUIZP4HD4l5BPd+3HrtiN8ai0/wHtd1DNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cD/0dcXA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso1644981f8f.3;
        Fri, 08 Aug 2025 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754668038; x=1755272838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8xJFRNG4FHGw7rctRWT/NqPWTXzZS9VVVxqgWaZipA=;
        b=cD/0dcXAkw6oUjVtbRHNVCulQ5grl+HlIvVluOjCeCcs/mbyRkGIViloufsDs7QpPc
         ZS4oiHSnhK47yMCfr3pXs1OtY3f0z01WwFC9gK6xM2yKE/9FbeW95beSq3KaVk6s6UFB
         8K1vP6A8DyzcIMwPPT6QcAEcB5SuBFS1K0sMLPvPWTiJO/N5vRJnte3jIqAG/lpoZNVr
         9n7WSIRck/hfVbEjTaMjqaxQ5RI3RXKPEvhCRkojIcs84EbjjUcQxy3BMiyDqdNFDt5O
         W01EspicfBY2FvlQ9ZRb6OLKTAvsKrIzxBH8sfC7JEVSY39RvQ+OAKE/h0wcmN2EUxWj
         NYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754668038; x=1755272838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8xJFRNG4FHGw7rctRWT/NqPWTXzZS9VVVxqgWaZipA=;
        b=HGGXfdzFkxp5jQFOWNO1fKSk5bQTu2+V6OcfDhvihGUFUMs4cRJaGGPBOyOYOUf3hR
         2jM5qHucl2aFgFQ2AMrGE3H12MOdaZNAGO54TrYKht/TeeUE/XNwkd0YG6PscxcbkVxN
         hCBWARqwu07R8R7W7DlGca+nilo2bsTQrkoj+I7yPWS3Sai/Kd2Fu2hGgXDtQ4gZyKbT
         ARCrwm1bGHIIG1iMmSiEPHGWtwC3VOOJcex0D+XdovDmJnrcyU51FSjJKvAFFh/to4be
         p4lHBQagOljGAmQFa9a+ApAZuCHxO5+CIezcCtAAnNZz8GBktnNGWnxFggDlrmMgkryJ
         1irw==
X-Forwarded-Encrypted: i=1; AJvYcCUUGPo/lJ1ATYe/K34lufCNg6ZCunXWxsNyQf5ej/dU67J2jL0j9W/Wr15RbyZZI2bUEHNHs9g5OwQ8gZB8@vger.kernel.org, AJvYcCVtixLB/aWEypZqBPOyowFOGSc3+yT30mot/gnYXry/Z8gYxM6HUyc+sGU46JK6QZ9xheM=@vger.kernel.org, AJvYcCWzg4wDkyJN/0dEM/qO/HwvYIqfh38FSghhrjfYBLbSPlqZnH7S+Gv/Ejybu4sa+PeDg6HAFQI9@vger.kernel.org
X-Gm-Message-State: AOJu0YypZnU8WCu19vwxswJzg/ZJ2CViUIzT5jCRCmAwM4/eoeeha5IS
	xqIEZo+OfiuG7KyuUzMm4uWoSDoswggAHr5CXTwKYmDMRhYJBkTiPuENiVEt5cx1EhxUNX1Vn5Z
	tsuMM5C6uxg5dSWPlmYbunAbzqeSbvHc=
X-Gm-Gg: ASbGncvj/lbBMHbMOOB2rEGoR90cGO2+npyTZ/KUHjamUQ84FN5/Lt94a+hGQ/kH2YF
	2/wqFNarDBwJFY9xibN4AfhOxmQP3t8s5mC8JXURljBmWq4U09FTSOzFK//7Yv00UMynEMGbwRh
	NCrrEK3/NchNiL3gQjpSYrpTeolOJMzU+lHwmcNVcgkfOtO0J9JP5GN4aUWAaeoDf1SVANBtYSi
	8TtDfZVlBAVwxlhvqQ184H6jd0IO4N+7/nE
X-Google-Smtp-Source: AGHT+IEyIVSPkWoRZqRrJMUNTA4hK1n6Pjx0KnD0HgmaWTZ/J+Ytq6admCq0l9lj2d/GE43RnUIWvYqx/wATcTlXs/U=
X-Received: by 2002:adf:fc87:0:b0:3b7:9aff:db60 with SMTP id
 ffacd0b85a97d-3b900b4bcccmr2381593f8f.10.1754668037517; Fri, 08 Aug 2025
 08:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-3-dongml2@chinatelecom.cn> <CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
 <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev> <3bccb986-bea1-4df0-a4fe-1e668498d5d5@linux.dev>
 <CAADnVQ+Afov4E=9t=3M=zZmO9z4ZqT6imWD5xijDHshTf3J=RA@mail.gmail.com>
 <20250716182414.GI4105545@noisy.programming.kicks-ass.net>
 <CAADnVQ+5sEDKHdsJY5ZsfGDO_1SEhhQWHrt2SMBG5SYyQ+jt7w@mail.gmail.com>
 <CADxym3Za-zShEUyoVE7OoODKYXc1nghD63q2xv_wtHAyT2-Z-Q@mail.gmail.com>
 <CAADnVQ+XGYp=ORtA730u7WQKqSGGH6R4=9CtYOPP_uHuJrYAkQ@mail.gmail.com>
 <CADxym3YMaz8_YkOidJVbKYAXiFLKp4KvYopR3rJRYkiYJvenWw@mail.gmail.com>
 <CAADnVQL_tMbi-xh_znjGwvvY1GkMTUm6EvOUU1x7rNPx53eePQ@mail.gmail.com> <CADxym3ZeuoSXDS3j+Sv-Au-FbJzKjkh7TPmM619gRODuRCKzJw@mail.gmail.com>
In-Reply-To: <CADxym3ZeuoSXDS3j+Sv-Au-FbJzKjkh7TPmM619gRODuRCKzJw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Aug 2025 08:47:04 -0700
X-Gm-Features: Ac12FXwcfqiqCSdbZK-fZSyrPFgi9QJvGofkcCNexe6aHx4JPbA8kUshVJpVeD4
Message-ID: <CAADnVQLjRVdGHF9Tzgmpf2LHZc2p1fXgneUNbMOhT42GQPCS0g@mail.gmail.com>
Subject: Re: Inlining migrate_disable/enable. Was: [PATCH bpf-next v2 02/18]
 x86,bpf: add bpf_global_caller for global trampoline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Menglong Dong <menglong.dong@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 11:32=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Fri, Aug 8, 2025 at 8:58=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> [......]
> > > +{
> > > +    DEFINE(RQ_nr_pinned, offsetof(struct rq, nr_pinned));
> >
> > This part looks nice and sweet. Not sure what you were concerned about.
> >
> > Respin it as a proper patch targeting tip tree.
> >
> > And explain the motivation in commit log with detailed
> > 'perf report' before/after along with 111M/s to 121M/s speed up,
> >
> > I suspect with my other __set_cpus_allowed_ptr() suggestion
> > the speed up should be even bigger.
>
> Much better.
>
> Before:
> fentry         :  113.030 =C2=B1 0.149M/s
> fentry         :  112.501 =C2=B1 0.187M/s
> fentry         :  112.828 =C2=B1 0.267M/s
> fentry         :  115.287 =C2=B1 0.241M/s
>
> After:
> fentry         :  143.644 =C2=B1 0.670M/s
> fentry         :  149.764 =C2=B1 0.362M/s
> fentry         :  149.642 =C2=B1 0.156M/s
> fentry         :  145.263 =C2=B1 0.221M/s
> fentry         :  145.558 =C2=B1 0.145M/s

Nice!

