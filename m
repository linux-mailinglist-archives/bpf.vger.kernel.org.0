Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D76256161
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 21:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgH1Tgg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 15:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgH1TgO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 15:36:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FEBC061236
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 12:36:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u128so277468ybg.17
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=ntqqP+oTxa4ovownU4E037j4DkCLhsnQeuQG8e3plIM=;
        b=AYSFWGB0h2DV9xVaVkEI26P9ljTv1zdH+jfmkkGrSfczvU46QdPGP64IbKG5HNWTJE
         dCVk8FL1csrb5vKbFrQ2qkmmBr1Jk82ZGpJBBMIixBCZ9GyOzs8qypRzfFUOpNm24IRo
         R71ayaswh4D3Xv2a3Dyid+gYLiD9heFR8AcgQyKKIO3zTZDd7SSvp2SsjxNunoGkB2Sf
         /gsyI+3tJ7PEThFvyD2NGjM+MB+zIwmn76B9MxlxMaf1ey0GJoSJz+RHztC+jQPeBh4M
         eFbMQNy1/ImaMSRU658oZTTTEgeel0S6AGhlL3oIQ0KO91SblE4q9StCI6ZoMLIza+NV
         DTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=ntqqP+oTxa4ovownU4E037j4DkCLhsnQeuQG8e3plIM=;
        b=RV7OnwDGwwmJft2dW81BDTUUNHk+No3IalPY4qcLZj0ImmWa2jd3Z2mPCr8JUvbuZ3
         GPTKr+ivxcWhOWviwza6ZnB7yHikJlkJrGpHz6Win0WUa6w6uYAo+rgXUsLaQ8ep28bl
         bm7gLm2/g4PMbfyPto9W06nGoYFBh2mNDM6BTpn//sAbQ85sGpzwZz7fZiwyZ5pCGsOo
         CaLrAr1ok+A84FMxRA22izKKBLAF7vrp94beCyC41CrMz9h4k1vlOVbeyZaD7nffigAn
         SjABA95zeUjAAG6+FWWEmcKbmx3RHUuaBnkh6RR0p+KPk2zLuRomyGh59Spp1/Llz9oY
         5AVw==
X-Gm-Message-State: AOAM5315SUvl7TDeVyGnVfKrul5e2rezk7OwH6LjyxpYu9jGsZgs2LuD
        nTsMau0kVFOstTLZigZjWNB3S40=
X-Google-Smtp-Source: ABdhPJx1IsJHBHlIzxza1al3CcA+8QFR4gJT1AnNn6Andp0lI5xEqPTU0Sat/qun+98IJbgmrVY3GFI=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a25:1fd5:: with SMTP id f204mr4340421ybf.142.1598643373098;
 Fri, 28 Aug 2020 12:36:13 -0700 (PDT)
Date:   Fri, 28 Aug 2020 12:35:59 -0700
In-Reply-To: <20200828193603.335512-1-sdf@google.com>
Message-Id: <20200828193603.335512-5-sdf@google.com>
Mime-Version: 1.0
References: <20200828193603.335512-1-sdf@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH bpf-next v3 4/8] libbpf: implement bpf_prog_find_metadata
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        "=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a low-level function (hence in bpf.c) to find out the metadata
map id for the provided program fd.
It will be used in the next commits from bpftool.

Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Cc: YiFei Zhu <zhuyifei1999@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/bpf.c      | 74 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.h      |  1 +
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 76 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 5f6c5676cc45..01c0ede1625d 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -885,3 +885,77 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
=20
 	return sys_bpf(BPF_PROG_BIND_MAP, &attr, sizeof(attr));
 }
+
+int bpf_prog_find_metadata(int prog_fd)
+{
+	struct bpf_prog_info prog_info =3D {};
+	struct bpf_map_info map_info;
+	__u32 prog_info_len;
+	__u32 map_info_len;
+	int saved_errno;
+	__u32 *map_ids;
+	int nr_maps;
+	int map_fd;
+	int ret;
+	int i;
+
+	prog_info_len =3D sizeof(prog_info);
+
+	ret =3D bpf_obj_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
+	if (ret)
+		return ret;
+
+	if (!prog_info.nr_map_ids)
+		return -1;
+
+	map_ids =3D calloc(prog_info.nr_map_ids, sizeof(__u32));
+	if (!map_ids)
+		return -1;
+
+	nr_maps =3D prog_info.nr_map_ids;
+	memset(&prog_info, 0, sizeof(prog_info));
+	prog_info.nr_map_ids =3D nr_maps;
+	prog_info.map_ids =3D ptr_to_u64(map_ids);
+	prog_info_len =3D sizeof(prog_info);
+
+	ret =3D bpf_obj_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
+	if (ret)
+		goto free_map_ids;
+
+	ret =3D -1;
+	for (i =3D 0; i < prog_info.nr_map_ids; i++) {
+		map_fd =3D bpf_map_get_fd_by_id(map_ids[i]);
+		if (map_fd < 0) {
+			ret =3D -1;
+			goto free_map_ids;
+		}
+
+		memset(&map_info, 0, sizeof(map_info));
+		map_info_len =3D sizeof(map_info);
+		ret =3D bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len);
+		saved_errno =3D errno;
+		close(map_fd);
+		errno =3D saved_errno;
+		if (ret)
+			goto free_map_ids;
+
+		if (map_info.type !=3D BPF_MAP_TYPE_ARRAY)
+			continue;
+		if (map_info.key_size !=3D sizeof(int))
+			continue;
+		if (map_info.max_entries !=3D 1)
+			continue;
+		if (!map_info.btf_value_type_id)
+			continue;
+		if (!strstr(map_info.name, ".metadata"))
+			continue;
+
+		ret =3D map_ids[i];
+		break;
+	}
+
+
+free_map_ids:
+	free(map_ids);
+	return ret;
+}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 8c1ac4b42f90..8982ffa7cfd2 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -251,6 +251,7 @@ struct bpf_prog_bind_opts {
=20
 LIBBPF_API int bpf_prog_bind_map(int prog_fd, int map_fd,
 				 const struct bpf_prog_bind_opts *opts);
+LIBBPF_API int bpf_prog_find_metadata(int prog_fd);
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 529b99c0c2c3..b7a40f543b2b 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -307,4 +307,5 @@ LIBBPF_0.2.0 {
 		perf_buffer__buffer_fd;
 		perf_buffer__epoll_fd;
 		perf_buffer__consume_buffer;
+		bpf_prog_find_metadata;
 } LIBBPF_0.1.0;
--=20
2.28.0.402.g5ffc5be6b7-goog

