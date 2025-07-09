Return-Path: <bpf+bounces-62825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 394BCAFEFFD
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 19:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66271C82117
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 17:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9309237717;
	Wed,  9 Jul 2025 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7PTbtcG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505F522FF2E;
	Wed,  9 Jul 2025 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082677; cv=none; b=S1CFqDJKIQx/kfV0j4qcCtYu4Hxcm7J6n0r1TUmHeG/z+DviYRtpyvEkPsz9/SAO/B/uZW4OoDKKeQruajTE61/B/jgto//P9XL6+jxftx2EplZCQ8bJoNoCmn0ByUG+JWu4wHVSseBmeei8LUQxpw88l3mHpDcmibkXBP10UzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082677; c=relaxed/simple;
	bh=OMOgvfdHTO0N0tGSTRzzcPyqZZpHdz+tJYmDsqLzymM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMmn+wJcDlyZSC+YCIrbL+zjscrQZ7YTyK5F9e1PIG+yrpc5WYTFOi3geF0epZCng8Ixy2VMW7bqf/VqUCJM2nAGqSM0efV7/s8pgvf5ln+mogh0Axy65pa/CaRU9LEJX1na7cN5PrBHgR9O9+OTQv+hI4BgbtpmRr+Qb+HyVKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7PTbtcG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451d3f72391so1066755e9.3;
        Wed, 09 Jul 2025 10:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752082673; x=1752687473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gw+G0MC9wj+Jkn+UMmX3IcTYEfrzvzSXrova8Fe+FcY=;
        b=N7PTbtcG5dmoE3+ZuqIL5AA6JU5XBgVLHdWpAhv4JIp/Qw/YdEKdw+pQyZs2Jqg/NE
         XCEeRM20xvwC/OCxmuRfXAUsFOT/VjB/10xZ683FOK8QBuAEuwLE7U5LPwuDXbY/ok7P
         L1XgQghDmL4trAEsP1IRYmveVmVC6IPV7l102Ow3GRHJeJQGho+TpGCgpfzSGr315nt0
         yP8KHEhhYmHqwrj+YQdPJEX2ynjaUN6REAWcho840lI+4XQvZc2DcntnuVRUnOJSiEQz
         pmDERshGmg7bio1M29oBv579g+7tC2xm/1tslMQGI+8a8P8uhDtZdYHMNJIpcItFzkFg
         0nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752082673; x=1752687473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gw+G0MC9wj+Jkn+UMmX3IcTYEfrzvzSXrova8Fe+FcY=;
        b=Fx85BqGufuc8c7ttlH+l2/Nbsvn02Gspd6so07eKbz+43PSh5wB925jTnKNQpQ2PTp
         GBBF/zekxfP+LUnMJMejPHKaleKs5cWrA+XY7Awp7oDwLJpols20LkRDl8XRHDWKtT+7
         itoNq2ppBkXwT4zBYZcVezDmCiuCgE3ZeqEvhn5w4RLWoNknObAgv/kejm+z/87PINMP
         0njomoVsSko+PdOFUTOl47QUQsUCUmuaororTbJVIhAAEauwedN8AspU0WCWxUMLIaPP
         va52IC+JYXeF17nQxLkhY+F0wwHFuok5ejGjtcXq8CVC8mQ+KiASJYjhWrh1xC5imEUP
         ESZg==
X-Forwarded-Encrypted: i=1; AJvYcCX+hXv6kYuYla9nNRzjJpf/zd5q6SYADr+O5vWMUHQO9hEF6Zb2UQpA2JYYmZnFMk5VbtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCdm4FVFx1JTKyrA9RKLsD9VYgR9tItNVsLHZBaTGmKCf/z+4q
	/ee5LfAouJ3c+TyCs+SIG2VYfZJDdUMJleWB/H7TTMXpyl6ewDSaUl6mDf6qnBnY
