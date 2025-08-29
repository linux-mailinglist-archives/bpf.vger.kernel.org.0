Return-Path: <bpf+bounces-66955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D363CB3B560
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 10:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B1A7C1AA9
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 08:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18C829CB24;
	Fri, 29 Aug 2025 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ier2DQll"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662EF225788;
	Fri, 29 Aug 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454578; cv=none; b=E4B5OPpV0Lkv+ibWynTSuxzt68zNy2tv7S+JExWQeE5czQBo18HoU/iwMr67zd3NazTE1KjretHgFeAdEBYy1Zr0rlRhjPMyS2tL/DnHzXCQNe3ycVbzGyT3dGoNgyYXg7qz40wPlU/DvuoliI20hMy8DswpAZDq9z4wU6IIKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454578; c=relaxed/simple;
	bh=yEY9P3BA6E4kqaGTHyjuJlgmOOGj2m2ZOET4fPd8xcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6wp2KCZ3AhGjDNASopqKUdMqML1o91N52oBG0xNUXvs57Et+3Q8nxB6rGztTYd9xnvDux1SJMiatNaK3WaG+GJHiAFbDhOWWRjaCQXE73auQDWMhpiJbZ2/Hf5KHUrDNwOFZxFgSeQlwwuZYdOXFgkg5QHYlpX/f5N8awSPjXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ier2DQll; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-771ed4a8124so1919149b3a.2;
        Fri, 29 Aug 2025 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454576; x=1757059376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kNx/lgQaweLHCKpOd5HxLBg5NtnJ9f3nOi2hx/97zs=;
        b=Ier2DQllCl66+ZUG/wDbK8Mv8skWwLrseAmXvJ4P4ioufdgROx/U6kG7VyUAEGfFnT
         bMC+wu0Ixa8vwoFIz+NCZO2vvDFLTi2dmtkurd/F5x3FtS4+ayudXTamebtpx2cZzCLt
         /aHoi3I2BAVwylGoJ9SO05COR3v0ErOi7M1bt0jOXvrNR4o9g+E9EjlJ0CQ7TLL+8bOm
         dg5ben5eZRNcfUYoReh7F4u0hbsi30VRDAb9PkkfqAyg31L88IV3v2KjKoifVdKAGkp8
         7Xi0Cd9FRHmNrKuDQsc/OyfJnKEjbIH3yZeLxRQ4UXtUzeRfgw8ONErYf1/4V9CeQ2+3
         K9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454576; x=1757059376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kNx/lgQaweLHCKpOd5HxLBg5NtnJ9f3nOi2hx/97zs=;
        b=DpFYu5dmeVHokwXjco2P9TYlAHLHHcmd601yzjUMUNbBucJzDN5V/Wz/2hieqd4DZe
         eJ+MPAzAANK/AgNTvAvpxPnrjZZeQMk51m2cTwmXEEpAr2BDK7hr2/HOFX8dHXB7zxQ6
         2M3qc/XIK7c0yi0ksLisSDTBDK4KnRpwSVeHt7dT7e97RkQpPo2dV2JI+rKro2eBBq+k
         JerjNcmycwbQTPy/8U8Zru12Nux9J2JZUEKbqxhcQOaaoWup6/ztb9RcYpaYzDwWp/HF
         VzGS33jYDhwS7vO4VQ53edcbmwvx1ybZwlKwdNCohCovNFawR2+jHNoJWU5ViBV7mjeT
         xbtw==
