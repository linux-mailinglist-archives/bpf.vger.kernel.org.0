Return-Path: <bpf+bounces-66958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27180B3B573
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 10:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DEE4679B9
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 08:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589F72D24A0;
	Fri, 29 Aug 2025 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz5w3LXU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08F22857DE;
	Fri, 29 Aug 2025 08:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454581; cv=none; b=XKNjLWnkGKs/zxt4Ni7wRV8psVOCXGC4i5ZUA6P/eyVY7+zemDcbUZU8a/sHbuBY7tiOmfFGVSuCTMTlvfljcNE95Y1Kx0MahOgiMifo54PNk54hxf8YPHp25hZ6ObPQ98aGZ6t7UiPOBnlETtRUi1tiQ0V1I3Awh1BVb/IlQCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454581; c=relaxed/simple;
	bh=QIAPxg2EoM7XBiBH/OfCd9SfIrsCdhbBl57WJdF7gOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nkb5bOEXPsX79UPWThE29Iv/nZKUEpncDfZaA7Dn2GCnur756RqYvmvv2HCdSWejjMHhJxNR68jbXT3SQAmpBLJ4rMT89veFCwUR/gXLvtern2FpVbl990TplOBcwdNhGI/21EeF6Z9Xk5ooAi/Qn7glyQYAf+zoBTgU+IyJXEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz5w3LXU; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7720f231174so1555043b3a.1;
        Fri, 29 Aug 2025 01:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454579; x=1757059379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji3KkW3qUsiM430Q8CaZBzXxSVywrfxa2oAywWyFSjA=;
        b=iz5w3LXU7XG4NJJFh6JefPvazJrNiHtO6WJ1Cpxe2GJsc9IuITz2gDST5g9A12ywz6
         5nRD2LcBNbOQN0G3Lf++FWqahxBkPsZIZgcsjxi0alLe8JsmvWZ9SNyApUMiSjQgM88A
         A9bSidnrzdKRldwyOx1kduh6mh03uBXRvoBDXhLSHuyZYKHazy6DFnLKCSJ+Zu9E+ofL
         ioQcMc+VqJ3HskJTy1B3ff5hqNbPr613J+m3MgnYs6bgnSQ2y0Be9jpnnb/ixwh3ADq7
         3kAgBj42FMCzGWYlDmR46MjEJidq8ePt17Smk/kvLLuf/0mfOYPEmPg3h1UA84X4RlRK
         ZsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454579; x=1757059379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ji3KkW3qUsiM430Q8CaZBzXxSVywrfxa2oAywWyFSjA=;
        b=bO6Kb9itXNqe/7mZ5mCLFhD4Ps5h6gYkVa/2lqSKKZoom5sMWOc50uQl+QIvSLRuyo
         NVQ4N8QSOOo8Qh4db+kcHt4ZpK94/hrOtElRWuVcAqBQBzP0+zDoirqklaZ2OmOVYYSS
         dL4WYnxd4XdF8xKpS1s5iKvTB87m0mu+DjD65ym1uT5ZfRIM0MhPAbMrciefGzKOh5My
         mmJ05glKgZTQPZahYEzHaY+Jqdzah2Z1WdHXWscG7fRmrJqsODGa1LMQuV+461itbPO0
         7jxTI0PzbFq/NTU8qpEVU37+/IceyYmjfqMlkGDBSuX3LHMs3PsF5tTjDBFbZxXM6yVm
         vJDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4otoMrVFm24C0rn+TBc/oCIIYzdgpJngJyKPaMFP3rQyMxX7US6osigjfFJTFuYXldUAygv3X@vger.kernel.org, AJvYcCUMq9OofPdjCb/k8aiYBW2xeCGcagQEWm+bPoyCPPk+f2N+q0dLU+EIJts+itz0w+RKOy+hsGX1qKEQeqo=@vger.kernel.org, AJvYcCUX6dDPgJdUjdYB39iA2S24EU+gksdi4x5BaCb8BeiJ5Dh9yMDEmmTEuPwNw3EIX3azm6t54xtpDpO+@vger.kernel.org, AJvYcCUeolW69DQmdmT7ZNkuOFpP8gW4CQCvjOypBTDEvted89iuEXTlIOAL4qzGEfTVt9/ti8COikFGtEEAwQ==@vger.kernel.org, AJvYcCUuy+verHzC1MT+5D9Nnn1KK8Y8aFMoJBGhQ3fpRFl9Gi1ZflkQjrXuazlvJSdqBo/lyEI=@vger.kernel.org, AJvYcCVJjOjQgPPZAf1FdT1ZRF9aVeZyvoTg5s6fcDiwRflMWhi6I4QKdCwF5T7jv1SwHtL/fFrmn3DNI7R0TDcy@vger.kernel.org, AJvYcCWbq5h1c93VS0ok6CgusN/uk7QxadgNI84+nLL88kR2EaRkXTOWq84KEB5wTxAG/2sIAE6QFirG+txVHEM=@vger.kernel.org, AJvYcCWn/xf+8HPUKNZlHLk1KJIZcsT0oyM5U1m7c0RKYIsCHwHkzfKG8KIV7HBYM9YbWWGjy/k07RvX0S/0@vger.kernel.org, AJvYcCXN0qtDi7sLM9hEr50+1aGGEkS+KOWtTw/4/nIHrAtaPgp6znWsANFtzE5ZNAD5ARzPQ+VkYbRPBZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiUlmwUsAu6R0o003MWYf2kazlutMaLwEtMRBvxqNgn8a2Q8Sb
	36fJU7MMxegq54hMc3Ekh5WpUMkc94zneK3768BMOfzuVpXSEhMUeJIA
