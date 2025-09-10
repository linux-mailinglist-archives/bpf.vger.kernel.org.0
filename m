Return-Path: <bpf+bounces-67963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E5CB50B6D
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7FD461259
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4381425A631;
	Wed, 10 Sep 2025 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTmzurin"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B4124DCFD;
	Wed, 10 Sep 2025 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472242; cv=none; b=CXzzd3aUCAFQKvwKYTQBdeOqkwt6+zla2sN8N9aU1lq6vACpk1Rb7bTu2vxUTExZzmMSOxt9NdNrUTebEoj3Chd3QYpLdoeRkitwqsN9UQgbRK0rIcyClKHbiAk5uy2eywi4KPv69EGAiDglb+0mcU+Xa3u+gOzjZupuNLJkaak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472242; c=relaxed/simple;
	bh=TM7A3b/55JCgQfCA5kxK7YxN6xbvfSMV2ctBC+dU0+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4EJZJLN8EE+g/zXI6kzH7JNiNtQTSZF7+e/OhOAkQYcwaAVRcdZ0Plkm1motqAwwd88V0OhDw83Eb6usOhLkjdApUYFrcF5Y75RHoyYnTYiTavWoZYjEYQuXRY/WPo/yoHKm2f9bnQujYdjGwuaUNJE9xw93AktdDXkviIGFMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTmzurin; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so149120b3a.1;
        Tue, 09 Sep 2025 19:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472238; x=1758077038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJdcHxX57XebbZj4zrMMfWynAEuJyyuoNM4CHXO3dik=;
        b=jTmzurinvs8fvmrim5MhOobZJhjRwNJvXVGPTYMGibQQMN1EaaNJr58OuXoYmnBkqo
         kmUsMFBPTzpaLKE2iPNTLMw030fajXZgnsgmOK5dVDPjuVzflHEwpMsptG4/bHJUKuN2
         dY/e1DsHrFGarR/PoNC+P54lLii1US9Hz2gBBn/SBS1mJvFwWkDbTXjj0zeZJOJJM8OS
         9LRhHkg5Tm4Us3JLkTIN6G+k092jGXnRTotlULEwxT5bg6e490CFrtEfUf+aFYVJXm/1
         GXdv/b22zVGd5Cz1Ccc76FG2he4PZBkATDkKzCmcUHZAHTYADBlXNPXmf5Ry9Qiz6jXS
         rjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472238; x=1758077038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJdcHxX57XebbZj4zrMMfWynAEuJyyuoNM4CHXO3dik=;
        b=oPWZ6xK+kDUwbM6ZPB/1GULOhYp4fZPAJQgcv8ARfRqN/FNBLA90Jz/UOBvoT4yYkN
         jEoUymexbuHECC1FV9xFQ4bTuTbTvyjv+LRSclO9MfNus7rVTSjtEwq1qkvEHdN+Mq9R
         I6kLlYTCT5NOri254ac877haWsG3T8cKRkjFnzm9O3ijgV5zmApMFIw1aYjwnWDJih02
         O4DFEH5Zsv952aWJxdN/3gkOYm2FmOqu3rYqS+4E4BCuSAv35uWe6LOON+gYsBqYem7/
         fgEpp4yz2W0D8sD3MunvSXyYo20pqSROk5PnG/bt8UuDHIIeAQTzSDhA9xDudbqgH9vJ
         dPUA==
