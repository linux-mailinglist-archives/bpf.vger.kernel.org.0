Return-Path: <bpf+bounces-66953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF09B3B519
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 09:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21B3202AA7
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 07:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6782D8DD9;
	Fri, 29 Aug 2025 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/PrkAbE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC62D8388;
	Fri, 29 Aug 2025 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454151; cv=none; b=MWA5IfmK7Jl104QlqJfjEcHI/17+jOHLbC9TriMYI3iQewVsrSvsn0EWwUOw3WinmEiM2EXQaJvy9ZYELSHIFi/2hKDHnUWeKqS7O77WkE9zw1hx4hLuE0E94ksfj8fpbE+Lg5p/Owqa5Rq1KAXPmhfOtlFJTN56BTaqtxzpnzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454151; c=relaxed/simple;
	bh=evrdLEAoXKuQzTljW81Kh3KyWLApG8gUObVzJ2YlNgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pThoW70Ipe6UdxQvJmqLNJQxDtvQ6pl3eyRgF+TlWsYrIx0Vhm3BmsLLkKoTIs5kncGqw5BvRx+yEvTj+LBNqz5hbfyW+W6PRe1OnFH2IriuU2POUDrCzryA7BPpfTXmVNDug/QKt/g3wK5frMCALNTtDdO1aT9sMg1Ufy9ljxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/PrkAbE; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1570525a12.3;
        Fri, 29 Aug 2025 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454149; x=1757058949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQcUO3MMNiHKjyp0GXG4A4uvsTQgAsYSLBA8ucpISkE=;
        b=T/PrkAbEDgjnmooE6ttNcyK3EB3/X33I1ZV1rEbxXFyHf+Aj35dnQhz7bfaWzgxcd1
         sc+EQQn403MHJ+gE88k2ZoqEvsu9l7pvYduPA3u0Y53wNMvVaKajDMtMoP4k6zQB5FO6
         sUdkchM0EMLwLnNowwb9LM3MQc8LKoAv/jZOIGAzuUUDoI1xbm2rGBXel589wjFmfGNd
         i8bwPCREuv35B35XkH7ufMkmPQ9WTdeQ9jjj2wnoA/xyq3f+QwZW61ffcuvNW5dsu9JL
         sZeGz9xVmihcIPFtF4SFsMX834A8aS6ljmP5UXxMI+P6t8CQialhwMumuzLl8nAzybRj
         QG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454149; x=1757058949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQcUO3MMNiHKjyp0GXG4A4uvsTQgAsYSLBA8ucpISkE=;
        b=c0MepO2zuk32WlNy9OaWrezzL/BBBXS0OIuGgJzE/LE6Xu5CmI3zq/3Vj7SfP0bRDP
         gm/2kPP2vGc+Z44kqYCYOeBIUu5T14pMlnkFRYofeR3KTt8hXULPAXdVAooCPA5rdMsR
         0b0lWQJS1kC7G8QTNK1yGRsg8DPmsmxF4BLyS69anVYIom+/mFwQULmdDuEB8Me9VQi/
         Hfwblh/f40WpbeD3mgFf5+ur8iTPxpTGRS44v/HRfFR+yF5uyiPBJMN9uK+cYzXKzlTg
         IOlCndfD8feXRVo3loHKOyY04N1X28d62QTpq1ipl6Fnry650dBuVamur+wLdzGM80f0
         54gw==
X-Forwarded-Encrypted: i=1; AJvYcCUC96xhMssdMUmU3J+rHxyQtwzKxAY7L0kv+vxKs9JybCOX0x68C3+v+4ZGPSehoQCZwT+OEf+U@vger.kernel.org, AJvYcCUkIaXEiSBSDjo4lv5twD77phstJWd7CQGKVxfoOn+qWaA817dlVYjZNi+RWxOFSmTg83Nl0ZiVMJMszw==@vger.kernel.org, AJvYcCVBgeGkLBhXYA05N39LCXv307vE2ri5mne2QVNgpJ60cOkI68rnkgxckup9H3+/kvHRdPwl22nN4Fo0PeUB@vger.kernel.org, AJvYcCVMXSyr6D/RWDQaQ4UdcSM6AujCU3ouEBtN1MedSihIqs7cApu/6ttjC4YkwhKgC8m70CxLCWQypHiEwkg=@vger.kernel.org, AJvYcCVZRfTWOVBg6lIO4cJPsufnu9l9ugx8wCJ0XJqYufTofL13VtfB6Pf6GH4goCUviOIPs/NfO0eH3Ur3@vger.kernel.org, AJvYcCVeZ+ewrcd5moUVF9suB9J8KfaLpdBO0dyO//yi8yoXD+RooB6e00YcEJDieWZlRzd0OYPuujCPU3c3@vger.kernel.org, AJvYcCXGssv+qy3+boqIdZxqARk3ujZIs1bNQtndqyrorAJ7HQB83pBSekoc5/onq4ZpP/4VH5Z8mqHZZgW5zbo=@vger.kernel.org, AJvYcCXfs7TRVyOPDB65hplta4sYo+ta9s2UOtFH64jPlNb3H4/MNEhEvoZAkaM6FegIbULxDzA=@vger.kernel.org, AJvYcCXmmB76Rg+c+9ppoe2TLF/1KfCdKJzyaGHpkHhH1Bw7nVhKyX4ILxQZvbTy9Ee2qrvmZcfpmgahN7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCMAQmw5aqSDNvDujOu/TdjwPJzAK7yCc+5fyHemzann48Wzbt
	mFwGOKrsVD219zxcP2KROIQKee+lFqjcA8K73BUI37oUfq+XNl+HL67z
