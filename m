Return-Path: <bpf+bounces-53680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CB6A58409
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 13:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA534165F3B
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 12:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C4B1CCEDB;
	Sun,  9 Mar 2025 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjCfz7ga"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC037482;
	Sun,  9 Mar 2025 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741523438; cv=none; b=HNB2thsSj3EYFLElZXRxf68NUzPXkhPJiExlUgwj2kBm0I439tE5pZYDTtLh4uc2jUoOW7PcPtPqeYxpY9bd+a2obXBOIiek/l0HNlo7V81ZjR6nO5lrZ1vimI6RLVVg66uCNxIL2O1GCmc9aeyo5TY40gyxE2xx6fCSxhn9N3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741523438; c=relaxed/simple;
	bh=wZJjxwV42JCd91jTROSSilGqdgGCZDLMNi4KCRgR/8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SdpB3a6fVPhocGtedRTTA7g/M7JdjG5LHHV5GPtOF3KoJ59Loq3hs21VSgB+KcDrKoM00iS+DLMg1zzTEJ68o+YMrm8zhJBr7gLB2puvAhC9DCOLcIpeLiqTDksInT8LRuTbbIafxiLZkv8dWL8vsnGaay99YnvYuTD2ey8N/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjCfz7ga; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf64aa2a80so639921366b.0;
        Sun, 09 Mar 2025 05:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741523435; x=1742128235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pqj3TJjhabGigKmi0ouKSehitIwTHPlDh+RYxcgOvx4=;
        b=QjCfz7gad4bkJ5m8dd6L2evyrfVS1Q00kGn6WzwXSyvaOBPBEdqxFvuIutNBpqkieW
         qmEZUEyHrc28GXBuJbXDiIus1cdOZO3WQnYfcA2hWugzDw2hZEJPURd8bVM1oyBm7d91
         p4qzfKD2dotI93P3OanJsC/+aLgHqJw7zrYye767BuCusT2/9IIzUames3aH+QPjBzVJ
         CGoBTVsfBpL7NavZjF23aec2nsSDANF9YuN6yqHoLEUVrUJBzALz2E6923ceYENoztar
         YEr7fuJaFmhsSTqn56hBgp/uqZgnqfIYNQ4Dums55FrFtumLokWWKnjX8zMlNtmVPOW/
         R+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741523435; x=1742128235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pqj3TJjhabGigKmi0ouKSehitIwTHPlDh+RYxcgOvx4=;
        b=q6IHD09PYL1YE5KRsaDQSJx43u5bpprLIncgjA2kpvz3655r81gjY7kHLIUue8Snh0
         vncnIArjAYAVLDCAhULs/kUQaPM60YDoZ9A6Vu9wT31OR9JcJJXtqK2pNXHi1cWEI8v4
         nhNwvU0w9Wqfa8nfJ7encCaPqoF3DlvQeMpG4bjXUZQXEHWfR47sTSGuuR8eQGllhae5
         zr9fwpu67wgcQn7LI0XroDjv3YwUYBhO4mg4Ua7JMOjh9ltM437z+qHl2rSgEg1HTMBA
         323F2d0SubfC3PoQMAda1SYWPfo/6V39cCXNaD4rHVTU2C/Dirg4kLXJOoUTvi1gzDZZ
         HodQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8vWRSl0eZGgKuqhzJTXXWzk+npB9SJLoG8xQfyyfuUzHgweJHLOeQmTGoev4mHk8m3qdQM7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/fKFt7jlFaOneMKPVe5SnbvNHfalLHf0oc7QN62jFjJmE7JeD
	yceFbFh5N0PljroldTMHa+YjMmHeG+qXZEqFn83jpEwLpqJKTIvQ
X-Gm-Gg: ASbGncuPCudlg7T4JhtDSysPJaLVArwAgKv1D80EFrZwr4iCpvftiuBfRJod1Kr2Yps
	67dqSbTEQR32GmYRQl9FYoyQoP88cpGst+I8AWEy2VR0J/GHqB158R5+M0bHlzz4pA66DFrU3o5
	mfYy247zh5OOKxCP6/fJBYEPDLMRHEhlLbpfgh2Ne1PDjs6m8Wni4awK5jzAc26bx8E3Hkzeve8
	CrR017Ec7V0tD1eX+HJ4feHMvLxgyOJPxjxbNLPkGgkMcotHmcGBU6V74xWTHYVpc5QoTzzK9ud
	FeeI5oeJjxJmIKHQi8CCMsFQg0afu0TgN/bAhgvrM0MO3TlvI0o5bzvoG/S0pIzZf2gNy+Un00q
	vchncOQ==
X-Google-Smtp-Source: AGHT+IHKfjhv2KRqi72m86osn1kaV3bKVHiKIXa/2VcOYqS87Xn4ksZV0pNDz8lCjbtDG+Db5af31Q==
X-Received: by 2002:a17:907:3f9b:b0:ac1:ddaa:2c11 with SMTP id a640c23a62f3a-ac25210ff7emr1172106766b.0.1741523434773;
        Sun, 09 Mar 2025 05:30:34 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac29c19603dsm39144066b.38.2025.03.09.05.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 05:30:34 -0700 (PDT)
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
Subject: [PATCH net-next 0/5] tcp: add some RTO MIN and DELACK MAX
Date: Sun,  9 Mar 2025 13:29:59 +0100
Message-Id: <20250309123004.85612-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf_getsockopt for RTO MIN and DELACK MAX.

Add setsockopt/getsockopt for RTO MIN and DELACK MAX.

Add corresponding selftests for bpf.

Jason Xing (5):
  tcp: bpf: support bpf_getsockopt for TCP_BPF_RTO_MIN
  tcp: bpf: support bpf_getsockopt for TCP_BPF_DELACK_MAX
  tcp: support TCP_RTO_MIN_US for set/getsockopt use
  tcp: support TCP_DELACK_MAX_US for set/getsockopt use
  selftests: add bpf_set/getsockopt() for TCP_BPF_DELACK_MAX and
    TCP_BPF_RTO_MIN

 Documentation/networking/ip-sysctl.rst        |  4 +--
 include/net/tcp.h                             |  2 +-
 include/uapi/linux/tcp.h                      |  2 ++
 net/core/filter.c                             | 22 +++++++++++++
 net/ipv4/tcp.c                                | 32 +++++++++++++++++--
 net/ipv4/tcp_output.c                         |  2 +-
 .../selftests/bpf/progs/setget_sockopt.c      |  2 ++
 7 files changed, 60 insertions(+), 6 deletions(-)

-- 
2.43.5


