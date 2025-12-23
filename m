Return-Path: <bpf+bounces-77349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9824CD857D
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 08:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DF16301A346
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 07:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC9230AD02;
	Tue, 23 Dec 2025 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y5d2ODmY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PAarSx9P"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF301A3160;
	Tue, 23 Dec 2025 07:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473460; cv=none; b=QeARj0z3lKGDGyOYm7LVNmuSMvoV3t0a1Fywz9kzKyAoDxy5KHpYApn9Qr1iu97Yvxi6PhMhibRHHVMRPR+3sTBihkFREwGPTt//pDQ2N52C5QPpbGk6HUaRiq8M00GWEvLxeQ+A6D7KzXTW0aR5e3MAwjgJQaZnShIVaasI0aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473460; c=relaxed/simple;
	bh=1+NW29yfruV/Ec4g2DSnXGrgqnqMbnt64fDn+nZOeTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e4i0OcUpbC/uajvcW1/8BBdDN+kGuPSMDKNjGuIK3Fv67TUDPekBOldSMvtKT9hGpzl5hpNmrVkuhDWtlL0yhGPYwDbJAYhmpaqKFpUo9Nb+mGm2JZbc+9mTJq4KA3aONNVrF6qK2To3clt2k2zrCWEnkLaXEaNJmArcTqOxgL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y5d2ODmY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PAarSx9P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2rffiepzzuxtGAonU0CVKOURwqZQ/L+i26P6vQ8Toys=;
	b=y5d2ODmYLOQSw74nGm0yKAjV1xDOKn97fKvqTRkg/fYZSqx+Pt7weBtox1kYHPHEZsF/wT
	dLlVvUkvAiOqXsr603FcbdR9c5yubPEV+mwefEKgFNkqTQJourWP3/A1pY6hUBdty/f45I
	jVOxxClYbYbb6v/a9AVc8mD3EyOp2nLP0GdoKXaFEXtg+Msjyb6m2wFpBY7jL8nFuOXkSu
	5DrMyQy7NnibVJWtnj5u1N9FIxXQXnFhoGeQps+yMAW6oGRIlfCMWffoWKwAh6/MruNIau
	6GHeEf74crsqQlS66WjyBSNuqlq1DHiyDS0mA5nCATOfE6IkVNYgpXM6AG77yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2rffiepzzuxtGAonU0CVKOURwqZQ/L+i26P6vQ8Toys=;
	b=PAarSx9PZOdqyna5ShRV7FKzAE0SaLEDoUVEeQHv363WfuG7K6IUVfROWhJxtbs84yanlR
	1DbUhe2svHkl1vCw==
Date: Tue, 23 Dec 2025 08:04:08 +0100
Subject: [PATCH 1/5] kbuild: uapi: validate that headers do not use libc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251223-uapi-nostdinc-v1-1-d91545d794f7@linutronix.de>
References: <20251223-uapi-nostdinc-v1-0-d91545d794f7@linutronix.de>
In-Reply-To: <20251223-uapi-nostdinc-v1-0-d91545d794f7@linutronix.de>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Brian Cain <bcain@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766473456; l=3680;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=1+NW29yfruV/Ec4g2DSnXGrgqnqMbnt64fDn+nZOeTk=;
 b=SrUNwBhWtiIv0gEhhP+5+eoJTtOhDvLyZ8G5AVzgl6JsNzzkLZioH+zGZyAQK4XOqnEL6YJmd
 nCp5aSokohdDqN/WP2bJ1e0JGlhAgg6z89Shv0r90afmkSBDMbA8xhI
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The UAPI headers should be self-contained. That means they should not
use other headers from libc. Currently this is not enforced and various
dependencies have crept in.

Add a check to make sure no new ones are added.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
This currently depends on a fix for linux/fcntl.h:
https://lore.kernel.org/lkml/20251203-uapi-fcntl-v1-1-490c67bf3425@linutronix.de/
---
 usr/include/Makefile | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/usr/include/Makefile b/usr/include/Makefile
