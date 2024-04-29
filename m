Return-Path: <bpf+bounces-28178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0341A8B64B0
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2841F21799
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C26A184115;
	Mon, 29 Apr 2024 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQAoWCbn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2CD184106
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426577; cv=none; b=Gx26Nwn42GJsmIOkjxbHRnX9czk5qphLWJz/GEzHW+Bn2uIslJ5IUU5ZFFONSmhJO6iv9dT7fol3RIKi2x2qzFJVbTGDVCtSz0NUruIFG+TfK19Q6qIV4JkVxpGdm64Wtw8PHoMPSf7uupIHmy9QhVSRiYJS1wAU1YB8oHfR0Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426577; c=relaxed/simple;
	bh=KR3nntE0MSV0xmElGXWcN2MeqwUZwsO4XLNYJPvTbIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B78gVbQT1fwz6IEDteE5iAbU+sxB/2bhtZdVNuNALBjzg94DeqT8w/ncKTLoaF/Ty2ZmbwHKPhOlwBYQCHW9xMe+bcVSs83MyakkphwwZXruta9tYvPQovpw/fI417kuY2o+NWnWfOzjd0zWRa4hJMp+ixnW3wSCqSrlEBbr0mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQAoWCbn; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c844b6edbbso3018389b6e.1
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 14:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714426574; x=1715031374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiPf+3XkCJLmBitbMVDk2ZnNXM0bO3q3Bz9cKB/E+HA=;
        b=fQAoWCbnmZv9MUjXZbTAVKZg6Ak1GgbgKme7kOna59rta6UYoRA0zT1JUC7D/zRfc7
         eorVuO4ViFS6ezwgXAonY/DHRRS6+yBTPCT0P0iroIiT2Kdn/Nvs1m2Prv6AOvbgBEBr
         cmYjCMZrzZ/RdM/M8sfpo61RqIbVF/x4S56vLttF9UomxFNZ7N9bx+b/QXmKlQuvfskU
         GfnyYbjgapL9myKPCckCazhv2/QJCpA81W0uhNbe4xW5rBvNEFqQc45EU6K0sIfN3gtC
         uoIfE0AyAzPBAspNMFngP8yANknry77vlMOYG22Rt0WnKnyIwtQJc2JBGZXwTpKVtS+a
         8NQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714426574; x=1715031374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiPf+3XkCJLmBitbMVDk2ZnNXM0bO3q3Bz9cKB/E+HA=;
        b=vjqgPpHv25GXU5BWLmbQlk2CiUxLaa2MpX/BpdyQeZ5QOi+2ylbQS9JOovMBOrXb2D
         owQrCNnY0326NP3qeBJ96j+VskaIehlhLKcJ8cB91BHuXBE6dy6n/JdxYMB2+B9eZIQP
         KNPchMlNvn08jPDfQMQE1OrcnRJfsPnB88wUFSOzHf/P/WAHsVl05L4+WxXH/TkfpS57
         e81YEV4ysf3/2SXlUJS3of+ES0CgfgwmjNoRAvaVSlYB90YXDAH5H3FvYWIo1RAX49+6
         dzCLwKl/25N+SrRcOid3yYed6AdfpXg1got2bIedy1pPfuojMOnS7O+keEZJGw7IJOz8
         c33w==
X-Gm-Message-State: AOJu0YyX9JKWTzGkK2ftZihKmoMBpjWWJ2rbb4Qo6GrgguGF8IlM4FuV
	jCthZ990TSsksTybWoW2JgES+/nPqUdBFoBwKVMbOnvH9WKNek4VmaR48Q==
X-Google-Smtp-Source: AGHT+IGHBsGhoUnJbogxRfTNrzCvIDjSEDw6VH8OUcfgXfdQarpvCCUJoKKtoWCsy1dB8SEMOU1iGg==
X-Received: by 2002:a05:6808:1887:b0:3c7:5091:54e5 with SMTP id bi7-20020a056808188700b003c7509154e5mr15881779oib.21.1714426574543;
        Mon, 29 Apr 2024 14:36:14 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b805:4ca7:fd75:4bf])
        by smtp.gmail.com with ESMTPSA id x5-20020a05680801c500b003c8642321c9sm714034oic.50.2024.04.29.14.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:36:14 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 2/6] bpf: export bpf_link_inc_not_zero().
Date: Mon, 29 Apr 2024 14:36:05 -0700
Message-Id: <20240429213609.487820-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429213609.487820-1-thinker.li@gmail.com>
References: <20240429213609.487820-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make bpf_link_inc_not_zero() available to be used by bpf_struct_ops.c
later.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h  | 1 +
 kernel/bpf/syscall.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5034c1b4ded7..8a1500764332 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2324,6 +2324,7 @@ int bpf_link_prime(struct bpf_link *link, struct bpf_link_primer *primer);
 int bpf_link_settle(struct bpf_link_primer *primer);
 void bpf_link_cleanup(struct bpf_link_primer *primer);
 void bpf_link_inc(struct bpf_link *link);
+struct bpf_link *bpf_link_inc_not_zero(struct bpf_link *link);
 void bpf_link_put(struct bpf_link *link);
 int bpf_link_new_fd(struct bpf_link *link);
 struct bpf_link *bpf_link_get_from_fd(u32 ufd);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7d392ec83655..4a2f95c4b2ac 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5364,7 +5364,7 @@ static int link_detach(union bpf_attr *attr)
 	return ret;
 }
 
-static struct bpf_link *bpf_link_inc_not_zero(struct bpf_link *link)
+struct bpf_link *bpf_link_inc_not_zero(struct bpf_link *link)
 {
 	return atomic64_fetch_add_unless(&link->refcnt, 1, 0) ? link : ERR_PTR(-ENOENT);
 }
-- 
2.34.1


