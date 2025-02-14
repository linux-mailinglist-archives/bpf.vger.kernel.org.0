Return-Path: <bpf+bounces-51568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F26A36026
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 15:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6FD1891E5C
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 14:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B745264A9C;
	Fri, 14 Feb 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCT1c45N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7B245002;
	Fri, 14 Feb 2025 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542750; cv=none; b=ZHAZ90NbqNYs1okcbVxv1yessnP9ES6KL/vx7fXRPvkHx0oHSTHYuaSmd2vOHzJzG8jjhjfYLHHGQNfNyZmq4ROG2jj7WLSGeWIC0Qvml5miyqwyXh1mlUjJKvJga22nKjlYZ6jquil7UwNqYsWzw/3gSgk15qpJQfV7PIdqp4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542750; c=relaxed/simple;
	bh=lhrd0AQI9s3FEnz8yxPBJXpKc3rwdBVNzPcFb5HJIkc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AE/6TPrS/TdlrYyZeqxRp4xRc6qwcgSv72exz5bUw7utAHkHBD97NbPEroVI/lhNyDR+aMA/+jOy+sgW0MUTavQHiGFv5i1NaRejypy7lRE26hQ4UBZgktOwhwpzkSMi9x28WnAkMJTkSFG0b/RfiWR8vMkMBp5AC1Ov1esu0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCT1c45N; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso3827665a91.3;
        Fri, 14 Feb 2025 06:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739542748; x=1740147548; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBaplg3g3rUu8/rRc+aYsCsq7KMcM5ySIdriDejyTSg=;
        b=RCT1c45Nk2EQ0tBof09B/n9cxpnBKH5p4No2aSJcnmqsM9ypoRGc5sr3quG7kXdR4W
         3mXktRKi6RoS/EiPymDKT6Izo0AzpeSzhhAW2pv6DTJqfTmdo+Upab9rhgJv1V6+JOJN
         zO7A3aTokdSXj+WFvggSQfcdbW9jgv1PAfUeMc44cUtWxN2Tv3JfTPjobkeaTbXDHzqB
         XCPxZ8lLOS2vYpzNz4SxwkaacypbsxeanrjjeVQEwvVq3iIztQQtY3oof7p4yVsoY7lA
         XW4cT+Csa/Z3FgOD/XBA7+6FQHBAVNP4aA515G0m4VqD4jiXbwXjlEacnvy06OYnz9E3
         0+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739542748; x=1740147548;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBaplg3g3rUu8/rRc+aYsCsq7KMcM5ySIdriDejyTSg=;
        b=c+KqIvrs9mDlpm3Jm+7+OehhcIfBUI7abi7zv1dD0QYrp3olc9T+tyFqQ5+r42dmkL
         GZecXEPmzXledCVFVVcLpjZahck4e0Sw7QfykQ0H+S1hhQzZG8Azu+BDyQRJ1L6Nif/3
         RIo3B+xjFMmQS/J/fkTnZeoD5Uvf85z5H6lgcZMYAO5kINFA1uf2gjzB1WzXDb4BDlYb
         JOFk7bobxgRzdXmBB7M2tegyCcFl41h6h0HWUIekQnt15x0mTMTyo2jxSJGto+/sQtpB
         uEr9x2A16pqs0dpFA6TO2kFicOdtC3Tu8rcmODKzTMewd1QMtjWOqqFbnS8s3Tvks3ST
         vQHg==
X-Forwarded-Encrypted: i=1; AJvYcCXEUuV7LFfU7I8dl60mUHjzGSfXfECPd99ZmYi/Yc2ZrJJsuLNN0k3ppAGZZYTUuz3ud4BWW3+kqxzJ/Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmsALvWlmsfOFZA54OBGaOZD1gqRiI6BlslbbbnXxWyw0B5WGH
	zA0WlpyiwwvKMQNumsQ/zzRKB19/Q8vB49SiNufb+g85DKtkrsTC
