Return-Path: <bpf+bounces-58135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C2FAB5A45
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 18:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26A5866FE7
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9E02C1E18;
	Tue, 13 May 2025 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7vjKy2y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588112C1787
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154187; cv=none; b=u5F/Lhb49n/8FM2uvllvsPXWRMTSVVp1v/0iQ80srkn/ADruUt/QqWruP4HnCQ+5Q/HC+gS3SfYqwKBkcGKpHWi0uf/F1Kmur4Kb5ovFipgTz8RP+O+YHzf4rlsubcUhGlpW8OPW42rzXfxxBzDK+glssGdupyntcwxxrXLm2nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154187; c=relaxed/simple;
	bh=lTcuEGhsamj/xztXdOWrb/5i4Xdmx6ntJG3YH405vn8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lheyc6ggAEtGqL+lXioDrSHZFRm1IRXVo/WK+rIj3k8eDb04IRKfwm0G9kRC039AZqk968mnMUCEmNG3SlKRKqiirF8CYJ7rWko9PTlTu8Vp9mfSIJVVCyMt5q6niDFRil7lWe1/QOQqx/DWrsPOVwNoV4nS5hAsiRksGzeQ/CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7vjKy2y; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30abb33d1d2so9167737a91.0
        for <bpf@vger.kernel.org>; Tue, 13 May 2025 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747154184; x=1747758984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2++fCRMe3L9pR8XKatZapTnZclNsk79jNMtd4ev4pGw=;
        b=n7vjKy2yoJ3o2L1lFCJ3NifsQiYWHj3OikH1xSF6NrrYIzrDW/KBDyHrjJaez3f/Pi
         ERhQMAzRlQBi9e8UF+aAz4/bqDvKOJIW3sx6WxgAjzmbH8D8YO/nFHcGRXNB25AEMNyR
         gTz42PHlTuvfZB3OjN2hO1jG5UPkSdkN9DSmaUPFVN3pclHC7S1xDk+/kW9IOLIP3kTR
         8dV6jZjNO9oxBtACQDPz6bEdZonzA9RXmrNqPYh5i7rLfClU3AaPOagrnPUu5NRQBxe6
         CHsY5tGdEN35OOJzKLbw3S4aVenbFhaAzaLUgGShfIjBOZucnc1ApIHy8O1y9gFhbzYn
         iQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747154184; x=1747758984;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2++fCRMe3L9pR8XKatZapTnZclNsk79jNMtd4ev4pGw=;
        b=f41uah1ZvbegwTPw60QKJjZlzF+T6IxucoTNL19nBBQFY3kP6gKW/+/lIYPULi2qAv
         831oPJTC4Rb2hIbN9LM5Y34gvdPGu+OcqmCdsl9R3MJakNIiCcpaSA9uz480yyzLNzb4
         S+n+9zkUgLwlJo+Asz4MD61gY+zv8+XGuaTbR5umqkWwyRUcXqBatzBehOqoDSYCZbEi
         ayLMjzB9WEv2JaYGIC/RWVwXfzP4izm6eeoVLgSq1cnrUTkAsziAjieM+M/Ep0I7NAzD
         iYDH4v3VW4EW/JuFuI7QhFwJCfZcky0jgoVGA8ACh+gFMKNAPNtU9PI5TBqSwL/6sM82
         UlWA==
X-Forwarded-Encrypted: i=1; AJvYcCVSWAl/Ueq+l3Eip1WLbzR9/V1CVJfy3oZp4bg8mdIt9s8PrN3Y5B8dj247HFPDzqTS+XI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7IehvZdt5A5U4eO0kBS8d1cM1Etj931aKmGAPaowvksepbwcp
	Z23s6hc1i4wnCl6FZbZcfFQ4ACza2bZb9cc1PZi01Gj6MxPzmgzFDlmnBlrAh9Oto/aaW1B5VDT
	GqL2GGqOpqphOLg==
X-Google-Smtp-Source: AGHT+IE+aqPOpgjO1590OZC7ONM9C4FChLY4A8vilD/mONkHhcOuA1B9Bfey4X0tmkv0XxFwbLvbokI1dDCWlME=
X-Received: from pjbqn8.prod.google.com ([2002:a17:90b:3d48:b0:2fb:fa85:1678])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:58cf:b0:30a:2173:9f0b with SMTP id 98e67ed59e1d1-30e2e629eb8mr327463a91.28.1747154183884;
 Tue, 13 May 2025 09:36:23 -0700 (PDT)
Date: Tue, 13 May 2025 16:36:01 +0000
In-Reply-To: <20250513163601.812317-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513163601.812317-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513163601.812317-6-tjmercier@google.com>
Subject: [PATCH bpf-next v6 5/5] selftests/bpf: Add test for open coded dmabuf_iter
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

Use the same test buffers as the traditional iterator and a new BPF map
to verify the test buffers can be found with the open coded dmabuf
iterator.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Acked-by: Song Liu <song@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  5 +++
 .../selftests/bpf/prog_tests/dmabuf_iter.c    | 41 +++++++++++++++++++
 .../testing/selftests/bpf/progs/dmabuf_iter.c | 38 +++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing=
