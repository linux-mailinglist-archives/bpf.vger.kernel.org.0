Return-Path: <bpf+bounces-54237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE1CA65F1C
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 21:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A7017BD04
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 20:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4C71F9410;
	Mon, 17 Mar 2025 20:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c99hHcpa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3BA1F8736
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742243333; cv=none; b=qYfLcvYCfeeniIyAEnrUcYMTp6op1uCRVGA1GrzhsGMiGRUPVZr5vvzmUc2FHy/xd4yj2A5YAi69C+YFe8a+1wEoAWa1Ote0/MO7jrQ/MJJiWtB6BECeijyWS9H3y0WScIJreOTs3yOizTZDOwndp+9mNHzhSrCPDovB023y2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742243333; c=relaxed/simple;
	bh=6x2L/dcqXaq5QzpGkScRqFPsKo3tEyEPX1HF6xHveZw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tUPvj2KwF13pmRr6bfjEOA32AwvDYx47HBNKT4mDkZjLd5ovrrb0zDGqzljqjfe1Poepp28v0Lra44WhBnV1QMM0+5iFAb2EsIUNhcZCJUJMCrNQBRCX+ASwyhlfyH10XefUlSP3b+M3ZuC8taGv08Mx8wMfnyc4U4D7qAhhBds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c99hHcpa; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3015001f862so3077441a91.3
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 13:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742243331; x=1742848131; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=34A/f3HSE2O1BngjmfaCXc3yl2DN6ZSFSm+EW7ppUco=;
        b=c99hHcpavp1klxibUzk8k8l2ys276Ge03/vk4+5ouc7s5SUTHjMIb9RQIrK5xA7DOM
         Puipw+DaFIJt57KgzYvbUNN3XKmF9ppldQIYUZ8Uq30PnYNduu+AoyBOxnZ0uI8c6Gre
         TyXbbGJ56y7mZmv57PCVtzgiAYq6xZWR3YQTxtcmO2djY2nuHorThiZQU70Vm95+xZ9j
         2Z95+bvEx9SkiIoG3u4bDzRz1B4qg8FLH1TYm8zSKfVEHg5EKKMC+/kyVk0ZCtqdGsMu
         aO1v7RXCLzFI0QAV7hq1zAK2aP6A2EIInO4zXg5JXa4vw68T7HYhUM0d51Lrv609YlXZ
         31Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742243331; x=1742848131;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=34A/f3HSE2O1BngjmfaCXc3yl2DN6ZSFSm+EW7ppUco=;
        b=cU8QLEKNrpf9St/3qPXdkYGkiadePt1adxesSh4OCPZ0udaqzajoceUEZcXmb+yDHQ
         AhEp9ZEnGrycvkp+fg3foEJglAgf2V3g7NriWhtRyDA88DHAQxbWAWWOD+xbsby6JiKm
         2fgTL30WkQ5v2BkFy+hcn17F2URQUdLCgWiGutCIFIhMpey4VE9buUl5ojovSCbxH27c
         iGytQLBJkBszIGzWSKBzvjQBbUg/kbC+XHlxnNo1iwX654w9mjvtcePSCN1iCMNfmLka
         wqCgTTokflahaA2FtOiT8BKwjBwEwFvAWj5WVKKHPbng3roAl+56CCjr5i/2fAfky98H
         VBlw==
X-Gm-Message-State: AOJu0Yw3p24K1kB1YkEcyvJL4zh0S+R/WZZ2lY+FTjzl7ynFGyWJUqQ5
	BVnh9JhV8ZexLnNHpzWhCh8CPUG4RS9B4WK3p5DUi9DgJE98OrWm
