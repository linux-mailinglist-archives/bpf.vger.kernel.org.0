Return-Path: <bpf+bounces-42259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE689A175A
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 02:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F41280FD1
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 00:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68621804A;
	Thu, 17 Oct 2024 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VtKr7Hro"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175C410F2
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729126671; cv=none; b=MEW7EUIdQgrplGj2nuX6/tgNBM0+ZiF5wr8BTPw5hvt9p+mtyKF1F8GOlZTbltC8YySo9Nw6aRMMBYv4pUZruq2NyuM5Ix/9j8K8ted8gAIW2vRMlZc4sWGKNIpf95QbXUTIf2nWvPQMLSUlb9+27Wtb27+FaEEn2MyOxeRWraE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729126671; c=relaxed/simple;
	bh=ztsoP4yQAbLU/sfeMzZ8pioaFukXTCLQpdoYvLrX7YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sDAkTxsL2Ic9EIuHVw0H6a8wwvjts5cQQLrTzAFD+DoYqgRQrGBsDHJ0C0EyMoQrc7DYmD9Kg1NMCF+ATmnBAJByWNBS7p8ozDIBdf4hVClJgF5FQoXofBhA6LYyqwrIJQLdIlVU7fqb9/R9JAdq8cuO9aX77wwybz84SSTYKn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VtKr7Hro; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b111f4df62so32578185a.1
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 17:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729126666; x=1729731466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tOR+dpc8DM6A1a+IpLEzndQfTbrXfpiIyBadcQkr28U=;
        b=VtKr7Hrov7II2TnTw+mDt9kaPYOqbcX5QceOMfWwzeS0Yc+JO3+KX7aSp+wrZKqUdG
         tTtezpujxdasXmlK8Ab1qhnjZ1U3i75XXzRUcJHG3sYUlBA0uFujZeZoznO19F41RGNI
         dsIYfR1YdX0NV1OBWpA2KY3DpyAaExlBE3cE9E0XOnT0laLhhaNXqHKzhumkxkttQzqm
         IhOaRf9rHo2YgkbAYwq9pjN1TdmQqiwsKtXTr9b2upW+BAYf1E+NJNGFtFudsAIFxrSm
         gcF8feV6OPfG0iTU6hY/a/f4HM68t7UlfgiPQ/87i2A9Lwpy+8w+zhU1Stw5AjjmJpXP
         UOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729126666; x=1729731466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOR+dpc8DM6A1a+IpLEzndQfTbrXfpiIyBadcQkr28U=;
        b=qIW2akq9n8WGb7+itLDbAZDiwHBQT7s386cPkGDv+Fivgp9iSdY0EqogurkrTW6Euq
         BJeZj9Hv6bop9hpJ3w4S4+ITIJnEEmyJVtFcz9oKy0O44yBbU32YQL4OZ4L9/upcmpVw
         XHNFlJBXoqYOcObqtF25Yjnq3cmok4qSbXpB4CnhWHJ+iPgqneSLjHHUYshId/khxLRX
         6XUAK5j790L39F9jGJ+NFhaPTToDiIm/U/72hTWxJGWD1q1bUO5rYP+KszSSqD/znco4
         v0lqdQL9uZgb99Eh6vxei8Hc7wuEl6+HI/alkhWPYfG2aDYSZV/jZYhpHNE7W8b5CRuT
         SoAQ==
X-Gm-Message-State: AOJu0YybBSZXxL+ZXVX42UcALiNEhuVmAT0+tvZvZaEAlMOW0lZs12kL
	JH8+lpScfU03kkpV8SlwVfeoV/I/KGJfTipBDblEsy9jdR7H6GNI13P4xp3k4xo3hq0PMSFU1/6
	t
X-Google-Smtp-Source: AGHT+IGPcsrIhdZmOFUuDVFXb2vJJhYiEmCRPKZpP6JFr1v4IdZGhQfebiZvqMyqBCPt9cU/h/j+KA==
X-Received: by 2002:a05:620a:4493:b0:7b1:500b:b7ff with SMTP id af79cd13be357-7b1500bbbdamr68192485a.27.1729126665919;
        Wed, 16 Oct 2024 17:57:45 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13617a23esm242466685a.60.2024.10.16.17.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 17:57:45 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	cong.wang@bytedance.com,
	zijianzhang@bytedance.com
Subject: [PATCH bpf 0/2] tcp_bpf: update the rmem scheduling for ingress redirection
Date: Thu, 17 Oct 2024 00:57:40 +0000
Message-Id: <20241017005742.3374075-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

We should do sk_rmem_schedule instead of sk_wmem_schedule in function
bpf_tcp_ingress. We also need to update sk_rmem_alloc accordingly to
account for the rmem.

Cong Wang (1):
  tcp_bpf: charge receive socket buffer in bpf_tcp_ingress()

Zijian Zhang (1):
  tcp_bpf: add sk_rmem_alloc related logic for ingress redirection

 include/linux/skmsg.h | 11 ++++++++---
 include/net/sock.h    | 10 ++++++++--
 net/core/skmsg.c      |  6 +++++-
 net/ipv4/tcp_bpf.c    |  6 ++++--
 4 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.20.1


