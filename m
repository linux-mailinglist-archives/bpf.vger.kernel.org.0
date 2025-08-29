Return-Path: <bpf+bounces-66952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3449B3B512
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 09:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E604D1C837CC
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 07:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7A82D838F;
	Fri, 29 Aug 2025 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXUGCrDQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A6286421;
	Fri, 29 Aug 2025 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454149; cv=none; b=BLuZ1a8BWVD9uRSesaPSUKFBuMS5+Fm81yUFtYqifbTuQtIcxyZVKHtnH7EU5NntTK7/njUGcF7c4KItO9xndC7z6pZzotMdnrUP30INu2PjNJhdJLKAcHBMm/0AsqZvTyIn0pL++kc6tJu8+2QkRLC5HfYOFFyKeF98LZZsJjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454149; c=relaxed/simple;
	bh=Ip9RCWVx3N2eFboDnh1dVntKjUKs5RT6sbpEBdmz23c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PR8JhsOYh27wY2pOh10Zz8rce0dbvv2SGBcUgs5sJDof/zkJi+62Xl1TgepOLN0ShOX5iZt37p7M0Hz6NQBG9dpTW52jeOK2Ao+8uCX5jX21itIRQFIVy3vu0XK+6AHFzq6/bVvc1+Xmw4kHRZ6dkyC8dm1hR5mdNb3Eiy+edq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXUGCrDQ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4c6fee41c9so1102159a12.1;
        Fri, 29 Aug 2025 00:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454146; x=1757058946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fK0hEDM5Yyao3a7xqBzpr49p9H5HB+om5vfXDIKLdeg=;
        b=mXUGCrDQmBJLuU2PXYJKU3+UhVoS6GW6T8ED6CwRweLnu7LaCnbqxuEqNJEXVauim8
         m10tm42f2l6OtMKt8nNOlxiBvo7uMOJ6VieTDOLCK1kgGBHRoB3MHn1FGKF5ntq+tzZ6
         e36vZxGAI/blx9eRrD6aBou5EAISoTHPywT+L57CG30TmmPvjFGYvkjzYIsOMw23xwTC
         wHgnvDZnlpkCBJLzt1FRCbAJUZwwpLQwXBKQfGLS/ngOkh58PMQve7gmQba6F6Vzm6bP
         4royouIipJCE0b9T4H8xhwzyHB+TZk3fNVLcgETpN9F4dJqjee4Itf0cdkc8JxEH0yNo
         dz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454146; x=1757058946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fK0hEDM5Yyao3a7xqBzpr49p9H5HB+om5vfXDIKLdeg=;
        b=cj+1fFCj95lCrSrky7pS/YU/Ieal5omuUHv8ypQ4urvQczo8I/elafUZpDgHogKyWH
         bTqPCwUoFkB6Eh0s1E4p+fpP1dFjuScEW+Qwth2Irye2RmLoHEkvgueGLlq63EvEXrIq
         s8byQaeh4Yk+LJtWGastDPOuRyc39ODoK8KuGOEJXAxr9r8msm47OBMEykNYQNhcMgAZ
         FP3n6Gh9TdQgxJfzU9cmXrfBc2DpjWWkAIoOwbqYnfOarawvH3fXhr/iFCPQdjqIN6cO
         dj1fXR9rIlWTtTzWZzp+188xmw5P+1VsmFJ53iRi58AqdHLkjURzPFVlH77r+Quz98v4
         WGzg==
X-Forwarded-Encrypted: i=1; AJvYcCU2qvK28KHmF0ynyBY7i55rCBiOuToJWzxRGlxjp4A1v9fttxSr470P5bIZcmF0vvl4pkYN+qsM7zZr@vger.kernel.org, AJvYcCUSV6/NI4NVO30PQbQa0lZKtBA9Xs2HROgO55cQjJ5I5pqkoTlESYmJOkG2/Toa4b5rAOQ=@vger.kernel.org, AJvYcCUUxyHrFQhysIQve993bLt+JW5upTSbLNvEK3vloBM0wMUndlrpy/O02FJp4ER74h15Zt+AWHYahWGp@vger.kernel.org, AJvYcCV3oNcJefRmxfv1KwBQTXCLdANw/cojtNNAwhR6rHQsB/4t2MUy07nueUlURXGFXcslvvqlCGhk@vger.kernel.org, AJvYcCW+NgJE0iIr4C4EUnGzr3okbt4ddT+1n/yAYg1Th/tqb2JbvIk94pjicmv+oKfhMj1gXKZ26xxSeFgFKfE=@vger.kernel.org, AJvYcCW+Rpv1vFynwiliY+9JRexwGrisOFjngVouPHcZ31QXyHOqOf6EK/PiqiATAOrBtsCuNhkOHvBtFxQJUg==@vger.kernel.org, AJvYcCWWtr9IRaGx2+SL8aOHHUSsLbdNH6YJaqe1bXjYEMPxnsXritU9H9JKqlKqIahoJjNEMWlkCEt0r+w=@vger.kernel.org, AJvYcCXRY6qiW6WRn7GAx3E4zz/rLCsePRUPFnhYiFxanKrRC8stmvgTUIsbZQWhFYDxkYJUH5rPpsI3FMMJb4o=@vger.kernel.org, AJvYcCXys3FNPxdeqn1gCY2B97jznEwbLy19/IRcM6qPjPqceqhKdQzKsWf+YnvSkdZSwSfFjuY7dUHLf2WhHwRo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhy7DZbNTwnmAKti8UN0+7FnTKvsLdTqvauPwUQTSglXCgtR6L
	0483ZA2FV9RjP71wVF8kPqS0OK82PQq5Lb8MbyeWaOINYgw/jgw3DzkM