X-Forwarded-Encrypted: i=1; AJvYcCU/dZL8h1aS2hp484dYKaurihCfsGGR38hoeCE7DeFseDPlWIoTv4PquFecYDb1cfRLZm2G6NA5W+8inA==@vger.kernel.org, AJvYcCUQERPqlVFDqZ9JhH/bOvSWkDgHraX5mSvscrilJ1hrBBssKlhhrYPzbL35a8+S0QvsZSJTxlulk3d817w/@vger.kernel.org, AJvYcCUWXjJ5FolTY+8/dDulZKhlDtrDuDg8CZt3F3WA+9sSPj3+7L5uOsTLLdhNJ0zmAqKMBPlIP43nR2U=@vger.kernel.org, AJvYcCUeZvNSrUcPvZoFKD06EhsqwldrkFkhgEEfN9TpMGLLabwgVtUdfKraSvfflEgVhji1qYrj30X6k7/7@vger.kernel.org, AJvYcCV/dMKBCA7IdDbWBiqqNIgYTJuUaiL1rIJCCgEhwcwkDO0ocJEsf2NaUVeIpLhDiiqoqtU=@vger.kernel.org, AJvYcCV5eAr55zao6G/2okHvZpeUaIkjDeheCmfyd1fDRY0cz50AUb0IFaOvIOK0RpWVouFi3mYqrJ9q@vger.kernel.org, AJvYcCVpnD4oWZKQl7H0St/jEr9MKNrgs6rKkT+wX+3VScxtXUPptWC28iRN8PLqv8n/OOaS6vO8+udTLuGz50Y=@vger.kernel.org, AJvYcCWZEehTVkloaU/myCDVV9bHLVxD9bbAmqsDD9h5ygZibn826pOL/6NFWGheFn+VmZjHnB1hk2af2l4JJrQ=@vger.kernel.org, AJvYcCXBul9a5ULyslSovejt4PQGuKZuAedo1fht4sXd/Pd6CMbdauIox6+4q+IFASD+LdeAfyBhgW8Jr8kT@vger.kernel.org
X-Gm-Message-State: AOJu0YxJMeLINYPqwBWmoYmOunPuSMNznUWkOce8IHieQvvExdr12WoJ
	BTliMwYhtjgFxeE3y+yN7hOBvRZPq0gQpKmo7LdSMPHwyZZkdnTBRMOL
X-Gm-Gg: ASbGncv1Hx4srGqvfhaLJqHCfa3PsDt6iSfqFptAcyq2ufT8QUZ5R/pPKDWqKgZc1gi
	S0H+asXGzSPL5zY8NMVOTrNM6YpjzkciR20SAnAe630W/D1guctNEy5E7l7E4xWWqHEOIOMxZOR
	8H3CX25da6D4ijeFn05urJMF7G19Fr2QvY/ZMMPqThDHKtZMbHwZIXVE+PsWtRQjY840CEMpInh
	3JRXk/zNKwWlRfsiGagg0casvqXI8tHHgg0Un/yObLfPfwvCnGnpTSz13RP9dbmlbpLVvC5tCdY
	BXroUffHP8XGuopcSFXmNgP8BZONeOiDGcUS1CxzSJQRJxl+Kn6LsL17jGvufVfnYuCStUy5zqd
	k3eDBZWYz4xVu5QmoF9MS6YycB1btjsicGNDx
X-Google-Smtp-Source: AGHT+IH+t29amFLYd0pmHfYJonIUbgBYX5deBT907gE9ZXzofCuXi+cmB62DwyrzhPtfYbGnFlKG4w==
X-Received: by 2002:a17:902:d2c4:b0:249:25f2:16d0 with SMTP id d9443c01a7336-24925f219ebmr1591865ad.12.1756454575452;
        Fri, 29 Aug 2025 01:02:55 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037254a0sm16722785ad.33.2025.08.29.01.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:02:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A15474480905; Fri, 29 Aug 2025 14:55:28 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
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
	Eric Biggers <ebiggers@kernel.org>,
	tytso@mit.edu,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Alexandru Ciobotaru <alcioa@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Steve French <stfrench@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 07/14] Documentation: kasan: Use internal link to kunit
Date: Fri, 29 Aug 2025 14:55:17 +0700
Message-ID: <20250829075524.45635-8-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=bagasdotme@gmail.com; h=from:subject; bh=yEY9P3BA6E4kqaGTHyjuJlgmOOGj2m2ZOET4fPd8xcs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY15eUeC/XH99x9zD0/p/z/9z+OvEiwfuXjriUbHJw 5Al4fDvwo5SFgYxLgZZMUWWSYl8Tad3GYlcaF/rCDOHlQlkCAMXpwBMZOZehv8FVlI3eaYvZbZV FT1yZ4VwhOvUr/8ro6tZD8+s1FyQW17C8E8vzE754pXFu0SKjG4wxTc6XF7j/+Pma/mjrVH18/Y ypfEAAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use internal linking to KUnit documentation.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/dev-tools/kasan.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 0a1418ab72fdfc..c0896d55c97af8 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -562,7 +562,5 @@ There are a few ways to run the KASAN tests.
    With ``CONFIG_KUNIT`` and ``CONFIG_KASAN_KUNIT_TEST`` built-in, it is also
    possible to use ``kunit_tool`` to see the results of KUnit tests in a more
    readable way. This will not print the KASAN reports of the tests that passed.
-   See `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_
-   for more up-to-date information on ``kunit_tool``.
-
-.. _KUnit: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
+   See :doc:`KUnit documentation <kunit/index>` for more up-to-date information
+   on ``kunit_tool``.
-- 
An old man doll... just what I always wanted! - Clara


