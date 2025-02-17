Return-Path: <bpf+bounces-51729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6254A3825B
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 12:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B423A894F
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 11:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73185219A66;
	Mon, 17 Feb 2025 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGH0L7hQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86469C2EF;
	Mon, 17 Feb 2025 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793130; cv=none; b=A50gW0pb5UUnMKvdMzny95KHnbbYx732KOJxe6SpaFEdRe75VQ4EtnazAhBkw7Fos3moM70v/90uqUi4Bi68jH9lHLEiMcBN5RSJE07fm+dD0ERHBNl6KYjn/8VvSaSunS2Mse2wR8lCWZuJtJKSy7rT9YXoaSSSDLg2OZmepRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793130; c=relaxed/simple;
	bh=Kw5fJhdscUiWMv2LJOfvfRwT8rtKmlYtNBGe3hviB8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VlLnXzEthmhNC86h6rpB5fTEin9Ox2bkOZXT4BiRbVKyRXPOquRhEonjUCwJPYpa/X4cp0qw1NsPyyV5ZW2zhB8hrDV+FqJp3ZiYtYFMrDydvVRJTQqoG7msLjId/+pBf9J4Owt0unKvFPlVV2cE6aDSM5xUTLkU2755+0yP3UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGH0L7hQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fa8c788c74so849066a91.2;
        Mon, 17 Feb 2025 03:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739793127; x=1740397927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OmSK00H6Xgl6mtiFppglnB1vB4Wc6DbTip45Aa90tU4=;
        b=AGH0L7hQN86/vaqgijUzrakFrF+OnKMcV4qhQznYGm9wPYKiAtASKrCPFzXCsmEzXV
         Dev+o2WqvbkFYsMxU2INYxha1lMGrwHxQuoRGzrzWeub3vaBlGg0eHOI9Lo3kEIdPoAd
         r5oix1s01zwEbGCuIavscE0DIHgduAAg0QWm0d3x27vO8K0D/uQmZhKg3tjbZgxDRLSv
         6dWORb+DCj0Qb+V1rPBr7reg7EIUuWmYN1o1cQ/WWjdg9YfTjU34WO3YyMqwuLQYmScz
         kI8sLCjnk2sSh6gglZoLSMeutr4DPTgmdPG6Sehu0TgKtHeifUK1YHImJXGVU22P0gtf
         z2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739793127; x=1740397927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmSK00H6Xgl6mtiFppglnB1vB4Wc6DbTip45Aa90tU4=;
        b=uCSK3ro7+8ltTZ9z2LFemwBLUX+PqO7/fZV6I9422r+Ei5HX+xc48y4+wcvHm7O8Qm
         DHiWlbza4Lj9bz8iIJOWB+vYF9O0auQUePDZNEArgfrNgSW0VG57Fl3OcFZNGI7ACOPd
         kau8PcxJ3v7Udf1Umqu90G7j3cHSe6skale6TIXtdSjdWtPJm8Fnph9UTnhMZhn+/2SJ
         7J0wx24dEBcUaCepNEucRSbLltsUEhcrH3tiZsnbWj+LYa/yWauaz8mqZTNPlf/zYrkg
         cm80WCxP2ntaXwkoQyADBbkgzM8z4zU313iaiCNCNdMcB5EJ3m/HWXl5wUnd2OeOa/y+
         DtTA==
X-Forwarded-Encrypted: i=1; AJvYcCUKM1JITDssKddt9ElMD8YR1HxyypehkdW4rFfx43LxUbUQGwgVuhZbF3Ry1G5Zfmm1/Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxV5/4FFgz20gbnvAOX6Vz9ShvXwi5JadLNUt7vNg2dZH4daYv
	CiNqTUUdjDg8azNZOyD6PDqcJnZuEOPF5t22FLaM8mABKLHHPHqT1u/XcJ8JI0c=
X-Gm-Gg: ASbGnctVWtAv2fPZyaddgalBaqzeokP9kEOD8el1ySTjBDfJ6NASb7foUK7KQAfwEa5
	YPMDfpIp6OQZMjztcd4NNYu/jd3QXkFk3GtLwKvrPPKqMVkcZ0WhjF74diG89RcGs5nUi4Hpl3d
	ogAT68cfCgnJi0TlX/xuGX4m+OChB7OV0fO9ncKm4rDSfdWry8thpZ/NIR48gcNUnVltOadbFKu
	0G3xDY1J/ktYxuSx1PRmEYpRrHMdisBrCNmL6HnP2k6navE2omFM7aLSNN6f4NlXQ57ehuWUBbP
	wwfGFgE68X4YLksAhrdq
