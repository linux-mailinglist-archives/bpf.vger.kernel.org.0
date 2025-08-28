Return-Path: <bpf+bounces-66821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9DB39B6C
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 13:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76C53B4E52
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 11:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEAD30DEC4;
	Thu, 28 Aug 2025 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt1kh0yC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE97244691;
	Thu, 28 Aug 2025 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380178; cv=none; b=ZivJeGmrCOM0Jeq3YSaM4BtwWLdaxw/N1JJc6VLt20YI1S2NxgTMwX1+awKwN9rG1GXsnPJmOr/HIZtTbDLWUt13Je7sDT5cDz3MPEDixv/Jmz5FZeqmSqILeIYizzoRa0vngh+ljeN9m7KF3HMSPkNOciT6gOopv7Wlg4tyEW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380178; c=relaxed/simple;
	bh=fvV1/34M0q/gAMQ253l/U84MmKBcsMJLgosMs2oZQgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d/iv61m2I+TkmV3UGbPnvSUt7w3+7WzfeYdAba8KFn5cWOVI9wr4IIPQVNRaeXjmXkCdunDpvcn96vtvtPcXuXzxvMaGw6UNI48TUZKxO3pGKU36xrRMo2+3vvuwCF5/455Maka4GaaFr0SnffQ97nMPjxzmBNdlbqVnmZSnkXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qt1kh0yC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2445824dc27so7139685ad.3;
        Thu, 28 Aug 2025 04:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756380176; x=1756984976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PxeMfx1+uNFbtk5b+iMV6QezPtIYzUJuvmOTjg2DLuM=;
        b=Qt1kh0yC0vw6jItCiCV9czAn4OxUuWnFj4N5JpMiJpbj0sAgDXYu9+mGe9LHRkJgQ2
         lvZgeAvisXSaBFB8tM7pgmQ9knbZrvAs1ypnG0yKEJMa+/GFNvUJGJGpcQBKojNLE43Y
         nofVOyfUHq/piwG50hZBRXhgxVvGSzAYxDTTrRD5oUmaxs6tNcc64V8TU2qYtcDlhNNc
         qz8dL8THwnv9/3rW4mXFPJNUFZTGohLW/tcUISN/WWEazQil38RnyPNnjLKksr/sgrY7
         78QjKisVDqJzF+P9oHKCkGI2uY5IBR/MF5O/z6bqlkE0fDF8B3ESYE7sim7GSMTIxe2R
         I/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756380176; x=1756984976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxeMfx1+uNFbtk5b+iMV6QezPtIYzUJuvmOTjg2DLuM=;
        b=UhrpCDLqTJpaX+ZgWymxslGSr3gR0ni8s/LQ3VeLWsQ4yB05xDeWUAV8HD4/K8VIou
         AX9/ozU0UK/04U7sQX4uu+3pxsZgsTmaJdeoo4VEKj/mpDa2HRkmJoeHQGZjmblpvv2g
         yAUHPtXc3K5+S0zIjdq6kGkiWxZ7+Z3Z7SQ7m5pDDL7Zwv+gatdBEviR0DklS8pNl/Ub
         +W/k6F+fC6nHbkDv/WOjNaJKkwyWExPH+nLwdaFFm98bx1wUmDO4+P3iXwuGGmP5ClXy
         mWKKM0kuoZoeFvzUrPG6/9O2VnVihVnODP+mM3bfw7DQPLs0UPJdG07rJNqRpDujCUvX
         NTug==