/selftests/bpf/bpf_experimental.h
index 6535c8ae3c46..5e512a1d09d1 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -591,4 +591,9 @@ extern int bpf_iter_kmem_cache_new(struct bpf_iter_kmem=
_cache *it) __weak __ksym
 extern struct kmem_cache *bpf_iter_kmem_cache_next(struct bpf_iter_kmem_ca=
che *it) __weak __ksym;
 extern void bpf_iter_kmem_cache_destroy(struct bpf_iter_kmem_cache *it) __=
weak __ksym;
=20
+struct bpf_iter_dmabuf;
+extern int bpf_iter_dmabuf_new(struct bpf_iter_dmabuf *it) __weak __ksym;
+extern struct dma_buf *bpf_iter_dmabuf_next(struct bpf_iter_dmabuf *it) __=
weak __ksym;
+extern void bpf_iter_dmabuf_destroy(struct bpf_iter_dmabuf *it) __weak __k=
sym;
+
 #endif
diff --git a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c b/tools/t=
esting/selftests/bpf/prog_tests/dmabuf_iter.c
index dc740bd0e2bd..6c2b0c3dbcd8 100644
--- a/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/dmabuf_iter.c
@@ -219,14 +219,52 @@ static void subtest_dmabuf_iter_check_default_iter(st=
ruct dmabuf_iter *skel)
 	close(iter_fd);
 }
=20
+static void subtest_dmabuf_iter_check_open_coded(struct dmabuf_iter *skel,=
 int map_fd)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	char key[DMA_BUF_NAME_LEN];
+	int err, fd;
+	bool found;
+
+	/* No need to attach it, just run it directly */
+	fd =3D bpf_program__fd(skel->progs.iter_dmabuf_for_each);
+
+	err =3D bpf_prog_test_run_opts(fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return;
+
+	if (!ASSERT_OK(bpf_map_get_next_key(map_fd, NULL, key), "get next key"))
+		return;
+
+	do {
+		ASSERT_OK(bpf_map_lookup_elem(map_fd, key, &found), "lookup");
+		ASSERT_TRUE(found, "found test buffer");
+	} while (bpf_map_get_next_key(map_fd, key, key));
+}
+
 void test_dmabuf_iter(void)
 {
 	struct dmabuf_iter *skel =3D NULL;
+	int map_fd;
+	const bool f =3D false;
=20
 	skel =3D dmabuf_iter__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "dmabuf_iter__open_and_load"))
 		return;
=20
+	map_fd =3D bpf_map__fd(skel->maps.testbuf_hash);
+	if (!ASSERT_OK_FD(map_fd, "map_fd"))
+		goto destroy_skel;
+
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, udmabuf_test_buffer_name, &f, =
BPF_ANY),
+		       "insert udmabuf"))
+		goto destroy_skel;
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, sysheap_test_buffer_name, &f, =
BPF_ANY),
+		       "insert sysheap buffer"))
+		goto destroy_skel;
+
 	if (!ASSERT_OK(create_test_buffers(), "create_test_buffers"))
 		goto destroy;
=20
@@ -237,8 +275,11 @@ void test_dmabuf_iter(void)
 		subtest_dmabuf_iter_check_no_infinite_reads(skel);
 	if (test__start_subtest("default_iter"))
 		subtest_dmabuf_iter_check_default_iter(skel);
+	if (test__start_subtest("open_coded"))
+		subtest_dmabuf_iter_check_open_coded(skel, map_fd);
=20
 destroy:
 	destroy_test_buffers();
+destroy_skel:
 	dmabuf_iter__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/testin=
g/selftests/bpf/progs/dmabuf_iter.c
index 2a1b5397196d..bd4ebfc9161c 100644
--- a/tools/testing/selftests/bpf/progs/dmabuf_iter.c
+++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
@@ -9,6 +9,13 @@
=20
 char _license[] SEC("license") =3D "GPL";
=20
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, DMA_BUF_NAME_LEN);
+	__type(value, bool);
+	__uint(max_entries, 5);
+} testbuf_hash SEC(".maps");
+
 /*
  * Fields output by this iterator are delimited by newlines. Convert any
  * newlines in user-provided printed strings to spaces.
@@ -51,3 +58,34 @@ int dmabuf_collector(struct bpf_iter__dmabuf *ctx)
 	BPF_SEQ_PRINTF(seq, "%lu\n%llu\n%s\n%s\n", inode, size, name, exporter);
 	return 0;
 }
+
+SEC("syscall")
+int iter_dmabuf_for_each(const void *ctx)
+{
+	struct dma_buf *d;
+
+	bpf_for_each(dmabuf, d) {
+		char name[DMA_BUF_NAME_LEN];
+		const char *pname;
+		bool *found;
+
+		if (bpf_core_read(&pname, sizeof(pname), &d->name))
+			return 1;
+
+		/* Buffers are not required to be named */
+		if (!pname)
+			continue;
+
+		if (bpf_probe_read_kernel(name, sizeof(name), pname))
+			return 1;
+
+		found =3D bpf_map_lookup_elem(&testbuf_hash, name);
+		if (found) {
+			bool t =3D true;
+
+			bpf_map_update_elem(&testbuf_hash, name, &t, BPF_EXIST);
+		}
+	}
+
+	return 0;
+}
--=20
2.49.0.1045.g170613ef41-goog


