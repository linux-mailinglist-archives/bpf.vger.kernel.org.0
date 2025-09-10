Return-Path: <bpf+bounces-67961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE0BB50B56
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 463827A790A
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13260248F78;
	Wed, 10 Sep 2025 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0avlSuG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A30242D72;
	Wed, 10 Sep 2025 02:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472237; cv=none; b=eobN4N7zcyIzdTW8TVGB1QxArrbe7QGIOFHWlh5XwZKvYig3kmyJSSLCWR4ZlWZkBGy1joDIzWGzHidr/GgsOt/frguFO/QSdgPVARLKWEhUzOMEuRDyolj/NLzotpAGa+mGgQbOfNKsfLZb8TC30eW5Au5YHvwmYKuvo60o2gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472237; c=relaxed/simple;
	bh=oQ/U51BIIgNGsRun+kwInz/tmig5xTqHruGeEvNRxQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bb6IxsHVVut96lWBeobQSowCpRqQJASXeUhxZjT0xs1ik5SFLijCQtv71WXCJUITXWgZuCqjYGovRFITuDeK49N6qkSHLqFQYo1cyboGZeHa515m6URpl7v1hhTqhm2gtn3xz44r+EXeY6hNk09Y3QHsYbY7fUhm1ufj3x2pi98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0avlSuG; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b475dfb4f42so3813146a12.0;
        Tue, 09 Sep 2025 19:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472235; x=1758077035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKHUedwTpnE+6902OLKWJUrKeeyE0icmaP4M6h8VeIM=;
        b=W0avlSuGmXNWmy8RXo73USlU6xA6mh+VFlg6c7F6PgGsFVAMOmCaIvU5xoUZ2HtKeN
         otGYfG7g4jyEmfSge6bTWWMkjMHWoaU50WfY7Ua3zibELs/jvxOfpF21SdPqfltIVdad
         ONjGYDQaeopPlajAa6WLEpFrE9H3mgF7TpjFS1w1YIXrIPw2pKhXwkafkup/0u8bVdrh
         t4DSE/xFbcM+cSwtN1nTjdXUuu9LnU507G5iBNuJmLDaM/N28yGRWHfOhwwSCEwo3TPQ
         MI3tzlWU9t3ORcQHDS8h1F28nKvj1RmEHtnVp5nEk46ULSkYNHAFdLG7iXZlk4Su+0Xe
         WjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472235; x=1758077035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKHUedwTpnE+6902OLKWJUrKeeyE0icmaP4M6h8VeIM=;
        b=F6mL51Y9x0suFrjKO6EF9vL4ZP5WMnxXlsssvS3RZU5kDllqSovH39Bu8mVpMYW4QT
         b6miPa5rBgIzmQssD1FOecmS1FRtQv1HrTi/TPXwCvKOUdSoWWgBjAG3Ub5V7TKkaNXs
         FOeoIAsBE+PWxovvV9jrI9RVWE9I4l6DpTF843TF/A1QRcxQG7qFucv5fBYPzeF+7Hys
         aDvc8hpebghjkkZZfBLbIZHSy28IoQRHDgPQBDIapgSRiNFhzj7s1LC6CctL1o73xrCm
         mS9UPV9HvICMgLsi9rsFnE0Q9+roPo4jNNKH3HLUCRiJJFfD7aCVSRX6H/bUpsq0plby
         mq5g==
