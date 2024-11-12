Return-Path: <bpf+bounces-44576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 279EB9C4BFD
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 02:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E132F2821FE
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 01:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA55204037;
	Tue, 12 Nov 2024 01:44:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D3914A62B;
	Tue, 12 Nov 2024 01:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731375860; cv=none; b=Vpee9QyAJFOtY9fSr5ZNajpPicSE7OdiG66Jk8UwV3/ZXNqyFjM3/5DgMf6K/DyODtXHFUdTNolWvd+kBm5wX25vp+k/bUriqbwu3mMgWB8BNuhXUXV42rA7Mq1thYKkaQ5RP39Wr5/Z6jPRySj+Xo3BvAsrvNhgiWzckhGPATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731375860; c=relaxed/simple;
	bh=eGDUpvzyoj13xkYp96HxypKFK9ImDPS++WV6k1FVq00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cnc96d/43RSk/Fp7cIWvEBhLsVSk8OpBLKEkVr7eoEnr3kYBw4wSdO4iu4sJGorY6sziKEQrTrBsG55j6FOr/Uff1EzZXb7DIklOj0xWDmlF0wtIlrpA6HDMHpKVLGEiM0vBhb6nSTPSdGJ60lVCl71jJmWsWSKBeBpgzbD9dyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76732b2eb8e9-09906;
	Tue, 12 Nov 2024 09:44:11 +0800 (CST)
X-RM-TRANSID:2ee76732b2eb8e9-09906
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76732b2ea66a-46911;
	Tue, 12 Nov 2024 09:44:11 +0800 (CST)
X-RM-TRANSID:2ee76732b2ea66a-46911
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: qmo@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	luoyifan@cmss.chinamobile.com,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH] bpftool: Fix incorrect format specifier for var
Date: Tue, 12 Nov 2024 09:44:10 +0800
Message-Id: <20241112014410.279250-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <7e382bfd-cb1b-4d67-9e2d-a007af86e90d@kernel.org>
References: <7e382bfd-cb1b-4d67-9e2d-a007af86e90d@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, this is not a bug, but a minor change to eliminate a static checker warning. Since the var parameter has been cast to unsigned long long, the corresponding format specifier should be %llu instead of %lld.



