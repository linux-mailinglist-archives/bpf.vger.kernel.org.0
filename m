Return-Path: <bpf+bounces-66947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7931B3B4EC
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 09:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2898168C96
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3785829D27A;
	Fri, 29 Aug 2025 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCB35WBv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D422857D8;
	Fri, 29 Aug 2025 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454137; cv=none; b=LFfEPTlLEKYULk96P1Hg2Unduv6X0Rm0lLlHJMGK5xSA6aynV93nOmMIMVNFW0IwJyzek6G5koGU7H2cJwMYEQlyXssrkQ5FiKB8iKGO2gc4xn8h3HtHLWQv3YS+a0UeyqAx9Erwj9En4D/OQHRAKq6YwuW2j8GSkOKntDnzsvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454137; c=relaxed/simple;
	bh=br/gH56HVzhrfYYqrTP3c/xceN5BBvTsvI3pBYQ/yVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glQC/bNwrQUcFSDftVSQ0ibxHTZkFJ8UcDFmwtlA5nUhI5V7dYWrcL2+1Dr6MZxCnjA+njYiMFw90KD9RiHYs77hiVxy6Zm4QiACezYpvzRWGQEjFX0DEpDkzlxpVGHl/rgaIyW6m9oiJThXhRbwvV9wTLwdKTVWd/4Dj+ezNM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCB35WBv; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b47174c3b3fso1069873a12.2;
        Fri, 29 Aug 2025 00:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454135; x=1757058935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkZ2LL+fO6oH27E7YsqUKpWK9h0JvMFOl/W1FWHyGxk=;
        b=KCB35WBve4e6UTfHwrny+HSVx7v70TOwwL1c5VOeY7G1bmxzxvE0PQ3I3SuhF12xEk
         W3AR7q928vrPGTpEPqi6ZbrXOq64wAkddHRPdRUedbd+3EsrjqswPRZU6XnieGLpVKj5
         ctTY51+ZjPqU+4zD5C2VP597l77BRFhVJEV2SE8YLp5G7dIMxyGeiArIKK3my6pTti8t
         Ow/t8kQY98murSecNiya28pQkaeQtkzzLkLqCLK4exupb5pVHyZzXgKmtVWLbnF/OCVs
         jcB7WMBGAMkTf8e2jqrStF6MJXyhhi7RxdwpAmJt5W6KBvcyp6TLxxGfKNiPnACF2tw6
         WmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454135; x=1757058935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkZ2LL+fO6oH27E7YsqUKpWK9h0JvMFOl/W1FWHyGxk=;
        b=l0vHY1DscbYGRdbYX6CxOyC75kyrDoCvd5H4D7Y3oxLt7XS773U/c//kbTIGJQFohr
         EZ3JOxb2JBkd3fDSYadadMTZowx3IOEDBwR3Q1984DszMFS0PcDmuZJ6Ib0Hhl4mLmej
         QGzORgoOOCDX44u90G0XBDpzWAv1e4oBubrrt6NtXU4P5Lmt32WSspgbJ/8Lx53klV5X
         EPIaZ9BDS1Q0yZVSAdXdeZaRmMWigqqlnzGClGvabseeaCqdWHcPO5wvKt7lDGy/tcY3
         A9WeqnmSUkwlHpd5BzZFcGMv0FbErdI8LRaPwBxhdPxJtVjQrMidyxUiU4q6+Mkbpr5j
         aGVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU64oQVEL+OxZyx2YNUogZutEMt3cZUfwgLZP/NI1hnPzUne5bvNy0TyVsUEynmXrj7l+ldHMlZ@vger.kernel.org, AJvYcCUE70F/cigPho4FviM6KMdQugCVwpbV7mmXDUJqJYG2c5QIIW5BT4OKiC03AFFyskFubybmcTPcOcNX@vger.kernel.org, AJvYcCUZ46R6uovYzTJGtbSk/XDFr7bosY1gtVHVXmI49tluBQh68q657xchyOlznZyhcplOP6M5dKB99xop@vger.kernel.org, AJvYcCWyzohVfhs/Fwr/88y+6HYobfAC4aMuyeFb0+JEPWOv0l1lL3lUqTiCkLURyu4pNkOD+mSeIGraq4w=@vger.kernel.org, AJvYcCX6ZhHv9DNt1iBoA7S6zfdg5nwpuEG1ZJEHzrFbNecQkDV0Vye/pZKdbDDOTIpHKXRjBt8=@vger.kernel.org, AJvYcCXAU3RJe0P0Hu54U/fWVZsA1eeNQDw+fbxbZrs+YxwX59cwAkle9gbFt0a+MaYqK9hkawElbBQRM8rgbaQ=@vger.kernel.org, AJvYcCXJw6B7/jvqphUksbxkacXiIDa9zkqeO/lNJW+j53O4jX4D4ArldwkU/SzWx1Ft38D12+nzM5s6fF+XFw==@vger.kernel.org, AJvYcCXLkTSJpVC4mnl7UObD6Q97bZvKnE263e3zuhdrTsllbqJY2Fh0Eo3ighxR/ei457qYwKtGptZKUF2XASk=@vger.kernel.org, AJvYcCXj76KljxzPssMLsh9GnasOow0v/RDIdDASlKRPKfAE58ZW2ISAsqp7grCTbvuxtcTvxbNNxPCu+jXH3gIj@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0fA175X84SsqW9P12YPw1lcpQmSe86m8NmaFiImzybpU4DEX
	MAdLr9RPQ4AXtNTXi0WIlI7bbelGJY0DnmzWm2VmJfw/B7tne0CLL3Zw
