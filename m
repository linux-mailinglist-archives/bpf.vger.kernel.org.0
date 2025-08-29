Return-Path: <bpf+bounces-66959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C2CB3B578
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 10:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198CD564FE2
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 08:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DE82D3EC0;
	Fri, 29 Aug 2025 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBB32ZE3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE9829992E;
	Fri, 29 Aug 2025 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454582; cv=none; b=HwA1YhrDQeTHO4lSm7aWeIYOkZQlrEEgg+V54wsFKgFtCBBilcQRtd2TrHcmw9Z+fuCUsN/kO/oCbsL3s/LCGWkxUHYz9MSzoUnccP07fOgw7D89vpzAcy8sdKquXFmao4Jz0gCMbTFufkA2+Ej/IP47bS8aUpmavIh5EcR/hBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454582; c=relaxed/simple;
	bh=eMX/Qh24hdl/D8upWlphNzasCNRD/YCgXxsSIbz5MxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfWJ3QmlNabph2hpImO2wabaFvpuC1epNPykoJGKSStza1eU4u/ULyKfqko5JapK/W9Bd5C9l+jFDmr5xBKyv+kgWCbkl+J3iQoz1cqquf7aOtArOhQHmsYgFKmXWK+tFKPwya2t7kPX0z/DoNQvw/SarrC3krPjhkMem/v1nLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBB32ZE3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-248df8d82e2so11752065ad.3;
        Fri, 29 Aug 2025 01:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454579; x=1757059379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AfZlK+2PpvnkbeUUWLESRnsPEd9fz1tduXIyE8HjWg=;
        b=LBB32ZE3h6wVAtBgQkBBDLcZdfoFS6/AbAuz3H+B89It1paqDs8stvayV9p8vCPHJe
         DnMdKmThMwX/dhaJISNWXMqCZAC7BJeMMdAk7tUgRrzhpWs44bCJA4qQNbZ2qeOp5G7L
         /dzQiVvAB0bQQLDsRNvmFHahF4Pu0/XaZTakWb+B9L6dC2goVyU2cr2OmGRvImgwhvPQ
         fxEhM3WU88vilITw4wzjveQjgIbbllGzyc2q6/zsMiNrT7Gv+PhLUu5bvLLpnpAdPMXd
         8X5cGJagF0WQuk7Qw/I9mR9U86+xedE7ZMB8NrtljCgz9eU+3Z7IilIyldcFAT8z9ba9
         Io2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454579; x=1757059379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AfZlK+2PpvnkbeUUWLESRnsPEd9fz1tduXIyE8HjWg=;
        b=vLl+slBl1kWpngjzXE0QeiGJqIRIf2E/oTCcrrwMhpLYGInyF/smv3Ft9OgCQoz4y0
         HoUJ2fTtDJvc4nGaLm5whUGnv4TjTd+6BBp6JjORpdaajMQdMPTdsYTmc/kiCUIcPgfP
         DDN93fIzkdCfRYNlesN35zu4fdMmQH1fh6IGkfcYQUGir/kPdpIAO/0g60H8l6WDLkdX
         GiPw9fDS0LspOfdYsiGcLLN5QQzcw09FP5r7jAg7iTMqT9ZvL8DAmxX30MK6wrrPRN25
         K4b7OSW4kXGn/tCfWnSa6wLOXm5oOPz9P8GhDwHjgI4TnyvfNCef65fBL4Ygi+2dirFm
         j4jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaMWqDrpxeb/7v2nRwbambWuC09rs1oIwGtve7hIiS2FuMYCPVP7cy0cKMTm7cyG6xux9IZ9KWmkzr5U1F@vger.kernel.org, AJvYcCUbj90W7DDKTzaL2Mgi5VpC+tpVjS/hNkBrjla1cWnmEzWRY5ddQMC82N29/lPqyexyYQsHDrm3i7UZWKs=@vger.kernel.org, AJvYcCV//DjOhQFYcFQ2pjvgscXwzja1kq2dx6/4ryq+O/gvGGOPUNiBM8B+nj0pKMnwsDoTuKqPHsRvqwhG@vger.kernel.org, AJvYcCV7KvlWV81T8xE9UsYX6bnrS38K1KteBR0Qgy3wkpGXGqRCDK510C1FuBElzH3jdd3qthmUlH3Au9Vk@vger.kernel.org, AJvYcCWCgVQHkVgn8Vwj+E4KbZPRAizUpfK5jgQwWXu1T1azxVtA7R1zwThIa/2uw2h2M5pn32Q=@vger.kernel.org, AJvYcCWKUEnvejFhX57qXLEPb3sOLdxKNvCzSJW5KJCOM6a7udakfpV0Jam2kVh3BpAN1D7DEeN8r5IpWsYKMw==@vger.kernel.org, AJvYcCWvbYrR35IyuA5eO+xIDRddVRN1NjSigNg6YTGE3PeRv5KagcNDi9SK2GYZ6VoZf9xS7m38yf+O@vger.kernel.org, AJvYcCX4S/qPMxZubDSOGEKUBxjQ7TZon4s26GVAs+tEXq/6TdGNy1dP6ufXqz3X6LGf0VqlDv6HQSUu3mM=@vger.kernel.org, AJvYcCXtlPlwCnn4+pMeu29VUwD8sszlmm+FW7UfPM2h3Bx9iA18UtMz6NUVpTCstLN6hIgIjf4ydzgusiVk8KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdO/bnej+Roq27QikLSEVWw9yN1ZITxJO6fJkutxH8AaSnYGAM
	o7InZzkFkBQbmfi+7zEGNtM5Y/cnEdT4RRPXn21KhKikzY/jr+F36uTM
