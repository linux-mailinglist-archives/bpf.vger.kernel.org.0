Return-Path: <bpf+bounces-53685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E61A58413
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 13:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B509A16828A
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA7D1DDA3B;
	Sun,  9 Mar 2025 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeVDuFaW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F64BC2FD;
	Sun,  9 Mar 2025 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741523447; cv=none; b=mTj8MZUTNqCHKEe37Ok/PlQnk9VGLthRSj3wuzy5CCouILNI0r9SMB7EWmx5xS0t+nOU8PFWD9br3Qnqzax6mAKYorNqqyUISkDurpJF5rJ/WensVuvKm2wPZ5J/VxxeX0Q4cicEU+OzUUQM96k0cSqPFY2c9f9O1lC7UNkQF0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741523447; c=relaxed/simple;
	bh=oe9IFBRxTC4K7Yl2I4dZTUYiD8zJwqLA9l5IMudw9R0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GkZnXJjgGKjc6bDUUAE8NmZE1GDzp341ggL9FbuKmW841rxLqZjlo1MM8elB/OqXBAzAzlwGoNmg/EmqYxDn1xOxB3LgA1qF9P/HJVtln6PSFSp4W6IY0gVRIb+/FUSWoMI7LrgcPhGWZLpLXx6oLw9bE20sk3YRHhC+E6MY43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeVDuFaW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac25d2b2354so312512366b.1;
        Sun, 09 Mar 2025 05:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741523444; x=1742128244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbB+H6DnjKDKEGPGTN5Kwbnu/2fQ4gt3M/BOm0GQpoY=;
        b=BeVDuFaW/oi/BPGJGqa3h6YE5NYee66vzL17d5+xHyYkntUybHJKeuwN/qFe22RskD
         1Np0ewH5ZsCDkJ3Q1xuZO7PHoCZZgH4tD/gO7UueI4ldzxZiZs+IAgbwlnMVzLYVMA48
         XK7Slq6NmxYsjDCv0pMTf6qB9LFdo0YHlE0n7DGsB8HPiCdRFcrMHbxHgOnm9YHuojBM
         HEbmN3xHb4weUkaKbBoPcHqHYKvygqrJw7rPVOI9BNwS9EglwXvExgq+vFuBO015tbco
         HZ0GPU0rBOlgEZquTAvu3kzAuxMRTKM6qJMuhOjDsJ+ib7r2oIT1V3HFsBfO5CC3fBL0
         kPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741523444; x=1742128244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbB+H6DnjKDKEGPGTN5Kwbnu/2fQ4gt3M/BOm0GQpoY=;
        b=fxhFW5ztWuJEmPgybWvGrc0I0brKw5NTaAucYaP2LSCypcN5BUF8QN+/5BkEc5Cadm
         0GTDq6ZUTax4O98I8VyX9xvf9BbGPlj+p05ifC3J2XG3C48g0GqpqBdUoM0zX92xLeV4
         ufBJoJY2K4DSUA5vhqaCVIT+SyVzU05vMZWEhP9s1+MmyHR5i3KpZj0MCbVi15d2sq7B
         4tbRPpNF6GZ8k1xWB6eSwAoNFW6TNbK+zH3Ql7v3HX3nHu6nZt8Y9Ba9jfjwP3isMcnK
         MueiUzAEN6H/Or5o1ZvWyMTNyhin38IM3bo4iadtGzY+Bpks5fBH/2ySOUId7Yjk3Qzb
         Uveg==
X-Forwarded-Encrypted: i=1; AJvYcCWjHcySzwLzyIT7jHV/gHnhYNU4/vjJ8umAH5SG71ktsFIlbHX0IZ5PtXzgathl91IfUWWrim4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhE0Mq50KZj+vIaOqBi9aCnLEeB9Cr8iAwJrGhp75Vb8R0X+Rz
	JrzLgTeAxBjjbg1z/PltHmAKSAZP2IywLC2O5NMr4I55TUQ2LcKF
X-Gm-Gg: ASbGncuFaT+5CUR6SIpFjn7CztdKEoeXciAKW5vXvUaL/ymx5/b4S0NEdOel+pdRV+j
	SSo/icS/1/aB7quWO4QZf4UtIp9FNo+MOL4HGc32b1L/D+ZVPpZhYfhsEQtXSRp7ZiOZBOTa5dc
	7nCbnclkCEGyaTGdh98/x/clFKC0d8cYxg/W4A8LaUYLwMrxtTRlgtwXCnSzDpIiaS6CPFWeSFj
	kt371wh1NreXaCtWhn5TAGLgZqL8S2GfkgilnHNuwO11qOTTjBewo5EUPzdrm3lZyS4PNTDql0j
	pSFnkfCaGD4e4yPL9AaO3/xHXKDDLAzT83tyuU1Q3jeMwVRsAhvtPpCSJcUnrSTs+UHq5r58vii
	3AlPzOJDFEptUAgmD
X-Google-Smtp-Source: AGHT+IEixGIngPuX5WlZc86c/dDR3NG2NsNg+DxMwrr0/IfdJ4rkyeSX4z0sntkn+7cmfJAC4AoUtQ==
X-Received: by 2002:a17:907:3fa6:b0:ac1:ddaa:2c03 with SMTP id a640c23a62f3a-ac252150449mr1120560566b.0.1741523444213;
        Sun, 09 Mar 2025 05:30:44 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac29c19603dsm39144066b.38.2025.03.09.05.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 05:30:43 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org,
	kuniyu@amazon.com,
	ncardwell@google.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next 5/5] selftests: add bpf_set/getsockopt() for TCP_BPF_DELACK_MAX and TCP_BPF_RTO_MIN
Date: Sun,  9 Mar 2025 13:30:04 +0100
Message-Id: <20250309123004.85612-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250309123004.85612-1-kerneljasonxing@gmail.com>
References: <20250309123004.85612-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for TCP_BPF_DELACK_MAX and TCP_BPF_RTO_MIN BPF socket
cases.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 tools/testing/selftests/bpf/progs/setget_sockopt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 106fe430f41b..7a18a2d089bb 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -61,6 +61,8 @@ static const struct sockopt_test sol_tcp_tests[] = {
 	{ .opt = TCP_NOTSENT_LOWAT, .new = 1314, .expected = 1314, },
 	{ .opt = TCP_BPF_SOCK_OPS_CB_FLAGS, .new = BPF_SOCK_OPS_ALL_CB_FLAGS,
 	  .expected = BPF_SOCK_OPS_ALL_CB_FLAGS, },
+	{ .opt = TCP_BPF_DELACK_MAX, .new = 10000, .expected = 10000, },
+	{ .opt = TCP_BPF_RTO_MIN, .new = 2000, .expected = 2000, },
 	{ .opt = TCP_RTO_MAX_MS, .new = 2000, .expected = 2000, },
 	{ .opt = 0, },
 };
-- 
2.43.5


