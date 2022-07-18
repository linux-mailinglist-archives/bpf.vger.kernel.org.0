Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01102578D0A
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 23:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiGRVqr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 17:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiGRVqq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 17:46:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073182125D;
        Mon, 18 Jul 2022 14:46:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g4-20020a17090a290400b001f1f2b7379dso633957pjd.0;
        Mon, 18 Jul 2022 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GM8+8p1/J6+pvSGth1ereNERHh7ix8LfwtKYNnc1Yxg=;
        b=jgcYn+YC6i33CFfygb7e9U5GlpP/bJ0AV/VZXeqqL3Jc02Ng+sA+DrgA0/1OK4EpMo
         WEccNc2FoNGfHrFYx1dwY03rglWXab6oKFJ1hJGn5s56bBTyy+Pqu2qHdcgohPhvJVFh
         D5lP5fk5rlAKMoPSrIRPnq/XuCNppfdKD9nrGha2CsejmYvHFx70qtxR9FeqR7+f5dVt
         LZvG3iyj2ltfq3LxlRpi9//zrWKnGSAaBOhpmr74ITjke3uo/D5jQqq8lAAyI2xPoomY
         tAF9VaQK1KuB9EsxiVk9lQG4+UzynlHTgw6NYgpQ8SxS2pAsqAS/9/F2wlQH0X4Mo3C2
         X0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GM8+8p1/J6+pvSGth1ereNERHh7ix8LfwtKYNnc1Yxg=;
        b=sUF/IwOZC5zRRNvvNJpJCuUvfCOnuKv0ecbt3cqjbJMakkhdzJN9K1DqHZcAmrBbDi
         XCbJy7QrOVFODQ8oj+idl9/+EziZpoYTcvMPSy7SM2CbymfanLDd/cVeYDi6a4ne0O0T
         guHsM3S9GHLTwqts5Dt7l0sYPLMTwrSpdESkuEP2fgOu1CKYx5mWNjD/by6D38ricIkY
         b5li40j6N2lQ/w/0Y/ftksBZGJggEFf7BchD9dvSn5U/ukHnm7upxDvSSE7fd80f/XNa
         H07Qe6g67DsmgGTZyv2fTNcEcrKBfcPE5GdRtN5LFII1yDSIapcI/TZt8WpgLCycOgWG
         2dhQ==
X-Gm-Message-State: AJIora+UDWWYPzt7LKNBKsNIBli6WdlBmfjnjdvnCS8ZnmwTi0yjAsRF
        7NzmUJyQZUl7XNQ9lYHL1A==
X-Google-Smtp-Source: AGRyM1vvUiEJKErL+DrhF5cRKF825CvG3u21GVvK6FHmCOMLT6owA1qQPK018cZae5WSCmi6/I73Ag==
X-Received: by 2002:a17:90a:f0c8:b0:1f0:671b:f594 with SMTP id fa8-20020a17090af0c800b001f0671bf594mr39853106pjb.238.1658180805505;
        Mon, 18 Jul 2022 14:46:45 -0700 (PDT)
Received: from jevburton3.c.googlers.com.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090341d200b0016cb98ab5b4sm9289657ple.153.2022.07.18.14.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 14:46:43 -0700 (PDT)
From:   Joe Burton <jevburton.kernel@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joe Burton <jevburton@google.com>
Subject: [PATCH] [PATCH bpf-next] libbpf: Add bpf_obj_get_opts()
Date:   Mon, 18 Jul 2022 21:46:33 +0000
Message-Id: <20220718214633.3951533-1-jevburton.kernel@gmail.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joe Burton <jevburton@google.com>

Add an extensible variant of bpf_obj_get() capable of setting the
`file_flags` parameter.

This parameter is needed to enable unprivileged access to BPF maps.
Without a method like this, users must manually make the syscall.

Signed-off-by: Joe Burton <jevburton@google.com>
---
 tools/lib/bpf/bpf.c | 10 ++++++++++
 tools/lib/bpf/bpf.h |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 5eb0df90eb2b..5acb0e8bd13c 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -578,12 +578,22 @@ int bpf_obj_pin(int fd, const char *pathname)
 }
 
 int bpf_obj_get(const char *pathname)
+{
+	LIBBPF_OPTS(bpf_obj_get_opts, opts);
+	return bpf_obj_get_opts(pathname, &opts);
+}
+
+int bpf_obj_get_opts(const char *pathname, const struct bpf_obj_get_opts *opts)
 {
 	union bpf_attr attr;
 	int fd;
 
+	if (!OPTS_VALID(opts, bpf_obj_get_opts))
+		return libbpf_err(-EINVAL);
+
 	memset(&attr, 0, sizeof(attr));
 	attr.pathname = ptr_to_u64((void *)pathname);
+	attr.file_flags = OPTS_GET(opts, file_flags, 0);
 
 	fd = sys_bpf_fd(BPF_OBJ_GET, &attr, sizeof(attr));
 	return libbpf_err_errno(fd);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 88a7cc4bd76f..f31b493b5f9a 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -270,8 +270,17 @@ LIBBPF_API int bpf_map_update_batch(int fd, const void *keys, const void *values
 				    __u32 *count,
 				    const struct bpf_map_batch_opts *opts);
 
+struct bpf_obj_get_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+
+	__u32 file_flags;
+};
+#define bpf_obj_get_opts__last_field file_flags
+
 LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
 LIBBPF_API int bpf_obj_get(const char *pathname);
+LIBBPF_API int bpf_obj_get_opts(const char *pathname,
+				const struct bpf_obj_get_opts *opts);
 
 struct bpf_prog_attach_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
-- 
2.37.0.170.g444d1eabd0-goog

