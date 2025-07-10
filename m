Return-Path: <bpf+bounces-62907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A99AFFF38
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 12:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC9C4E8232
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBC02D8DC4;
	Thu, 10 Jul 2025 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj0Abyu3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD92D46DE
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143201; cv=none; b=XiNf7/gRVlMDtNL/orJd+E4tBYoDxzrWfVmxGcic/eOReBImwgunaz3760s0+W0gxtDEkKKQIg/GtnXrp4QQWnvFvSJTH1AoTReNQqvgtkn7TJNMOErB5umSMbyitil9KOAJnj3Ap/bEZyegirOXoujlJLCUTERm2jM8Lxzb0s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143201; c=relaxed/simple;
	bh=bqL1L24C8LuiN81a62VZFB8R4Nxj2OvcExsgKEN32+M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jveQ/poWnguyd/I9M/ckRi3K1L1rrgQzXFw/C0jldVb271ISHa/PBJgSS3RwkSX4MSiwiOW4PcXQAy/o/xVFrRHaYRhXV8LgzOxXNcS+/yl4mB7dpdpyCUnDWPMwJfXMkCdp2Md4MEtzd9+oK0uR59pjh5p9o/XqviS5IDqevRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj0Abyu3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a54700a46eso531559f8f.1
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752143198; x=1752747998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lp/Bb7VkYBHnDsN+n0vWV6mPt2UCeAGK6kGZUIkb81c=;
        b=dj0Abyu3RWk7xh8qM6IXDI73LIAL9MTJKHuFkEi5yikK9TTGsBu3QECTKlbaOe2EkB
         rDFPAHoIip7ndJI0Aab+2VHiWxL4d+7YbRJwQqt6/AH3rF5zmU0RHr73I4uQYR/24Tr2
         uc/4VjpWbcG9kuCZfGknvQn7BcJiBemtkda7yOotaqKLBB9i4c50nxzdVhyRFl3H/UxH
         407JsvQKhRA//PFv/jzLIOSdhxN0SDPmrzQSAM6uf8WhcaC49Uzcw8/de5OOq9yxtUca
         Vltcda0Q7PoAAH+wHwyL0YUoyGnGti6PAAiVbe0JVsi5pmgdQF1M5N12ny/hfTOlPMjO
         WCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752143198; x=1752747998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lp/Bb7VkYBHnDsN+n0vWV6mPt2UCeAGK6kGZUIkb81c=;
        b=NT6nsuXDMknS46Jth3KnnM0ZM3ULmF7G0AAOLIoOnhq1KlANFQoCNqMrlsNV8y3YVq
         bI49OVXW0EwBz6ONVCQ3H/kLtXxof5vuvaAm0KkW5AamOXoVrQdfn8aPPKBxEVDEVtRx
         WSPTIg7JiNvGa9KS80VuchfsT81uULfBftmE9UhCBCQUFmlZMXmMj6xUq92RL32IQMlg
         6dPOprGBK4eMnUMU7uOq6Ujn92z8S2DumO9CDgTlUoGinQmExmTXemKzHUzDG2b3lc1H
         WtWDeA6M/Dw5q2z3t/JlskDY3V3Y0zfiUWxFXH8nWjQaFzjyJOxxTjeMoKmyzdrI58kY
         C8lw==
X-Gm-Message-State: AOJu0YwG32FeRVHTozEtpzG/aVS95tzJrbkg+F4pawCU3IK40R+rZy3I
	CJExN4XiPTQZCg0NekeCuswPGqttWvTcBCOmYhZVWv9sEOWBuxzcfQSQsAyy0NQwFoA=
X-Gm-Gg: ASbGnct0eZbzbI/U6KX7PIkmW6VHrQbwk+aW7dJ3tcxn6hew748haCrYTtfN37mKKs2
	8Z7SXJgowE8xEF49rMtOXU89IGwXnsAXyFyjg7fJj1jouRco+VUIebVglJOYnjzNO69vZStbBGr
	cWyU5B7X3qWyt/0qoQTB2FamNrPLobEc6/zH/gbkP086J0A5MEDYgj+gh0jiDMEL0uFY9jXq0wu
	e/T4Ocxtq/sBXZX/ATt88EGel59HRMtkGbWvxxwi/YLaNQ9RqBZBufwMznGJF+Sn1X0NlBdIiQU
	XOQBVP/jXqPcV+sJLlIAN6M/dAZ1656UpjpN2OY6UJsQpX9H8sOKsqKd1kNtk2vJxcD+DSmGQtL
	f1RhmLLnXj5ox
X-Google-Smtp-Source: AGHT+IGvLR5ApARVH1fktF63NymRxcyeBRlA4nwgqZu+xM1VCpnFQegREvMJKs1jWeQS4sNYrtM9mQ==
X-Received: by 2002:a05:6000:22ca:b0:3a5:39d8:57e4 with SMTP id ffacd0b85a97d-3b5e4533bbemr4935520f8f.41.1752143198057;
        Thu, 10 Jul 2025 03:26:38 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-454d511cb48sm52639745e9.36.2025.07.10.03.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 03:26:37 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v1 0/4] bpf: add icmp_send_unreach kfunc
Date: Thu, 10 Jul 2025 10:26:03 +0000
Message-Id: <20250710102607.12413-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v1 of adding the icmp_send_unreach kfunc, as suggested during
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

Caveats of this design are that a cgroup_skb program can call this
function N times, and thus send N ICMP unreach control messages, and
that the program can also finish the BPF filter with SK_PASS leading to
a potential confusing situation where the TCP connection was established
while the client receive ICMP_DEST_UNREACH messages.

Other design ideas (to prevent above issues) could be:
* Extend the return codes for the cgroup_skb program to trigger the
  reject after completion (SK_REJECT).
* Adding a kfunc to set the kernel to send an ICMP_HOST_UNREACH control
  message with appropriate code when the cgroup_skb program eventually
  terminates with SK_DROP.

We should bear in mind that we want to extend this with TCP reset next.
Please tell me what's your opinion on above ideas: if adding new return
codes could be considered and/or the other alternatives would be better
than this patch series and thus proposed instead.

v1 updates (from Daniel's offline review):
- rename netfilter moved functions to ip(6)_route_reply_fetch_dst;
- explain why nf_ip(6)_route are replaced with core route functions;
- remove useless IP frag checks;
- add KF_TRUSTED_ARGS to the kfunc;
- simplify declarations of structs, initialize fd to -1 in tests;
- insist on why SK_PASS is easier for testing in BPF prog.

[^1]: https://lwn.net/Articles/1022034/

Mahe Tardy (4):
  net: move netfilter nf_reject_fill_skb_dst to core ipv4
  net: move netfilter nf_reject6_fill_skb_dst to core ipv6
  bpf: add bpf_icmp_send_unreach cgroup_skb kfunc
  selftests/bpf: add icmp_send_unreach kfunc tests

 include/net/ip6_route.h                       |  2 +
 include/net/route.h                           |  1 +
 net/core/filter.c                             | 63 +++++++++++-
 net/ipv4/netfilter/nf_reject_ipv4.c           | 19 +---
 net/ipv4/route.c                              | 15 +++
 net/ipv6/netfilter/nf_reject_ipv6.c           | 17 +---
 net/ipv6/route.c                              | 18 ++++
 .../bpf/prog_tests/icmp_send_unreach_kfunc.c  | 96 +++++++++++++++++++
 .../selftests/bpf/progs/icmp_send_unreach.c   | 35 +++++++
 9 files changed, 232 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/icmp_send_unreach.c

--
2.34.1


