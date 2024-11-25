Return-Path: <bpf+bounces-45585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69A09D8CE2
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 20:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D624284D61
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 19:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0151BC9F6;
	Mon, 25 Nov 2024 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BcpSLoEN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238531AF4F6
	for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732563322; cv=none; b=IszyhPkq+ZV1QwR0vjYwmEGij6wCpgQaGq+uzMrPyv8iJ8ZYUj5dm4XCwwUTFI/SUmPfxThG0UnF6jWeNmu5DQf03b/rntb9csm1fwiZGyUMvEvMdAededdKdut0exElNpnauRvZm5DLnJp4WNcpx3RNe2NLKPg++wKRqgtbOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732563322; c=relaxed/simple;
	bh=54RqcZIEYDefe8bmhEgsgV8Um5TmPfMXzPvftggRdAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8zNihdCyaaro+5tnRE6+L59o21M70l/qHsf94vF0Bj6BchCKAp3tJALiucCMEvMs2iyqbRqlAXHMLY2j/79Z3VWTGpKNgNZoETaa1yyQIfT7e4fYwPLu5oFxrc5S94EpT0whh++/jDJ9lfg/J5DFxafqXNlfbdthHfLDowfwds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BcpSLoEN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cfaeed515bso6301481a12.1
        for <bpf@vger.kernel.org>; Mon, 25 Nov 2024 11:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732563319; x=1733168119; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PWhH05Bm9KZ7sByGo33urKUrEncVx+V1FdurLN08RYI=;
        b=BcpSLoENfybDxiUzVMPvrlVVCOCvvyiUSgj5hZOcseXTNxKolmQ4BHkreWdv4fkOFe
         7inys9jZeTMk6Etx2qSNbxyj0YDMZaMpux3Sq8n4DNX94+aBiP2TVOJjTn0eyGU0tb1E
         xLwhRQ0qkjjI08cukiF14ca23ak+Xm0RYdMFR2dHZtcWtEK9vZiiZTzo6gVutb8ySj3b
         F6YODdQazmtTCeQtRI7eQ/u62/fzenxKT2S+YcHYqINYy83o1eM1QDaJFj/CUg0qvBnu
         KhJ9vydpwq7uIiUTdkX2bSGl0FLwtGHey533QAESrnRD6ON77BagwLiAJWK7sTx8Nb1B
         R8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732563319; x=1733168119;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWhH05Bm9KZ7sByGo33urKUrEncVx+V1FdurLN08RYI=;
        b=h1uEoRzC8qtk0Gkh+Xkmtg2e2yupVDuDXaMy3eQSjhg6yZGxYFeQJrjd2tbJAcYoRj
         G2rn+8aHH4ot9J+DMmD8scJ28SSs7rAYiX7M3620ZU6mU32grab5vBQsZ4IvvnNaOkg7
         ZjH8ZBzDh61crwQZhoDk2bgK1Yd6h5ZlUjaGOA3PBW42g6LRQHIxc8WLYK6C0wP+/Wlo
         PIL5mMx1b1S0r5iWYyvz66ET19H98bkQZzJeEtz+4frre4DtcHL1NXnUXxvU92M4aQ05
         agshZRgpdyzSOCm+EXOEgbQFLymgnUNlaRTIj/e/NtG+cMp1v1D7NQGLHZR+U+FnqVpa
         hPNg==
X-Forwarded-Encrypted: i=1; AJvYcCUo7dsqD4msA0E+GPqZzdBLrrkKzhoPGVxo182iej6pRi4yn2EBENTA9w7a/O5lkb+c+dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB5y14ZgD6nYOI8ZNm7KvgJuZhA73dmdE3S8W/JdxPuCpG/75W
	brkdBC3U2pLSMw+rzBnG53YMX5X+VwZW7oai9sUEmOD1knzw+PsIu13tKFhXaA==
