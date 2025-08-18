Return-Path: <bpf+bounces-65896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 914E5B2AE8C
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 18:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32953189BF47
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F56A32A3E8;
	Mon, 18 Aug 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if2o4Mcx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447651F2361
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535895; cv=none; b=NSGL75AyoKnaLvaR+SgzorC60zY/7fhT6cPVD6puh9fORMjk2EqKPmsUj+NjdlP2HCkJln+6IDHNs6XJj8+qfPe4Dg5rHCjN594CifryiodBsGu2MHAGZtsugHTRul+z04qxQ55Js0dMhJBL74VrAsKReyS0PR+cQKhCnzyACD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535895; c=relaxed/simple;
	bh=bJzZI8XZSTuS0OhhL/NPcJfBF4xRSW4rZ6voXVZlGR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QaVU5ior3m32uoG/93lamfqqJKDGMQC4R5/eXJF4VU5/bDMXO/iReXQbPSYggcGg9GjUVaVMC3i5rp8DMbzRzp9neX4Q/H5iq/OscfqN3Fho/yKhzSZDtsT5+Chqh+P0MkZxnhzHuHrMfbK7fCvHzjNwjC9wDPOb3y9FgU0+YgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if2o4Mcx; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e7af160f1so297231b3a.1
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755535893; x=1756140693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/euaJ/7fPALo6zCeBHiM1Bg2F9S1pSEtYGTextEL8o=;
        b=if2o4McxKl1URXgDsJkwbavY104A/G6w6ZbBsFWaqEnIay7QdU2lwRfhS/ra5/DM6L
         uwvvCzyCi84Yg69427OBwgI7gOyeJcxeDZph2MjzI2MSW+7TU589mD3I1zNPIjBQken3
         xEkxXVa7aoytJQVizPipM3KjCstTM325u1YZ4HZ6wHyGw/A+JdZkfbNa6V4zXKhw8Vou
         mdsLT3WCTrIqvsHJ5xfbXeIidP4UnYrlyTUEbGHaFiuYkciZ1H8sxdQ1TbnKT9FxUwiH
         t0dZ8DOEMacxT1QPXdqbLp9rDZ+2XpaLPpip2/z9vkcYMz5kkHkZ+nqkCmRUzuPK/UgN
         2nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755535893; x=1756140693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/euaJ/7fPALo6zCeBHiM1Bg2F9S1pSEtYGTextEL8o=;
        b=rlU5L6GZmVeHG0Kq9afBZmEeJHRzL0x2FtsB6w14VhVLwxIPfF/t/B0yEK7gxj2qls
         JOk+HdXqN4dMmZ3VL8IhfjNuMo/iykbW1SB0eeCVFmPCRu/EiNX+9Agd6guQQNQGQo0U
         myIGV1ucwCx/nkZKPgqhlr+IiEgp7mS3UEmyEKLL+KveCdDuc23FfrtEvHep3KzHWv/A
         HbkUGhniuOYZNY+t+otwnJ/4piHqLeZRRqaqrmXUxrePk3RQ+e0rF11NwryAGjNk/P7B
         6yqntZ1FXfeOBqfzr/nT/XjMXbK/yCDfWvrOSPhlUdcPtlTp4o8ZrYfV7LnINrVXiMi6
         3YUg==
X-Gm-Message-State: AOJu0YzE6Qaz/NnbAxhTwtBeeDTA9pjf/yKWns86EVAf4opHA6lIHtMB
	uE/DMNoI9yH7NXy6RvQfdEzo+r8W0OkKHk7OVwUIdyigWxJmVW9GXrqW2NXiu9PQ
X-Gm-Gg: ASbGncu73L/DRMbanemw4QnMFs3rZwEXqfXTdArMYyZjvFRM/ZArl00oexyApFoF5s6
	LhaBWjXVrG1ZGe9OTXNidiOlMzeWD7A9sDHl0GCCcS7oMBzfVI/ySNq6KGSa92Jo5Vt+60vEPg2
	XA63zhNfujHewQ2tdoqRv2ppPyAdu166ArJYPDNGqJtkiz4JYE1BhoDYaqHdImx3QR7e5UW4Wzx
	ces+amhWv1pQazy9h9PZKjGPTjqt6pZRJBBe//GHEpRdJnq73pG7fvD5tN9qyDe/o3OKLlW66eb
	g2rSmVkVbbSLc87bUm2Uuj5JbLiTAiOXbPu7C0kEZbdJpPMAQGQwcSPNWTrkRADqHwGqQjHrQ8i
	6UdLfo0HNGhV0fr3ftQkEq3V1MGDRYF9r
X-Google-Smtp-Source: AGHT+IG3tCaALUVFMlL62sAF1Aer4Z3KNXGigh9s57zLws3FTq92I4JmGnuH5rbR4JeZVKa7VTkUxQ==
X-Received: by 2002:a05:6a00:23d1:b0:74c:efae:fd8f with SMTP id d2e1a72fcca58-76e447dd0a7mr14481600b3a.15.1755535893057;
        Mon, 18 Aug 2025 09:51:33 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:648:4280:48f0::2e2a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d1101fbsm132450b3a.31.2025.08.18.09.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 09:51:32 -0700 (PDT)
From: Vincent Li <vincent.mc.li@gmail.com>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Vincent Li <vincent.mc.li@gmail.com>
Subject: [PATCH bpf-next] bpftool: add kernel.kptr_restrict hint for no instructions
Date: Mon, 18 Aug 2025 09:51:13 -0700
Message-Id: <20250818165113.15982-1-vincent.mc.li@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

from bpftool github repo issue [0], when Linux distribution
kernel.kptr_restrict is set to 2, bpftool prog dump jited returns "no
instructions returned", this message can be puzzling to bpftool users
who is not familiar with kernel BPF internal, so add small hint for
bpftool users to check kernel.kptr_restrict setting. Set
kernel.kptr_restrict to expose kernel address to allow bpftool prog
dump jited to dump the jited bpf program instructions.

[0]: https://github.com/libbpf/bpftool/issues/184

Signed-off-by: Vincent Li <vincent.mc.li@gmail.com.
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 9722d841abc0..cf18c3879680 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -714,7 +714,7 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
 
 	if (mode == DUMP_JITED) {
 		if (info->jited_prog_len == 0 || !info->jited_prog_insns) {
-			p_info("no instructions returned");
+			p_err("error retrieving jit dump: no instructions returned or kernel.kptr_restrict set?");
 			return -1;
 		}
 		buf = u64_to_ptr(info->jited_prog_insns);
-- 
2.38.1