X-Google-Smtp-Source: AGHT+IE8IQDgwXJku33E4AoG0sCymiFSgxVeEQxBNgMT4EYT1oyzstS+HSA0ywbqYD5tyyHS6VR35Q==
X-Received: by 2002:a17:90b:2d85:b0:2f2:a9bd:afe9 with SMTP id 98e67ed59e1d1-2fc40d12e58mr5560254a91.2.1739793127457;
        Mon, 17 Feb 2025 03:52:07 -0800 (PST)
Received: from rock-5b.. ([221.220.131.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13b9145esm7850482a91.33.2025.02.17.03.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 03:52:07 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	bpf@vger.kernel.org
Subject: [PATCH] tools/Makefile: remove pci target
Date: Mon, 17 Feb 2025 19:51:52 +0800
Message-ID: <20250217115159.537920-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e19bde2269ca ("selftests: Move PCI Endpoint tests from tools/pci to
 Kselftests") moves tools/pci directory to
 tools/testing/selftests/pci_endpoint, which will cause build failure
when running "make pci" under tools:

linux/tools$ make pci
  DESCEND pci
make[1]: *** No targets specified and no makefile found.  Stop.
make: *** [Makefile:73: pci] Error 2

This patch updates the top level tools/Makefile to remove reference to
building, installing and cleaning pci components.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Fixes: e19bde2269ca ("selftests: Move PCI Endpoint tests from tools/pci to Kselftests")
---

 tools/Makefile | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 278d24723b74..5e1254eb66de 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -25,7 +25,6 @@ help:
 	@echo '  leds                   - LEDs  tools'
 	@echo '  nolibc                 - nolibc headers testing and installation'
 	@echo '  objtool                - an ELF object analysis tool'
-	@echo '  pci                    - PCI tools'
 	@echo '  perf                   - Linux performance measurement and analysis tool'
 	@echo '  selftests              - various kernel selftests'
 	@echo '  sched_ext              - sched_ext example schedulers'
@@ -69,7 +68,7 @@ acpi: FORCE
 cpupower: FORCE
 	$(call descend,power/$@)
 
-counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi pci firmware debugging tracing: FORCE
+counter firewire hv guest bootconfig spi usb virtio mm bpf iio gpio objtool leds wmi firmware debugging tracing: FORCE
 	$(call descend,$@)
 
 bpf/%: FORCE
@@ -123,7 +122,7 @@ all: acpi counter cpupower gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio mm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
-		pci debugging tracing thermal thermometer thermal-engine
+		debugging tracing thermal thermometer thermal-engine
 
 acpi_install:
 	$(call descend,power/$(@:_install=),install)
@@ -131,7 +130,7 @@ acpi_install:
 cpupower_install:
 	$(call descend,power/$(@:_install=),install)
 
-counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install pci_install debugging_install tracing_install:
+counter_install firewire_install gpio_install hv_install iio_install perf_install bootconfig_install spi_install usb_install virtio_install mm_install bpf_install objtool_install wmi_install debugging_install tracing_install:
 	$(call descend,$(@:_install=),install)
 
 selftests_install:
@@ -163,7 +162,7 @@ install: acpi_install counter_install cpupower_install gpio_install \
 		perf_install selftests_install turbostat_install usb_install \
 		virtio_install mm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
-		wmi_install pci_install debugging_install intel-speed-select_install \
+		wmi_install debugging_install intel-speed-select_install \
 		tracing_install thermometer_install thermal-engine_install
 
 acpi_clean:
@@ -172,7 +171,7 @@ acpi_clean:
 cpupower_clean:
 	$(call descend,power/cpupower,clean)
 
-counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean pci_clean firmware_clean debugging_clean tracing_clean:
+counter_clean hv_clean firewire_clean bootconfig_clean spi_clean usb_clean virtio_clean mm_clean wmi_clean bpf_clean iio_clean gpio_clean objtool_clean leds_clean firmware_clean debugging_clean tracing_clean:
 	$(call descend,$(@:_clean=),clean)
 
 libapi_clean:
@@ -219,7 +218,7 @@ clean: acpi_clean counter_clean cpupower_clean hv_clean firewire_clean \
 		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
 		mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
-		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
+		gpio_clean objtool_clean leds_clean wmi_clean firmware_clean debugging_clean \
 		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermal-engine_clean \
 		sched_ext_clean
 
-- 
2.43.0


