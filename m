Return-Path: <bpf+bounces-46446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45FF9EA441
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 02:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78394164860
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 01:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2A05588B;
	Tue, 10 Dec 2024 01:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gny/pZxU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C790282ED
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733793887; cv=none; b=UCg9RR+TwosmdUcANL/LdqeXYqRvytWaAYgXBYyoIFE5GzI/s6qnUkCHmTKE0G0hjWkAgOXB6sC17N2NcBFJijqjJlwtfAlGIAR0M0+TB+0hAwo+V0mYj9LRnT/tNdT9oAA09muqZ79KhooZVb9NZIp8DXL92lNS7uBTSdxm6HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733793887; c=relaxed/simple;
	bh=27PRSVK9SCoaPFrRbJr0ijtH/VbQydAOcdWzqA4BnHY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=otiDPi8hezlghwZOgOfXNZql57vi84tdq+me+2nDWvne0zDXbTw8iEtHEp5yH7dW4lo8wQHsDbLjOGAl8i/gGepPWp+7JLQzUgwXLOytgwPlXvbDYttDN8ZnJ18K6WgA6d16gw4osnvfFSpALxnImEx1RhFSk+ot7k77Ipwn7IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gny/pZxU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725ef0397aeso1383096b3a.2
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 17:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733793885; x=1734398685; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=27PRSVK9SCoaPFrRbJr0ijtH/VbQydAOcdWzqA4BnHY=;
        b=gny/pZxUCKUFFyEAUZI3D8NaTXiOQr4rcRihFpPHED/pZJRwaCqwhYYdjqbnm5CsWy
         372zl/xvRjySoO0YmykMT9SVktxwuJ2tF1G7wDrUhaBqYTUfJ1O09ddZmC95aQmrBFvK
         2fKpbX1HffrhlZ1718ADyElhg7XE7C4bj9f3Wnd0lKNQzynYUk+6OczFWD6SfyT23NQW
         6VbazXpLrDYzv5L+0Do4wyKBwfAIcn3LQZwDenkuVsv3OxzlEq/1UIOpSyFoeYITOeOT
         SV9f+7LKlnRTQ9cFAShItaWYg6JTh7EPjmt2oqt6DyMCW8lBb+7OM8BzVsRLGO0zUvS/
         P9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733793885; x=1734398685;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=27PRSVK9SCoaPFrRbJr0ijtH/VbQydAOcdWzqA4BnHY=;
        b=wulA90ZaGSkz5nSIVW7ZZzDrFdM++jxWuLH7fLb1trZyNyaKrKcqYoehulnN/klaNa
         TVXIvToH/yRuq4UZrpQbMJkL7SDMVpX+ePgU0d7mrj7kic+QXthBG4c1VM7M2orHL66/
         oU+G2Zo4PfQ2XMacbgr2oQbDP5Dv7z2HK6xTygXECtNK3i9mi2OqZZ0G8haXsw3IVzrR
         xXtBth1QwBNWmCt1ncxBLaD5DLIYR/U9Ac4CRtdiDnQBvZd9Bckah6ZT9L8DimbpADG9
         y7yIdmvvdktBTxW91bq0gbKl9h03Ho62X4WPfa1CDFOH//3f/+m8hX+eFj23qHFD9EnK
         L+4Q==
X-Gm-Message-State: AOJu0YyGYwAcVhouH4zbG+PKnJLUce5455kwSVUuMLvzpPEtKm+HX0lH
	MivzCa5Hb8j0NwxyYcWR69BrmrP41es1+6pGRxfLiPsAz6PRxvUDNJFqmA==