X-Gm-Gg: ASbGncvnj9jz+5mEBoO1adnj1OeOhtBtPkC+sJn+cF8g8D36gc99onHzvHXq4g1iauS
	4exzpY5XJoSROTJ75QhjnTAp2vjpos6qZZ2uxHL25eSvLkGXihi0Kmtu2SBvZDyELAkz4wZHxWZ
	xLFSMpVPbQhMYeZDKOWIcPAq+jSB2w7EPXVurLEnDqdB/Lxb/XRE82si98og5XfnA6Ik605Qabp
	RK1z83lYdklgL8pmswcKimuXx7kMeA4EnLxGieT5hVAeY/O/Kw7niiK2N3fPfFXpwDD8N9czX3W
	YWS2OgIR8oVOqG5IClNAfpQm8Ra/dfSZvoSH21jo7eS22fS2MEeBdOdEfagX6QX0wDi62vtdATE
	Erf34ew9esktryGjwEffD9zWaabFnlDFZr+2D
X-Google-Smtp-Source: AGHT+IHJ0etjvptegteXgkUWoFIILA9nIajrzCKr99WRD5OzNxzSggv2jyDezns1lof2dGSUjRUcTQ==
X-Received: by 2002:a17:903:4b07:b0:249:2297:c424 with SMTP id d9443c01a7336-2492297c777mr3315565ad.15.1756454134776;
        Fri, 29 Aug 2025 00:55:34 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903724ec8sm16944365ad.41.2025.08.29.00.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:55:34 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id EF6DE4444CA3; Fri, 29 Aug 2025 14:55:27 +0700 (WIB)
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
Subject: [PATCH 02/14] Documentation: damon: reclaim: Convert "Free Page Reporting" citation link
Date: Fri, 29 Aug 2025 14:55:12 +0700
Message-ID: <20250829075524.45635-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=839; i=bagasdotme@gmail.com; h=from:subject; bh=br/gH56HVzhrfYYqrTP3c/xceN5BBvTsvI3pBYQ/yVo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY14UOzeckV2lWTlnxluBwiWvpt1jF+xvT61/ejpwa tSzw60XO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjAR0x5GhlnvrvsFdd3e6TjZ g2FTa8uK3U48C+++2yu+oPH13XO8khKMDP0RbvPq2Hk2WQbMuFkV7P77fsRatst+E/e4qhe89eI LYAcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use internal cross-reference for the citation link to Free Page
Reporting docs.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/mm/damon/reclaim.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index af05ae6170184f..92bb7cf1b5587a 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -298,4 +298,4 @@ granularity reclamation. ::
 
 .. [1] https://research.google/pubs/pub48551/
 .. [2] https://lwn.net/Articles/787611/
-.. [3] https://www.kernel.org/doc/html/latest/mm/free_page_reporting.html
+.. [3] Documentation/mm/free_page_reporting.rst
-- 
An old man doll... just what I always wanted! - Clara


