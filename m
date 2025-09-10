Return-Path: <bpf+bounces-67970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87215B50BA2
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A185E723B
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2FD28B7EA;
	Wed, 10 Sep 2025 02:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+B1Wj/s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41626B777;
	Wed, 10 Sep 2025 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472250; cv=none; b=arkI6b0inuc4+JPtd3GRXc9Z0uiuO3anopRkulz0Eyck1eaVgJ+uMitA2oQdG7XXDvtoOSW4cHSkTj1vdzlgl5xrJFgDbQZWkgW4BVXNJlFRRdgvtBj6MKLQGPAAoBatJwhko7qrlkup+EQ0F6X4RYw/f1eolbLFJHop373Flfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472250; c=relaxed/simple;
	bh=Ip9RCWVx3N2eFboDnh1dVntKjUKs5RT6sbpEBdmz23c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDeJwJmNOJcEQAK90FIwD0Vaf6dcPUW53IMpOzukazU4R1dQPiET5gg1GA8lzeuzilp3gvZP67o9vtnNB+1TM1g+8m3XnWedtEwSLNHQ+M14l+uer0UIOgTuiy2Zlqz+hJvdY26u0ubm8OkMfCqv5TAooG9zdHYhgHSakJlk9II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+B1Wj/s; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-772301f8a4cso8828956b3a.3;
        Tue, 09 Sep 2025 19:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472248; x=1758077048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fK0hEDM5Yyao3a7xqBzpr49p9H5HB+om5vfXDIKLdeg=;
        b=i+B1Wj/sgOM1uepG0eHhRbdRM0tuMPxTyyN4Z4eo7xlKvlzkc/pCL2xrLqWx7AsChz
         N4T4EOYhpz0V5jkUFoswTXZOAfhGSsE8CJHcU7oMbVdpX6jpXmRr+Gy1lG2FMqEz2ZWQ
         jK/1Uj3TDx3JIRsQSPHOWEW1e+4spOBhAuBKMDeM9OPevyPYYQ4U1Nr+04TvqXEsfY8F
         JTt94UYYpGAA+zrRF4DLMg7ND9iUnt1tcgvwcVgCUF5NYf/PDpbU5N3ukYEuxgHabwd3
         JpBz9dOUOpm1v1131h2ortq2xtKSQgS20I0fktKceub5eLRbfia0CXe2Na9/8g4XbPTO
         CzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472248; x=1758077048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fK0hEDM5Yyao3a7xqBzpr49p9H5HB+om5vfXDIKLdeg=;
        b=C2Ty0Se6CIaFbDJSoYghvDXQcwc3CUgqCeiKYB7BCH1kAZx9syAgBiqxoW+IcPwQVb
         JQuhIMgL3ricNVokTytaWLcexY4M7sTdz/uA55m/4YEdumIXjLKnKnlc1+doF8w+rWTW
         8e8Ru2lBo1u0dY4puB0pF4FH3TXP0yvg6US72ZdHpkK00CznAlXXJJ9bCanl9cL8MRVh
         S+cmW02857H5DyU1kDbCgR1LkZdlGsEFbbxcuSe2mtrlazsKyiqO7YomHPMKE+rKhwo9
         UgdiIqh29u1Hz7LTaRNUEjqZztLtdlHlvvX/Rerraof0lo6ruck3xfOgjWGsKzzjiHSE
         vnjw==
X-Forwarded-Encrypted: i=1; AJvYcCUjWtmC64vi8xwCCQenuuyAOG/7Kl39y8qA6o9WAEOYHMyupWJrP4jVnBBuFYKsZYmy1Rr4WW4H@vger.kernel.org, AJvYcCVUfAvPrdbB1lIQM4lNwNsyM5wEqr8im3JCpmnmrNLi1gNnnLMM3DZU7N6Euo94whTCpRs=@vger.kernel.org, AJvYcCVsTErE0hogwilAdJhytGYrWURtYsfRtjUKCcnsU2SrVVWZwKaHNKWGMG/VUUl8iPMS/9icnm486CM52w==@vger.kernel.org, AJvYcCVtwfOdTGlXouetPHQJYPlkAIf38PsHIUos1eQesNeq4T5Q1W328zQH8NUBA2OuzC60njVkI77NVjqy5XM=@vger.kernel.org, AJvYcCW2A9N/d7+0vOjUatztFaJE7yp59D62n6egAxSoKfMdlr56hCkZHhqHIu5YTfJ7InVVt8Ub+uTdry2T4eI=@vger.kernel.org, AJvYcCWGYaNMMDd1lTvRxrG1oNLwVKGMUKjKU2nFWMERptMAF3AB1/v/Yq7YYRPB2xnP9jd+df6dtzqJrQGd@vger.kernel.org, AJvYcCWfrB3n5nm+ncxsfOXRX1oYp5eJThCNZkIlKK/x5Vxgpjeu1BCZTxLe91GTUus5vAN4EN5mQm/NdUw=@vger.kernel.org, AJvYcCXFUzaqAw8ovKNkFStxMCEwyEyhmmIQlPv6XY3myyRvJUvPjL2kQNltxO4LFpOJJAlubELGzm6cHnQL@vger.kernel.org, AJvYcCXtRBLF+pUp3oOnJ9HAnL7tocH43sOOR3jxkGcifeSukxtj6wLp1A3nfn2TW3ITgIHZNZ6Sr7FDKC4Uhzdj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0VBr5fvR/QEQ2cWJZYi2kOYqGOgQZYgy3yTi/0Gt4HBHctigz
	MCFbM9gGQ6myt7/AiExZ+2IBqjqb57hb7nj54XxYytxql2X/p6sIimfF