X-Gm-Gg: ASbGncsjVVfC6xiisaId48Cb4yin/8Sw7+ZTM5Hojz1VqdUrxralr9H93th/5jx5dqt
	covwKTSzmv1TRP6g8yIyKP5ItgTSA6gTzVx+HzS2U6j4tTyel+UF7CWRiTtCEKgqgVX3LLrnEAM
	dK5HbrtWOjQfu1jFWOoSEeVsAlElHBsRHpE4m2vTVDVRHbS3pS6h3HRZlHTompCcKOrtsf82xtX
	cgv6E5/TCJDGEOR6pVakG6mfarjcQDyq30Zr/M4bUHc1kCyAb66dJPW+xJg0HvlrgbDiLQENhk5
	1ewDxZPyDcDdQpuSCHrBp0uZcYooafI3Rud1h0IJkzKNszuUK3A=
X-Google-Smtp-Source: AGHT+IFtaItXMMhxCwl9Xju05Hxf9m5SpDWy5IWEdmqLkDU3xr3QWIdTyuGGH31JUnfj47pKxd19dg==
X-Received: by 2002:a17:90a:e7cc:b0:2ee:ee77:227c with SMTP id 98e67ed59e1d1-3019e8f3ee2mr1227486a91.3.1742243331464;
        Mon, 17 Mar 2025 13:28:51 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153b994b3sm6506013a91.30.2025.03.17.13.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 13:28:51 -0700 (PDT)
Message-ID: <1b1913448e28d0d6beef5c2f47a033aa44e2f336.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: states with loop entry have
 incomplete read/precision marks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Mon, 17 Mar 2025 13:28:46 -0700
In-Reply-To: <CAADnVQKBdJsDWVCNk2LaEc7ZTPFOEeQrRgoEiio4YWFYsijkcw@mail.gmail.com>
References: <20250312031344.3735498-1-eddyz87@gmail.com>
	 <3c6ac16b7578406e2ddd9ba889ce955748fe636b.camel@gmail.com>
	 <9190c8821684a6c75c524c58c6d54f7d9b2366e3.camel@gmail.com>
	 <CAADnVQKBdJsDWVCNk2LaEc7ZTPFOEeQrRgoEiio4YWFYsijkcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-03-14 at 19:51 -0700, Alexei Starovoitov wrote:

[...]

> Looks like the whole concept of old-style liveness and precision
> is broken with loops.
> propagate_liveness() will take marks from old state,
> but old is incomplete, so propagating them into cur doesn't
> make cur complete either.
>=20
> > Another possibility is to forgo loop entries altogether and upon
> > states_equal(cached, cur, RANGE_WITHIN) mark all registers in the
> > `cached` state as read and precise, propagating this info in `cur`.
> > I'll try this as well.
>=20
> Have a gut feel that it won't work.
> Currently we have loop_entry->branches is a flag of "completeness".
> which doesn't work for loops,
> so maybe we need a bool flag for looping states and instead of:
> force_exact =3D loop_entry && complete
> use
> force_exact =3D loop_entry || incomplete
>=20
> looping state will have "incomplete" flag cleared only when branches =3D=
=3D 0 ?
> or maybe never.
>=20
> The further we get into this the more I think we need to get rid of
> existing liveness, precision, and everything path sensitive and
> convert it all to data flow analysis.

In [1] I tried conservatively marking cached state registers as both
read and precise when states_equal(cached, cur, RANGE_WITHIN) =3D=3D true.
It works for the example at hand, but indeed falls apart because it
interferes with widening logic. So, anything like below can't be
verified anymore (what was I thinking?):

    SEC("raw_tp")
    __success
    int iter_nested_deeply_iters(const void *ctx)
    {
    	int sum =3D 0;
   =20
    	MY_PID_GUARD();
   =20
    	bpf_repeat(10) {
    		...
    		sum +=3D 1;
    		...
    	}
   =20
    	return sum;
    }

Looks like there are only two options left:
a. propagate read/precision marks in state graph until fixed point is
   reached;
b. switch to CFG based DFA analysis (will need slot/register type
   propagation to identify which scalars can be precise).

(a) is more in line with what we do currently and probably less code.
But I expect that it would be harder to think about in case if
something goes wrong (e.g. we don't print/draw states graph at the
moment, I have a debug patch for this that I just cherry-pick).

[1] https://github.com/eddyz87/bpf/tree/incomplete-read-marks-debug.1


