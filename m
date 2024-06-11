Return-Path: <bpf+bounces-31792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8DD903795
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 11:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81BE289B8F
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 09:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB0C176AA8;
	Tue, 11 Jun 2024 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAWiVKKs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D09176244;
	Tue, 11 Jun 2024 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097233; cv=none; b=HURW9ugSNwOA/tUuR4KBd68UpuJXCiTpedpy9MSl4E+v6AZ8+RIX1taijJRQ3kGw9X3MKGY47KZz+5V0NF52JPCrz0khaMkHHfwQpsBhSg4IlCsumfvDpK6szVzJhk++hpsYTXGKlYwBpDYotWwm7ItN5pHbW0wkXXCt9HzKMH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097233; c=relaxed/simple;
	bh=iVIg9Chp+SFgvnl0DiHQwSQmMS0jLU5+gy5nrRq4TPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J346klILsDBybeL0qGf+4V4vc8ACQ2rrWTJ5i8V2AB2y2/LvhoWp4M8gd6zv5bg6EAM2YNVwAv9jA1MVNL8Re8/AcpMka/m1HmG2Q+MPZ2arCSw72/4VXXE+ZzYS/GVfujCNaIhKVEjaWix2m03zbrkGVbTc9I3hZQUZlwArzxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAWiVKKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F073C2BD10;
	Tue, 11 Jun 2024 09:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718097233;
	bh=iVIg9Chp+SFgvnl0DiHQwSQmMS0jLU5+gy5nrRq4TPw=;
	h=From:To:Cc:Subject:Date:From;
	b=mAWiVKKsZwSZuxCoy6wJ7+sLcfTd/qFnhrwfCjVj6h/f4eiM6IXOMX6N0pXDrzEa4
	 u8TvJla0g1MKTj+NhaDH8eWhnTLbkhIpzu/dLFW4bHO/BCnkzQG1dSJVDGpSpQlH1b
	 TUm4UWt6BQlNi9ziMH0BYWFek+Zw6YV2qLrJHRwUroDExrU1jKhZjXbwqV9CxMuoSk
	 MYj0aagXV7KNECn8q9B0tkspjt/4+W71OpxnSGcEqMNElMGv+YLHLKikv6qeTvu4Uw
	 sLPnjuszEV9w0Z/RwlwzBCYTbegOCTsZuaUI5ZBuYQljvU/Z+j0ltdBydTNMArF9yf
	 NL2pZjFhl5EjA==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 0/2] Add F_SETFL for fcntl in test_sockmap
Date: Tue, 11 Jun 2024 17:13:33 +0800
Message-ID: <cover.1718096691.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v6:
 - add a fix for tls_sw_recvmsg().

v5:
 - add a new patch "Check recv lengths in test_sockmap" instead of using
   "continue" in msg_loop.

v4:
 - address Martin's comments for v3. (thanks.)
 - add Yonghong's "Acked-by" tags. (thanks.)
 - update subject-prefix from "bpf-next" to "bpf".

Patch 1, v3 of "selftests/bpf: Add F_SETFL for fcntl":
- detect nonblock flag automatically, then test_sockmap can run in both
block and nonblock modes.
- use continue instead of again in v2.

Patch 2, fix for umount cgroup2 error.

Geliang Tang (2):
  tls: wait for receiving next skb for sk_redirect
  selftests/bpf: Add F_SETFL for fcntl in test_sockmap

 net/tls/tls_sw.c                           | 2 ++
 tools/testing/selftests/bpf/test_sockmap.c | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.43.0


