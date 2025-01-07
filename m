Return-Path: <bpf+bounces-48078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB78A03EAD
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A894163EEC
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038491F1305;
	Tue,  7 Jan 2025 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImuqVbzE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332271F03F0;
	Tue,  7 Jan 2025 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251730; cv=none; b=N8GM/SO+/3VwY8MSrmytBN2lmml4yRG6noQHA5pepbS72Rcdec58AtdAydHgNMhgJKzYxxILsr9ECUkyCpu+TzQINU62zS3Q6Ece7ERmBeHey+H3xQDB/oenajNnJNOPi++1voYLxxIy39/1CXYNGX0/C3WtG0gSet3DpLv4b6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251730; c=relaxed/simple;
	bh=dFowweZmqoHTDjnE3Q4Oi/G8Ma5JlTL4czltXfRmVTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saKiN9x6+WCIRTTmCj4qF4dmzUZM0gMe3UkKjBsSLuREVBg3GEy3Gs8Vy18mRLHtpp0KE/ui+SdvV1Dv77eoyFWXSF4/Cbgu0gZ5Wuw3PsEZLnTU4oIW2a8gmArPyh6TumZo09Mlr3XrwKXHSDUD77douAaMpVMSMjUkbdbwm2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImuqVbzE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2163dc5155fso221725395ad.0;
        Tue, 07 Jan 2025 04:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736251706; x=1736856506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkIoWa3+df1IoXEzOIp55BOynbHpat50uMkhx/SzFZk=;
        b=ImuqVbzENgAB66lGmTvEe6iakhlljRBtxuYYiXAywWDDP/CghfVY04lYeUpQAW3jJM
         +damsxvkiZIAO8qg8NMBnf1I+pB8uoCOIXYdVc8CRL28QnlthP6rZ4xlbU1vHC904yFw
         tCafDms+qFXiJlPHbjBvzy5iXDTKyUaEwcu3KsbqoRDyx1p1TQl/jN6sCDob9Tg8DdsW
         j09+Gu02oyd7b6IslZwGAOybT7WdadMZfUWyPG4xPNHYaXcMhunBp4GY+bJCegCqTMHL
         usjQ8X5/B095ugVy/l8duznbmHAamJ31udCiI9lk95Ua+NzpYrFC9SJiL2k453j1sjYu
         w+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251706; x=1736856506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkIoWa3+df1IoXEzOIp55BOynbHpat50uMkhx/SzFZk=;
        b=fNannKtnRTA93DPLvxbVgROOPAKAr8CkDfTxGzI0JJzYPHj45NpmdAFhauZFGuTFTg
         ejzcfq4FTRbhmXbZemqZ+FJeAesMkK/WjKLvyUyevD0+Tu9HxjUE0q/Trt7izWIpGwdf
         q0di5bqvhJPFtVd3eT4ST9nSjw2VdCWCW20jh+Bh8cLi3eunZtcijYq/4erP9vuHaYcd
         KfYYXkMhISwgwjxBUQSiPZKLhYEmnbsDJp0wLdM9ZT4lefPDUMXMuAU1i++SIWT+anef
         mpPe2in32rcM3mtGGaHST0jFdgEe3er0S/1Do7xhwX7GQjYQ7ii2dgD5zcm93ZeaHjYn
         og+g==
X-Forwarded-Encrypted: i=1; AJvYcCVZpCrglCwqVCunySQhsDqdBO7H1TxE76GKckJ5jeU+sj5ATCrNQf7+YxakKhSmgQReqAr8VkpDQQIHoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy85xyE15dub8UyV5jYF97j3jePOd6lba4Qkr9kwyjIJ5p3Pv0c
	Q1TphJzKdRztkj5yDc74dYJ9cSoESMOkhe4xakP9mUYtWPUcijqo
