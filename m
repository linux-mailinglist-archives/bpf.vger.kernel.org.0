Return-Path: <bpf+bounces-72191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C0EC09A07
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 18:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E825C1A66735
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 16:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1137C3191C4;
	Sat, 25 Oct 2025 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/vGGDQi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8616D22A813;
	Sat, 25 Oct 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409597; cv=none; b=Iss7MjWse+sscg4tev6eGSuxDZ7sx7kAcA+D1eshTwicR5YikKGhy83DrjKqs+6JtpgZPxt3z70Ii4Kj2z/oOZf09z21jM7+NVtSuQTaUOKbScazbSfQs0FuF0JeHbtZBdjPWyTkbr5pPomsbNDARbLYxAeklSDEubq8E5wt37U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409597; c=relaxed/simple;
	bh=x/+AB9VcolXETwZPh43T7yT+yzubNlJGGjsrCP8l1uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6cyL6g0bAY/38gUBHziD2+7H95dlDJAnEUS03WGfrshdxxEe+CgPNWEV0tmZ4rrC4+akWtMvCwQQ1cAVAYAeK8Fz64J3DskNOc2cOvsv33PEIYBtPofokEY0W0GorQAWOt9epnskwpwD/CHPIYW2ZSBuFvnpGUlJvfNi832ZyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/vGGDQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED142C4CEF5;
	Sat, 25 Oct 2025 16:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409597;
	bh=x/+AB9VcolXETwZPh43T7yT+yzubNlJGGjsrCP8l1uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/vGGDQij3tS9gJUqdPkuQ2Yrnd6qQ35CV391OlF1pUqcvHGUgsff/CbqkWQJ0k4u
	 j4XYBRRBOYoOLuYPPMsPAdQIxYIOk19YStZdOry8Ur6DUtHgiNaSNA7IQZj2u+ioPn
	 eGq3UFqFaVlevRmf5KACszCcsF8iOE25kdOCJI3cYZkSj7OInbixOyL7RMWyszciJS
	 +zfwR55rZoVVM1yY+STrWFQ4UQcV1vlyFl/KU+x6THCOdkad6C4xAFO4dXXpn+HatW
	 LFcYoCnx1JtDjrPnFgKRgcgJs0+q8hOpC5uOhIxIFG9YYJ98KhgXcX3Whe7HvQmvd9
	 7rRLuLlDSn7Ng==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] selftests: drv-net: hds: restore hds settings
Date: Sat, 25 Oct 2025 12:00:14 -0400
Message-ID: <20251025160905.3857885-383-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit ee3ae27721fb994ac0b4705b5806ce68a5a74c73 ]

The test currently modifies the HDS settings and doesn't restore them.
This may cause subsequent tests to fail (or pass when they should not).
Add defer()ed reset handling.

Link: https://patch.msgid.link/20250825175939.2249165-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- Fixes a real bug in the selftest: The test was mutating device HDS
  settings and not restoring them, which can make subsequent tests fail
  or pass incorrectly. The commit adds a robust, deferred cleanup to
  restore both HDS mode and threshold to their original values, directly
  addressing the issue described in the commit message.

- Adds targeted, low-risk cleanup helpers:
  - Introduces `_hds_reset()` to restore original settings captured
    before modification. It first tries resetting `tcp-data-split` to
    `"unknown"` (auto) and, if that doesn’t match the prior value, falls
    back to the exact original value; it also restores `hds-thresh` if
    it changed. See `tools/testing/selftests/drivers/net/hds.py:63`–81.
  - Adds `_defer_reset_hds()` which captures the current ring settings
    (if supported) and schedules `_hds_reset()` using the existing
    deferred cleanup mechanism. See
    `tools/testing/selftests/drivers/net/hds.py:84`–90.
  - This follows existing patterns used elsewhere in the selftests
    (e.g., explicit defers in iou-zcrx), increasing consistency across
    tests (cf. `tools/testing/selftests/drivers/net/hw/iou-
    zcrx.py:50`–54, 81–85, 112–116).

- Ensures cleanup runs even on failures: The selftest framework flushes
  the global defer queue after each subtest, so scheduled resets will
  execute regardless of exceptions or skips. See
  `tools/testing/selftests/net/lib/py/ksft.py:271`.

- Minimal, contained changes: Only test code is touched (no kernel or
  driver changes). The changes are small and localized to
  `tools/testing/selftests/drivers/net/hds.py`.

- Defensive behavior and broad compatibility:
  - `_defer_reset_hds()` only schedules a reset if the device reports
    `hds-thresh` or `tcp-data-split` support and quietly ignores
    `NlError` exceptions (graceful on older kernels/drivers that don’t
    support these attributes), see
    `tools/testing/selftests/drivers/net/hds.py:84`–90.
  - Individual setters still check capabilities and skip when features
    aren’t supported (e.g., `get_hds`, `get_hds_thresh`), maintaining
    current skip behavior.

