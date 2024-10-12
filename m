Return-Path: <bpf+bounces-41797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276FE99B09E
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 06:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0B91F230A8
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 04:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A29E126BFA;
	Sat, 12 Oct 2024 04:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUciom02"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEA3A41;
	Sat, 12 Oct 2024 04:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706022; cv=none; b=pZz0Y37yIXwq9vhoCZJ5tWgFqVg14xIyzE8ocLyITRN9kcpp9hCj7rW3XmPDV5pJbPtuViOIvjHXY1zjxz9xcQcp4jHbXbRKu5Mty2Cwyxrg9xGnCulWYVLF+FbuAhrz3qiTo24/8K3TpPZNL8KKJhNZOjF3WLu7578vJKwixw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706022; c=relaxed/simple;
	bh=XES2tQiEJVE0YGyL1eqHh2iIj7S30J0+qAZk12OnD7w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JOAQyrBMmzzLG16M4WP+ZPHkjMr8OhiFgKW+3/n6kKSDpBYfZSf0mvyp6Ql7GInsoIKkS9MRq25knXqemqSFme3nkZZTDYMQLOmzDsON6tTJ0OmonJGUaMCtrbh6IHfHk32EusSW/H0mHuCYPZEbkGo+/JRrwyXvVpWUEzujI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUciom02; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cb7139d9dso6496595ad.1;
        Fri, 11 Oct 2024 21:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728706020; x=1729310820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2D2DwO8yx75JDPfMkeKeAbJ6J97OrpGiGWU3haByJ5A=;
        b=PUciom02zar54iGhjA4etCM725x9uv/hZC1AezCXitv7OwHy88KidlAmjcMDxoOKCQ
         gn8yHkhkVZJsvi3hcx/awwV7OTYahO9En989LCq4dbeYwDCHUQPKWHVhxmMwvCdpr7oD
         mWtY8TYlkHhOqLmn47wM7cbcJ3fxOxfcqINBtpHOeo2Ps2U8tG08Xir15OAP46wo13Bk
         bT1T3pQsFmPcEFniyLLPRifXvv/Hn/CRVj5/WTU/hNzSW7N7srVTg9utlm+xSKyVXdIb
         JW+lHvLZ10GPFk+z0Q7Mu+i9JsTyFkBXT7mEKvK6l/GSpMQl+novHbAi2Eb53sJczTLn
         kjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728706020; x=1729310820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2D2DwO8yx75JDPfMkeKeAbJ6J97OrpGiGWU3haByJ5A=;
        b=H1l69AUH8SSEYW7r2lIrdCCdVLW9RHOQrY9Jr97UaMswLVPBlJDDPJIXF53UZk0OAd
         ZppKxIJDLvxrxeKbB0LIUrQnsVIxhnH2Zh5I58P/+y4LH87ZAj7o8la+WA4IXCrLTODZ
         DfC0UkSbfEMe4VJx2nHKm84g3vSHt5Xb2enDZ8Ex8olyN+tmQJULbWts92Ig4vokYTCF
         0SRUbiXbiOkIu4lKdIzd6D9Cwt1nQLpBf9SBqdncT8kIMvzTbmyFAXL7kxjRZnTyHAZs
         tLjp0c8wwt0/+o7JV2t+oF8fCgg/EWbujrH0EgaLBcmXdkuMoaREsbF21fWVI2lptGl/
         0U3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXf++xEntu/DhsDXEQqT1cu0EvvslDrhSLUy0Ro6ViBRXrvuDDCt83rx6gv7Ur/4hxgWBVVltU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3FTAlinpwzsc6A8dkf4VaCVbAhPiMsQZcbemm/mfbteUGK9Zk
	VSWB/g9oRGCCkTLV6BiPaNXBEbO5lgEuf+rOCdtFp/pXEolZRP01
X-Google-Smtp-Source: AGHT+IFs3OuurBGk0RLgKWivdB3HrINh60GKl06DHROmgEo/Gs2cWgEma4gcgBgEtvqJNsaQTBDI5Q==
X-Received: by 2002:a17:902:f681:b0:20c:8b88:8268 with SMTP id d9443c01a7336-20ca1425c22mr73116065ad.10.1728706019730;
        Fri, 11 Oct 2024 21:06:59 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c21301dsm30939685ad.199.2024.10.11.21.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:06:59 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 00/12] net-timestamp: bpf extension to equip applications transparently
Date: Sat, 12 Oct 2024 12:06:39 +0800
Message-Id: <20241012040651.95616-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

A few weeks ago, I planned to extend SO_TIMESTMAMPING feature by using
tracepoint to print information (say, tstamp) so that we can
transparently equip applications with this feature and require no
modification in user side.

Later, we discussed at netconf and agreed that we can use bpf for better
extension, which is mainly suggested by John Fastabend and Willem de
Bruijn. Many thanks here! So I post this series to see if we have a
better solution to extend. My feeling is BPF is a good place to provide
a way to add timestamping by administrators, without having to rebuild
applications. 

This approach mostly relies on existing SO_TIMESTAMPING feature, users
only needs to pass certain flags through bpf_setsocktop() to a separate
tsflags. For TX timestamps, they will be printed during generation
phase. For RX timestamps, we will wait for the moment when recvmsg() is
called.

After this series, we could step by step implement more advanced
functions/flags already in SO_TIMESTAMPING feature for bpf extension.

In this series, I only support TCP protocol which is widely used in
SO_TIMESTAMPING feature.

