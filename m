Return-Path: <bpf+bounces-79137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE0CD2813E
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 20:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9469A3004E2D
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCC63033E3;
	Thu, 15 Jan 2026 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7ms308c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEBD30146C
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505277; cv=none; b=G84cdlV5aKKlAGr62AddZK6A0elkGccsI/cI04GMOLbZAsjDv9xWmfCWknCr3mZ56ixTgk/f0dOBGxeImBOrto1mfHtRv/EiFrLU/tzJd2IEWT561fvkEX8Ob07iz1dcwf7eBXfarVL9Y4dLhDocRxL3iFtlEYg10OrkxFzZohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505277; c=relaxed/simple;
	bh=5GMZ/TUCwUtxSLx0LUIJ8vavIOqT65qwwK3pGMH7oFw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=N8tP72AxcR63riDsT6Qie7Pp/ZMxoPajcrF3wyCIqaFSc+lIfpTg367IDQvXLkwr670o5WjNBnr5HngXt2LxylfqOWRpfI9+vy9xQ+4bIBmNb4N0UIxG6t5kYYBh6CLf1RDXiVswq+9s7rtKUSfBf5Fa2RKonxxep/5c2Q7+8uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7ms308c; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0bae9aca3so8742595ad.3
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 11:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768505270; x=1769110070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=soGpvjxmEPNDfiYFH25uO0+94oRxBqeVCaqFrd4PTSo=;
        b=M7ms308cq3vCYpqWqPjAHza25S6z6qy+AFsuqU8eBPHBbDE/H6iKzedpqoMzKbKHly
         KJPxFwHSel44mwtXbQ6GOeZZ1goSat4XcCU1fvv32U98HYaYmMPVGHg36z+1k84Alq6Q
         yggMbGijJkBBNe6+44b3YUog1uJmOnumloPLpFFQKoCYAzOVlqL9qiTHNo2/wCRUd73m
         ZHrrMUT5QS/rW3V0OwxLfKdG7zOg01NYCCSA7rIssks+JelTZEo9aSBq8X9m/dgSlPfL
         POWpRZOUzxy4FPD3B2XYSMEY0yF1CE39OpSHD/RGW2f5ldMCPFcUcnobXEDLK5rCKWgD
         lo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505270; x=1769110070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soGpvjxmEPNDfiYFH25uO0+94oRxBqeVCaqFrd4PTSo=;
        b=Z1kUYt8xd+dhNJena3py9AvN2NorbhD8z8gfK2zV/MUDBOM+vDLiFzQLrz1XDYq6xH
         v5/J4q7sf1xxw+49tqKZoPnOw5HHsb1fc3j29vyiIY7xTLJKXxNqrLANdLL6frkNnGww
         dLfZR4hc2d7D0xJuZwCUe4vYvp+E4Hm0SFJyJNRBdm6of/U645g/Lsg5jBriyP3No+aJ
         /xVoN+VZCYbONFBt92WHVYfxaXX7LhsjetwXkfweZLEW2wVBlOm7u/YxKhPgnu+BbkeR
         ULSsp2KoO+nbKpC6+PLngR6LW51fUI01VORDKyzy18CwzOf/xtP8YdgTnwkPZ7dBkLij
         aikA==
X-Forwarded-Encrypted: i=1; AJvYcCUVE6jqziEADjhDr0EbXKY4yQgNzOiM1p0N+jGpT1muaXFZ5k2pjyP1fhkpTE8bzuHZ23I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQivg+sW8TT/t/Ws1j4MBQ1U5cnLNPeO49/HW5G0JCZnJfGb82
	+szO1Ifsitf0cz9sB8R8QTU6sNYqbERB8Qk9IchUOOYqWIfG7VsCtf04
X-Gm-Gg: AY/fxX4inyWKCiLyhIB/ZILVwQLKzim6FaA2frxbVV1RPtz4JvjdHcRUKczgaT4WeXQ
	o/r75oFPTc4wYnx7tSP3VzUPWUFxmmayVjH9l7Hu+LNK29TwpfPlnrPKrT+8KFlMNpWdI71W17N
	ByAfgA2GoGW+E99zD40dhZBS1uShCbscj4hTxvWxVD0VUOLxSd35PqppLM3U6B9qY3XYTV6POK9
	g/LpdUSzh1z1Sv6aHbxXm7wqifNG6hD9VsBUa9IiCNTg8cu8lGsb2e6JbQE2RGmHGHJnlPpNFhI
	lyBP+f1Rp89Wh0M5pTnhuD00IriK6AEB3y5SU8+AzH9B4/00IuzsWQhkLP/b3GQU8wAqUkfV9HC
	+LVzDZNSEQ/eE6+jv8F1PlS/XQmIyV+wBnAyf5FcQgeFoTvZ+P2f5osCWJWYllqEobTtHH8dsup
	xcaqNaYL9i+uvnkAxd
