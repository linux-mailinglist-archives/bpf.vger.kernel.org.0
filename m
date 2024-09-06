Return-Path: <bpf+bounces-39147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FFD96F7FC
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 17:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2949DB21999
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 15:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8334C1D27A1;
	Fri,  6 Sep 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NExWpsxR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810931CB525
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635726; cv=none; b=beKqTIGMq+65lnyyA9pggMPtaB69yQeYYdP06meKhp8ec74OS3fO+LwoAmHqzelJKOEKGM3RlMciDqHgZX/B1RImbEF0GzRQdh4/4yZOGMk4tIRnq8q19vPxXa+GFN4pABgbXO+Bq0pkHMnmwuqxhv0CSGYoL43bXkFEinnsJMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635726; c=relaxed/simple;
	bh=MlCrinc0ukvjgEUDs04pww8xKNdgauirJzoZ/RVqEug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WS45fyPiLkKT21gWRg7ApmBvW8DOR3wx8rxkjZ4l3cPfho9Bv3u81DtkQvuSoWntgX6cH7q8wCcuGJ+Dz3Q40OzsulJeqIjhKa9KBtWpqIJH92caM4nOHmzoe26/xE43RKjlrlFK66rPO00hxd34H33+WPDp4eY40QovhAg8LjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NExWpsxR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso3153435e9.0
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725635723; x=1726240523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlCrinc0ukvjgEUDs04pww8xKNdgauirJzoZ/RVqEug=;
        b=NExWpsxRBsW/HbmTQeYM9uVl7T44h84Wzj2+5IUtdERvUbi1uustLyk52B2oBWss2Q
         XF1kU68TUBKupWRZmiYJBLmAj3zf7S+Yn8K/PT2tsxGp4yewjVu+/u0QTXoRadW9wANC
         K62MEpQvnPi9KZhuMz4yRl0JksZW0L32ugM21A3nKOX3UI72MSAsLhB8UyBNhrVz4QXF
         KzjB/ceZvG3A3TlycMONoRF7B5/44iRSfSZCBh00Cmu2iUNlLNzd47GUm3pDYAtWDkRw
         w7o7WC1tR1lWxyChnEiurEw1PtyDcjQNYMpFfIklikZgTYOZXEZuvVG3cwQbXWZTLcGQ
         Z19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725635723; x=1726240523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlCrinc0ukvjgEUDs04pww8xKNdgauirJzoZ/RVqEug=;
        b=ZdnmanHQHk/xUHWTtUloOOsqbnCl4nvDDOhSa/SCVY4SGCX0MB1swSFeju/fMCf9Re
         W6phCXcZqwO0hJQHwF+LfJZutKFMDQSA8aoM6LBbtseqdgyOW31wJVW+nUqIesRaA7j5
         2hPbaWM/NZdpYs04fwjpQ4mJFrWZEvzCY5XVic0+dlV/5vCixhMP+/mBVi4yF6d8orjZ
         HzAddFverauXf8/cJjFeh+SFBdQBv3GHdTqLQYyaKrk7gQffAGFRsH1IQKgNpvNBHD3o
         iZ63Ht9g8/lhYulkfIGmxSJrnZTIezkIhH6JxSkNSxZzbZS+e7ggknwsKxralV8H0i8T
         Yz/g==
X-Forwarded-Encrypted: i=1; AJvYcCVPqVeOZDtFXRuaD5BvDZgO00IVnpUycoBr3Yqbw3pdk2oFNe7YWS1eT+tjHXLXbHZ0c40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXL2ffMAg0n5DYR11qK00UzT8mdOxiiSKxNIueIky4aVuotJUi
	ZXJwvvUPe6zt/whV5JYMhWkY+l8MS1JmiwfS3JUgblylHbr2t0cwMQyi/lwGDk1S4DxJmObivha
	fHjHlHJzs1I57ckt9qJY5O+nc0Cw=
X-Google-Smtp-Source: AGHT+IFeocGzUPE8lZgnMm84owu1u5HGMhQuT8aFh5unS6ENF+jSB6WbCQco6UjGfar77QCyEO1OQDVhuRtdHSTl/zM=
X-Received: by 2002:a05:600c:1ca6:b0:429:ea2e:36e1 with SMTP id
 5b1f17b1804b1-42c95bbe285mr65960345e9.13.1725635722425; Fri, 06 Sep 2024
 08:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725016029.git.vmalik@redhat.com> <92146771-8756-4259-88f0-e0b61c11ad55@oracle.com>
 <3adea7f7-0e8d-4114-ba04-356cdf9d20d1@redhat.com> <CAADnVQLmo0sOCuF598nL_xoowMDwTEXzjHareG1xiWGPLM77qA@mail.gmail.com>
 <CAEf4Bza=i15HZoZHyvGJrPdqUPbNxEGG5QWTDJKFnbOcT-jPZw@mail.gmail.com> <b157f640-98d0-4be1-ac30-35800032d094@redhat.com>
In-Reply-To: <b157f640-98d0-4be1-ac30-35800032d094@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Sep 2024 08:15:10 -0700
Message-ID: <CAADnVQJvWR4UzhUBf40aJb3hE31f5y3Q+sGMg1WosgOgtHXdng@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/3] libbpf: Add support for aliased BPF programs
To: Viktor Malik <vmalik@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 10:04=E2=80=AFPM Viktor Malik <vmalik@redhat.com> wr=
ote:
>
> >
> > +1 to adding multi-attach fentry, even if it will have to duplicate tra=
mpolines
>
> That would resolve fentry but the same problem still exists for (raw)
> tracepoints. In bpftrace, you may want to do something like
> `tracepoint:syscalls:sys_enter_* { ... }` and at the moment, we still
> need to the cloning in such case.

Multi-tracepoint support in the kernel would be nice too.
Probably much easier to add than multi-fentry.

> But still, it does solve a part of the problem and could be useful for
> bpftrace to reduce the memory footprint for wildcarded fentry probes.
> I'll try to find some time to give this a shot (unless someone beats me
> to it).

Pls go ahead. I'm not aware of anyone working on it.

