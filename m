Return-Path: <bpf+bounces-67969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8515B50BA0
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1545E641F
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20092287249;
	Wed, 10 Sep 2025 02:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4RdcytB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFBB242D9E;
	Wed, 10 Sep 2025 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472250; cv=none; b=bWIMQZiMROTpCrnbrZukrIaD8g6K80+HgRovOnh/rW8z2J+OmBd6D1M7t1pUIyH8G0yRklUy8c5Pm2aiuQHuIiqNaJnDz6f2ASVb7Nw1t2HFvSggwgmO95GL2gtdwooANfxeGfne8j8UlopAq0APFGkw3fz2mxJUnhcPK0DQF3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472250; c=relaxed/simple;
	bh=yEY9P3BA6E4kqaGTHyjuJlgmOOGj2m2ZOET4fPd8xcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uV9gUjmFLquFHh9Y8seSNiPh8GFChmpuTYy+KSmmHGRVdo+5mbjVzAXQaz3Bo/eCeKUX7u0IntSpVQXyDRLtXfsbFIRy9hA0W+AUCVFZqpP7nMLAHRF2Jqtsw2WA8Pff3qiUUxqp9Dw9RxjhEiq6DZcI3/keelMyivOleerljYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4RdcytB; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77246079bc9so7425193b3a.3;
        Tue, 09 Sep 2025 19:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472248; x=1758077048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kNx/lgQaweLHCKpOd5HxLBg5NtnJ9f3nOi2hx/97zs=;
        b=Q4RdcytBALx9wkhV8FDjmO13KRWACRKyAUvvAU1PqGIXsDeqJUAgJ4RtJHGKnYIQNu
         56cmyBN7/daYDql1WeONtVLheU9wVIZdKCLvc+1BMB8LypUExVMxsaiLPpl785FGTFLs
         B27nyumweixg14lmby2jUbG1jzMoJfBkXvhNb10VNxU+tCbDTHW2nXDf5Lj0yxeoMdU2
         NdgtVmmu7chBWWcI/KR86f039Y1hvcL5ZqyydTlbAuoCc+XZbGZljPTQQav/E6dX2BjI
         1hkXcrElnFQBkp0HQ7f906tolja9K3GzZiALPdr8oHB9ksqFIoJW3Lq/x6nQomY5fGYY
         NhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472248; x=1758077048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2kNx/lgQaweLHCKpOd5HxLBg5NtnJ9f3nOi2hx/97zs=;
        b=H+kd6Y/RyqCGvYDSgkhKRaC8F6Ehn7fSDgeSQH6NHogeCDfKLQ7rviFtq1frpVIuAl
         ZXZtX+HFGFUCVNYa2iZKB/EgkU7HP/0cHMMBj5vXVkzlr40WJKNDqEl5SAj0WUdnEp1u
         GkCh5N4+eMJ/oGnmFZzEAiHEkwUuA8k9vNDsP6CLKhSqfbwayQGhuQezjmBisXamqdUX
         0XQN4qisqFsGZL4AnWHiTlkHyFGIGoXKGrcjM7K+ZIwBiCmSUR0ekWUNzziL5Mgcn8MW
         pjsNvglt+/HOSpoZROHV4KJB3fPQRY3t+by1upPJnc6T+L6b2UzpBTPGcIGlJkxZFpL3
         neaA==
