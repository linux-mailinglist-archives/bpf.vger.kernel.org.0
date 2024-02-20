Return-Path: <bpf+bounces-22307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5721285B780
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 10:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89841287EEE
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ECB657B2;
	Tue, 20 Feb 2024 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SEGU1oF3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350964CF3
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421323; cv=none; b=LdOSTQGfQz0FOEYwVMkg0Z0yqdE/ZPsRB17CHyw1dvD5nN6vWlMb4oH3IxJzo3K6DTgeZkjgLol5pwCNb1e3f6eG7xWdIi35hHfA00WijlKiWB/W7W13WuiJ5jMq7W2d+A6Gd2VuQiy61RkOlGL4B7tnvQLwUyB2C6ZYkstpzhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421323; c=relaxed/simple;
	bh=B0wfWCclmrTNKw8t5WQOMXI4ZoGVKDEJu3DZO62q57k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyYrv8GlSYXk+M+WHICsMkhDGK9bd/wn/Ff9fyWYZsAyl05TOt9j4SG8qDRWDk3ppkfwwfmQHbaxR1W4bTsMV3wgz7fi4CYUrF009VzT4kDt1RbVaE/Apw1qb9VKN8hsvSL+g4iaavXuUUYBq5/YFKmCDdZpnviGraTJN9tcn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SEGU1oF3; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-564d9b0e96dso128493a12.2
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 01:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421319; x=1709026119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxaMZcDKEkY7wflrO9M/nsmbkLRY7k3BJEAicWcKejI=;
        b=SEGU1oF3rDdvPqD8mC7dU+hhSA1dRtXkroqVxYfXB7cI0p2TwyUYNn1S8kMCTZD3ve
         GN4xhojgIKrvnwvsx+XN05TIE02ttDzOSFE1jJp22tivUlTjCMn2e8ToMPTVtVlRse2d
         vRcVl2oYGvB1eERdRykxURxNdpzKSoHmWEIcTwTl4Rjh5iifKL/AaLlnIU6txnfVNdx/
         pcKa0LAtP+sGB9EKnHDsF7LbZKjx87z7wODlK5ohMOAkg3E9TnW9Dvx0Jj2so0f62xcL
         G548vK4lGil9EeUb0CZBHS9DzgoNqhGKV0vDh0uaR0z6+H1xxv3nKYDQCNTiGfDxhw6z
         HroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421319; x=1709026119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxaMZcDKEkY7wflrO9M/nsmbkLRY7k3BJEAicWcKejI=;
        b=Mfi1WtMmTfx2mN6i3e8awKvcYFpAaIx6DljPOYiR+f/nYdK6Vnz3VyYkdJxiszBlVp
         ZC/+0x59OyPRfJFkTiis7oGtOnaDidm45IQdoyWfOaoLpedlctYRjGDCEA22znwNiHQ5
         8SAJAzJKgZweaDogb7ywRQ/DEHmCnLNd5bRLMqUc9cQUaWfyAWPdA8qr9EQviTxxMJHl
         DuBJeoz2+SlK1mK7yckfcYYFQfyY/D/NpCQc914+gys1oNtvZ3D6NacPDb9y0GWHymht
         RGioJ9L8IdSVPHS54Jib2uqymPCFk+KIhuvfiIRlOT7o8H04Ucz06EdMK4C/djJgeCD4
         rTOw==
X-Gm-Message-State: AOJu0YzJ+jhhvFcBOVcu9ufD4qoXWeDQuZ9o1WbcQmAciSerNtXZ55y/
	GPTmH9MPHCd0qtbIWzujMUrHFW1veyKUzsYBVOncGXdyNZKqzS+ADa2ERv8+1bBQcc4yeoHnHyE
	LmA==
X-Google-Smtp-Source: AGHT+IHOBu+/5v68Q4wEQvOl52ps73P98rLT4hw71J9hPjcmK9E4xRz5ROknH+/Xu0kNrWHfG8P7aA==
X-Received: by 2002:aa7:d997:0:b0:564:71d1:6cbd with SMTP id u23-20020aa7d997000000b0056471d16cbdmr3536021eds.14.1708421319547;
        Tue, 20 Feb 2024 01:28:39 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id h10-20020a0564020e0a00b005641bab8db3sm3286601edh.86.2024.02.20.01.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:28:39 -0800 (PST)
Date: Tue, 20 Feb 2024 09:28:35 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 10/11] bpf: add trusted d_path() based BPF kfunc
 bpf_path_d_path()
Message-ID: <46200bbaa6eae2131abed97f1a51991207eeb071.1708377880.git.mattbobrowski@google.com>
References: <cover.1708377880.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708377880.git.mattbobrowski@google.com>

The legacy bpf_d_path() helper didn't operate on trusted pointer
arguments, therefore under certain circumstances was susceptible to
memory corruption issues [0]. This new d_path() based BPF kfunc
bpf_path_d_path() makes use of trusted pointer arguments and therefore
is subject to the BPF verifier constraints associated with
KF_TRUSTED_ARGS semantics. Making use of such trusted pointer
semantics will allow d_path() to be called safely from the contexts of
a BPF program.

For now, we restrict bpf_path_d_path() to BPF LSM program types, but
this may be relaxed in the future.

[0]
https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2bb7766337ca..57a7b4aae8d5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1635,6 +1635,36 @@ __bpf_kfunc void bpf_put_path(struct path *path)
 	path_put(path);
 }
 
+/**
+ * bpf_path_d_path - resolve the pathname for a given path
+ * @path: path to resolve the pathname for
+ * @buf: buffer to return the resolved path value in
+ * @buflen: length of the supplied buffer
+ *
+ * Resolve the pathname for the supplied trusted *path* in *buf*. This kfunc is
+ * the trusted/safer variant of the legacy bpf_d_path() helper.
+ *
+ * Return: A strictly positive integer corresponding to the length of the string
+ * representing the resolved pathname, including the NUL termination
+ * character. On error, a negative integer is returned.
+ */
+__bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, int buflen)
+{
+	int len;
+	char *ret;
+
+	if (buflen <= 0)
+		return -EINVAL;
+
+	ret = d_path(path, buf, buflen);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
+	len = buf + buflen - ret;
+	memmove(buf, ret, len);
+	return len;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(lsm_kfunc_set_ids)
@@ -1651,6 +1681,7 @@ BTF_ID_FLAGS(func, bpf_get_task_fs_root,
 BTF_ID_FLAGS(func, bpf_get_task_fs_pwd,
 	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_path, KF_RELEASE | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_KFUNCS_END(lsm_kfunc_set_ids)
 
 static int bpf_lsm_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.44.0.rc0.258.g7320e95886-goog

/M

