Return-Path: <bpf+bounces-31885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5B79045EC
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 22:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E89F3B23D5B
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 20:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B42B1552E3;
	Tue, 11 Jun 2024 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMgkEgmC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5273815445B
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138576; cv=none; b=cvqp64SEP97RGfWKe8EjrovvSTQX08KNk3rQjugL46pVpxoYbdx9FwScHcL4rNtN2sY15BafyDNymM50Dv76IjvjGHCqb2qQqLIoO5YqrCRF7AbwZsMCGiikrAGSF7p1+OFQV5cW8KYlZT+kKMLc/UzXWuX64zQcO9IcI/lMBkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138576; c=relaxed/simple;
	bh=z13w3FyIdhXzV19DZPaTPet/WZjvBOi8aVA1LIHuNGQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OeSYlwDuu4UbYzi0NtrW6B8QV3Ux5GjT+XkcV3gyUIpIRLIQRQDAa3cXSzEwIBcJs5YjohuWh0jZJySklfGed2RiPcBAzdnmZ1dDxGz4gireacphS2qX7f6NHy8P5CCJR8k+u1rjEvGUzy63v6vot6e4IpQEiePpcjSTVqo9g9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMgkEgmC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6c559235c6eso1156791a12.2
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718138575; x=1718743375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HdlkzLgLCtvAJq1xqlnT8MDGHFbPYIyBxlWe0HyFASk=;
        b=eMgkEgmCgezxFhQWxrXfAVaR2LPq9V7fA4WXSPMzuMS7x82BywpKQopTkpKbTXDFIC
         aHLKqgBU/SWINc5P5CNklvzLLYSXdir3pC73EyywNYclCNxDfYiULmM/cDabhdb5HrFQ
         uWBboYjoU9TVfOq8SjnCE7ITnwNS8YNVQ+FtbeON0ZVeOajTzKh6z6TurvR/QZNX0X3l
         YXSdRflvBCHpytMPGezFQzyIvGfKhkiINoBPfq5XOfEQz0j7StKhtimmwH6FQaI5WX6v
         KHkkO1qvB+SS+D+4XENLvnVzDCeWcFO27cNj3vueBJAqRAoox6a2P4MwZ9RYh73Fq49m
         JHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718138575; x=1718743375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdlkzLgLCtvAJq1xqlnT8MDGHFbPYIyBxlWe0HyFASk=;
        b=lbeI2VUVg+jDZIv2Dq8+GLLIOgC7Fv3ymvvVMj+tzHPNPldDeUJsO7yA1bjY0EQs6L
         PfR7A5RP/E6//LhMTLj7nNsZEeu3UfSyKjfOg4b2iHaast/zcbp/BqIoc6iY78va8Myn
         h4HOljrCI/9F4er0NbjTEILbHTYhorgnQ1M3L+FZIW5KzPe36b485B5fqCsn8IGr4IAR
         kkJiXgN5lP98WgkI6r3d8L6j6auc5R+9aakc8v7R0Z2BdcFK4/Xnyvv/gXRAYTuB/ua/
         VFc5R4gn0uGxSI9sinYTrHbrfvjrX2s/STcUlWhnSRVJvsyEdrzjpfZY5tXHFt7oOBJq
         J49A==
X-Forwarded-Encrypted: i=1; AJvYcCV1J96vR2edGpVKMc/xx1KKfdEsMeFCGhVEqUQqsSJ2sBm2lkc/fT7/Md82W51ST0ILbBqlWQsUEIdbvfE5n+QAkBVL
X-Gm-Message-State: AOJu0YxL5245G9yS7xDKKtnrd68pn/tsRa6guQrDtjGmifWiQzaUoss3
	AfqduG3ZGDjTnkP1YztYeM+riAtdk9MDmqa4KpnSuD2GqmX6Pa4ayszttNnVB9UIp705u64P8/i
	dky/VkoIeDg==
