Return-Path: <bpf+bounces-39762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3F69770DB
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 20:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67D1FB2252F
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 18:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1251BE22E;
	Thu, 12 Sep 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UweKm9r9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7BA1714CC;
	Thu, 12 Sep 2024 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726166315; cv=none; b=e7yM5/k71TcyajvIeJAk87+gPMK8U8ctUTY4kHLA7vWKXyyMDRuCkGVexAAkxohOnLFPzjWaUAUPZzjjUA3p3z1AAU2f/LJ241Tj9ZLBA3xJnMvhN3xgkozauRdzY/jIdNn6NofD9raPo1HDWTdd2uKX1USNjdzLWP622xB6QzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726166315; c=relaxed/simple;
	bh=nIibWQt4JIHZKS4okqGLDF4ak0P/fHnif370OGFOJZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvimFNfeYLOixiXCnkrxnxhkeyW6rA1r/HM6FyJUDcGAa8AZsLdlz4lZwTZB3K3BcwqlnJiR6aDzztTEyeH4K8/4r0e87oAYnAwmRMDFULx52sUR/qMM38N000IlqRFV+4lrgGpRMzPfQUPnwtjj5/y3CHw59U3qqZOI9om4l2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UweKm9r9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2053616fa36so15559135ad.0;
        Thu, 12 Sep 2024 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726166314; x=1726771114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrxrbGyxUHx+SexTGeYgM0tU2bFsAbcKqZ+1mR6UZv4=;
        b=UweKm9r99VlVAdBxs/dzrUr0pqxaxTbodsMD3NSBdyYpHAqhoGiQ6CyNhX7N4pW54D
         /pKJdLRA+cj7+xmEDyuQBmmhlqHbpV5auUqBpG2QDklczribWiB7TyYX//4wWj6PDJ+/
         VUiwQYwwCJwDW2kgu/7LxufQvC5UllwipHFze8GRAsyxhVieeU+ucJYh8SCD42Jdvx5A
         lYg1BhJop0deT/A62Rkyccl1OLyAHOqUpnpFLw98SIgJ7BsVTAO1PYRKzbNgWhmhOu1r
         TQzWpvTCQUc+S+1IZebzYosZySlKCk50N5vC47juxJCinCQz+s4yfwyKu/RHzgJodd64
         O0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726166314; x=1726771114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrxrbGyxUHx+SexTGeYgM0tU2bFsAbcKqZ+1mR6UZv4=;
        b=CRHO9JtkQa/G+cQTUGGHH2VFbntz+owC5M8ke8ew09NZP+b1Wg7um9OmFOkrACXqNs
         GRFx3imEjiKJUYMHLzous8UCMlch5vULeN5ztbG22LOSG41nEO9fKy6mvQ9yIh1h/GL0
         jnjIaoiodePc3qLPg0oOFWM8CPZ5Ep5tD89ZAYFNcuWDW8woiDVdq4y6aGzSOl8e0Nvl
         pWN2OX5kIOwoTH18XIDa9GGsbLpqlPXIWP179KmwYPYUx64XvxZ2txh5RuBhcIFYfzjd
         54bp6urD2yyY052VZ2H0ovWmlWHPGgG1JElGbn33Uvs1ULTuG1R2rIyT6B5t/TjyBzdP
         XZmg==
X-Forwarded-Encrypted: i=1; AJvYcCUJEqkSdYTtt9yPjg4ZmRC79oNb9Dns9adNASRf6WTlPTiyBiEn3U/fPdaPaIfLNN+IT68=@vger.kernel.org, AJvYcCXuvGVV24OKYWn4VE6KxTPZQe9iBvEU9i78Z0AvRkPkarA3cRpReWYlYCJFhhRKhi1o5K7tkLrCMgtVYsQtDXsjcsep@vger.kernel.org
X-Gm-Message-State: AOJu0YxUN4pLQyneaAhIVty6OBTUbchYrqMopZTkkBZ1WG3YAMm7qtYz
	HnBxMSIP1Fk/d5DeSiVbKfCAXPUkpW0sND77dLzm6TgJljwfW0EgfSJtpYiE5mZmQ5wf5muVTeb
	iekHOk+7z5ZYvmHIIrgu7PH/R6LU=