X-Forwarded-Encrypted: i=1; AJvYcCVBr6DgtmPWhbHdXj1CTfsfzvvVa7zCOMkysAvIGKps70G1JpgfNQ84fZBFQk18pLfRJRsskyE3@vger.kernel.org, AJvYcCWjwRlTwc6k3+H0LcjOisJarhehSPWbV54Q8Ywso8f5Pwa/TvaDs+rImEa64V3oaMVBQco=@vger.kernel.org, AJvYcCWpp76uyiENM6t509yPUC4nYseUZ6HPpuqVS8qHRrf/tNGJXbG3FSPx2lOTDWswoN+6AwjvMbFQOCq28w==@vger.kernel.org, AJvYcCXvR08hnM5jb73cboeoRv3nPFY2gooM0MZ43wqjSz1tZdD4IAkU8nH6IxHNpRS+TWsGiAjOcbSbrcLx/Jfr@vger.kernel.org
X-Gm-Message-State: AOJu0YxmBuF3KO703f2KJGAixIW9chkaVIDaiUN9kAQhX94s/89Z0By4
	zAJOg+f0i/sJDg7sAlUFbbgrBl93iIRMypC6fPHDQP3Sxibthimb77h8
X-Gm-Gg: ASbGnctIbRq63VKxrki0H2ekp3f9sZWXOkSfjRliJprT2aLr+aJzLLgvKurDXGtIONB
	uEWNkK5Km95fg8FJg8w38c5suHJkt5dzJdYjYCR7PcI/R5teEfo37ZSI2FOTrakuhdfOKZOBarj
	8jKzy8rRZOs/19a6JuJmhgKUHMafqWYNIpnpueG3R9qJSvhfBvcr/04nvxw9JugdPEElxXNAgGH
	c3C0ninF2lxFh2HEcXQzYiR0/+m6wRFiz8B+x66tsC2UV9TDuAilcPd7K2PprsgeC8MZ93efgkA
	0ErCp4R8cTXCH7aTS+WPv3IbwDxTCoeSihffMdJmqZIJJMtn3PMqptDe94Uj4/BVMsluBt4KxVL
	ULx8SUg2o3SOuI0sAHUWAgL01UTTVqUbSVhUOP81kjnsqsxFzbeRRyTWUH0wroIXvTj973noUxM
	kyGr8Ipy/XHA9DbEZgN5wvOQ==
X-Google-Smtp-Source: AGHT+IHQiVu4toyB2lDInXoaA+fupYv0LkXXDoJV5p3MjYWV2/Hw1sV5uJxKSw9UtwpQSAHlRTlqsQ==
X-Received: by 2002:a17:902:fd0e:b0:242:accd:bbe8 with SMTP id d9443c01a7336-2462ef4ca76mr245371675ad.36.1756380175971;
        Thu, 28 Aug 2025 04:22:55 -0700 (PDT)
Received: from localhost.localdomain ([112.97.57.188])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3276f57ab3esm4952547a91.3.2025.08.28.04.22.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Aug 2025 04:22:55 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Joerg Roedel <jroedel@suse.de>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] ACPI/IORT: Fix memory leak in iort_rmr_alloc_sids()
Date: Thu, 28 Aug 2025 19:22:43 +0800
Message-Id: <20250828112243.61460-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If krealloc_array() fails in iort_rmr_alloc_sids(), the function returns
NULL but does not free the original 'sids' allocation. This results in a
memory leak since the caller overwrites the original pointer with the
NULL return value.

Fixes: 491cf4a6735a ("ACPI/IORT: Add support to retrieve IORT RMR reserved regions")
Cc: <stable@vger.kernel.org>
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
This follows the same pattern as the fix in commit 06615967d488
("bpf, verifier: Fix memory leak in array reallocation for stack state").
---
 drivers/acpi/arm64/iort.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 98759d6199d3..65f0f56ad753 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -937,8 +937,10 @@ static u32 *iort_rmr_alloc_sids(u32 *sids, u32 count, u32 id_start,
 
 	new_sids = krealloc_array(sids, count + new_count,
 				  sizeof(*new_sids), GFP_KERNEL);
-	if (!new_sids)
+	if (!new_sids) {
+		kfree(sids);
 		return NULL;
+	}
 
 	for (i = count; i < total_count; i++)
 		new_sids[i] = id_start++;
-- 
2.39.5 (Apple Git-154)


