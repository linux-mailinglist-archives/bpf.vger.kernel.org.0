Return-Path: <bpf+bounces-26293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7EE89DD66
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 16:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF119B28A2B
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64F812FF9C;
	Tue,  9 Apr 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6Sp2B0o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5C50A62;
	Tue,  9 Apr 2024 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674605; cv=none; b=kZsPqSL3swp8oMZnK8NQ3hjTm6j/rVMXe8sw6GERt/K9lLQvE9iEO9bWj/SUuQEO14+ybTkQh/13ireiaVwWFTNbKSHjNT30DRz0yRCgHlJS4YTPE3fh+4M9IwyOkyeQE9Jm3+R4w8pMX9rhz76n1T51fi6F04J6Oh/Ek9FLKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674605; c=relaxed/simple;
	bh=ug4Ts2Cp7j78r7TufKRbIoCmpdcmtZPlEZXV+Ub4SYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oY9dcIjqN8w1mxlEz0iNYUgINSibX8U+VkQ8w93M2OhujaLNP71iUbyNK0ap9aMKKP/pLsenLClnjszX7bIPCAbyyUifbnIrrz94Vux4ineegY7+ClJo85eMgRwX0y5EBtyYvx0FPDUcwr32YqgQLp1k7qSaS2drmEWn9gXdAjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6Sp2B0o; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4169e385984so7951505e9.3;
        Tue, 09 Apr 2024 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712674602; x=1713279402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuOfapBMHMN0JDFA4xRTHh3cbZqcvV44chaTzX89Va4=;
        b=d6Sp2B0o53eDpTe9kiEl81DQnUxVI2DDiX+e8DFRUqKmXTIZba4JRbkWk/ArRhtz0b
         jtIzEx+fahuY4Rn5gNsJBcJarfh0/+EaIdjYusfPLxZwX0SXndUt/qMYyrj9pRb7P5ni
         uaDogTELE8YPuQqFDE2P/vWvZT90C8R0RUDiQhunqbIZiRnyxUeSUD5i1ERtj7fmfTkF
         Ct1n8cOnkqVMKRvRK8lKzsiY3uzgvctl81aQP6effe//GIoV+RZYo2ciFTBR4wja1YUf
         ryZflmcZzWK7wMNaKUbe3mq/xryJtyj8fb9zdteKvl6FaeQx+bN/5p2Pbg2hSOo34jdv
         Pqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674602; x=1713279402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuOfapBMHMN0JDFA4xRTHh3cbZqcvV44chaTzX89Va4=;
        b=gWB2S/AZ3QjAMgchaTWmo1Z63lLpI2t6/yrfUYsldvetXuAytLks6CBT3Tm5mODQpU
         5GjhOT7WUBnZsJRasF/8GWhmNtoeGpHE1xdOYSod47sm8Lz9fA6RGdB+fkBSBcPewYow
         +Tnv36Ina7A+sTydoNkGY3Ruqxb+KMXjHLBk7Ml6/FWnEjrUo9f8YLK6bk1qsU5Kv1jQ
         AJRpgUmj6T0Rwj1n6iIviPy8OW/XHmldgUkGsr+PPEeDgy+g0Y2F6UAvqSbfi84u91ZA
         axkrCOF+I9HowdNfrccJINjKhWiSVDf+19M+PDIUp5M95V0CbwFr/L7y5UogbkErupzQ
         3zNA==
X-Forwarded-Encrypted: i=1; AJvYcCXLM2aBpebqLCnYyvokvajJ0SpL9PRdobushXW4h3NdiMDcTBwcDKFHw1IWxth6RRGx/SgXncNxi/3gtKGsy2GJEcD0dwnNPLs2wEKLvwlvKHGcHmEti4jp8Mnysg==
X-Gm-Message-State: AOJu0YzCPCT/2pITP5G70g4YDURVel3j4MflJAx5+YdoUa4dcmygVrKM
	hxFM73Vt67BVWxKJL0VucvtRwYCbGfR+1ndjxIyBHt/iiDdj5WIf3NacwQB9+Ha4pf8szReCpkm
	/qN9AxTaWW/pHFwM4rQ45pfwtNzE=
X-Google-Smtp-Source: AGHT+IGUtaOa8kdb2gkML4JaWgaMVMWnlMOnozM33m9RLfbiuC//3D/eCtK74KiCA58Ty7RtH2CEDfqLXqvwdG2ckPA=
X-Received: by 2002:a05:600c:444d:b0:416:ba8f:d980 with SMTP id
 v13-20020a05600c444d00b00416ba8fd980mr550631wmn.7.1712674601799; Tue, 09 Apr
 2024 07:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402193945.17327-1-acme@kernel.org> <747816d2edd61a075d200ffa5da680d2cc2d6854.camel@gmail.com>
 <64bfcf02-030d-471a-871a-e7490d74ca28@oracle.com> <db6480e9378f59c367b03f7455372caf7b593348.camel@gmail.com>
In-Reply-To: <db6480e9378f59c367b03f7455372caf7b593348.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Apr 2024 07:56:30 -0700
Message-ID: <CAADnVQKnkGVL3Snaa-E+EpG536rauWZmn_kZsgQK-oaESfjjQg@mail.gmail.com>
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, dwarves@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, 
	bpf <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@fb.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 7:34=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Thu, 2024-04-04 at 09:05 +0100, Alan Maguire wrote:
> [...]
>
> > Could that be the handling of functions with same name, inconsistent
> > prototypes? We leave them out deliberately (see
> > btf_encoder__add_saved_funcs().
> >
> > > I'll try to figure out the reason for slowdown tomorrow.
> > >
> > > [1] https://github.com/eddyz87/dwarves/tree/sort-btf
> > >
>
> Fwiw, the best I can do is here:
> https://github.com/eddyz87/dwarves/tree/sort-btf
>
> It adds total ordering to BTF types using kind, kflag, vlen, name etc pro=
perties,
> and rebuilds final BTF to follow this order. Here are the measurements:
>
> $ sudo cpupower frequency-set --min 3Ghz --max 3Ghz
> $ nice -n18 perf stat -r50 pahole --reproducible_build -j --btf_encode_de=
tached=3D/dev/null vmlinux
>            ...
>            3.08648 +- 0.00813 seconds time elapsed  ( +-  0.26% )
>
> $ nice -n18 perf stat -r50 pahole -j --btf_encode_detached=3D/dev/null vm=
linux
>            ...
>            3.00785 +- 0.00878 seconds time elapsed  ( +-  0.29% )
>
> Which gives 2.6% total time penalty when reproducible build option is use=
d.
> ./test_progs tests are passing.
>
> Still, there are a few discrepancies in generated BTFs: some function
> prototypes are included twice at random (about 30 IDs added/deleted).
> This might be connected to Alan's suggestion and requires
> further investigation.
>
> All in all, Arnaldo's approach with CU ordering looks simpler.

I would actually go with sorted BTF, since it will probably
make diff-ing of BTFs practical. Will be easier to track changes
from one kernel version to another. vmlinux.h will become
a bit more sorted too and normal diff vmlinux_6_1.h vmlinux_6_2.h
will be possible.
Or am I misunderstanding the sorting concept?

