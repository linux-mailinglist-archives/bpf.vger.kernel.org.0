Return-Path: <bpf+bounces-67968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B04B50B94
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A2D169042
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A4B2798F8;
	Wed, 10 Sep 2025 02:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+WYWbUG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E60274B34;
	Wed, 10 Sep 2025 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472250; cv=none; b=qxAMBqlGkR/ARmcAbU0FnpmRLyXkRRfnz+VIEAaGk7aRJMfmzh6opQEM/RI8RQV42yFWhs/71n3rE0JQICJQHWkPY5gH4wZp7sdi+leKj8VgXY6hbEhLz027IOszi3FaDXKK/HL51To48uT1z0I2nXUIcq+UURt0WO8Pd5cClHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472250; c=relaxed/simple;
	bh=WOOeaeuC9/RH4phIV+H+QiLxF/prahARBSHjeoa181M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxyDmWlCfJZxdFCBJrglJ1Rcsp6L1kjR8UuOkkR/1Xs5UWydBQ1LmKSRAX2uWoCZLwmdeHwO4g8T/vEeIxOuDQrTxr9i9z1Xg01AuhqVsdbhHtNDTtN3g6YIM90xqgb6XwXNOm+SythJlGrvjnv5ZkgVc1gXMlunTpNQBeUzrew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+WYWbUG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-244580523a0so68087305ad.1;
        Tue, 09 Sep 2025 19:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472248; x=1758077048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BATnrPttTGOeKRCCT0K3V4HzIU9KTE8stAVBRczt2LY=;
        b=K+WYWbUGhlj2W3an94pU5lZl8o7WsvuLzprhkkn4j+fVFKMBXQqPiTJ+nkNShP9YGG
         /n6mb7CDRwN/7xkHk9D8x/gYC4tfhTUzuL1nWnNdQyfrgm7J1Hx7pdLCtBdN00g7NzFO
         5IuLS83RZItaJwmLm3E2mFHegDSR+dSvYsN0vsWxkenkNPyf49jCcOTHbC4LIKxMLwC1
         qirHeI2Ju6H4OflpsNwl+Ueh6a+DTSZ171ofPNDJA10qb/nkz+Z/iotAvfVcTeIdUGvr
         /wS62e8qnG+ZDlw1q1RaKIQMVa45IKvuaD/oMR3hjSlZLYWI0WEj+H2vGfxooEkchS37
         voXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472248; x=1758077048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BATnrPttTGOeKRCCT0K3V4HzIU9KTE8stAVBRczt2LY=;
        b=Q30IS/jEQV6YuUEFHfyz629BK2DA0r9SoOGQqjCJyBJd2+WWiImhc+kp+ieMqygTF2
         fMqougnQOHl8NMJRQv2cfYnuG7YBjy1itBvpvSZW0aPr0v+/qruw1l7lf6tD1y+QNbT8
         zzxr9KuKTS3RTBtCKe+LTeG04NLM+PEjDC6sjk8JDOlvL5e6rsikhXdqwVPIS9+wB1KS
         p433RZVH0lnHDuPsGF3acwFusy7eMpQmKDdhsPVZN9Yxe1jAo+BZhAOf1sEhzEO/bCnc
         tHLk5nx5kuon5ueLoVBd6/uZlIAL81UlKLCx0AmfFWBAn0jZ6tJWgEzoFcJN/aqDCRdk
         rRBA==
