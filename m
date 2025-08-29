Return-Path: <bpf+bounces-66950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D12B3B508
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 09:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD192A010E1
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 07:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADAE2D3EC0;
	Fri, 29 Aug 2025 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqOASymM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974C2D0C68;
	Fri, 29 Aug 2025 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454145; cv=none; b=LjN8jRyEytrQwg6zNwf4KiRZscNsqp2emrBlQ2JRGj1slhvuQMUMlRnSiO18fgU088TbjCFOyMsKQpBovOOQZ5Ltddaa8xKanPQxnfhj6PGNVRQrl9q9tzdA/4Tb58dPKpHZwG75zQjHkRUyLUCPMDcxLFRapZzf5fB2LP+YJ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454145; c=relaxed/simple;
	bh=7QXrNRuCbHeHgCYdGUN3dSXlo+bJ6ZwXyeTt5Kf+8Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uG8OmFFJPDmzJDg/qLK2p6JtBZiMX8gnZ6qLFaEYeSoAQH9kd/6oML/Hb1VJ1cqa7QIhvUs7QwBoj/HpNeLZr2591/nvbW4mRkM2pGsj23bYwTDEXl04wi6Y/DvMYtITaZnHQm/cCqnN6WIvwnvuFQlkFAb6ImSo7PIkQxgRJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqOASymM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so157091a12.1;
        Fri, 29 Aug 2025 00:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454143; x=1757058943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exY9byyl4etH+4IQEKnm6qXO5lYPceGxvCuurSN7fh0=;
        b=OqOASymMnjUJjKeyL/rUtaPFRLooC4g2jWK2ADtdVJQn4+ymhMawBk3mG+b3pFcM+0
         BS0CplbVZfjWxd44M3/WiI7TExYtYAe7gHlNAxm2Hb+/0sS1lS3xkS67u3HmotbaaMoX
         JH2kZJhO727dNlOlQJqKMf6qCSy03QDvDLPoH3zOA82VWc5Wu5kUksBBeaUWfMhyQcGT
         +6g3QDtm/eAzO+mfk711CAEWm4sdglNdhGCAztaFwBHPO376yvPIBuiK4aKMJQYYJ0NV
         9ALLZ2/V6rTAmMNJmfAq0jNifn4e1HR3bOhuMrFqPEPUZ/F+NRnpVqqUBkem7r+5bQn+
         dUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454143; x=1757058943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exY9byyl4etH+4IQEKnm6qXO5lYPceGxvCuurSN7fh0=;
        b=l9+GLUV4dFJD5vvSihNJTnqZ6ZTUGIRKFuVJH1M9gBxjgwt5Ikno4Ia35k8K5yS4Cv
         oamlTnMAV1TxMmGbFLvNohSRNmHZxmHmjw4Y7UbNf6wnr+S3g7UdM0NtmpN+gS7g7TIW
         RXXBArE4BW/x2KZTFJaFiNkd0TcjQOmG7ip7FFqKOD2UbJx0VLH0PrJyafE6PAJ465pb
         2quFreV5F5xf1g0O6HnwmClJ+gdLni/uzV9seY1hXB+6St9aUH/1XlviCcnarHpPgfGQ
         1wWbI6NdW5ywjRHb99ERSucKxUdfi1Ha4ifgKeIIAcHMrzuzFCIrlCPCl3znmSwl+HJz
         rjyA==
X-Forwarded-Encrypted: i=1; AJvYcCU7K0cAcTNy/fJ6HIfpZjNCF+HpSHMKP2WIha8k6EmgepYddBg03QwVK8/5c80NdnVIOLccgSVU/zItcaQ=@vger.kernel.org, AJvYcCUuRngjvVl5Pwrj+iT9Pgb7ajN/qJrwF9TvhhgModS9ZIGw6YLSTPx0Lv4QmSFAdaLlQn+gghQ3@vger.kernel.org, AJvYcCV3JeSE/oprnKCLl6J7G1rB6fd57m0Mvz8n/yoOMc2OKScA6RQBhoAWJNa3mA9tMHpxRfhOA7vTOxLDhA==@vger.kernel.org, AJvYcCW0TCQh2YqkNRqypQVTmG5L/+wCVEp8tvTuEzRgh+89Iju5TE3KA325J9kx7WTr8i6npJ3V1XBqF52BNyry@vger.kernel.org, AJvYcCWkX02qjw4tCQmV0Yx7D40HUIB55gNWAvKu0GXJq0mwcWCMT7z0RTIsdt06EdFL/5mHH2Zyc0f2BEW9@vger.kernel.org, AJvYcCWzQzeG/1q+DOBPv8wBLhkByCWnLBz5iLeHh1gy+uce6Zgkys2PMSWYkhVFHcjxMM/kHaXyNvrtfGH0mns=@vger.kernel.org, AJvYcCXDzgW1hXLAKLqI1zFQ78XguRTgz1sNulZfwmTaiNlKz0X/IiCj5NZNLGUPQJVvjINRCuw=@vger.kernel.org, AJvYcCXcW5dJGKHNSErA323iI+HZJ/7JkrWDHgaRbiwdjxc3WH4uuVZM4283FNAOiLQZ9erjzqRqUdU/3xs=@vger.kernel.org, AJvYcCXwD5a872mHdKbc9lYzrL511z6e6hSGnnHiSlJfTk9zW5CN1LnYCBFZgXb0OeJeb839WAb57jto8AzN@vger.kernel.org
X-Gm-Message-State: AOJu0YwUvW89flVKfw+aaYFYvtu3SGsVJqZ6yZ3zH/oXiNZw3Cy8HxcZ
	rq0cxv+MxK5yxG7aC4LKV9oHQb/scUtm6MVgwsPxgaFJCwAVEi4RK07S
