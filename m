Return-Path: <bpf+bounces-55650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6FBA8418E
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 13:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8027C4A86D3
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 11:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D580F218E92;
	Thu, 10 Apr 2025 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3kuW3dx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC71DDC0F
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283803; cv=none; b=AKEVEATFKS1y+RSp+tbRSvuUjP/3dZYQnNb6pvN56wbg78Tw6cyf0pglfaKqlnu3zUYDvy3Vog+ACBkemwgnXx8+aTUGDYb/g7GYS5xZLegdGTttxSZDJxMoBtbfsAccNI8BrgqPB/yBM5oe4z31hNsIr/eSAhGkyP7xZYXd8nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283803; c=relaxed/simple;
	bh=emrE38hgqo1I949fJm30xJrUVAxuRK2QUgHDqoDJzrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kno50zscEICjkqbCWBBbcvGagFwHwIbq8c9gQDokdQyITyF8wAsFDFgNWwia99kfnSePTqiKgE8M+Nj1MfXZcPVngzr36IqlnhH+1oJsNWpUY3GZcgySFw9o/8vbOi7WzLwdak8riwkX0Dd5uSfPJ7iNXe0yk0tlYBZWYY+bs8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3kuW3dx; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so535577f8f.1
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 04:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744283799; x=1744888599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y8PAu/CPNBDcnAhm6FdrYj8C9iV98aABtM/f0IPfvlU=;
        b=S3kuW3dxxSSH3dRK2pZ5OAGmlfIyOHIA3By3AfG7sXiC8luixjA2CEWQeNSgk233+j
         1Sm51QalGmvzhTi322TNPo5dNEwnpM1KFjdn6dFM/YjZiVoEt9ZXCEiVgfrLCntb3Tv5
         yQlYtQHXFbQNhJS+/tYFp2mLKFaftNaH07u6ct5fMPOFXddhfoJpIyFSwulRzYN4rlAu
         rlyYBcvfTXoPAkv7GfJ3SKI/fA0GMtd8YEkch9XzyOm813oIXPgHwsA6bTeYUQf1hm/3
         MCU81z4NXC58WD7qzty9TE240ceOVmqHI/xEk/nq2Yra5gngsvWOhnEhZHogPndG6tUK
         TmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744283799; x=1744888599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8PAu/CPNBDcnAhm6FdrYj8C9iV98aABtM/f0IPfvlU=;
        b=BpR+zqCQn/FNTe+P24Y5pfljEQQ/9iQHXwuoi3jvGmNW5Ee0OSsq5z9FbtREHu6ePO
         wiDN3tA6OfwF86PXabMfTR2r4m9A1ZKS2URDAOsDt0GkFVGDVkXwQoKiYnh3vCnVSujg
         Y5YEWWOidcSZStL/26OahNSdSoCRyxAerOtbdl0Bxsrt8/iCeRhh/KiHCoI0dCld/P4b
         o6qoFlgFr8Lnvps/Xh5l/1qKFaE9iRJV35xZevIa3UlGW/qOIE9Q7mrk0hmXr/HsuFA5
         1a3fN1xx5gNkEpDglZVCvvMYHWlM60RazZw1Yl3CWUVpLRTXrk9UI0jR2R3SRLwtPgiC
         qQJg==
X-Gm-Message-State: AOJu0Yw/czp7lCcTs91S/XI6bbxrQRsBcGBm8WmqMifhTvEjjbixU/tE
	iCCutaL11tVGi6zUM1DZVQRbBWG3SasrCtEpvZctAkxZaiMabesoREZ4IaN3RTk=
X-Gm-Gg: ASbGnctf/pc2tlH5dDmKIpynOmZf1r92D7FoLClbsC44Igb671oP/cRZS1cHBNe1Tqs
	LvCOet8s55ldTj8TOJMZN6GYR2jdP1mi3DHeO6Q4ar5yNzyrnQiFLsIEQhDZWrwAMqgW1qjeVfg
	o5oSSG+YIBP1KvnNQ8iDn9TtS42z04GBjofcuJLUJArioVJGHSDPmrCAqkMeLx+xwckQYHy3Mjs
	x6QkLjvS/94wROgfDKU9qKmlhT3/uOxbG1SdbNRsJVQze3/4U6anqVeRl1s8rldOQiWonW4eq2O
	8evdD67ygC7xesu6Zy7Hs0AY09IDBj0=