- Systematic application at mutation points: The new
  `_defer_reset_hds()` is invoked at the start of each function that
  modifies HDS-related state:
  - `set_hds_enable()` at
    `tools/testing/selftests/drivers/net/hds.py:93`–99.
  - `set_hds_disable()` at
    `tools/testing/selftests/drivers/net/hds.py:111`–119.
  - `set_hds_thresh_zero()` at
    `tools/testing/selftests/drivers/net/hds.py:129`–137.
  - `set_hds_thresh_random()` at
    `tools/testing/selftests/drivers/net/hds.py:147`–156`.
  - `set_hds_thresh_max()` at
    `tools/testing/selftests/drivers/net/hds.py:178`–186`.
  - `set_hds_thresh_gt()` at
    `tools/testing/selftests/drivers/net/hds.py:196`–205`.
  - `set_xdp()` when it changes `tcp-data-split` from `'enabled'` to
    `'unknown'` at
    `tools/testing/selftests/drivers/net/hds.py:217`–223`.
  - Existing explicit defer in `enabled_set_xdp()` remains (restores
    `'unknown'`), see
    `tools/testing/selftests/drivers/net/hds.py:235`–239.

- No architectural or behavioral risk to the kernel: The change affects
  only Python selftests, improving test isolation and reliability. It
  does not introduce new features or alter kernel behavior.

Given it is a clear test fix that prevents cross-test contamination, is
self-contained, low-risk, and improves the reliability of the selftest
suite, it meets stable backport criteria.

 tools/testing/selftests/drivers/net/hds.py | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
index 7c90a040ce45a..a2011474e6255 100755
--- a/tools/testing/selftests/drivers/net/hds.py
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -3,6 +3,7 @@
 
 import errno
 import os
+from typing import Union
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_raises, KsftSkipEx
 from lib.py import CmdExitFailure, EthtoolFamily, NlError
 from lib.py import NetDrvEnv
@@ -58,7 +59,39 @@ def get_hds_thresh(cfg, netnl) -> None:
     if 'hds-thresh' not in rings:
         raise KsftSkipEx('hds-thresh not supported by device')
 
+
+def _hds_reset(cfg, netnl, rings) -> None:
+    cur = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+
+    arg = {'header': {'dev-index': cfg.ifindex}}
+    if cur.get('tcp-data-split') != rings.get('tcp-data-split'):
+        # Try to reset to "unknown" first, we don't know if the setting
+        # was the default or user chose it. Default seems more likely.
+        arg['tcp-data-split'] = "unknown"
+        netnl.rings_set(arg)
+        cur = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+        if cur['tcp-data-split'] == rings['tcp-data-split']:
+            del arg['tcp-data-split']
+        else:
+            # Try the explicit setting
+            arg['tcp-data-split'] = rings['tcp-data-split']
+    if cur.get('hds-thresh') != rings.get('hds-thresh'):
+        arg['hds-thresh'] = rings['hds-thresh']
+    if len(arg) > 1:
+        netnl.rings_set(arg)
+
+
+def _defer_reset_hds(cfg, netnl) -> Union[dict, None]:
+    try:
+        rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+        if 'hds-thresh' in rings or 'tcp-data-split' in rings:
+            defer(_hds_reset, cfg, netnl, rings)
+    except NlError as e:
+        pass
+
+
 def set_hds_enable(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'tcp-data-split': 'enabled'})
     except NlError as e:
@@ -76,6 +109,7 @@ def set_hds_enable(cfg, netnl) -> None:
     ksft_eq('enabled', rings['tcp-data-split'])
 
 def set_hds_disable(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'tcp-data-split': 'disabled'})
     except NlError as e:
@@ -93,6 +127,7 @@ def set_hds_disable(cfg, netnl) -> None:
     ksft_eq('disabled', rings['tcp-data-split'])
 
 def set_hds_thresh_zero(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         netnl.rings_set({'header': {'dev-index': cfg.ifindex}, 'hds-thresh': 0})
     except NlError as e:
@@ -110,6 +145,7 @@ def set_hds_thresh_zero(cfg, netnl) -> None:
     ksft_eq(0, rings['hds-thresh'])
 
 def set_hds_thresh_random(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
     except NlError as e:
@@ -140,6 +176,7 @@ def set_hds_thresh_random(cfg, netnl) -> None:
     ksft_eq(hds_thresh, rings['hds-thresh'])
 
 def set_hds_thresh_max(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
     except NlError as e:
@@ -157,6 +194,7 @@ def set_hds_thresh_max(cfg, netnl) -> None:
     ksft_eq(rings['hds-thresh'], rings['hds-thresh-max'])
 
 def set_hds_thresh_gt(cfg, netnl) -> None:
+    _defer_reset_hds(cfg, netnl)
     try:
         rings = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
     except NlError as e:
@@ -178,6 +216,7 @@ def set_xdp(cfg, netnl) -> None:
     """
     mode = _get_hds_mode(cfg, netnl)
     if mode == 'enabled':
+        _defer_reset_hds(cfg, netnl)
         netnl.rings_set({'header': {'dev-index': cfg.ifindex},
                          'tcp-data-split': 'unknown'})
 
-- 
2.51.0


