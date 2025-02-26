Return-Path: <bpf+bounces-52669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5448A46794
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 18:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83881887A11
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77342236F0;
	Wed, 26 Feb 2025 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="ooKFCYjn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C819005F
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589584; cv=none; b=gJnGSVff/Iqe5MQoHrjQJa4bbCVHxallfl5zJk4LXagoEePSZvBh28Q08jLfsuO5XmLc9c4CF2bNdPDvOqoIBZHchoEntJhN5+dQYpRDqlSxP09EfQrholdpgB3A+n5GbjDvNkpUynTGBxVHxgGq6PoIjWnjIcE8Yi467lql+7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589584; c=relaxed/simple;
	bh=44NNnUD+hfGRR2F9rFgWYPI21r5uwakJT3FCaArWLuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3JgiqHnxmctq96bJ5fVqmk2TYFlJgNV5hNKmdd24w20YrQzPKcx9Y6Yeo7+sHxuIVooFzYGlkleqGCsmTJVD2tbK2JLUQ6NDyCEoGt/QNN+n0lMZe77zPhUj1uL+385kn/GAB1jp2E6tEqkC2uqraXeeXY8fArkHltH6ddKhw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=ooKFCYjn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220ea8ed64eso17691485ad.1
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 09:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1740589582; x=1741194382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge7xoU8UBAorBDaipzgy/G03+hB92T3wjFILg07gSac=;
        b=ooKFCYjnJdlCJEnI7C65Q8ecY+k/S2Y1HLfnEFimOP563JL3cFnuPU3makRMK6PpwA
         4DENhQSypLKautzEwFoESV2WAR3QIdQBG8jxh22Cze/9J0w3MtJF4bZkjhWkrW+ChzGF
         yLTiX3OQm24GwXU3lQKS+IFsMtE3IxV+/m3JcP+ikLy8CFlawbFwz5vT9T3oC5PAO3zL
         qE8x3OsUsKLMsf0bnT/U59wlWPMqvJdiwH6IqZsSUpKIm/0pIA82g5tUK6xNSxL24/QV
         TROnPde52So3UFBF/eMfLtHx6z9q2qTu6FgdNrViQaBrfiak6lZjEgpqBMrtv88gJZv3
         dMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740589582; x=1741194382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ge7xoU8UBAorBDaipzgy/G03+hB92T3wjFILg07gSac=;
        b=k0sxPrfoUviy1ZPaGpnf984i3LhPJVKw2SgANJCA3QKhDcfNSl0HQdYjZV/Z4HHITQ
         dDcHw3rA66lpspyCemkIokrucyZdhmBjoX0cITnCSBUl0de2y0nz1RyLlps5b5sFisgD
         XkguR70R2Qkc/QicNHCVYwbbnpPKZwWv3oAkDlDX6GXZOAyKvDt+CVploUN4FCXhauEn
         pAKLDfn66/SoHbTV2zgwK/q9hlKQlmw7+vuNVdSl+N6g/S2BJrWUn19e8fUKCbdJD/3l
         drUoSZQAr9a/a8t9Tbg6ycFwG6DoHrV4mD6pfJb5v8n3goBgOKkJVY9g8IpAelK0+3nB
         dbww==
X-Forwarded-Encrypted: i=1; AJvYcCVs02qRQRSyoY/yCLfrbNyzV1ubirF51t5yyySoXNHNqu3FL71Sc//lMa1C3Mw69ZIYz2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+M8wJBjG70zJ66LgipSK6mWW8IPku+BPzLnm9bb7wrfUdkqw
	JVWnGjbhFIRjiZaGlqSzsoWvZIyBbW77iZkivoQ2A0XdGSG+eiu5rSQ5HyQkgWk=
X-Gm-Gg: ASbGncv66PFyWSx7ogdHv00HolRXjtgAYMwW9jJR31AJ8kSe9RhjIIZfDDKeo2FXnR9
	xqVGzc/P01I/Ba6E6JPFHY3QRRQoRxZH7SqUg76EK0clJrk4jy+EuQlh/dSRsxLU6KruoyYO53+
	RPMgNzg8FpiyvDOvtAkTSqSjAfV3RHu3upEYAUMFBX7Tre3lVfDU26n5dP57jiAoqvSmsAd9I3f
	CVF2Blo0mqsLoXVzMKGawejhSi6ozF1NXyaxnn1MYy2nG3Zu4SjWlRWlOuTkLLtkDUZ60bY3l/5
	YxNv8eMI+afxTYA=
X-Google-Smtp-Source: AGHT+IFG6PPYtEosIJZGPzM849unBlSnZ7+rND8/XIdyITOovFgbB5eNE3jH+ynu/u20HtMC0RG5Ig==
X-Received: by 2002:a05:6a21:e8d:b0:1ee:cac0:1b49 with SMTP id adf61e73a8af0-1eef3cdc55amr14833326637.5.1740589582235;
        Wed, 26 Feb 2025 09:06:22 -0800 (PST)
