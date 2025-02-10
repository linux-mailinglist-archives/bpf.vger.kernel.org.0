Return-Path: <bpf+bounces-51021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA5DA2F599
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 18:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 080627A24DD
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 17:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A623225A356;
	Mon, 10 Feb 2025 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtKHoYX+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77EB25A333;
	Mon, 10 Feb 2025 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209445; cv=none; b=crHhwl3DZPQ87UTAnt9TYv5kgexd6GHkrVMEDg5n6UvrBwf+aIuLrCqYOpcnjdumzBX6mgX5utZnxrzymI/N099zptBnH+VxJ6Du+xRRGfA9Gkhs0I8lm/DulGuPEz0t8qzQOkurhKup0Gz6bOSkETtg1uI41keCn9QiKa6S8Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209445; c=relaxed/simple;
	bh=oVv2JtaDPIKhZsdywXA46ACT2BCLo0/oHTOdRQDrkDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gnhzmny+ZCXnt+mHLYW0n+d0x5EOyIA2qcxJNmXZJsH/GvWBvfSHupX2NamDxzJgkx52TLbsFWLst/PHIpCWvGIXoOM4fZ7kbnRiZSleujnE7ojTxqMrgTPr0iZeO0Gi7C7xoC+dTvYVm8SzNc+tzUnFYCTn34ezBbOnMfZVjjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtKHoYX+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f7f03d856so32555715ad.1;
        Mon, 10 Feb 2025 09:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739209443; x=1739814243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GH5rMBh11R0Ev4mXMfCpLP6RKJCsJzPSkJfSqyVzrk=;
        b=RtKHoYX+uVzGwfLTfJfZtfNO4obFi8225NPB++6y/S7zcWG7JSSI+KCM5McfOHPXOn
         PB7HWJRlCf/FB2QE2MyU6y3lhLdRHN0FU5eOnW8pJegSLJpwah2o4n/K3nisRvJogR6D
         wrAEKPf9fc5NXR0o7SGCHL/kse0SfV9w97hvQexrHeh6e/KH7LYmVimWGnk3RkW2hCD5
         la5TH4TH//HqSQZNgbHyQ8DIYjYEPjMMw5okS8xtqaFVLw2oXwGkjx4lBPAk616aLJ7x
         aMuT4fChu+cFBESmxPqq/AWwFlX43gfNiOe4frdZwCtmyqAsl/SoAJNpqqSwkq2tD/b0
         XSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739209443; x=1739814243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GH5rMBh11R0Ev4mXMfCpLP6RKJCsJzPSkJfSqyVzrk=;
        b=SHNUhsfZXR9Da+EvdjVv+KAQrjQ4lDyzvPc3IFAcETR9VZSoHqrE0LK8l6g6LlrF0i
         5NPmxwmkuWP0aSiyifOvQHEfAXby4iZBm3mlxgUhQKXmstGlJrW2WITvWOKBimKxQK7S
         slV4Vk2NkMsFmPx2e5Ar/bRbOoP24p2Cs2QZ+B/n47j2Kg28tz8u3rAzjLZ/QvAcOU4E
         uesQuLx2ZxXLwftag8g+TNf7EBbRiOVRoFr34zfUjCV0HmnuMWBfSmQLAOeB8oQHTGBL
         plnE6wL/yz7Q3wi0zdAsnKXKZ7J2RiSDEkk/U2/ycnN18MYhlcFDlzXz258RtNe/QFyr
         RJmA==
X-Gm-Message-State: AOJu0YzFqC12GCC0B4PyF+waDSQtMIEdK7jvSsnORt8YNZocVGUL8481
	Lqh3EeZZ+VfOS2yCD3xqY0AuizU+sAbTItbY/QXsFJV2c6OaiJqiWom2sIgi
X-Gm-Gg: ASbGnctT1BG0zwirYwLDrC2+ebxBYaIGInOrf9P6awZd04JiMkOSiYsfr2K7kU0Xbyj
	dw+RZiORJukEuGKmgWCB5uSvXoZaJVQlu9DoYtVCEP9MT4CIuSo1kMxN+atxjLHDEKZeGCiOhlD
	5kn/SFtbNpoY3LF5jrTPMu/IbcFQGxkTuMKRGZJ38JSdlwwdSr6080gE7xIDsmVUtB0dOHu0+q0
	5bwYNx7NsJ9NpmDGffkJfc+/JwyHdVCEBnUicjRB10udq2aMDeUX1PddSBM8iEX1D3Ktc3mFH6B
	J/JAyLWJV1T78jRKVJao/rNa/yA2nRLQOaMmQ8aAoyyp2EVdDKqPk6ml6XRJsB5BTw==
X-Google-Smtp-Source: AGHT+IHmU09V34c4ifLI9dfbFiwDRvX4p09TymP+JHRWRQpwn1l7XlOcPLgFXRKVZ+qb3TldmxANrQ==
X-Received: by 2002:a17:902:ecd0:b0:21f:74ec:1ff0 with SMTP id d9443c01a7336-21f74ec235fmr162670365ad.32.1739209443056;
        Mon, 10 Feb 2025 09:44:03 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa3fb55dcasm5554961a91.4.2025.02.10.09.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 09:44:02 -0800 (PST)
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
Subject: [PATCH bpf-next v4 14/19] bpf: net_sched: Allow writing to more Qdisc members
Date: Mon, 10 Feb 2025 09:43:28 -0800
Message-ID: <20250210174336.2024258-15-ameryhung@gmail.com>
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

From: Amery Hung <amery.hung@bytedance.com>

Allow bpf qdisc to write to Qdisc->limit and Qdisc->q.qlen.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/bpf_qdisc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 6ad3050275a4..e4e7a5879869 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -68,6 +68,12 @@ static int bpf_qdisc_qdisc_access(struct bpf_verifier_log *log,
 	size_t end;
 
 	switch (off) {
+	case offsetof(struct Qdisc, limit):
+		end = offsetofend(struct Qdisc, limit);
+		break;
+	case offsetof(struct Qdisc, q) + offsetof(struct qdisc_skb_head, qlen):
+		end = offsetof(struct Qdisc, q) + offsetofend(struct qdisc_skb_head, qlen);
+		break;
 	case offsetof(struct Qdisc, qstats) ... offsetofend(struct Qdisc, qstats) - 1:
 		end = offsetofend(struct Qdisc, qstats);
 		break;
-- 
2.47.1