X-Gm-Gg: ASbGncs0b9CJX+MHuDk0e1VNUfL+A9jVtQmMIyhAxekamsnbBm7NF8DLD+sN/JS3bbo
	n6mZwTp45tUR7nQGhZJZl7BJPPojkrV8SE6NVTiIzF7G/9uaZEss0aryYFZBRA243AphDqU8SQ8
	noqwsPWzkOsTRFNrA62lvTjyKh2YxoxxpFMzRMeVjMbWR+bPxg1B7rDV0h6P5YOcG4nC9v2fs9Z
	3/KfnVAgZBm44ha3kuF35Hih+1Es8CC3kuoagvTW2g/kpPcbc4=
X-Google-Smtp-Source: AGHT+IH0TjdlvkfQNquBZ6nQL4rJgIBGe68ZGQoyjHL+rLqTzQgaMu+aj3kV3outFvlX4M90qlDmZA==
X-Received: by 2002:a05:6a00:2381:b0:71e:573f:5673 with SMTP id d2e1a72fcca58-725b8144a42mr16003250b3a.15.1733793885478;
        Mon, 09 Dec 2024 17:24:45 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725ea4bbd3csm3011891b3a.112.2024.12.09.17.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:24:45 -0800 (PST)
Message-ID: <8f620e10edd75367fbb9e2cd47eb40872350eefb.camel@gmail.com>
Subject: Re: [PATCH bpf 3/4] bpf: track changes_pkt_data property for global
 functions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>, Nick Zavaritsky <mejedi@gmail.com>
Date: Mon, 09 Dec 2024 17:24:40 -0800
In-Reply-To: <CAADnVQ+RNBq+nHO2J8m-eaZ_5K=dHk7BBOAwk399e+6qwoybUA@mail.gmail.com>
References: <20241206040307.568065-1-eddyz87@gmail.com>
	 <20241206040307.568065-4-eddyz87@gmail.com>
	 <CAADnVQJgLj6qPUtujg0a0fj7Rifv3L3LL3F5abs6auf6hAhKGQ@mail.gmail.com>
	 <6546c0418c00ab378ed8b6a0d8da1b22778d88df.camel@gmail.com>
	 <CAADnVQKDDpFFkaR21o5cBU5Q0dqBgP_0c9KWt1t5ADLV1yX=HQ@mail.gmail.com>
	 <58dbb0671ad59507e45c3f5ff50da66b0f8bd36e.camel@gmail.com>
	 <CAADnVQ+RNBq+nHO2J8m-eaZ_5K=dHk7BBOAwk399e+6qwoybUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-12-09 at 16:48 -0800, Alexei Starovoitov wrote:

[...]

> Also either inline global sub-prog traversal or the simple rule above
> both suffer from the following issue:
> in case prog_array is empty map->changes_pkt_data will be false.
> It will be set to true only when the first
> prog_fd_array_get_ptr()->bpf_prog_map_compatible()
> will record changes_pkt_data from the first prog inserted in prog_array.
>=20
> So main prog reading skb->data after calling subprog that tail_calls
> somewhere should assume that skb->data is invalidated.

Yes, that's what I was planning to do.

> That's pretty much your rule "every tail call changes packet data".
>=20
> I think we can go with this simplest approach as well.
> The test you mentioned have to be adjusted. Not a big deal.
>=20
> Or we can do:
> "if prog_array empty assume adjusts_pkt_data =3D=3D true,
> otherwise adj_pkt_data | =3D for each map in used_maps {
> map->owner.adj_pkt_data }"
>=20
> The fancy inline global subprog traversal would have to have the same
> "simple" (or call it dumb) rule.
> So at the end both inline or check_cfg are not accurate at all,
> but check_cfg approach is so much simpler.

I don't like the '|=3D map->owner.adj_pkt_data' thing, tbh.
I think "any tail call changes packet data" is simpler to reason about.
But then, the question is, how to modify the test?
You suggested bpf_xdp_adjust_meta(xdp, 0) for 'xdp', and it is a good fit,
as it does not do much.
For 'skb' I don't see anything better than 'bpf_skb_pull_data(sk, 0)',
it does skb_ensure_writable(), but everything else does more.
Dedicated kfunc would be cleaner, though.