X-Google-Smtp-Source: AGHT+IEc5QbXZBMsJIjnHCa3x3cQ0o7LGpAL67wZoW0MKbaTpWHCcKh3+OVsJbCmYrbQKffWLuK+rCsF0ThPTw==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a63:d548:0:b0:6bc:59fc:d7a with SMTP id
 41be03b00d2f7-6e15e5e8ec4mr33968a12.9.1718138574472; Tue, 11 Jun 2024
 13:42:54 -0700 (PDT)
Date: Tue, 11 Jun 2024 20:42:47 +0000
In-Reply-To: <cover.1718138187.git.zhuyifei@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1718138187.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <8501fbbb7c61b62844c2f7e7fa5d7be3ee3aa259.1718138187.git.zhuyifei@google.com>
Subject: [RFC PATCH net-next 3/3] selftests: drv-net: Add xsk_hw AF_XDP
 functionality test
From: YiFei Zhu <zhuyifei@google.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

Run tools/testing/selftest/bpf/xsk_hw.c as part of drv-net.

A matrix of TX/RX, copy/zerocopy, and driver mode / skb mode, are
tested. Additionally, it tests some edge cases such as:
- Zerocopy TX with and without attaching an XDP prog.
- Zerocopy RX where binding happens before fillq gets filled.

TX and RX are tested separately, and the remote side always runs
the basic AF_PACKET handler rather than AF_XDP, in order to
isolate potential causes of test failures.

Currently the next-hop MAC address of each side must be manually
specified via LOCAL_NEXTHOP_MAC & REMOTE_NEXTHOP_MAC. It's probably
doable to detect these addresses automatically, but it's future work,
and probably library code since it is also applicable to csum.py.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../selftests/drivers/net/hw/xsk_hw.py        | 133 ++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_hw.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 4933d045ab66..e4647ba126a1 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -11,6 +11,7 @@ TEST_PROGS = \
 	hw_stats_l3_gre.sh \
 	loopback.sh \
 	pp_alloc_fail.py \
+	xsk_hw.py \
 	#
 
 TEST_FILES := \
