Return-Path: <bpf+bounces-23215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D540886EDC8
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77CCCB22C02
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFB963AE;
	Sat,  2 Mar 2024 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmgZSB9t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C86FB5
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342381; cv=none; b=awvNXW4tSWIvyt+XB+Q6JmVLThAI2jtXrecMl5frCIZxwGB0usCp6cZ09iPCNP576QZi7M3Gb2BMTESnrZcCEl4C7CGlRdiuUgdwn83b6at1fNNxV+TKn93IM1eyianntJFr/vt+rjXpldbHibmA2IVLp/9E6Sa3Yk14uBiWEOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342381; c=relaxed/simple;
	bh=7n3VOltWg2CvMWA84SRE1wH3LRcYRxUITz9dnx52KQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHsq0iI0sHL6PWNBCnVZfx9fAO9uBvwcHdL+SS2Q6BhJdIgxEM532AG0Vn1PMS6ZfYt8W3PdRSy7qGMjzIIU9nJoGiKRy/jqKsD20V3PB1Ayh46OLnKoYaf1h1biHLF5R4gZ1/Uo4V5NrETVZdIuD0mwe4pSIkXkFtrpKz3z+V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmgZSB9t; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d27184197cso34829091fa.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342377; x=1709947177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v11JrOpQ0vOwRfRtr1r+yvwVR9OS5PTJrump/SfFJRM=;
        b=VmgZSB9tpfIzL6HlU6LKJcgYFDMyeLejeUkmR9sg2jYPKCzPqMJIF4PSuqpGfRecVd
         pVb/MxSnh7amtzGAUVLJ6LUWPhkprddglBJgukHev1kp2xuKIQpKEJ3lud5Rn2pfr5JQ
         qI//TdjlBTuXdu2vUDEU8DmPWdV6cvCxskpnZ2I0BxcGwblTGx5w7tl0oNUJYjaCmOqY
         AQPIJPIOjBo/FhF7NCHfL7ea/vdm/PXPF6syOdDiWnnJYSflK1lKYHfXXPaoZj9T0UkK
         BeJFUTzyOdLBg8RMe8qL9aM0jSLWzkSrlgAD8jLQZpDx1GWNzAqo3u45W5QxKAZ8Y7rC
         0DIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342377; x=1709947177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v11JrOpQ0vOwRfRtr1r+yvwVR9OS5PTJrump/SfFJRM=;
        b=RJD8pb3z/1Hzsy+j+A3kOhRtveJv4UjOlm730vEh4bNFEGlT2DequyMekifc8huqqK
         /KzAxmziib/drAOvdSV4JG5aWQG/st7BboG+HnqYQFpNW90AlhiCo9iSHW1iu7w+CEbM
         eLiSns224XcH+/sbE6G8u8ii2G5G75B7t8ZZ8tuaQV/fbNhzmLMS9uMPDoXL+1JkbY1r
         TIJcQLROdq5cIEYxiazOFANab/fwJj8VS2zwXRMVLJOk9fOep5dyz5vbW9H0IIjHC/QK
         KMSqjqL1aF4GqwZbq5Ns/kZbfVaeUWDF05NMSLG2cRp4FaGo18pJGFoKD1M85YuBS4zp
         0K3g==
X-Gm-Message-State: AOJu0YxnkIre+Gc+8Tn+Pcrr30UcFxr4UpjpTsXUjO7VPTGpclThnry5
	bWpuGJZntu07kkFo0dmESgQUopxgXPcsYak8i6sVALdHGxFLVPoA2q+Ejn4t
X-Google-Smtp-Source: AGHT+IGpB5wOMHq70nPcyy7vlDPZWnYI3UYcqxyE+oDDYOU7Xps8/8n3gbUwCh9RVn2ppi2poXQXgw==
X-Received: by 2002:a2e:7316:0:b0:2d2:5f8b:1382 with SMTP id o22-20020a2e7316000000b002d25f8b1382mr2376977ljc.2.1709342377006;
        Fri, 01 Mar 2024 17:19:37 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9657000000b002d295828d3fsm767386ljh.9.2024.03.01.17.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:19:36 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 02/15] libbpf: tie struct_ops programs to kernel BTF ids, not to local ids
