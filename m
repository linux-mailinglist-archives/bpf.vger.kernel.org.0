Return-Path: <bpf+bounces-70868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B3BBD71F8
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 04:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD2E420E78
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 02:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99CF238D42;
	Tue, 14 Oct 2025 02:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpuayaEr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8CA213E6A
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 02:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760410119; cv=none; b=Ew2ekCzfqRQTEWx9KftWU6fm5HFonGvzdjAqI7E71tzSiIZ5Hj8PyiEJNxE+U5nstH8/um6keJVjBQNcdMXkM+8sPLd9m0cCyemTLNLUbDjSD7Yvh/ikpk7quIHIZceTmd14056Y18Qy1oAUiusqH7yvxjR563XG1/EYs3peCQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760410119; c=relaxed/simple;
	bh=dGj4XItH+WnBUIlZ4F3FWzZdBgz+gnjQrlvvsej3eFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3chX3XwtdltE4YNpvculpbCqTDqQESZJeSvRJFnAigmA6Dyd0BpURukEeewxcAm8eBvCcCpUvWaEZBfxgdZSEjb69yuWt+yjSSK6bnMa9vnh0xggQG5Xdg2tKveyD20ytzhCoM86B7dj7oxNT5B7ydJUyS5Tx1t0W94zKnPkk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpuayaEr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso42276235e9.3
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 19:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760410116; x=1761014916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGj4XItH+WnBUIlZ4F3FWzZdBgz+gnjQrlvvsej3eFs=;
        b=fpuayaErAZ5ooC2s/IQzA0WYiTjjxFHI6F0Of++54xAdODFhT2PqP4t6CcMIONOIdB
         hlZKD+n8m+i8hvONsQr8epghJtzwCxgrc51rSm6DrtN4zQ60ofhEc0RAiZrUXf/UJHQ7
         R0iNgiM4ApL3WVKmUqth+Mx6ZbLsVkUO9ymHTC/FVt/7OYmjt9n5g/LAi+iqVmMoC1VX
         rJgvNUkjCKrNvT3ch6xVfswqsBL4dLKIRsfuW9rCg0104y6lqdIajckBNy4pWw63jy5y
         DAJgoXbYNPJHvRls1CN42TFnPltBzXwonLP6FP78nINbcHzNnijgH/SunX6O9cGUE+Md
         4WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760410116; x=1761014916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGj4XItH+WnBUIlZ4F3FWzZdBgz+gnjQrlvvsej3eFs=;
        b=DC4htJ2rXvt73Qh1ih3y/o9m6P3pThX3ucFAw6sQKY/OS4p16Y01hEb2MU/R+FUq4I
         SCZXubeaiSHyk6kA4a3odf+epvenhSYS4Fe9xbSm63IAXOIvvavrWr2H1VhdYbYnKo8E
         O7vTdLZyAm+tqhHAICLpouUOr8DSe/NuZyk09aaWmi16U0kqtkWaAlHaas/G5w7QBskm
         aeihxZQ2dRwqm+e4T9qOtESz7uqzI6AGNNwamP9ujLZTBGJfUppPhpTxkTDzX4FoTGaP
         900qY/f9TPzbw5TLztITRZJZgtl752W245gvEbDK4i4VfNebVdOYm9kwwwG1uIN5Av/U
         O6MA==
X-Forwarded-Encrypted: i=1; AJvYcCW2JpUeIMF+VEm7Tex632/Kk6IqaIYwQVlAu1/GhLTFCgrbvLSMrk8PcDGpg6PALQ7z+Io=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDIG39X+ibR/n243ts3VV9hp3fZhkJ2DWF4WHifEd2WeN9m/mc
	DKnwQss/5wMjokp2Kg6QvoMKqFUnx/n8DVC3JH3tzU9IRxqzBLWnKX8/5Z8kaUtPJLufvZPhihQ
	gJj9PV7L8iw0QjFBnJDBrWvMWS4RsqAk=
