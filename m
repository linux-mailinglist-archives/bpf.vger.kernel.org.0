Return-Path: <bpf+bounces-68048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA15CB520AC
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 21:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC4A1BC67CE
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 19:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D982D46B5;
	Wed, 10 Sep 2025 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiuHBnNi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304AE23C4FD;
	Wed, 10 Sep 2025 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531489; cv=none; b=G7xPqVF3pstWwLDUhqWnpZ3yy/FsNjV84RZO+iNCNWzPm+5F2Vre7zhxWPqW6RKbX63S1oy5jexTWr/4j4rvtCOQO1y0dKjwcyDQbYqetSTDR0mvXvIR8jrt+atDhexXP3Ulehf4xEtrD4QNgopKGfm4407/X086Lq+p4qWTu5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531489; c=relaxed/simple;
	bh=BPdDJRjtV20iUQcq9Et449k+dPo0xsDOfYUW7aNuBdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOVNHxL3JMgCGSXkm0ROsVz95R6WLuuH0hQ1pmjR1yOtSnPII8c1tSxBlRtCCIwkyIJQMM3vuYPUY5AC9diVgriXHOHLgG3O3663L4xCkL9rXuiZxYP4FDOpiXjvDLrzQJ6onhKwfLrhLL3MPGTiIlmnIniEImpp//oinV3DlYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiuHBnNi; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-ea0297e9cd4so2908665276.3;
        Wed, 10 Sep 2025 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757531487; x=1758136287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7Nzdb/Royn0V9ZUHLh9FO9ItFQGh/B7jCmsZS8xz2g=;
        b=MiuHBnNiYYPcOdABTUNNogPMs/iQpUzYJV+QwSf9yJoav9voIMRCmlQ/gDlYTjKNJo
         w5ZbSQtXENQu6Lt894fDT++8J5h0X12SN1d5hI7mL1xrpco6TkSR/xa3c66D6JNIM9MH
         tWUaiGait97Slmb8FJtkARz1qxq3zQhBfadkW/4W3Q2NCBhOPQ9zBTca+MECkoky1fFm
         wHOtDwNLbfPUr0OyrS8pxj/7WJnSh6prMCT5Ldm4IDHnKNRIWQH+EIp3a37b4R0zo2wt
         SLXpPo5JyRaTUeeAbvRchqyvfWKc2RI8dIZmYqDTpoV9bYU0b3K68k5KqaHF0BqoUIZv
         I3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757531487; x=1758136287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7Nzdb/Royn0V9ZUHLh9FO9ItFQGh/B7jCmsZS8xz2g=;
        b=C8T25zJ5XJ5uh3EGQ644DPCrtFP6WyLn9NfFE4+nvFxU4/22nZCwUMA+FYATAn9Od8
         KAilGyMuZD7LCzUo5eduRVPEsWiNDRHJgUDMO8/YpDpScL+SRlOAEkDU3J1Y2ozAvlD9
         R4N/6OJ28gUgvU8tKrZ7aZReOpA4LsXiOyS/8n0iLNV8p/xMFvZkdUeMn1EWpOVSijd9
         Sqv/GHhywr7OwoHqGWbvwesoBkQVbL50FAge6Bio38w/3SDedqIpWvLHtl+H2LUMDctm
         DqN+ST5OWbWOyS4yJM1Q8IY/RkWEwZKZGdPsXg0qSbUtu+PQZhEi4RGfMstnBnE2hnk7
         5s0w==
X-Forwarded-Encrypted: i=1; AJvYcCWi3fxMwxxAamGtjW0QRucSIkWKvbMsUO/yljPMKGuIhM0pRLwpTnnQfIH4mQ2EpmyckBlOGuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kvDxOb1QPqZIEBgiiEqww+V9fdEhc9Kd0ekwcMBrKWN7Pw1u
	5nwBJ9ed133GteaYUbHiTcPUr7bS9DYs5QjJ3+ZpRonQJtH9x3+MHOtX6ZQKwxGU7LPO1ZtVEQg
	s7dfIX7BcJtxoEaCwrGD7/7QALQhvcGM=
