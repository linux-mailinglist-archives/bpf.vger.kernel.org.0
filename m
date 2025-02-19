Return-Path: <bpf+bounces-51916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55051A3B36B
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 09:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2733B55B8
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 08:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9E21C5D57;
	Wed, 19 Feb 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLR55ZkY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A41C54AF;
	Wed, 19 Feb 2025 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739952828; cv=none; b=FumLYbTOeLcD4z1JZUkcJefc7ZEd97lGIZGQdPvFxZhtoaSan0d85fk9/PoIELSbxgZtjjcVajfdb1b0VK4t+aPXIzEUzxJ1MyD2BFur2n3BKYPnNX9QW1RAkNXybL4dCLi+pWKWG2avew/aHqabtUT3fj+r3w5aKeWwUwhbNFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739952828; c=relaxed/simple;
	bh=xA6MLc7s1jo+X6j60s9LAgz7kITcrshc4vHKO5l9t2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PfNIhv2Ksro+aVnve+pByFKkcYtpC+zX0bmAC5VuoKPPSg3qU7J0cGJMNpSo8IosfxYW8x3mtRaRDQDsSF3iovbp0vsKeyhTD57GAR6zWCpHUwzx+9XEF9lzvUJ75YU6g/oQCQclteIQ98K0L/amBWt99LsobembU4DjJY2OiZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLR55ZkY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-221057b6ac4so67111115ad.2;
        Wed, 19 Feb 2025 00:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739952822; x=1740557622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4GY662FMjxQiqIyaysFN4OzKQ1VrBUdJMuXn5bU6EpE=;
        b=dLR55ZkY4l9zuwAWp27QLeyK7Wk8I2mVzpKzNpbX8jHHIkxL87Vz6Rtmnnx5ewb7ED
         PB0bw9P3oq24/orSQ0SoV0kkoQmSKkWO0tRhlmoZOpSDaXHVpQRnLNH00skNekaqAGU6
         tptSKJMDHIJUQpMDUKBt1F0M/90yGgK0tjMoJ9eOLwPOR7HAenEsLgj5tlyWB9QkEOfW
         /NuhMalofw3zMKK8mFXWvdIWOYEGCKHKuQcQUna31mb93QEajZFH/RyzwzdefkdzWocM
         Nw+bxQFVzb95M/1W7TeYvjL+2Z354YIuPVpD/GVHBS/Sw88qMsnQTkSL5PnYHoY4LY/C
         Ff1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739952822; x=1740557622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4GY662FMjxQiqIyaysFN4OzKQ1VrBUdJMuXn5bU6EpE=;
        b=RFqE+oSQT7jBDecC7IGTQiivtelxe0pNPiB+FtMTBGQX07JsBzJSllWa54WraxmqrS
         5xbUUanR9hALP8lqgsSBvmp2pxLsboNhb+ZQeDi2WbB0Ut5o1dQoMbK+/OwoJUO9rbnU
         HY3ViT7Z/b76Q2VRnwOfc7H6QeiNq+KR5yaX0W2S+Np2AEQYtHJiFih6lF5ZTwJCSv/p
         6EiqJaPPnaOH9dPutBczAjyhL5Cv547qQ2JmbXGfnfIkf8mVdt0c8LjX/9rsAxgjsSzD
         I3b/NmPzq3lxHeIF4YhAWlethgx/o/UJWJMA0Rp621YnilL1N/PQdGfLgNmnxPqniBFd
         RVoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhi1Z6u/QPbzkqMw+JU3H0CdV455IFQTp0c22D8ZmvO46yPu1h9+CUVxbh32t2cyOFO6kgfQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/fx6CGVvf9jAtjzYaSe1GBSZy4mpe6mej3In3zKbcGCz9IxMx
	7cyTuEgTojfP9cvNVU6f/w7ShviCckKpCX1a6S4Ayk9Sm1bM8RW/
X-Gm-Gg: ASbGncsUYHoF5tC8tTIRW6zyR0Mden8uSuar/xQ2TNowIP0a6TOt4Dbi6kRb8iz3uWf
	o4Gi9FBHsm+kpNQzeqGxGFDjrC29OZz9RxPa7IBDftHcilkGdxJ4NPUuB5RjNwdplFKpCnATuhV
	xuvfMI3Cz1v/x/uzgZ3ZRFWvTLc9XYUvKvnOyIjy6JXltA0VPHWfC5fDWNeIBylHHvniSyRMp55
	bPXdKjQYCXAX+iCEcFoQLH+sv8SPbudbM0vqBafg8e2VOsQAjXd4ZTowacC9gf/79OlcLoSL707
	UZnwanxRnQnO83NmXND4Py3pI/OLHs7PRSidOPSfmx8pzmfBFc8NHjvHPbx8zTk=
X-Google-Smtp-Source: AGHT+IGFRjSfhWMGnmLYZl+rsKQXMQPj8mKnww6w5yOfDWXtkIW3ckJsw2wWEuTwOnKgPPC3rhmUqA==
X-Received: by 2002:a05:6a00:1707:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-732617999d0mr32341105b3a.8.1739952822121;
        Wed, 19 Feb 2025 00:13:42 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732642d908esm7774746b3a.159.2025.02.19.00.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 00:13:41 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com,
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
	shuah@kernel.org,
	ykolal@fb.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v3 0/2] bpf: support setting max RTO for bpf_setsockopt
Date: Wed, 19 Feb 2025 16:13:30 +0800
Message-Id: <20250219081333.56378-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support max RTO set by BPF program calling bpf_setsockopt().
Add corresponding selftests.

Jason Xing (2):
  bpf: support TCP_RTO_MAX_MS for bpf_setsockopt
  selftests/bpf: add rto max for bpf_setsockopt test

 net/core/filter.c                                   | 1 +
 tools/testing/selftests/bpf/progs/bpf_tracing_net.h | 1 +
 tools/testing/selftests/bpf/progs/setget_sockopt.c  | 1 +
 3 files changed, 3 insertions(+)

-- 
2.43.5


