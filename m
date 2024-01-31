Return-Path: <bpf+bounces-20790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E19843619
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 06:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836141F26E3F
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 05:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3780D3D964;
	Wed, 31 Jan 2024 05:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktHYJypZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBDB3DB89
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 05:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706679156; cv=none; b=DUN+hA/lugcxf5/G4CXf001dYE6EV1I2nFe7C4uHGt6kboqS52USG8/28LnYiKs2awF1b9sf3frp1z9cjeSKIZSiUOroPUGZc9IjoRJVKocyj+2Jco5bZ1MTbV4GkGGzc65/hI21q82AxXko5tT+5x0/qL0SSQROc8oHQKS3Jy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706679156; c=relaxed/simple;
	bh=viRArYt2LSdZCyFFaXbkpeuCDvTJDuFUuseM+L0gtoQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=PUKesDUUzxOi0hE/967eqOKI+3OeFFGKqZk8ZKG/7x00z67VxtalPGY8IQW5iNc8NlWSS8/jMMQzXQvjE2LwD3d/U4Jga04ps1GVW5O91hAXHqEEWQqMd2B2xv9E1Cr132++pxlzUE1JQ8A/34aFU6ofpeYFTvcB7KRrmZfWP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktHYJypZ; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e118da997cso1940232a34.3
        for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 21:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706679153; x=1707283953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1F3VGgeLgKaHyxSt+eI2ACUPrsRne1NkZj/RLAc22z0=;
        b=ktHYJypZ8nmkLjKDGI1GKkaW+E2Tux89CrtVPk5Q+oK1wxzaO7r9r/VD4eNqYjg+AD
         yri9szJ9TlkH7lnCSV3j6xM8sb7sOI0WiNO7tCRkG7xLV9NJTBzYx1G9VM/nDuYvtQjJ
         12jtKBT9QIXkTaDiBy9dXv9ORbXhW0myl0H52XtRUMDE9OF4sDZSSYLMlGJ1NJT4tCy/
         AFaeUcWw6NuzNN5VddyYG8kCEtm9X/tyTYA14MTgWzMM048IwKMyQlPXhTTbOM/nj6Q9
         ZsNPqw3TQIo/HatsWJxEkPRLyGq4c/15+cUPkEuOY81mpZqA4sC3uBiJVKnU1k3IWpbA
         xOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706679153; x=1707283953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1F3VGgeLgKaHyxSt+eI2ACUPrsRne1NkZj/RLAc22z0=;
        b=ZHY79ERGvdq3b9q+TcIK/Y3ItKMt5Iltbc8uDjemLj2lj2czRW07WsX0wifKMD9zWt
         q/n5+lwHgD6cqdCEnSoNLIL9qGjmWP8dN5dyYFWN5dN/W+IqQUQT5LLvKrMQ7wUQdnLc
         15nbDfAMD1rQEZGhmV8PXrQ2IGW8KaqJnl6CkasYAC93JKjpHw0z3xI4IcEBVZyJrGb7
         IvFIpUK+KAu171+yp5uOzfLkGoOwaOSaP6uLwPfter1giGU/NC+WCftFBWfCE4C5Vd+l
         9Cgu1COEiR5Ny96Q0AtZW/kWMQr8hnN9/3ktffvqDwlddAj09Sw73UmqDxKSqNv8Qq+t
         Raxg==
X-Gm-Message-State: AOJu0Ywog9DRS5VijYWONlMkzPyz7L+1BDBxQngcGt5f9p5SlUZGK3yA
	bbb7bZ2WKu1smVXlBGGJqu2JBP5r8MpiJNWHRH/eyx86+mKD0yX4L3bdj5woMXo=
X-Google-Smtp-Source: AGHT+IHjbo1Wm/QwE+h1RYOAIC/llNvmBDLDQuMO2z0ChS9gKcqls9NuoT4q1QBKHXjZt7R+Kb2CCA==
X-Received: by 2002:a05:6830:87:b0:6db:cffe:8e8b with SMTP id a7-20020a056830008700b006dbcffe8e8bmr551223oto.10.1706679153307;
        Tue, 30 Jan 2024 21:32:33 -0800 (PST)
