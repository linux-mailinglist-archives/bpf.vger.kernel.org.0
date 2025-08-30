Return-Path: <bpf+bounces-67065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 087A2B3D02D
	for <lists+bpf@lfdr.de>; Sun, 31 Aug 2025 01:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16D21B249C6
	for <lists+bpf@lfdr.de>; Sat, 30 Aug 2025 23:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37DF266B66;
	Sat, 30 Aug 2025 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIVg8xKD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA95A25A65B;
	Sat, 30 Aug 2025 23:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756595495; cv=none; b=EVq/n4WtDGjBOz4JT6VdBGmszQwhY8aBKs0/Eqynd9ew+OBjIYZtDi84sP7ljDazyswaMfGZY26tUFdNO3GaFwh8GV8rutmwaB0GD8mOpr1Nzsss8cS2nmSmoLP6HxGgHJDJWc4L3xW1ZDhqnJy4t6DVMMbGzwzg5rTf2dvZiVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756595495; c=relaxed/simple;
	bh=pKJR3d1y6/pE646jp/qQ2LVHmuXD7qWjBS7Rpy0QVAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t913QYLO23eQtM7qxBDzlf11RFzSFT7d9dYj8hDzGEvuAsOdvmtWG2KQ/XipqugD+AxmcTBLaiRPN0w8u6+Dm9gwswYjSdApx0LBHBMgO5C10NgxHdkQ3SyDBOeJC6ILHHmhAL3n5ARFjItIevfLGmtbHrDL/ufT/0UgZHRu2F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIVg8xKD; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4f1ee2e250so218252a12.2;
        Sat, 30 Aug 2025 16:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756595493; x=1757200293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKJR3d1y6/pE646jp/qQ2LVHmuXD7qWjBS7Rpy0QVAg=;
        b=TIVg8xKDK8jOd6uAUjWKvjYMF0o3z9qT2kTioFTpikXbNdl8/U32G3LsyTrnVa9q71
         28HtSsFm1Kj35XAgD+pyJ7d69a78HT0ccO+A4pp2W+an/UJsBws7ntMQs7siDyINTtYp
         ONkchYQ+dIkHDhnbsD1yXmuYmsgjhCuB+Crm2du1ZtScalWSqYDuo1/teSqVj0ThWBZ+
         kO52RyQ2FghkncBplB8yixYbgEblHVAWEdjMknp794codTxh3Q/bzjT3oR9ep9sqhVy8
         yuZXgHcBln+TVkLR1+XdoB1HMAPguEMwMXhwaDsDY6/wgJjIhyuSOn507LH1BTND7a0F
         uJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756595493; x=1757200293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKJR3d1y6/pE646jp/qQ2LVHmuXD7qWjBS7Rpy0QVAg=;
        b=F1UxlTncWX1CSiQyQWD8gZ02Y5cCHqcUEHaKhzb4ggry4qYYQsWkeNznApZFHN7iV1
         ygjL7HqYNJ20OFU0zvVGJWAg5riXTnXWqxQdcpU8Cn4DMdWx6hgPMx34QVGUuksGK8E/
         5vDRS/L+rAYDPshQJ71VGrUo0b0DuScVSwnbC/npHOFclT390Ar9eoTY9rsn0lVfDtZG
         Qk6vQQwNoJ31U6zd8dJmaqLGrnFrY1IIYdRTlv8lmEKmhRdhcFCsA67KhQGa8xaLFZo/
         j4fZLK+g1egP3bKnuGwau8Ch/1Dkdh84j7NEB2LD4G/O8PZaUBnkcP9Pg2TUVS5URsOG
         E9jw==
