Return-Path: <bpf+bounces-52256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B131A40AFB
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 19:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E6D17D948
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 18:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722CE20C469;
	Sat, 22 Feb 2025 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ng68kHbs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD3720C008;
	Sat, 22 Feb 2025 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740249072; cv=none; b=pMq3pm125phQj45mmkyFrairtcPXrnTtEcFWadVKXqgNXlUa/1lJT1krY5oAQcvKYDoTQGRITb1BtKx04QQtwu4C89LBhhnXmBeg7bWSyXMmh+9034fUenwCY6p5d2e/EehgBzWazVrdfh5PSZ6Pah8g+iRBLxO2a/kZKNZxJOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740249072; c=relaxed/simple;
	bh=gRk2yRabhWhPWhADGM+Ok2+mzIHtLDY2SIR0tGl8w4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A/tQYjC7grpHcFAvsbDC4hUIfl8pAEU2Q5/X2VBcxTZY+o52xu/4H8p4Q1f8KPk28Lrou0GAZszaMRHAs++cEl8rl4pDinPM+5VNndAx6PzTB0yF2oW4GSILcWvD+B3rXvAMRZrOntGEFoCrBTYOdVVQDSC4PLbHlDt9UzSReV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ng68kHbs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220e989edb6so87235665ad.1;
        Sat, 22 Feb 2025 10:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740249069; x=1740853869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hBQjwKCpi/rRVV/Ve5h9twAin5N57JR7ZeRSA+Dds0=;
        b=Ng68kHbswcHraLFi4WERh3QsALEMYgqge2XCZxtTYy33AQ9AlL8Nwn8kvqrQ/ibZf0
         Lg4MIVa0kjfWxM577BC6NWziBflriTa28UcxdYu8IkjbBsXpJt5mJBUCNVPnhTO67lfY
         Dajg5kmTvANsmTla6aphLuBeVTIFh1aYtbhCsOzGqNj5PhCrj4bn71LVsu7SOmp0K+2t
         sMQLcJbr614Lsy1kBI1WAqsAaJk5ICWX70oxssrqQv7RtB6guB9MOcuzHjjPg9my9Lfq
         m1xv9NqhORyknUoRZrwlz44avEDjsyqLn4xHHvZWLX3J1krAmHPzDvdIsLhirsHpLiOm
         64oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740249069; x=1740853869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hBQjwKCpi/rRVV/Ve5h9twAin5N57JR7ZeRSA+Dds0=;
        b=C9kNobamtR4kEblky/5a/WSdI+hd3MFe2ciibF+/phoHs0ZPqa/duwsNrCxxo9D1l0
         K2jXODUam5q6zCHrxASVl6gRpj3egMSvRjtCOf+RFbdyE5H90gG3J1P0A/wDqKvmpFD3
         SBpuz5fDGl1qxLi4JidXQeSCrneVGZBr6Sc2/riDerd+32A5Xr/xL6MGI2hycc01dLsR
         Wf7+SVE66KzNXTCzN5vqfqnOgEDdAtlCyT/Asi7jqfXmqVKwF2WV/X16G840vjetfWaa
         T+XZPOBuN5VowX/6/np2AQsrAWf6/iQLP15lrRJBHZsHQ5fgkgOArqF4RwwKL9bU7ZEZ
         N45g==
X-Gm-Message-State: AOJu0Yz/DJpCXOW4AzvK/RZyMcNXwYTgS3Ab83lde7u/x73KXofaqY90
	XtYzH7zh3ATgKYuS+iDrE+SP2C4ZNzsm5CtmM9Eo5gTyO3IXhtM27kFKMg==
X-Gm-Gg: ASbGncub3CTa6QLBhgey80QrjU7WpIJRmgIPDgs6KQX/AY2E7HbXcgxt1kVA7F+DPVE
	Zfov13+c5UrbFc3qzS4JuoAB9/UHcHGzr6MJA1K0Idu2wbFc03dCyPgyFCHUvybjowM1E45/Ri5
	1ESKUATzWVw2/tRFj5Ikf175d5yEvc7VvSNxtg9mm6t0e0/QxVMVdMX4iH/x7chbED99ZRxVrZ2
	uWyUHb0sfDxCF/v7iqJUi5liA1QV+OXr2RH5X/aOM3WTmqVDYYWPjqnjId6A7XqExZWj6s6+PuZ
	MdRzIF4IXbhpzPbzJIgwtIZ+Jbx3wlHjQeTm2xBN0plPcc1tvfsbZqM=
X-Google-Smtp-Source: AGHT+IEcJ5NIW7/K149wntM9GRaFkqfROC7xpdTfpsgut2DclceiUxD+9v++C9/yfx1G78OhKHi1Hw==
X-Received: by 2002:a05:6a00:8d0:b0:724:59e0:5d22 with SMTP id d2e1a72fcca58-73426d8b897mr12304801b3a.20.1740249069452;
        Sat, 22 Feb 2025 10:31:09 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:2714:159c:631a:37c0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73250dd701bsm16442959b3a.131.2025.02.22.10.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 10:31:08 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	zhoufeng.zf@bytedance.com,
	zijianzhang@bytedance.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next 3/4] skmsg: use bitfields for struct sk_psock
Date: Sat, 22 Feb 2025 10:30:56 -0800
Message-Id: <20250222183057.800800-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250222183057.800800-1-xiyou.wangcong@gmail.com>
References: <20250222183057.800800-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

psock->eval can only have 4 possible values, make it 8-bit is
sufficient.

psock->redir_ingress is just a boolean, using 1 bit is enough.

Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/linux/skmsg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index bf28ce9b5fdb..beaf79b2b68b 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -85,8 +85,8 @@ struct sk_psock {
 	struct sock			*sk_redir;
 	u32				apply_bytes;
 	u32				cork_bytes;
-	u32				eval;
-	bool				redir_ingress; /* undefined if sk_redir is null */
+	unsigned int			eval : 8;
+	unsigned int			redir_ingress : 1; /* undefined if sk_redir is null */
 	struct sk_msg			*cork;
 	struct sk_psock_progs		progs;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
-- 
2.34.1