X-Google-Smtp-Source: AGHT+IFTOetsQV6x97JgsKXXsmoZq0PEeCMyvk2TlTTF+7NSO+UN8WRVvuaECOl2CGT/x06xbF/RLrlrNzdb4Cd/DSQ=
X-Received: by 2002:a17:90a:2e85:b0:2da:9dc7:add2 with SMTP id
 98e67ed59e1d1-2dba006808amr4592931a91.26.1726166313641; Thu, 12 Sep 2024
 11:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzaYyEftmRmt6FswrTOsb9FuQMtzuDXD4OJMO7Ein2ZRGg@mail.gmail.com>
 <CAEf4BzasRqeAY3ZpBDbjyWSKUriZgUf4U_YoQNSSutKhX5g2kw@mail.gmail.com>
 <20240911091343.77c60bc2e5d96cbfd8787c19@kernel.org> <CAEf4BzbdxSbaK1V10j8t_rjG4ZnYsFQLqPrBSswR8KhjmC=5cg@mail.gmail.com>
 <20240912001848.d9629a1579ea3ef6531a9a0b@kernel.org> <CAEf4BzaWtsAeXyDWh7kq8Qnyy=9u7iAVonmefNRvXnTfbv03yg@mail.gmail.com>
 <20240912085346.154b18ca686c7c4595e93c9a@kernel.org>
In-Reply-To: <20240912085346.154b18ca686c7c4595e93c9a@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Sep 2024 11:38:21 -0700
Message-ID: <CAEf4BzbApinibMSv54k1zbBtaR46amZ0nRaF_kf+J4=DjRHarQ@mail.gmail.com>
Subject: Re: Unsupported CONFIG_FPROBE and CONFIG_RETHOOK on ARM64
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, adubey@linux.ibm.com, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, KP Singh <kpsingh@chromium.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Florent Revest <revest@chromium.org>, Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 4:53=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Wed, 11 Sep 2024 13:18:12 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > > > So while I get the desire to have a clean and nice
> > > > end goal, and that it might take a bit longer to get everything rig=
ht.
> > > > But, maybe, landing a stop-gap solution meanwhile (especially as
> > > > isolated and thus easily backportable as the patch [0] you referenc=
ed)
> > > > is an OK path forward?
> > >
> > > I had not realized that the PSTATE register was not saved correctly
> > > at that point. This is one reason why I decided to move in the
> > > current fprobe-on-fgraph direction.
> >
> > Sure, but you said yourself, the same problem exists with current
> > kretprobe implementation, so this won't regress anything. And yes,
> > your fprobe-on-fgraph series is supposed to fix this for good, which
> > is great, but that's a separate topic.
>
> It does not regress kretprobe, but introduces the same problem to
> fprobe.

I'm not sure if we are on the same page. There is no FPROBE on arm64
right now due to lack of HAVE_RETHOOK. Implementing rethook on ARM64
quickly will enable FPROBE on ARM64 and make it so that this can be
pretty easily backported to old kernels. Yes, PSTATE register won't be
complete (we can set it to zero or whatever to make this more
obvious), but then an entire BPF multi-kprobe functionality will start
working on ARM64.

In my mind it's undoubtedly **much better** to not have PSTATE value
and have FPROBE and thus BPF multi-kprobes than not having anything at
all.

> And since fprobe-on-fgraph was boosted by this problem,
> I think that is not a separate topic.

I see fprobe-on-fgraph as an improvement on top of implementing
RETHOOK for ARM64, it doesn't have to block and preclude it. I'm quite
puzzled that PSTATE register value is a big deal for you, but 15%
performance drop (for anyone following, see [1]) due to
fprobe-on-fgraph is somehow not. Quoting you from [0]:

  > Anyway, performance optimization can be done
  > afterwards, so I'm not so worried it :)

If "afterwards" means before we turn on fprobe-on-fgraph for x86-64,
then sure. But otherwise I'm not sure it's acceptable to just have a
15% regression just like that.

  [0] https://lore.kernel.org/bpf/20240912100928.a7322dc9161a90aa723662c4@k=
ernel.org/
  [1] https://lore.kernel.org/bpf/ZuHhD35xHpw2kCC-@krava/

>
> Thank you,
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

