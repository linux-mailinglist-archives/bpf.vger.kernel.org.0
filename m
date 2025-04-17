Return-Path: <bpf+bounces-56208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E519A92E6C
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 01:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F6A97AC58F
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 23:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0EC222560;
	Thu, 17 Apr 2025 23:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IrMYvwPN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B3A1FE469;
	Thu, 17 Apr 2025 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932958; cv=none; b=Huozd8/uoi9ILvLxhpifuSyDsF5VEfe2ppxAhSUqIwjGT7yzM0ZwXkqO0OONql59U49xKq4pF2cIjO15H+QCpbN/mSAKZWkSY7PCFEOq+jxpnZ22Nt7GSiA9IHTOVVGLZZU+wWRoKMGxLdwQyeJ/Lbk/lQXP+xjHsrAKTmwUvdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932958; c=relaxed/simple;
	bh=VbWHf/X+SkN7GftJ93BB+Bl5vwuaQr8hBTf345oxbvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPA1lmQKvVe6aU7rpKb6mlNH2lA+zkCUavugYBJ4tMO52eju0Y7CsN2zHCJpdrr/JGMer/zrpO4hAT/HFm9zbNGCY0qR+4907J4nRaEGTvpSAB+LQZJQnoEve6yxlLZht1azXOQw2fnLmkCb3GLqi9Wi8Wny2Ffo6U3lbDJ08bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IrMYvwPN; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744932957; x=1776468957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FcEQWxuQ5SoFFm6GgqudS6VAqgDUTMXw0/slyAaA3fo=;
  b=IrMYvwPNzs+EiwUVyv7C/1Xo1yQZao3Htf7qoNKnWNIWMWbHe6eY13P6
   SDQWuCdFsHD7q1RgNB2TXgbp95OFreJ01PthcQX6ysCBePZyNaQGhjFUb
   Ls3zHzytMrZkmh1CJTZKJfDRfTgTbVpFz2q0F/lO3bSRisbMWvnAjingL
   w=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="816978166"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 23:35:50 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:31552]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.238:2525] with esmtp (Farcaster)
 id c1c2f52e-d15f-4bbd-b3e3-da2d4bcbe0c4; Thu, 17 Apr 2025 23:35:49 +0000 (UTC)
X-Farcaster-Flow-ID: c1c2f52e-d15f-4bbd-b3e3-da2d4bcbe0c4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 23:35:49 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 23:35:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jordan@jrife.io>
CC: <aditi.ghag@isovalent.com>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
	<kuniyu@amazon.com>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
	<willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/6] bpf: udp: Make mem flags configurable through bpf_iter_udp_realloc_batch
Date: Thu, 17 Apr 2025 16:35:36 -0700
Message-ID: <20250417233538.37783-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416233622.1212256-2-jordan@jrife.io>
References: <20250416233622.1212256-2-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jordan Rife <jordan@jrife.io>
Date: Wed, 16 Apr 2025 16:36:16 -0700
> Prepare for the next two patches which need to be able to choose either
> GFP_USER or GFP_ATOMIC for calls to bpf_iter_udp_realloc_batch by making
> memory flags configurable.
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