X-Received: by 2002:a17:902:cec3:b0:2a0:97d2:a265 with SMTP id d9443c01a7336-2a7175339eemr4597475ad.14.1768505270144;
        Thu, 15 Jan 2026 11:27:50 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:3874:1cf7:603f:ecef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce692sm876115ad.36.2026.01.15.11.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 11:27:49 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	zijianzhang@bytedance.com,
	bpf@vger.kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch bpf-next v6 0/4] tcp_bpf: improve ingress redirection performance with message corking
Date: Thu, 15 Jan 2026 11:27:33 -0800
Message-Id: <20260115192737.743857-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset improves skmsg ingress redirection performance by a)
sophisticated batching with kworker; b) skmsg allocation caching with
kmem cache.

As a result, our patches significantly outperforms the vanilla kernel
in terms of throughput for almost all packet sizes. The percentage
improvement in throughput ranges from 3.13% to 160.92%, with smaller
packets showing the highest improvements.

For latency, it induces slightly higher latency across most packet sizes
compared to the vanilla, which is also expected since this is a natural
side effect of batching.

Here are the detailed benchmarks:

+-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
| Throughput  | 64     | 128    | 256    | 512    | 1k     | 4k     | 16k    | 32k    | 64k    | 128k   | 256k   |
+-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
| Vanilla     | 0.17±0.02 | 0.36±0.01 | 0.72±0.02 | 1.37±0.05 | 2.60±0.12 | 8.24±0.44 | 22.38±2.02 | 25.49±1.28 | 43.07±1.36 | 66.87±4.14 | 73.70±7.15 |
| Patched     | 0.41±0.01 | 0.82±0.02 | 1.62±0.05 | 3.33±0.01 | 6.45±0.02 | 21.50±0.08 | 46.22±0.31 | 50.20±1.12 | 45.39±1.29 | 68.96±1.12 | 78.35±1.49 |
| Percentage  | 141.18%   | 127.78%   | 125.00%   | 143.07%   | 148.08%   | 160.92%   | 106.52%    | 97.00%     | 5.38%      | 3.13%      | 6.32%      |
+-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+

+-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
| Latency     | 64        | 128       | 256       | 512       | 1k        | 4k        | 16k       | 32k       | 63k       |
+-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
| Vanilla     | 5.80±4.02 | 5.83±3.61 | 5.86±4.10 | 5.91±4.19 | 5.98±4.14 | 6.61±4.47 | 8.60±2.59 | 10.96±5.50| 15.02±6.78|
| Patched     | 6.18±3.03 | 6.23±4.38 | 6.25±4.44 | 6.13±4.35 | 6.32±4.23 | 6.94±4.61 | 8.90±5.49 | 11.12±6.10| 14.88±6.55|
| Percentage  | 6.55%     | 6.87%     | 6.66%     | 3.72%     | 5.68%     | 4.99%     | 3.49%     | 1.46%     |-0.93%     |
+-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+

---
v6: Fixed a few kfree()'s on error path
    Added a missing sk_wmem_queued_add() on error path
    Converted backlog_work_delayed from bit to boolean for lockless access
    Reorganized struct sk_psock fields

v5: no change, just rebase

v4: pass false instead of 'redir_ingress' to tcp_bpf_sendmsg_redir()

v3: no change, just rebase

v2: improved commit message of patch 3/4
    changed to 'u8' for bitfields, as suggested by Jakub

Cong Wang (2):
  skmsg: rename sk_msg_alloc() to sk_msg_expand()
  skmsg: optimize struct sk_psock layout

Zijian Zhang (2):
  skmsg: implement slab allocator cache for sk_msg
  tcp_bpf: improve ingress redirection performance with message corking

 include/linux/skmsg.h |  47 +++++++---
 net/core/skmsg.c      | 176 ++++++++++++++++++++++++++++++++---
 net/ipv4/tcp_bpf.c    | 209 +++++++++++++++++++++++++++++++++++++++---
 net/tls/tls_sw.c      |   6 +-
 net/xfrm/espintcp.c   |   2 +-
 5 files changed, 399 insertions(+), 41 deletions(-)

-- 
2.34.1


