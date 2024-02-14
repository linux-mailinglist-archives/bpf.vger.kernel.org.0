Return-Path: <bpf+bounces-21957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03742854370
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 08:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C701F23330
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 07:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D871170A;
	Wed, 14 Feb 2024 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YeTFCOno"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FA3111B0
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707895840; cv=none; b=Xjxcfo9SwXiacAaD78OukPBm6u4MY6s0iiV4oHeiWkexqbKPZ5MakqTxvStV6Le5zgPzXn5I5OavC8FvsF4yiFZ1NGmjnLLvl0TobKib5FojvPdW1w+Z1+nN0xuQCpaADxfHvqXZ2sv9gP5pm1AdhHhYlQSD1q+A8D50ZD/06X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707895840; c=relaxed/simple;
	bh=smiX0ItpScvLWLagCPbFZRb3015+Sv+brv71zQCZBPY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FcXHTD60zCcCurTMOwDJTR1g/OOR84EQn/Fna3nNPElncCS561XgVYPQ2AbjzhigGmDIonBPFjbj/oWX1nRV5YblQsRH9EESLfgRv3FAJP/aZMRURrXCMoz/F/Kl9s+/2KPVMoaPCTJSvCUQoCzxVDqxT87CCRolFaZeT3bux1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YeTFCOno; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so702220166b.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 23:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707895835; x=1708500635; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNBP4KUPyi6Dyl5CVorOkklp5uNvIjutICMBUaGJ8gQ=;
        b=YeTFCOnorSfuUDz3R0joQXN56qyBeALZy7UQAXE/mOn6Qqz7H7xLEOQd4NODxyX8Db
         OO79PkOY9JgsLeutLGE/Q/vHIckxI526qwq/sbxSzr+vXGlDHkY7Hk9eIwf5xOwBlLHk
         ID+7kRDRV6BLOsKfgjvqbBuMJxXwftYHzYUR2kzablv5mfpI8jb32SaG4wGjTdexAhXp
         iXAuSZ6XEEVhHtx9U4tU37x7ZPhEl1UouxtiRkK3r9iQYvbx5kqDcRhpINwiQq1QmPAU
         hom8fD3JnBhbgnND+sHFgLWvaSTe2xuN226h/sLuREcXaJuK2yuAUK4zGfdk1EQctejc
         rusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707895835; x=1708500635;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNBP4KUPyi6Dyl5CVorOkklp5uNvIjutICMBUaGJ8gQ=;
        b=sokxg+kmnPL1+WqckhxKaX4MHfKlQwHLjXRq9eYEQKxUPiaWn+5m6zAJ5FXbOvTQaO
         6PNszTymfrnC0Mz2dVjVdP7/g94t6Pp5TDdJpy3kMJl25J/+l10voKlhMGy1MRTteyxl
         wFoIU3WSDpNly0ueHzGDnQEN3G0K+dQMNk+Y9Imxy4v3ysBsFEm/zLmp21goZ/agAjXK
         2PAE+KOuxTuew71Q6oAo4g9KTM4DnPUebbTxIlWcxMIK8XRF6Rex7MQ2yEim7q9oMQoK
         PEu6mLM+RwbovbWHF9XOEnYxumkUTG85RWqrrEtZtO9DoSPBcMaOa4URVzjD+pyIw0v4
         z1eg==
X-Gm-Message-State: AOJu0YxxCxMvLfwpEfxeiTVADwShOqB4fDuX5EqLTYRAWRt2940+zx5V
	LJsvR+6dHWy7KZXP2doHoZohTc4j8DStkdmke5+1nb1C52BQXqnczT4PjKsgrHNqFQOCuLo5q8K
	pCA==
X-Google-Smtp-Source: AGHT+IENMNztunqDj8p8SgchUAeFO0xM9NkqNpLpi+9htTp8AYxJdpFwQal477tHwloYgZNyFV+rnw==
X-Received: by 2002:a17:906:c30a:b0:a3d:45ca:679d with SMTP id s10-20020a170906c30a00b00a3d45ca679dmr702437ejz.58.1707895835255;
        Tue, 13 Feb 2024 23:30:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRoCTYk0NpWnB0F5YYZFloA3pReizuYV/4I6KVIZBkZDzSTZMGRQ5Fo1KiHAHPBgvLpWC4f/LGRMNjZsN2IRnIaw==
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id cw20-20020a170906c79400b00a3d4b488970sm254087ejb.45.2024.02.13.23.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 23:30:34 -0800 (PST)
Date: Wed, 14 Feb 2024 07:30:25 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org
Subject: [PATCH v2 bpf-next] libbpf: make remark about zero-initializing
 bpf_*_info structs
Message-ID: <ZcxsEQ8Ld_hqbi7L@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In some situations, if you fail to zero-initialize the
bpf_{prog,map,btf,link}_info structs supplied to the set of LIBBPF
helpers bpf_{prog,map,btf,link}_get_info_by_fd(), you can expect the
helper to return an error. This can possibly leave people in a
situation where they're scratching their heads for an unnnecessary
amount of time. Make an explicit remark about the requirement of
zero-initializing the supplied bpf_{prog,map,btf,link}_info structs
for the respective LIBBPF helpers.

Internally, LIBBPF helpers bpf_{prog,map,btf,link}_get_info_by_fd()
call into bpf_obj_get_info_by_fd() where the bpf(2)
BPF_OBJ_GET_INFO_BY_FD command is used. This specific command is
effectively backed by restrictions enforced by the
bpf_check_uarg_tail_zero() helper. This function ensures that if the
size of the supplied bpf_{prog,map,btf,link}_info structs are larger
than what the kernel can handle, trailing bits are zeroed. This can be
a problem when compiling against UAPI headers that don't necessarily
match the sizes of the same underlying types known to the kernel.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 tools/lib/bpf/bpf.h | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index f866e98b2436..3ed745f99da3 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
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
@@ -530,11 +536,14 @@ LIBBPF_API int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info,
 LIBBPF_API int bpf_map_get_info_by_fd(int map_fd, struct bpf_map_info *info, __u32 *info_len);
 
 /**
- * @brief **bpf_btf_get_info_by_fd()** obtains information about the 
+ * @brief **bpf_btf_get_info_by_fd()** obtains information about the
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

