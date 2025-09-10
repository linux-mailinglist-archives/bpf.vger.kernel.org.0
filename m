Return-Path: <bpf+bounces-67985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEC6B50BEB
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BA54467FB
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E658525A350;
	Wed, 10 Sep 2025 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdsvlRB5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863BC1DFD8F;
	Wed, 10 Sep 2025 02:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472717; cv=none; b=iZ4t2BnS6r2sKO2VzSri9VS0fRgtA8HgBIcueePvajMnxCOUXCAkkrqo82632Lu7t2g28AoCN9HBgeFELUgxl6xpN1V/nKXIKvTp0+u7kxLzKMbLXklpU9/6pB1Cp5KsiZGaDcqSTnPO4rvHEQxziz05c2W4hgEolTm5Hi824BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472717; c=relaxed/simple;
	bh=3KTOccWMzr8DxZPfBNk641Us82FbHT4BEw3lrJOsNTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAfXIW8Z4+vbcr4MpkSF+NXEhFi2G+ctVBn9VDNrSX5Ods06yL0oJRKp9zrYQnh3KBu6NN9iXuTV9x9lClq6cif7NpoquZszIXpbcnIb8ioAbN5RL2yFXFBYsczgoMv2vca44CDC7+DOOt9RSeQPrIP+ljY54McV6VQCepqeExc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdsvlRB5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so152237b3a.1;
        Tue, 09 Sep 2025 19:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472715; x=1758077515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2TiZwTLryn0Z2XdO8OaBNvuenSuTUZNT9oHE0TAuq4=;
        b=OdsvlRB5HOQOkeknasjsr2yiiVvTu2iRfA/by2SOvpU2cGvvx1Pl0lr+xgm6zNEZnW
         q2v+cOh2Qk2rhQ5umxIzQ19I86OqkXpTJeLb905nKp4+VWSC6PbW8OkeaIHJtse+Rplu
         pzORfpg81ajsy/wou4Ntj+fVVPKMDUCYVtFJSd8skWkx/sBI5A+e3U5kbgl2M7Ch2JUn
         kLKzpeqOMcuC5CrUA8OsA+hoBCaou8tFy5Lw66fFY29C6R8P1mySS8setxcUoQQ1tjpA
         xbF3ZJacTsiqL0Gjcrk3/G6kpJBD+GFWu6wzJyiSVdamg89bxeLLEDVR7jVH7sXuWOPR
         P/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472715; x=1758077515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2TiZwTLryn0Z2XdO8OaBNvuenSuTUZNT9oHE0TAuq4=;
        b=NyG0zRqzn5Wm3wJ2b+5GizEN7XCXB6x/sahPk3W4cD8F7uxkOYT6BbNr0DH7EhptBO
         QLftOlnVXt+B6GFUqrGdticvQD2Ll5zorn2hu31ghJVN2op/6v5NqLEAQQWQEn27rZCX
         qqq6q1rW9vV0WPfJbxsk31a8uzZFlROAbgXZjMce9qECs5otNxWdEwI5k27vV12bzk+x
         gQYX9noonEZcOIbCAKtjijqnPBZuHO1kGbxRcuf+ZjsdF5hZtnU4BBkLvX4TvawvyHZp
         SfsJLjQ7b6qcuUB5sJeIwxn0qglaT5HiVdBG6SnXue6doX00RlmOSWRGqsmrn7zcmrUg
         ov2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUIrWvx+UPqYe7SsXQIfsbIt4LQ2BrGv1xX3sBDcmYludFzeyG3i6rjuFk+SGNjLb144tBcEhSg96oL@vger.kernel.org, AJvYcCUkmVMzYYcgcCug/zJ2iF9yiETGuRLIOCSEwpUCBC5BgJCc+8HGPhhPntulCZaTaiO8YKLVn2UoJeQ=@vger.kernel.org, AJvYcCV6XFLBieh/v2nG2cbeReaxKuEff/NPPxHWCHqAV0MKs5NzVD8CB8Ab77oWKruO6PHaDB+rozF2L3hjpVc=@vger.kernel.org, AJvYcCVbEVq3eiqq5/Xe0xMNQaOgIrFdEJFm2IMPGYydd8wdH2gegEBhBRiGZtq+8rbTnW5crL/fWvNbJdcoz/co@vger.kernel.org, AJvYcCVnasjWXdxqdHMEcnXz6XmVR9hajXeDbhvHVmEkMvTt2rUpqtj7vesN0t2cBDVtAQgaPjx+0zAl@vger.kernel.org, AJvYcCVpitWN7tS40avVubwTnlL+s+hehfQ5ydrI8amSQ5fNf8PVc39COYmyIo37gIojnIJFkrw=@vger.kernel.org, AJvYcCW0VLTac3ELBXEBio4RauJ/WwHRtgWqphh3xV+IP8CXTGTb2KOkJ1H4pfHWzqZk8MMyx6+Yt5BiyrV2ghE=@vger.kernel.org, AJvYcCWgR3DcXl7aSs/mqCKb3yo5d9EM72TyNYo2BKjpZwlohy8OSL7GyiPSuOAiu0imeGyPozDWb3x4l0zJ@vger.kernel.org, AJvYcCXmSeCGS0mbDbHfA8TX56c3Y48PIw/3KPXee3SKL0g2//g+YyZnP6yWGdK/0PBGwJlJS+vbS6+PjXZ68Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEP5GU5fz8M7ignn53vwvMAajpehQrlkdueM04+13h4N+VEG/r
	g76rE/68jUHxLA5IrdXGmdkBmF24Ao2GVEelVB1SOhRNXlwUQXDsR3pY
