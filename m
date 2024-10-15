Return-Path: <bpf+bounces-41998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE00199E2EB
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 11:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833F92817F0
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 09:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088B71DF970;
	Tue, 15 Oct 2024 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjRuo6E/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEFD1DD9BD;
	Tue, 15 Oct 2024 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728985015; cv=none; b=QDRBLLMJsmD55Uw3r2o9zQO02PFZnS7KDhOzkwO2f3zE4k6kbpWFLTMxNG0cF42LtMAJcYJGwhkKy/OPCjydHga/YDEwy42LcAZHHrljC5Yg9psVJiDUMEcZJ6dnUUuv6qXjlbPyJKIa1LZX2Rf/fupMqJqaoDQUtTcZj6ITvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728985015; c=relaxed/simple;
	bh=EuHSVp0ma6AF7blC/RGH7eF4epMQJtOuLhIEBG/TvBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaWIfYsXokkDoCyGSvFTXEwMjoJ9seEc0lVOV8N2b2onjkYUyBORUmVIMKm2uY+8rPu4+IUDNwrKHTPFHPqZlCEfQkMTO35gXG9HoDWJORwsmzvoPmiql4giB6vTL1xVt4+twFi5VYR1jbJ4O41O7KvmUTRO/Pr/YE6OehY4/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjRuo6E/; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-836f1b47cdfso246761139f.0;
        Tue, 15 Oct 2024 02:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728985013; x=1729589813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOzlHPSBobGuPptS2qSZ1QwRtjfsUbv4gGiNiZWPFR4=;
        b=fjRuo6E/zWt3bzaXCGjSudseT71qrAf6iR7/0H9fkehfBld/QRxuFrj+uJodWiVwkO
         Seu5HyjN4f8cJzDVzO8EU97kCTWfaLuPDuAjGB1wTcbDJn15/QpfYMEaRmh2chM2DzxA
         FOnNn0EtqaiSoLNTJGsJ+M53B+KRD4ihtuiIKJBck2qy133znh5+p3N1PL2Lzuy23xcP
         N2wKHLuy6avm4XiGGCzgit1HF5+K4ZV54JFECmfFmZBzKyJtmETXeMorZou4tnZg6TJe
         czN5dh+jKYjpTVJ5AX7fcpaLQ6hYAVKSQMdTDyz42LPSEY6eLAGRJ7cvgnAzXt4aJtmr
         kAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728985013; x=1729589813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOzlHPSBobGuPptS2qSZ1QwRtjfsUbv4gGiNiZWPFR4=;
        b=v7YF7wYf8j8fLOTY7ZUenAnj9LNekGRexY3URezCxEMUW0h6S7VN+6g/03OI6MLnDA
         hyJLQ7dNL0vwUc/D8Z8KXTcCQM2Q/8pDoMDJC64Jwc1+7TJ4+9e77/ZVLpnBH42E2J4b
         Gm92bOb/Qfa0UmQ1vXyypbYjOyPayI7yl4KKPHETOpMW4Y3LSC/5r5OLsTxVzANJmrjl
         SJcM4BbSKHjitj2L81fmITChwlykBa6IeAymF7bxfwM0oaFXLtux55Rd4ClkVaD+HrUo
         GlutQEfZAEzsMC7sv50F2dgL4pePNQGKnbuaVk2zH1FQrUBeLgOQQg3HShHlQ9uj+Yun
         uDrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPXLr76b1f0YKaO+qNPBFPy9f4fR8kPDadjM/ieuvjvJTuv9Lowy3AzQYdotcFoL+J3Z8=@vger.kernel.org, AJvYcCUtu7RrrOiPRcDd24pbqc5ERqMEZzuTZEop+8PKX37AX0X6ei29j6zewD4lqSlnD0myyeugN9Od@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq/lfHJMZdObrX63KYP7pJDMwmhJ8W9rXzvugMLDm3JId/HIC9
	g5pt/tfP8n4i877sjYyRYr0tbQr1RAzJgYfXSxmPsGQ2jZ4t/5cKx8AosRAg6U5W8Uhj87BVzN4
	XocIloNyM99yapNgzg7UlFqdZDNA=
X-Google-Smtp-Source: AGHT+IHAUit3P2s0RoURPDSBc3P7BsQ0e7J7JlVGM9tYWDXEhA89gyrAqTmPloyMh7hBhGScnTLEFj/4VJVnn72WJvY=
X-Received: by 2002:a05:6e02:1a0b:b0:3a3:b4dd:4db with SMTP id
 e9e14a558f8ab-3a3b5c73b7fmr147541985ab.0.1728985013202; Tue, 15 Oct 2024
 02:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-10-kerneljasonxing@gmail.com> <202410151628.hcAdeahi-lkp@intel.com>
In-Reply-To: <202410151628.hcAdeahi-lkp@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 15 Oct 2024 17:36:16 +0800
Message-ID: <CAL+tcoCsWdDKSfWfbAD2DtSFJRaCMJNVy4UbKqoLH8RfkPkBvA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 09/12] net-timestamp: add tx OPT_ID_TCP
 support for bpf case
To: kernel test robot <lkp@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:41=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Jason,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/net-tim=
estamp-introduce-socket-tsflag-requestors/20241012-121010
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20241012040651.95616-10-kernelja=
sonxing%40gmail.com
> patch subject: [PATCH net-next v2 09/12] net-timestamp: add tx OPT_ID_TCP=
 support for bpf case
> config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241015/20=
2410151628.hcAdeahi-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b=
5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20241015/202410151628.hcAdeahi-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410151628.hcAdeahi-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> net/core/sock.c:926:2: warning: variable 'tsflags' is uninitialized wh=
en used here [-Wuninitialized]
>      926 |         tsflags |=3D (sk->sk_tsflags[SOCKETOPT_TS_REQUESTOR] |
>          |         ^~~~~~~
>    net/core/sock.c:920:13: note: initialize the variable 'tsflags' to sil=
ence this warning
>      920 |         u32 tsflags;
>          |                    ^
>          |                     =3D 0
>    1 warning generated.

Thanks! I will fix it!

