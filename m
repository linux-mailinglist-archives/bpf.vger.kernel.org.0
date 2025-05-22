Return-Path: <bpf+bounces-58781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9A4AC1731
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 01:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8E13AD438
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E33F2C2AC3;
	Thu, 22 May 2025 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOgMu2XD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324F2C17A2
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955086; cv=none; b=E4QXg1eqsgdFDMsyF1p3rI8iWOoaTcQafsOGgckJbA5f8ehHzaGfg25xnOsxQ3bTth8vh8p1xCMNfJ3sBBHC0aQwNZXdknXVkQS3wA/jJYNtxxGFxm/LKvN5GoqB7a4GUZ9mPlcun863sURPdYU3vglPs7eXfYUAsidlbrTfMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955086; c=relaxed/simple;
	bh=IzIhp5f9UkPPUd0nWSAK8FUbuMqu0g7cAdmTXHizgXU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fTzCJNlidmmJaztNRZkR9tZ+idfCVcvdMf4WHnFmKGCyZ3p4EBSnes52Xkt/oLAFcQBOg45hH57omnbQum68EeeFJgeMR9f5HP+fR7NYkxQRlLERHRNRGb7KEHAkDJn/UhwbNsPPddQ3Peq83dfOqohocPoR1fThMtzwva8sSsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QOgMu2XD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b240fdc9c20so8758548a12.3
        for <bpf@vger.kernel.org>; Thu, 22 May 2025 16:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747955084; x=1748559884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/g8JyMw2VwyJ/m9TjS/SiUKpJwsf5OkBbH7oNpMPS0=;
        b=QOgMu2XDkHI0o07iYFksuqsZF4C/4WsXVza3rkoSuzqKJccwjQ33KkLaH2f9jBu9Oo
         T012Po2JMJTqPAC3QyvsaRgRxpeDfDTNLIGylQoEDsldqDSyHJSCSeRqGg7hTgyScH4a
         9RJHoQbiJoMWqQzMcd/GVfoh5UBk8FktBB+XWUmABtOFxTBewbrF262HszjqU/r57tFq
         0ihdSoZwgovovLnU6lPKR5FjWWfolj67SZlGzGzyHyzyBzSLgEo1CLSpwmd2/dKb9jzs
         ZU5/5LEc+8dqjyOvkOEXUJBTOGf0n5+lGF1cZxXQcnjM5qCoyfa3sebWOz5P0xYC/4oX
         7E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747955084; x=1748559884;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G/g8JyMw2VwyJ/m9TjS/SiUKpJwsf5OkBbH7oNpMPS0=;
        b=uR+Hc10CafDiM5qXGft+mLgeHUA6TdTO5LF7v4IR0XIt6zyG6ob0VgvdBJDupcPvuL
         jpX9QmlKpZGapPk5NIhxUc5y9tz19r+LjVlUek2fuUqGyF7XVJL/dJJjvJWzKIdv2MZX
         X/cRljrw4gzS1fsVmAabN6Tl28gTu4pChgf2ZYKrL5mWZAaZYccup8kXA9/BcKhtUC58
         QUF4YRCn4grOJOz6sLk3s2BQy9B2VExUdX+dt/NM/OXHq5mZF5seJFXKl5UTcFVK7RRQ
         dip0IxDEVbWzj0KUINS25C0IZghGqL3PK1MRXbDG5kXxGPz2xlYOYg2DeuXuRevB7K7l
         zEBg==
X-Forwarded-Encrypted: i=1; AJvYcCVB62uYYXx6VkqmmoDTgB/r2qdn8cXrUkxfdsObPlReV2SQ7RT2wAzPigul9rTOLAoOCrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6uFoaUh60tms4UItifIA57DXa0Nj4POSp1eJMuzX7Ytp8t2zb
	VGf+Txe75nqI5EMiCBoHMoePceuowlWHYO1Sd1AgrTc+RAhNjoE5Q4tLrrz4dgSTQK6JejQcFcs
	oJZJv/IsN4VCf2oJnvA==
