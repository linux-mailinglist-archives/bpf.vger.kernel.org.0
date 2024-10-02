Return-Path: <bpf+bounces-40762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A541598DED2
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 17:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EBC281B47
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5BB1D094A;
	Wed,  2 Oct 2024 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivTACkfe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CE879D0;
	Wed,  2 Oct 2024 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882597; cv=none; b=cf6y2xvJJQu4gwaBuONliAHHvH6ynxsacYVXfW13snuUuDC+LhcrORJYywJX97hWMJ+XdblZig9OBG5GcXgQo0HesrK0q4iZAojrnbMnMbuoP1uxgKJY5rN4/JLQzqGX0EAP92MTv0ZBOoR18eAw58l4UY0sqsIBr2BSwQg2YAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882597; c=relaxed/simple;
	bh=IhqzmrCAVaLbNPfFQSlXvHcZL1XBwRYgh7yR40B9I6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nvGfLjTFBMEKpoLCfpYeZUaea+Epnm715BjcmDHxE80Z8m7FJqpdVzS4MxAaN2cC1KWDHe5B03gPgSZdBYyQ+2LTqixD939zTdvp5q1FVInQIM3M37KFvH9yJgjEZIv300XDBelfBTDvKANmaq48oXTCl3WdHANjDm7tovXZZ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivTACkfe; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b0b2528d8so75143645ad.2;
        Wed, 02 Oct 2024 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727882595; x=1728487395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zc/acfT9kdgzhmkJk3mvwRHkKN76tDWkgF+Kd466Ixk=;
        b=ivTACkfe0XkUI1d+wWhevjoNx8nMBv08ZrgNMhnOP5V2k6HVyWKqZV9EGtIPbzbK/N
         d+U7Cdqs3knEihc/iC2FOVvLCPjx0JLMUZxdndIRGV4k1zp2oFkPpI9ambbLyMtZtH0K
         bfC4PwL4pxhzhIqm629UVGjMAMucBlZXfhqFHo+w/XxLQVIJBmvaIEgEzAHMCMDD6RgY
         tlaPqtabgEoqDbXUnrfU2l2ZFIEVD+8qel6aAAWW3Qd/a6EgSMb1DN8zubfZyNSrz3Ys
         uSNkp0jLOciHpT8UZQh2zmvEwTEgBy2NVHkGhUxPoLByT8yBxqaHi56BHqH700KeyTt3
         +DKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727882595; x=1728487395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zc/acfT9kdgzhmkJk3mvwRHkKN76tDWkgF+Kd466Ixk=;
        b=Muq04c2rUh1Fm0Q76LFzLZjK9QKZygUZO0N1Fndt4YYXOo5WPiW7dRxlRLyI/xaEwN
         nq86FuCjUcKhE3Ax4UdXQIiT+0rzr65VTSpCe20hISqY6a5+HhQz5f5/DviYz8WRq87o
         hpAMX4bm2iSuzg82Mt9MXzXjL0K6c3ML7B2aNmMfCIdzJkY3l2MnEmKNkidzZ9A8YaqZ
         wGHmR+A8r29w7JaO9+YyNQPpnWyMPzTvdA1ZGVm1yXo9GtC7t1DfI9wRm1nDmqPsUFl2
         UmaWsjOfY2wbIzrDMwfbAQgJGuJBQu1KZVZ0cT9uXM06aYtyqbXX/75+RO7f44nKGAP0
         ijpg==
X-Forwarded-Encrypted: i=1; AJvYcCXUMMehm7nN+TH2B6dJ4Uws0gCsP/cEgeZw5ZPzuQIm6Pi2uVOUiI3dwdoJtqC3aQqJ7Jw2U7EEo/wpY9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT4PbTxkgET09hzxj10Qrr3XAHqK21H4LYpjB6SG3VLh53v6nj
	Jd457OFuKNRGHF3c2Z2c8wJsgZevgqFrGig95v1vXbLUpPVtiRLI
X-Google-Smtp-Source: AGHT+IGfR5F+pywTaDc8v9Dwk3vyrfjZ2eqpYVA73qhV+s9zOuMWjXcpLzNZRGP2SklMP1oATSisAg==
X-Received: by 2002:a17:903:244e:b0:20b:9e14:c138 with SMTP id d9443c01a7336-20bc5a1d696mr64890995ad.23.1727882595281;
        Wed, 02 Oct 2024 08:23:15 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d89508sm85171885ad.64.2024.10.02.08.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:23:14 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@gmail.com>
Subject: [PATCH bpf-next 1/2 v2] bpf: Simplify code with BPF_CALL_IMM
Date: Wed,  2 Oct 2024 23:23:07 +0800
Message-Id: <20241002152307.388565-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No logic changed, simplify code with BPF_CALL_IMM.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53d0556fbbf3..26fe57c79f93 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21157,7 +21157,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 				func_id_name(insn->imm), insn->imm);
 			return -EFAULT;
 		}
-		insn->imm = fn->func - __bpf_call_base;
+		insn->imm = BPF_CALL_IMM(fn->func);
 next_insn:
 		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
 			subprogs[cur_subprog].stack_depth += stack_depth_extra;
-- 
2.43.0


