Return-Path: <bpf+bounces-66957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8AAB3B567
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 10:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DBE1C8759B
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 08:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2212C08CE;
	Fri, 29 Aug 2025 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6HK6QJr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036DC285068;
	Fri, 29 Aug 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454578; cv=none; b=oP58oLiPUXQPOCpJ8UiRTFAWFZeJWCw3Yk5KRifwueM3KFesJfh/4VqwKzk+oqGbCmezrwZjLJWBuRgiWBqU7Z6iwOGdUORfTOsq/FPrZvKoOmRNw+q8xV8UWiTZiPot8L+qZ3VePJL4p4SL/FlivtOKh3Lupvk5oy7OtQOvVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454578; c=relaxed/simple;
	bh=tVZea1ikNA4Sssls4g09ZchJ08JhUaFOY8Mmt8T2Tzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmX4sT8XfC2MuYioqeeOGyHHT4g6MTD+/ebpveH8zeuyHURa22/Eg+PL5qihVfrh7ziW0eb0dv0bjdGkLvphXYsSbYoKOhTNyEfbi4zqGg73y2krf25lhMaNHhD0Z9q4FOaftOT/QoLtUjsCViTZKtT/AxSXjTjKND/FLAS2cEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6HK6QJr; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3278efed3b0so1412256a91.2;
        Fri, 29 Aug 2025 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454576; x=1757059376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdhbTSK6p9ht0YngyCDiyyRtcLCfpgxS9tGDrcGiJGs=;
        b=m6HK6QJrKCL4NhX5vRmRvx+kKf+UD0SCePCT8SQyijOvyVFAUmvYFeLpKLE/0xgHWi
         FNwOZKI6qFJBvK8mxDqCQa9QZO31ghE/2F0gETGOKNDB+GJAYSAmLNVDbObTf3yOssgA
         d6o8kdtYIrxFisM6uTjlvznUIZVuj0W0J6Ru+jW3saIZMn1aQodFz4TsG0yOR1Sdby+S
         amaAZaTzNcTeE6+wN/urH+7nZCwz4mSFFXJCQKrsbSArm2/bPOek03vleCh45+QA61xR
         QtVIhjGwt9YANZcbmNMyAa9KyES0pnhBHHBYegyFILKtOclZLv9rJF6VKNSOHVclCAjy
         WJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454576; x=1757059376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdhbTSK6p9ht0YngyCDiyyRtcLCfpgxS9tGDrcGiJGs=;
        b=uo1k4zl1PUKCz4j5dJZO2gxyw3cy0Cl+3aKiRNy4I+9oGr6tJF2msC8Dwpd2hX49zB
         +A4VpP+IeR/QSdVlv8l+HL59avGxWzJCvVL/18qZ3/F9GKlWa+K6Lqy9a0rTp/Eif2xi
         cKloI3+BxHuGVgfCdbJnlhhLKLrN5CgqCKAf8q2uK1zrMPMor5d5sYktX9+/8XeymQWj
         qPsZvjlaTx00YBJUoMsu6tKButJxap6tP2SY+DN5jpuPXpA2AbuzSsGu6n1Jv1gx79dc
         X5vE/I8v71GVpsD9JaVErOunYmKPSDlvY3kXYban7H0EmlaPypnSNAyejw6YTNApzn0U
         I9Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUEzXYUSDACPszdUy9gR6LKJbFJPoX+/czSMh4Z0jy47EnSZtIz4G2ojO9qzSzcC7ij3Ktf/PChYlqUNzg=@vger.kernel.org, AJvYcCV+CiW4TveYanL2/Qe7E6hqFr5RnkAWgTS+qHuodmE8DMQESJgxE+JhWk/vZi+WzNIk3SuQtqCxgi1J@vger.kernel.org, AJvYcCVKLSdat6W0fHNwS+7QS+lWGPwu1jfut0Wecr3MssjYh+1CufcXi8XTbNiGCn3AH4OnEwGbr+Klpi8IRCI=@vger.kernel.org, AJvYcCVjvD5ruNLoBdw5TPsCwLU0MW1mDTec+tI//d6xbir4ooCuVdKmoWUgiz/e+MVSvLBVEdUPtT+74/U=@vger.kernel.org, AJvYcCVohjlWzrfgdeNwhtElJ/W2IDpTaMbCdAm/DfgAbQkS95VbfB/PJ2qmDkYFW77WmjZpshk=@vger.kernel.org, AJvYcCW6SQC3JlEgiKsTM/dfsku5zh25GoTkQquU28xxvhqnLtXOvRPGnQcmSj5AORaq4bJf8/mb4lS5@vger.kernel.org, AJvYcCWRDebciJJWyAzBF4BpCLRSkcqVMgcjLvFXifrkuDpEYxsaYsv7TaIZEZPBXgD/0mjiYLPy2JR/sIWzQiRQ@vger.kernel.org, AJvYcCXHx16CiNI5LXgWbwg7mqHQhhKY/1kODRyvgbzFhddBZ+6GbbZXfbqliv8JynKND9ApPlXwxbJdBxcb3g==@vger.kernel.org, AJvYcCXQ4knurbHGgla9K6V/1r4ubFXP0oxRjxhuNRfSckdCFLATn97oOQFdqghFEPcuNDNHWCvUREzPEMeu@vger.kernel.org
