Return-Path: <bpf+bounces-33367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170C391C3C0
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 18:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 624BDB21743
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 16:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A71B1C9EA4;
	Fri, 28 Jun 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="KkM48zxl"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF71118029;
	Fri, 28 Jun 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592309; cv=none; b=fM7QEwn/i5HUp/pUfuBdgDG6KYd3LTcow7+BA2ZQx1f+DReyVmIZ4rbFKjWtpcVs+4Tutf+BX6VRyqbFm5XbttFKVzANfiN7JkWj0PT6w3LbxyXgTJAlyqaOtSZmKTRJ51LW12IdE15SVj+FQ5f/qpZS7dzwd3Bepd/QQZegctU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592309; c=relaxed/simple;
	bh=dvBezZHVkxpftGzlPHYzoueeEKTuBQsOKMWwkCmium8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fuGzPbfXFTDJVikemUAf+1d3AyuQ0uvlXzvM1B81K3Ls7pCXzuWa2Lk9HpmrSwJmq+fg9HNGJYwQPxu8/CTQhFjwChUYxDtYpGRTFPEAi2Gi4CKNZb6/hcZobVOweEKvHxlbHbEQdt4myNONiKbLEXSykEceoA/m/Xtnl6xNdvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=KkM48zxl; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=RzW7KTjfzTh4GwJ4a4+QOtrJU9NpZtGNhtK54OD4mCs=; b=KkM48zxlhWy1NGNkZR48/dVJt5
	al6NJaQWpBfGNMGc/mATqdr6q9lQbWUgzUT8UXItF9IMaqn+L2O3t9rxq/+/LWXiJ9d8hCJ7QolkD
	oX6UcoN9aTfr/tyTmDGshMY0qF+jY9UtkEHhTdMDTzWlPMY73GIRKnzF2lQGzecFrypbYIqcGk+25
	jOmD3/zFHM5NBKLnuRcRy0QffN9km6Mbg2vJXG/l71o1B5E0AF5y8ViQE7wgWvmLaliRU3Va9aRAP
	+WD5DASbsFxfiwaG6DjJkAM8ZbY6Ui6Fjo3Tgb70oLsjTS3vPRz3Tesrj6o4yr05HTwk70sYwU+vX
	rpkEu3rQ==;
Received: from 38.249.197.178.dynamic.cust.swisscom.net ([178.197.249.38] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sNEVj-000FXA-Ix; Fri, 28 Jun 2024 18:31:43 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: neilb@suse.de,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lex Siegel <usiegl00@gmail.com>
Subject: [PATCH net v2] net, sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket
Date: Fri, 28 Jun 2024 18:31:23 +0200
Message-Id: <2e62f0fc284b2f27156cd497fbb733b55a5ade43.1719592013.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27320/Fri Jun 28 10:37:18 2024)

When using a BPF program on kernel_connect(), the call can return -EPERM. This
causes xs_tcp_setup_socket() to loop forever, filling up the syslog and causing
the kernel to potentially freeze up.

Neil suggested:

  This will propagate -EPERM up into other layers which might not be ready
  to handle it. It might be safer to map EPERM to an error we would be more
  likely to expect from the network system - such as ECONNREFUSED or ENETDOWN.

ECONNREFUSED as error seems reasonable. For programs setting a different error
can be out of reach (see handling in 4fbac77d2d09) in particular on kernels
which do not have f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err
instead of allow boolean"), thus given that it is better to simply remap for
consistent behavior. UDP does handle EPERM in xs_udp_send_request().

Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
Co-developed-by: Lex Siegel <usiegl00@gmail.com>
Signed-off-by: Lex Siegel <usiegl00@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://github.com/cilium/cilium/issues/33395
Link: https://lore.kernel.org/bpf/171374175513.12877.8993642908082014881@noble.neil.brown.name
---
 [ Fixes tags are set to the orig connect commit so that stable team
   can pick this up. ]

 v1 -> v2:
   - Plain resend, adding more sunrpc folks to Cc

 net/sunrpc/xprtsock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index dfc353eea8ed..0e1691316f42 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2441,6 +2441,13 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 		transport->srcport = 0;
 		status = -EAGAIN;
 		break;
+	case -EPERM:
+		/* Happens, for instance, if a BPF program is preventing
+		 * the connect. Remap the error so upper layers can better
+		 * deal with it.
+		 */
+		status = -ECONNREFUSED;
+		fallthrough;
 	case -EINVAL:
 		/* Happens, for instance, if the user specified a link
 		 * local IPv6 address without a scope-id.
-- 
2.21.0