X-Forwarded-Encrypted: i=1; AJvYcCUGOu/NjOZ63m7hu5Wv6Bq5b5kSwMz0VEwKvexcvgDVNsdeQA3wd34y+IHK/lBgJiSSh7u0VXv2il0=@vger.kernel.org, AJvYcCUN6IF3MeXJKOL5eMazf40cg7WhcGyGi5Ugbnc14vWvOlxqjfUGlGC46P/LzAksKrBrMRVq/kb7gJRD@vger.kernel.org, AJvYcCV/AaLl1ghNppibbhke1457I5FzR9UN+GF5Sc3HpO4Er8+O1iEhvxX9WdWDAUMMEsOgPeQRTk+fLRsKncU=@vger.kernel.org, AJvYcCW4c/F+fA53F9wE/Cc7S25/gdHLgs/Z3jNzXKZmj/H4quK6ZOosC8oWLB70jhAKO3rvd82bOVUykmGF+A==@vger.kernel.org, AJvYcCWdXQOnK2F7zc0Jnkfoijlj/F0n/F72Zcrz27Jxv9vHAPL++wtSEOZJ8dQ6WO4hDcO9Vtk=@vger.kernel.org, AJvYcCXQcHsHBv0/wPZAsFuceLMUaHpGeiA+kWQBEHbMRbES86PgBTxP4+zn/tBGz8buMTz8pjYNUp6J@vger.kernel.org, AJvYcCXWyj7sAxlYMyJFEQimOcFxoCoQyb5MHg1D7KLAqaOpqS72OFwR9uZJuuv+zXdoKe2U7Iy5LRqDqCVk@vger.kernel.org, AJvYcCXeX1INGpb9EBaEecPmJghKHp5IKEECq5fPupBu4trVfzjJzDWpe36cj/s26fOf8P0fzVQdnXwaa9PO9J0=@vger.kernel.org, AJvYcCXyfOsv1rreXY7umSmcxqqTcqigImyczGxYO0KfyH3Jy710uZejaOrbs1tkRynaaZP2+Rw0v/ndZ76udJKI@vger.kernel.org
X-Gm-Message-State: AOJu0YwJMExlmz96Bolgxw6xWS+Z5j3sJDhYdb1dXOBCrHUIsTaL6zFS
	RvHE2JJ8naVRUZmK7JU1fyD3iikbbrJy6I4ApkFXsmEYrcL0qg1/n9dw
X-Gm-Gg: ASbGncsfAKYjgNdWwNg7xXqJNSQuLnN/PSrLnCGKOf2FFKHu9V4VsvY3AzSq8NenHpy
	xePsgoiHPUuwIlHaPW2FgcE7s5Mi55wmwH23KCdG5I5mKQbo79Uvf1nJv0NIKcm3giYObUYwnbF
	Wvidmhwe1mTgmP26baCmqMdOsK1oEXJWKbXjrt9lrwvWlxUdF8K/rhLV2bL/MOysifIiGY0p+WS
	ifyP5RZS8K0P68xX/DxjgIctf9ouElhgNLwUH8WnErEp9A/5X2A3/HWcbrKNIVRAO9KOIkwWW85
	eeOt5GFJTQIJKoVV4WQTbTpItF2W/Iuqtjo2kblXzHfoofZPRT+NtHZTB/333jUz4v6KK/Q4U3H
	Xbjefj/OwH6pMWCb/OBOZzfpHiYJbCCG3mb0I
X-Google-Smtp-Source: AGHT+IH09TdLkBTBS46a9KkDQcsPHCKV5BjcOl3BN1JIlX/axUWBHc8jxps5fYfmQWtY+6vT/lzr2w==
X-Received: by 2002:a17:902:c952:b0:248:cd4c:d6e with SMTP id d9443c01a7336-2494488a679mr39782015ad.9.1756595492940;
        Sat, 30 Aug 2025 16:11:32 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906395aa0sm61840295ad.100.2025.08.30.16.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 16:11:31 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3F63E4222987; Sun, 31 Aug 2025 06:11:28 +0700 (WIB)
Date: Sun, 31 Aug 2025 06:11:28 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
	Linux Sound <linux-sound@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
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
Subject: Re: [PATCH 12/14] ASoC: doc: Internally link to Writing an ALSA
 Driver docs
Message-ID: <aLOFIEknbxQZ6FM2@archie.me>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
 <20250829075524.45635-13-bagasdotme@gmail.com>
 <20250830224614.6a124f82@foz.lan>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q50L9+H94gXo88jD"
Content-Disposition: inline
In-Reply-To: <20250830224614.6a124f82@foz.lan>


--q50L9+H94gXo88jD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 10:46:22PM +0200, Mauro Carvalho Chehab wrote:
> Em Fri, 29 Aug 2025 14:55:22 +0700
> Bagas Sanjaya <bagasdotme@gmail.com> escreveu:
> > -Please refer to the ALSA driver documentation for details of audio DMA.
> > -https://www.kernel.org/doc/html/latest/sound/kernel-api/writing-an-als=
a-driver.html
> > +Please refer to the :doc:`ALSA driver documentation
> > +<../kernel-api/writing-an-alsa-driver>` for details of audio DMA.
>=20
> Don't use relative paths for :doc:. They don't work well, specially
> when one uses SPHINXDIRS.
>=20
> The best is o use Documentation/kernel-api/writing-an-alsa-driver.rst
> and let automarkup figure it out. As we have a checker, broken
> references generate warnings at build time.

Thanks for the tip!

--=20
An old man doll... just what I always wanted! - Clara

--q50L9+H94gXo88jD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaLOFGwAKCRD2uYlJVVFO
o9MMAPwIm+r4BZdTF0jZV4Naj+z2WrUBji4gRFJQ4f97vYNhfgEAwX/UGgC71a9U
lMJHF+utPAWnldcv9PoyPOBgO71EEAA=
=C7rV
-----END PGP SIGNATURE-----

--q50L9+H94gXo88jD--

