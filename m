Return-Path: <bpf+bounces-66948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CA6B3B4F4
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 09:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D90AE7B4CBB
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 07:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E792C11C8;
	Fri, 29 Aug 2025 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwmMYXe2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477DC29DB96;
	Fri, 29 Aug 2025 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454140; cv=none; b=SLm74xoxEhvH5+tfg6svMAt+Rks/Q9Hk7bPZsgxlxUxsxv2npTwm4J4t/ALAQB3QjMyyPk+SZUv1xS8d96GSqzWuPz4CvXGZeNDWnObcx0V876mPmqdFUmVCBhgRntBgESSBgKFWImeyblA1/uUruK+HWFVQ6xb7JR1Z6tbCwAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454140; c=relaxed/simple;
	bh=OYt2QegR/+u0q3CRKm7Zg38q7SY9D/3L6tdzv43Jflg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6AT7vPKRfZGZKRFgkvZNnBRRbEM6Zs8Z8TV0qvs+3xI72sPGksdz/ocijGLQf9esMKIcD5ASzVEeoeXWtlg7hXgJHx4bWii5GXClkWiKRmpSVUGOG5T44iQOZp9QAv2LraZtu6byKQ8LnAzt0ydH4BbJC4c9I1Y2O7mjX/Ywag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwmMYXe2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-244580523a0so18917595ad.1;
        Fri, 29 Aug 2025 00:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454137; x=1757058937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0koFSnJrv2UowuMhMeqtiJIslvN7BbZv6mHXQ/mKo7A=;
        b=FwmMYXe2zWhbsv5Vnm0izxirizTMf/fPpkqcaHVNtEvps/DGNTHJOSrZQuoID25o/T
         Kt1KdSmj3Ep6mViLtJPU6+79oRoKFMKCHotSdB5KX0JXi8oYiU+qnEUYt6A0H5uu9tQ+
         8jfk45/iQWJzLmFOFFj+sCuNPjE/BEFJwqflL/PusXPhfiWaht7QANUXoadoVkztCd0q
         P1KrTQIL+4ttxqS74MsHLE1xh+r+ikkrqPi4LUtcwGynBHSirK0oHN62Wpo63D4BWzLG
         28uItPNgxBzmUeH4tmhgJKWGeLerRzxIRe8Wr+8R+QWmN7H6LwQ6nleFfsbdg5GTdDMT
         x/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454137; x=1757058937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0koFSnJrv2UowuMhMeqtiJIslvN7BbZv6mHXQ/mKo7A=;
        b=h3unaKe4APG+W9u1jiNoYuQI6jWMaLMWN4PmAEyJCUIpxIdaGNeem9++Hna2Zlh5XU
         8+TUFMPE3+szaSiilUNYSVG0wVzt3ypIXN+Y7x5eVPTCVYx11S+dHMBxvRuPC6Q1ntn4
         XWRjjoVqaB5y4ohsCW1SOSfdZrbDvk0W03qLmTFc/fyq5jjPZtw93ovRfswaM+m548De
         J5gnt24IdCsOYliBn2Mh4tACJnV/JV5GtmhttIR28VtUqoPH9Sh7gZVXsNtQtfxhvDLw
         1RM0gmlrouMsWjeQiI+pTB+tVOnI2Soy8oiHb2YADw6k5t6dKCOeZVnC7Rg9clfMZdLD
         xq9g==
