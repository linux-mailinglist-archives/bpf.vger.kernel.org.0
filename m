Return-Path: <bpf+bounces-45928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1102E9E01A4
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 13:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E40B22FD1
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 12:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328C11FECBA;
	Mon,  2 Dec 2024 12:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="fQ/sPKxh"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A31FE46C
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140849; cv=none; b=iV0SxYdmel1MGzJVgbjpQS2WTYuUm/oKkFpJ1XRrnYY+QoLvQarWjXF8k0O9+UxjtMQMUD0gUqJwZWzxbFkeMrXirDop9td6VTgNzYs563mKjPHK8ol6vNEtZNGU7weuHdrLb3RvV182os6I6sahHVqFBN9IjhxnygdOD2kyZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140849; c=relaxed/simple;
	bh=8w0r3ktu1M5FUF105N4Rsn60q1AcX5GbCp8n4ZRd1As=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O0/y+/ZGYy7I5VBNSabAdoPxooOkYmdeNZfUOM2bfALEUANMI2QYYrCJJ5Gk5kDSPjzd7mvHtcUJUhO2Z5YX1x/qY/WclFgxMHMo44LI76a+T6HpI07gzeBmDFJi8NcTju+b6EDtx5YlCYVkXn/LuLJDlP1+hbYuS6sEzohCcZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=fQ/sPKxh; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tI4dF-008GeA-Tl; Mon, 02 Dec 2024 12:30:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=SC1SAF+IARgGsN+DYWrWfiuj6Ct7UFuzudPQw8Fn9tE=
	; b=fQ/sPKxh9nul6IWGHhds48hDA3TVcVtByLCZ6ENFVNswVL5jrrGUjkhibQOF4BO8NGxyuGLpp
	rFsReiga4RfrD30f/WgBgwFH3Wyd8ExZuvwLlhux99QReFEavbs7Wy89FqKDeSTbrGYseF/yim7UO
	q5U6UDPtYmTw43+RH46czAzy2qgkRFruzw5jez1N1yjDHhzit01E8lZ9A3dB9yQbeBnhfwV5aoE+m
	KjdG6G6O49g6Yoh6YcRfdzZ1UvtV76FQ6qJntETS3hJEBiNCiE/spSVLcGqVJ1YgP5eB0gUriKjl1
	geuDdnp2+3qqZo5WlGxuC8pdEfOcp2wBpx7tIQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tI4dE-0007ES-Da; Mon, 02 Dec 2024 12:30:24 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tI4d2-007H5a-4r; Mon, 02 Dec 2024 12:30:12 +0100
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH bpf 0/3] bpf, sockmap: Fix the element replace
Date: Mon, 02 Dec 2024 12:29:22 +0100
Message-Id: <20241202-sockmap-replace-v1-0-1e88579e7bd5@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABKaTWcC/x3MTQqAIBBA4avErBP8iYSuEi3MxhoqFYUIxLsnL
 b/FewUyJsIMU1cg4UOZgm8QfQf2MH5HRlszSC4HIblgOdjzNpEljJexyEZtNdfaKaMEtComdPT
 +xxnW6GCp9QOSUogNZgAAAA==
X-Change-ID: 20241201-sockmap-replace-67c7077f3a31
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Series takes care of two issues with sockmap update: inconsistent behaviour
after update with same, and race/refcount imbalance on element replace.

I am hesitant if patch 3/3 ("bpf, sockmap: Fix race between element replace
and close()") is the right approach. I might have missed some detail of the
current __sock_map_delete() implementation. I'd be grateful for comments,
thanks.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Michal Luczaj (3):
      bpf, sockmap: Fix update element with same
      selftest/bpf: Extend test for sockmap update with same
      bpf, sockmap: Fix race between element replace and close()

 net/core/sock_map.c                                    | 6 +++---
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c | 8 +++++---
 2 files changed, 8 insertions(+), 6 deletions(-)
---
base-commit: 537a2525eaf76ea9b0dca62b994500d8670b39d5
change-id: 20241201-sockmap-replace-67c7077f3a31

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


