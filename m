Return-Path: <bpf+bounces-15977-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D577FA99B
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 20:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF571C20CC4
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119A045977;
	Mon, 27 Nov 2023 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oEDmmPpJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EDED63
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:43 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5b7fb057153so5917926a12.1
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701111823; x=1701716623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mi8JIb1HDOpvCzNHvZfkM5tn49cG4glA3ceC2JikRio=;
        b=oEDmmPpJmbyhMR8AQJhlygNa+Lbsvmn6uX6PQxQcdI30N31yR9tp88oM8PdsSB/NcR
         jdhZcHCVTNn9S0ACPCL0avyLaF/nofXgA5YlZkdL/cHeieBImTQn5abBPt35QDtE85qy
         MzGvD75lZ72ypWZDqOZnNp4bLy3V4AUfmsu1oXghZDeUgObHKLj/jM+bagv6gCdusK1I
         Qi7HuUSPBnzFfeeA6Vs84ZUutW73Bq9ZkaJwgrIrqunGAvaIMJL56+ynUrKxTgU9sZus
         LtmTHfXcYYUzBglmj1U6xNulEM0YLxHwkvRFxn96TPs+TqcMEzMzPTeKfJJZ8VPLjyvN
         +KwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111823; x=1701716623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mi8JIb1HDOpvCzNHvZfkM5tn49cG4glA3ceC2JikRio=;
        b=Ent6fbqcg8zFqmjBcCdsmBv36GXDWxKiDWd+lEy8gaf2Wbycn5NY8JBDTfORi0e5/c
         D2nnTv0N0GiU6HEwX4m15ZG71/HhHD8xV7ohDdY2+Po38fOKhMwGlwwnigv5L3EFYzeu
         UT/UulffFuYjile1KQhTjgbO/px8s/QScNXhCgegWIbfMuYeRy+3TViDP6sBiRQF1VRF
         QSFgM+IZSwLH/BEZjDMUDGJTVWaSDYUIY6rTUq7arAUoYslTl4CHbSMm4E0qxBntfkk7
         r8EXfZG2dR3aKQ7yYNASNDiYwGNlOrlhPXYqQISvzYrhHUTRma95y0UtdUOptMuO0QTF
         nKKA==
X-Gm-Message-State: AOJu0Yyq4csvxtyPegQQwVyBaV+927muYxUFLHPHzLm+ZJIpob1YAAvq
	dvMpz3A6HUarQKQtR0W27i5qarWimdlHPc1A4lAvr5P+Ql/jN0CxX2wmeF8aHPeIupiR69SPJGd
	JAyW4c9v/xfrTAT1p9s1g2YKLKnO4eVv2gSGxokr/dmOvaxTVaQ==
X-Google-Smtp-Source: AGHT+IH1KUk+5+dQZAufzInV+dXbKA0Ma+WWsCT+tk3mIzZPJf/ZmIWseSSOzCnMVCpv3ENQ4+iIF68=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:481a:0:b0:585:6402:41e4 with SMTP id
 v26-20020a63481a000000b00585640241e4mr2013275pga.7.1701111823236; Mon, 27 Nov
 2023 11:03:43 -0800 (PST)
Date: Mon, 27 Nov 2023 11:03:18 -0800
In-Reply-To: <20231127190319.1190813-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127190319.1190813-1-sdf@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127190319.1190813-13-sdf@google.com>
Subject: [PATCH bpf-next v6 12/13] selftests/bpf: Convert xdp_hw_metadata to XDP_USE_NEED_WAKEUP
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

This is the recommended way to run AF_XDP, so let's use it in the test.

Also, some unrelated changes to now blow up the log too much:
- change default mode to zerocopy and add -c to use copy mode
- small fixes for the flags/sizes/prints
- add print_tstamp_delta to print timestamp + reference

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 73 +++++++++++++------
 1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index c3ba40d0b9de..4484b17c7a56 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -32,7 +32,7 @@
 
 #include "xdp_metadata.h"
 
-#define UMEM_NUM 16
+#define UMEM_NUM 256
 #define UMEM_FRAME_SIZE XSK_UMEM__DEFAULT_FRAME_SIZE
 #define UMEM_SIZE (UMEM_FRAME_SIZE * UMEM_NUM)
 #define XDP_FLAGS (XDP_FLAGS_DRV_MODE | XDP_FLAGS_REPLACE)
@@ -48,7 +48,7 @@ struct xsk {
 };
 
 struct xdp_hw_metadata *bpf_obj;
-__u16 bind_flags = XDP_COPY;
+__u16 bind_flags = XDP_USE_NEED_WAKEUP | XDP_ZEROCOPY;
 struct xsk *rx_xsk;
 const char *ifname;
 int ifindex;
@@ -68,7 +68,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
 		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
 		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
-		.flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG,
+		.flags = XSK_UMEM__DEFAULT_FLAGS,
 	};
 	__u32 idx;
 	u64 addr;
@@ -110,7 +110,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
 	for (i = 0; i < UMEM_NUM / 2; i++) {
 		addr = (UMEM_NUM / 2 + i) * UMEM_FRAME_SIZE;
 		printf("%p: rx_desc[%d] -> %lx\n", xsk, i, addr);
-		*xsk_ring_prod__fill_addr(&xsk->fill, i) = addr;
+		*xsk_ring_prod__fill_addr(&xsk->fill, idx + i) = addr;
 	}
 	xsk_ring_prod__submit(&xsk->fill, ret);
 