X-Gm-Gg: ASbGncvgOCm0Bzv4rEle9KSACG+wT70wgc79QzdGSwu6009ETix0MlhauzRqTmBbgjT
	C0JRMfiVp3YOZlHOy9bcQ3DTbirG0SaoX8t5aJNrjn3oO6fZPH4FI9eav5LqWCFP/BDEEDii9BL
	pOXTMuf0BTgt1/tYZjC6q+OtT8d0470l+7Kn/sv7ttrSpmFJOJnO02y9aWjk1UKu+f8dCwKrJLN
	8lM3F/soJRnidjlktChFbGmr1sNTWUQnQ==
X-Google-Smtp-Source: AGHT+IFsfyvL7fXV7slP9gsfFRDNxdl0LL5jBMDMfelSHrfYbMCAGKy7n+J0zelUcih/TTkmNgszQZiIzJTjWdo73cc=
X-Received: by 2002:a05:6902:620a:b0:e97:6e5:298 with SMTP id
 3f1490d57ef6-e9f663f3b45mr14273098276.11.1757531486983; Wed, 10 Sep 2025
 12:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905173352.3759457-1-ameryhung@gmail.com> <20250905173352.3759457-4-ameryhung@gmail.com>
 <20250908185447.233963c5@kernel.org> <CAMB2axPLuQ75_JSqkR43-UVBUi9Yj7juHFLCkDvSLPL445SZew@mail.gmail.com>
 <20250910110457.152b0460@kernel.org>
In-Reply-To: <20250910110457.152b0460@kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 10 Sep 2025 15:11:14 -0400
X-Gm-Features: Ac12FXwPgV-tVy8vogjfnrpHv2alAN4aGjF-GmyoGU8DNuTkVZFl5lSA86A9dkI
Message-ID: <CAMB2axO8rWWuSAo6pfuU5LRL=v43TJjhs66iCk8K4FALKdwRVQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/7] bpf: Support pulling non-linear xdp data
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, stfomichev@gmail.com, 
	martin.lau@kernel.org, mohsin.bashr@gmail.com, noren@nvidia.com, 
	dtatulea@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, 
	maciej.fijalkowski@intel.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 2:04=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 10 Sep 2025 11:17:52 -0400 Amery Hung wrote:
> > > Larger note: I wonder if we should support "shifting the buffer down"
> > > if there's insufficient tailroom. XDP has rather copious headroom,
> > > but tailroom may be pretty tight, and it may depend on the length of
> > > the headers. So if there's not enough tailroom but there's enough
> > > headroom -- should we try to memmove the existing headers?
> >
> > I think it should. If users want to reserve space for metadata, they
> > can check the headroom before pulling data.
> >
> > If the kfunc does not do memmove(), users are still able to do so in
> > XDP programs through bpf_xdp_adjust_head() and memmove(), but it feels
> > less easy to use IMO.
>
> Actually, I don't think adjust_head() would even work. The program can
> adjust head and memmove() the header, but there's no way to "punch out"
> the end of the head buffer. We can only grow and shrink start of packet
> and end of packet. After adjust_head + memmove in the prog buffer would
> look something like:

Ahh. You are right.

>
>   _ _ _ _ __________ _____ _ _ _ _      ________
>    hroom |  headers | old | troom      |  frag0 |
>   - - - - ---------- ----- - - - -      --------
>
> and the program has no way to "free" the "old" to let pull grab data
> from frag0 in its place...
>
> skb pull helper can allocate a completely fresh buffer, but IDK if
> drivers are ready to have the head buffer swapped under their feet.
> So I think that best we can do is have the pull() helper aromatically
> memmove the headers.

Agree. Will make the kfunc memmove headers if more spaces are needed.

