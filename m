Return-Path: <bpf+bounces-67984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7365BB50BEA
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE884470F6
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C181C258EFF;
	Wed, 10 Sep 2025 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdJpaAiP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E8F211A28;
	Wed, 10 Sep 2025 02:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472717; cv=none; b=eMb+dy8RFsB7AHCFp+vpBRr42MmRGdYLOXTw52J2cTUYxde0oHOs4BZkZ1fAtr7+ed0Kxlf+zAwq1mb7NIcWTDe20KEfxvoUfwCRzkvDxbzoHVXxQ06deDzvvvG+p1QTBXCWt3cQ8eL7DyMIc6SFfbV6PH2yXJjdBWASGL3D89k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472717; c=relaxed/simple;
	bh=evrdLEAoXKuQzTljW81Kh3KyWLApG8gUObVzJ2YlNgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQ+6pmBfdmvQ+kBJEIu7MNAtWfjwBYucoYGIsoUZmfye1yCax1et32KYWyqXLm1Xbfj6sm3NWtFAlJXHvVryxiJc9br6dydjNe0ffTMwnGfl2rmHavXR3OOhUZD7MOiykb+HWjLhwEVzy7IriDwPoHxOXBlrvPT3l51+6bHXoT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdJpaAiP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-323266cdf64so5476763a91.0;
        Tue, 09 Sep 2025 19:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472715; x=1758077515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQcUO3MMNiHKjyp0GXG4A4uvsTQgAsYSLBA8ucpISkE=;
        b=kdJpaAiPROWhYOkySJUXyPnMg3ALshgV9TVcGtiw+Ltr3oT2i/piKXtosp35L5TgT8
         KiRiXC56wyrj+MtmCsLQ7oJ8ACYaZ3rJ76Ffcjt9j7n8tqjp/SzCpGb7e8X+3OxTLqi2
         VR0YBtsBpPTqUMGz9H7SEHnxFmxpdvNbI6WF/xxqPkXwb2JoX5GYRbHZVHpTVuep4KFI
         vZZegZtaeQ+k7QM/Wl31v/rFlX6+HToo2JNzqHBJklFDXfnsY7AADhGD3ca8YjqB3OMw
         MoLBpRfUN3yuZlQ0U9ylmq3k/V+JFG82aplaebUege4YnFf2KS7ejUvlXAzSeJ3NaqHM
         8sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472715; x=1758077515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQcUO3MMNiHKjyp0GXG4A4uvsTQgAsYSLBA8ucpISkE=;
        b=SezoKR/86e/3HIlIVhG8nNa71Ic5gVxevzOhRbLvFP1mOxlG+aLFa2KCmVlyjjssaZ
         cK7klyMk3N2LKOW+3soU8Q/m9QFToq+LZoUsdBqsaSbDHgBv1fI0m4QdzfBB1h5CBqAJ
         q2d63RDZb0WlnbGZPC4gSPQCSQEMARZrdSWybERqlBwkrHM0RGTGi9aSeJYvYCmzAyVe
         M2GiVMoGlP8s0AuMv728eelO6VwB3OI9KCQGZgGQIkNDQZ3eEJNSfm3m9UOExyrQkHeD
         9OUUJOcrZzvRKqF3L53jAKLkWAK99AFAxkzVW/pS9Jhe2pUffy8bxNvN60KqnRg8Wz9s
         QYng==