X-Gm-Gg: ASbGncu33YfLObSoeU38NuidBg8/N1GZtqyl7XHBp4mBQ71vkOEAu1zkY+vuc9M10Z+
	TM5feChLOwIkeU3lJAwBn3l+oXUjEGS8XAV3nKF0khykX4KTLE2Voc+BEa5YsvFg/xMXn+fGiH0
	ZDKHDbr5zIh26Jlke0wF+lw4uQ/I0Vaa1yyjcbJDG2/S0yUcKlWTumoX66SWTXxM7YnpTbe+SKy
	LjZR7zZE53EgmOccCZGqVsvZt3TKGcgRGW+jKDjjSZ8YUzfokyhLQuQCQZO6/nBxRoHXUy+430i
	zLF1DVpDDsYfOhA4h8mY2eXuD8VpKwy2ZKQwLLMtzw1Sgq2e2I+ZLePz2HHm04Hu5ADo0g==
X-Google-Smtp-Source: AGHT+IGrMZzPIMA+OZ8ptXUvy+eENlLvi9ZNPqRHm3/+TpxY3QE6cvxOQLizwUrc7YybiNvCfDTMCw==
X-Received: by 2002:a05:600c:34d0:b0:441:b3eb:574e with SMTP id 5b1f17b1804b1-454db7ba710mr5068645e9.5.1752082672981;
        Wed, 09 Jul 2025 10:37:52 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:2::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225b5cdsm16321176f8f.85.2025.07.09.10.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 10:37:52 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	horms@kernel.org,
	cratiu@nvidia.com,
	noren@nvidia.com,
	cjubran@nvidia.com,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	jdamato@fastly.com,
	gal@nvidia.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org
Subject: [PATCH net-next 5/5] selftests: drv-net: Test head-adjustment support
Date: Wed,  9 Jul 2025 10:37:07 -0700
Message-ID: <20250709173707.3177206-6-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250709173707.3177206-1-mohsin.bashr@gmail.com>
References: <20250709173707.3177206-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test to validate the headroom adjustment support for both extension
and the shrinking cases. For the extension part, eat up space from
the start of payload data whereas, for the shrinking part, populate
the newly available space with a tag. In the user-space, validate that a
test string is manipulated accordingly.

./drivers/net/xdp.py
TAP version 13
1..9
ok 1 xdp.test_xdp_native_pass_sb
ok 2 xdp.test_xdp_native_pass_mb
ok 3 xdp.test_xdp_native_drop_sb
ok 4 xdp.test_xdp_native_drop_mb
ok 5 xdp.test_xdp_native_tx_mb
\# Failed run: pkt_sz 2048, ... offset -256. Reason: Adjustment failed
ok 6 xdp.test_xdp_native_adjst_tail_grow_data
ok 7 xdp.test_xdp_native_adjst_tail_shrnk_data
\# Failed run: pkt_sz 512, ... offset -128. Reason: Adjustment failed
ok 8 xdp.test_xdp_native_adjst_head_grow_data
\# Failed run: pkt_sz (2048) > HDS threshold (1536) and offset 64 > 48
ok 9 xdp.test_xdp_native_adjst_head_shrnk_data
\# Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 tools/testing/selftests/drivers/net/xdp.py    | 147 ++++++++++++++++-
 .../selftests/net/lib/xdp_native.bpf.c        | 155 ++++++++++++++++++
 2 files changed, 301 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index b62e41c0e708..648fda231728 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -12,7 +12,7 @@ from dataclasses import dataclass
 from enum import Enum
 
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ne, ksft_pr
-from lib.py import KsftFailEx, KsftSkipEx, NetDrvEpEnv
+from lib.py import KsftFailEx, KsftSkipEx, NetDrvEpEnv, EthtoolFamily, NlError
 from lib.py import bkg, cmd, rand_port
 from lib.py import ip, bpftool, defer
 
@@ -31,6 +31,7 @@ class XDPAction(Enum):
     DROP = 1  # Drop the packet
     TX = 2    # Route the packet to the remote host
     TAIL_ADJST = 3  # Adjust the tail of the packet
+    HEAD_ADJST = 4  # Adjust the head of the packet
 
 
 class XDPStats(Enum):
