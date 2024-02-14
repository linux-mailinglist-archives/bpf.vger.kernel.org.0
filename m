Return-Path: <bpf+bounces-21962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B1C8544CE
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 10:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4EA285EB7
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 09:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3738A125B0;
	Wed, 14 Feb 2024 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HbjbPvm3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0154B125A2
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902071; cv=none; b=W40FhslMOoAnWvuofVDk67nc5O9+yA+q5JlJHP5SrZBmbGSqhI4GI0X6BpvGDOigW478VxnaxouuKA8mJ2RnK9+ey57glPs+zbJgE4MFy1cA8HVeWumPuohte9Sh7UK2nXGbFh7QSzTZPoQz/FK3JIHMDjiBEpor40CcFgS/w/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902071; c=relaxed/simple;
	bh=SDD+K+Yv6yN8ji3fIWSICKnf+rOBF90dBZGOM0pd8Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RC67TH/ROYDKKvJKbWW1lYsqDr5LLEYALtnRGavBx2hbE/kGs3QPRtyLDSfOwWxXNLhiQlMdawyOn+mGvMhY10twmvddy/tUqLvsuWaOODk6ZkDAU+SL9oUbaqVU1ygBv006WHgB5+arojY0ZahiLimLHw+8jrFq445BSCXAe0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HbjbPvm3; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so8361829a12.3
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 01:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707902067; x=1708506867; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AS5JVIWdNa+5VoSKRh/QU4HSpmGvSZqp0tJVbXIS324=;
        b=HbjbPvm3lUvi2o/4tnsAEXXuyl3vSZncOeQoaA8b++yxiwd9gUFnIWiFS1tAFputby
         ehviH3RXKXmgw78uLLWwCcMUkqzu3pSe2Yk8uv+3K/byGFNoEveCls8D3FErRDlwLu9N
         VNzOEhwi7Tt4rv8Z9bO74GN3Rx6fOB6FV1pib7uv6KZcHyS4hPNTcsl7Cwpc3eI+CoM9
         ccbKrGx0uBWcRNLde0zPdgKEGRAA0a1NbHSIUJmYd6unl7EYxO2gBtk8iEdhSlurCYWx
         hggb5QGDXAzYoIs2CZk9cWKtF7vuHQNLQ5bKVlL6Jrbs7bPGazsAQ7CDkjKuZnbEAwYO
         9xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707902067; x=1708506867;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AS5JVIWdNa+5VoSKRh/QU4HSpmGvSZqp0tJVbXIS324=;
        b=dZAADmmh7BJ32c3bopMYhw3i6WawndQbZIFbwWYCz9ZRavtDe9VOcn9+YerwDIsDg3
         jbiBznTEQAijQv54XRTrTzFm+fsALsw84cizI/UaU7iAc2J+A8WlEMtAh0yC56due9x9
         0z9ZgRzPH7a6s5v7jy/8uGe06TM1DKjCyBBnxPPDE6Z9VMDaOrrqBgIP2sru+qS/JGjw
         Cg3kG3+xznRLLBO2DBTVDOX5D+ygtmVJNYf52LH7z5W7kSm8NXdYl7HBntUWtO14xA/B
         8h/Gfxltq8OyhxqPyxSWz2Bsx64aq3+4/jh2hkCrCbE96TwSesftANWwQ5RY4U08PeSA
         Pz/w==
X-Gm-Message-State: AOJu0YxA51GJ7E9Ej2wDNtnMSvXfFdyK2nx9m8OuhLu3L3OH3fjlXfV+
	2i8Srtg+Sx68CR/UPCuvkbwIHKfR9ZWMUkK4Lq1GJlnlMfdbtsgEGs4jvA+1r8HmruiV0AJOXt+
	nRw==
X-Google-Smtp-Source: AGHT+IFDipQW8/wKAx1I+C8d/PLooMQrGefnrErWT3Zf2PVylM314zlU75zT3+ByZ9V/VjOzumjrcQ==
X-Received: by 2002:a05:6402:2034:b0:560:8385:811b with SMTP id ay20-20020a056402203400b005608385811bmr1368161edb.36.1707902067444;
        Wed, 14 Feb 2024 01:14:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQ+y8055TkdQmTiFN0jdnq+JfvRPeoUumsFNtIldfQc7lL2Ra0SaO8OJLcyfxMC4DycgcWsZAtw+3puTK1Zy99wbvz8Bf4Koxsqxn2FFNn1iwNYfPK
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id ij6-20020a056402158600b005621bdbfdb0sm615052edb.75.2024.02.14.01.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 01:14:27 -0800 (PST)
Date: Wed, 14 Feb 2024 09:14:23 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, olsajiri@gmail.com
Subject: [PATCH v3 bpf-next] libbpf: make remark about zero-initializing
 bpf_*_info structs
Message-ID: <ZcyEb8x4VbhieWsL@google.com>
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

v2 to v3:

* Modified the comment wording a little to make it less
  misleading. Specifically, noting that the supplied
  bpf_{prog,map,btf,link}_info structs should be zero-initialized or
  initialized as expected. In some cases, subsequent invocations to
  bpf_{prog,map,btf,link}_get_info_by_fd() helpers don't necessarily
  require the bpf_{prog,map,btf,link}_info struct to be
  zero-initialized, but rather that it just has been properly
  initialized at some point.

 tools/lib/bpf/bpf.h | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index f866e98b2436..ab2570d28aec 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -500,7 +500,10 @@ LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
  * program corresponding to *prog_fd*.
  *
  * Populates up to *info_len* bytes of *info* and updates *info_len* with the
- * actual number of bytes written to *info*.
+ * actual number of bytes written to *info*. Note that *info* should be
+ * zero-initialized or initialized as expected by the requested *info*
+ * type. Failing to (zero-)initialize *info* under certain circumstances can
+ * result in this helper returning an error.
  *
  * @param prog_fd BPF program file descriptor
  * @param info pointer to **struct bpf_prog_info** that will be populated with
@@ -517,7 +520,10 @@ LIBBPF_API int bpf_prog_get_info_by_fd(int prog_fd, struct bpf_prog_info *info,
  * map corresponding to *map_fd*.
  *
  * Populates up to *info_len* bytes of *info* and updates *info_len* with the
- * actual number of bytes written to *info*.
+ * actual number of bytes written to *info*. Note that *info* should be
+ * zero-initialized or initialized as expected by the requested *info*
+ * type. Failing to (zero-)initialize *info* under certain circumstances can
+ * result in this helper returning an error.
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
+ * zero-initialized or initialized as expected by the requested *info*
+ * type. Failing to (zero-)initialize *info* under certain circumstances can
+ * result in this helper returning an error.
  *
  * @param btf_fd BTF object file descriptor
  * @param info pointer to **struct bpf_btf_info** that will be populated with
@@ -551,7 +560,10 @@ LIBBPF_API int bpf_btf_get_info_by_fd(int btf_fd, struct bpf_btf_info *info, __u
  * link corresponding to *link_fd*.
  *
  * Populates up to *info_len* bytes of *info* and updates *info_len* with the
- * actual number of bytes written to *info*.
+ * actual number of bytes written to *info*. Note that *info* should be
+ * zero-initialized or initialized as expected by the requested *info*
+ * type. Failing to (zero-)initialize *info* under certain circumstances can
+ * result in this helper returning an error.
  *
  * @param link_fd BPF link file descriptor
  * @param info pointer to **struct bpf_link_info** that will be populated with
-- 
2.43.0.687.g38aa6559b0-goog

/M

