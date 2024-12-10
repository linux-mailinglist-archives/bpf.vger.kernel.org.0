Return-Path: <bpf+bounces-46443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA3F9EA42F
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 02:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8603E188A519
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 01:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C194D8DA;
	Tue, 10 Dec 2024 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GjNtd6x0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D3A282ED
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 01:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733793645; cv=none; b=l4iolon7w0OG0h0wticgzA9Ga7Re24SwVhqs+trJiIWKBC1m8YDs2YaV2RJhbQg8aalWVuA8ZfwuZXdc99nQUbcd4V41XhaLuHUIq0GGd3nPVorpMTI1a9PrN1k38djyihEN5/DLIGFjgTJpMl9d0a1fxLiLlfNuH5eStZcR1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733793645; c=relaxed/simple;
	bh=riAgWIm4eHOvFvIAD29NmiRmabOQhrVcGI9FcWeW08o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rLEy+Juzwm3MyPyHN8KhVsgsq8DscS4M+Tp5aMKMNL2vBdawN41T93RywWrxRCAISMlHZFI5WRu5lWgjsnuJEmAocsrVTGXrDn9fZncqexxtm1QbUkKUI3ELx+QrL7Bd9Y9QuJWznD/9Vpnl2cIulFnbdUOZRCNMOmEMT+Wax20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GjNtd6x0; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4675d91ea1fso16892791cf.0
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 17:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733793642; x=1734398442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ENRSn1yH7VoQY4e24Ns356ses2mMqgMcB34tq5lxgTQ=;
        b=GjNtd6x0mKLwqS1vSdvcB5W8QrXnlluViak2EVkclYsIdNeqMFc1s+ZTJSZsdKH06O
         BWU1X2KKj0blursigxyduLHMdXOAgV3k9oRAWBkRFKBHG/3sCisgq4j+NPUiD2kaZFC/
         IZAhFc0rDStMBAW1SNUOPZmt+71noUOIgNryQzTj+uYXjPRN+YZz9a+h/L1eBpfZeAMh
         PFgBhQp+ikzufNE7bre/rDD9JRUSDYvCIiZ+M3f4kh3q0NqJ6ZIykaj431YPI4egOf7R
         i+M/VeJEzu1t+oiGytkZHV2M8GlOuvgDl+foU5zzrlvn7MBevZVijZrnED/T1nJDwJ2s
         jwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733793642; x=1734398442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENRSn1yH7VoQY4e24Ns356ses2mMqgMcB34tq5lxgTQ=;
        b=q/ft7oBcG3aV+2FymjLegL6jz/ixcOa7b5dG4O8sLh47srIbDDp0BkHfck1uzpGNz3
         KUNM8jWCwD2yDANmwv5egbF8n4HZo8FAOCxCvjRyLqn8u69yyJbn/lmYNbCPgO/WFBI4
         Q9sgzko3CL0rQpyMAy5i8j6kQnJWlHqTEiGIpav3M7k6OY10zTwVcMYJZUOae4ex2lNG
         6NottQFpe3StF9LKNCNWek9Q+iyfX7E37f5oWbQJ6npvo5AHQQ9mpt/rvWe9/oinGFUB
         YeIz4LY/mhJUJVdsQlXcGSk1qnfVDSI7P2oOrl/I1e7EKsH//Y9P1FyFl/JX9yDjCFnT
         7fjw==
X-Gm-Message-State: AOJu0YzETW4P6HMkVwA3VKBx60znkrAaE2AT89SHs28k4E1Brts6M3N6
	8YuGGFacoTeIURX74K01vdj3jNohrJehFoiNP+VAHMtOIS/L9vuP7Bn7qAIMldNc7W7hG7s/MN4
	2
X-Gm-Gg: ASbGncuK0TRoDrE/XDv8JIjv/q/Ed2r4Y4JAYr70lS1whm4Jy42h0KPmtYA9VfHNBg8
	7762DJbce24qxSJj+ezMQBtiE97Zg7zUBXB0FYO1Xyx7/LbuUhAhfyTWxWcYwe7IWLy2iBCQEcO
	PZy+CcdX3jCHh9GVeV5+gv1A5P860c3w0FwHy369vsKsBI1n3FK0RjZsbDcyJuOAKpQtkgYHw7h
	6hWrFWeo+jRTN516MxAcypBpqxpSU2IxyI7Gxxj+EL4+OVOwFfd0U4hFLpP/XJ0wxMM9w+fn/tx
	U88=
X-Google-Smtp-Source: AGHT+IG+jwM1LsV8lCSffGZDdkO+RuMN3wi5qCHTFZ2dq6X/nH2EzdoVMLfykgxlrtEMRzSWCf0kcQ==
X-Received: by 2002:a05:622a:1454:b0:467:614a:b6d with SMTP id d75a77b69052e-46772028ad5mr44503881cf.45.1733793642465;
        Mon, 09 Dec 2024 17:20:42 -0800 (PST)
Received: from n191-036-066.byted.org ([139.177.233.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4677006d143sm8116521cf.19.2024.12.09.17.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 17:20:41 -0800 (PST)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH v2 bpf 0/2] tcp_bpf: update the rmem scheduling for 
Date: Tue, 10 Dec 2024 01:20:37 +0000
Message-Id: <20241210012039.1669389-1-zijianzhang@bytedance.com>
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
bpf_tcp_ingress. We also need to update sk_rmem_alloc in bpf_tcp_ingress
accordingly to account for the rmem.

v2:
  - Update the commit message to indicate the reason for msg->skb check

Cong Wang (1):
  tcp_bpf: charge receive socket buffer in bpf_tcp_ingress()

Zijian Zhang (1):
  tcp_bpf: add sk_rmem_alloc related logic for tcp_bpf ingress
    redirection

 include/linux/skmsg.h | 11 ++++++++---
 include/net/sock.h    | 10 ++++++++--
 net/core/skmsg.c      |  6 +++++-
 net/ipv4/tcp_bpf.c    |  6 ++++--
 4 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.20.1