diff --git a/tools/testing/selftests/drivers/net/hw/xsk_hw.py b/tools/testing/selftests/drivers/net/hw/xsk_hw.py
new file mode 100755
index 000000000000..f8ccbb0134b9
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/xsk_hw.py
@@ -0,0 +1,133 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Run the tools/testing/selftests/net/xsk_hw testsuite."""
+
+from os import path
+
+from lib.py import ksft_run, ksft_exit, KsftSkipEx
+from lib.py import NetdevFamily, NetDrvEpEnv
+from lib.py import bkg, cmd, ip, wait_port_listen
+
+
+def build_shared_args(cfg, ipv4):
+    """Build common arguments between test cases."""
+    if ipv4:
+        proto, local_addr, remote_addr = "-4", cfg.v4, cfg.remote_v4
+    else:
+        proto, local_addr, remote_addr = "-6", cfg.v6, cfg.remote_v6
+
+    local_args = (f"{proto} -i {cfg.ifname} -S {local_addr} -D {remote_addr} "
+                     f"-m ${cfg.mac_local} -M ${cfg.mac_nexthop_local}")
+    remote_args = (f"{proto} -i {cfg.ifname} -S {remote_addr} -D {local_addr} "
+                      f"-m ${cfg.mac_remote} -M ${cfg.mac_nexthop_remote}")
+
+    return local_args, remote_args
+
+
+def test_receive(cfg, ipv4, extra_args):
+    """Test local XSK receive. Remote host sends crafted packets."""
+    local_args, remote_args = build_shared_args(cfg, ipv4)
+
+    rx_cmd = f"{cfg.bin_local} -h {local_args} {extra_args}"
+    tx_cmd = f"{cfg.bin_remote} {remote_args}"
+
+    with bkg(rx_cmd, exit_wait=True, fail=True):
+        wait_port_listen(8000, proto="udp")
+        cmd(tx_cmd, host=cfg.remote)
+
+
+def test_transmit(cfg, ipv4, extra_args):
+    """Test local XSK transmit. Remote host verifies packets."""
+    local_args, remote_args = build_shared_args(cfg, ipv4)
+
+    rx_cmd = f"{cfg.bin_remote} -h -i {cfg.ifname} {remote_args}"
+    tx_cmd = f"{cfg.bin_local} -i {cfg.ifname} {local_args} {extra_args}"
+
+    with bkg(rx_cmd, host=cfg.remote, exit_wait=True, fail=True):
+        wait_port_listen(8000, proto="udp", host=cfg.remote)
+        cmd(tx_cmd)
+
+
+def test_builder(name, cfg, ipv4, tx, extra_args="", required_features=()):
+    """Construct specific tests from the common template.
+
+       Most tests follow the same basic pattern, differing only in
+       the direction of the test, the required XDP features, and
+       flags passed to xsk_hw."""
+    def f(cfg):
+        if ipv4:
+            cfg.require_v4()
+        else:
+            cfg.require_v6()
+
+        if not cfg.have_xdp_features.issuperset(required_features):
+            raise KsftSkipEx(f"Test requires XDP features {required_features}, "
+                             f"got: {cfg.have_xdp_features}")
+
+        if tx:
+            test_transmit(cfg, ipv4, extra_args)
+        else:
+            test_receive(cfg, ipv4, extra_args)
+
+    if ipv4:
+        f.__name__ = "ipv4_" + name
+    else:
+        f.__name__ = "ipv6_" + name
+    return f
+
+
+def check_nic_features(cfg) -> None:
+    """Populate device supported XDP features from netdev netlink.
+
+       If the device does not support any of the required features, then skip
+       the relevant tests."""
+    features = NetdevFamily().dev_get({"ifindex": cfg.ifindex})
+    cfg.have_xdp_features = features["xdp-features"]
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        check_nic_features(cfg)
+
+        cfg.bin_local = path.abspath(path.dirname(__file__) + "/../../../bpf/xsk_hw")
+        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
+
+        cfg.mac_local = cfg.dev["address"]
+        cfg.mac_remote = ip(f"link show dev {cfg.ifname}",
+                            host=cfg.remote, json=True)[0]["address"]
+
+        cfg.mac_nexthop_local = cfg.env["LOCAL_NEXTHOP_MAC"]
+        cfg.mac_nexthop_remote = cfg.env["REMOTE_NEXTHOP_MAC"]
+
+        cases = []
+        for ipv4 in [True, False]:
+            # Basic test with AF_PACKET on both ends
+            cases.append(test_builder("basic", cfg, ipv4, False))
+
+            cases.append(test_builder("tx_skb_copy", cfg, ipv4, True, "-T -s -c"))
+            cases.append(test_builder("tx_skb_copy_force_attach", cfg, ipv4, True, "-TT -s -c"))
+            cases.append(test_builder("rx_skb_copy", cfg, ipv4, False, "-R -s -c"))
+
+            cases.append(test_builder("tx_drv_copy", cfg, ipv4, True, "-T -d -c",
+                                      {"basic", "ndo-xmit"}))
+            cases.append(test_builder("tx_drv_copy_force_attach", cfg, ipv4, True, "-TT -d -c",
+                                      {"basic", "ndo-xmit"}))
+            cases.append(test_builder("rx_drv_copy", cfg, ipv4, False, "-R -d -c",
+                                      {"basic", "redirect"}))
+
+            cases.append(test_builder("tx_drv_zerocopy", cfg, ipv4, True, "-T -d -z",
+                                      {"basic", "xsk-zerocopy", "ndo-xmit"}))
+            cases.append(test_builder("tx_drv_zerocopy_force_attach", cfg, ipv4, True, "-TT -d -z",
+                                      {"basic", "xsk-zerocopy", "ndo-xmit"}))
+            cases.append(test_builder("rx_drv_zerocopy", cfg, ipv4, False, "-R -d -z",
+                                      {"basic", "xsk-zerocopy", "redirect"}))
+            cases.append(test_builder("rx_drv_zerocopy_fill_after_bind", cfg, ipv4, False, "-R -d -z -f",
+                                      {"basic", "xsk-zerocopy", "redirect"}))
+
+        ksft_run(cases=cases, args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.45.2.505.gda0bf45e8d-goog


