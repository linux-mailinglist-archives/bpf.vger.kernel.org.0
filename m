Return-Path: <bpf+bounces-57341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA44AA947C
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 15:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C6E3B395F
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 13:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ADC2586E8;
	Mon,  5 May 2025 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b3wGu2ff"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DB91E5218
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451626; cv=none; b=flm7QUAO2LBxlclakBIuf0krCoYhClRb6cBqYINTgWw61jPKuAzMfMEuTrmQVVu2hetqrWVHnPgsSfusz46rbO6cbNyTpTKbh5ubz5RmyAz0XeeNk8PQWiqz4izImZsG56R65rTVU3YwGE3P4/OR6D+YRiOhCp8d8qL3aOZYByM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451626; c=relaxed/simple;
	bh=jr6GkgQ9XD6Lf1yVIS9v7Sn9Vkf3Ybk+w8g8l1Va0NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpiSEAs9c0C4IYxV3NUqBRZDMyKct2Nj0QoWfHWsToDeDWV7kW+mK6TTskvC8idpnn5dFjrF6IcLBjGP5B43KBaeMnXi19CiMKAFomGlvCustMAE8qRTh23wjzVO011rgQm+CB/EMorreJoUFWmVekXDrIxEzxE5c3LjAOW3+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b3wGu2ff; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224171d6826so63843115ad.3
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746451624; x=1747056424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HVJEGPoaKMbKHaMifVzIQ6ou8eEsRnLAzJ4Z5KRLUjw=;
        b=b3wGu2ffjMSl4Gh/pNzkQSdfng/JTet8aFdCFv0o2FMgbUwI7sYjNJtxOgUUOHJk5O
         wr+KKzlL5SvbdK6ieZBYpOTOEyjiVQGZO1Fakfgq4BqOZ9ZWcYENk+9q0WHyyK2mmaSU
         jn0NqL5TE/8mmevNuPHNWgoJBp8KPjJIJq+vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746451624; x=1747056424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVJEGPoaKMbKHaMifVzIQ6ou8eEsRnLAzJ4Z5KRLUjw=;
        b=HKzVBsM3LIcnHGQFNDeATL+MDNKv1VjJdOXQcdtNQkN3BSNFTimaajMJtEemVwJ42T
         ddCl9YxDtW43QlIv2mdRsEBrGYJfvnA+ektE6ub/wVw13e0LxCVjQyoxzXYCDrnaqXvb
         RsgAfNnlJGqfDZkZH2l3CvmcvYwWHvuFVxYInouVai4lzu020nMsxcR6EtJDdpVTHWA7
         X91icLE3llA9x6TtVeyyhb9drXZob6VHOczkRsFcg3QYNuBr875ZBuJeyu4OM3Y4imFq
         +B2R4rTkE46wCaDp4a01nu8b5BQngKLLOCkKy7gzOWp8eUP+9jtKWXWnsUaViGD9GPAk
         i0Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUePTlYCeMv8frvFvxyITaAK3yfItInRea+qDuyWUoapuOr7byYmN7F4BcQpMy4GfdnkNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydpt0Xk4VtDiXnLglOsQX6DsWktLrsUaB9Fze/o+LQwTxO9/1T
	tfBGF8JgAsjTLrLxAAnNWrOLBqPL/Kjl0UoVfQ+kCUBgvhyG96WyT5KBkjFtEg==
X-Gm-Gg: ASbGncuD3o/gv1BP9x/IeflImSAwS226bjImXDhhSkrvw16RKU91xuMl23A7IsCv2KA
	pUwzW6J770Twc1cSUYlpEUQKWqAuT7S2mKx1M8vY44LqOVl8APDMxUNMNt7gdYvpgB+Vqza+REc
	bGyZEvutb4Ab6P9zk1C0u59jN7Rr05ULC6puDgPpB29pzzLqthwW9AoUvk8EAtLqnBlJfqVq3Om
	ah5fpFI71BTv2MsitYn77dSjJVFw4+dy+N9xO0PVWs8qhfRBz+XYCpxCcp8Q2YKHXp73b3HWLeY
	mOSanRrmWKhIEqsaIZWxS4f3i7l4bzUOPnl1rxDCxd2o4YDSilEOtt8=
X-Google-Smtp-Source: AGHT+IHwt4UC2XxevtMUndbyp4q3ggLLmwYBWT4XVFFijAYsgulkfTtOXilXhgJqug2fYYB8ORCCaA==
X-Received: by 2002:a17:902:c94b:b0:224:1ce1:a3f4 with SMTP id d9443c01a7336-22e1e8c4afdmr110817575ad.1.1746451623915;
        Mon, 05 May 2025 06:27:03 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4dd5:88f9:86cd:18ef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e152201a1sm53720925ad.114.2025.05.05.06.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 06:27:03 -0700 (PDT)
Date: Mon, 5 May 2025 22:26:58 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: add bpf_msleep_interruptible()
Message-ID: <wzxhhoiczrhsosf5bkwqf2yypdrhgrm6wskiusfg7iumpgk7ew@rcegtieelqco>
References: <20250505063918.3320164-1-senozhatsky@chromium.org>
 <aBiJnR5MEL5hVXXC@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBiJnR5MEL5hVXXC@google.com>

On (25/05/05 09:49), Matt Bobrowski wrote:
> I noticed that you've written the newly proposed BPF helper in the
> legacy BPF helper form, which I believe is now discouraged, as also
> stated within the above comment. You probably want to respin this
> patch series having written this newly proposed BPF helper in BPF
> kfuncs [0] form instead.

Oh, okay, I didn't know about kfunc.  So I guess it's something like
the patch below.

> Additionally, as part of your patch series I think you'll also want to
> include some selftests.

Let me take a look.  Any hints on how to test it?

---
 include/uapi/linux/bpf.h       | 8 ++++++++
 kernel/bpf/helpers.c           | 6 ++++++
 tools/include/uapi/linux/bpf.h | 8 ++++++++
 3 files changed, 22 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 71d5ac83cf5d..8624cb2ac7d9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5814,6 +5814,14 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * unsigned long bpf_msleep_interruptible(unsigned int msecs)
+ *	Description
+ *		Make the current task sleep until *msecs* milliseconds have
+ *		elapsed or until a signal is received.
+ *
+ *	Return
+ *		The remaining time of the sleep duration in milliseconds.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..6ba75bf816f2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3194,6 +3194,11 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
 	local_irq_restore(*flags__irq_flag);
 }
 
+__bpf_kfunc unsigned long bpf_msleep_interruptible(unsigned int msecs)
+{
+	return msleep_interruptible(msecs);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3294,6 +3299,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_local_irq_save)
 BTF_ID_FLAGS(func, bpf_local_irq_restore)
+BTF_ID_FLAGS(func, bpf_msleep_interruptible)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 71d5ac83cf5d..8624cb2ac7d9 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5814,6 +5814,14 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * unsigned long bpf_msleep_interruptible(unsigned int msecs)
+ *	Description
+ *		Make the current task sleep until *msecs* milliseconds have
+ *		elapsed or until a signal is received.
+ *
+ *	Return
+ *		The remaining time of the sleep duration in milliseconds.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
-- 
2.49.0.906.g1f30a19c02-goog