X-Gm-Gg: ASbGncurz5Z3SHREiMwpMMhi55evzls0iTuLxu2OqMABI60YSDUNF4GOmg5SWqY37Vy
	uHZ7HLfrbDDX7WP+NPxdrc6coGAwdopxmmglowp6UZdoPPH+Ir5BcUhAnFLwFXnhq/MuLbmB3f3
	Nfpui+myRROh7seHI1DxECcygTtwBDq3WQtgpZpfTBDbUJaeHpGLS5Uv3SueUXvwR8EdiZPWzfZ
	rLhp1eVsD0AohR3s01aMSiNHdJhDz+JYzcBhXzKDtuTMdpGjSVeG3xkTarnlkxpN1zk
X-Google-Smtp-Source: AGHT+IHfwMTDN49X3zErgeAJH9i8tWN9t9kmUkMAdL68ZKIQBO5Mc6BAe/sERHnvYxZpHRxGXc83AA==
X-Received: by 2002:a05:6a00:6c89:b0:728:e52b:1cc9 with SMTP id d2e1a72fcca58-72abdeaad08mr87614041b3a.18.1736251706027;
        Tue, 07 Jan 2025 04:08:26 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:25 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 10/22] ublk: bpf: add kfunc for ublk bpf prog
Date: Tue,  7 Jan 2025 20:04:01 +0800
Message-ID: <20250107120417.1237392-11-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250107120417.1237392-1-tom.leiming@gmail.com>
References: <20250107120417.1237392-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define some kfunc for ublk bpf prog for handling ublk IO command in
application code.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/ublk/bpf.c | 78 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/block/ublk/bpf.c b/drivers/block/ublk/bpf.c
index 479045a5f0d9..4179b7f61e92 100644
--- a/drivers/block/ublk/bpf.c
+++ b/drivers/block/ublk/bpf.c
@@ -93,7 +93,85 @@ void ublk_bpf_detach(struct ublk_device *ub)
 	ublk_bpf_prog_detach(&ub->prog);
 }
 
+
+__bpf_kfunc_start_defs();
+__bpf_kfunc const struct ublksrv_io_desc *
+ublk_bpf_get_iod(const struct ublk_bpf_io *io)
+{
+	if (io)
+		return io->iod;
+	return NULL;
+}
+
+__bpf_kfunc unsigned int
+ublk_bpf_get_io_tag(const struct ublk_bpf_io *io)
+{
+	if (io) {
+		const struct request *req = ublk_bpf_get_req(io);
+
+		return req->tag;
+	}
+	return -1;
+}
+
+__bpf_kfunc unsigned int
+ublk_bpf_get_queue_id(const struct ublk_bpf_io *io)
+{
+	if (io) {
+		const struct request *req = ublk_bpf_get_req(io);
+
+		if (req->mq_hctx) {
+			const struct ublk_queue *ubq = req->mq_hctx->driver_data;
+
+			return ubq->q_id;
+		}
+	}
+	return -1;
+}
+
+__bpf_kfunc unsigned int
+ublk_bpf_get_dev_id(const struct ublk_bpf_io *io)
+{
+	if (io) {
+		const struct request *req = ublk_bpf_get_req(io);
+
+		if (req->mq_hctx) {
+			const struct ublk_queue *ubq = req->mq_hctx->driver_data;
+
+			return ubq->dev->dev_info.dev_id;
+		}
+	}
+	return -1;
+}
+
+__bpf_kfunc void
+ublk_bpf_complete_io(struct ublk_bpf_io *io, int res)
+{
+	ublk_bpf_complete_io_cmd(io, res);
+}
+
+BTF_KFUNCS_START(ublk_bpf_kfunc_ids)
+BTF_ID_FLAGS(func, ublk_bpf_complete_io, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, ublk_bpf_get_iod, KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, ublk_bpf_get_io_tag, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, ublk_bpf_get_queue_id, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, ublk_bpf_get_dev_id, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(ublk_bpf_kfunc_ids)
+
+static const struct btf_kfunc_id_set ublk_bpf_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &ublk_bpf_kfunc_ids,
+};
+
 int __init ublk_bpf_init(void)
 {
+	int err;
+
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					&ublk_bpf_kfunc_set);
+	if (err) {
+		pr_warn("error while setting UBLK BPF tracing kfuncs: %d", err);
+		return err;
+	}
 	return ublk_bpf_struct_ops_init();
 }
-- 
2.47.0