X-Gm-Gg: ASbGncu38/0elk0oG0K7Yjlbez4EZsNjUESKni1R5vbcY5iEBHQ8lusx2LUDDUJ4QpX
	UTMz+RLlQTyGnfvCiZrIVz+oaAdKrmiyXiZJ04+M5orqdskIAaYsFKrMB+f8+vh83UNIhYYCIMv
	eDiMKieDNqZC4nbRsHW8zKxo5GMiah+F7oT/0czehrJFMVbHC/W9Kp3KVA7LbEXqQl1juFch+4o
	EdW4AvhfTvS+WD+n7er5hbfcH3kdFWSzt/AFXLiZlxFHQaSCmHp0IOXMyurS1vkE46aFzkNYuqH
	ymfVbzN10YZRUc5258o=
X-Google-Smtp-Source: AGHT+IEOPvAAr+8PRfHA1PcyllOYQjEhFE9OlwV7vpKSDmpIC7O4Fv+Vu++U2fhwJG2qbtsaRMl7MQ==
X-Received: by 2002:a05:6402:274b:b0:5ce:fa47:18b6 with SMTP id 4fb4d7f45d1cf-5d0205ff1cemr11001676a12.12.1732563319336;
        Mon, 25 Nov 2024 11:35:19 -0800 (PST)
Received: from google.com (97.176.141.34.bc.googleusercontent.com. [34.141.176.97])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa547ffb152sm235348666b.62.2024.11.25.11.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 11:35:18 -0800 (PST)
Date: Mon, 25 Nov 2024 19:35:15 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, audit@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH] bpf, lsm: Fix getlsmprop hooks BTF IDs
Message-ID: <Z0TRc0A6Q8QUxNAe@google.com>
References: <20241123-bpf_lsm_task_getsecid_obj-v1-1-0d0f94649e05@weissschuh.net>
 <CAADnVQ++-VwPnem-xY+Urec0=zi71s-Pmzox+TXYgaVpshHtEA@mail.gmail.com>
 <a77471ed-1c18-4469-be4c-c9e00f8a3b80@t-8ch.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a77471ed-1c18-4469-be4c-c9e00f8a3b80@t-8ch.de>

On Mon, Nov 25, 2024 at 09:25:24AM +0100, Thomas Weißschuh wrote:
> On 2024-11-24 15:45:04-0800, Alexei Starovoitov wrote:
> > On Sat, Nov 23, 2024 at 2:19 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> > >
> > > The hooks got renamed, adapt the BTF IDs.
> > > Fixes the following build warning:
> > >
> > >   BTFIDS  vmlinux
> > > WARN: resolve_btfids: unresolved symbol bpf_lsm_task_getsecid_obj
> > > WARN: resolve_btfids: unresolved symbol bpf_lsm_current_getsecid_subj
> > >
> > > Fixes: 37f670aacd48 ("lsm: use lsm_prop in security_current_getsecid")
> > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > ---
> > >  kernel/bpf/bpf_lsm.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > index 3bc61628ab251e05d7837eb27dabc3b62bcc4783..5be76572ab2e8a0c6e18a81f9e4c14812a11aad2 100644
> > > --- a/kernel/bpf/bpf_lsm.c
> > > +++ b/kernel/bpf/bpf_lsm.c
> > > @@ -375,8 +375,8 @@ BTF_ID(func, bpf_lsm_socket_socketpair)
> > >
> > >  BTF_ID(func, bpf_lsm_syslog)
> > >  BTF_ID(func, bpf_lsm_task_alloc)
> > > -BTF_ID(func, bpf_lsm_current_getsecid_subj)
> > > -BTF_ID(func, bpf_lsm_task_getsecid_obj)
> > > +BTF_ID(func, bpf_lsm_current_getlsmprop_subj)
> > > +BTF_ID(func, bpf_lsm_task_getlsmprop_obj)
> > 
> > Maybe we can remove these two instead?
> > I couldn't come up with a reason for bpf_lsm to attach to these two.
> 
> Personally I have no idea about bps_lsm, how it works or how it is used.
> I only tried to get rid of the warning.
> If you prefer I can drop the IDs.
> 
> In my opinion this is a discussion that would have been better in
> the original patch, if the CI would have caught it.

I agree with Alexei here, we can probably just remove these
instead. ATM, I don't think we could do anything useful with them from
the context of a BPF LSM program anyway.