X-Google-Smtp-Source: AGHT+IHnLRxPQgx8nRZKwZVyvrKZI9ohz6IaK6Otr1MlggouSailkc6o6fGdNGBKn8LM9a4nLmSc6Q==
X-Received: by 2002:a05:6000:2cd:b0:39c:e0e:bb46 with SMTP id ffacd0b85a97d-39d8f272025mr1889094f8f.4.1744283798497;
        Thu, 10 Apr 2025 04:16:38 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:41::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893fdf84sm4382381f8f.86.2025.04.10.04.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 04:16:37 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1] selftests/bpf: Make res_spin_lock AA test condition stronger
Date: Thu, 10 Apr 2025 04:16:37 -0700
Message-ID: <20250410111637.467198-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; h=from:subject; bh=VlEocgSzT8vkHq+mz0y8C3kC6mkQvpqjdGahGe8Aqhc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn96gkGa6SGBkbx42wCqO+ouIXrekAMVXBmEcA1EZU 56Ry6FmJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ/eoJAAKCRBM4MiGSL8RyseQD/ wP6yzbWUU5sTuIfMXJb4IILr82FjyzjLKKbNtE/+CqRB3VLEbVRl+TFr4sdYvlOllYleejPr6jL9kr rteRCXrQQeQien4Poi9DgaX6MNEN958+bAW6xi8hCG0Bk7JVZTDm/ehHOLG7SN28NR5j4c6W/PykUj 4EZgZudVKNXIz2lRKmlkqz8vtpaxdgrWZHzvFEP7zYw8V9aPpO4PNpHe9phq5VX/e/4LHdRIR+c138 7Zu6azL6WvPltfo1UwUqHHBnyWB48tgCk43+hSb24hp59sY6cC8m1kJYOX+rCgoj+RIHuOvnqn2EIk fMSPeCtqCBSgY7qqe560PbWDuco0NtdO7ejZ+WMsKuyGg0CiSEjewts5KlFw9enbQ8vwWl+15bmED+ RFi+sj1c78jg+cRyW8TkyAGpwuoPz4+LXpnHITNNxrNn027qRX55USAjrwMiDqjoPj+0WC3UL0vEoG hWWlmEDJvmm6dY4kpZRvK8hk9cyGEsvBCBkERbYc1VThJP0xn2J7M+VP5XwX5GrqfV274p1G50N6dF Q6ffTZQZ/ISSbLSY1+ysB4jipaNhM/6or6xjVwZ8eqCbuf3KVHrT9jZm91kq4YK8bH9fReTWXjveLb 6luDblL46w6cspmozgWKC82pwVFbB8B83m2ucy7DRun94EXmlxtgx900uXUQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Let's make sure that we see a EDEADLK and ETIMEDOUT whenever checking
for the AA tests (in case of simple AA and AA after exhausting 31
entries).

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/res_spin_lock.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/res_spin_lock.c b/tools/testing/selftests/bpf/progs/res_spin_lock.c
index b33385dfbd35..d937780f6a8d 100644
--- a/tools/testing/selftests/bpf/progs/res_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/res_spin_lock.c
@@ -38,13 +38,13 @@ int res_spin_lock_test(struct __sk_buff *ctx)
 	r = bpf_res_spin_lock(&elem1->lock);
 	if (r)
 		return r;
-	if (!bpf_res_spin_lock(&elem2->lock)) {
+	if (!(r = bpf_res_spin_lock(&elem2->lock))) {
 		bpf_res_spin_unlock(&elem2->lock);
 		bpf_res_spin_unlock(&elem1->lock);
 		return -1;
 	}
 	bpf_res_spin_unlock(&elem1->lock);
-	return 0;
+	return r != -EDEADLK;
 }

 SEC("tc")
@@ -124,12 +124,14 @@ int res_spin_lock_test_held_lock_max(struct __sk_buff *ctx)
 	/* Trigger AA, after exhausting entries in the held lock table. This
 	 * time, only the timeout can save us, as AA detection won't succeed.
 	 */
-	if (!bpf_res_spin_lock(locks[34])) {
+	if (!(ret = bpf_res_spin_lock(locks[34]))) {
 		bpf_res_spin_unlock(locks[34]);
 		ret = 1;
 		goto end;
 	}

+	ret = ret != -ETIMEDOUT ? 2 : 0;
+
 end:
 	for (i = i - 1; i >= 0; i--)
 		bpf_res_spin_unlock(locks[i]);
--
2.47.1


