Return-Path: <bpf+bounces-53992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F018A60073
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C119742300F
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE1A1F4275;
	Thu, 13 Mar 2025 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwJ3s/8y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0991F3FEE;
	Thu, 13 Mar 2025 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892610; cv=none; b=FHvvJXlN9JUZyhBij0LfCKIdsntcXx7O0y/ttWLg7CgLX/vV4/z3nEC2/FsMF6gQZucjWg+JzhG4C75l4kFYjQosj9wR9A2mr1gzYesyRBL730q8y3XOxjAVqB+U2iQ0mOwq4lnW5hSWeBiftfraLbmliI/CGGoYRrXx9oEwFuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892610; c=relaxed/simple;
	bh=70fK2D1VKNnq07QhB2X+UwPEhOlQN3WCUcZ4aBXmKGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZicpdmRi2dfMbWxe/biaF1VgkUtcoqVMJ6SxZKTKwwcvw3N78IcLyMNc0dJTI+/eRTRV2UWfk0J/wBAfx55S1tJCY9LIvqhjY6bFL3iIvrCeGHvAiY0JAEkunts84h8OxeVvvth8gNIiE0bUGvGfugu53AAaZLKDTWuMlSjOgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwJ3s/8y; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-219f8263ae0so26220135ad.0;
        Thu, 13 Mar 2025 12:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741892608; x=1742497408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFDTynPkfE2pHRJC+9xprWx2iQpT2oTsma7USZIPR7A=;
        b=jwJ3s/8yM2eQtsWXGqnaH8FnOx6qebU5pN4WNMXskJFt1ZUMCpxO/i8QXybz5N4Yor
         Y5xaKSXOLLDe0ErnQDj9uP7gny9U3kknekChRhk7gramuCwKJt8cpmzNYebEnGrsJ4DK
         rVcKOhUhALXtzl3NqweSYGq/S5gMGp7FgTjf+LWNWE0SF2zF7gb7DUsgMqp1RVjDp8Th
         iCn+JSs7sEesZGTzD/JviaSk42DXixfFZNWXjhjORR2StxL3hsh2KjjqetSI6Obukubg
         /dDTrmBxmNoz48e7R+apCgDdCEOLa2I5xtg5yRgywYBCKkM0UtdlKN/bILLHF6nXnDNZ
         osag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741892608; x=1742497408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFDTynPkfE2pHRJC+9xprWx2iQpT2oTsma7USZIPR7A=;
        b=gEg6FMhyWTc8aexcjqF0eYpI8nvWoxsw2q9vG8LP9Y/FZ7GGGQ4/AIVVuw4o8zLBml
         rnBEjzrXSdpVQqP/nY8JgvOVXfkNFevpCMxeXKOS2M3l2q++go/PHUsic7O7UzMWj37t
         +/gnemZtOeJmB8vOa849N9kznheXoEGBB9XE/XvBJEzRefb3JvIls9jUe7vHC5LnHDr+
         FvkeL8K8jb+sToQWLJ+UqxfJvlahBk9kzKZT0NwZdNl5pc5Ozoax82ZZBUnp3uZlI1YD
         qdDOptuPY01OvbOWu0WLSEd16Brg/Yc2/vc6jn3Y8GZxFgsrOv+8XbD1ICoZgL7nwP6x
         /liw==
X-Gm-Message-State: AOJu0YzEcT/xZE3iiEor2tTSUSOYOPTdWx9+n2oyKeIyrc9nad/TrRqj
	q3mtsC9vJpO/CGkrVJiz1/S+PkFlatdNpJ8OceDMZ/A8jM/BaH0ZgRgjWr4qp9Qvlg==
X-Gm-Gg: ASbGncsuYMlDKkar+CrCUuFoi10VnAghKOpyga1S2KvRhQ5ATE6pcAdSZm4bbwWd4MS
	AMsK7awbjETAgf2cGc67C6iH0FdcUi96sqlZwSUMNVkuHnQLyOVnUXFFexoYnJG78Mf8Lc1j1nv
	ILlslqjRkCUdCp7hKQeE3timQBHPV1dqLRyQdLbAcDwChC943HLKR3JnxOvg90GAWjceNxjo7u4
	TYLQS2YEmgwQma4tLSlhjvg6jad5AGsJdbbv2sLPN+Tfid7uE/SjIk1vDTx+SkPM1xuNz07JbnK
	RYrCClVytJW9TqOeU4KKrS81o9wAKxLbmG46iKtL04qt+y7IZHlpZIbpkbr89FCEGpUDiAiIklI
	dFBANyuKXjLPyy9OWR2o=
X-Google-Smtp-Source: AGHT+IGYFzJg++LlVwbp0OBA+5YiTMxibihqcJ86fzzwPBn3xdcqJxXhZItZqAbfAOF5s2RaExnCdA==
X-Received: by 2002:a05:6a20:ce4b:b0:1ee:e96a:d9ed with SMTP id adf61e73a8af0-1f58cad4a5dmr20835403637.7.1741892607793;
        Thu, 13 Mar 2025 12:03:27 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e2f45sm1652505a12.29.2025.03.13.12.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:03:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 09/13] bpf: net_sched: Disable attaching bpf qdisc to non root
Date: Thu, 13 Mar 2025 12:03:03 -0700
Message-ID: <20250313190309.2545711-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313190309.2545711-1-ameryhung@gmail.com>
References: <20250313190309.2545711-1-ameryhung@gmail.com>
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