X-Gm-Gg: ASbGncvc624lWnvdzmJZLtnUY/3aJPxint2GMAI3MvbRZNKPIfHntr0MF3HmX2BldDb
	VizfWKycRq0Fy1ZA/5JgkCEqj2hgtP22tcQM9eN9K3ZM/YiUVVXCNPASsBvDx54vg9wTxiK7ACM
	CQURjeZO40NkA4GR0akHhd6CteIKExo7XRBhO49Mltogn2eojV2XzKHLFCYputCjL2m4lP7FK9W
	lObAQ12V1+cPXu6u6TqvsjNCNjXH+YatlZGUpgtfjuyETpygpcwcqT9KHw=
X-Google-Smtp-Source: AGHT+IFotiWPFO2AllCGKA6tO/T+IXcCmNirCX3Lliq0AZ2OfXI3bRZk7OrVIcI9TcUtGhU5hzc2a/WiVxBXjnfZarU=
X-Received: by 2002:a05:600c:699b:b0:46e:43fa:2dd7 with SMTP id
 5b1f17b1804b1-46fa9af35c6mr161148645e9.24.1760410115695; Mon, 13 Oct 2025
 19:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com>
 <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
 <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
 <CAEf4BzaZ=UC9Hx_8gUPmJm-TuYOouK7M9i=5nTxA_3+=H5nEiQ@mail.gmail.com>
 <CAADnVQLC22-RQmjH3F+m3bQKcbEH_i_ukRULnu_dWvtN+2=E-Q@mail.gmail.com> <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com>
In-Reply-To: <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 13 Oct 2025 19:48:24 -0700
X-Gm-Features: AS18NWBn4zAMAeVMaeMdIBpO0QuBxoqXylpn07vpJYMirTGjgZsbn7Yyj6E3etc
Message-ID: <CAADnVQ+2JSxb7Uca4hOm7UQjfP48RDTXf=g1a4syLpRjWRx9qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 6:54=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Tue, Oct 14, 2025 at 8:22=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Oct 13, 2025 at 5:15=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Mon, Oct 13, 2025 at 4:53=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Oct 13, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > >
> > > > > Just a few observations (if we decide to do the sorting of BTF by=
 name
> > > > > in the kernel):
> > > >
> > > > iirc we discussed it in the past and decided to do sorting in pahol=
e
> > > > and let the kernel verify whether it's sorted or not.
> > > > Then no extra memory is needed.
> > > > Or was that idea discarded for some reason?
> > >
> > > Don't really remember at this point, tbh. Pre-sorting should work
> > > (though I'd argue that then we should only sort by name to make this
> > > sorting universally useful, doing linear search over kinds is fast,
> > > IMO). Pre-sorting won't work for program BTFs, don't know how
> > > important that is. This indexing on demand approach would be
> > > universal. =C2=AF\_(=E3=83=84)_/=C2=AF
> > >
> > > Overall, paying 300KB for sorted index for vmlinux BTF for cases wher=
e
> > > we repeatedly need this seems ok to me, tbh.
> >
> > If pahole sorting works I don't see why consuming even 300k is ok.
> > kallsyms are sorted during the build too.
>
> Thanks. We did discuss pre-sorting in pahole in the threads:
>
> https://lore.kernel.org/all/CAADnVQLMHUNE95eBXdy6=3D+gHoFHRsihmQ75GZvGy-h=
SuHoaT5A@mail.gmail.com/
> https://lore.kernel.org/all/CAEf4BzaXHrjoEWmEcvK62bqKuT3de__+juvGctR3=3De=
8avRWpMQ@mail.gmail.com/
>
> However, since that approach depends on newer pahole features and
> btf_find_by_name_kind is already being called quite frequently, I suggest
> we first implement sorting within the kernel, and subsequently add pre-so=
rting
> support in pahole.

and then what? Remove it from the kernel when pahole is newer?
I'd rather not do this churn in the first place.

Since you revived that thread from 2024 and did not
follow up with pahole changes since then, I don't believe that
you will do them if we land kernel changes first.

