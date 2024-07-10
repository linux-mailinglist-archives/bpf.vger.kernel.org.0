Return-Path: <bpf+bounces-34338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9D292C7D4
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 03:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC167283FD0
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 01:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E0F2CA6;
	Wed, 10 Jul 2024 01:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/GmOI+/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F0C161
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574331; cv=none; b=dCJfFIMkADrQzuCNT0bQ3d4zUaQ3mCTPhx2aSKUm2dSNOosh4WvyaaLm558xdG9foX0iwJR+VG+eSyP6jplJMkghvsCYZcT8t7bTS+jmRrcd8xiIlOieHFvzayLkdGoZqmiwgVtf1YE5FCopnNipFR5cibXDw6QO2PDa6BEDHEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574331; c=relaxed/simple;
	bh=6/yjmhlP7am8GRYBuQfWnqXTamIo68lEbUXrU+SY/ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFSE63MLx0LVUklbyk5X7WCumXLjK8Ld4MfUeW4AO8fT3SwBCshXE29xRxChzFZ3XEZniowrTE2jMn/U2H0H5hdd5bZYFBjDdFh9nKIlGRoLvlGT0AxKAK1z7B3vYU8iBMLxLwd3F8l9ZMc8gcz8YBJkBqWmOWduZTnOXGGedT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/GmOI+/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4267345e746so9040325e9.0
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 18:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720574328; x=1721179128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6psNhXTyA9tr4qhfB0Ue/L27wnFSJgwdLBdt+smiTH8=;
        b=N/GmOI+/pDNos9OAcaHk5gSBZyRAaGFHOLEx7IK6+1GNXAPt7WeQb0rC1xafUZWOdd
         jdqKMfMxAKR8lJZr4X3+fDPLj82SHU0TRKY7S3wxBYkS0oiCbgHBKWQ9vOdfLBYJf2U9
         uKTTBS6pWEgLohs5ET/F7sgTLxP2CT/c8aSP9hn3NGxx9lNajK9iGWdFIWQeGqZHvaWN
         AadwaZ6LyZX3oCIabH9yNa6dwDZnOXlxyQ4TNJg0vI9e+7a6/xsCZtbBqRHuRyWNQ+Xm
         Or08eSMV4KZ6dIu0Y89TNl/wk8IWXL5VpHtzxVUR3Istr3jLRQrASni3GhfEOma+HUNt
         uJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720574328; x=1721179128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6psNhXTyA9tr4qhfB0Ue/L27wnFSJgwdLBdt+smiTH8=;
        b=bE4hyPIf9+C/XZIaFZfFMn+n5iM4mMzOTaSFlEqfs81SI2apMi8px3LTEH0B9miqbM
         wOdcHPkQdPtaiFhG9AW3iJekr4MOPyhtpNxyBTOM8llYiednZdUzyoS0gmxJTBPrmlQg
         r2ZuLfmB7AfxQL+5MAqLcSQ6twfVhLnJ7j7gCpiyG+wSeHmmG2FbO/g72vpNqSFmmC+2
         mD7vxwaOxXrOvO4yx2WS/E+wK2XuJdVsiokvuHftqC0wSUw2g0JuHJ43wAyGubftuRfm
         cPttoBlZTfzjcB3p87rt/+0DwC6Wt4gm5ATXFxTSXTD4WpqPNGgKpmB7JJod2xEDd8bA
         tzlA==
X-Gm-Message-State: AOJu0YyoX6+YnLi3G+Qi07BASzGyhQ9CtQVVQtrM8r/+7qOawKcxsuXN
	HgFeX4GSP2UzMOBBMOCTIsI76MRiXG51UkguSrE9uafc2CWOvcuUbEqZqH3/vud++i+SfTAUIS5
	NFxKEIdIKnEFdxgbrCq4r8YsvQPo=
X-Google-Smtp-Source: AGHT+IEFFgt1XGID6l42oTJ9djpFrDcfVTMXNOMpsfpt0LxyxRa7cv9vLyAVkFeMp9rtP7XqNXWAU6VFGECehHcw2qw=
X-Received: by 2002:a05:600c:3b8d:b0:426:6765:d6b0 with SMTP id
 5b1f17b1804b1-426707db70emr26307775e9.15.1720574327718; Tue, 09 Jul 2024
 18:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704102402.1644916-1-eddyz87@gmail.com>
In-Reply-To: <20240704102402.1644916-1-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Jul 2024 18:18:36 -0700
Message-ID: <CAADnVQLBd9V3NxxbEJM_RyZHm-jcwqqUkc1n-1Djry5RqF5eEQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 0/9] no_caller_saved_registers attribute for
 helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 3:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> - stack offsets used for spills/fills are allocated as minimal
>   stack offsets in whole function and are not used for any other
>   purposes;

"minimal stack offset" reads odd to me.
I noticed the same naming convention is used in llvm diff.
imo it's odd there as well.
Maybe say:
llvm grows the stack that in bpf architecture always grows down and
picks the lowest stack offset not used by local variables
and spill/fill.

> Here is how the program looks after verifier processing:
>
>   # bpftool prog load ./nocsr.bpf.o /sys/fs/bpf/nocsr-test
>   # bpftool prog dump xlated pinned /sys/fs/bpf/nocsr-test
>   int test(void * ctx):
>   ; int test(void *ctx)
>      0: (bf) r3 =3D r1               <--------- 3rd printk parameter
>   ; __u32 task =3D bpf_get_smp_processor_id();
>      1: (b4) w0 =3D 197132           <--------- inlined helper call,
>      2: (bf) r0 =3D r0               <--------- spill/fill pair removed

Are you using old bpftool or something?
That should have been:
r0 =3D &(void __percpu *)(r0)
?

>      3: (61) r0 =3D *(u32 *)(r0 +0)  <---------
>   ; bpf_printk("ctx=3D%p, smp=3D%d", ctx, task);
>      4: (18) r1 =3D map[id:13][0]+0
>      6: (b7) r2 =3D 15
>      7: (bf) r4 =3D r0
>      8: (85) call bpf_trace_printk#-125920
>   ; return 0;
>      9: (b7) r0 =3D 0
>     10: (95) exit