X-Google-Smtp-Source: AGHT+IFHuZm2aKEEnirqMLyqXI/q0B8Co6Lr8MSquOHmj/BaEI70fa0f5cgugQZD5uKAyXECH9AT3FapY42Phlk=
X-Received: from pjf6.prod.google.com ([2002:a17:90b:3f06:b0:2ea:9d23:79a0])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3905:b0:30e:9349:2d93 with SMTP id 98e67ed59e1d1-310e972b4famr1252004a91.28.1747955084272;
 Thu, 22 May 2025 16:04:44 -0700 (PDT)
Date: Thu, 22 May 2025 23:04:27 +0000
In-Reply-To: <20250522230429.941193-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522230429.941193-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522230429.941193-4-tjmercier@google.com>
Subject: [PATCH bpf-next v7 3/5] bpf: Add open coded dmabuf iterator
From: "T.J. Mercier" <tjmercier@google.com>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org, song@kernel.org, 
	"T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This open coded iterator allows for more flexibility when creating BPF
programs. It can support output in formats other than text. With an open
coded iterator, a single BPF program can traverse multiple kernel data
structures (now including dmabufs), allowing for more efficient analysis
of kernel data compared to multiple reads from procfs, sysfs, or
multiple traditional BPF iterator invocations.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Acked-by: Song Liu <song@kernel.org>
---
 kernel/bpf/dmabuf_iter.c | 48 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c     |  5 +++++
 2 files changed, 53 insertions(+)

diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
index 83ef54d78b62..4dd7ef7c145c 100644
--- a/kernel/bpf/dmabuf_iter.c
+++ b/kernel/bpf/dmabuf_iter.c
@@ -100,3 +100,51 @@ static int __init dmabuf_iter_init(void)
 }
=20
 late_initcall(dmabuf_iter_init);
+
+struct bpf_iter_dmabuf {
+	/*
+	 * opaque iterator state; having __u64 here allows to preserve correct
+	 * alignment requirements in vmlinux.h, generated from BTF
+	 */
+	__u64 __opaque[1];
+} __aligned(8);
+
+/* Non-opaque version of bpf_iter_dmabuf */
+struct bpf_iter_dmabuf_kern {
+	struct dma_buf *dmabuf;
+} __aligned(8);
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it)
+{
+	struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
+
+	BUILD_BUG_ON(sizeof(*kit) > sizeof(*it));
+	BUILD_BUG_ON(__alignof__(*kit) !=3D __alignof__(*it));
+
+	kit->dmabuf =3D NULL;
+	return 0;
+}
+
+__bpf_kfunc struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *i=
t)
+{
+	struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
+
+	if (kit->dmabuf)
+		kit->dmabuf =3D dma_buf_iter_next(kit->dmabuf);
+	else
+		kit->dmabuf =3D dma_buf_iter_begin();
+
+	return kit->dmabuf;
+}
+
+__bpf_kfunc void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it)
+{
+	struct bpf_iter_dmabuf_kern *kit =3D (void *)it;
+
+	if (kit->dmabuf)
+		dma_buf_put(kit->dmabuf);
+}
+
+__bpf_kfunc_end_defs();
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index c1113b74e1e2..bd17ed5bfc4b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3386,6 +3386,11 @@ BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLE=
EPABLE)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE | KF_TRUST=
ED_ARGS)
 BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE | KF_T=
RUSTED_ARGS)
+#ifdef CONFIG_DMA_SHARED_BUFFER
+BTF_ID_FLAGS(func, bpf_iter_dmabuf_new, KF_ITER_NEW | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_S=
LEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE=
)
+#endif
 BTF_KFUNCS_END(common_btf_ids)
=20
 static const struct btf_kfunc_id_set common_kfunc_set =3D {
--=20
2.49.0.1151.ga128411c76-goog


