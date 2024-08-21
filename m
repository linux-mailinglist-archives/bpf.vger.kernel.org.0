Return-Path: <bpf+bounces-37738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F5195A303
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E49282AD6
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B165166F2A;
	Wed, 21 Aug 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFZ4UtG3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D7152199;
	Wed, 21 Aug 2024 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258452; cv=none; b=KaSUbpetUTj0fI8XjkvFO5i87nkS3OuQvxiO6Ku0ua09v4zL+dSSFfi2XJm2pAM5neXlTOkNFhaKCEMpNXt5E4Y4pSh7SrvjPVCEQSj6gOKj8f/5ZKMAdIo/BwszPx5AwG9QrwNOtCSl1znGrMV37E93WA31LYQ6OvYFCy7KGGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258452; c=relaxed/simple;
	bh=sJf6jiQ13TDCgcjgRib4X5ouGA1y4YARS+xp4O8b7Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0RmBG2r6YuWMwUVRODlS5ZyhSyRJNkGsMrgHm3ium12KPk/nQ1Vne7L4Qstr5g1rNaoEXElwPPUPwHb9RkqUZC5Klc51boc4wI35Lw17zamU5k+0oyposeT1Js/d12DdAZeO9/tNOkyPgjr8UQcRXFBoPpAEGAM9TBv2Hp9iN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFZ4UtG3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7aada2358fso163405166b.0;
        Wed, 21 Aug 2024 09:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724258449; x=1724863249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJf6jiQ13TDCgcjgRib4X5ouGA1y4YARS+xp4O8b7Kg=;
        b=RFZ4UtG3DGrj5h2+BTyzhgKWT+T1mmkLC3cdtIA9bZ2kLoviQ3Xb4I6SsWy3rSWvpt
         0lIvSN9XSVdDGfPcKog4XMk6zdroMHuRdI31vVj2hTQjzP/CekRe4lWpzhJe7vcVxMb8
         ws+jTRRsV8t3uXadWCflozhtyQFjglH/yjfeYXIQVeuyJG4cH7IKMK60Yl27vrvhXwmc
         /8nYrcFF9ZMOZj4sDHSAmVB5x0XNQA0WTCC1JvVFGvkgzneXBKVJKBRJm3xVxEvJcyRh
         QT/VwgicyB9v6szx6zQn9bwLeKg+lW1ON9LUh3lLNx+PL/t4vWne9WHhJxgZBZ6VzWhk
         mUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258449; x=1724863249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJf6jiQ13TDCgcjgRib4X5ouGA1y4YARS+xp4O8b7Kg=;
        b=O547TdjLJe8ytHzca3GIYaYap+iEfAG4ioh740bs36P0TPZs2ESCeOoMScKQNRF20r
         cThPgsaGYPP/1pyFdVDSMrCUHZLeUAkCpN1LMnfY1QwZYAql6N6v6CmszQX2ndwmiiYf
         eRXbe7cxEiKajJTLrWEVk67KVlN+9xW+s82FLit/y85oGiQZ3IAENzQGUsEPsEWXqM5X
         sQwjN9pf1cMfHK8Ql2HYjTNA03+AoyCVjCxG9AeY+IBaD38JoBuqhDASMOnNwjn7ZSDH
         3j2ZREcAaqTzR19a7lHKUA384ziPV+gL/o2dIWTpmq+bNk700BmCUUlAuchPUk5zdvc6
         bR2g==
X-Forwarded-Encrypted: i=1; AJvYcCVA6PeIrjR0cUyLhusjnCBhNSN2J6rT1zjWPGTp9XAVxuXxUY2Xjof6zB5ZjR0wSohVCQ+36xtiaqnXoBO8@vger.kernel.org, AJvYcCVMbqJmIKySLAoHC2DlZgB3u2lLn+NDv41HT/9RuvJXKIpelMSr2k8VGMINBKeOnWkhEl5RH1Fp@vger.kernel.org, AJvYcCWKjcUsEdL4+8v+ZvJhE+1ZGvGMKi1cboylQvhvd4KSZsQX5N7iHCEqeD63Lp9idfZTnsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXglQHTgBXcmGrnmZLLSRXZHwIoFO4z7m0qWGRNmrgieJewXuB
	FX3hLc6MUAYUrhWdJOBycnia6ui9kiILt3cgyjbVhzzTIj2xDRGZejq3wdt/edCUEPLye773Llg
	3RRAi9DZmfs0RobwOQ6+Uod0QV3eJ9g==
X-Google-Smtp-Source: AGHT+IHBzbuPaj1YZCt0hCbiC2P/pXGyXmrjLnBwGTyy/blqFT/D977io1I/VfCIZ8TRKK3R9hsKGb8cHgs2p8zmrMs=
X-Received: by 2002:a17:907:868c:b0:a7d:ab62:c317 with SMTP id
 a640c23a62f3a-a868a908c50mr16241266b.30.1724258448536; Wed, 21 Aug 2024
 09:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK55_s6do7C+DVwbwY_7nKfUz0YLDoiA1v6X3Y9+p0sWzipFSA@mail.gmail.com>
 <badd583d09868ffdd48a97c727680ca6f5699727.camel@gmail.com>
 <188a0d1310609fddc29524a64fa3c470fc7c4c94.camel@gmail.com> <2449825072217d392b5b631e8fd394e91b22a256.camel@gmail.com>
In-Reply-To: <2449825072217d392b5b631e8fd394e91b22a256.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Aug 2024 09:40:36 -0700
Message-ID: <CAADnVQ+9oy6L+oYWJsvy_yMri8vDL9jBQRhZ8nf0SEMm+mT4DA@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref in bpf_core_calc_relo_insn
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Liu RuiTong <cnitlrt@gmail.com>, stable <stable@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 9:34=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-08-21 at 04:46 -0700, Eduard Zingerman wrote:
>
> [...]
>
> > will post a fix to bpf mailing list shortly.
>
> Status update:
> apologies for the delay, the fix is trivial but I have some problems
> with test case not printing expected log on BPF CI, need some time to deb=
ug.
>
> Link to wip patch:
> https://github.com/eddyz87/bpf/tree/relo-core-bad-local-id

I would ship the fix (since it's trivial) and sort out selftest later.

