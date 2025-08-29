Return-Path: <bpf+bounces-66986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4628AB3BED3
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 17:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0A618981EF
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5D032254B;
	Fri, 29 Aug 2025 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL0L+xjl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69C320CD5;
	Fri, 29 Aug 2025 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756479902; cv=none; b=cY3yQWEjBOJBOWkWhfx54R6akL7F/8ZBJV5ZYbYQx7XBk2NEzTyOavYQqsq+0iWG1v8jjSM5PvUPLlNnaBbPReVesBvDIu6FWfFMKj0b6lq1l686ksUwTJs9eQF/4N/Sc01hE3QczxlJeUTp+ZShxUtV3OJU4BeXJ0wXbJaLXj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756479902; c=relaxed/simple;
	bh=xtU8o3RRKlATt1ZkDZoqGZInz4LA3xlvTSiKt6WYT3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hod53G5QAZS6i7DqYCUYgwplRhXBJPXHxxu8sci3MnKcZVihPvnVlAZWJY2+sfC+X7qvzrtaYz8KP+9C4igIItO78DCfCDw4bXS+HaOZ+3iztfEZg3fZcfBhrlo96L7E/BhM0/xYjxd4kRjlsvCq+cmqgzbNMA9V4/ITRVfaQxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL0L+xjl; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-74526ca7d64so1825829a34.2;
        Fri, 29 Aug 2025 08:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756479900; x=1757084700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xtU8o3RRKlATt1ZkDZoqGZInz4LA3xlvTSiKt6WYT3E=;
        b=UL0L+xjlcYxqac//yMFsSf2xAtZdfsYphdBxn58T6Q33LeyXlDUYPPTRHsxLDKK82M
         Gx20Y246DcEGHik30/Vglq1syNcfv+f5DbpU6PRT9Xn+Xoa+LjFIniUUEZWDu8aAWpTN
         Lwhew2gxTBWpylX9FMlJHI7KoQMMGtAQ8rStgsxF/XNx2/8UVtlVuY6cVN+hMzasO0px
         a4d6kx9BEQ8lSKgxqRXG3df+04c3Wmy6H55P7ZhjORoVDd0t88BHFmGZuTv/aCqkfKAa
         5W6Oo6FgTkpoS2SgpT7HUx9IQR2ovJ6g6v9oPlg8YASMzwYT+EybHssh8qPCNGo+x27i
         Z2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756479900; x=1757084700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtU8o3RRKlATt1ZkDZoqGZInz4LA3xlvTSiKt6WYT3E=;
        b=nCWMb4Q4o84yc7pVZXkiExnSAKUDwWaDqjzXZ/qK8NYn7r5ZGwuN3CAsE+PmN+YoE4
         UQmogKg8r6nmyFbQrAXiiwBbq32xHCgxcW026f9roI8gOsrUx7+y49JKPU9KFkI0p3Y9
         WDif0uwALU7xxhPa41KPbgNRKBb8i5X8szzk4e07PX7r/t5I2h4fG6kXOM5vpeAiYlEP
         DKGUSllVU0GtMErEQQsCLYqIvvUHAMss3u0eg+gkl9MUZBCZmFCjwSGu9dQe4WcuzuJz
         AZ4CG9d77tvsNGhc+MHhV98W6rAPl4coqfFD7863WaxgU1zmTEpGci3NbfVnT8sVjl8a
         u/Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUKo5zTR9R6oV2U4bh9PWXKT875MPmf1b9taBKfvjVA4ILvUVYcX7CakR9b76OYazgN3QO+OZrwXYwv+edI@vger.kernel.org, AJvYcCUgEdEPAqMgO1KyQJLAunak7kLd2HwOvsB4eTL2OFTdGYPvJOu4sivv2nvoZaZxJPqBL9I=@vger.kernel.org, AJvYcCUr6UvJbQmJTjbdyCTSDnNiUng1sdsVSOcOrIszZeL9y3iQfZUAeSlBnNra9WCXMpENucBPhSpl+3s=@vger.kernel.org, AJvYcCV1EuCkugrRpVHAU7DfxH2J4BkkeG7ApGj0mA8c1zRsXFpd+4kEjqaTC+Cbvz8d89PVpeHKuTfXY+2ulh8=@vger.kernel.org, AJvYcCVG0tPGbuhr7OCgkCqZYlj8t99OvdkGTY2ubKVe5fxwOWtTYddJqN281naJfbJN5V/mGn7qX1uIBcJP@vger.kernel.org, AJvYcCVeYk0FHzJwE8qw9LDBaHcRik1aKym9gI5zq6gNYraMauY/JMRuMeJEd71dEBEq1rLs8ShAQrJTDD5snF0=@vger.kernel.org, AJvYcCVkpFNkW03sxni6lEhP5PHYtDvNKXAKUW5WPXZovQQ0IWOiGZO3UYdsiTpTx78pVGR+TsqA06TSOiPi@vger.kernel.org, AJvYcCVo14Anf+DPJAVcz9EUWGl2noH2gemSiIQwHMHyDyXeBTq7dwoOUyYN+btrihRjOgqHcmcTBhle@vger.kernel.org, AJvYcCW4jAYBwOxzxrAgnPgJtteSycpdIc3s0Ue+ENFMNLCBNeGm2jvJItT1l69vCU58xujt2uglgbTl2GY6TvdH@vger.kernel.org, AJvYcCW9O9bdlN+zvqzvV4eJjBzPB1vmgFymzT38M02iEAhC
 uumUff3cyWssmKFZ/dhVL9GYUOKfetPEhnzM4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqnowe6BG0Kiv/NHSCns6GtIE6qUF3R82LKWKO4gRlnIW3Fult
	YIQ/HBOmsYEu1029ZwZgCXHzVg0zyFbDUE0EcBLHtZzZEEapOlMHm/YH