X-Gm-Gg: ASbGncvSD99emGxggympLMXTnmEy9isfsRo9BNklwaWyZXQZ2oBjQkj2DtBksoevyq4
	oJ+Tjj1h1vrop7C6CcjoNklUGOCr5rxHBi8alH3sMMVY6eg5qkr/HUhisxCu7Dwmin+e7pSGtTJ
	KmHN6L78JS/m3i5zv1hULh7WpUWaCuF9B0Ijd+IxXQeWrao8o/+41EGfAUMyz8gHs9TR35jCmB+
	WFsFPsZF0TLDz/j78V+ER4W3NhAUX5oexKiuc6pTj3J+ebLcJfT6BMpgT7wIRLzj39JPQf2l0sZ
	MqFgHk2CEyOHm5L9/9MReRyuhLJQa+wqwlx2uxdXkjvre6CEm5hbBqiwlDe7rBpskSsgBnoYkMB
	SRsnnsc+3+9Lte70vn03+Sad71bvN1oX+yiMrrxC/tp2AdKU=
X-Google-Smtp-Source: AGHT+IEwoXGIzV8akza9wuHnzpdMDJjRSJFuE8pmXkEOlv9nwKY6YvijMOuiPPSYq1k0su7e61Abrw==
X-Received: by 2002:a17:903:acd:b0:248:cd0b:344d with SMTP id d9443c01a7336-248cd0b381emr78909285ad.9.1756454579374;
        Fri, 29 Aug 2025 01:02:59 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903702999sm17213525ad.3.2025.08.29.01.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:02:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 08D794489F50; Fri, 29 Aug 2025 14:55:28 +0700 (WIB)
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
Subject: [PATCH 11/14] Documentation: net: Convert external kernel networking docs
Date: Fri, 29 Aug 2025 14:55:21 +0700
Message-ID: <20250829075524.45635-12-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4099; i=bagasdotme@gmail.com; h=from:subject; bh=eMX/Qh24hdl/D8upWlphNzasCNRD/YCgXxsSIbz5MxY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY16d1mKOz99m1qX25ldgn5beybqta3f6vFwaVK3P9 qU9Ts6io5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABP5Y8vIsLj5nquL3YaGH+H5 K1M/GSvVfagoWJf+Wf//FmmeVbsWnGJk2HnZqfzd057r3t1TvvSsKTBp/5q8NJD5d+PrUJ8N/JZ PmQE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert cross-references to kernel networking docs that use external
links into internal ones.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../device_drivers/can/ctu/ctucanfd-driver.rst       |  3 +--
 .../device_drivers/ethernet/amazon/ena.rst           |  4 ++--
 Documentation/networking/ethtool-netlink.rst         |  3 +--
 Documentation/networking/snmp_counter.rst            | 12 +++++-------
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/device_drivers/can/ctu/ctucanfd-driver.rst b/Documentation/networking/device_drivers/can/ctu/ctucanfd-driver.rst
index 1661d13174d5b8..4f9f36414333fd 100644
--- a/Documentation/networking/device_drivers/can/ctu/ctucanfd-driver.rst
+++ b/Documentation/networking/device_drivers/can/ctu/ctucanfd-driver.rst
@@ -40,8 +40,7 @@ About SocketCAN
 SocketCAN is a standard common interface for CAN devices in the Linux
 kernel. As the name suggests, the bus is accessed via sockets, similarly
 to common network devices. The reasoning behind this is in depth
