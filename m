Return-Path: <bpf+bounces-22794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C1986A106
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 488EFB21E8B
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 20:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F9414EFED;
	Tue, 27 Feb 2024 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6dMF259"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466D814EFDE
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066800; cv=none; b=gN6aafW3+/BzTb9T7iuZqiazt9DZe2EAHQCPCsLuxZQS1pJ3pPqxX20iskGMCcuBsgga2vxq5ziw195y6lChdhMfR1wFLyBMr5mp2ZBhH82FBxmNXtTOdjvqB7CrPreD/cXWXfPsmV5fSr4CLDjw/irYOucBewxHoZAIiqPH+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066800; c=relaxed/simple;
	bh=U6gtvYNVM1cbFEXOzsGpGLs2llhqqH0x3g5sCyrQbdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOVb4XEDp9KHGdbJL11dr2MKCRapzQUPniE0q0BTBynClxx860zJeFjnZQGR4tXLz74Fj1bbZC22JqIpOJtehSyG6o2QHve7znx26+sc30u5ALEohzmzkqesx08bXmvNZd0qrOAQS8sH7LaTACEY7xz7lMVBKYo4vUTJWpLU9+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6dMF259; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so8398303a12.2
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 12:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709066796; x=1709671596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nv9d4uG3mkntgWZefbffEpIEK7nJX3evMpRPaACsep0=;
        b=i6dMF2590hPymMgnuxhcF0Ib0t1GnUfkKqtoIGpH8YtLEefm2LD5rbMVH/3yIVhJGj
         r/DpMeMGGH2GmatZdqlmlA8R564rgoAAADuJxIvlY6if5GHYXaZxgWOe6qEUlq9r20aP
         7Y5Mr1CRMPTuCwQX40x2rI0cE/6VvC+QHQMO79LppdtTFQTigc/PZvWDpTl+y8nrncza
         LM5DVS+BBgYWQEVwjJgZhbDigEAheKmFEfhuFXlBYzNc9aO5Z4IojaAAX+7hEEpz/vnZ
         DTd5u80W4Ql9mceitUSx/davxNxRi6XywGMu6CzWBKo2cnPUNtrI2myH3vF7lJrh5xVQ
         NnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066796; x=1709671596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nv9d4uG3mkntgWZefbffEpIEK7nJX3evMpRPaACsep0=;
        b=BzoAsDA1MLAs/dKI4fhHZ7ZWgljFKKyQWZCB8h1r4T2tjKlRm7ibEih0mHv+vjYyVJ
         JYzyJE6ikSQgiP4vac03CmGynrI+64POixXLU6703iUgnWs5ZqHLzpanIRxQ9XSeTMch
         9kz3FS2M+uCqGgql4jlbVo7E1tTiI6y6EbH+kIsX0xt2NeyV6Wxx4Kr6VbEONlRuzB0K
         nKin+Jjhy9gLT8stJ/z7dCJRc5RDrBujZ5J2ABwLjA7vR7uTIudJmIg+D5ZQZdr2E1kZ
         HRtMMGmhard0kFiLXMpN2WPwk/fmCJxvS4Q9x58ngf5UPsTWwWuuAFTLyXQEPRxA4ahf
         kY0A==
X-Gm-Message-State: AOJu0YzmPKWh3wB309Y2elm8ssXhAJ5FlitBuw5k+XKG1Lg1NOZLvfTi
	pafqRCmX7CpoxuzpuzRbf1h1s4Is3rPD4JnWbuZygUvVCRrT+p/hkcaMhfCYtI8=
X-Google-Smtp-Source: AGHT+IGTTucL+N3lMG+iwPuaEto0NAqTU+Qdh61T3rvUHyYIMrQz8rfj24a8mEh3xCT7gQRrwglZoQ==
X-Received: by 2002:a17:906:a3cc:b0:a43:3d07:803a with SMTP id ca12-20020a170906a3cc00b00a433d07803amr5209054ejb.54.1709066796363;
        Tue, 27 Feb 2024 12:46:36 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id hb13-20020a170906b88d00b00a3d9e6e9983sm1119832ejb.174.2024.02.27.12.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:46:36 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps autocreate for struct_ops maps
Date: Tue, 27 Feb 2024 22:45:55 +0200
Message-ID: <20240227204556.17524-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227204556.17524-1-eddyz87@gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make bpf_map__set_autocreate() for struct_ops maps toggle autoload
state for referenced programs.

E.g. for the BPF code below:

    SEC("struct_ops/test_1") int BPF_PROG(foo) { ... }
    SEC("struct_ops/test_2") int BPF_PROG(bar) { ... }

    SEC(".struct_ops.link")
    struct test_ops___v1 A = {
        .foo = (void *)foo
    };

    SEC(".struct_ops.link")
    struct test_ops___v2 B = {
        .foo = (void *)foo,
        .bar = (void *)bar,
    };

And the following libbpf API calls:

    bpf_map__set_autocreate(skel->maps.A, true);
    bpf_map__set_autocreate(skel->maps.B, false);

The autoload would be enabled for program 'foo' and disabled for
program 'bar'.

Do not apply such toggling if program autoload state is set by a call
to bpf_program__set_autoload().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b39d3f2898a1..1ea3046724f8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -446,13 +446,18 @@ struct bpf_program {
 	struct bpf_object *obj;
 
 	int fd;
-	bool autoload;
+	bool autoload:1;
+	bool autoload_user_set:1;
 	bool autoattach;
 	bool sym_global;
 	bool mark_btf_static;
 	enum bpf_prog_type type;
 	enum bpf_attach_type expected_attach_type;
 	int exception_cb_idx;
+	/* total number of struct_ops maps with autocreate == true
+	 * that reference this program
+	 */
+	__u32 struct_ops_refs;
 
 	int prog_ifindex;
 	__u32 attach_btf_obj_fd;
@@ -4509,6 +4514,28 @@ static int bpf_get_map_info_from_fdinfo(int fd, struct bpf_map_info *info)
 	return 0;
 }
 
+/* Sync autoload and autocreate state between struct_ops map and
+ * referenced programs.
+ */
+static void bpf_map__struct_ops_toggle_progs_autoload(struct bpf_map *map, bool autocreate)
+{
+	struct bpf_program *prog;
+	int i;
+
+	for (i = 0; i < btf_vlen(map->st_ops->type); ++i) {
+		prog = map->st_ops->progs[i];
+
+		if (!prog || prog->autoload_user_set)
+			continue;
+
+		if (autocreate)
+			prog->struct_ops_refs++;
+		else
+			prog->struct_ops_refs--;
+		prog->autoload = prog->struct_ops_refs != 0;
+	}
+}
+
 bool bpf_map__autocreate(const struct bpf_map *map)
 {
 	return map->autocreate;
@@ -4519,6 +4546,9 @@ int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
 	if (map->obj->loaded)
 		return libbpf_err(-EBUSY);
 
+	if (map->st_ops && map->autocreate != autocreate)
+		bpf_map__struct_ops_toggle_progs_autoload(map, autocreate);
+
 	map->autocreate = autocreate;
 	return 0;
 }
@@ -8801,6 +8831,7 @@ int bpf_program__set_autoload(struct bpf_program *prog, bool autoload)
 		return libbpf_err(-EINVAL);
 
 	prog->autoload = autoload;
+	prog->autoload_user_set = 1;
 	return 0;
 }
 
@@ -9428,6 +9459,8 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 			return -EINVAL;
 		}
 
+		if (map->autocreate)
+			prog->struct_ops_refs++;
 		st_ops->progs[member_idx] = prog;
 	}
 
-- 
2.43.0