X-Gm-Gg: ASbGncv71ccvPHCEKErgy9F+LnM8h1WER9+6qTZZDUvVEl+zN7j64nGscXe7p5QhNtV
	HsKXhvVolwSXf1+/OouULynDMSsOre3HGGQsTH2vGY2+E4QN+0mjhXVzHDsc6JGJR59ODzLyYOu
	bR8v9Q9DUqyBMKTvUthBgTPtLIPtWeYfBFqs/BnmDOBiNjiGqxNDjy+DZxRT5LTKGjQFAuOEa/B
	yy2lNKj9Sgpi5leu1zFtsqun3c1F9/lAdRrxqIH4J6C954aQ4sBsxt3pgrPlHUPZpALH7skCUbe
	Q2cfEeyeWwf1R7rh5Ysmip9yqpLC9vJ2GyKIAHvI85tlXsJD1ItvN1BLWA73qNJ6x/qwZeZKlF/
	ZiYcxJZBeDxHBUCh0dk8LSOplDg==
X-Google-Smtp-Source: AGHT+IHoYRW1dTyT65+rU4V7sdHQy1ZAWCnUhYSUduVJT7h6pncITh0MMXOlALcxWQkuMLP36zurpg==
X-Received: by 2002:a05:6a21:339e:b0:243:9b4e:281b with SMTP id adf61e73a8af0-2439b4e296dmr15525181637.49.1756473541271;
        Fri, 29 Aug 2025 06:19:01 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bac60sm2408193b3a.63.2025.08.29.06.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 06:19:00 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 51DA0409D7C0; Fri, 29 Aug 2025 20:18:56 +0700 (WIB)
Date: Fri, 29 Aug 2025 20:18:55 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jani Nikula <jani.nikula@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DAMON <damon@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	Linux Block Devices <linux-block@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Linux KASAN <kasan-dev@googlegroups.com>,
	Linux Devicetree <devicetree@vger.kernel.org>,
	Linux fsverity <fsverity@lists.linux.dev>,
	Linux MTD <linux-mtd@lists.infradead.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Kernel Build System <linux-lbuild@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Sound <linux-sound@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>, SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>, tytso@mit.edu,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>, Andrew Lunn <andrew@lunn.ch>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Alexandru Ciobotaru <alcioa@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Steve French <stfrench@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 00/14] Internalize www.kernel.org/doc cross-reference
Message-ID: <aLGovx7OpL_85YTf@archie.me>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
 <437912a24e94673c2355a2b7b50c3c4b6f68fcc6@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v+QeNeXg1wIV/8Z8"
Content-Disposition: inline
In-Reply-To: <437912a24e94673c2355a2b7b50c3c4b6f68fcc6@intel.com>


--v+QeNeXg1wIV/8Z8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 03:18:20PM +0300, Jani Nikula wrote:
> FWIW, I'd much prefer using :ref: on rst anchors (that automatically
> pick the link text from the target heading) instead of manually adding
> link texts and file references.
>=20
> i.e.
>=20
> .. _some_target:
>=20
> Heading After Some Target
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20
> See :ref:`some_target`.
>=20
> Will generate "See Heading After Some Target".

I did that in patch [14/14], but I had to write out explicit anchor text
considering people reading rst source. When they encounter checkpatch warni=
ng
and they'd like to learn about solution by following See: links, they shoul=
d be
able to locate the actual docs and section mentioned without leaving the
terminal. Before this series, however, they need to click the https link
provided, which leads to relevant docs in docs.kernel.org that its source is
already in Documentation/.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--v+QeNeXg1wIV/8Z8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaLGougAKCRD2uYlJVVFO
oyLxAP95mJgSRTOQ+hTC3+7/hjakAGgQRjyWnfFgZF9dKlXeHgD/bJRCDtPLAnbQ
JLSf5TwAGdo1LgUd0wgEgetqhpMKwQI=
=82dj
-----END PGP SIGNATURE-----

--v+QeNeXg1wIV/8Z8--

