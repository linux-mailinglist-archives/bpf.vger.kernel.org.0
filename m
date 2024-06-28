Return-Path: <bpf+bounces-33375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBB491C767
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 22:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4E81F21033
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 20:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0198E79DC7;
	Fri, 28 Jun 2024 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JlqIbXpW"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10D78274;
	Fri, 28 Jun 2024 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719606938; cv=none; b=Xc7W/REw+8HAKM/cC79HZ2r2F9mznbaKlTezVlBFDL+LvZgBYr5+7JMoFFKrYlLcKgw05cYTdhLKS4qMgbYKPxGF3E3t72QgyY6ocWXn99KzViwyMsoG2I5u0DBxNOb3VObfx6jsOUktVraW4/ny6/2mXRAWvjR6GvEaWKoPzis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719606938; c=relaxed/simple;
	bh=Z+z8IqF9p2OuVi283o4CfF1bk3TE4Li6a22iqTpCbd8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QWYeh5xU5lnOP6q1AN4G+cOTBaIFqKeBMRoxPlwbz0MvlcUXeUjs824MukKjSBLJLA5aI5ykRrRoUP/2TBFDh1EgwsI10NK0Nsq3RvN5a1JWTmTiemkZ6Kkx8q1NBMD3bdBJa9KjEsRb+o0kRT2krmmeybkelmkeRIxGQVGlUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=JlqIbXpW; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=7+iquzvX4RJb1J5IQ5AgA+Y0XDzL+plsSrlY+5cXPF4=; b=JlqIbXpWswI/6kp6yHi0rZgeFd
	2NCBU0422V+udILjAsCPx/yehPOK+YW3pJWQ0FYOqXp+8YS16EgvQuXVey8k5RP4KwZAZj4pxIuxl
	3Sh/PS7a4qZdx0ChaXNsWFLYUKRfgccGLfPJzIrngSfp2FxzDv22rzSBiTNJUmEQTefsrSu/Vo3Sr
	+jKpyllzAIc15nJ6ywGMZ8H8DqudtsMO1nPw4zfb2krFvGPo1gSon49HvaSTToVrVW7u0f7aIO0xY
	KM56jMy50E6j/5uf/h6k4o2yIZ6NVCK595ssGKGrz4G08AZ5OdZVSgqSdPsx4GSmWIhy9GmBLsvYh
	RGWj3lXQ==;
Received: from 38.249.197.178.dynamic.cust.swisscom.net ([178.197.249.38] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sNIJd-000Ego-9n; Fri, 28 Jun 2024 22:35:29 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lex Siegel <usiegl00@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH net v3] net, sunrpc: Remap EPERM in case of connection failure in xs_tcp_setup_socket
Date: Fri, 28 Jun 2024 22:35:25 +0200
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
Cc: Neil Brown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>
Link: https://github.com/cilium/cilium/issues/33395
Link: https://lore.kernel.org/bpf/171374175513.12877.8993642908082014881@noble.neil.brown.name
---
 [ Fixes tags are set to the orig connect commit so that stable team
   can pick this up. ]

 v1 -> v2 -> v3:
   - Plain resend, adding correct sunrpc folks to Cc
     https://lore.kernel.org/bpf/Zn7wtStV+iafWRXj@tissot.1015granger.net/

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


