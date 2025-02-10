Return-Path: <bpf+bounces-51022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6891A2F59E
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79146166F09
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D62257435;
	Mon, 10 Feb 2025 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iy8+GV85"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F603255E24;
	Mon, 10 Feb 2025 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209447; cv=none; b=cUluBES+mMC4/Gec7NfzcM2kFPw5yJNrSsOfCtENtp74QHEeywJcTP4zxNdnyguWaIQhXYiZCkedR1NUNN4KzjEP/KXwf6ceAabokOQefEm7uyuhQzo1wFw7cvYxxbNCKw2E8h9ayvXIItRCih/ohQotGtpfSVUfDnALF8qKxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209447; c=relaxed/simple;
	bh=70fK2D1VKNnq07QhB2X+UwPEhOlQN3WCUcZ4aBXmKGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAQytrsiTruVUByI8LvXN5iORiZbGqP4uTAj3mlbiF2wn4VtcGiUXmECUkg2pHrTHs69ciAybTkEflrorRYF9/IcZgFGBceLJYyWqYzaKsyf+nprCfOn04mLZUOQwM54KxTGSbCnKy2dvS1sOhuP/TtseDaaHmgjwgtyBjdrKgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iy8+GV85; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fa1a3c88c5so5856251a91.3;
        Mon, 10 Feb 2025 09:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209445; x=1739814245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFDTynPkfE2pHRJC+9xprWx2iQpT2oTsma7USZIPR7A=;
        b=iy8+GV85PskrQvMKjfM8fSngEIZutVhDE+WTz7T2Bv0Kf4DBGGFSfy2BxeOOmssycs
         cdzyYJHrCMA5q0YsUuXHokPNhb3k8WPTuOHlAH8HI0ErR2D7qGNUWP0VOyh1YoRudYni
         GnQypO4ctnBdYdE73Lh+Ny/XDp9kIElnWKzyBU85Y/Yqow8ChA6c3NixBEUc6Pl5A4qR
         1hF5LyvD7n65AoFpfChQCTC+wQW4aZ3bs5QedAW95oMhtuq62AxxO4AUCS8E4uLsSbAb
         tKFtW6Q0hySdM54GdEUTXW6SFT7gjLSV7E4ro/qjwiMuFUT18i/JLgKN3vzr8HILPduQ
         N62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209445; x=1739814245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFDTynPkfE2pHRJC+9xprWx2iQpT2oTsma7USZIPR7A=;
        b=T91YDJHRFgzIa8cge825BjI0ZBxokR05iQh7bHk/HwHJxmLluz3OxFher9QGWnJNPk
         k/kdOjwNnk5IAw8i4mqNB/tokJtyMBtTX/o9Q10LwMpQjAo5sIcbLtYCihvBju+Z5adE
         XRUuGmx8mohghAuhgR/lWf7Opy6kdC3GGN1bioOL2vIuX92SC8isoLl2gGAyku58yVpD
         7VDWwZgk1Ni5bZ8R/fg/iarRKZdGF9UKo8oIOAFkum4V8oJ+ri+9etIiIyfZaihVIIhN
         MD7g4WMYHsQ6gs0CBNM9kAVv6y5aDQb4NVnfiYVwetG4eXU4q2QcTAwjccy99MUIZ1S5
         oRQw==
X-Gm-Message-State: AOJu0YzWArZ9Y+0cOMYdSY47NPWgrzde7Dmis12JHE9cbtl4I9LNzsg7
	nRAis0CG4Zq5WjVxBwF26qrqudXW49xWHlAHBJR8mvmgwjEJ80ox237N28yR
X-Gm-Gg: ASbGncsvYjVMqtG8fuUvZZCTSyr5PfPbGe9U8Jexu0YDnxl0gkkezt2G8E217TqE7xE
	wsrGqatYkJEvVMg/FFXViBffGXvK0JdfNQ56VN3ry0pFJBy2KHcTCOfYH1ldG9hNVcK5N8rtWoi
	xChIjWUKI7fwu7ctW91BjB7dFi4/ET+ESYWBlJI1u8joVXfz43XG/m8CNOrm7cfUjWr784J07I5
	fN8rtmeJ5pkN7tQvmKPoHeJoCOpvGRYhl+DJAx3uOvSv3hYdUw6jGABGr3Oi/3DxaobGO+pU0yt
	x4u4uckR5W2ZpgPx0i6tofoOTTB8U+R9VFQjagSi2bMe6IsykThmrn85Xx2pDt2uxQ==
X-Google-Smtp-Source: AGHT+IHQdIsQnjXidn38NrupTsTDhwUte5TzKjxyFG6wFnYd2ISop6Kb1umbQ+VzZ/l+yirz/I3BGQ==
X-Received: by 2002:a17:90b:3144:b0:2ee:8008:b583 with SMTP id 98e67ed59e1d1-2fa9eda446cmr634475a91.16.1739209444142;
        Mon, 10 Feb 2025 09:44:04 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:44:03 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 15/19] bpf: net_sched: Disable attaching bpf qdisc to non root
Date: Mon, 10 Feb 2025 09:43:29 -0800
Message-ID: <20250210174336.2024258-16-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210174336.2024258-1-ameryhung@gmail.com>
References: <20250210174336.2024258-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not allow users to attach bpf qdiscs to classful qdiscs. This is to
prevent accidentally breaking existings classful qdiscs if they rely on
some data in the child qdisc. This restriction can potentially be lifted
in the future. Note that, we still allow bpf qdisc to be attached to mq.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/sched/bpf_qdisc.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index e4e7a5879869..c2f33cd35674 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -170,8 +170,11 @@ static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 		return 0;
 
 	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
+	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 16);
 	*insn++ = BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0);
 	*insn++ = BPF_CALL_KFUNC(0, bpf_qdisc_init_prologue_ids[0]);
+	*insn++ = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1);
+	*insn++ = BPF_EXIT_INSN();
 	*insn++ = BPF_MOV64_REG(BPF_REG_1, BPF_REG_6);
 	*insn++ = prog->insnsi[0];
 
@@ -239,11 +242,26 @@ __bpf_kfunc void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, u64 expire, u64
 }
 
 /* bpf_qdisc_init_prologue - Hidden kfunc called in prologue of .init. */
-__bpf_kfunc void bpf_qdisc_init_prologue(struct Qdisc *sch)
+__bpf_kfunc int bpf_qdisc_init_prologue(struct Qdisc *sch,
+					struct netlink_ext_ack *extack)
 {
 	struct bpf_sched_data *q = qdisc_priv(sch);
+	struct net_device *dev = qdisc_dev(sch);
+	struct Qdisc *p;
+
+	if (sch->parent != TC_H_ROOT) {
+		p = qdisc_lookup(dev, TC_H_MAJ(sch->parent));
+		if (!p)
+			return -ENOENT;
+
+		if (!(p->flags & TCQ_F_MQROOT)) {
+			NL_SET_ERR_MSG(extack, "BPF qdisc only supported on root or mq");
+			return -EINVAL;
+		}
+	}
 
 	qdisc_watchdog_init(&q->watchdog, sch);
+	return 0;
 }
 
 /* bpf_qdisc_reset_destroy_epilogue - Hidden kfunc called in epilogue of .reset
-- 
2.47.1


