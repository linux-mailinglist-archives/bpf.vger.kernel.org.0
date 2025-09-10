Return-Path: <bpf+bounces-67964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0918EB50B6E
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 04:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3917B3AE503
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 02:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A2325CC69;
	Wed, 10 Sep 2025 02:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ldw5SZ4g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58582561A7;
	Wed, 10 Sep 2025 02:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472242; cv=none; b=iDTtACKHIrA9ZHxFfOdwH8VyBtnZfSD9IUsHE5pDSnYmpHmBhITHmeXNBZx2hMYrGr7CFBpRmtX1LsjHkLUqPwvBa71DCeYe59/CM5ElNWooIE1EWymP6KDof85CzCHR9lvGs+U6pS4GdiuCt0MK8+FFTRUYQc6DdOX55Kf5LH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472242; c=relaxed/simple;
	bh=7QXrNRuCbHeHgCYdGUN3dSXlo+bJ6ZwXyeTt5Kf+8Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vd3nIjt4plooO10H+xx8sxtz5vS6AEt8eOACgfwtwMCjfU6VFJVpfTAKsTNRvYWuvorfi6jV45XUw3j6bFLXQgsYQO/LePieUE47RllaxyrG2o1VQomyCrLvYjXYxDaUsiGfw3tYIVhVgXtTmcE6+KFexO3srZZqQOhqNwIqnAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ldw5SZ4g; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77269d19280so5796887b3a.3;
        Tue, 09 Sep 2025 19:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472240; x=1758077040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exY9byyl4etH+4IQEKnm6qXO5lYPceGxvCuurSN7fh0=;
        b=Ldw5SZ4gXJFn2g6UfqJc6MBkftXHELR76cugzw8BHgaiet5kOrpGMIYSIbpTEG1GMA
         om5CjFT1Mrha/JUemSERtLuCa1SguTjuhuxktK5y8To0TZ2EyLSaYdehk5T4rcFclfm5
         jNaMpHuzRbodbvUumV5YSqQMoYRTA3vIPS3VloLXGorx1zfCKqECGcHd/aRr+KXP8ZqF
         mOxZa1rwR5+pgRp9NrtG7Mq49K07n9Dt0vUgCbSWQdcOg40RwmM8fhID4EgmLwJYNarz
         buNE/tdv1+yrs/G/Oj289gD034V6vkIaTJpxgYRihvPOk+12rD8I5+g1hL3kDM4s74O+
         Umew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472240; x=1758077040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exY9byyl4etH+4IQEKnm6qXO5lYPceGxvCuurSN7fh0=;
        b=KYY1cILgbodxKeWc9Am8SHtWDdGrRUNxsig7H9fnxJZL5gYchN1bigkLCKmKjqgXyt
         i2DVg8t5uCw3wIif/Xg+darGBgEGWkXRvpq6ZKAx10TssJqsPnbiAr9mZtbFxhSdTxMn
         BsbGHn0QM6HFt5pZ/B1m+9N991v6sh/5HSwGV+rEJkLBJF1KWy1ATsvPh13s19JodyQS
         N+RrESXJ24Z+4CGxHVLefiSL61+vNGC0vR9CP5Xv8oI2boQBu2ouf2rSSzTns/QEvJfK
         LjfzxUfTUfd50j+0KkWkCkAiSlK8QF18g33n6dzecsKKottxxhHSqrcoUnlCi63h2J6C
         yA6A==