X-Gm-Gg: ASbGncuIiqFf5V2tesP4kVUxuPNiqch4Sn0pxSBS9emNvaeNhiB1VUur3Z9Z5zL2fk2
	SlmqVJr3+xs4pCRcuqLCmCDDMMmGgokiVQoFlmZRQEiHiG0lSfFSANjinz1/p8KRyuRdit7Orxo
	h/REQo/6MvoerpKXQdupSNgjHvyRHR0nzaJnLUye0hP1NTP2BcEDXQkYc3cOYDciyO4RhnI0N4Q
	QVhs1kTxUyEycN3Ll7McmgaQzeDIP65zfkZmOdkJdrvdNQsOeu1LzJMBzVGc2PvUzABa8lXEhiK
	O57f2ke5n/PzzeuxAPsJ4z4o1d9OPS/B8v+RyzfMDrulzQHcdonKF2ub8D4w/m3RutnS+J/YwV3
	/ldSAfK1TvLFIVBSyaTwp6XXoEQ==
X-Google-Smtp-Source: AGHT+IHubWrsefo+d87orOab1DSwsve/ArB2W06/xMLWCSAZ2PZ8eNr96v1SI6ir/qnxEBjX+/LG4w==
X-Received: by 2002:a05:6a00:2d16:b0:76b:f0ac:e7b2 with SMTP id d2e1a72fcca58-7742ddadd68mr16640975b3a.13.1757472247852;
        Tue, 09 Sep 2025 19:44:07 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77466290d84sm3499051b3a.65.2025.09.09.19.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:44:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C367141BEA9F; Wed, 10 Sep 2025 09:43:52 +0700 (WIB)
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
Subject: [PATCH v2 09/13] Documentation: filesystems: Fix stale reference to device-mapper docs
Date: Wed, 10 Sep 2025 09:43:24 +0700
Message-ID: <20250910024328.17911-10-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2828; i=bagasdotme@gmail.com; h=from:subject; bh=Ip9RCWVx3N2eFboDnh1dVntKjUKs5RT6sbpEBdmz23c=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHniixbj++M2M+e9AK28XZP75VaZfxL/rvM//ttckLa 3oE7/o/6yhlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBNZmb4p1i8uPKB8ZP13wum BPvKxR5SWdltK/h88a0CIW7J/3IPcxkZtk3KCLwZnfbq4QUbicP9bC8vlyYEbns3a5pPVM71i2f ecgIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Commit 6cf2a73cb2bc42 ("docs: device-mapper: move it to the admin-guide")
moves device mapper docs to Documentation/admin-guide, but left
references (which happen to be external ones) behind, hence 404 when
clicking them.

Fix the references while also converting them to internal ones.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/fsverity.rst             | 11 +++++------
 Documentation/filesystems/ubifs-authentication.rst |  4 ++--
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 412cf11e329852..54378a3926de7b 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -15,12 +15,11 @@ of read-only files.  Currently, it is supported by the ext4, f2fs, and
 btrfs filesystems.  Like fscrypt, not too much filesystem-specific
 code is needed to support fs-verity.
 
-fs-verity is similar to `dm-verity
-<https://www.kernel.org/doc/Documentation/admin-guide/device-mapper/verity.rst>`_
-but works on files rather than block devices.  On regular files on
-filesystems supporting fs-verity, userspace can execute an ioctl that
-causes the filesystem to build a Merkle tree for the file and persist
-it to a filesystem-specific location associated with the file.
+fs-verity is similar to :doc:`dm-verity
+</admin-guide/device-mapper/verity>` but works on files rather than block
+devices.  On regular files on filesystems supporting fs-verity, userspace can
+execute an ioctl that causes the filesystem to build a Merkle tree for the file
+and persist it to a filesystem-specific location associated with the file.
 
 After this, the file is made readonly, and all reads from the file are
 automatically verified against the file's Merkle tree.  Reads of any
diff --git a/Documentation/filesystems/ubifs-authentication.rst b/Documentation/filesystems/ubifs-authentication.rst
index 106bb9c056f611..9fcad59820915d 100644
--- a/Documentation/filesystems/ubifs-authentication.rst
+++ b/Documentation/filesystems/ubifs-authentication.rst
@@ -439,9 +439,9 @@ References
 
 [DMC-CBC-ATTACK]     https://www.jakoblell.com/blog/2013/12/22/practical-malleability-attack-against-cbc-encrypted-luks-partitions/
 
-[DM-INTEGRITY]       https://www.kernel.org/doc/Documentation/device-mapper/dm-integrity.rst
+[DM-INTEGRITY]       Documentation/admin-guide/device-mapper/dm-integrity.rst
 
-[DM-VERITY]          https://www.kernel.org/doc/Documentation/device-mapper/verity.rst
+[DM-VERITY]          Documentation/admin-guide/device-mapper/verity.rst
 
 [FSCRYPT-POLICY2]    https://lore.kernel.org/r/20171023214058.128121-1-ebiggers3@gmail.com/
 
-- 
An old man doll... just what I always wanted! - Clara


