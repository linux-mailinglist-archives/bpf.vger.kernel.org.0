Return-Path: <bpf+bounces-21861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C78D8536FF
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 18:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CB128AEF4
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 17:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C872D5FDA5;
	Tue, 13 Feb 2024 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o83cGvMC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5DCBA57
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844572; cv=none; b=Lgctq2kes4jO2Ij9ebyk9FJk+vPsRcojXnvZZZWhy1gQ9JhRfAeVnpR5IQLRZ7dXtRgA8poj7qbRwo66Ueh5mFFHtNxCfaag3YcsnPjk498Zg5KV6krE0WmdQf+AfrEeZAoIbuXzu9vJxsnC+vBElkGRNgoEkxQJ6N6R5UT8ttU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844572; c=relaxed/simple;
	bh=/UBP5Bgl0lriW1Ky66IaK0R3AQfwAosYcss0lNTQqJk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BGH2GGlVbjAlXKfr+Kvujz2B0GAvxZzx/9gQBkmz+sI4YU7IATRLk38/OCjHHZwQeCC+r5pwGlEAkHeYKeSeCoSDI9USyb89vOIqefjsCWa9HTGkVOzScAUGrSqd98/yH687TMn3HOKFA8YhNQDkVqOoGLn5Bh8uUibonsyd7M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o83cGvMC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56001d49cc5so5752960a12.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 09:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707844568; x=1708449368; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2g42OX8LE/JfSmVUSLVPuGyo5+u8nLAvsmtTkHdz0hQ=;
        b=o83cGvMCSxX5v2bMIy5lujBJu38/p5pk2Lt8zjQy12cnz8PBnobaepSR0r/AW5+mKb
         JNRxCodAL3ubVeX1RF6XTrW+SyQhyElUFT/B7lR9gGv7JtRKQrXcFaV0uMDjFr+VG9DI
         tLGU1ghbZJIL/34ZtQtxje+MpdPq7WPkk6GoOcvdpyLHLghnhi/oj7PFLMBS05Pj77B3
         PetTCEPQDG6JNNMc3nqt5wRPZvIaFTFK2xdbXQHTcE1PZc9GxFfktmF/Feiw+xk/wHpt
         0k0CAnvlF7HkLVHcTMs9i/ceV5LiVw4Ln2b3So5jbK0I0iGJQqODCv6H0P642z0cPa0q
         2l4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844568; x=1708449368;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2g42OX8LE/JfSmVUSLVPuGyo5+u8nLAvsmtTkHdz0hQ=;
        b=H99EuiOfa5Iw5HJYSMmtSmDIRLZ2oXrlW9IEz1qIX3VYX++8XJigcVm5RukCskm11Y
         bNbP+LZrcfOB0fdNP3KhsMovcc0AGc10CaQmjPprKWKPuuvQHcgp17ZtHS6+xmKDc+AG
         b+WzRFVwVRTfxDxBtvpUo24Fg1l0kx7EcrE3gvXhAn9cSY+Sws5nmc48q8Sm5rDNh7W/
         uoOh5pQGlRYaJ+jKAZjLCSuFn8nfH7sQopjczWV4B0Ml4h0Iaa09cqNoyGCkwsFLrpRc
         UnsHN0tFwtylUbqOB5JLz6lE18HS8yaITP71itiOPOG5m4FMAR9WZ/BkmHUpzMZ55W9S
         mTdw==
X-Gm-Message-State: AOJu0YyhrvxIQ3HfLLusIV3a1LVKM3yiBycwf1IJoLsGSJ0mqy9c8NYP
	IEsvqZrvLoY23cIb+DU9BxxM8bDWzepgJmYepcFcoEUNWEr2rp9eDnxG+qjIHJ7XeD1grqS72vD
	XOA==
X-Google-Smtp-Source: AGHT+IEiVytkpsST1tzc/r+LDejhx0NHtnVDef/R8Elrcz+PvGfta8idXcBdG5ma3JeGO/TM5ZiTlw==
X-Received: by 2002:a05:6402:6c7:b0:55e:ef54:a4dc with SMTP id n7-20020a05640206c700b0055eef54a4dcmr212340edy.23.1707844568182;
        Tue, 13 Feb 2024 09:16:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVf8lTsBZPqXvoxd/HMTbjXTYjaZ/kyPlUdOIQVwvHFFv9m/HsHIMagTCrsGdsxlrf2jrd+zLhMaNW9VVLQNeVNJw==
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id q26-20020a056402041a00b00562149c7bf4sm167849edv.48.2024.02.13.09.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:16:07 -0800 (PST)
Date: Tue, 13 Feb 2024 17:16:03 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org
Subject: [PATCH bpf-next] libbpf: make remark about zero-initializing
 bpf_*_info structs
