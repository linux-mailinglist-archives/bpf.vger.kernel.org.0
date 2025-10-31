Return-Path: <bpf+bounces-73128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FDFC23B92
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 09:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABE584F8041
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 08:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2568B33769A;
	Fri, 31 Oct 2025 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nVF12WGh"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556E335067;
	Fri, 31 Oct 2025 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897916; cv=none; b=PgRxOHpOo2dj+67Nkf0Psoa+f2h9fAebVdoN/yEouAaf3BprFBGmOueDGQhJKbLtqKqn7ftuuj0LLSpqhEUsWoSjb0ydPEEPTFHj4t1UGQUM6pE9/T4JtO4ko8tWLDba2v/CGNWRzXI6zcvZcSjGQ5bZd8GFk+m8UaG+a22GoWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897916; c=relaxed/simple;
	bh=EeQlUXkWQC37VA+bYsxzFWGd6/K4AxgcApQlX8DCaPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EbKoDTYQIkjmuxFCaXdvzCxHKpv+tbh3GGFX5zv28vxtin//qkhAwf/iFV9SlKVwDTnRtU5nqYITFR3pPWm8xyiIUR4NFhbFcwVO/UZ/7okqEp9CUExcfcNIVrqRgaQlL/yQeqDlBFLVyPVIMKsh7PRh0tB7nusYJnqEl/L6wi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nVF12WGh; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BC7B3C0E94D;
	Fri, 31 Oct 2025 08:04:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 439AF60704;
	Fri, 31 Oct 2025 08:05:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E118C1180FB59;
	Fri, 31 Oct 2025 09:05:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761897912; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CrbRVpU6RN8+Pg9aSpPk8JXyw67nrDa535KDMx8knCI=;
	b=nVF12WGh20nkxAMXKYFtfGMCVs868490kMPUSc4ZiBJeXzGcDY+yChlcB0OsDfEnzK8vu5
	jX+xvTqGg78xZ2jGuhGd/sP/qEAV+nchjR9rvyhN+UGKXml9/bE+DMiIk5lR0YtJtKwiSq
	ZQ81jQALTom8ox9JuHf1m9M3+cOZYIJMH2N4JJk9j+jV0yLuaLqrcNPgVpxvMGTU0p1i+4
	Rf6wFw9fp7iQxYVso4G2ArobzubtWWts9wLNXWctjDBXNuPrj26eZ61AjsmFHCSdWMCE4W
	grPOsGxeWeQJVeyQlmwGd04UVE2o1LkxwPBY/VRyTWJGiRPhRqdfkavJEHEfXA==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Fri, 31 Oct 2025 09:04:45 +0100
Subject: [PATCH bpf-next v7 09/15] selftests/bpf: test_xsk: Don't exit
 immediately when xsk_attach fails
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-xsk-v7-9-39fe486593a3@bootlin.com>
References: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
In-Reply-To: <20251031-xsk-v7-0-39fe486593a3@bootlin.com>
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

xsk_reattach_xdp calls exit_with_error() on failures. This exits the
program immediately. It prevents the following tests from being run and
isn't compliant with the CI.

Add a return value to the functions handling XDP attachments to handle
errors more smoothly.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 tools/testing/selftests/bpf/test_xsk.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_xsk.c b/tools/testing/selftests/bpf/test_xsk.c
index 7db1d974e31511e93b05bf70be991cee4cd444c6..0adb6c0b948f6216b24d0562bcda26097dbb9dbc 100644
--- a/tools/testing/selftests/bpf/test_xsk.c
+++ b/tools/testing/selftests/bpf/test_xsk.c
@@ -1643,7 +1643,7 @@ static bool xdp_prog_changed_tx(struct test_spec *test)
 	return ifobj->xdp_prog != test->xdp_prog_tx || ifobj->mode != test->mode;
 }
 
-static void xsk_reattach_xdp(struct ifobject *ifobj, struct bpf_program *xdp_prog,
+static int xsk_reattach_xdp(struct ifobject *ifobj, struct bpf_program *xdp_prog,
 			     struct bpf_map *xskmap, enum test_mode mode)
 {
 	int err;
@@ -1652,31 +1652,40 @@ static void xsk_reattach_xdp(struct ifobject *ifobj, struct bpf_program *xdp_pro
 	err = xsk_attach_xdp_program(xdp_prog, ifobj->ifindex, mode_to_xdp_flags(mode));
 	if (err) {
 		ksft_print_msg("Error attaching XDP program\n");
-		exit_with_error(-err);
+		return err;
 	}
 
 	if (ifobj->mode != mode && (mode == TEST_MODE_DRV || mode == TEST_MODE_ZC))
 		if (!xsk_is_in_mode(ifobj->ifindex, XDP_FLAGS_DRV_MODE)) {
 			ksft_print_msg("ERROR: XDP prog not in DRV mode\n");
-			exit_with_error(EINVAL);
+			return -EINVAL;
 		}
 
 	ifobj->xdp_prog = xdp_prog;
 	ifobj->xskmap = xskmap;
 	ifobj->mode = mode;
+
+	return 0;
 }
 
-static void xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_rx,
+static int xsk_attach_xdp_progs(struct test_spec *test, struct ifobject *ifobj_rx,
 				 struct ifobject *ifobj_tx)
 {
-	if (xdp_prog_changed_rx(test))
-		xsk_reattach_xdp(ifobj_rx, test->xdp_prog_rx, test->xskmap_rx, test->mode);
+	int err = 0;
+
+	if (xdp_prog_changed_rx(test)) {
+		err = xsk_reattach_xdp(ifobj_rx, test->xdp_prog_rx, test->xskmap_rx, test->mode);
+		if (err)
+			return err;
+	}
 
 	if (!ifobj_tx || ifobj_tx->shared_umem)
-		return;
+		return 0;
 
 	if (xdp_prog_changed_tx(test))
-		xsk_reattach_xdp(ifobj_tx, test->xdp_prog_tx, test->xskmap_tx, test->mode);
+		err = xsk_reattach_xdp(ifobj_tx, test->xdp_prog_tx, test->xskmap_tx, test->mode);
+
+	return err;
 }
 
 static void clean_sockets(struct test_spec *test, struct ifobject *ifobj)
@@ -1789,7 +1798,8 @@ static int testapp_validate_traffic(struct test_spec *test)
 		}
 	}
 
-	xsk_attach_xdp_progs(test, ifobj_rx, ifobj_tx);
+	if (xsk_attach_xdp_progs(test, ifobj_rx, ifobj_tx))
+		return TEST_FAILURE;
 	return __testapp_validate_traffic(test, ifobj_rx, ifobj_tx);
 }
 

-- 
2.51.0