X-Forwarded-Encrypted: i=1; AJvYcCUBLMCb7pjaLesaGFRmiaWzswOB+pLrKemC/0RAfxnl+n4AmVRA0qjO1Z9ULepZQoAJmgEtsRVN0qg=@vger.kernel.org, AJvYcCV+jyIdfx3ChsMn6mNfv69zmEIvTZzgmsmOQ7Edtu3MqOE/HeVrW1pCWenSvHasVgthv8k=@vger.kernel.org, AJvYcCVGXGGN59QKFI8J7Zaus//fUslZpQJ1yKqpLOv95dsxJaBtyTWGcJJUjHrI6aUUa4+PISexGWRLO5j6@vger.kernel.org, AJvYcCVhTy/sGIB2ocE/LvtE+V8szp0oSru1kPhGRLZVW1B6k83/eXJsJjyNsrf7P4kkW9CNGekLD/km@vger.kernel.org, AJvYcCVwDTDEUUFocCk1y9PQT9SGDKDTaY6WtzwTclntfAjKHi19Q/VR8eUZTGuA24sPSj7Bmhs9FSYQJ6BgF8Y6@vger.kernel.org, AJvYcCW34gFwihjQQ255YWJ/AcDjd/iZCEvWWvtYrM2fTFCf4yxD7lbfxnHbfNUb46X+Wf7JZhEJV968tZPDwWA=@vger.kernel.org, AJvYcCWUe3ogvohVXZB6YXCg6Xvu97VrDjTmrJQOImZq2dI/3Bk7Bteaf6awwPJlZS3M/hvIL6uNjcpA3Clvkw==@vger.kernel.org, AJvYcCXF1Ejher28NGwoM58lW2AsAGIJmdtQdQZIdiobC+PQXJ4OEhYM4Mdn96HsJ8eH4dfjBszkmhwN2vdlcSY=@vger.kernel.org, AJvYcCXG6xPxS5jQNtgCXmQq+zlM9JBU30XAFtP8JCQUiCxrAB1pa+UkW7SDG7Yq6FbN44aOUUekUy9mdvEn@vger.kernel.org
X-Gm-Message-State: AOJu0YyRU0I9/Rp/rjkDYuFhTpM7wnEK92zYrXRt5KcbdBBRGiXuCvSq
	70Q3LKIdWz6pwFtsAGrTSb+xc4CEAxResuYdkmfNFMTKAC8vXbY5NgdC
X-Gm-Gg: ASbGnctFSuj0oxiPm3v2Ya25R1vTSVIkJWw/BLJKF0X+3VmdssjxIF1H9Il+4dg22S1
	SJ01njJTJEoTUQMNvq2UzJ439hJjT3pKXG6oc0NMFTbheKqp705FRUFaIUX0IEfulW/x5T57sNL
	XNfGt+FRILygBZlyho6UtjQHSfGvMcpHA9Z8BNkDIv55Gp7FIbmBGCGfhifF2uDNyaoMf+nBICP
	dBomR+4pSycLAmJxu/ev4BMV3FJ12H8wplboo3YLzSErffFED54brMvkV2w1cA8Y3DAAHHskS3B
	vYp2G4PjkJudM4eHA9FFfvf7y8y03xaX9pXlBVpmMwjKweY1waJdiGxFSawlP8sGIrUQPBgdVJb
	1rXkpm3xhhCK0wwuEgLqqv6YhS7MH4wM/E9Ie
X-Google-Smtp-Source: AGHT+IHbDjWZY3VztYJWV/FENnSrT7+pUTw9iPKJIW8vQLIXrlNVN5ahZX5GB9eL2BwlCwOB0bsRtA==
X-Received: by 2002:a17:902:fc50:b0:24b:640:ab6d with SMTP id d9443c01a7336-25172b4b335mr233139385ad.49.1757472234639;
        Tue, 09 Sep 2025 19:43:54 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27422ffdsm11441735ad.17.2025.09.09.19.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:43:53 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E4226420A809; Wed, 10 Sep 2025 09:43:51 +0700 (WIB)
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
Subject: [PATCH v2 01/13] Documentation: hw-vuln: l1tf: Convert kernel docs external links
Date: Wed, 10 Sep 2025 09:43:16 +0700
Message-ID: <20250910024328.17911-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=bagasdotme@gmail.com; h=from:subject; bh=oQ/U51BIIgNGsRun+kwInz/tmig5xTqHruGeEvNRxQQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHnig6a/JZLY81M41OfrJ5W/1jtyyro8lZM99fCflwN Zg5yrW3o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABOplmZkWLE7pDLv7RVG0Wlf H5ewasZymzr2NV7tNPkiErzi6eK/vxgZzoS7uJzLvPvRJPIa/z7RCs5jTcdeb3Q8EmZgt2n66RO ZTAA=
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