X-Gm-Gg: ASbGncvv/GVN9GNtE4i5fUFQmIN+486zWV3OS0VfE/YzutwmXGqa7aeLcRyeR7glnv9
	lIOjGGDHXOEeCXcb6WqF0ZcjfB7veYoSA/bKPUPTHaabo981wxmb1YgHiLN9RmNAIOLsvWBbNtC
	s1q2w+0cOFuIhqo80tf4/BuvhzXG6yU9/I0EnAP1l/D0Ul9u8wEoBr4DTbN4K0w4tcx959/h/Ml
	pAhGcO+6rvD7/rhUwjQWcNYHqtdg/XPM1+FunzcSSLSnT/j7oKlwyIc6eov/2y+WvZH8C8Ib+sd
	v4/YmEmTNFZJzatQeH4j2V/k+IeN4nN9drM0ndTzCiQw5tmTOAqS3xGDtUkQkzDEkxiIu858sEQ
	0MsWOccsuTuFaOvTbfq6HPLL9pd7wtH1Q+dPp
X-Google-Smtp-Source: AGHT+IHJbtOvLK7smFZ5Taldvs91dQKYlT3bJQAsV4fZ4iEcDvRKpIMHMCPIqq2aQ2G3ehFn7aA64Q==
X-Received: by 2002:a17:902:cf08:b0:248:a4e2:e6d6 with SMTP id d9443c01a7336-248a4f2333bmr133286365ad.39.1756454145980;
        Fri, 29 Aug 2025 00:55:45 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da4784sm16792615ad.90.2025.08.29.00.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:55:43 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C98394480991; Fri, 29 Aug 2025 14:55:28 +0700 (WIB)
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
Subject: [PATCH 09/14] Documentation: filesystems: Fix stale reference to device-mapper docs
Date: Fri, 29 Aug 2025 14:55:19 +0700
Message-ID: <20250829075524.45635-10-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2828; i=bagasdotme@gmail.com; h=from:subject; bh=Ip9RCWVx3N2eFboDnh1dVntKjUKs5RT6sbpEBdmz23c=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY16ybj++M2M+e9AK28XZP75VaZfxL/rvM//ttckLa 3oE7/o/6yhlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEPq1l+Ke0Kqr32Tmn3/wy 503l2Fb8+Tb1i0vpkb/b//3YUvkmUo6bkeGv6MSGx38SK429ymz0txt6/t/hdS/prR+npRZPk6W qGg8A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Commit 6cf2a73cb2bc42 ("docs: device-mapper: move it to the admin-guide")
moves device mapper docs to Documentation/admin-guide, but left
references (which happen to be external ones) behind, hence 404 when
clicking them.

Fix the references while also converting them to internal ones.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/fsverity.rst             | 11 +++++------
 Documentation/filesystems/ubifs-authentication.rst |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 412cf11e329852..54378a3926de7b 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -15,12 +15,11 @@ of read-only files.  Currently, it is supported by the ext4, f2fs, and
 btrfs filesystems.  Like fscrypt, not too much filesystem-specific
 code is needed to support fs-verity.
 
-fs-verity is similar to `dm-verity
-<https://www.kernel.org/doc/Documentation/admin-guide/device-mapper/verity.rst>`_
-but works on files rather than block devices.  On regular files on
-filesystems supporting fs-verity, userspace can execute an ioctl that
-causes the filesystem to build a Merkle tree for the file and persist
-it to a filesystem-specific location associated with the file.
+fs-verity is similar to :doc:`dm-verity
+</admin-guide/device-mapper/verity>` but works on files rather than block
+devices.  On regular files on filesystems supporting fs-verity, userspace can
+execute an ioctl that causes the filesystem to build a Merkle tree for the file
+and persist it to a filesystem-specific location associated with the file.
 
 After this, the file is made readonly, and all reads from the file are
 automatically verified against the file's Merkle tree.  Reads of any
diff --git a/Documentation/filesystems/ubifs-authentication.rst b/Documentation/filesystems/ubifs-authentication.rst
index 106bb9c056f611..9fcad59820915d 100644
--- a/Documentation/filesystems/ubifs-authentication.rst
+++ b/Documentation/filesystems/ubifs-authentication.rst
@@ -439,9 +439,9 @@ References
 
 [DMC-CBC-ATTACK]     https://www.jakoblell.com/blog/2013/12/22/practical-malleability-attack-against-cbc-encrypted-luks-partitions/
 
-[DM-INTEGRITY]       https://www.kernel.org/doc/Documentation/device-mapper/dm-integrity.rst
+[DM-INTEGRITY]       Documentation/admin-guide/device-mapper/dm-integrity.rst
 
-[DM-VERITY]          https://www.kernel.org/doc/Documentation/device-mapper/verity.rst
+[DM-VERITY]          Documentation/admin-guide/device-mapper/verity.rst
 
 [FSCRYPT-POLICY2]    https://lore.kernel.org/r/20171023214058.128121-1-ebiggers3@gmail.com/
 
-- 
An old man doll... just what I always wanted! - Clara