X-Forwarded-Encrypted: i=1; AJvYcCUE2aGVVvFHC5NyiyHSniBgCFplubWu29422yybQ5eRim+ToY0g35KouuK2jsM8P5bnGevVhrBP2W7h@vger.kernel.org, AJvYcCUOQVqOmC4FDMzFCoTbgDeZJgJ1ueQ9t6rsU1WBGcFNa2nOWB5niNa+aw5tCLJOmfxTBI8e1j3PryTLNg==@vger.kernel.org, AJvYcCUSb9a0jXUCpXdfRbb1umi/gPjvqJs/iy5ml4bEdLpL6ar+KmPmeGsMWE2X3GU3TvUcSMk=@vger.kernel.org, AJvYcCV2AxA/S0lVzjXdEh9ZSNv4W3NIA2yBUAPxNd6qSFd846H2TEYylK7QJXlHZYj1Y0yf9cV5xfECfzmN@vger.kernel.org, AJvYcCVMbrogkDkp2UfT/u67OVkjSJeg8c493GkKh7wjhjlHk6y4T9e9PM+6PurUshaNDy+KHXEzDj0t2sgylpc=@vger.kernel.org, AJvYcCWwgsViaOkG+NGfWWKqBKZAOf2V/665V1wi+GbvD9ZaIq4rSnzW000lY5BVA/7fLGp78P64ULaMafOtXeo=@vger.kernel.org, AJvYcCX+lDM0lC+DrjmEmdO9KU6wZVucLV3AnZjUR0+v+NCehGpcJ+hUrfX/CHAfeYoVFhQyM46O4f26@vger.kernel.org, AJvYcCX2+yw1mvYG9acfYGMw479QTCCSJANLhFNQg946mnDnQBqmcRujqj7XiW4gG4lC6ACHaQMDLWDGbwDBD+Dd@vger.kernel.org, AJvYcCX2y3tDA2K/URoOVI2Dg3qJJ09229SYpCjn37xM7xB3H4O4Ib2wZ5f4KqZs8gITiDYg872+YV/XtZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYh4oMHPHFWDa+rkcQRFh02/7bfU5gYcsEyn9ygglwLfFiYyQ
	S1WyKQzcu4sQHzkaUYUGzmfGpXhDnlr9bgewgxginN/d828q4Q3tbB8B
X-Gm-Gg: ASbGncur/OY30V5gm/9/RdHEEM2+ypOiFelKVl7Io4PMFC49ioT8QCfMJ/AbZPPbeDI
	WkbDHRp9DBXTa7/7MrNPD9PVD8QKFubRq5aDcbljxsmdaA1hpMKNQvXPWhNv/aw8jPL61uJLcaC
	YuOQTQz8Gx64Hdovb8lNvxc0OiSeLsAFb8xi78TemBDq5jxCQaLaE3NusAqzl0g9o0da5WN+hxf
	inSuLPY4fjZXdoZUmY3QzLaZvNd29BhmJYpOUYbQxtBVqM4NAdF2pfHrnS+Ep5X4uCFE7VS/OKm
	OsupzuSRERzdTrutgOwIDj89Fo0bmpD8MR7/yD0tgsDn/qxBwH1/3XDv/AEKazs31BQAAgBteag
	PS+WbxpzdckSQ2fv0pgapdFrIFw==
X-Google-Smtp-Source: AGHT+IGNjBdTFArxVwVJhrEyw48u+wDRa+YP0G1KaeCtmArj8lT7+bi74vyrPcJB8r8IUDLpPVmmVA==
X-Received: by 2002:a17:902:e888:b0:240:a54e:21a0 with SMTP id d9443c01a7336-2462ee13154mr358734785ad.19.1756454137188;
        Fri, 29 Aug 2025 00:55:37 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da26b9sm16688215ad.93.2025.08.29.00.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:55:35 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 2F80944808DE; Fri, 29 Aug 2025 14:55:27 +0700 (WIB)
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
Subject: [PATCH 03/14] Documentation: perf-security: Convert security credentials bibliography link
Date: Fri, 29 Aug 2025 14:55:13 +0700
Message-ID: <20250829075524.45635-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=bagasdotme@gmail.com; h=from:subject; bh=OYt2QegR/+u0q3CRKm7Zg38q7SY9D/3L6tdzv43Jflg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY17WLH+uxHuD5TvzhcJo65MVRz8evf+ht/Kg8H3eu d3xR8redZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BeAmZzL8r1qVsXFN0aQnhlcd HbX/7Z5y0OBc87cVSY827u/OC7GTfMTI8J1f/vkt1YY1nGfMLy+IOlnmXaYQu3XLZy7bCT/2T+u /xQUA
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