X-Gm-Gg: ASbGncvij/WkXwcJct2nEOCd78fX5I6d86tD1oYJ9faqegNA38njj8YFmcm8rpC0bTp
	B2jKVgorqMCOi7htUiB69hicut01b8jn9B9y2ohOeKo7jxoUepj7m6HLzVPgLCnHUOmtUM1GQxv
	2Q6h6kdN0Z61FxpOUDO/YTUFSKnN83VUE8sD44FiiHX15b4QkTjBdulpoGLn411OyUZngDYfrjn
	rgMCrRlfR+QrWol/Mg6PC1Mm0+zsMXwucVZMiJdsIz5knbfiPVGuCX4bvUc40LuZiYBeELGR3a7
	mWZZMvATC+AWpdp11AxcVQ++ZA3PdJOy7vIXrdkptUOaPWfjtixcV4cOZPs4hC8MONb7oq5qPha
	VMHcKrnCvw7eShL2eE1G85rq9aaaWkiMimIX1
X-Google-Smtp-Source: AGHT+IHLqM32trOVVzh172ftn7E15FM6Ea2Jk4ybBnzNmcbOCkm5faJ3oUsml9NRpuaa5OiBwPVbig==
X-Received: by 2002:a17:90b:4ccc:b0:327:7c5a:fe77 with SMTP id 98e67ed59e1d1-3277c5aff68mr10961209a91.30.1756454148623;
        Fri, 29 Aug 2025 00:55:48 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327a22ec24dsm2591905a91.3.2025.08.29.00.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:55:43 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3924545A3F85; Fri, 29 Aug 2025 14:55:29 +0700 (WIB)
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
Subject: [PATCH 13/14] nitro_enclaves: Use internal cross-reference for kernel docs links
Date: Fri, 29 Aug 2025 14:55:23 +0700
Message-ID: <20250829075524.45635-14-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=bagasdotme@gmail.com; h=from:subject; bh=evrdLEAoXKuQzTljW81Kh3KyWLApG8gUObVzJ2YlNgE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY16J9usWFB1WvT+NSavLIanh+698vZJvp5Iqyn5cF Oeb1Xiho5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABPJ/8zI8C+tSSfleGvDlW33 Ss5v/Xrog5zFrjCmKzem/Vr2Ka6JL4WRod0y2uaV0GJBfuHrJzY9vTqdTVAvLqhtcdO5S89liyP teAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert links to kernel docs pages from external link to internal
cross-references.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/virt/ne_overview.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/ne_overview.rst b/Documentation/virt/ne_overview.rst
index 74c2f5919c886e..572105eab452b2 100644
--- a/Documentation/virt/ne_overview.rst
+++ b/Documentation/virt/ne_overview.rst
@@ -91,10 +91,10 @@ running in the primary VM via a poll notification mechanism. Then the user space
 enclave process can exit.
 
 [1] https://aws.amazon.com/ec2/nitro/nitro-enclaves/
-[2] https://www.kernel.org/doc/html/latest/admin-guide/mm/hugetlbpage.html
+[2] Documentation/admin-guide/mm/hugetlbpage.rst
 [3] https://lwn.net/Articles/807108/
-[4] https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
+[4] Documentation/admin-guide/kernel-parameters.rst
 [5] https://man7.org/linux/man-pages/man7/vsock.7.html
-[6] https://www.kernel.org/doc/html/latest/x86/boot.html
-[7] https://www.kernel.org/doc/html/latest/arm64/hugetlbpage.html
-[8] https://www.kernel.org/doc/html/latest/arm64/booting.html
+[6] Documentation/arch/x86/boot.rst
+[7] Documentation/arch/arm64/hugetlbpage.rst
+[8] Documentation/arch/arm64/booting.rst
-- 
An old man doll... just what I always wanted! - Clara


