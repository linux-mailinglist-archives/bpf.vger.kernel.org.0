Return-Path: <bpf+bounces-39213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B20A970AF0
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 03:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7662FB21246
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 01:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DF9B641;
	Mon,  9 Sep 2024 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG9Lcn1X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D421B28EF
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 01:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725844400; cv=none; b=pBnRnkoPx5Tro1Qv2Bi66vJFY1AK1eq9V0ixl+mkYxXBA3aUI+wGVep3z13OX3Kb4sbyzdRHJ4xZqsaFEmPSGEHH82wNLlh1mF9Wd9LHebpW6Fuesrx7uzyh2+OavuitA0paRGsIiALS/S6bC/qBCMqvQi6B5CLJHRF9QXaAjx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725844400; c=relaxed/simple;
	bh=vS0WOo++67WuTK8vusCz+SMXPi+OS6rb5zLY/51PLkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBy348mljUaa8DzOsmI93LNc1kL+yP0Dpaqcy1A6mBOgRcR+BXnrZdHepX8mmy22H9jF8tzALNLQWLc34TU+ejXfR8gaUUwyysbPkWuan7U/Uql8oDZ5BNIM/MPoyZAyv9yTEE0mHcPJmC79ZsKgIiPvDCJaxCNIzGjtD2iK800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG9Lcn1X; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d8a7c50607so2488526a91.1
        for <bpf@vger.kernel.org>; Sun, 08 Sep 2024 18:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725844398; x=1726449198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmqfjRgLjURaheeD9gs5xwILKCqZABC92txMpZWTQPU=;
        b=OG9Lcn1XCYx6ap+nULqWy6xaS3PDUMHtMMQlCDNDMAQUt1Y5pDQBbS2xq7xYSe9NYo
         v7GoN0T7pCxsELt/RU7IVZzQX4kQI1Ul6TADj7UUUMayTSpkjiIn29uZiCqMBLPVkZiF
         +B/MH9pPRHQ6stBowFfad7v36obrm2yCWodsXUH5ab3ERF8WXY3+7dhTQ085/xhayux9
         MPNv9z7gMGy0xGLQvKe0TUPciq3g/5a2So8eQhP0lK4rgtQKolPcIt0F6x0sF8PqEw8z
         vCBFo5Qmz6rhsUVYGPPdiO9chHdcOfjEuoldwlX4GtvRSbAKMhnUhELlONQ4WnntwCGh
         8URg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725844398; x=1726449198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmqfjRgLjURaheeD9gs5xwILKCqZABC92txMpZWTQPU=;
        b=IOCQd7SArNlTtneO61AfRrh/N8OBXQ7mt9GMSzc6nj3P0p+B35JGOiUqCHaeaffPcy
         cTk2bMZlTHB+/Xwx/a2uplZQtMuCGAHk4pGI9hncL6XgSpK4ZqDipQDbr2ofIpX4KmkA
         CnG/gp0Cmd4lMFZgzXtbDiTf2FPXTy+uK5G+9MD/WllcHnfbWG1NyAV/IFVrpxyyycIc
         F2rEtGz/bvJFnaC9Tnf3VZnMqss5lD8s5HntzeZHseDILVyjGMU/0fSMeHvzP+bEkjq9
         AKTQa9t0QDbVb7oUIM7yRZ5SSraPhbEXD0byDheWqtciOohdCqLuyjDACWh7/sVKRI27
         ZGyw==
X-Forwarded-Encrypted: i=1; AJvYcCUMPlRypoophsnn6DGyN8+QuART2FGKMyQvzkjL2BM6fhdMxN1Mrc/px/VU3K1rn1Z86kc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtM0RBCrM75ARLrrQe9rE9xIBItValwmhhne98ve7G+sZ8hn9E
	eech8gwPUt0bkIiBJoPK1Q9rZK9PVL18rDkY0N6pbUaNywAFkFpaME9ozlvDVmQ3IP2yojYiWvZ
	9HQKuR08OyLgDiEXqbUYsaF1ONmo=
X-Google-Smtp-Source: AGHT+IHZYNXjMZsWum9aNMwAXVkyySi4fNZopOCM8m2K8Y0jUQHJEBS+f4rW/0wV/KFyuaAT4zLceiHtrYtyy+xpawg=
X-Received: by 2002:a17:90b:204:b0:2c9:9eb3:8477 with SMTP id
 98e67ed59e1d1-2dad4efd2b3mr10783978a91.16.1725844397996; Sun, 08 Sep 2024
 18:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830113131.7597-1-adubey@linux.ibm.com> <172562357215.467568.2172858907419105155.b4-ty@ellerman.id.au>
 <20240908221053.ad2ed73bf42db9273aac419c@kernel.org>
In-Reply-To: <20240908221053.ad2ed73bf42db9273aac419c@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sun, 8 Sep 2024 18:13:06 -0700
Message-ID: <CAEf4BzbbVRGROtRn8PM4h1493avHMggz1kSDDJcaNZ1USO_eVw@mail.gmail.com>
Subject: Re: [PATCH v4 RESEND] powerpc: Replace kretprobe code with rethook on powerpc
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <patch-notifications@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, 
	Abhishek Dubey <adubey@linux.ibm.com>, naveen@kernel.org, hbathini@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 6:11=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
>
> On Fri, 06 Sep 2024 21:52:52 +1000
> Michael Ellerman <patch-notifications@ellerman.id.au> wrote:
>
> > On Fri, 30 Aug 2024 07:31:31 -0400, Abhishek Dubey wrote:
> > > This is an adaptation of commit f3a112c0c40d ("x86,rethook,kprobes:
> > > Replace kretprobe with rethook on x86") to powerpc.
> > >
> > > Rethook follows the existing kretprobe implementation, but separates
> > > it from kprobes so that it can be used by fprobe (ftrace-based
> > > function entry/exit probes). As such, this patch also enables fprobe
> > > to work on powerpc. The only other change compared to the existing
> > > kretprobe implementation is doing the return address fixup in
> > > arch_rethook_fixup_return().
> > >
> > > [...]
> >
> > Applied to powerpc/next.
> >
> > [1/1] powerpc: Replace kretprobe code with rethook on powerpc
> >       https://git.kernel.org/powerpc/c/19f1bc3fb55452739dd3d56cfd06c29e=
cdbe3e9f
>
> Thanks, and sorry for late reply, but I don't have any objection.
>

It's weird that powerpc and a bunch of other arguably less popular
architectures have rethook implementation, but ARM64 doesn. Any reason
why that is the case, Masami?

> >
> > cheers
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>