index d8a508042fed..a9a861ec8702 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -68,12 +68,89 @@ endif
 # asm-generic/*.h is used by asm/*.h, and should not be included directly
 no-header-test += asm-generic/%
 
+# The following are using libc header and types.
+#
+# Do not add a new header to the list without legitimate reason.
+# Please consider to fix the header first.
+#
+# Sorted alphabetically.
+uses-libc += linux/a.out.h
+uses-libc += linux/atmbr2684.h
+uses-libc += linux/auto_dev-ioctl.h
+uses-libc += linux/auto_fs.h
+uses-libc += linux/auto_fs4.h
+uses-libc += linux/btrfs_tree.h
+uses-libc += linux/cec-funcs.h
+uses-libc += linux/cec.h
+uses-libc += linux/dvb/dmx.h
+uses-libc += linux/dvb/video.h
+uses-libc += linux/ethtool.h
+uses-libc += linux/ethtool_netlink.h
+uses-libc += linux/fuse.h
+uses-libc += linux/gsmmux.h
+uses-libc += linux/icmp.h
+uses-libc += linux/idxd.h
+uses-libc += linux/if.h
+uses-libc += linux/if_arp.h
+uses-libc += linux/if_bonding.h
+uses-libc += linux/if_pppox.h
+uses-libc += linux/if_tunnel.h
+uses-libc += linux/input.h
+uses-libc += linux/ip6_tunnel.h
+uses-libc += linux/joystick.h
+uses-libc += linux/llc.h
+uses-libc += linux/mctp.h
+uses-libc += linux/mdio.h
+uses-libc += linux/mii.h
+uses-libc += linux/mptcp.h
+uses-libc += linux/netdevice.h
+uses-libc += linux/netfilter/xt_RATEEST.h
+uses-libc += linux/netfilter/xt_hashlimit.h
+uses-libc += linux/netfilter/xt_physdev.h
+uses-libc += linux/netfilter/xt_rateest.h
+uses-libc += linux/netfilter_arp/arp_tables.h
+uses-libc += linux/netfilter_arp/arpt_mangle.h
+uses-libc += linux/netfilter_bridge.h
+uses-libc += linux/netfilter_bridge/ebtables.h
+uses-libc += linux/netfilter_ipv4.h
+uses-libc += linux/netfilter_ipv4/ip_tables.h
+uses-libc += linux/netfilter_ipv6.h
+uses-libc += linux/netfilter_ipv6/ip6_tables.h
+uses-libc += linux/route.h
+uses-libc += linux/shm.h
+uses-libc += linux/soundcard.h
+uses-libc += linux/string.h
+uses-libc += linux/tipc_config.h
+uses-libc += linux/uhid.h
+uses-libc += linux/uinput.h
+uses-libc += linux/vhost.h
+uses-libc += linux/vhost_types.h
+uses-libc += linux/virtio_ring.h
+uses-libc += linux/wireless.h
+uses-libc += regulator/regulator.h
+uses-libc += scsi/fc/fc_els.h
+
+ifeq ($(SRCARCH),hexagon)
+uses-libc += asm/sigcontext.h
+endif
+
+ifeq ($(SRCARCH),nios2)
+uses-libc += asm/ptrace.h
+uses-libc += linux/bpf_perf_event.h
+endif
+
+ifeq ($(SRCARCH),s390)
+uses-libc += asm/chpid.h
+uses-libc += asm/chsc.h
+endif
+
 always-y := $(patsubst $(obj)/%.h,%.hdrtest, $(shell find $(obj) -name '*.h' 2>/dev/null))
 
 # Include the header twice to detect missing include guard.
 quiet_cmd_hdrtest = HDRTEST $<
       cmd_hdrtest = \
 		$(CC) $(c_flags) -fsyntax-only -Werror -x c /dev/null \
+			$(if $(filter-out $(uses-libc), $*.h), -nostdinc) \
 			$(if $(filter-out $(no-header-test), $*.h), -include $< -include $<); \
 		$(PERL) $(src)/headers_check.pl $(obj) $<; \
 		touch $@

-- 
2.52.0