Date: Sat,  2 Mar 2024 03:19:07 +0200
Message-ID: <20240302011920.15302-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302011920.15302-1-eddyz87@gmail.com>
References: <20240302011920.15302-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enforce the following existing limitation on struct_ops programs based
on kernel BTF id instead of program-local BTF id:

    struct_ops BPF prog can be re-used between multiple .struct_ops &
    .struct_ops.link as long as it's the same struct_ops struct
    definition and the same function pointer field

This allows reusing same BPF program for versioned struct_ops map
definitions, e.g.:

    SEC("struct_ops/test")
    int BPF_PROG(foo) { ... }

    struct some_ops___v1 { int (*test)(void); };
    struct some_ops___v2 { int (*test)(void); };

    SEC(".struct_ops.link") struct some_ops___v1 a = { .test = foo }
    SEC(".struct_ops.link") struct some_ops___v2 b = { .test = foo }

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 49 ++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e2a4c409980b..2c0cb72bc7a4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1146,8 +1146,32 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 
 			if (mod_btf)
 				prog->attach_btf_obj_fd = mod_btf->fd;
-			prog->attach_btf_id = kern_type_id;
-			prog->expected_attach_type = kern_member_idx;
+
+			/* if we haven't yet processed this BPF program, record proper
+			 * attach_btf_id and member_idx
+			 */
+			if (!prog->attach_btf_id) {
+				prog->attach_btf_id = kern_type_id;
+				prog->expected_attach_type = kern_member_idx;
+			}
+
+			/* struct_ops BPF prog can be re-used between multiple
+			 * .struct_ops & .struct_ops.link as long as it's the
+			 * same struct_ops struct definition and the same
+			 * function pointer field
+			 */
+			if (prog->attach_btf_id != kern_type_id) {
+				pr_warn("struct_ops init_kern %s func ptr %s: invalid reuse of prog %s in sec %s with type %u: attach_btf_id %u != kern_type_id %u\n",
+					map->name, mname, prog->name, prog->sec_name, prog->type,
+					prog->attach_btf_id, kern_type_id);
+				return -EINVAL;
+			}
+			if (prog->expected_attach_type != kern_member_idx) {
+				pr_warn("struct_ops init_kern %s func ptr %s: invalid reuse of prog %s in sec %s with type %u: expected_attach_type %u != kern_member_idx %u\n",
+					map->name, mname, prog->name, prog->sec_name, prog->type,
+					prog->expected_attach_type, kern_member_idx);
+				return -EINVAL;
+			}
 
 			st_ops->kern_func_off[i] = kern_data_off + kern_moff;
 
@@ -9428,27 +9452,6 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 			return -EINVAL;
 		}
 
-		/* if we haven't yet processed this BPF program, record proper
-		 * attach_btf_id and member_idx
-		 */
-		if (!prog->attach_btf_id) {
-			prog->attach_btf_id = st_ops->type_id;
-			prog->expected_attach_type = member_idx;
-		}
-
-		/* struct_ops BPF prog can be re-used between multiple
-		 * .struct_ops & .struct_ops.link as long as it's the
-		 * same struct_ops struct definition and the same
-		 * function pointer field
-		 */
-		if (prog->attach_btf_id != st_ops->type_id ||
-		    prog->expected_attach_type != member_idx) {
-			pr_warn("struct_ops reloc %s: cannot use prog %s in sec %s with type %u attach_btf_id %u expected_attach_type %u for func ptr %s\n",
-				map->name, prog->name, prog->sec_name, prog->type,
-				prog->attach_btf_id, prog->expected_attach_type, name);
-			return -EINVAL;
-		}
-
 		st_ops->progs[member_idx] = prog;
 
 		/* st_ops->data will be exposed to users, being returned by
-- 
2.43.0