Received: from localhost (fwdproxy-vll-009.fbsv.net. [2a03:2880:12ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id j13-20020a9d768d000000b006dde112dc5esm2246307otl.29.2024.01.30.21.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 21:32:32 -0800 (PST)
From: Manu Bretelle <chantr4@gmail.com>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	yan@cloudflare.com
Subject: [PATCH bpf-next ] selftests/bpf: disable IPv6 for lwt_redirect test
Date: Tue, 30 Jan 2024 21:32:12 -0800
Message-Id: <20240131053212.2247527-1-chantr4@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a recent change in the vmtest runner, this test started failing
sporadically.

Investigation showed that this test was subject to race condition which
got exacerbated after the vm runner change. The symptoms being that the
logic that waited for an ICMPv4 packet is naive and will break if 5 or
more non-ICMPv4 packets make it to tap0.
When ICMPv6 is enabled, the kernel will generate traffic such as ICMPv6
router solicitation...
On a system with good performance, the expected ICMPv4 packet would very
likely make it to the network interface promptly, but on a system with
poor performance, those "guarantees" do not hold true anymore.

Given that the test is IPv4 only, this change disable IPv6 in the test
netns by setting `net.ipv6.conf.all.disable_ipv6` to 1.
This essentially leaves "ping" as the sole generator of traffic in the
network namespace.
If this test was to be made IPv6 compatible, the logic in
`wait_for_packet` would need to be modified.

In more details...

At a high level, the test does:
- create a new namespace
- in `setup_redirect_target` set up lo, tap0, and link_err interfaces as
  well as add 2 routes that attaches ingress/egress sections of
  `test_lwt_redirect.bpf.o` to the xmit path.
- in `send_and_capture_test_packets` send an ICMP packet and read off
  the tap interface (using `wait_for_packet`) to check that a ICMP packet
  with the right size is read.

`wait_for_packet` will try to read `max_retry` (5) times from the tap0
fd looking for an ICMPv4 packet matching some criteria.

The problem is that when we set up the `tap0` interface, because IPv6 is
enabled by default, traffic such as Router solicitation is sent through
tap0, as in:

  # tcpdump -r /tmp/lwt_redirect.pc
  reading from file /tmp/lwt_redirect.pcap, link-type EN10MB (Ethernet)
  04:46:23.578352 IP6 :: > ff02::1:ffc0:4427: ICMP6, neighbor solicitation, who has fe80::fcba:dff:fec0:4427, length 32
  04:46:23.659522 IP6 :: > ff02::16: HBH ICMP6, multicast listener report v2, 1 group record(s), length 28
  04:46:24.389169 IP 10.0.0.1 > 20.0.0.9: ICMP echo request, id 122, seq 1, length 108
  04:46:24.618599 IP6 fe80::fcba:dff:fec0:4427 > ff02::16: HBH ICMP6, multicast listener report v2, 1 group record(s), length 28
  04:46:24.619985 IP6 fe80::fcba:dff:fec0:4427 > ff02::2: ICMP6, router solicitation, length 16
  04:46:24.767326 IP6 fe80::fcba:dff:fec0:4427 > ff02::16: HBH ICMP6, multicast listener report v2, 1 group record(s), length 28
  04:46:28.936402 IP6 fe80::fcba:dff:fec0:4427 > ff02::2: ICMP6, router solicitation, length 16

If `wait_for_packet` sees 5 non-ICMPv4 packets, it will return 0, which is what we see in:

  2024-01-31T03:51:25.0336992Z test_lwt_redirect_run:PASS:netns_create 0 nsec
  2024-01-31T03:51:25.0341309Z open_netns:PASS:malloc token 0 nsec
  2024-01-31T03:51:25.0344844Z open_netns:PASS:open /proc/self/ns/net 0 nsec
  2024-01-31T03:51:25.0350071Z open_netns:PASS:open netns fd 0 nsec
  2024-01-31T03:51:25.0353516Z open_netns:PASS:setns 0 nsec
  2024-01-31T03:51:25.0356560Z test_lwt_redirect_run:PASS:setns 0 nsec
  2024-01-31T03:51:25.0360140Z open_tuntap:PASS:open(/dev/net/tun) 0 nsec
  2024-01-31T03:51:25.0363822Z open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
  2024-01-31T03:51:25.0367402Z open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
  2024-01-31T03:51:25.0371167Z setup_redirect_target:PASS:open_tuntap 0 nsec
  2024-01-31T03:51:25.0375180Z setup_redirect_target:PASS:if_nametoindex 0 nsec
  2024-01-31T03:51:25.0379929Z setup_redirect_target:PASS:ip link add link_err type dummy 0 nsec
  2024-01-31T03:51:25.0384874Z setup_redirect_target:PASS:ip link set lo up 0 nsec
  2024-01-31T03:51:25.0389678Z setup_redirect_target:PASS:ip addr add dev lo 10.0.0.1/32 0 nsec
  2024-01-31T03:51:25.0394814Z setup_redirect_target:PASS:ip link set link_err up 0 nsec
  2024-01-31T03:51:25.0399874Z setup_redirect_target:PASS:ip link set tap0 up 0 nsec
  2024-01-31T03:51:25.0407731Z setup_redirect_target:PASS:ip route add 10.0.0.0/24 dev link_err encap bpf xmit obj test_lwt_redirect.bpf.o sec redir_ingress 0 nsec
  2024-01-31T03:51:25.0419105Z setup_redirect_target:PASS:ip route add 20.0.0.0/24 dev link_err encap bpf xmit obj test_lwt_redirect.bpf.o sec redir_egress 0 nsec
  2024-01-31T03:51:25.0427209Z test_lwt_redirect_normal:PASS:setup_redirect_target 0 nsec
  2024-01-31T03:51:25.0431424Z ping_dev:PASS:if_nametoindex 0 nsec
  2024-01-31T03:51:25.0437222Z send_and_capture_test_packets:FAIL:wait_for_epacket unexpected wait_for_epacket: actual 0 != expected 1
  2024-01-31T03:51:25.0448298Z (/tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c:175: errno: Success) test_lwt_redirect_normal egress test fails
  2024-01-31T03:51:25.0457124Z close_netns:PASS:setns 0 nsec

When running in a VM which potential resource contrains, the odds that calling
`ping` is not scheduled very soon after bringing `tap0` up increases,
and with this the chances to get our ICMP packet pushed to position 6+
in the network trace.

To confirm this indeed solves the issue, I ran the test 100 times in a
row with:

  errors=0
  successes=0
  for i in `seq 1 100`
  do
    ./test_progs -t lwt_redirect/lwt_redirect_normal
    if [ $? -eq 0 ]; then
      successes=$((successes+1))
    else
      errors=$((errors+1))
    fi
  done
  echo "successes: $successes/errors: $errors"

While this test would at least fail a couple of time every 10 runs, here
it ran 100 times with no error.

Fixes: 43a7c3ef8a15 ("selftests/bpf: Add lwt_xmit tests for BPF_REDIRECT")
Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/lwt_redirect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
index beeb3ac1c361..b5b9e74b1044 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
@@ -203,6 +203,7 @@ static int setup_redirect_target(const char *target_dev, bool need_mac)
 	if (!ASSERT_GE(target_index, 0, "if_nametoindex"))
 		goto fail;
 
+	SYS(fail, "sysctl -w net.ipv6.conf.all.disable_ipv6=1");
 	SYS(fail, "ip link add link_err type dummy");
 	SYS(fail, "ip link set lo up");
 	SYS(fail, "ip addr add dev lo " LOCAL_SRC "/32");
-- 
2.39.3


