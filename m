Return-Path: <bpf+bounces-66949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EE7B3B4FC
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 09:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7618A0100C
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43CF2C3271;
	Fri, 29 Aug 2025 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiuBKP/c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B83F2C11CE;
	Fri, 29 Aug 2025 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454142; cv=none; b=XEtFiTF6OGdKv95lIa3wWq3c3i6qS+k5U8IRkJsPytf6bV7aXwHJDPVPb61SGsnPfBsuDczH5w6wNKsYQl9uwPCok+EwUA98R/Y+qF1/f/M1aLtSdZ2NMDKlfJQk9D5XMkOq53Dq394uf1BVdlecV2BKbSwKTMQ2umwCvwfFJfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454142; c=relaxed/simple;
	bh=YCjSy3OR+PtbNsOx3d7dblyTwJjnDEtFBwBCle5X25g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ntb4/KPzgMBpSX6YYbhb8lAnyjy/U28G3ipc9FsOLVRlXXlQFvqW0H7SqudvqXZEHfzzZgEIleAN86NMJSUK62NagFnJ90Zc55d43sWDSDcZ/1nzlYozg07R4uCKTas/JYzJySJHBf8qJIoFONMUsQ7lY2Idfun+bVED70ZlRSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiuBKP/c; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-248d5074ff7so11457605ad.0;
        Fri, 29 Aug 2025 00:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454140; x=1757058940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+SUGCH8uEjWgwJ6PdsO74F0lOA4arnp0TuRWyoM63o=;
        b=YiuBKP/calz5FJvlz6ZcrEMDDWLaa9RCSes0mwWQBJs66Uiyjt+r6XYjAqb/Fu+Mas
         IJDLUAN21ovzvGUesHT/FHEH8sUVisCGhMkzLo4jimNLJb7FoTpQe6pZDZkPR9J+VxlB
         qF3JIxDhLgdM5/q+fyYYef181ADfC9198spisVT3rs1ajMfyQcBseUpuey0ieqVxbyex
         0M1jy6TwTM1XW6BE7H5I/M7S0TfOXFxnHNfekjBs9VlUe3d1yeHXOQGML1TyWikOrc31
         oJ1Bg/cMnmrd1U+RpFqLYeZGWjpZefg/bofES3JdxNdbKHVXCl+K2IKk9naQwtZPBy2H
         Uy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454140; x=1757058940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+SUGCH8uEjWgwJ6PdsO74F0lOA4arnp0TuRWyoM63o=;
        b=Xz7VdliowwSHoNUl2I5/Ajm1Sb9YBo3NSV1pteGlY44qembxmjdfHqsFuJf02jx8RA
         cO1Ubcwgq/jx1E/t3sjidL93RS0VJ75AjJdW5muyKZHXu2s6HfF2O/bqRquOBKpN+stO
         /SCcWHVXKrG8I0TVlTIyuhk/M5s6uVfyMrDi7/Qzt0WV/7rC3Rqm0awNJTmedMVih1HV
         ICn/+k63Vs+WIa45vXQ8W5KU1V3qWLk+NHERNHb1Szi9/TyXZpHk1e0uuRWs+LW6CwZv
         Wh2QrLKkWz1y1/hd7s+4MaMaAyhjzMYALhdyB7Nab8anTZBZpzhRhskZRrXxrL08su+S
         OaYg==
