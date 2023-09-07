Return-Path: <bpf+bounces-9471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506B8797F0F
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 01:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C02A1C20B64
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 23:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20B614AB8;
	Thu,  7 Sep 2023 23:06:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6314299
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 23:06:08 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A3E1BFC;
	Thu,  7 Sep 2023 16:06:03 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401d10e3e54so15627185e9.2;
        Thu, 07 Sep 2023 16:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694127962; x=1694732762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1A01Vb7M9/CvOvvy/tRz9MhOl+QjbGTZcIw1h515GI=;
        b=mKWtIaKrBaVznTA8yFnY5c71MiCJRUdeFo6YRqHkMbPGnAIuPBg+TbPlQBdOWDcj9A
         apy7GX6GSY7em99Ozk3Lwignh52BosRnsoGXKHCqrIgZFnazVbwpspRYtx2BG0QmF29f
         UXORV0jrNZ4opmGPWACoVtX5cNQfAYma2ztsfyj4YCSDhHO3PrOofDTyvt71ZiDHNMdJ
         rNlXm7w9ygAne5EDj+g8JdGBze+7T+juPCvKw3L60rASlHHuqBdChHMa5QYsCdHjZRCu
         BXChlvfCUmN+RHhyVaQWKtT7aIln+sBMWgRIaloMpAN+6TZChio+o/TLrfDeSfLpm3ev
         fN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694127962; x=1694732762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1A01Vb7M9/CvOvvy/tRz9MhOl+QjbGTZcIw1h515GI=;
        b=RzhnxM1vDTIoJ7VFu1wO0dTx0lhYFCTXd/QYPKzVRvLuo4rTLvOlY1qnVlwHv2AcvO
         MmHnjgPZi1DBf0Pfb+/ZRF962Dl5siLDUfd/UOYkZHeyBNI0FyOGA0FSDAOfeuJrZbOv
         MmPEfMN1MDCSKCFu1V9PNa7U6VhFNJQ+Bci1YjbviDLf6pgfJB7r9ozzOhpyrSqwFHBg
         K7E4F/3ypN8a3UCVeYQV7KXklcBftwBnq8oQVnzyDpIZGCKxtWcZBPaC5TmSEGzPfCyr
         vkfcFg78rmmfh0DHcSHVxAryUamzogq4aGFqMszeSnw+sJ7g4HctATNmPH+PjwmTpIqS
         EBEQ==
X-Gm-Message-State: AOJu0YwTiURgEIJPsju7ZZD5Xnwys+hD8hlCNkxSmLJZqfI/KdTlUzcY
	ZU+o6h3eEOoRHntHxwlCYsM=
X-Google-Smtp-Source: AGHT+IEpV5PqBqA3OEVDFiT2Vm2tbW+TW3MN5AIhRzxdbQ8A3vlFQuu/IE9Jn54Y4o4unYmMHZiyag==
X-Received: by 2002:adf:f709:0:b0:317:69d2:35be with SMTP id r9-20020adff709000000b0031769d235bemr518704wrp.30.1694127962041;
        Thu, 07 Sep 2023 16:06:02 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-3-249-32-32.eu-west-1.compute.amazonaws.com. [3.249.32.32])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d484d000000b0031f3b04e7cdsm491358wrs.109.2023.09.07.16.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 16:06:01 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shubham Bansal <illusionist.neo@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v3 9/9] MAINTAINERS: Add myself for ARM32 BPF JIT maintainer.
Date: Thu,  7 Sep 2023 23:05:50 +0000
Message-Id: <20230907230550.1417590-10-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230907230550.1417590-1-puranjay12@gmail.com>
References: <20230907230550.1417590-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As Shubham has been inactive since 2017, Add myself for ARM32 BPF JIT.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 612d6d1dbf36..c241856819bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3602,9 +3602,10 @@ F:	Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
 F:	drivers/iio/accel/bma400*
 
 BPF JIT for ARM
-M:	Shubham Bansal <illusionist.neo@gmail.com>
+M:	Puranjay Mohan <puranjay12@gmail.com>
+R:	Shubham Bansal <illusionist.neo@gmail.com>
 L:	bpf@vger.kernel.org
-S:	Odd Fixes
+S:	Maintained
 F:	arch/arm/net/
 
 BPF JIT for ARM64
-- 
2.39.2