-described in `Linux SocketCAN <https://www.kernel.org/doc/html/latest/networking/can.html>`_.
-In short, it offers a
+described in Documentation/networking/can.rst. In short, it offers a
 natural way to implement and work with higher layer protocols over CAN,
 in the same way as, e.g., UDP/IP over Ethernet.
 
diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 14784a0a6a8a10..b7b314de857b01 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -366,9 +366,9 @@ RSS
 
 DEVLINK SUPPORT
 ===============
-.. _`devlink`: https://www.kernel.org/doc/html/latest/networking/devlink/index.html
 
-`devlink`_ supports reloading the driver and initiating re-negotiation with the ENA device
+:doc:`devlink </networking/devlink/index>` supports reloading the driver and
+initiating re-negotiation with the ENA device
 
 .. code-block:: shell
 
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index ab20c644af2485..3445b575cb5d39 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -1100,8 +1100,7 @@ This feature is mainly of interest for specific USB devices which does not cope
 well with frequent small-sized URBs transmissions.
 
 ``ETHTOOL_A_COALESCE_RX_PROFILE`` and ``ETHTOOL_A_COALESCE_TX_PROFILE`` refer
-to DIM parameters, see `Generic Network Dynamic Interrupt Moderation (Net DIM)
-<https://www.kernel.org/doc/Documentation/networking/net_dim.rst>`_.
+to DIM parameters, see Documentation/networking/net_dim.rst.
 
 COALESCE_SET
 ============
diff --git a/Documentation/networking/snmp_counter.rst b/Documentation/networking/snmp_counter.rst
index ff1e6a8ffe2164..c51d6ca9eff2c7 100644
--- a/Documentation/networking/snmp_counter.rst
+++ b/Documentation/networking/snmp_counter.rst
@@ -782,13 +782,11 @@ TCP ACK skip
 ============
 In some scenarios, kernel would avoid sending duplicate ACKs too
 frequently. Please find more details in the tcp_invalid_ratelimit
-section of the `sysctl document`_. When kernel decides to skip an ACK
-due to tcp_invalid_ratelimit, kernel would update one of below
-counters to indicate the ACK is skipped in which scenario. The ACK
-would only be skipped if the received packet is either a SYN packet or
-it has no data.
-
-.. _sysctl document: https://www.kernel.org/doc/Documentation/networking/ip-sysctl.rst
+section of the Documentation/networking/ip-sysctl.rst. When kernel
+decides to skip an ACK due to tcp_invalid_ratelimit, kernel would
+update one of below counters to indicate the ACK is skipped in
+which scenario. The ACK would only be skipped if the received
+packet is either a SYN packet or it has no data.
 
 * TcpExtTCPACKSkippedSynRecv
 
-- 
An old man doll... just what I always wanted! - Clara


