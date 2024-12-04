Return-Path: <bpf+bounces-46106-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E309E4676
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 22:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA67B3BCA0
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 19:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC1B1C3C1F;
	Wed,  4 Dec 2024 19:44:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468ED1C3C13;
	Wed,  4 Dec 2024 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733341470; cv=none; b=ZzQdMF5SXYwy/b+ooMTtNxhq/vPnWaH36HMC+6Qt1R7PmWCFTKf9Fy+qtQblMg4MD7QIjW0Gw0HWoXoHKhg3ixGC/1dlcNrFYgiGiwUfYm2Qpq8VL2aOCCEfgjNR+VokKGZrjXlPthdhT21TU/Vie02bmh+U9olkFJ2VXzohk6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733341470; c=relaxed/simple;
	bh=2OOKq6bUnibON4KSB5WcZcAAFsQT+8w2p5cxtRqH3k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCEnZlHAI2nGWsIiJ4QY99WcYpgy6VlMGIlUvYtwojLD1MwEvbIQj3efGjFwXurh5JiqYSzMpoS9Wve79CoQZG9KsRIOvq4mKQ6apBSre1mLpUh5Tg2rqA0cqUMvFkiJKjbzlU9yMj4knTwmzJN0jV2wzaBECimYHpUBsGwY8+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a777fd574bso230105ab.1;
        Wed, 04 Dec 2024 11:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733341468; x=1733946268;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OOKq6bUnibON4KSB5WcZcAAFsQT+8w2p5cxtRqH3k4=;
        b=AUM2J2bdVk3tiINQRRsyPHjrH+qPeoFHDGQdxaF6Ri+Y6B/cxhg8Hc6+czwqbcJaFX
         ssshUHBrzx+CSGG/fU3R77ZVlCbOl9oAgwwImuJl8N/vbe93FJRmEhkS2trTJYaF7N5l
         aHdMs9wQyQ4UWiEffyhRXuiUrfTJqLbupuAYDyFqaYgnHgN/9ZOObDM3+0dJt7JXz4VM
         VBjcXQuWGfJzye5voCX7NIeiti0+mS6fxdNi/xxtHIn+lNPU6MKHLQA/BnP+x+oV9+Jb
         U3z2hSmPNMZJl24NvH/3TIFsKwQ1hIQHAclMrpKozRb6Z9I64fDj3ui/pTYD5QNN3lV3
         NVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRt/8jZoDm62AGIATeG+clIiBa3AFk5oY8SKo7c5o0HQxQN6ZnQ4Y5s/L3+Gbt16iJEMoJ50ronJubtxiP@vger.kernel.org, AJvYcCXkyHEiYjfS47FGa5c2aTMyWWoJyVAx9gDXJ6WJlscqNi74ew8Jl4j3/TvEHCNPMkzeqss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpnZLF4ZZMkdWc2rAZcS0ZqwHWRca55by9+yau6Y47GjIjblvx
	2sI6ykuacxDxnZbqMlk1GYR4NOZR4q/ifuPh4K487ufeJlfxhyU8
X-Gm-Gg: ASbGnctP0gyiv8gNmGz/tMxu34yKMeR/HFI0+xtP7uR9KrdHVxS4Jt/d3dd3NWOnsuo
	ScCQfkUyTO0LI36k6A3kKoZueqa6iToJBNiSTERPhkV+5d0NgCAi8Djyb8HMRA7RBv8aJNk0xRm
	7YDE/5HJRaaxstj5dCV0FiguR0kfU6+VpYjVmm3uXbUQjFn7jGTfM8vEdgI7Urpqq3wT8y5wRMS
	ZlcZhONoZHgAdim+v9FLg5SCKrQjKAD8yhIom6xTXekeiY7q+MWuiHhLYx99X/YQM0Xx6TtNvAC
	s1UsUGKE2mV+0GPO7S819BZ4TQ+hX/+8q/MOPW0CUghtepVLaa4=
X-Google-Smtp-Source: AGHT+IGPdKWnMKP+jsuwHHOrXLJ7n6s6io1OHWLuAhBkpEOkQexcnlFs4DjUj+XnSsDmZ+TiLBY3LQ==
X-Received: by 2002:a05:6e02:1c43:b0:3a7:819c:5129 with SMTP id e9e14a558f8ab-3a7f9a8d86fmr103105825ab.18.1733341468334;
        Wed, 04 Dec 2024 11:44:28 -0800 (PST)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230e908b4sm3143809173.158.2024.12.04.11.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 11:44:27 -0800 (PST)
Date: Wed, 4 Dec 2024 13:44:25 -0600
From: David Vernet <void@manifault.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	andrii@kernel.org, mykolal@fb.com
Subject: Re: [PATCH] selftests/sched_ext: fix build after renames in
 sched_ext API
Message-ID: <20241204194425.GE2718@maniforge>
References: <20241121214014.3346203-1-ihor.solodrai@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CoQCSxelwxipSP5T"
Content-Disposition: inline
In-Reply-To: <20241121214014.3346203-1-ihor.solodrai@pm.me>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--CoQCSxelwxipSP5T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 09:40:17PM +0000, Ihor Solodrai wrote:
> The selftests are falining to build on current tip of bpf-next and
> sched_ext [1]. This has broken BPF CI [2] after merge from upstream.
>=20
> Use appropriate function names in the selftests according to the
> recent changes in the sched_ext API [3].
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?=
id=3Dfc39fb56917bb3cb53e99560ca3612a84456ada2
> [2] https://github.com/kernel-patches/bpf/actions/runs/11959327258/job/33=
340923745
> [3] https://lore.kernel.org/all/20241109194853.580310-1-tj@kernel.org/
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

Acked-by: David Vernet <void@manifault.com>

--CoQCSxelwxipSP5T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZ1CxGQAKCRBZ5LhpZcTz
ZC7uAP9K+fcjGMBK2Tgqp8dK9VEqgHOOPSOJCYVdmKEm8DzxBAD/V0dlQwNs9Esk
NoVmEIg3ekHiU5cMqDRQUfd32wn0kwU=
=5jHI
-----END PGP SIGNATURE-----

--CoQCSxelwxipSP5T--

