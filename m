Return-Path: <bpf+bounces-67983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B2BB50BDC
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21ACE17BB6B
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C1324A058;
	Wed, 10 Sep 2025 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePK0tLeI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038FB18E1F;
	Wed, 10 Sep 2025 02:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472716; cv=none; b=WparGZMHHMYkzm05ot/r/O4ODrIByuyFqx65TRZ+mDxm5ifAwAkcqdHHQtUdJCPOT3uBIRKCL4Y1AlG5wa74oewwnFbQai5DF6XAJaCYgj2ojG7sZZtu96dnmGDDWlsSIwT3ZflhX7JNeMBfFxD8JFyIS+bbR/Ynt0W47FKvofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472716; c=relaxed/simple;
	bh=tVZea1ikNA4Sssls4g09ZchJ08JhUaFOY8Mmt8T2Tzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqFo+3vq33886BF8G+1q/bhCohFKDgRs8vQqOdp7M0NwBFztrjI9dgffRgicgg8xYQZyR0wAnqtrXAMo0spGAKcw2MmOiyW70VclhXHRdaOptL649oZHeI1xru25b5mAYZK90ThvCXHXrniKAbzHbna8uE/Fg+qP+9C7cFZxx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePK0tLeI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4d5886f825so5462206a12.0;
        Tue, 09 Sep 2025 19:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472714; x=1758077514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdhbTSK6p9ht0YngyCDiyyRtcLCfpgxS9tGDrcGiJGs=;
        b=ePK0tLeIfyWg+w0tLYe5RzjkEOk984O6vaQj2Ogl3s1fnaCFWmOZVpy4MynXp79iAj
         gosiW6phrYFA+hBtBdgUDb3rYKwGk+jDEUDGJxAAsBWSrMd32RTlxZpLE1i9vu2qc9W8
         y8v+84AzSf1UuoBRE5be1fviiK2ZD80xB8pLnafZxOzVRGrq37Xn7lQPphWWW8dtSk7r
         pTAvy6ovBvyA7241Q2ZnSYE3N2FJBm4+CC2APF/oCguXjPnHwgf04Aca2N2gC8cR4s1j
         gUU43wPKdlnArDdbHXTT4/YZJQiex4o0gs6bW9ESvcCWEjhturFVJfvVnzZ9YToq/ATW
         Ihug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472714; x=1758077514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdhbTSK6p9ht0YngyCDiyyRtcLCfpgxS9tGDrcGiJGs=;
        b=mDtQ6woxrrcYglMdqWscYXKNxq1MrTOMahxAHsi4UaDdS4FVWJwq+8fNEorwslaoy6
         qEGD1Ys40woVtfzRNIxQI/tHLZVlLEomO5AG5Xt0cHuoR5AgI5QBUaJcuDdXAYzvnYx3
         S6akgbWCdrujCFq2nC/hEZXde358lWB4C+X31uQd28x1DC+ok0rYdxJbCk/XUsFWohuF
         6BQpQhAdKqCp0mzhgjJWdD2AZpLfTBfXvvnwNZJf+psFLtvHNiGCj3xtcOA2Gw/vgqTG
         izB+T8KQ4c414n5exOYGS4UR4jXAboHSJdYOwz53RrHpe4Z6FNkarH86SBiYceQukEyn
         vqtA==