X-Forwarded-Encrypted: i=1; AJvYcCU+/7CVTYQo1q8bpZQ96qjza+jpJQlmOMAqpk7Vf6J6mRaASMb0MNKUp4CQOxJPmgR3yGNc4TgAz/kES1k=@vger.kernel.org, AJvYcCU7tPvGvC6wqEZ+YkNtPd7Srhmhoh9zDGy5OMQAvjM7354mO5T7nSnwkNsTmh1lVK0xMJsVADXPNWFuvQ==@vger.kernel.org, AJvYcCVbhcH7Zf0wvD426cQhJEvnNEZFJxWojPfWhRWBAevAmgmcSoSLZbtjk19QqsynNqzIs+R/aVoYe9iPVOY=@vger.kernel.org, AJvYcCVxzk10e6/FddqyskRfswyEq/Q8BvhKH3kTNJZFAi5pWn/3fWQVf2h/80+Yzp8gDCLM0KIoVSJIjKs=@vger.kernel.org, AJvYcCW4EASCaEaKcizlRCYTTRAe8c2/1jHQcEDNNaKbiISH2TK6pgN0SmJwZ5hptHCQvjXWvwH5/h1tsFeEsAg7@vger.kernel.org, AJvYcCWGRMq2Ec5aKedsAfhjFGjv7sY4MJqnVK6Dats0GFwX9jBr/A2YKPB3Jk2+E5521dzGcP1ltSWV/jEF@vger.kernel.org, AJvYcCXER+qTda1m+uqnoUoW3JVjNzWjQnIHrUz6PzLXHFp/YSykE7+WwM39FxVNhpBKeJxXgag=@vger.kernel.org, AJvYcCXO6D7P6IJWmdI6/XBHxXRhmAj/NPDtJI4DI3mYmXtk4WL1YYcDnhMvw3BOB64gNsyKyi4iJmIv@vger.kernel.org, AJvYcCXsRsihCZnK/RGrvfgZH8I0QUf8qT2HxJA0gAEsueeFXiAvLdVYzmzbtAY2zQZg0fPN8yk+l0O4dSEB@vger.kernel.org
X-Gm-Message-State: AOJu0YyIQX/r6Yk94uoZC6KIgzU4mEGqcqifKB+h+NcPObg53zB/V8r6
	yvrfxuCMlD66GGos2Lb7hYL/A0nb0MJkypeL0rdRPkr23/iw9XKuUxeY
X-Gm-Gg: ASbGncs9FjYSXFOPgPD71aWjC34rGVb73ybAjxFRuZxZi3HoGu/370R3C7GtWlU8VDk
	Hosw1ezy8lannM7DztpJANUHnGHGeBOz9cvPQGvASIFMVcSjF1KJEmq+6QHRJ9TzSg4BmXJN8N6
	aGdDooetqokDsrhSF7h25NwST1EH6PIAbfkCagTxSainByG0hP7XUbL3Nau9gNKN7VaSYsnxeoR
	t9TDDcfxogCuE5e0kNZ7zDhUhUsxL45t23N3rbH7hlaU6S2pjKg9BxBihweWHAunqoqfZXrFWWC
	ah+ir2UoF5tVp0DhS2SRWlafuS4+oshIte4tfuwJxZ812Gk5fHJSWdMuUIEu8VbWvcUu1PM7psS
	VXn8PxnUXJcBNVxUhLkatGVtytzyO/Y21SgXF
X-Google-Smtp-Source: AGHT+IEUIbmp5KZdMZPn0c0CGQYstQ2DxLDepEvVflAGtJJLsQl7+Hp4DCT56TGBU1NzXfP4o4RcNw==
X-Received: by 2002:a17:902:d510:b0:249:11cc:2afc with SMTP id d9443c01a7336-24911cc303bmr18192475ad.7.1756454139741;
        Fri, 29 Aug 2025 00:55:39 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903704379sm17029615ad.29.2025.08.29.00.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:55:37 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 5F71C44808E5; Fri, 29 Aug 2025 14:55:27 +0700 (WIB)
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
Subject: [PATCH 04/14] Documentation: amd-pstate: Use internal link to kselftest
Date: Fri, 29 Aug 2025 14:55:14 +0700
Message-ID: <20250829075524.45635-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=bagasdotme@gmail.com; h=from:subject; bh=YCjSy3OR+PtbNsOx3d7dblyTwJjnDEtFBwBCle5X25g=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY14qPYlapHXxetwsqb0JS9jb7/0/73aj6M+zsn/7f 7uJBK+t7ihlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEJPkZ/hloBmcs7pqXLvRo 3uW3yzpsL08refrBOejE1FfXjopF7nZk+B9pJzZFXlK9u2zWB3XR7Keu63hWz99heLTAzXSF0Y1 5YmwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert kselftest docs link to internal cross-reference.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index e1771f2225d5f0..37082f2493a7c1 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -798,5 +798,4 @@ Reference
 .. [3] Processor Programming Reference (PPR) for AMD Family 19h Model 51h, Revision A1 Processors
        https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
 
-.. [4] Linux Kernel Selftests,
-       https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
+.. [4] Documentation/dev-tools/kselftest.rst
-- 
An old man doll... just what I always wanted! - Clara


