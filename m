Return-Path: <bpf+bounces-31883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF3C9045E7
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 22:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1071F25515
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 20:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9A0154426;
	Tue, 11 Jun 2024 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7N0zMoB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB0A153569
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 20:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718138573; cv=none; b=KSwmAWxUmNKf5FYlGXVEZdgAFXSWLG/+I8roeZRYPwVlDmSeYWWRqL6Gw6YqzooMJCHLHZT/3u78xtzZuiwhxxC1V697SEjbigC5TIdKE2yOwdMT/7ksgZPFChvcgrFe/KHT25XoKi8h59UY6VgYfTlNOgJPcntsFcbuN3QR/O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718138573; c=relaxed/simple;
	bh=ZC3jwVHmyjA9T8vj/DUPMtjrMTI5ggbi5bhcu/zigYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V2twZdmFOiwejuaSrQe5WHYyMaVMIh8HRWJ/gsQ9hai1w9CPEJDEyvwTq/LOJgPALlkTFu9EUjKsja16fJL0kfBHSycD1tbhon9KnY3rXvkkALYDtRw2adaT/h01OiDXy7ZF1WTLBaeDWITbFOhEcJpSWMR7pZoCO0qz2F/SXa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j7N0zMoB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6cdc904ae4aso4811053a12.2
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718138571; x=1718743371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OqCPL9U8ZjSxymP893fgGbwmQErYRpVw5HY4fXwQBKg=;
        b=j7N0zMoBJ9xiONKiE66KlyNnK84la4enq2ZwAtbY4mmJOUGX1/2RN4cC0ctGln+hR8
         Ccs8IYwbs8vn8WHp3Gpbp2clrxL/q+rmQkjFRU5mb3drjNEb11WTVSSWb1kkR4ENRigu
         4jkQKTJSFhyYICpj/co72qntIVpazLSTVUAXB2p5Dxl+aJO0aGM7Y2E94vKTv2y1OSQg
         J6l8wIVv9nDVCAXrr0OYrbZgYaj4QGvFcgMwWzSdnyW3zJ0qHDe8GLE+pz6zgmJIUBq3
         7k75tRmOpEwYBD2pHxZMIZE9iewQRFZUHN269EHDnEaR3OwpiDIjvrVqnta/v78RPGSw
         BqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718138571; x=1718743371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqCPL9U8ZjSxymP893fgGbwmQErYRpVw5HY4fXwQBKg=;
        b=AJFoBZGihzhQ2tyyhhBuqCeTYogD7fFXZ5ys1O/YqiayYFg9MpaQ9s+3VZUgM8r1Cx
         pEELHKDSyHC0jjzdK9EbVzJsWZwElDhAEr+e9Lci/+yS0/Az0yo2nvUI+JSuHeR7eT42
         oVQ0+Y2CE6sebcqt35hPOIWyXChJkLdqzvIu4ncmAYTJ/yvYThKE2n+i5PJpj0ChDD0t
         XHc4wOSpX7+ztEv19yM7QFmIuPGT5/US5N6heSmW6VZs+h4JdH1SwC97JpJPCH+R91nu
         wllqqy3jDFG3+qwXImleZ9OehPut1d/3p6XGXYzzA7yNcjX6qrlMXx86XZHQlEjtoEsj
         Om9g==
X-Forwarded-Encrypted: i=1; AJvYcCXr6FHQ0M64qipMPJ8sSyUmIQQdMqps/JRv62YXVHBSOEgkVrp5RcCRv6NKpcO/jS56al8m92TBTy9yVHEZ4/aYXzkg
X-Gm-Message-State: AOJu0YxMY04gFtenTCg5HdSNRSsAUFR/0MCwoplh+4eKLKSmV6zb7aSj
	DHKXvWZD2LzWIor5ub8shsLhBCdjN52ll0dsy3/h/a1D5zTf+wjCim4YzE+pZnXoFTQWuasnjIf
	fbn5GuwYx6g==
X-Google-Smtp-Source: AGHT+IFDEfAtRtZOdGNFi1pbAoLZ5KhgCvdrpSZBikYHlmGgYYbmSU93y8fD3QKM92tfVo6BlDamZdgVW/DDfA==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:90a:db8f:b0:2c2:e420:f42f with SMTP
 id 98e67ed59e1d1-2c4a7606f5cmr89a91.1.1718138570783; Tue, 11 Jun 2024
 13:42:50 -0700 (PDT)
Date: Tue, 11 Jun 2024 20:42:45 +0000
In-Reply-To: <cover.1718138187.git.zhuyifei@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1718138187.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <a932c40e59f648d9d2771f9533cbc01cd4c0935c.1718138187.git.zhuyifei@google.com>
Subject: [RFC PATCH net-next 1/3] selftests/bpf: Move rxq_num helper from
 xdp_hw_metadata to network_helpers
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

This helper may be useful for other AF_XDP tests, such as xsk_hw.
Moving it out so we don't need to copy-paste that function.

I also changed the function from directly calling error(1, errno, ...)
to returning an error because I don't think it makes sense for a
library function to outright kill the process if the function fails.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 27 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  2 ++
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 27 ++-----------------
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 35250e6cde7f..4c3bef07df23 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -569,6 +569,33 @@ int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
 	return 0;
 }
 
+int rxq_num(const char *ifname)
+{
+	struct ethtool_channels ch = {
+		.cmd = ETHTOOL_GCHANNELS,
+	};
+	struct ifreq ifr = {
+		.ifr_data = (void *)&ch,
+	};
+	strncpy(ifr.ifr_name, ifname, IF_NAMESIZE - 1);
+	int fd, ret, err;
+
+	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return -errno;
+
+	ret = ioctl(fd, SIOCETHTOOL, &ifr);
+	if (ret < 0) {
+		err = errno;
+		close(fd);
+		return -err;
+	}
+
+	close(fd);
+
+	return ch.rx_count + ch.combined_count;
+}
+
 struct send_recv_arg {
 	int		fd;
 	uint32_t	bytes;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 883c7ea9d8d5..b09c3bbd5b62 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -72,6 +72,8 @@ int get_socket_local_port(int sock_fd);
 int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 
+int rxq_num(const char *ifname);
+
 struct nstoken;
 /**
  * open_netns() - Switch to specified network namespace by name.
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 6f9956eed797..f038a624fd1f 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -495,31 +495,6 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 	return 0;
 }
 
-static int rxq_num(const char *ifname)
-{
-	struct ethtool_channels ch = {
-		.cmd = ETHTOOL_GCHANNELS,
-	};
-
-	struct ifreq ifr = {
-		.ifr_data = (void *)&ch,
-	};
-	strncpy(ifr.ifr_name, ifname, IF_NAMESIZE - 1);
-	int fd, ret;
-
-	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
-	if (fd < 0)
-		error(1, errno, "socket");
-
-	ret = ioctl(fd, SIOCETHTOOL, &ifr);
-	if (ret < 0)
-		error(1, errno, "ioctl(SIOCETHTOOL)");
-
-	close(fd);
-
-	return ch.rx_count + ch.combined_count;
-}
-
 static void hwtstamp_ioctl(int op, const char *ifname, struct hwtstamp_config *cfg)
 {
 	struct ifreq ifr = {
@@ -668,6 +643,8 @@ int main(int argc, char *argv[])
 	read_args(argc, argv);
 
 	rxq = rxq_num(ifname);
+	if (rxq < 0)
+		error(1, -rxq, "rxq_num");
 
 	printf("rxq: %d\n", rxq);
 
-- 
2.45.2.505.gda0bf45e8d-goog


