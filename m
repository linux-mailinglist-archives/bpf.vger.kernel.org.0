Return-Path: <bpf+bounces-75222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2A6C778B5
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 07:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D3B14EB682
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 06:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBF82FFFB1;
	Fri, 21 Nov 2025 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGW1sMYH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF110238171
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763705705; cv=none; b=gPfyVG57CY/mNjleZyVGSwgLn0GGAx2IxQLqLAf2+g5G83q+ebpcIWgX79si4/z/PpvlhcpLraLkhqkjctjBsSc01Eemb10lEIziTyZlicbZeY2dvXlfNqmx+MgejBtWxJCMmHljthdpwvKxdFT3cpHhJIPoJOkmIa92ICFoXTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763705705; c=relaxed/simple;
	bh=J6yts0692oNbckDHoLvXs4DMBmIkVVG792DZoIpyafk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9hdE0ntvox9Rca5cOv1bKpc7PbON2WdGhSaEyhgScfLWP08+JXDapxxUpcnkHFzSuYNdKbM2+pyX2C050XaC+nds+Z1JWHsqigPR6wI9jcSCdkk+OVywSl7e0rFRcFSxAmEPxuA315v2LNYtbh7d2BKG/wr3Bse5nFhqDmBenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGW1sMYH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2953ad5517dso21653295ad.0
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 22:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763705703; x=1764310503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J++f67xZUroNSU3sM+QK10kr9uNblSA2E0GGy7o7wA8=;
        b=dGW1sMYH94IcTH09MTQYbRNCZcHfevXNz9a8A7hCXZejcuXqEnpLJQCfOTlsivRzZH
         WV/FaNq3Wx0IHOd8DVbW1FWAqZQ80L6ONMr1zXyjEl1E1D0NCNzgjhxDIyV/OjVv3QEl
         FEpKTG4nSYM+HpCgfjUX2lMSTAyicWGSRFO7UwR97cWzo6XBuldNpF2PW2suvDeAq+qo
         V2U19aU8gwg/+xfxTlal4MhXIl49vOzwxCZnwtrKxAQ8f/bOihWUDA9kbtb2trOvuzQh
         3bw5MPsTOldsfOhVK2McX8exs06fOMawy+XVphNDJUsJt/NaD7szi/oJspgZsW5n3QUG
         5BOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763705703; x=1764310503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J++f67xZUroNSU3sM+QK10kr9uNblSA2E0GGy7o7wA8=;
        b=BvgQk7JFI8YFEzjPqBqZdsH9GYLk8bkQbe2BMLz/DJ4DxwVpmF/wxgOVw+MlW7Uryy
         QElyZOGB0tPBj/lDPk6b+Hkjms56ya1HIMI6C6kUkjY59n7WKy6c6YV276wW7qjeDW63
         rWvYLHEeyL21yFxCLnc5633MDr8jI40JaZ9cP0qyEIFsBj5XXrG/CuyrQJ8OtOO4Xg1Q
         luSoYb+5MAyRxhcvJ9uqYMXJaGe5bFsfxsp2pRnVn8b+TmNzrsrjWWlY6aQv8Y9PSM+/
         6Dngoqo2/pnYMetLBPTsQfPXfBbZGI+o6MarZ5bkv4HG2SURKhFWYhXrdjNBhDe0iAam
         FgQQ==
X-Gm-Message-State: AOJu0YzVYP3ZBaKwTJslRQwCgL/t60z9lHhqceVbARPud6avkxh7g+Cz
	QlM5yucvC+kqu2So/5t8oMgjFaaKwngUSsc/tQ5wIDPhaXGuZXI2VxmAUoIvlmQNwBw=
X-Gm-Gg: ASbGncsk1hPHgnEWEKLfpMT4Jefd8CXOXC0c9TU03gROcD26eYL2ZH/DIJEHyWoAZ6H
	lSd8rHOiUKGiCVN9Pg9GLtCaqfBgf5R2GVSmZM0Kn9QjSKJsTEaaIZhe5bPBFt+AorS/aAg3ccv
	BJP5srLjgtPuCLouqkUduS6Z1itp6Wt786DwuJGu6OAFUTdYgsigFVXBAF7ZOvV2EQClfJ2o3j1
	dcbrtcsKstQmnrOc8y4oz2uEDlSCKKvUpWDTWtIPjT/4h9q9wsNOiUplB3ljQ1oZmmXJoQ0N9fm
	d0TMd9J/TRsi42weZkjFuYJ22t79TXbQl7ifaX3u9+spB2P0xAEsQzXAMpxSbk7zqGGvYqhJjAN
	pXWEoTzAGJs0mUgNCSRPOpjK8VlPwT+zlzQjI93Aj8j4JLm/B7v5SgYlidWZWeAPenH+VLQLUVo
	gvtPFgX5fehQiT2WJzpxtbu/GsBYkswwN6EKFi8HlBOBkncwswqQ==
X-Google-Smtp-Source: AGHT+IGNCWomOCLHFwn5qGPrBhCRdd2z+rGyb+/IFjbvf5UbLDSOe/YqRxvRuvSTizY0g3yfCUjWPQ==
X-Received: by 2002:a17:903:1aec:b0:297:e252:9e50 with SMTP id d9443c01a7336-29b6bf5daffmr16162625ad.42.1763705702714;
        Thu, 20 Nov 2025 22:15:02 -0800 (PST)
Received: from laptop.dhcp.broadcom.net ([192.19.38.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2ae1c3sm45561315ad.92.2025.11.20.22.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 22:15:02 -0800 (PST)
From: Xing Guo <higuoxing@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	kpsingh@kernel.org
Subject: [PATCH bpf v1] selftests: test_tag: prog_tag is calculated using SHA256.
Date: Fri, 21 Nov 2025 14:14:58 +0800
Message-ID: <20251121061458.3145167-1-higuoxing@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 603b44162325 ("bpf: Update the bpf_prog_calc_tag to use SHA256")
changed digest of prog_tag to SHA256 but forgot to update tests
correspondingly.  This patch helps fix it.

Fixes: 603b44162325 ("bpf: Update the bpf_prog_calc_tag to use SHA256")
Signed-off-by: Xing Guo <higuoxing@gmail.com>
---
 tools/testing/selftests/bpf/test_tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_tag.c b/tools/testing/selftests/bpf/test_tag.c
index 5546b05a0486..f1300047c1e0 100644
--- a/tools/testing/selftests/bpf/test_tag.c
+++ b/tools/testing/selftests/bpf/test_tag.c
@@ -116,7 +116,7 @@ static void tag_from_alg(int insns, uint8_t *tag, uint32_t len)
 	static const struct sockaddr_alg alg = {
 		.salg_family	= AF_ALG,
 		.salg_type	= "hash",
-		.salg_name	= "sha1",
+		.salg_name	= "sha256",
 	};
 	int fd_base, fd_alg, ret;
 	ssize_t size;
-- 
2.51.2