X-Forwarded-Encrypted: i=1; AJvYcCUVVZogjeP1AAIvfggrwV71fodHhTTbQ70GzRxCiN9V8aWnzJ/tpin0QSMn3v3gZkZO3IUH1j9C@vger.kernel.org, AJvYcCUWgOfi8hJvd+5ywPmHDYDVk04FqKww3ulduGaa9nFB0Te9Dw8oGQRmuC7NhTEuDrGX7Z/biv2Qu9eMe44=@vger.kernel.org, AJvYcCVJx7OIzc6LKzOp8IDzc3nJ3zAjp8DIXYfFO6EDZbYkZa+x2t7+I5tpxWivw+up4Y/GpAcGa+JVEWRN@vger.kernel.org, AJvYcCVSjyQ0N5SeKLqsyNg/c40PdL2xYW5wHEpyIK83fZA2B4yUCc4NFVTgVAA1OFMqg7+o/qCYYT1WyTj/bZsO@vger.kernel.org, AJvYcCVW3AEncqy19XzH1caBvcYIjikHPfN6yTREcFxqkjyvhG89MjbAnauEVyksFwxfEdh0jLa46gtejqbQ@vger.kernel.org, AJvYcCWMnO5uGB06d3eyWjPmHVQjLX+Ft839eVD7DQp+DbS9TPvcFOXrMaraSApIeZAZQm2nGo6cxE7z0nY=@vger.kernel.org, AJvYcCWpJOI7SIoXA93c10dIkCakmlddM26GXd3Y+W80qeri5bNil3MgpJ9UsbkdIbUOhXRlaYOmwSPEHV4BpGg=@vger.kernel.org, AJvYcCWxAGa4nay8ler64LQHe7HS7+fECvaHBufPlYgVnTOsVCSj5mwTrDInoBHe6SqCSbxioIw=@vger.kernel.org, AJvYcCXGQUqyyfQiFzL5usUN76Tm4gtWsG6M10BYh+kSweY8qXEPd1ynRpiCySJzgqFYOcsfdc8O26Nk5ac06Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3JT0X48y8E0QN31N7LgLhmBLQ+5+KGLyjmRtcaFN8h8Fa2kBE
	P0DR5VGcnyhsjzaJStLaVt6TYAsQwVAwlRWb5Z/Re/iM9ngq4ah01Z73
X-Gm-Gg: ASbGnct0vVG6awdMmKZdCMl7AYIlu7XXV/B9duAOw6LIUheF29ZHuZs4ViCzA+66MTB
	w26TdWQ97zeeMluCWqFq+KK/N/oISNTly3Mlf7EDhaakAOcNj69M2XyzA1jy1kpvK+ZXLNnsxlc
	sj3Lf/6hsnFRHmQsXIr+iZos3LYrtEmkepZ4TnkzGHLh62Rf/4Hvr4k2QLAU5oSkZXliZAVvntw
	t+vXxOmbfda+HFMjaZ1lMR6IeN0TogUwkHGO8To4MlPWTAdOEhcVdiBxGdJcpIuwout39Gax/GI
	GnBloMt4dIuXCRyo1n0chWKpqhDwW1+9SDnkvYt7cNlVxhzSDW6LZprsbvCaIRq2lYA0X5bvs/L
	mIofpvo7hQXLw80+WkgAxDDhybdEPiB1FIj6w
X-Google-Smtp-Source: AGHT+IHumoKCl0BwECrl0jFgQDm+a5TPs08x2B/wSLqiGEG+ifiNXW+7jwodpJ99kFpH7Ms7vygGwQ==
X-Received: by 2002:a17:90b:2b43:b0:32b:5195:d119 with SMTP id 98e67ed59e1d1-32d43f04fc5mr19535835a91.12.1757472714800;
        Tue, 09 Sep 2025 19:51:54 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb313dbasm659049a91.5.2025.09.09.19.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:51:53 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 158E941BDD48; Wed, 10 Sep 2025 09:43:53 +0700 (WIB)
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
Subject: [PATCH v2 12/13] nitro_enclaves: Use internal cross-reference for kernel docs links
Date: Wed, 10 Sep 2025 09:43:27 +0700
Message-ID: <20250910024328.17911-13-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=bagasdotme@gmail.com; h=from:subject; bh=evrdLEAoXKuQzTljW81Kh3KyWLApG8gUObVzJ2YlNgE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHniiL9usWFB1WvT+NSavLIanh+698vZJvp5Iqyn5cF Oeb1Xiho5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABN50cHwvzL4D8eTgyE89fse HlBVStE02WjOOvl23fZ49/PHUnNONTP8FYh3YzzAeWbK5vj6FqvtSXp3M3+Vxhz3fMrXXv7oQq4 HPwA=
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