@@ -490,6 +491,147 @@ def test_xdp_native_adjst_tail_shrnk_data(cfg):
     _validate_res(res, offset_lst, pkt_sz_lst)
 
 
+def get_hds_thresh(cfg):
+    """
+    Retrieves the header data split (HDS) threshold for a network interface.
+
+    Args:
+        cfg: Configuration object containing network settings.
+
+    Returns:
+        The HDS threshold value. If the threshold is not supported or an error occurs,
+        a default value of 1500 is returned.
+    """
+    netnl = cfg.netnl
+    hds_thresh = 1500
+
+    try:
+        rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+        if 'hds-thresh' not in rings:
+            ksft_pr(f'hds-thresh not supported. Using default: {hds_thresh}')
+            return hds_thresh
+        hds_thresh = rings['hds-thresh']
+    except NlError as e:
+        ksft_pr(f"Failed to get rings: {e}. Using default: {hds_thresh}")
+
+    return hds_thresh
+
+
+def _test_xdp_native_head_adjst(cfg, prog, pkt_sz_lst, offset_lst):
+    """
+    Tests the XDP head adjustment action for a multi-buffer case.
+
+    Args:
+        cfg: Configuration object containing network settings.
+        netnl: Network namespace or link object (not used in this function).
+
+    This function sets up the packet size and offset lists, then performs
+    the head adjustment test by sending and receiving UDP packets.
+    """
+    cfg.require_cmd("socat", remote=True)
+
+    prog_info = _load_xdp_prog(cfg, BPFProgInfo(prog, "xdp_native.bpf.o", "xdp.frags", 9000))
+    port = rand_port()
+
+    _set_xdp_map("map_xdp_setup", TestConfig.MODE.value, XDPAction.HEAD_ADJST.value)
+    _set_xdp_map("map_xdp_setup", TestConfig.PORT.value, port)
+
+    hds_thresh = get_hds_thresh(cfg)
+    for offset in offset_lst:
+        for pkt_sz in pkt_sz_lst:
+            # The "head" buffer must contain at least the Ethernet header
+            # after we eat into it. We send large-enough packets, but if HDS
+            # is enabled head will only contain headers. Don't try to eat
+            # more than 28 bytes (UDPv4 + eth hdr left: (14 + 20 + 8) - 14)
+            l2_cut_off = 28 if cfg.addr_ipver == 4 else 48
+            if pkt_sz > hds_thresh and offset > l2_cut_off:
+                ksft_pr(
+                f"Failed run: pkt_sz ({pkt_sz}) > HDS threshold ({hds_thresh}) and "
+                f"offset {offset} > {l2_cut_off}"
+                )
+                return {"status": "pass"}
+
+            test_str = ''.join(random.choice(string.ascii_lowercase) for _ in range(pkt_sz))
+            tag = format(random.randint(65, 90), '02x')
+
+            _set_xdp_map("map_xdp_setup",
+                     TestConfig.ADJST_OFFSET.value,
+                     offset)
+            _set_xdp_map("map_xdp_setup", TestConfig.ADJST_TAG.value, int(tag, 16))
+            _set_xdp_map("map_xdp_setup", TestConfig.ADJST_OFFSET.value, offset)
+
+            recvd_str = _exchg_udp(cfg, port, test_str)
+
+            # Check for failures around adjustment and data exchange
+            failure = _check_for_failures(recvd_str, _get_stats(prog_info['maps']['map_xdp_stats']))
+            if failure is not None:
+                return {
+                    "status": "fail",
+                    "reason": failure,
+                    "offset": offset,
+                    "pkt_sz": pkt_sz
+                }
+
+            # Validate data content based on offset direction
+            expected_data = None
+            if offset < 0:
+                expected_data = chr(int(tag, 16)) * (0 - offset) + test_str
+            else:
+                expected_data = test_str[offset:]
+
+            if recvd_str != expected_data:
+                return {
+                    "status": "fail",
+                    "reason": "Data mismatch",
+                    "offset": offset,
+                    "pkt_sz": pkt_sz
+                }
+
+    return {"status": "pass"}
+
+
+def test_xdp_native_adjst_head_grow_data(cfg):
+    """
+    Tests the XDP headroom growth support.
+
+    Args:
+        cfg: Configuration object containing network settings.
+
+    This function sets up the packet size and offset lists, then calls the
+    _test_xdp_native_head_adjst_mb function to perform the actual test. The
+    test is passed if the headroom is successfully extended for given packet
+    sizes and offsets.
+    """
+    pkt_sz_lst = [512, 1024, 2048]
+
+    # Positive value indicates data part is growing by the corresponding value
+    offset_lst = [-16, -32, -64, -128, -256]
+    res = _test_xdp_native_head_adjst(cfg, "xdp_prog_frags", pkt_sz_lst, offset_lst)
+
+    _validate_res(res, offset_lst, pkt_sz_lst)
+
+
+def test_xdp_native_adjst_head_shrnk_data(cfg):
+    """
+    Tests the XDP headroom shrinking support.
+
+    Args:
+        cfg: Configuration object containing network settings.
+
+    This function sets up the packet size and offset lists, then calls the
+    _test_xdp_native_head_adjst_mb function to perform the actual test. The
+    test is passed if the headroom is successfully shrunk for given packet
+    sizes and offsets.
+    """
+    pkt_sz_lst = [512, 1024, 2048]
+
+    # Negative value indicates data part is shrinking by the corresponding value
+    offset_lst = [16, 32, 64, 128, 256]
+    res = _test_xdp_native_head_adjst(cfg, "xdp_prog_frags", pkt_sz_lst, offset_lst)
+
+    _validate_res(res, offset_lst, pkt_sz_lst)
+
+
 def main():
     """
     Main function to execute the XDP tests.
@@ -500,6 +642,7 @@ def main():
     function to execute the tests.
     """
     with NetDrvEpEnv(__file__) as cfg:
+        cfg.netnl = EthtoolFamily()
         ksft_run(
             [
                 test_xdp_native_pass_sb,
@@ -509,6 +652,8 @@ def main():
                 test_xdp_native_tx_mb,
                 test_xdp_native_adjst_tail_grow_data,
                 test_xdp_native_adjst_tail_shrnk_data,
+                test_xdp_native_adjst_head_grow_data,
+                test_xdp_native_adjst_head_shrnk_data,
             ],
             args=(cfg,))
     ksft_exit()
diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index a974d1869385..c5a12a17e36d 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -31,6 +31,7 @@ enum {
 	XDP_MODE_DROP = 1,
 	XDP_MODE_TX = 2,
 	XDP_MODE_TAIL_ADJST = 3,
+	XDP_MODE_HEAD_ADJST = 4,
 } xdp_map_modes;
 
 enum {
@@ -328,6 +329,158 @@ static int xdp_tail_ext(struct xdp_md *ctx, __u16 port)
 	return XDP_ABORTED;
 }
 
+static int xdp_adjst_head_shrnk_data(struct xdp_md *ctx, const __u32 hdr_len,
+				const __u32 size)
+{
+	char tmp_buff[MAX_ADJST_OFFSET];
+	void *data, *data_end;
+	void *offset_ptr;
+
+	data = (void *)(long)ctx->data;
+	data_end = (void *)(long)ctx->data_end;
+
+	/* Update the length information in the IP and UDP headers before adjusting
+	 * the headroom. This simplifies accessing the relevant fields in the IP and
+	 * UDP headers for fragmented packets. Any failure beyond this point will
+	 * result in the packet being aborted, so we don't need to worry about
+	 * incorrect length information for passed packets.
+	 */
+	update_pkt(data, data_end, (__s16)(0 - size));
+
+	if (bpf_xdp_load_bytes(ctx, 0, tmp_buff, MAX_ADJST_OFFSET) < 0)
+		return -1;
+
+	if (bpf_xdp_adjust_head(ctx, size) < 0)
+		return -1;
+
+	if (size > MAX_ADJST_OFFSET)
+		return -1;
+
+	if (hdr_len == 0 || hdr_len > MAX_ADJST_OFFSET)
+		return -1;
+
+	if (bpf_xdp_store_bytes(ctx, 0, tmp_buff, hdr_len) < 0)
+		return -1;
+
+	return 0;
+}
+
+static int xdp_adjst_head_grow_data(struct xdp_md *ctx, const __u32 hdr_len,
+			       const __u32 size)
+{
+	char tmp_buff[MAX_ADJST_OFFSET];
+	void *data, *data_end;
+	void *offset_ptr;
+	__s32 *val;
+	__u32 key;
+	__u8 tag;
+
+	if (hdr_len > MAX_ADJST_OFFSET || hdr_len <= 0)
+		return -1;
+
+	if (bpf_xdp_load_bytes(ctx, 0, tmp_buff, hdr_len) < 0)
+		return -1;
+
+	if (size > MAX_ADJST_OFFSET)
+		return -1;
+
+	if (bpf_xdp_adjust_head(ctx, 0 - size) < 0)
+		return -1;
+
+	if (bpf_xdp_store_bytes(ctx, 0, tmp_buff, hdr_len) < 0)
+		return -1;
+
+	data = (void *)(long)ctx->data;
+	data_end = (void *)(long)ctx->data_end;
+
+	offset_ptr = data + hdr_len;
+	if (offset_ptr > data_end)
+		return -1;
+
+	key = XDP_ADJST_TAG;
+	val = bpf_map_lookup_elem(&map_xdp_setup, &key);
+	if (!val)
+		return -1;
+
+	tag = (__u8)(*val);
+
+	for (int i = 0; i < min(MAX_ADJST_OFFSET, size); i++) {
+		if (offset_ptr + 1 > data_end)
+			return -1;
+
+		__builtin_memcpy(offset_ptr, &tag, 1);
+		offset_ptr++;
+	}
+
+	update_pkt(data, data_end, (__s16)(size));
+
+	return 0;
+
+}
+
+static int xdp_head_adjst(struct xdp_md *ctx, __u16 port)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	struct udphdr *udph_ptr = NULL;
+	__u32 key, size, hdr_len;
+	__s32 *val;
+	int res;
+
+	/* Filter packets based on UDP port */
+	udph_ptr = filter_udphdr(ctx, port);
+	if (!udph_ptr)
+		return XDP_PASS;
+
+	hdr_len = (void *)udph_ptr - data + sizeof(struct udphdr);
+
+	key = XDP_ADJST_OFFSET;
+	val = bpf_map_lookup_elem(&map_xdp_setup, &key);
+	if (!val)
+		return XDP_PASS;
+
+	switch (*val) {
+	case -16:
+	case 16:
+		size = 16;
+		break;
+	case -32:
+	case 32:
+		size = 32;
+		break;
+	case -64:
+	case 64:
+		size = 64;
+		break;
+	case -128:
+	case 128:
+		size = 128;
+		break;
+	case -256:
+	case 256:
+		size = 256;
+		break;
+	default:
+		bpf_printk("Invalid adjustment offset: %d\n", *val);
+		goto abort;
+	}
+
+	if (*val < 0)
+		res = xdp_adjst_head_grow_data(ctx, hdr_len, size);
+	else
+		res = xdp_adjst_head_shrnk_data(ctx, hdr_len, size);
+
+	if (res)
+		goto abort;
+
+	record_stats(ctx, STATS_PASS);
+	return XDP_PASS;
+
+abort:
+	record_stats(ctx, STATS_ABORT);
+	return XDP_ABORTED;
+}
+
 static int xdp_prog_common(struct xdp_md *ctx)
 {
 	__u32 key, *port;
@@ -352,6 +505,8 @@ static int xdp_prog_common(struct xdp_md *ctx)
 		return xdp_mode_tx_handler(ctx, (__u16)(*port));
 	case XDP_MODE_TAIL_ADJST:
 		return xdp_tail_ext(ctx, (__u16)(*port));
+	case XDP_MODE_HEAD_ADJST:
+		return xdp_head_adjst(ctx, (__u16)(*port));
 	}
 
 	/* Default action is to simple pass */
-- 
2.47.1


