Return-Path: <bpf+bounces-71499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37E8BF5DE0
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 12:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4BC18C3978
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 10:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7991A303C93;
	Tue, 21 Oct 2025 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV0b1/D9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A149E221FC8
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043655; cv=none; b=GOJ3dj9/c+bMum7R+t7hqujO6KCmWNb+g3HEbmONxXJo73E4HdOCixLTee3G2ZKbxkazVky10P0Alp4VzUUNjmCvaswVUE4Yv9q8voDFncNCO0o5iNbU2WsvoDtTKH08Mkvh3Lg3ztMVrnQ5NzCTq0xyzsGq6VB8aJil42aPS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043655; c=relaxed/simple;
	bh=u3x+mZ9WYaMzDykMD4wrOaaWSHSxUpyWrVYfEbgeV3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fV5CYlSBOrsP9Z/D3RPl6/UEgLuooaiGeru/4NP5Ef05j5Evt4fT+wuEtYoTLhGRovZE3L5hbak43YWBCFe78mMfvagU0+Bi9rhbFJS6kesO1FZT32qheTl9UN1CiOQRv0IGt3BmlMshR3gLMVRaQywlseYkg11g7z51jXvRy50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LV0b1/D9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3e8f400f79so92836766b.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 03:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761043651; x=1761648451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hYQSYXxT3vBEQ3060Gmkoau5FySMDvalsTXJ7MNV5UM=;
        b=LV0b1/D95OJkJLKTxOL0hM48Qp9nyNgkGGl0y2QALvRjfJOVW65LHLubfJjLT7XdKV
         yt7yWfZfGL30LuOe/jTElJFWM55nwk5w/Z1FP4li/UyJu4nB7tD+ZYByotrXkDcoJQuT
         AMf9OkW1rWNJ5Ot2/F8hMOHKzhkwc2NjyWIUeakRq7U0cclGwUv99S9QS5CsyuOnmfN9
         rh+GvZHS0597r8iYDzBP6lZCYM/KcHPdBacK14QoIJ/MAKsQBn3NekmwuuGADvdyEYPL
         T++csfR2qqXSh50+Vyy671WVM+byd8Z7ZZ8x/e+g8lsMl0eSAPNMlnXMGMlyYJggZAvw
         j2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043651; x=1761648451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYQSYXxT3vBEQ3060Gmkoau5FySMDvalsTXJ7MNV5UM=;
        b=PtptAVrTSrgAVOXC8ZNbUZj8IboYj3ZEszs2vrBm07Z3zgdhHxXPyHmyjNtl0QkJw7
         x4n4XES4NNIApsWt67KU5IK5/81RIA5AIEOaXw6JLCzUl684vNaUf4LvUARmGH/9fsh7
         ohCHZw9u6lb9xOoemw81FsVM4Ubw+i8iMrhBFZIkCPPb5l0MC9+3cUJF+mpTPDeJPNaq
         H6DDY7q0ViMQKXd3MJx9BPtRhe93hmJYyEE79q2Xfy4vhqZpOg89YOeHYlcpXP9UgsmI
         S8nPe45j3OyQ01lqkrpuswm9IxcqKKioN9C8OsuL6u+92fsEgm8XLb09Ax5qYFEWmfBc
         j0pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2BppWuC8Tpo/fxBB/dmvf5HGfyM52XDhbtJ5XzGo8MRVQCgr3cmwyFt1SwSf8KBdo6as=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYD9Bua6Z6BnTqSBRfFtcSbx4SXeU92lbqly6cV2OL6MdSIECg
	98hiou7n6RAj6kgVwYq6B/d3Sm44nfgdvfRF7L9rfLkUB67CugoIBGyU
X-Gm-Gg: ASbGncvL+3qP3BdcgGb/Cx1+CqMs1QNxIp8CP6HmJjevjZ+2Dmc5AX66IzsIJpGf1w+
	mrbJIHNz/8H3JVUF522iTQnVgPWzACvMoTNy5juO7fuUSLM1n1hJmMKDUJLEBbYumWNMYYns84T
	pnaS/fotSGcyxH99NDs9nSdnVgelchccx1XEf5I9CBuv5d8w76Pwc4khOSo4EHdfgwh5fz1NaAl
	vBO1Pg6wvBiGlMmVFEnicC+ZHP8kkXQCTc2LDhNf5BCh8QCMSsHFYwO25CcoGAKd/Thtq/WrXjp
	ng/38rxL/sw5Vd1yVFVZUK6u7X92Ycy9BvPPI8o0qKB6dtd2/QLq5mc920yNjbdsH2Jw4dulARx
	d9tob8NR++tE8JujtNU5R53frjbNQHAjqDUwbRK0x9crg3gIoGA1V9oQHgst9CCUII2qikWqq33
	0Gab/FvJ5rZS5L
X-Google-Smtp-Source: AGHT+IEVgz7zYtsnpcehMAmhlB3OUMARV4++YtUV332nKXGeBC2HoEB9fppwF5GU/sp0jIUet5ebFg==
X-Received: by 2002:a17:906:4fd5:b0:afe:a7e3:522e with SMTP id a640c23a62f3a-b6c798e7a68mr191581266b.8.1761043650805;
        Tue, 21 Oct 2025 03:47:30 -0700 (PDT)
Received: from bhk ([165.50.73.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da2c5dsm1029123566b.15.2025.10.21.03.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 03:47:30 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH bpf-next v3] bpf/cpumap.c: Remove unnecessary TODO comment
Date: Tue, 21 Oct 2025 12:41:24 +0100
Message-ID: <20251021114714.1757372-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After discussion with bpf maintainers[1], queue_index could
be propagated to the remote XDP program by the xdp_md struct[2]
which makes this todo a misguide for future effort.

[1]:https://lore.kernel.org/all/87y0q23j2w.fsf@cloudflare.com/
[2]:https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
Changelog:

Changes from v2:

-Corrected the new comment

Link:https://lore.kernel.org/all/20251020170254.14622-1-mehdi.benhadjkhelifa@gmail.com/

Changes from v1:

-Added a comment to clarify that RX queue_index is lost after the frame
redirection.

Link:https://lore.kernel.org/bpf/d9819687-5b0d-4bfa-9aec-aef71b847383@gmail.com/T/#mcb6a0315f174d02db3c9bc4fa556cc939c87a706

 kernel/bpf/cpumap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 703e5df1f4ef..ee37186fea35 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -195,8 +195,10 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
-
+		/* RX queue_index is not preserved after redirection.
+		 * If needed, the sender can embed it in XDP metadata
+		 * (via bpf_xdp_adjust_meta) for the remote program.
+		 */
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
 		act = bpf_prog_run_xdp(rcpu->prog, &xdp);
-- 
2.51.1.dirty