Message-ID: <Zcuj0zHhFMML8-mU@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In some situations, if you fail to zero-initialize the bpf_*_info
buffer supplied to the set of LIBBPF helpers
bpf_{prog,map,btf,link}_get_info_by_fd(), you can expect the helper to
return an error. This can possibly leave people in a situation where
they're scratching their heads for an unnnecessary amount of
time. Make an explicit remark about the requirement of
zero-initializing the supplied bpf_*_info buffers for the respective
LIBBPF helpers to prevent exactly this situation.

Internally, LIBBPF helpers bpf_{prog,map,btf,link}_get_info_by_fd()
call into bpf_obj_get_info_by_fd() where the bpf(2)
BPF_OBJ_GET_INFO_BY_FD command is used. This specific command is
effectively backed by restrictions enforced by the
bpf_check_uarg_tail_zero() helper. This function ensures that if the
size of the supplied bpf_*_info is larger than what the kernel can
handle, trailing bits are zeroed. This can be a problem when compiling
against UAPI headers that don't necessarily match the sizes of the
same underlying bpf_*_info types known to the kernel.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 src/bpf.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/src/bpf.h b/src/bpf.h
index f866e98..568bcb3 100644
--- a/src/bpf.h
+++ b/src/bpf.h
@@ -500,7 +500,10 @@ LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
  * program corresponding to *prog_fd*.
  *
  * Populates up to *info_len* bytes of *info* and updates *info_len* with the
- * actual number of bytes written to *info*.
+ * actual number of bytes written to *info*. Note that *info* should be
+ * zero-initialized before calling into this helper. Failing to zero-initialize
+ * *info* under certain circumstances can result in this helper returning an
+ * error.
  *
  * @param prog_fd BPF program file descriptor
  * @param info pointer to **struct bpf_prog_info** that will be populated with
@@ -517,7 +520,10 @@ LIBBPF_API int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info,
  * map corresponding to *map_fd*.
  *
  * Populates up to *info_len* bytes of *info* and updates *info_len* with the
- * actual number of bytes written to *info*.
+ * actual number of bytes written to *info*. Note that *info* should be
+ * zero-initialized before calling into this helper. Failing to zero-initialize
+ * *info* under certain circumstances can result in this helper returning an
+ * error.
  *
  * @param map_fd BPF map file descriptor
  * @param info pointer to **struct bpf_map_info** that will be populated with
@@ -534,7 +540,10 @@ LIBBPF_API int bpf_map_get_info_by_fd(int map_fd, struct bpf_map_info *info, __u
  * BTF object corresponding to *btf_fd*.
  *
  * Populates up to *info_len* bytes of *info* and updates *info_len* with the
- * actual number of bytes written to *info*.
+ * actual number of bytes written to *info*. Note that *info* should be
+ * zero-initialized before calling into this helper. Failing to zero-initialize
+ * *info* under certain circumstances can result in this helper returning an
+ * error.
  *
  * @param btf_fd BTF object file descriptor
  * @param info pointer to **struct bpf_btf_info** that will be populated with
@@ -551,7 +560,10 @@ LIBBPF_API int bpf_btf_get_info_by_fd(int btf_fd, struct bpf_btf_info *info, __u
  * link corresponding to *link_fd*.
  *
  * Populates up to *info_len* bytes of *info* and updates *info_len* with the
- * actual number of bytes written to *info*.
+ * actual number of bytes written to *info*. Note that *info* should be
+ * zero-initialized before calling into this helper. Failing to zero-initialize
+ * *info* under certain circumstances can result in this helper returning an
+ * error.
  *
  * @param link_fd BPF link file descriptor
  * @param info pointer to **struct bpf_link_info** that will be populated with
-- 
2.43.0.687.g38aa6559b0-goog

/M