X-Gm-Gg: ASbGncsFycA2MWvly5QxJKEBEsjaq7kL8MybOLzjmOrxwle2IeV+ZFZuPtOF3poZAZw
	tXxTUAbL+dmfoA6AypyDl+SvJmnUw6xbe5qmohJOmYqqNdAfYLgm/65YB1BNPW4xbbXGT7TwPtm
	du2XLC8YHg8UnkTfI29RgXwYp/RqahTdB+9bETxk0vR0UiIvB69o5TBKZs7bax2XUZboKlgo+Tu
	8FMw37ZgOTrJ8JwaxWhXWUvYQbvW9ljpwWYPfABHad3K6VvFIQ8UCbAZAFz2vN9wHnCDHFVbdo9
	0UEtXYc8vL2jW2ea
X-Google-Smtp-Source: AGHT+IG7++srGQQOn/pNXRoiLH3TUX/WBOvYJneTflwiDnq4YhgWbBUWU/eCjlk2DRGvxSCVPRZOTA==
X-Received: by 2002:a17:90b:2549:b0:2ee:d193:f3d5 with SMTP id 98e67ed59e1d1-2fbf5bc1e3dmr17699942a91.7.1739542748368;
        Fri, 14 Feb 2025 06:19:08 -0800 (PST)
Received: from localhost ([111.229.209.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf999b619sm5223205a91.32.2025.02.14.06.19.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2025 06:19:08 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [PATCH bpf-next] libbpf: Wrap libbpf API direct err with libbpf_err
Date: Fri, 14 Feb 2025 22:19:03 +0800
Message-Id: <20250214141903.27711-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Just wrap the direct err with libbpf_err, keep consistency
with other APIs.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/lib/bpf/libbpf.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 194809da5172..6f2f3072f5a2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9145,12 +9145,12 @@ int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_opts *opts)
 	struct bpf_gen *gen;
 
 	if (!opts)
-		return -EFAULT;
+		return libbpf_err(-EFAULT);
 	if (!OPTS_VALID(opts, gen_loader_opts))
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 	gen = calloc(sizeof(*gen), 1);
 	if (!gen)
-		return -ENOMEM;
+		return libbpf_err(-ENOMEM);
 	gen->opts = opts;
 	gen->swapped_endian = !is_native_endianness(obj);
 	obj->gen_loader = gen;
@@ -9262,13 +9262,13 @@ int bpf_program__set_insns(struct bpf_program *prog,
 	struct bpf_insn *insns;
 
 	if (prog->obj->loaded)
-		return -EBUSY;
+		return libbpf_err(-EBUSY);
 
 	insns = libbpf_reallocarray(prog->insns, new_insn_cnt, sizeof(*insns));
 	/* NULL is a valid return from reallocarray if the new count is zero */
 	if (!insns && new_insn_cnt) {
 		pr_warn("prog '%s': failed to realloc prog code\n", prog->name);
-		return -ENOMEM;
+		return libbpf_err(-ENOMEM);
 	}
 	memcpy(insns, new_insns, new_insn_cnt * sizeof(*insns));
 
@@ -9379,11 +9379,11 @@ const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_siz
 int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size)
 {
 	if (log_size && !log_buf)
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 	if (prog->log_size > UINT_MAX)
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 	if (prog->obj->loaded)
-		return -EBUSY;
+		return libbpf_err(-EBUSY);
 
 	prog->log_buf = log_buf;
 	prog->log_size = log_size;
@@ -13070,17 +13070,17 @@ int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *map)
 	int err;
 
 	if (!bpf_map__is_struct_ops(map))
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 
 	if (map->fd < 0) {
 		pr_warn("map '%s': can't use BPF map without FD (was it created?)\n", map->name);
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 	}
 
 	st_ops_link = container_of(link, struct bpf_link_struct_ops, link);
 	/* Ensure the type of a link is correct */
 	if (st_ops_link->map_fd < 0)
-		return -EINVAL;
+		return libbpf_err(-EINVAL);
 
 	err = bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);
 	/* It can be EBUSY if the map has been used to create or
-- 
2.43.0