X-Forwarded-Encrypted: i=1; AJvYcCU/HWXBMSztNOoObgr8z4Pyh+/BIEr0h2ysXByCbq8u2Fbzfsf7SXHg4MDIGHDiWgQhYgex7nBSCqn/zQ==@vger.kernel.org, AJvYcCUHN2xeOXElwViZEkICWZyh19uTcViJrd4W62hHWC2gr6TGuX+z6bf4iXgFSM1lUfoESuPxLWsL+r38@vger.kernel.org, AJvYcCUY69qPuoCQHXSpMgz7I8rn6nWUzdr1L+uupoe8QxMSs3cx4r45+uLr2/vJSvjywvChafU9VLtoROQy@vger.kernel.org, AJvYcCUtvRz2FTG05jcOxQUAeXjLNjEoI2C/r0vxL4+dfzgEPOvIeim0mAqttw3ynrdMcBmfSPRatXGSPNvcZdsP@vger.kernel.org, AJvYcCV2nZiZ2we/5xWlvkbEYEkjt8I/ovQjqwzpMpyZarMCq45UtEtoZshiHgp0D3Rl5Cc+Gh+ZB4S6@vger.kernel.org, AJvYcCVBYlli89M+4V3E1eOE8Ijyf9daFGkB/F9mLTf4ulGGI1D71G1Y5a6DY+mtlP5kPk3F6vL0uyl5KWolZe0=@vger.kernel.org, AJvYcCVRq9RMlHQJtezsRLChDXsz1z3OJ+1xjKBdfQ1m5o19pv5tlgwk6YJ3o0qsmlERPyGzXX6DvqAP5dU=@vger.kernel.org, AJvYcCVtZueZGMdJuDVr6mL/FK0VALL5LRCGr2nNQq+9J84Ow9CXA9XZj23ShD8B/afQHuwIeVTuGoGx/5x5plQ=@vger.kernel.org, AJvYcCWQmh2kBVjMR0JzKbH6za0UloPlyCvG6/FFacgEONokq5LGqBS6sQBfmJTmQ2im+p65iPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwivPyLpzIJ05STqJRx+lXlFEfaoSm42qiKSnFQ7tHHLnecEfT3
	A6mRPhud5c6A8J/3aqSfYcBidLFkjblHZdsCsn08xPbGcBFK3UHMSi0T
X-Gm-Gg: ASbGnct2pNkM/bk9SZSxoG3Wk7Tt548U2bUdolMHIat1UnAPf/Qswt/XGv/WWPGSFS1
	kxTOoUnchXQF2FL0Tw22XDPSYxL8cMhHDUx8Dmh5RcoYHhX/XBn5pujwl44RYipTNZpyCMjiopl
	5Iu/+ZuncqEaztvJ3g+kQ89wDMBuC6cEPSgkR87E4I7bgjsvLRxRn5qycYTI9VtxWzeLHQFzV84
	9GfHaLT47dpHPOEUpHx3Nxd+QIO+Vb8OzbWihZveKcO4bihDTd8ErCcasNle1NbNkF/hWOGYFrL
	C0K1FUL9URORllbfE1OjVrrphmnMtOrgLlymClmeS7AJB44P3A2SxEVWDQmX5Kvf7D56TsCt89X
	lM+SECJimHMiNicn0mJZ+GM96ZP6mXNU1gqDi
X-Google-Smtp-Source: AGHT+IHlW2FYAtqZ1nBeuiJ0erIdKTHM8TZOiaskQC50mFORCZ7qHar4U4e6n8dIjJOSKpsMSsisCg==
X-Received: by 2002:a05:6a00:945a:b0:770:4f37:bffb with SMTP id d2e1a72fcca58-7741bebe705mr21095803b3a.3.1757472238265;
        Tue, 09 Sep 2025 19:43:58 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c73e0sm3425976b3a.73.2025.09.09.19.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:43:56 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0C94B41FA3A4; Wed, 10 Sep 2025 09:43:51 +0700 (WIB)
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
	Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
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
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
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
	Alexandru Ciobotaru <alcioa@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Ranganath V N <vnranganath.20@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v2 02/13] Documentation: damon: reclaim: Convert "Free Page Reporting" citation link
Date: Wed, 10 Sep 2025 09:43:17 +0700
Message-ID: <20250910024328.17911-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=bagasdotme@gmail.com; h=from:subject; bh=TM7A3b/55JCgQfCA5kxK7YxN6xbvfSMV2ctBC+dU0+o=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHnih2mgVe6tXtn33sQOG2JKN6npsV2+KuvrWb+KLwo YbPrZOKHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZiIgi7D/1T1Zd+0q3NfXbSR WTM/c6Nt+dI0hVcvJi2QWSN+/Q/fJyVGhivi20SiX0RwBzyI4fPfm+rzyfPWB2YZV73+/5GK7JN 5GAE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use internal cross-reference for the citation link to Free Page
Reporting docs.

Reviewed-by: SeongJae Park <sj@kernel.org>
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