X-Gm-Gg: ASbGncvsv/we8fbXEU8isfscIChvW9t3YeKU/Gn2n+KlZj64WnCuzPZcoJxneAzpyo1
	anLHwUp5FvTRTZdmU5nVDxmtqAbjMNWfk/Wl19KstNZ1vtcOJtQ6mH29IUay/L6E7DH369zx3Q1
	Fwy8PvDhyJUa8a1MhZX/dMU6ozGpaAMF60rFFGbZDd6qBb8GeZLdeuylhMWWE9miQXHM8WZYGsA
	X3KPUQiFf5o9gSlbN+FP70tRcjIGg7SwhLPquNz8mamXZlazmSYLjs2u6EzB7xV/8oJ48z9eUHF
	VkkmB4KsYVV/FAm1gbENAzkYZIu3dDt2jCuNEbA/QwIcjTn1KFEn05+Rm0p7Vv25sXyeOiMuISA
	dhPE1tNNd/vfb5qcKgS55ZXvtL8vRvTIkEKkowRni0z2GK8k=
X-Google-Smtp-Source: AGHT+IGl2H1cpKBrzVIc01ALD2l+GqNGGEJdm0M1vP0Ajl0ap9rVA4eE5ntn2ncpRPD9DtXSzK3gDA==
X-Received: by 2002:a05:6a20:1585:b0:232:7c7b:1c7b with SMTP id adf61e73a8af0-24340c429e2mr42540329637.14.1756454142509;
        Fri, 29 Aug 2025 00:55:42 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2aaa70sm1550930b3a.24.2025.08.29.00.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:55:37 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7A9CF44808EB; Fri, 29 Aug 2025 14:55:27 +0700 (WIB)
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
Subject: [PATCH 05/14] Documentation: blk-mq: Convert block layer docs external links
Date: Fri, 29 Aug 2025 14:55:15 +0700
Message-ID: <20250829075524.45635-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2751; i=bagasdotme@gmail.com; h=from:subject; bh=7QXrNRuCbHeHgCYdGUN3dSXlo+bJ6ZwXyeTt5Kf+8Ys=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY17q3TFftH6q+kyOiIzsCLYVR/ZOd/GUnnS+Yu6/k 6t6/fl6OkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjARpWqGfwYJyctD8hT/NwY/ sO81mNZXoe/tpx8864flkqYm66Aruxn+V81fprfBrut+sv/0I1K75vi+e3t4WtGyeRzBVy1DeSv K+QE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Convert external links to block layer docs to use internal linking.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/block/blk-mq.rst | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/block/blk-mq.rst b/Documentation/block/blk-mq.rst
index fc06761b6ea906..4d511feda39cfd 100644
--- a/Documentation/block/blk-mq.rst
+++ b/Documentation/block/blk-mq.rst
@@ -87,17 +87,16 @@ IO Schedulers
 There are several schedulers implemented by the block layer, each one following
 a heuristic to improve the IO performance. They are "pluggable" (as in plug
 and play), in the sense of they can be selected at run time using sysfs. You
-can read more about Linux's IO schedulers `here
-<https://www.kernel.org/doc/html/latest/block/index.html>`_. The scheduling
-happens only between requests in the same queue, so it is not possible to merge
-requests from different queues, otherwise there would be cache trashing and a
-need to have a lock for each queue. After the scheduling, the requests are
-eligible to be sent to the hardware. One of the possible schedulers to be
-selected is the NONE scheduler, the most straightforward one. It will just
-place requests on whatever software queue the process is running on, without
-any reordering. When the device starts processing requests in the hardware
-queue (a.k.a. run the hardware queue), the software queues mapped to that
-hardware queue will be drained in sequence according to their mapping.
+can read more about Linux's IO schedulers at Documentation/block/index.rst.
+The scheduling happens only between requests in the same queue, so it is not
+possible to merge requests from different queues, otherwise there would be
+cache trashing and a need to have a lock for each queue. After the scheduling,
+the requests are eligible to be sent to the hardware. One of the possible
+schedulers to be selected is the NONE scheduler, the most straightforward one.
+It will just place requests on whatever software queue the process is running
+on, without any reordering. When the device starts processing requests in the
+hardware queue (a.k.a. run the hardware queue), the software queues mapped to
+that hardware queue will be drained in sequence according to their mapping.
 
 Hardware dispatch queues
 ~~~~~~~~~~~~~~~~~~~~~~~~
@@ -143,7 +142,7 @@ Further reading
 
 - `NOOP scheduler <https://en.wikipedia.org/wiki/Noop_scheduler>`_
 
-- `Null block device driver <https://www.kernel.org/doc/html/latest/block/null_blk.html>`_
+- Documentation/block/null_blk.rst
 
 Source code documentation
 =========================
-- 
An old man doll... just what I always wanted! - Clara


