Return-Path: <bpf+bounces-67882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE123B501EA
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 451F27A81B3
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 15:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7E2D24B3;
	Tue,  9 Sep 2025 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9rYV4OX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885904AEE2;
	Tue,  9 Sep 2025 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433238; cv=none; b=tdHwFnm5cHWrZMYjOcKdU5ZsqFICFL7CHmYD03/Oqv/cWvFg1gBoxhSNJJPkpTo2gDHxEggQR6HbcqwROhynFBo/cdOXe548cx6fAVnjTZZujQblA9ywn7DJLZdXQPBQFZ0HXJnfP1Ny9dLl1eNxr+wc/Xn1xb27oy22ZF0Jzq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433238; c=relaxed/simple;
	bh=24Ap9yBlbA18UP/rid/bgzN+Ovy08a7T6qnq9Spfuto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6e+JlrwebFXnjiexuyp6n/hBZMRzN6BvoaHgvrNbbQi7VKyA2dyNcji55lH5zvNgRZkxyzcZwwi/Ozd+4oYGXkfYcEasobf/7xZLWywykrXqNNYRQ7Un2OfQCsMNwDRCj1CBgU42nuvVMwcScHxQcIZCllMEvpAtn4KH7Rh5po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9rYV4OX; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d5fb5e34cso63141697b3.0;
        Tue, 09 Sep 2025 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757433235; x=1758038035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24Ap9yBlbA18UP/rid/bgzN+Ovy08a7T6qnq9Spfuto=;
        b=S9rYV4OXWTd+vTWqHrVtGms4wGuRKev/bhDDmUPDn/Ke+qS27dS0XjDhSBlxvLK5e9
         fZ0XCn+P7AYuMtQxz2m8yl6x5mOE/EBl1Lzk0Cmwyx0b9AdKrUy/TyoFq95KJAvRE2qK
         3UVFzsA/cLPWo9gASmIWye7WY5zHK633YKvcbcBzxy/MJIM/N4MLqGOGaPKdAXKfp+MY
         WapRZlLMZeObIBjL46RGLtNifPld/rrZzDzKFUzk9VALVjcZmKUl82SqBQ0h/oFbSL19
         dSXFObw19AnMBb6D8CtEOhHYvDFaqtRZLiSzVinWkpFWBFq0jLe65cD1SRu5hFNkfLqC
         EcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757433235; x=1758038035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24Ap9yBlbA18UP/rid/bgzN+Ovy08a7T6qnq9Spfuto=;
        b=NUiX/fTgBaXkj/WGLnGeQBCXyjWki1d74Q3QvZSWKc8eaJB2wGxz/MwEn1E1Mv+FHB
         6kl10x0eydVzV4JvqOwP63y3QlTfbj0lu5MfgarF2fYcp1o2Zd63YHHDmcOONhoRoBYd
         NrOV7E1pFriEi03szBQIUh6/+W3zASYdcnCE+p132WIgRarVGcMIyTX54UauDOA2W/9Y
         DA0hlOUnrODd4fNW+l6bBew4WBHQ/FP0PrJ/ebaTfT3rMtO1WFaAsWycpdyO1MPGfY/6
         U3oPNxd65L7UobvwFRIXkHXqEZgoQfRE5csdQvWZWFamsRKbHC4Ekr//Y48MiY+eX2ZX
         E0IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGpAFVn7AhZ8B74exC3ICj9gm5N7lEebPTSm/8fBTjdaT/jnJkIeIyb8uzXncBNTNm1y7DNz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeF9pZ0Kim/7Pi5aEs6+lEF4nDRRbiYRZl2YMV/LxJY3Nql6FD
	brfkJggOyWR+UdggkAo5LZkePRT6fWdMkY4SahILZqBK1L8W06r1gW1Wxar3kFPbXVo5ek75cqJ
	TsnpI+FKgjKwEpRHMg1yYxwXBUcBifPU=
X-Gm-Gg: ASbGncuU8GPECDL4C/1NA7IzKtG2EUQyLdqDbZ4MvKRLgRmyglwyHI4t/VtH0BmyiRk
	1YLdzxH51UVDowOXgo+6qa3YN0QrShOMOPvzd158O6kJsjQhDi0IRFE97RGGubL+CbJzWcW5tO7
	evkOeP8qVtC2tY+/wRiISbiwNj5kCyu9tUDve9ughe+c8o4y+2eJ8o8/t7dsJ1Y/Ca8VBkQ5QU+
	qL2oXw1eygiFIYFDYztizgkD5N21fQBZw==
X-Google-Smtp-Source: AGHT+IHlCQOYnMwyVYiDM5aI/e4xv9t8cbjkHouyPeuWZ/nZ+oqklmpcbYhzVXL8qFc2PXbUumP5TaVc5LlCeZLefEA=
X-Received: by 2002:a05:690c:fca:b0:72c:2eaf:1cb1 with SMTP id
 00721157ae682-72c2eaf3527mr36353197b3.8.1757433234097; Tue, 09 Sep 2025
 08:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825193918.3445531-1-ameryhung@gmail.com> <7695218f-2193-47f8-82ac-fc843a3a56b0@nvidia.com>
 <CAMB2axMk63AAv13q2QREn--ee-SMCwjhtv_iPN8EsrjN1L5EMw@mail.gmail.com> <19e4aad7-c4ab-49a4-9be4-28f464e6789f@nvidia.com>
In-Reply-To: <19e4aad7-c4ab-49a4-9be4-28f464e6789f@nvidia.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 9 Sep 2025 11:53:41 -0400
X-Gm-Features: AS18NWDl4hMGNevI6U1vJfuvKsz8jMzfDQaKXxPcRhXL3EJ5_2ghIq_ByCNxyPA
Message-ID: <CAMB2axOJXqHu3QZNCtCKNM8ScuoQU4SWTHgcYva=+62YUydCHg@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 0/7] Add kfunc bpf_xdp_pull_data
To: Nimrod Oren <noren@nvidia.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, kuba@kernel.org, 
	martin.lau@kernel.org, mohsin.bashr@gmail.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, maciej.fijalkowski@intel.com, 
	kernel-team@meta.com, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 9:21=E2=80=AFAM Nimrod Oren <noren@nvidia.com> wrote=
:
>
> On 05/09/2025 1:16, Amery Hung wrote:
> > On Thu, Aug 28, 2025 at 6:39=E2=80=AFAM Nimrod Oren <noren@nvidia.com> =
wrote:
> >> I got a crash when testing this series with the xdp_dummy program from
> >> tools/testing/selftests/net/lib/. Need to make sure we're not breaking
> >> compatibility for programs that keep the linear part empty.
> >
> > ping.py test ran successfully for me. Is this what you tried but
> > crashed the kernel?
>
> Yes, that's odd. Is it possible that the native multibuf case was
> skipped over because of an older iproute2/libbpf version?
>
> If it's helpful, I used iproute2-6.16.0 built with libbpf 1.7.0 support.
> I am able to reproduce the crash by loading multibuf prog directly with:
> `ip link set dev eth0 mtu 9000 xdp obj
> tools/testing/selftests/net/lib/xdp_dummy.bpf.o sec xdp.frags`

I can reproduce it with v2. Will fix it in v3.

The bug is that sinfo->flags is also cleared in build_skb(), so later
xdp_buff_has_frags() will always return false and no data was ever
pulled into the linear part.

