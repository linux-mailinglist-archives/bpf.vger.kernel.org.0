Return-Path: <bpf+bounces-64491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3694EB1380B
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 11:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8936417C67A
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8E9263C90;
	Mon, 28 Jul 2025 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORYZUtll"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB92571B0;
	Mon, 28 Jul 2025 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695844; cv=none; b=lPGK/ZXnBJxfoWmfstSsJU/KWFH70TMioje45YQIlIGw62ooJ18E6rv2AFwLpwB+cqEsMsUoPEKjO1twzFYQ7Oy+3dDPY0X8vRBttMrkLX1WwgxPOkS40dpnnN5NfJeYnSpU95H99uxjHHljCy3jseAh9yWnJicpSTVX7iIVrZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695844; c=relaxed/simple;
	bh=QwvRXzFZogKebxw5m6w84tCyPvrj+Mj2jXrz70Fx9zU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JlrwaKEiH3j/8noVb+cjyQfWrL1WbnRBzYrIMoSCOmOSi1RbRJINoZ6cvvv1qrxihhc6OPStaYpsdnn6pf6yKbmXkCmRh19g4PNmodas5Lz2OV11uvikJe/04/NDSrbKfgbTvO3FwKbCKD+yu/YzHFx0c/IQIb+9xGALinzeNI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORYZUtll; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45619d70c72so37892915e9.0;
        Mon, 28 Jul 2025 02:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753695841; x=1754300641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpZDkIwSNXAkfznm1ocUN63CgTKXhTTLgm3bOfdy+mQ=;
        b=ORYZUtllT5ji0QwzjdGjfcEUkkz1a0r5ngyWUXrq0RMg+jsZFGAZxe2niKlLHbAXSZ
         poLeIQeC0EfD29IEJXxOuoqiKORbyx6Oc6uQMdDdg9aSeD7y2XiH6QBjjNxAx1QICZBr
         cg5smCCDmCTYb4EsLpbZuFetYbIDPZJRsTw5+EF+HxuUVfhKM9ibBsdkt1uSGTHjfC/q
         7tz1IJAqvdFSspZsr8kqcnkDXufpdMH07a0OU33WpmzcP+AZmHfoLg3WmOu4mR+Ug6HM
         RUKiM7KVEmlZJYIwC9Y7+vit5FxDLvCJxQcGEtEX+Dii0J6j3o3MDYm/ZyBC/NrX+pWM
         DDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695841; x=1754300641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpZDkIwSNXAkfznm1ocUN63CgTKXhTTLgm3bOfdy+mQ=;
        b=PA709fgoPJX6UKOkTOMkHUDPE2WiV6k6rFUtbMcDaeRQ+7wanm3lEU9OT1JUN7uqoh
         HSZMljndlSoEPU9yQvJnHgJvyzbomIEVTNB2QAc1aC+mmq16WvAJD1XK2ZYtK1XnUjzE
         zqG/CuoO0N0Drs++vAwGuTSN6b6Z/O1hg5R6gWbfhgWGLAjgXZomQVo83mJvn7pSubxK
         spK2ZeZv+VjgtVkf66I3DsnRg6RxoRIr8gJ56+lHGiU2TEZBWnKQxvjxSwT6BcIeirT3
         /jNJbrJfdtChnCAc63CkMZRcPUK/VcRenl+s59lu9BjNxfrgh9v+cs6UlM2hr/YJUJQH
         noPw==
X-Forwarded-Encrypted: i=1; AJvYcCUOl31/WcrRAjYEaWsdZqTw07b/iXbtcQ01Hxf4a64iNpqSaModVY1BbvTnun812+Pbljo=@vger.kernel.org, AJvYcCUT5CQrvKKmi2hQDaQFtJ8zLDmuVmTXRakL8yaVN8zHGx3budD1nmkSy3fjABIozrA07d6pDcFq4yCY87qK/0SA@vger.kernel.org, AJvYcCV4yFvw11d1Lq6q788kp0fKvqNAjIzJC1v+Ca7TC5lqGuXbVl9oXAoyV0f8QPZyBHhIvp3sB/DJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxFC0NZze0vVaraqAA5WeVIX9bKhHYdNAOoyk0BONzGGmmKi5dp
	UOGGQ2tU92Qyx4AwIDGGcBYMihTt+YmI8ZkS5mDqI0IiarDVL9l+kTNs
