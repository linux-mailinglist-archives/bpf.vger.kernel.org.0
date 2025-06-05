Return-Path: <bpf+bounces-59701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75214ACEB67
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EBED16D252
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 08:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11DF1FFC49;
	Thu,  5 Jun 2025 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="P8QFwDL2"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC29D1F9406;
	Thu,  5 Jun 2025 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749110504; cv=none; b=QpyGrmwdkTQCZcy0TSo01bWpqQWaLGA396slcxsl61/dSbVjNPf02Q0fapmzhetag/PfYtuweppruyS8N0+uyVLRh4luDNybrTF1TzkcRiuR8PkmyTs/qnsw+4Rp84iCJMtZ4hglBDv4os8kp/+ZCymh4/NaPPgx5qGMF9hGHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749110504; c=relaxed/simple;
	bh=Ai4b9RdyFSTVbRskg5X7UDeB0s9KuArHonh4pYTC0O0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=tHWOtA4SkNP2Cx+M+35rTBj9WoqmzZlYBj18kECeHgaZzDkVrl5AsVjyAASNY34Yo7iwSPRHj7G6K8vfEaDEmQlODw01peaEtZ8eKjQcbRwrnEApfDE2isOD50Q57W/Xt1KbFYVd+JvQ3EkX6RmQdGRseTgYNNYhlO7Y4tzot7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=P8QFwDL2; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1749110190;
	bh=8Uz8tv8T3cRPzQ65GEImKuZPtmWh44fBGHT6PtM90tw=;
	h=From:To:Cc:Subject:Date;
	b=P8QFwDL2dqm+N/IkHLTX0X82CH9TBM1vpQyWnRjtmRsp3kXPCj8xR43KDGIbdAYxE
	 NNINRQes0CQu+2pGOYAKvlw7P90B3zUffuD2QA+pIT2EHDdTxjJMmx6VH1x/f0rLfs
	 QjhFazlLGzSfVmugLOOVKrg1KkFJdAYYrzlELw78=
Received: from NUC10.. ([39.156.73.10])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id C83ABCBE; Thu, 05 Jun 2025 15:50:03 +0800
X-QQ-mid: xmsmtpt1749109803t6b82m3yx
Message-ID: <tencent_D1C42CC7CB3F95E857E6D14C4422834E2107@qq.com>
X-QQ-XMAILINFO: NZRRnjJGoaJh6NFPd1YBH6QOGtkBbW1kTubUYmQzRNeUguXF6SPG1g7bzH35CT
	 iO8uJAz7Bsx+VZt6OBcBszUi47LTD8zjimKfH77ut00YISZvhlPbc4vwdiP3NzxhqSiyNA+1Q+k8
	 iaWgovnhAwoOtzAdeFr5ELt2ieseg/1amPxwbUoPAhyzN+lIqpBcI4/1bu5CNkd1c1gvkIfKXAuG
	 1R6YugrOnoP2uq9yTblXIcrV7AkVkBR/rpoU8/X30JlrDZejiZgyd+gXhw3HId04KAE6uv+bKCBL
	 KetrJFef/f0m8V3cqBUlrNWyUjwcwVDHQGWyeY8RdmegDCKp/N1AOzV+c2JmfKpmcLKrBMgHTiNx
	 zO6Pamk9vd3pJsa0i1ozw6OLK2Wne3INqb4X4hj56GAFqbST5bj2/O35nIh6ZFTT9B2UGX2Xgq1S
	 kHTr8FiCo1lGbsH2J2xnlXPU7ftySWtnAskR5/W1ABdrEu92KrsEE4kvNwAqtcbaiZINStuqom8C
	 e+AxOKCJsShjZjvzE/lIfgoQapoQADsYxtI8+ir9PUM825jYa5KTHUfYHRswkO0oUq+wKznJo7fd
	 X1GKwgQxNJ/YhEW7lqm8vHW4MvJOU9KbMVRS0E0M3WeBrgBQvSRN2H/Z/02yxueVn7QRLisJx2b0
	 Pbkbmh6xO62J0825ZNcwKQz3I9WiEV7FPwarFp+TTdNu5frVBHxQSrJ5FGzo9jpIcEWnGpQmkr+n
	 RsQpnWVH/hvUPuJuHTIP+k6YYy+i2+MGM4w8r630e5WNBU8sQGrdtFB+MfON2cWC+xw/5170EoyV
	 rFhd055SYGBvbxd9/54a8cVHmey+txwEtFIr1ydcvfcYK1FNmJz2dgFPrAnWYiior+Gyq5AG8cI/
	 FUPMs4O0lLfM7A8IdYafWpie1hkBj77YdStvLZqjb+aVwjPgyBer0n6b/Wey1Gm2wIrm3uDeyYeW
	 2hcEr5TweXdyZVsaHcRi24GwBUJXBuLpbVsuzMc5tMe4qz9ILL81pfLJPrw8XI
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Rong Tao <rtoax@foxmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [TOOLING] (bpftool)),
	linux-kernel@vger.kernel.org (open list)
Cc: rongtao@cestc.cn,
	rtoax@foxmail.com
Subject: [PATCH bpf-next 0/2] bpftool: skel: Add
Date: Thu,  5 Jun 2025 15:49:58 +0800
X-OQ-MSGID: <cover.1749109589.git.rongtao@cestc.cn>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

Introduce functions that support opts input parameters, Obviously, it is
more convenient to use.

Rong Tao (2):
  bpftool: skel: Introduce NAME__open_and_load_opts()
  bpftool: skel: Introduce NAME__open_and_load_opts()

 tools/bpf/bpftool/Documentation/bpftool-gen.rst |  9 +++++++--
 tools/bpf/bpftool/gen.c                         | 17 ++++++++++++++---
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.49.0