X-Forwarded-Encrypted: i=1; AJvYcCUBOP2qfcObTZSGA608xN3ipkKbWBx7Uoti+yAdLn1Fk3YLXNLuhaHR/jp52jwYqxkyn7/WaxoUQJM=@vger.kernel.org, AJvYcCUhCddqQirwngublyEZuthSc3MJ1Q48EMqs2G/N4KPvysjaFOxgSyxyfo6JVDWMKQvvBRtGndUeiQEXxQ==@vger.kernel.org, AJvYcCUzzlLVGKIrJ5LxpjfVGcaUgAQt3jqwdToNMKUKI3yDB1cwR4/ew2SCjNshdtM3t9mygAWN7x8IZ3PrkM4=@vger.kernel.org, AJvYcCVHu4OSeGqQLEMOedXCnrC9zKA+ke6P/rHLHVjERn6x47iM2DrHGDtvdLc5eKYvodhhQtXiFrz3@vger.kernel.org, AJvYcCVKbzW+pq6Si6a+/iTwGQFdrPKbpLlwkRbg8PW8EJjrkTp+TRDIMlR2EfMeRXSZIKLjqdEDbzsdZZF5A1U=@vger.kernel.org, AJvYcCVXTspUW9EuhnqoZvdkWCewBn3nRert27R7d8i2NXfvBdQGVCkxyKHqEH4Qu0idp5VI8Xgk/KD3HMxZzbg0@vger.kernel.org, AJvYcCVsHROg7f2XsggHujyQZPc99IoevfFKgEM7pxfGh5WK6h8MNZQJyOFltbRp/e6CZNhiUSNYtgKAtO+n@vger.kernel.org, AJvYcCVuxA7a9hwDN6CdrH9aRZR94/RaB+qfzXrQZylQm3jpyRD5m8FQj7sMQ0zwjQ1wmz8z68E=@vger.kernel.org, AJvYcCXaffH/8vG5UDEB6THR3/W6aZACjqLgKhgoAVqtVlxvjuQQ4EgNE7/Q36SilbIANX0/AGzQNXxW9e7N@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlma7uhHEBuSaC+hJ5wL1rHiwlmp1Z8EEmqgqOVoIkFy1gzoRi
	FrOZQWMBKtL0NKZKB/UVW6d1Eiohr9S1D99uHnZj0sLOfa6pxVgTCk+v
X-Gm-Gg: ASbGncvgptlXC2+qdTqqbT6+Olfw9CZuLVh3jEBWXv1wS1gW3Qh15IwA/ukD7rq2HhD
	sPP5Ulbg4yOlS4R5VIfXaZQhZI3dSXkNYM2CaKcSDLG5nPnmFch0kHFkiuf+R2yPJPbA5SGgeGG
	PZIpwyq4GJCv5ZM8Z8SXg83SGCqar12lF/AXNkDG2Pg9nsUsLO/9ZnKKOsRTwSEjuHw/mt6ShcD
	ZM1elWKcmLfosUN5Ig+SpWYXgxfcLl8q4NlHXTLRPW/03/WW7O/SFcWAN4iyI2uPWRAFIutoG1y
	Js7UeRiorwSIwQib2Ru65QpTVNO/otmeZPQ0/r/K5vi5LsklbFuIPcRXaWZH28hrAy+uOlxpt7f
	LEiZiiKUnZ2dKBN/f5A70zz6Z/HRF4ZBYKkho
X-Google-Smtp-Source: AGHT+IFT6YbUc/m0qKUsx2gIlS1cyHwFE/YTWi5ShK7yx8zu8toS/bxgvdpLpOBm2BAA4mGAvmnSyA==
X-Received: by 2002:a17:902:d501:b0:24e:3cf2:2457 with SMTP id d9443c01a7336-2516e69aee6mr211563725ad.24.1757472247632;
        Tue, 09 Sep 2025 19:44:07 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662ef781sm3491871b3a.90.2025.09.09.19.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:44:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id AD39841BEA9E; Wed, 10 Sep 2025 09:43:52 +0700 (WIB)
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
Subject: [PATCH v2 08/13] Documentation: gpu: Use internal link to kunit
Date: Wed, 10 Sep 2025 09:43:23 +0700
Message-ID: <20250910024328.17911-9-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=bagasdotme@gmail.com; h=from:subject; bh=WOOeaeuC9/RH4phIV+H+QiLxF/prahARBSHjeoa181M=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHnijZrvnhN9eJ1+LvAp2zslcUft9O2uC6e1HKcd4J/ rFLDLiudJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiyg8Y/lmtiNJu8EtVbugK fub0kTH31Gy3pLdrgoTZz7qUXricksHI8GebzZaeM9lhFZ8KFVTdJ9stibqczP1vypfAmIZda2d 1MwIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use internal linking to kunit documentation.

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/gpu/todo.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index be8637da3fe950..efe9393f260ae2 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -655,9 +655,9 @@ Better Testing
 Add unit tests using the Kernel Unit Testing (KUnit) framework
 --------------------------------------------------------------
 
-The `KUnit <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_
-provides a common framework for unit tests within the Linux kernel. Having a
-test suite would allow to identify regressions earlier.
+The :doc:`KUnit </dev-tools/kunit/index>` provides a common framework for unit
+tests within the Linux kernel. Having a test suite would allow to identify
+regressions earlier.
 
 A good candidate for the first unit tests are the format-conversion helpers in
 ``drm_format_helper.c``.
-- 
An old man doll... just what I always wanted! - Clara