X-Gm-Gg: ASbGncv3kWYDobCixjrs82gpp9GoqCj0aUJN9jlp2HjdN1+oVZXqtXTX+eAeDz4gdb5
	QJR91YLFGfCcTAymyanAkS2Bh5T4CoPC6NIo0fkUf8vTu6yYkFk9fjI8LBhhNR2vkLlGpxPDlMa
	VXNiWkmuh/BhhsHwtv1QIFSZsmXvyOMvePGUj6R1ySEunr1hAY8Z0ZLfli0BdNzDK+PPhAA8nPG
	aT5uGhlEg3MBMZ6SMp1Got0Akft9cl2FOp8GCBtxkqydc3CObouE6+6HrJfqg5Z4epLPk/N555M
	gJBp8d9ok7hyzoySG23MYatZGQ0UXiRQMCiKogqJpyKxsdv6yptBjTXyIG69NK5Swnhm8esayT9
	ReJkeKSgtf7kBoejm63jPkrFTzV8o4Tkqtkn1983FrPo9mOk=
X-Google-Smtp-Source: AGHT+IG4XzsUhVmrn4fJ8v1PNDsbGNCghgUfxDPbkeqpUjvEg9N6RxHWj66Wbdw1AdmD0ATs4dsvZw==
X-Received: by 2002:a05:6a20:3ca8:b0:240:750:58f with SMTP id adf61e73a8af0-24340d91edcmr35447322637.30.1756454578938;
        Fri, 29 Aug 2025 01:02:58 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd0e1c0besm1461992a12.24.2025.08.29.01.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:02:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1E9654489F51; Fri, 29 Aug 2025 14:55:28 +0700 (WIB)
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
Subject: [PATCH 12/14] ASoC: doc: Internally link to Writing an ALSA Driver docs
Date: Fri, 29 Aug 2025 14:55:22 +0700
Message-ID: <20250829075524.45635-13-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829075524.45635-1-bagasdotme@gmail.com>
References: <20250829075524.45635-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; i=bagasdotme@gmail.com; h=from:subject; bh=QIAPxg2EoM7XBiBH/OfCd9SfIrsCdhbBl57WJdF7gOo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkbY14FftK8Ic/EqPdDdzlDXfSrtOCCiCo1tq0af6f2T rxS2nS/o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABP5M42RYQe/RHjLfYX8tv8L 9vQt6eKUm/OnRm/3gUlFq/44pi2Xf8HI0BjxjsH0R+yFD+urVrRxaVu1SiT8M9vxwkWu7L/ecZP DfAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

ASoC codec and platform driver docs contain reference to writing ALSA
driver docs, as an external link. Use :doc: directive for the job
instead.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/sound/soc/codec.rst    | 4 ++--
 Documentation/sound/soc/platform.rst | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/sound/soc/codec.rst b/Documentation/sound/soc/codec.rst
index af973c4cac9309..b9d87a4f929b5d 100644
--- a/Documentation/sound/soc/codec.rst
+++ b/Documentation/sound/soc/codec.rst
@@ -131,8 +131,8 @@ The codec driver also supports the following ALSA PCM operations:-
 	int (*prepare)(struct snd_pcm_substream *);
   };
 
-Please refer to the ALSA driver PCM documentation for details.
-https://www.kernel.org/doc/html/latest/sound/kernel-api/writing-an-alsa-driver.html
+Please refer to the :doc:`ALSA driver PCM documentation
+<../kernel-api/writing-an-alsa-driver>` for details.
 
 
 DAPM description
diff --git a/Documentation/sound/soc/platform.rst b/Documentation/sound/soc/platform.rst
index 7036630eaf016c..bd21d0a4dd9b0b 100644
--- a/Documentation/sound/soc/platform.rst
+++ b/Documentation/sound/soc/platform.rst
@@ -45,8 +45,8 @@ snd_soc_component_driver:-
 	...
   };
 
-Please refer to the ALSA driver documentation for details of audio DMA.
-https://www.kernel.org/doc/html/latest/sound/kernel-api/writing-an-alsa-driver.html
+Please refer to the :doc:`ALSA driver documentation
+<../kernel-api/writing-an-alsa-driver>` for details of audio DMA.
 
 An example DMA driver is soc/pxa/pxa2xx-pcm.c
 
-- 
An old man doll... just what I always wanted! - Clara