@@ -131,12 +131,22 @@ static void refill_rx(struct xsk *xsk, __u64 addr)
 	__u32 idx;
 
 	if (xsk_ring_prod__reserve(&xsk->fill, 1, &idx) == 1) {
-		printf("%p: complete idx=%u addr=%llx\n", xsk, idx, addr);
+		printf("%p: complete rx idx=%u addr=%llx\n", xsk, idx, addr);
 		*xsk_ring_prod__fill_addr(&xsk->fill, idx) = addr;
 		xsk_ring_prod__submit(&xsk->fill, 1);
 	}
 }
 
+static int kick_tx(struct xsk *xsk)
+{
+	return sendto(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, 0);
+}
+
+static int kick_rx(struct xsk *xsk)
+{
+	return recvfrom(xsk_socket__fd(xsk->socket), NULL, 0, MSG_DONTWAIT, NULL, NULL);
+}
+
 #define NANOSEC_PER_SEC 1000000000 /* 10^9 */
 static __u64 gettime(clockid_t clock_id)
 {
@@ -152,6 +162,17 @@ static __u64 gettime(clockid_t clock_id)
 	return (__u64) t.tv_sec * NANOSEC_PER_SEC + t.tv_nsec;
 }
 
+static void print_tstamp_delta(const char *name, const char *refname,
+			       __u64 tstamp, __u64 reference)
+{
+	__s64 delta = (__s64)reference - (__s64)tstamp;
+
+	printf("%s:   %llu (sec:%0.4f) delta to %s sec:%0.4f (%0.3f usec)\n",
+	       name, tstamp, (double)tstamp / NANOSEC_PER_SEC, refname,
+	       (double)delta / NANOSEC_PER_SEC,
+	       (double)delta / 1000);
+}
+
 static void verify_xdp_metadata(void *data, clockid_t clock_id)
 {
 	struct xdp_meta *meta;
@@ -167,22 +188,13 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
 	printf("rx_timestamp:  %llu (sec:%0.4f)\n", meta->rx_timestamp,
 	       (double)meta->rx_timestamp / NANOSEC_PER_SEC);
 	if (meta->rx_timestamp) {
-		__u64 usr_clock = gettime(clock_id);
-		__u64 xdp_clock = meta->xdp_timestamp;
-		__s64 delta_X = xdp_clock - meta->rx_timestamp;
-		__s64 delta_X2U = usr_clock - xdp_clock;
-
-		printf("XDP RX-time:   %llu (sec:%0.4f) delta sec:%0.4f (%0.3f usec)\n",
-		       xdp_clock, (double)xdp_clock / NANOSEC_PER_SEC,
-		       (double)delta_X / NANOSEC_PER_SEC,
-		       (double)delta_X / 1000);
-
-		printf("AF_XDP time:   %llu (sec:%0.4f) delta sec:%0.4f (%0.3f usec)\n",
-		       usr_clock, (double)usr_clock / NANOSEC_PER_SEC,
-		       (double)delta_X2U / NANOSEC_PER_SEC,
-		       (double)delta_X2U / 1000);
-	}
+		__u64 ref_tstamp = gettime(clock_id);
 
+		print_tstamp_delta("HW RX-time", "User RX-time",
+				   meta->rx_timestamp, ref_tstamp);
+		print_tstamp_delta("XDP RX-time", "User RX-time",
+				   meta->xdp_timestamp, ref_tstamp);
+	}
 }
 
 static void verify_skb_metadata(int fd)
@@ -252,6 +264,13 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 
 	while (true) {
 		errno = 0;
+
+		for (i = 0; i < rxq; i++) {
+			ret = kick_rx(&rx_xsk[i]);
+			if (ret)
+				printf("kick_rx ret=%d\n", ret);
+		}
+
 		ret = poll(fds, rxq + 1, 1000);
 		printf("poll: %d (%d) skip=%llu fail=%llu redir=%llu\n",
 		       ret, errno, bpf_obj->bss->pkts_skip,
@@ -420,8 +439,9 @@ static void print_usage(void)
 {
 	const char *usage =
 		"Usage: xdp_hw_metadata [OPTIONS] [IFNAME]\n"
-		"  -m    Enable multi-buffer XDP for larger MTU\n"
+		"  -c    Run in copy mode (zerocopy is default)\n"
 		"  -h    Display this help and exit\n\n"
+		"  -m    Enable multi-buffer XDP for larger MTU\n"
 		"Generate test packets on the other machine with:\n"
 		"  echo -n xdp | nc -u -q1 <dst_ip> 9091\n";
 
@@ -432,14 +452,19 @@ static void read_args(int argc, char *argv[])
 {
 	int opt;
 
-	while ((opt = getopt(argc, argv, "mh")) != -1) {
+	while ((opt = getopt(argc, argv, "chm")) != -1) {
 		switch (opt) {
-		case 'm':
-			bind_flags |= XDP_USE_SG;
+		case 'c':
+			bind_flags &= ~XDP_USE_NEED_WAKEUP;
+			bind_flags &= ~XDP_ZEROCOPY;
+			bind_flags |= XDP_COPY;
 			break;
 		case 'h':
 			print_usage();
 			exit(0);
+		case 'm':
+			bind_flags |= XDP_USE_SG;
+			break;
 		case '?':
 			if (isprint(optopt))
 				fprintf(stderr, "Unknown option: -%c\n", optopt);
-- 
2.43.0.rc1.413.gea7ed67945-goog