X-Gm-Message-State: AOJu0YwVAAIkvGe/mVF1E89R4T5ULBkIrwVRcDC/teEvUsPx1tvyYPeT
	McrXGfjrwFCZ57sWGphUXK4d2HcbuSmqMGjKjhvH6ihiCbeqpGadrsRE
X-Gm-Gg: ASbGnctLcVon0vT/3wZ57GMzuPDYtOFY8OCsJVLcavWPvTk+pka1jJ7Dfxgk+tQbOFL
	YLIy1DZxEnArym0QKN0Q04K3drcBqOkwx6zTF1dfsVf7oEk7iaW/SkI2RqOTkuRtrIfnMaWpVa2
	AylxYYlEQ1SI7A4ppq3VGCs1EwhVsK+m/7RV1qCGk8WNwGWHXrBoNvrnhn6hHLirpSuJ1KiPuyi
	CSrALq+9SYY4DBIglt8ontGkpR0oe/rLzaqgf3PRUHAhz30ASdIuJbAIGwlXx4xWDMyUaYlc+tz
	WQRtnYuQqVkPICX75Og/zm/HFZ+mPTgQspmqB2AlnFAf4QkJOrd4hc6eZKKgBT9ATIMsWBkhpRA
	P545ODSpcigVaHFPQwJGu43f5Ata2A6HKbu6l
X-Google-Smtp-Source: AGHT+IE+D5SeDqchp/24MDHXx5CQWTZci+ASgYtlboM+vs82gW00FOC1mk2B4v9sodvZwpxdBzPuFw==
X-Received: by 2002:a17:90b:3a87:b0:327:c9c1:4f2a with SMTP id 98e67ed59e1d1-327c9c1642bmr4975594a91.27.1756454576161;
        Fri, 29 Aug 2025 01:02:56 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327b01e90e5sm2191228a91.1.2025.08.29.01.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:02:55 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E8F6644809A5; Fri, 29 Aug 2025 14:55:28 +0700 (WIB)
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
Subject: [PATCH 10/14] Documentation: smb: smbdirect: Convert KSMBD docs link
Date: Fri, 29 Aug 2025 14:55:20 +0700
Message-ID: <20250829075524.45635-11-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=bagasdotme@gmail.com; h=from:subject; bh=tVZea1ikNA4Sssls4g09ZchJ08JhUaFOY8Mmt8T2Tzg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY15VZXUEfpV/XXVSre/C87lNIRyCV5IjnItu7ShZU PiphvtYRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACbSt4OR4WixGWdF367Ci0f0 5/VHVx3YxHrvMF/c3LtfDf1enBJSvMrwV9hALHj9kQNbWF8l9WcGsahNXW7scuzOjYlmr0LWbpu 3gQUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert KSMBD docs link to internal link.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/smb/smbdirect.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/smb/smbdirect.rst b/Documentation/filesystems/smb/smbdirect.rst
index ca6927c0b2c084..6258de919511fa 100644
--- a/Documentation/filesystems/smb/smbdirect.rst
+++ b/Documentation/filesystems/smb/smbdirect.rst
@@ -76,8 +76,8 @@ Installation
 Setup and Usage
 ================
 
-- Set up and start a KSMBD server as described in the `KSMBD documentation
-  <https://www.kernel.org/doc/Documentation/filesystems/smb/ksmbd.rst>`_.
+- Set up and start a KSMBD server as described in the :doc:`KSMBD documentation
+  <ksmbd>`.
   Also add the "server multi channel support = yes" parameter to ksmbd.conf.
 
 - On the client, mount the share with `rdma` mount option to use SMB Direct
-- 
An old man doll... just what I always wanted! - Clara