X-Gm-Gg: ASbGncsGsMp+U2Q5q8FvxQhmmJ2FtwWp3hyhvOCCPapmuaFp1yHdoj/ijqJf/Rh6zQa
	52bPTzcNEJyftjFaGC9Eimu2h8ljSr8BVz7SunJXXIWB4D0s9QoSYVg4+ztbeuo89wIg94ztrka
	oJIoRyTdaMHPFC9lZ9jj/vq2i9/W5y21SthniKyErQd1Ig5WGUwPawSmSJuH/muy7YUtclZSQyL
	uqmPSjRU03MxusqDSpY5SmfvbWsCoZNJhsQdZ+a7xf+fzDBWSayAmzef/T0cWn0qV5biMfoZ5F2
	+YdZloujIGCQqvN+ZypQbBwCCEGzXMyFW+uff0E8tk6G0Lyh/rRihPQ1E0TUvZq1NyNQAtefM6w
	jIO14GnFlT3LCnvQqkRpyJ0v89ddjM5i7l7cHJD7azr6EfBLUbTSWhB1kQRY=
X-Google-Smtp-Source: AGHT+IG5YcJv7gRPiLUXWoPYJT12uySQOIVS9lPTpxptOjBAj2UVXqoD1tWPU/3FVsEas2UhJ6xBsQ==
X-Received: by 2002:a05:600c:8882:b0:456:1146:5c01 with SMTP id 5b1f17b1804b1-458705801acmr86122455e9.12.1753695840650;
        Mon, 28 Jul 2025 02:44:00 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458705bcbfbsm153422725e9.16.2025.07.28.02.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:43:59 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: lkp@intel.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	coreteam@netfilter.org,
	daniel@iogearbox.net,
	fw@strlen.de,
	john.fastabend@gmail.com,
	mahe.tardy@gmail.com,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org
Subject: [PATCH bpf-next v3 0/4] bpf: add icmp_send_unreach kfunc
Date: Mon, 28 Jul 2025 09:43:41 +0000
Message-Id: <20250728094345.46132-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202507270940.kXGmRbg5-lkp@intel.com>
References: <202507270940.kXGmRbg5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v3 of adding the icmp_send_unreach kfunc, as suggested during
LSF/MM/BPF 2025[^1]. The goal is to allow cgroup_skb programs to
actively reject east-west traffic, similarly to what is possible to do
with netfilter reject target.

The first step to implement this is using ICMP control messages, with
the ICMP_DEST_UNREACH type with various code ICMP_NET_UNREACH,
ICMP_HOST_UNREACH, ICMP_PROT_UNREACH, etc. This is easier to implement
than a TCP RST reply and will already hint the client TCP stack to abort
the connection and not retry extensively.

Note that this is different than the sock_destroy kfunc, that along
calls tcp_abort and thus sends a reset, destroying the underlying
socket.

Caveats of this kfunc design are that a cgroup_skb program can call this
function N times, thus send N ICMP unreach control messages and that the
program can return from the BPF filter with SK_PASS leading to a
potential confusing situation where the TCP connection was established
while the client received ICMP_DEST_UNREACH messages.

Another more sophisticated design idea would be for the kfunc to set the
kernel to send an ICMP_HOST_UNREACH control message with the appropriate
code when the cgroup_skb program terminates with SK_DROP. Creating a new
'SK_REJECT' return code for cgroup_skb program was generally rejected
and would be too limited for other program types support.

We should bear in mind that we want to add a TCP reset kfunc next and
also could extend this kfunc to other program types if wanted.

v2 updates:
- fix a build error from a missing function call rename;
- avoid changing return line in bpf_kfunc_init;
- return SK_DROP from the kfunc (similarly to bpf_redirect);
- check the return value in the selftest.

v3 update:
- fix an undefined reference build error.

[^1]: https://lwn.net/Articles/1022034/

Mahe Tardy (4):
  net: move netfilter nf_reject_fill_skb_dst to core ipv4
  net: move netfilter nf_reject6_fill_skb_dst to core ipv6
  bpf: add bpf_icmp_send_unreach cgroup_skb kfunc
  selftests/bpf: add icmp_send_unreach kfunc tests

 include/net/ip6_route.h                       |  2 +
 include/net/route.h                           |  1 +
 net/core/filter.c                             | 61 ++++++++++++
 net/ipv4/netfilter/nf_reject_ipv4.c           | 19 +---
 net/ipv4/route.c                              | 15 +++
 net/ipv6/netfilter/nf_reject_ipv6.c           | 17 +---
 net/ipv6/route.c                              | 18 ++++
 .../bpf/prog_tests/icmp_send_unreach_kfunc.c  | 99 +++++++++++++++++++
 .../selftests/bpf/progs/icmp_send_unreach.c   | 36 +++++++
 9 files changed, 235 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send_unreach.c

--
2.34.1


