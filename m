Return-Path: <bpf+bounces-67966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6B6B50B83
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5761C20DB5
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9168F26D4C2;
	Wed, 10 Sep 2025 02:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd2MZbNK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B742609C5;
	Wed, 10 Sep 2025 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472246; cv=none; b=uJQ2s9LFlcOBwVuFQ47qFm/V4SDZ39mVZI55uJOWdYm1M8FQ2TKqQzbmLVPxvtfAQyzUZwrTAE+KefjB/WzCoI0IDgc/5msSz9m1hIM/XYjP4XI0UFb0bSmcCt2E7w52K7HS7ZsVzPUcTty/Q4JeT+yEFOzbsbYSO4B/HdOO9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472246; c=relaxed/simple;
	bh=OYt2QegR/+u0q3CRKm7Zg38q7SY9D/3L6tdzv43Jflg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mk8LcgQSrLLgSowgDM+G0JCDwHYaKhQplPvvv72fh65P6GUsCvPAePGzRkOW5LUlER7jHceuuJxlv89eLCOzJGiD8rs0Nh73OtxlM1owC5DNf4el3lG/5oytf2eooxupYig20J8rtwNmmZERFNXWHjR3lv6vc9UZSt/X5mYV7f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kd2MZbNK; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32b60a9aa4cso4066907a91.0;
        Tue, 09 Sep 2025 19:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472243; x=1758077043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0koFSnJrv2UowuMhMeqtiJIslvN7BbZv6mHXQ/mKo7A=;
        b=kd2MZbNKcevNJfGoD7EhEBbiNEN4ymW821JUYKrgXm+h2BJU4caMZ02pbKpwvlFD3j
         Xz4iZWoHNkdy/BppudBAx0MOLjeORuF+/Tz7yX3XgjoBpEpz/ooxwPgbPN3w9ZkFxqSI
         mapuGxRKF7Mk7SDHQWl7GoYLTG1iRs36DwtzciiLGcpeaVHZUDSQSWkO6bRQMe35LQcP
         W0nEmRYrOErfZD4fB8ea8uECXUKCu6p+2TI0T2iiNXy2ZfuEXMGjIY9Voy0G9cLPhWbf
         dwU3MmOrBOiFkgPqozTN9x/gNTDpvk5MMBEj70A9my2ecvTrJJ8toNIFksGDCS+VY8oj
         v70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472243; x=1758077043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0koFSnJrv2UowuMhMeqtiJIslvN7BbZv6mHXQ/mKo7A=;
        b=C8a2PE2SUCkPdTM0UFVdDClnxv2cUXBpUFYd2x+8xsAc1CBMCjTuvbcB1QZfBwvSjT
         wzcbhoJ2LCt9hrLd8dZEFzseYulS9X6ByOvWOo6OdbeLjZFFfnFTMPvHBj/pzrV8ZcG+
         Pr5Rpd+r+lBl3i7eT63kXN6cUidlq0Fuq6zxpbrnXMBkWKY4vSPEZWwyt9SgyJqRBwXl
         F8q0d5XoYMkh+HgHpnIqEZxp+5v32iHNrqRc51K8rFcJLvoguUSGmdkG6C5yzdkAjGub
         KDwJtxUPOU1iQVkMLaoUb4HNfpHWFBM+TtvfL0Qzg80FubFoFhX9sJfnQZgOJ0jyod5x
         KO3A==
X-Forwarded-Encrypted: i=1; AJvYcCU1BajZvc7ogxCAevAuz9VUdnqwNf9ZMFSBXzrTE0dwH4JT6ArCeXdF9C10Hyuu57wVna0xReB1tWyy@vger.kernel.org, AJvYcCVQfhEuJ1GhzMLBk1X/hvHsiqOtQIljBFutTnat2ONRHt7wsbNwBkVqLiwUAQYZOZHfytzARzJ8xBx3jTY=@vger.kernel.org, AJvYcCVafNqe6hbjp+zvarSm8pjBxLUtYVW70GZXu9sOkYpWYiEftkIuDePPLi5X7lNFRpyijPDYj3ujjP14+eE=@vger.kernel.org, AJvYcCVz/l5UTpmBbxWidS2BzPJpaSlVFpAYRR4i7E+HDrKYQdbz+NUjqVwrwg+VlliDUE/zh9jgA+epmP5k@vger.kernel.org, AJvYcCW9RoowqNbgZrIysDHMiDs1g15+HoMrNSvAhJbn5njhqlaTSIJRNVb/ZdoiQjg1i0EXAGLRG2x05K3T9w==@vger.kernel.org, AJvYcCWexjYjPz9ynBe6lGk/qyoqdF0RCFUWMzuxKTSaHcei0fXWohl3Z8Gr916F1UVF6eXbXnI=@vger.kernel.org, AJvYcCX9KvnI7vmtVKCjlfXf+7QpGSijFyyVR/HxK3O06QQzDJ6vPsnjwkst8CldHr/b8eN7GOVd9q/X@vger.kernel.org, AJvYcCXMw4BDanpuc9g4cCphsmIvk4l4N0ZcvM7U1Rbe1YIY11hZHfBTKTAptGpfprXsy9VbYvtg5iqfLPc=@vger.kernel.org, AJvYcCXyzJ4HcRQUFXV+VrNOWiS1s+5xmyZ9NQd+uhDQu3YmVqvdH4rrzrj9ypod7trtde0TVTwC5pGsbI4AAqhb@vger.kernel.org
X-Gm-Message-State: AOJu0YzJcP6Iui5nhmYb+R/A2n8+QcjmTM7P8KWzanpJYB40bcuqzMnD
	NfPgaQB80wVlHydJy58htOhDmF8zT52+WaJV3W/5MF+j+e4IjTa7wAa5
