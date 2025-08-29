Return-Path: <bpf+bounces-66956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9BDB3B564
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 10:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94587564903
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 08:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5272BE7A1;
	Fri, 29 Aug 2025 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5tprWdj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88772773DE;
	Fri, 29 Aug 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454578; cv=none; b=Rup5xPbkwn04E2UfHo2SslVrkhKZPeyzWxhoViqA5ewDkWg89eIH3vz+LPzECowMWDhkISIJsoRUy/0sC9kk5QTPhhpZdVk82h/vz65qtI5fmjMNLz8JvcB1pz+kRsSOw30u71dzuqRkRbj6LB5rCCzbw4+HEyICbdQLJTAv8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454578; c=relaxed/simple;
	bh=lGvjj6RPPbr58GqrWqgYvJfKnQd0kE/Khje7rmfw55Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfclUnR8Vi2Ycci4B1+IOAB+iWf2TsUFCHV8fdjacbJAUDXA9nSTyaL4Yt5+VreiW5rqy3yjEM1q/1fIpoJHk7RiQPp9hBuejuyD5/bx5z0sJogtjFZSlqJRrIGpPGNfqjQUzng9lT/UVGx+keeaYsDIvcvv1OqsHwLvW6Mpw4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5tprWdj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7704799d798so1522391b3a.3;
        Fri, 29 Aug 2025 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454576; x=1757059376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUuceR9E3vzJz5a/JHCoOJAb1uIOOWcnyWbxLYGhp7M=;
        b=a5tprWdjKWLGHsGIdSRgCYfaYN4Z+HoeN2FkXcZdaqkgj+e4lSILjlU/rLMCB0BPxL
         /h7O3O0sfFbndGR5aYbr3dQf4W33G5gsNI+szurmassIl+3Iibdmi0Hl7FPg/Oa9x/NZ
         9zoKn1cfhjlkFeS10ihZSTNR66ATqtXAB+hFrNWp6U9krZuBKWK39L2EZ26KqZFzB5/J
         NETQVSyOlS1CUVWTyJgzz4zQ5n5yFXXGaa/izbWXIby20nDJRSP1VD051hYtI/TbNKrr
         KbRJrThgYGGYzPX+34QV2VhXqjTzAn5lWhWgHGlFWaz64vB55ZgazZBTz/vxhwuCar2Z
         BNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454576; x=1757059376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUuceR9E3vzJz5a/JHCoOJAb1uIOOWcnyWbxLYGhp7M=;
        b=UTIBguqOCGRmnwurnHJfjRiT4OhZm0x71jmAPqhLlLjTXRPQPsringL+mLngS6nbI7
         li4QmUleJEUrpsfnlHS437+9H/dzLUn974PlPUqDe+VAUv/4p99nq9VR1xDk8/izCtP1
         bnsgdZYdwQUD3Qde157L4kP/SLy0mYo8CbYF6urJ345uj0uX8nDMnjiC32iDBI86mXjj
         VShTnvHPMa60yd6DRkUb97WcOmiA8ULoB6t11FqJb8IoYi3DtVFal/ZkrOkzTJT0A/00
         x2ZzcwIGAG3NsG1WkCvRguFXAdoevewnh9gF0jaQTAQ2pSbw4jX2HPPH77/bVzFEYkd3
         kV4g==
