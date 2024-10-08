Return-Path: <bpf+bounces-41226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1B99944D5
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4D5B25EB0
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D781AD401;
	Tue,  8 Oct 2024 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alo0rh+I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1817917C215;
	Tue,  8 Oct 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381079; cv=none; b=uc7K6dpDpIX/QOl4PO0kQSo7MWjdYD1ZEQU2jyqTcxQQRW9HqSrvk23KCnwL+ti6i8bbAgHjSj/IOC2yH1V8yDfvqQvJZQxczTSRV/7qhquUP2J1LW9xMKG1CCuJSPQ+NZ/vr+L0eo3SE8hzIrE67TNAo0MnRrcEVThuYOasim8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381079; c=relaxed/simple;
	bh=aQRXL7X0IJ+5GQ8s3jTXvv/0pX8pK1FptW9LHEunY/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d4AagafCkgNyhxE9B0RY7NSjKn2JzpflR2fvZ/cmouY0qM+Y6DGqP7/UyVhqM55FIwjXY+SctR7Xua67a+zW2sYoh13j0EAbcFnn0mlN0u3BbhMIqzzoBjILulpxO74AaBoTsK/2LOJLIXIu5dpNYWYKetPQXf5niV9MwjqWzsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alo0rh+I; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b7259be6fso59489735ad.0;
        Tue, 08 Oct 2024 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728381077; x=1728985877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q7zRz4Fh3ZxH1R7whBmF1o2lpC1eVhM5XidXvXJZHms=;
        b=alo0rh+IUJsp7W1ZvpwBfIk4grxxBqCyepJGaUQC+rDJ3JaSuqcYM7cCQZc1IBWxJ3
         jEk8RhjsPMl0uyFxsZ6WQSRAxlfGrzXnjrvWiGR/q/w9Zbjx4DZL8o7DEnxG9EajkdV0
         XekRAg81kB7FIHxpJ4O21zZyG5SI8D+3+kek5i98J/Xm/NciaI4q8q94Q83Si++v10kw
         NlcHJay9GgY1kgexrhW1sMzz749zIo+kbfSs3MglV3C9ol+8wb8JoiAfnEDx4TwHGy3t
         BDPJg9ejQrALCcLhTzPuJgnNZldHvXW824uPLjdcLuJ75NQlkf07dY+6Xv2V/164eXHj
         vO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728381077; x=1728985877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7zRz4Fh3ZxH1R7whBmF1o2lpC1eVhM5XidXvXJZHms=;
        b=cYyiWE5ZDcSUpykTkEkcFOEx3CvjL610UnksYiWaHsud9vseIgH6LTTS66UDz8Ruap
         nnm1kPT+Zk91TFx1YccSDk8VPCFH5UtyvdjEHeXyFmt9bVe2qvYQWwA+3FD9cEfAkZNJ
         AaJ+Q85aIt+iT14UXtuthp4zRDGwyiHlZJeGtAcEuvTBK8ghVXohIE5Mdt4Koawauzv9
         nNOYedMKeV8Trz0ktm9PyEsOf/uGS8Etenax7WGjVXpONIrRn1DkX4Np1sAaz0iEOP6p
         SAkxklQIluPff/LIigqu9btwTtNBKu6zBvyypPMDxGF7cu82lVthipaF19xVQ04yfjEc
         zgGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+3hmBmeMta5NkGe2EePsuryTjB00ZGTm/KDzP7vMPR6P04Bru+Q5xwe9gfuZhmUmjIyf9Ny8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqbahzIN8EcFPOArSgTQrrxtEkMupMuEqj0/HQSvEm1gm6t9zp
	rX+WY0bSBqgAayeAj4KfTeZy4Yr3F81hgkbJdz54XZiuAg0nzHA6
X-Google-Smtp-Source: AGHT+IGLJSCgw9axqaoMQui72Q9laA0Va7Lrq3jyZHE/C2YmoY/esBEkfDkg5lKxGkP9ygQpyurPcQ==
X-Received: by 2002:a17:903:18b:b0:20b:6be7:3120 with SMTP id d9443c01a7336-20bff0642dfmr201167145ad.56.1728381077310;
        Tue, 08 Oct 2024 02:51:17 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cfd25sm52527345ad.73.2024.10.08.02.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:51:16 -0700 (PDT)
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
Subject: [PATCH net-next 0/9] net-timestamp: bpf extension to equip applications transparently
Date: Tue,  8 Oct 2024 17:51:00 +0800
Message-Id: <20241008095109.99918-1-kerneljasonxing@gmail.com>
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
better solution to extend. 

This approach relies on existing SO_TIMESTAMPING feature, for tx path,
users only needs to pass certain flags through bpf program to make sure
the last skb from each sendmsg() has timestamp related controlled flag.
For rx path, we have to use bpf_setsockopt() to set the sk->sk_tsflags
and wait for the moment when recvmsg() is called.

After this series, we could step by step implement more advanced
functions/flags already in SO_TIMESTAMPING feature for bpf extension.

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
	int rcv_flags;

	switch (op) {
	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
	case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
		rcv_flags = SOF_TIMESTAMPING_RX_SOFTWARE;
		bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING, &rcv_flags, sizeof(rcv_flags));
		bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_RX_TIMESTAMPING_OPT_CB_FLAG);
		break;
	case BPF_SOCK_OPS_TX_TS_OPT_CB:
		skops->reply = SOF_TIMESTAMPING_TX_SCHED|SOF_TIMESTAMPING_TX_ACK|SOF_TIMESTAMPING_TX_SOFTWARE|
		SOF_TIMESTAMPING_OPT_ID|SOF_TIMESTAMPING_OPT_ID_TCP;
		bpf_sock_ops_cb_flags_set(skops, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG);
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

Jason Xing (9):
  net-timestamp: add bpf infrastructure to allow exposing more
    information later
  net-timestamp: introduce TS_SCHED_OPT_CB to generate dev xmit
    timestamp
  net-timestamp: introduce TS_SW_OPT_CB to generate driver timestamp
  net-timestamp: introduce TS_ACK_OPT_CB to generate tcp acked timestamp
  net-timestamp: ready to turn on the button to generate tx timestamps
  net-timestamp: add tx OPT_ID_TCP support for bpf case
  net-timestamp: open gate for bpf_setsockopt
  net-timestamp: add bpf framework for rx timestamps
  net-timestamp: add bpf support for rx software/hardware timestamp

 include/linux/tcp.h            |  2 +-
 include/net/tcp.h              | 14 ++++++
 include/uapi/linux/bpf.h       | 36 ++++++++++++++-
 net/core/filter.c              |  3 ++
 net/core/skbuff.c              | 51 +++++++++++++++++++++
 net/ipv4/tcp.c                 | 81 ++++++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h | 36 ++++++++++++++-
 7 files changed, 217 insertions(+), 6 deletions(-)

-- 
2.37.3