Received: from t14.. ([2001:5a8:4528:b100:c968:54d4:e478:4e80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f8258sm3736863b3a.112.2025.02.26.09.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 09:06:21 -0800 (PST)
From: Jordan Rife <jordan@jrife.io>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jordan Rife <jordan@jrife.io>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	stephen@networkplumber.org,
	dsahern@kernel.org
Subject: [PATCH iproute2-next v3] ip: link: netkit: Support scrub options
Date: Wed, 26 Feb 2025 09:06:13 -0800
Message-ID: <20250226170615.2237516-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "scrub" option to configure IFLA_NETKIT_SCRUB and
IFLA_NETKIT_PEER_SCRUB when setting up a link. Add "scrub" and
"peer scrub" to device details as well when printing.

$ sudo ./ip/ip link add jordan type netkit scrub default peer scrub none
$ ./ip/ip -details link show jordan
43: jordan@nk0: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
    netkit mode l3 type primary policy forward peer policy forward scrub default peer scrub none numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 524280 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536

v2->v3: Updated man page.
v1->v2: Added some spaces around "scrub SCRUB" in the help message.

Link: https://lore.kernel.org/netdev/20241004101335.117711-1-daniel@iogearbox.net/

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 ip/iplink_netkit.c    | 46 ++++++++++++++++++++++++++++++++++++++++++-
 man/man8/ip-link.8.in | 15 ++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/ip/iplink_netkit.c b/ip/iplink_netkit.c
index 49550a2e..818da119 100644
--- a/ip/iplink_netkit.c
+++ b/ip/iplink_netkit.c
@@ -24,13 +24,19 @@ static const char * const netkit_policy_strings[] = {
 	[NETKIT_DROP]		= "blackhole",
 };
 
+static const char * const netkit_scrub_strings[] = {
+	[NETKIT_SCRUB_NONE]	= "none",
+	[NETKIT_SCRUB_DEFAULT]	= "default",
+};
+
 static void explain(struct link_util *lu, FILE *f)
 {
 	fprintf(f,
-		"Usage: ... %s [ mode MODE ] [ POLICY ] [ peer [ POLICY <options> ] ]\n"
+		"Usage: ... %s [ mode MODE ] [ POLICY ] [ scrub SCRUB ] [ peer [ POLICY <options> ] ]\n"
 		"\n"
 		"MODE: l3 | l2\n"
 		"POLICY: forward | blackhole\n"
+		"SCRUB: default | none\n"
 		"(first values are the defaults if nothing is specified)\n"
 		"\n"
 		"To get <options> type 'ip link add help'.\n",
@@ -91,6 +97,23 @@ static int netkit_parse_opt(struct link_util *lu, int argc, char **argv,
 			if (seen_peer)
 				duparg("peer", *(argv + 1));
 			seen_peer = true;
+		} else if (strcmp(*argv, "scrub") == 0) {
+			int attr_name = seen_peer ?
+					IFLA_NETKIT_PEER_SCRUB :
+					IFLA_NETKIT_SCRUB;
+			enum netkit_scrub scrub;
+
+			NEXT_ARG();
+
+			if (strcmp(*argv, "none") == 0) {
+				scrub = NETKIT_SCRUB_NONE;
+			} else if (strcmp(*argv, "default") == 0) {
+				scrub = NETKIT_SCRUB_DEFAULT;
+			} else {
+				fprintf(stderr, "Error: scrub must be either \"none\" or \"default\"\n");
+				return -1;
+			}
+			addattr32(n, 1024, attr_name, scrub);
 		} else {
 			char *type = NULL;
 
@@ -144,6 +167,15 @@ static const char *netkit_print_mode(__u32 mode)
 	return netkit_mode_strings[mode] ? : inv;
 }
 
+static const char *netkit_print_scrub(enum netkit_scrub scrub)
+{
+	const char *inv = "UNKNOWN";
+
+	if (scrub >= ARRAY_SIZE(netkit_scrub_strings))
+		return inv;
+	return netkit_scrub_strings[scrub] ? : inv;
+}
+
 static void netkit_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 {
 	if (!tb)
@@ -172,6 +204,18 @@ static void netkit_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		print_string(PRINT_ANY, "peer_policy", "peer policy %s ",
 			     netkit_print_policy(policy));
 	}
+	if (tb[IFLA_NETKIT_SCRUB]) {
+		enum netkit_scrub scrub = rta_getattr_u32(tb[IFLA_NETKIT_SCRUB]);
+
+		print_string(PRINT_ANY, "scrub", "scrub %s ",
+			     netkit_print_scrub(scrub));
+	}
+	if (tb[IFLA_NETKIT_PEER_SCRUB]) {
+		enum netkit_scrub scrub = rta_getattr_u32(tb[IFLA_NETKIT_PEER_SCRUB]);
+
+		print_string(PRINT_ANY, "peer_scrub", "peer scrub %s ",
+			     netkit_print_scrub(scrub));
+	}
 }
 
 static void netkit_print_help(struct link_util *lu,
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index efb62481..d6e05d94 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -882,10 +882,14 @@ the following additional arguments are supported:
 [
 .BI mode " MODE "
 ] [
+.BI scrub " SCRUB "
+] [
 .I "POLICY "
 ] [
 .BR peer
 [
+.BI scrub " SCRUB "
+] [
 .I "POLICY "
 ] [
 .I "NAME "
@@ -898,6 +902,17 @@ the following additional arguments are supported:
 - specifies the operation mode of the netkit device with "l3" and "l2"
 as possible values. Default option is "l3".
 
+.sp
+.BI scrub " SCRUB"
+- specifies the scrub behavior of the netkit device with "default" and
+"none" as possible values. With "default" the device zeroes the
+skb->{mark,priority} fields before invoking the attached BPF program
+when its peer device resides in a different network namespace. With
+"none" the device leaves clearing skb->{mark,priority} up to the BPF
+program. Default option is "default". Specifying scrub before the peer
+option refers to the primary device, after the peer option refers to
+the peer device.
+
 .sp
 .I "POLICY"
 - specifies the default device policy when no BPF programs are attached
-- 
2.43.0