X-Forwarded-Encrypted: i=1; AJvYcCU1i+jp4SjAtR76GVmzIiK+V7dVgnp51V94qJO3H5s9UZ7EIckDu/gBymHnI3XA7k2Z9sofNOAh7Sjk@vger.kernel.org, AJvYcCU8l1RmIRbR0qsjuM5DZEphvB6rvwgAT11U7syJksCC2Aq/1j76ABji3B1zUtEHUIbeob/YLrKofXM=@vger.kernel.org, AJvYcCWCGvqvHKKmd/bm5FxMWicAjQMzLdh6XS+yIUwJTJ6CocFI9pCtKIbqxpaPb+3T2/9ZORWIFQ5vt8seBto=@vger.kernel.org, AJvYcCWj2tHQMrbcVTRL2EeNGF2JZTigy2i4Ct5GWPZxDRXXEam+u38/1Or0rX2Wk3tb6wHEwb0=@vger.kernel.org, AJvYcCWvTLUiBpN+Urlh9w/ub/vaOjIjT5q+pbbUFaQPgRvsF4N6iRx7YcTnfJxiSfPaWhYBgresAFLAdZ81i+Y=@vger.kernel.org, AJvYcCWw753DhYr0pVRlS+nRgYxBjbYeTatA7bJRwXxOexHA2NUyOZdGU56tRhZI2BWPSoYED9Az/Gj6kWjO@vger.kernel.org, AJvYcCXjflWXr5KYxoAfOfu9/vkaznnSDDK7sa4QO69ZwKHhV4F9tesZAduaRD/WxqWjmqf0HSCbi92FTWsN2Q==@vger.kernel.org, AJvYcCXoqx6SuVDFwPNHFc9XNanDnQNu52D9vjl2SgfULYYpC9i4i0V8tAEnoYdFtIytTj33kytaFisD6dRqKmQZ@vger.kernel.org, AJvYcCXxHJcCcphDtKMasklSdmIqXHw2kIDnQASikfotI3ChdTnD5w6iNUkg25nh4P7DVEjkzs4m2r4q@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGp+rkuaNbF+WU9eyQHneBaDqV8SlXZGRXtjpdJy2j/UMOCXA
	7E29+59jdCKJBedhMqMG08yXvcL5Jkv5oZi1TSYHhQi/mBe3Bh1fdthe
X-Gm-Gg: ASbGncsrBQ7Wdplb2LTNNIYnDRge4bGapAK+oUcPmFHiNWgcJKjJvZ7gvA1EVGOwkBh
	7SMbnYUeuo3BKHmJWH8bBxXpQvdo7GpGhZTNJTsHPMdzSxpqHl44+xY2k80z2lZJu8SNTzgKF8O
	QqzsyYnIxyjMjFVoQFzbMedQvqCflMuvQK1ul8Mjb2x1nfzYta50dU+Rh2s3qfiRaXwzIsAMtc8
	CLuXsU67PzEiQ93OF+a8+bOPGuikPTzkAEY5HuLPwEcYt/AuBwJDzT8m2IrPrT73HLGEa6E3oqs
	+T/qH4Zg5OWDmDIk3qM6m1lBCa279XNcwuwFQTSjG+ISzB2OzI6jDv/yO/WW966JslM2ktgSE9D
	012AGcl3IhbYjQ44a+L8Z2D09TyZCtBUmfXKn9AITnKQeByo=
X-Google-Smtp-Source: AGHT+IF4N06fuW1A2YnqT9YeYfBmdnDVAaiP1zDRDWLaUsyjpra5p/f/1OQFfNYpt7LKVATNwvRwQw==
X-Received: by 2002:a05:6a21:33a6:b0:252:fbd4:630c with SMTP id adf61e73a8af0-253466f83c8mr21797369637.52.1757472239935;
        Tue, 09 Sep 2025 19:43:59 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a602e14sm1057772a12.21.2025.09.09.19.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:43:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 614CF41F3D7B; Wed, 10 Sep 2025 09:43:52 +0700 (WIB)
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
Subject: [PATCH v2 05/13] Documentation: blk-mq: Convert block layer docs external links
Date: Wed, 10 Sep 2025 09:43:20 +0700
Message-ID: <20250910024328.17911-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910024328.17911-1-bagasdotme@gmail.com>
References: <20250910024328.17911-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2751; i=bagasdotme@gmail.com; h=from:subject; bh=7QXrNRuCbHeHgCYdGUN3dSXlo+bJ6ZwXyeTt5Kf+8Ys=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHnijp3TFftH6q+kyOiIzsCLYVR/ZOd/GUnnS+Yu6/k 6t6/fl6OkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRydwM/yu/ZhfqF9YvP7NL t0p2f917xpei8yqP3w+TKtx3xMg27gbDX5mQVefmZ+9qe6G15Ils7rRL855MXJGSeHOCjN6Gx61 PyrkA
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


