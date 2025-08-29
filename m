Return-Path: <bpf+bounces-66946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272A9B3B4E5
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 09:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6A6562059
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 07:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6187928C03E;
	Fri, 29 Aug 2025 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAuafXqG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182142857C2;
	Fri, 29 Aug 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454136; cv=none; b=Q8LKIXom0ZPSk6RjokwxmpPl9dlgvpFy1Pt+b/X25jEYYUO4rmXRaMmJf4KDlVcnPJiomR3hKUY0nEdaQKkSslglm2nxlXIFS44fLoZ166+WwGQQZ4KN5HEVJ9xJL3Rxr4T/9Yv3fatyltBG84ys7alNZnEF7M0DpGFMT7BxqBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454136; c=relaxed/simple;
	bh=oQ/U51BIIgNGsRun+kwInz/tmig5xTqHruGeEvNRxQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3y8+ewm+716inBxYqThUiibZ6wAk6v6HCJT7/C8uHZmqoeg51th9CpRMCAZ8sHSG3dYGurUtgXwPE8P6NitSrL8LCo9QG6di5uNpO4WJ8mSjdjIjaLl/Tck4B4K9Flrf2NXIiBsTn3UkBXqRyPcyf7DZ9wjUQZCALUSF7/c9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAuafXqG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7704f3c4708so2199480b3a.1;
        Fri, 29 Aug 2025 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454134; x=1757058934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKHUedwTpnE+6902OLKWJUrKeeyE0icmaP4M6h8VeIM=;
        b=KAuafXqG690UxpnLiISh4UMSpaxxvihp1iG4ytY70oJDiF/BIneIX0COIzV7wOP8JM
         yNV/EbONZ8YqwAMIxVlWDHncHGE7oM/uBT78ilF22gSZGn4nDElHw8yOi6YIjeM0IKa5
         39mS5COThbqekVNxIxA8QEgLgNhFRxbvUtIURDT9Po9nfjsoXsEAzupZ0yLMT3UlHwfs
         0howrt/wMc6zd/L0MRf3Aj7suFyFiAWes9wkO/nWRFDdz5xZDVwOSmW6/QfPiJD1HHWU
         YPWVZnVSVZp5++TL25gm4Sta0DXPY5ywrPWRYPpbEFAcZAoQCFNSix2Yc390IwAtT+Fm
         bRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454134; x=1757058934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKHUedwTpnE+6902OLKWJUrKeeyE0icmaP4M6h8VeIM=;
        b=MLIuJ5U4zs9Gkm26FVYwNWN9t0+OjCO1lwejLp5C0K5jcgeIVoiRKSDdDdsKmvBNV8
         Xrg7cmmJER38QW8oPZC6Pvg9UQ0qFruFoQVtggXy+BQhYxWU0PKFsk8QXRqhrfmSiJgG
         UG1mKC7rETt6Cjb4SmThvtWpQ+/uzl+NRi3m/GkrAseF7AZ6EYfDbwNgZcMFgdxglHC+
         AQOiEqb9eBJuJbwtVR5uynKY60Tu5e6ebMTozWdJepkR7uTS3WX1DTulqhYquD27tNVu
         m00wrugPB7eAIO8ZfFM1X/l0KsDCnCeAIeBjMbBe634LxI0wnALysVN3B8CyrPLKWEpL
         FwGA==
X-Forwarded-Encrypted: i=1; AJvYcCUpKGhp630GUvtASmmtI6Q8Poyu3ABWRLYM/RQ4S/Uj4Ujx4Yo0EtDV4g9Y7U1d75/6t1wFf7oHO3DxrWg0@vger.kernel.org, AJvYcCUybJM8DNGlfop5IezwRLuFpyPEN9oBApyg+5aaQJYD9lM18R4GnNcETneOWg2PbNRDVzkGxtPVCe4l@vger.kernel.org, AJvYcCVO2k8tUEpCQOqOQb7gtLdvIiqOTsI4AIGKAC99qeYOl1DfXf48YALTeecImkhXFMQeWsFvr7SR@vger.kernel.org, AJvYcCVW7d/uYhzsShiGGk7yXHKZcn/EA9B1vz+2l0FeLBFCyGTgTVs9AmaPS1wYW6flZhM86DXdOoA5X6Q=@vger.kernel.org, AJvYcCVpqvowjwXlibtYcxIJx4vTXIY78eLDltiQY7XAAKeWU7jQJ3cYu78d005mBkYXYZ84IMAf1xQSRy55DQ==@vger.kernel.org, AJvYcCWYtVCvgGlJrAiUaIh8aksIV49tpe9lwAgZMcoJyaxBsj45CQo3bwWlvNXMqheFc61DuSPHEqaRuaWL@vger.kernel.org, AJvYcCX3Evo3bwRHlNUJpm5l9xkGz5UhHeAldGof9/fU8m6AUWgQH5Z2fssUO0rJYbIWWqv43dc=@vger.kernel.org, AJvYcCXUW7YMa8ujA9K+FHkfSRNE9jrniwJ42/OntZx1bz2AiHBUoAgDOKkDiYaZRqbjNJZVtrsdoYa0+c0h+vc=@vger.kernel.org, AJvYcCXmFsATSh0SihdklJVY7lH5kfoyF6toDnnQARN1N9Az+f1ISyaD6deNHc/KgRENqT97+MfxebsjpaavaFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzIcF2JgmT6NqW6FfTpYYpYBk5ueEj+X5yYkT77irxu1L7QMLb
	LxJ3GHvbkjJRi6jlHY1BlxbQSeXTBNi0BHGvksMkyXrA1y40riLqNbo6