X-Forwarded-Encrypted: i=1; AJvYcCU17hUZ0A8eugphDdkkC9Ryrw9bbPpA6rAtkC0tKUAVrWz4udthjC8dVHpV00bNCE7L7qY4VRfo8zYA@vger.kernel.org, AJvYcCUAmugSV/EWnMr9U2BL038PmZJndLj896lU9erGwIiaE6z5hfzjqmGdi9PJiKG+q/M9wSM=@vger.kernel.org, AJvYcCUg9vW6DDBFJ4TftRcplYHAVet7mkSxSfwOxd0S/h6F2LHHikNGXKKaogy0QKNQZsvAzRgAuOCc@vger.kernel.org, AJvYcCVUPMxDtTnPZnsNsMqtL4or8JrlzpPNyK+zg6RYvT2Y6EdD4LJdQR3tEZ4dejMDmLGoMY8h2Gt/IJRKvkBN@vger.kernel.org, AJvYcCVdCkwyGjpuosk2SNvvJUxxPB3y7tSxLnbByI5A2nIN9itYXfOP54v/3orSHX+nvm0Q1oUOCLPolzlx@vger.kernel.org, AJvYcCVn8r3E+5mD53woC23XmzjbmOqhrO3s6SNNsmyxJQa2KRhwKxvRBK3OA928sbXQ6iVJTIyLR3nbjQu4JQ==@vger.kernel.org, AJvYcCWk1VtxEnMwH72Gd8RwRArqZHgiDMbeRXfXjuqR8iQ37Mz33klXWGkFFWan9McOXZdhYka85AiNqnjop4M=@vger.kernel.org, AJvYcCXB0VoWrh72hEF9mrd7cgEmd37a8FMBetRGVnKFE5GILEv1VxC+QeJMASg3W6drqJ1KN0tdX4Xr4Lk=@vger.kernel.org, AJvYcCXabhnYkSifO1fOAxES4W5PH3C2+AsF9zEOxQKEjjrCSyDSe6u4lB2vn3xXO2tLNyHJwZQl7IUAA9qSRkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB6CY0ueUo71Letzc1QwSFSYwVUvwS+XTdjGc4anPX4o8oOxm8
	ii1aRBT53sOa2p1vDGnJtpfoBCkOIgcRx8hK28+VEC4QEqBQX59sMcy1
X-Gm-Gg: ASbGncuENZ1fbTmv5iYpxolWk6ayl4gxAIfR2DQp7UDcnUbdWNcG/5NNnZYop0mCCGD
	mMUTVtmx8ER0R9KygyJ0kgqUSjbLKbTUBH2C0G0Nx7GXGk66c0X2nVvDdKFgpJED5oNX4vqCuZW
	eMn7NjI5+hgbDrpBBGmnwML75wAv2TKCoFoqdEBehQ/igXfajEtXpkrTgESNGXxlO+7OX/UN9B1
	B6H2H4iLAlAy/hEwIKLPIy6xSu8q5wKhJ+AA6E5c9xrkNgpHzlwqSnirtWXtOFQCruGsopf8+GW
	7I3t2lApGYTHdx7KTvnMLx7k3AUjrOsMomS+yeQKHFrKm40Ihz7o+XkCuyP2gJQO0c5xAYv+c3y
	d4Podsl3JygGdEn5l10Xk57tlpg==
X-Google-Smtp-Source: AGHT+IEB/m099LrAl5yQVt4L0Nzl0jupOns8XwrHabjqcwIBBCUNyigNNYELdZPt4mBJxRKyTxzUaA==
X-Received: by 2002:a17:902:da82:b0:24b:2b07:5f6d with SMTP id d9443c01a7336-2516d818031mr154485025ad.9.1757472714167;
        Tue, 09 Sep 2025 19:51:54 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb032dc6sm679647a91.0.2025.09.09.19.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:51:53 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id DC0B441BEAA1; Wed, 10 Sep 2025 09:43:52 +0700 (WIB)
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
Subject: [PATCH v2 10/13] Documentation: smb: smbdirect: Convert KSMBD docs link
Date: Wed, 10 Sep 2025 09:43:25 +0700
Message-ID: <20250910024328.17911-11-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=bagasdotme@gmail.com; h=from:subject; bh=tVZea1ikNA4Sssls4g09ZchJ08JhUaFOY8Mmt8T2Tzg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHnihVZXUEfpV/XXVSre/C87lNIRyCV5IjnItu7ShZU PiphvtYRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZych0jw9MiYfOuPx0mkkFP UiIWTa/TFphmY/DisofsPrHQd/6Zwgx/paxTd1xaG72+5ivH8bnS+nm3e6W3try5uGL6W3UVsUu 32QA=
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