---
V2
Link: https://lore.kernel.org/all/20241008095109.99918-1-kerneljasonxing@gmail.com/
1. Introduce tsflag requestors so that we are able to extend more in the
future. Besides, it enables TX flags for bpf extension feature separately
without breaking users. It is suggested by Vadim Fedorenko.
2. introduce a static key to control the whole feature. (Willem)
3. Open the gate of bpf_setsockopt for the SO_TIMESTAMPING feature in
some TX/RX cases, not all the cases.

Note:
The main concern we've discussion in V1 thread is how to deal with the
applications using SO_TIMESTAMPING feature? In this series, I allow both
cases to happen at the same time, which indicates that even one
applications setting SO_TIMESTAMPING can still be traced through BPF
program. Please see patch [04/12].


Here is the test output:
1) receive path
iperf3-987305  [008] ...11 179955.200990: bpf_trace_printk: rx: port: 5201:55192, swtimestamp: 1728167973,670426346, hwtimestamp: 0,0
2) xmit path
iperf3-19765   [013] ...11  2021.329602: bpf_trace_printk: tx: port: 47528:5201, key: 1036, timestamp: 1728357067,436678584
iperf3-19765   [013] b..11  2021.329611: bpf_trace_printk: tx: port: 47528:5201, key: 1036, timestamp: 1728357067,436689976
iperf3-19765   [013] ...11  2021.329622: bpf_trace_printk: tx: port: 47528:5201, key: 1036, timestamp: 1728357067,436700739

Here is the full bpf program:
#include <linux/bpf.h>

#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>
#include <uapi/linux/net_tstamp.h>

int _version SEC("version") = 1;
char _license[] SEC("license") = "GPL";

# define SO_TIMESTAMPING         37

__section("sockops")
int set_initial_rto(struct bpf_sock_ops *skops)
{
	int op = (int) skops->op;
	u32 sport = 0, dport = 0;
	int flags;

	switch (op) {
	//case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
	case BPF_SOCK_OPS_TCP_CONNECT_CB:
	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
		flags = SOF_TIMESTAMPING_RX_SOFTWARE |
			SOF_TIMESTAMPING_TX_SCHED | SOF_TIMESTAMPING_TX_ACK | SOF_TIMESTAMPING_TX_SOFTWARE |
			SOF_TIMESTAMPING_OPT_ID | SOF_TIMESTAMPING_OPT_ID_TCP;
		bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));
		bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG|BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_CB_FLAG);
		break;
	case BPF_SOCK_OPS_TS_SCHED_OPT_CB:
	case BPF_SOCK_OPS_TS_SW_OPT_CB:
	case BPF_SOCK_OPS_TS_ACK_OPT_CB:
		dport = bpf_ntohl(skops->remote_port);
		sport = skops->local_port;
		bpf_printk("tx: port: %u:%u, key: %u, timestamp: %u,%u\n",
			    sport, dport, skops->args[0], skops->args[1], skops->args[2]);
		break;
	case BPF_SOCK_OPS_TS_RX_OPT_CB:
		dport = bpf_ntohl(skops->remote_port);
		sport = skops->local_port;
		bpf_printk("rx: port: %u:%u, swtimestamp: %u,%u, hwtimestamp: %u,%u\n",
			   sport, dport, skops->args[0], skops->args[1], skops->args[2], skops->args[3]);
		break;
	}
	return 1;
}


Jason Xing (12):
  net-timestamp: introduce socket tsflag requestors
  net-timestamp: open gate for bpf_setsockopt
  net-timestamp: reorganize in skb_tstamp_tx_output()
  net-timestamp: add static key to control the whole bpf extension
  net-timestamp: add bpf infrastructure to allow exposing timestamp
    later
  net-timestamp: introduce TS_SCHED_OPT_CB to generate dev xmit
    timestamp
  net-timestamp: introduce TS_SW_OPT_CB to generate driver timestamp
  net-timestamp: introduce TS_ACK_OPT_CB to generate tcp acked timestamp
  net-timestamp: add tx OPT_ID_TCP support for bpf case
  net-timestamp: make bpf for tx timestamp work
  net-timestamp: add bpf framework for rx timestamps
  net-timestamp: add bpf support for rx software/hardware timestamp

 include/linux/tcp.h            |   2 +-
 include/net/ip.h               |   2 +-
 include/net/sock.h             |  19 ++++--
 include/net/tcp.h              |  16 +++++-
 include/uapi/linux/bpf.h       |  28 ++++++++-
 net/can/j1939/socket.c         |   2 +-
 net/core/filter.c              |  39 +++++++++++++
 net/core/skbuff.c              | 102 ++++++++++++++++++++++++++++++---
 net/core/sock.c                |  68 +++++++++++++++-------
 net/ipv4/ip_output.c           |   2 +-
 net/ipv4/ip_sockglue.c         |   2 +-
 net/ipv4/tcp.c                 |  60 ++++++++++++++++++-
 net/ipv6/ip6_output.c          |   2 +-
 net/ipv6/ping.c                |   2 +-
 net/ipv6/raw.c                 |   2 +-
 net/ipv6/udp.c                 |   2 +-
 net/sctp/socket.c              |   2 +-
 net/socket.c                   |   4 +-
 tools/include/uapi/linux/bpf.h |  28 ++++++++-
 19 files changed, 333 insertions(+), 51 deletions(-)

-- 
2.37.3