X-Forwarded-Encrypted: i=1; AJvYcCU2ZUtTg4xCDaP5kQ26H1vDW/zSrv9xhUPFxxqpYVw2X7T/z4Hoz+SqXmasjN5/oC56HxEBrv79B5fX@vger.kernel.org, AJvYcCUMoA9oSelLZ/SGhDMt+XINHEqffs9g+VtliK0VfM3GDA4oi7gEdH50FuhT9MWQBTjS+f/J6I4KO+fohwo=@vger.kernel.org, AJvYcCV0hyhKUaqChFA2P4pdIu8vzisN0lFND36Wyy0tpvq8Jrzw8YtPHc8J7CGFAoHZJeOCQ9jN5sysMs6l@vger.kernel.org, AJvYcCV25FDlAiQBvJDLbkEgvcYnPZTGMspwNM4ll5h0T1D752Q+zEVXULInx40ngTMm9TkdzKhxxDlZZz0QR3Y=@vger.kernel.org, AJvYcCW+LR0FOlPkKSpZEv97jTPkr5BKD1Oizu9zAUcLqvjSF4nMm6OtgRIPwKue4Tu7j5oqsj7ZWGzq@vger.kernel.org, AJvYcCW1D0pptPHWWuqhQuW/Eix0Yj0uvQG+48L2EmIbkl9HefDlQYmpfJMMvHCILV8ytFCDmZNkB7AGmY14TeRv@vger.kernel.org, AJvYcCWc4NCNGgfItgPB7qc5D8sL/jSk6qR/+1i4BJeF+zXcYR13MiQ9cJxr1dI85XNTGdu5U4s=@vger.kernel.org, AJvYcCX2lRsc4GciPNHa7A0HUZds7RFs6LFTPrDqtx8DlvbUTD+3zJPx6MW5mv2cPsOoM3p0o0Z6EDfhIzaMMg==@vger.kernel.org, AJvYcCXHzOhlVu93wylKgkq1WGWVGOOhH92AbKkrCiM5m5Ur/9unt52AlD8Dpyhb/6+UaOTkhAcGkYMWmbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytr82nN3PLLl4cn1E0txrRf4C+tL51/aZ4wIxN9tApVbyG+ixz
	bHqYqnsBN/GlRefAYAJdMSQl/wrWC2WYgPjRKxt7bxfAJm0bCApoINoz
X-Gm-Gg: ASbGncsuzo432CR+9es+FIWaXUoOhVnTjAi55VIKsdCu7j6Mx1qljeRQWktYrpT7V7N
	wGhAINPxeUEaQBIApoEEITrnKLmOF/lZ5OP7WfjL3uEk7/gap9JCxt/CeSXTVJPVX97DKlkVUQ1
	ehP9DpIIabO44YYc6O0xPvyyzCL1Q0aR7gco7UNxsp4DS30iK3h1FrPi5AxJL4x07FDPgzFupCb
	ieyWu2mZhgAg8ng3mlhSxl4kuN/zcR2eQAvfbvvyIhCBkQMwK5kfEvcny4jsUw1OhQnxzdFbM2+
	SmggdiouwcCniXisVgIXhZaiHFllsekuvtScah9YprokGUkaAWam4JLvDDt5T3L0glUkncpEuKC
	rch6K5no3Nrh+xIYU97IoWUg3Q10IDSXKBtwr
X-Google-Smtp-Source: AGHT+IFt0CgZnKjzhJ5g4aj0Cm28ZWwwe3q9IBbh2aQ/4X9BQsH63Txhma9tsRWuYD6j70bLTYHjgg==
X-Received: by 2002:a17:902:e890:b0:246:bcf4:c82d with SMTP id d9443c01a7336-246bcf4cc37mr269048275ad.52.1756454575739;
        Fri, 29 Aug 2025 01:02:55 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249067de9f1sm16493345ad.151.2025.08.29.01.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:02:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B95C34480990; Fri, 29 Aug 2025 14:55:28 +0700 (WIB)
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
Subject: [PATCH 08/14] Documentation: gpu: Use internal link to kunit
Date: Fri, 29 Aug 2025 14:55:18 +0700
Message-ID: <20250829075524.45635-9-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=bagasdotme@gmail.com; h=from:subject; bh=lGvjj6RPPbr58GqrWqgYvJfKnQd0kE/Khje7rmfw55Q=; b=kA0DAAoW9rmJSVVRTqMByyZiAGixXOmjSTNEt/JFR6AhPDWfGCcGj/Np82/Az7wMJic3oIar2 Ih1BAAWCgAdFiEEkmEOgsu6MhTQh61B9rmJSVVRTqMFAmixXOkACgkQ9rmJSVVRTqNRJAD+IU+J KWDSPb94prUVj+FntqxPO7boU221XL2jEkITc6cBAKhpWT1CuLYVAMm4rv4hGzdOOa9sljkO4cB hdLolzx8O
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use internal linking to kunit documentation.

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