X-Gm-Gg: ASbGncu/go+pJ9vKI7GoIbJu4cF28j6ZEMGSleV3afGAmZq4e8kYilwafeB3Awt4Ywt
	bYm/bc0r/+ecnECUtMORKHgzCZRg0xWu7zpc2JKs1q95urOws8abz4Gnlb9VbAAPfrW7QgHdXxq
	a7uT2lXBoajNYLYdGT+BOncrimV9FpKzOyNY8VKsjmTcC9M1iym77SIBwYIP6/RDbcmH0Hk7L5c
	s3UpHyGQHNhk1dcFmTy6psU+bcS/s6fOsNWjEdFPLVyFhY20iDKfqDyKG6MRBYtBaN1f5J3VT25
	dYZl/RyvR0X2QPQ4NQAzm4BlZcdUMvGXc5mZoo5zPwFMmO9Rb1dU5i6TbTH+Oy2zjPMWvY73nCi
	7eec8pZ/YMi07xE4YVvLBfpsR2yUGr7jTdv9/
X-Google-Smtp-Source: AGHT+IHze3NqUFgqDMM+sZM9Wi/Xmfyi7sD03WA5eGHes94PFV7I4KKOuKIIQBvLXj+TekGgIh8lMA==
X-Received: by 2002:a17:90b:1e51:b0:32b:d089:5c14 with SMTP id 98e67ed59e1d1-32d440c5edfmr18323077a91.35.1757472243321;
        Tue, 09 Sep 2025 19:44:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbc1c467csm201563a91.7.2025.09.09.19.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:43:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3876D41FA3A5; Wed, 10 Sep 2025 09:43:52 +0700 (WIB)
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
Subject: [PATCH v2 03/13] Documentation: perf-security: Convert security credentials bibliography link
Date: Wed, 10 Sep 2025 09:43:18 +0700
Message-ID: <20250910024328.17911-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=bagasdotme@gmail.com; h=from:subject; bh=OYt2QegR/+u0q3CRKm7Zg38q7SY9D/3L6tdzv43Jflg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHnijWLH+uxHuD5TvzhcJo65MVRz8evf+ht/Kg8H3eu d3xR8redZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiXd8Y/pkdXvTh5u5HL7eU z3No81zweEv6gxSt+G/HWyxWsM1N7zjH8E/xHeNT5tNsutFpemIVy+M+5pasa5QSXynjZOFf2v3 OnBkA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use internal cross-reference for bibliography link to security
credentials docs.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/perf-security.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/perf-security.rst b/Documentation/admin-guide/perf-security.rst
index 34aa334320cad3..ec308e00771427 100644
--- a/Documentation/admin-guide/perf-security.rst
+++ b/Documentation/admin-guide/perf-security.rst
@@ -311,7 +311,7 @@ Bibliography
 .. [2] `<http://man7.org/linux/man-pages/man2/perf_event_open.2.html>`_
 .. [3] `<http://web.eece.maine.edu/~vweaver/projects/perf_events/>`_
 .. [4] `<https://perf.wiki.kernel.org/index.php/Main_Page>`_
-.. [5] `<https://www.kernel.org/doc/html/latest/security/credentials.html>`_
+.. [5] Documentation/security/credentials.rst
 .. [6] `<http://man7.org/linux/man-pages/man7/capabilities.7.html>`_
 .. [7] `<http://man7.org/linux/man-pages/man2/ptrace.2.html>`_
 .. [8] `<https://en.wikipedia.org/wiki/Hardware_performance_counter>`_
-- 
An old man doll... just what I always wanted! - Clara