X-Forwarded-Encrypted: i=1; AJvYcCUupHCak0Jf3jK2zLWhTc1F79Ip3if+WWo0JRxZ5LhcOZljjb4W3Rzq9Z9HguvF+6jC55eEzJA/3tE=@vger.kernel.org, AJvYcCV20oFS+dewyNnQBAaq5eVZcxyje9cA0AkDFjqz0J14INTLU0qiRAK9sdUlagiPODROy5E=@vger.kernel.org, AJvYcCViQKku3ko1esT0FFXXJvM8nY4VLDRxrJCC3Eg63P/YyhL7tnEDgOXvAFV5Wxc+ofrP7JN+/R6UPy3613dy@vger.kernel.org, AJvYcCVnty+Kvl5PPY3d3Jv4ge+Ki7yZBCu/vKbieglViG+VHoiqVoczYTH1pBIF5AfMU+RhJZZeiNVfoA0rl/g=@vger.kernel.org, AJvYcCWMwJubpqqx3AqWCI4u/Sfr4+oWAkr/Kh5Cl8qhiH7GsdMXZG9nZ3PxpHCWWQ19wTpBEnGxboeW@vger.kernel.org, AJvYcCX1sa+zMPhSFNSXXwtem+4hBJczdPqtwwx8q4APTrT/+Ub5DR0gmAfYr33diS5MwGyfOSCSKUytAzLS@vger.kernel.org, AJvYcCXSD3LRoVEr+8S3/6FTO+tyltSv4wbADSas3XDbIQpKdy7mqgHi2sjWiJVoQUiTqY5/IEUt70GhKeRDog==@vger.kernel.org, AJvYcCXsZ5C2R2ZzrsgnY7vQVYDbAQx+fZjMxboX+z62IzO5KnVMHV0SfXfF9sdJbdo7VAvSllZx17dNsdCL3MU=@vger.kernel.org, AJvYcCXsgsndhLLtWpmBmHgUMMc9wEFI6BmZ3KLaf84nr1v4V1B7D1xgRyH3DGDc3X/JiKcJayy91DY/8hjn@vger.kernel.org
X-Gm-Message-State: AOJu0YzFz0WmpQxUQcnuopEGsLm7ZlU9jLyRpGXtmFw5IDlbY+Vpfy3n
	OzK07k43SpLBzXU4t4fYb5ZHdDF1qC3jYR5HVndPKKDa1xo1a45XRc0a
X-Gm-Gg: ASbGncspkCW6c8PoVAjrU+82nS53900ObC1afAGYe352AxUrCdjFC8qJgC3eGY/oTPd
	0H+6zDpC7T0kOZ1vZe3A17aK4OX1cp6P87RsJhGw6FXaO9TcB4VbhgW4ZrnX3hWX/cE2Pm+v03y
	h++9fuQahBCV2Hj5Egr9sIO2SqlYQdt8anjS2Dx7VyH+Vhb+sn+H7eK/9nVTM8tHN64cGXdhNF9
	yi+fpZseF8/dMZLMyTdkcg1RFyXrn5mdnI7bRdwxRtpq0UGuBoNn0Li10MeNlUaYrofxhGT+z2M
	xkm2CwoT5V6wmqLCJRXLu7kqMXGfoSZAeJ8SpzsrbaqheMRBeDLZIt1U0LZdgceL2VMM7L/H77T
	bks30ZcMtzxbGI9wPXOGXFRaOAQ==
X-Google-Smtp-Source: AGHT+IEyED1mSm10/nBWu/PDugDe2kHeGr2B1Dlm/0Mxg3VMmmsn8EtrKKBRn8Kt1DMp+jVk5SErrA==
X-Received: by 2002:a05:6a21:998d:b0:24e:e270:2f5d with SMTP id adf61e73a8af0-2534547a6fbmr21436774637.43.1757472247740;
        Tue, 09 Sep 2025 19:44:07 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6bbc9fsm1061117a12.43.2025.09.09.19.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:44:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 999D241BEA9D; Wed, 10 Sep 2025 09:43:52 +0700 (WIB)
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
Subject: [PATCH v2 07/13] Documentation: kasan: Use internal link to kunit
Date: Wed, 10 Sep 2025 09:43:22 +0700
Message-ID: <20250910024328.17911-8-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=bagasdotme@gmail.com; h=from:subject; bh=yEY9P3BA6E4kqaGTHyjuJlgmOOGj2m2ZOET4fPd8xcs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHnihdUeC/XH99x9zD0/p/z/9z+OvEiwfuXjriUbHJw 5Al4fDvwo5SFgYxLgZZMUWWSYl8Tad3GYlcaF/rCDOHlQlkCAMXpwBMpGYSI8Phu5uLfVhjJryT C+XOkO/82KnH+HRZtlehgA+3hxWLXwPDX5ny7U3LZzLMPNBzWixMoIP59nkt/0fGhV4ZjM5rXH1 d+AA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use internal linking to KUnit documentation.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/dev-tools/kasan.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 0a1418ab72fdfc..c0896d55c97af8 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -562,7 +562,5 @@ There are a few ways to run the KASAN tests.
    With ``CONFIG_KUNIT`` and ``CONFIG_KASAN_KUNIT_TEST`` built-in, it is also
    possible to use ``kunit_tool`` to see the results of KUnit tests in a more
    readable way. This will not print the KASAN reports of the tests that passed.
-   See `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_
-   for more up-to-date information on ``kunit_tool``.
-
-.. _KUnit: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
+   See :doc:`KUnit documentation <kunit/index>` for more up-to-date information
+   on ``kunit_tool``.
-- 
An old man doll... just what I always wanted! - Clara