X-Gm-Gg: ASbGncsaU/g/ikjKDIZ57aPa1mbZnbMItZkJXU2WTlzZEQ0lhMLfT0590RWpUEb2htN
	woC6Pg13HLV46s05Fpq5f0TTPevIJTIsAJnnvtW0l681MsPTCpjsXD+c6X8h2UL3qVm0sgoKkna
	scmgMrIOOmQbJ1IgrKnTxcTm0bisPcRok/7MTWlVYOs/lU8ObKg0cLmoS4gLoG/PuSzxS1pkKeT
	x1FCYyMsTIkm5Gqhv/fb8GDE4w/NRTr1V/fHJylDRZ5m2qIkf69fN+3tFHqJJy5fu1RK7SN/bC0
	GwGSd1NaR94zStvJjQGNOE7vOqO2tdv6NHuxdptxDvVlfDheOnggFccZMMfFf1RBiQ3B7snYo2A
	vdQRDBpjkFgWQOhHRxsC4EPiTcQ==
X-Google-Smtp-Source: AGHT+IGAIwvY26FUOsw+74AGPHA13vcCLFsNdM4e5R6RQVZDqKcVncdSUEtOIO22R3FiVyKLzy1QwA==
X-Received: by 2002:a05:6a21:6d95:b0:243:9824:26f0 with SMTP id adf61e73a8af0-2439824377dmr17475585637.46.1756454134181;
        Fri, 29 Aug 2025 00:55:34 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcd336dsm7401665a91.18.2025.08.29.00.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:55:32 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CE9134016442; Fri, 29 Aug 2025 14:55:27 +0700 (WIB)
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
Subject: [PATCH 01/14] Documentation: hw-vuln: l1tf: Convert kernel docs external links
Date: Fri, 29 Aug 2025 14:55:11 +0700
Message-ID: <20250829075524.45635-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=bagasdotme@gmail.com; h=from:subject; bh=oQ/U51BIIgNGsRun+kwInz/tmig5xTqHruGeEvNRxQQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY144a/JZLY81M41OfrJ5W/1jtyyro8lZM99fCflwN Zg5yrW3o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABMpCGH4p3zu88Pdlu95fhsv /CZ2ieHwual5ab7C13i5XivpL/Ip/M7IMI9vYUN6A5f856j5POvK+r6kxCYoXlPd7vthl2/zPqb NrAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert external links to kernel docs to use internal cross-references.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/hw-vuln/l1tf.rst | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/l1tf.rst b/Documentation/admin-guide/hw-vuln/l1tf.rst
index 3eeeb488d95527..60bfabbf0b6e2d 100644
--- a/Documentation/admin-guide/hw-vuln/l1tf.rst
+++ b/Documentation/admin-guide/hw-vuln/l1tf.rst
@@ -239,9 +239,8 @@ Guest mitigation mechanisms
    scenarios.
 
    For further information about confining guests to a single or to a group
-   of cores consult the cpusets documentation:
-
-   https://www.kernel.org/doc/Documentation/admin-guide/cgroup-v1/cpusets.rst
+   of cores consult the :doc:`cgroup cpusets documentation
+   <../cgroup-v1/cpusets>`.
 
 .. _interrupt_isolation:
 
@@ -266,9 +265,7 @@ Guest mitigation mechanisms
 
    Interrupt affinity can be controlled by the administrator via the
    /proc/irq/$NR/smp_affinity[_list] files. Limited documentation is
-   available at:
-
-   https://www.kernel.org/doc/Documentation/core-api/irq/irq-affinity.rst
+   available at Documentation/core-api/irq/irq-affinity.rst.
 
 .. _smt_control:
 
-- 
An old man doll... just what I always wanted! - Clara