X-Gm-Gg: ASbGncuGVdVl3Ih6nBRXgfkxp5IstmIMhAE9lY5JNQ5JQji10fq2OSGHfcCMChe8MFT
	OM8uEn8S0xvyeFiKSalnt3Dj3xusDnUuiNGKPiOxWdPoOtyodGR3Z7fZlhhjTFaIF4Y9muG2P4y
	GPzty9mwHPbyVYnVYMvwbCXrvbeISv1eN27Uc3HGs9AUB/eERobPWYmv0/ovGv+6bmgjyACLngj
	GRoD9RVywOi+PlstH/cu6GnQ18eSbGtzdqapfWnfqz/sZjWoaEl0tqQOMPL+5tV5Nq/lG19NW3b
	zDqtYg8kIlhmwPq4q9UOgxcQhhWD7oFLemqoqHjW+P7Sn/JBesoCLUk1e5LWkOUAu9bcC2DtS8E
	pdaf1F1QJok2Uq/acL7MpLnkak+sloBpH9GZy
X-Google-Smtp-Source: AGHT+IFTyhfnUg3CqVtgOKW3+2pEfzFWWNjw1TnoTWF2WDPCy8Lg+0w3QYglyJRg7NnUo5SJL/6TsA==
X-Received: by 2002:a05:6a00:882:b0:770:4753:b984 with SMTP id d2e1a72fcca58-7742e4bf142mr18186197b3a.16.1757472714666;
        Tue, 09 Sep 2025 19:51:54 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77466293757sm3470498b3a.63.2025.09.09.19.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:51:53 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id F395041BDD47; Wed, 10 Sep 2025 09:43:52 +0700 (WIB)
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
Subject: [PATCH v2 11/13] Documentation: net: Convert external kernel networking docs
Date: Wed, 10 Sep 2025 09:43:26 +0700
Message-ID: <20250910024328.17911-12-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4165; i=bagasdotme@gmail.com; h=from:subject; bh=3KTOccWMzr8DxZPfBNk641Us82FbHT4BEw3lrJOsNTs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHniglPN1/l+G0b3W08+an+40OlbWa5hi83XTh+GX/4 C8C1xeFdZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiBZEM/4u927OPq/vretv+ eb/f6YB5Kk/Laj31K1IKboVhiko7uxj+pxYZGDy7rZrM+OWh+Y5vk3hP+ti0xKVJLGg67/x7TvV +PgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert cross-references to kernel networking docs that use external
links into internal ones.

Reviewed-by: Arthur Kiyanovski <akiyano@amazon.com> # ena driver
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


