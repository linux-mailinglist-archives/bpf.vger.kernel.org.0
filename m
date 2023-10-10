Return-Path: <bpf+bounces-11840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E477C4165
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 22:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84861C20F06
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 20:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA389315BB;
	Tue, 10 Oct 2023 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0K8nxEXl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C92225D0
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 20:40:19 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391DF8E
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 13:40:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a3e5f1742so2452384276.0
        for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696970416; x=1697575216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4NJX4yUcpMv7PnD6fbdI03ORGkY9y3mBYa/K/3+FNE=;
        b=0K8nxEXlrTg+00kJIR3xAvWp8673appyEx25Y3IPXUXvHsmlgqnW3oIa3fNBDaCuqf
         K7XEHPHtX6PSWM5e82fvghD6N3vHs2R7Vq9uN7flUBQ886WKWNDPQOLnJKIqZEE4e3fp
         gIYunWl6i8ZxeBH+azFYjeliNyrzh1kPc2C5FAjlcV+Y7aWJIA/MHvmwytjkb/V8doSH
         kP665JBbF6oHBKqtlIOD+ssN9RAm8hhoH8FsaiQjo914A2czIRIMs2K804j/IgVvM0Ju
         7J1CWDlKKrbjFieWSsWg7MmCwGcBdBDwtRkcm+gKs0YwDdeX1wJgELAAi0ZsLzK8ojWx
         U0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970416; x=1697575216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4NJX4yUcpMv7PnD6fbdI03ORGkY9y3mBYa/K/3+FNE=;
        b=s65MS/3bEFm1GEHqWqBwUoL2CyjQNxvuPSRBQI/yeIvP7MBikA4/QdsSawny9URbdy
         +eutwRR+vc6DGKPBQ7iSJ1Z8Zoziu9sUqdTdjo5D2Sn98/ta3TBxqD7sYR34s3cetnHU
         ofplVLn45RTINvyJCQ/+Yy/Dkb/nz3A6aV5uILRNsmZmHJUnPy38iJ0F5fE/SDs2lUbI
         /s+Z/BeLln2r+1m/B1XwHrd8qVn7RnmdYN0rolvJcu7Di26aXkoZaFiIuq1hcyYySAwr
         s6tnguqlO0vNiHQEUXIw4kNcqIIDipLzEvxNihdEWvHTdPnmk8Nw4P2lfWF82N6ONaQq
         v9hg==
X-Gm-Message-State: AOJu0YxM2pEb8fOjjyQ99AQa2Q+0PadW0wmEiaQPEzfwTsRY1sS1HH6H
	OaT/Hdvzl/l2/S/DklqysF80peo=
X-Google-Smtp-Source: AGHT+IF8ke5J3uI65hJJDJRuf2zIMfdTggW35jKasSXbEkU3FlAZX/U+dHSzVVi/Li23pgK5LkPXZ3M=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:990:b0:d89:4382:6d14 with SMTP id
 bv16-20020a056902099000b00d8943826d14mr325340ybb.6.1696970416340; Tue, 10 Oct
 2023 13:40:16 -0700 (PDT)
Date: Tue, 10 Oct 2023 13:40:14 -0700
In-Reply-To: <ZSQsQMLUIum1hmOI@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231003200522.1914523-1-sdf@google.com> <20231003200522.1914523-10-sdf@google.com>
 <532af030-f2a6-5569-549b-bbd012ad2640@kernel.org> <ZSQsQMLUIum1hmOI@google.com>
Message-ID: <ZSW2rn2zjJ0YfXXQ@google.com>
Subject: Re: [PATCH bpf-next v3 09/10] selftests/bpf: Add TX side to xdp_hw_metadata
From: Stanislav Fomichev <sdf@google.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, yoong.siang.song@intel.com, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/09, Stanislav Fomichev wrote:
> On 10/09, Jesper Dangaard Brouer wrote:
> > 
> > 
> > On 03/10/2023 22.05, Stanislav Fomichev wrote:
> > > When we get a packet on port 9091, we swap src/dst and send it out.
> > > At this point we also request the timestamp and checksum offloads.
> > > 
> > > Checksum offload is verified by looking at the tcpdump on the other side.
> > > The tool prints pseudo-header csum and the final one it expects.
> > > The final checksum actually matches the incoming packets checksum
> > > because we only flip the src/dst and don't change the payload.
> > > 
> > > Some other related changes:
> > > - switched to zerocopy mode by default; new flag can be used to force
> > >    old behavior
> > > - request fixed tx_metadata_len headroom
> > > - some other small fixes (umem size, fill idx+i, etc)
> > > 
> > > mvbz3:~# ./xdp_hw_metadata eth3
> > > ...
> > > 0x1062cb8: rx_desc[0]->addr=80100 addr=80100 comp_addr=80100
> > > rx_hash: 0x2E1B50B9 with RSS type:0x2A
> > > rx_timestamp:  1691436369532047139 (sec:1691436369.5320)
> > > XDP RX-time:   1691436369261756803 (sec:1691436369.2618) delta sec:-0.2703 (-270290.336 usec)
> > 
> > I guess system time isn't configured to be in sync with NIC HW time,
> > as delta is a negative offset.
> > 
> > > AF_XDP time:   1691436369261878839 (sec:1691436369.2619) delta sec:0.0001 (122.036 usec)
> > The AF_XDP time is also software system time and compared to XDP
> > RX-time, it shows a delta of 122 usec.  This number indicate to me that
> > the CPU is likely configured with power saving sleep states.
> 
> Yes, I don't do any synchronization and don't disable the sleep states.
> 
> > > 0x1062cb8: ping-pong with csum=3b8e (want de7e) csum_start=54 csum_offset=6
> > > 0x1062cb8: complete tx idx=0 addr=10
> > > 0x1062cb8: tx_timestamp:  1691436369598419505 (sec:1691436369.5984)
> > 
> > Could we add something that we can relate tx_timestamp to?
> > 
> > Like we do with the other delta calculations, as it helps us to
> > understand/validate if the number we get back is sane. Like negative
> > offset aboves tells us that system time sync isn't configured, and that
> > system have configures C-states.
> > 
> > I suggest delta comparing "tx_timestamp" to "rx_timestamp", as they are
> > the same clock domain.  It will tell us the total time spend from HW RX
> > to HW TX, counting all the time used by software "ping-pong".
> > 
> >  1691436369.5984-1691436369.5320 = 0.0664 sec = 66.4 ms
> > 
> > When implementing this, it could be (1) practical to store the
> > "rx_timestamp" in the metadata area of the completion packet, or (2)
> > should we have a mechanism for external storage that can be keyed on the
> > umem "addr"?
> 
> Sounds good. I can probably just store last rx_timestamp somewhere in the
> global var and do a delta on tx? Since the test is single threaded
> and sequential, not sure we need the mechanism to pass the tstamp around.
> LMK if you disagree and I'm missing something.

I ended up reshuffling current code a bit to basically use clock tai
as a reference for every line. Feels like its a bit simpler when
everything is referenced against the same clock?

For RX part, I rename existing XDP/AF_XDP to HW/SW and dump them both
relative to tai.

0x195d1f0: rx_desc[0]->addr=80100 addr=80100 comp_addr=80100
rx_hash: 0xEE2BBD59 with RSS type:0x2A
rx_timestamp:  1696969312125212179 (sec:1696969312.1252)
HW RX-time:   1696969312125212179 (sec:1696969312.1252) to CLOCK_TAI delta sec:-0.1339 (-133862.968 usec)
SW RX-time:   1696969311991283421 (sec:1696969311.9913) to CLOCK_TAI delta sec:0.0001 (65.790 usec)
0x195d1f0: ping-pong with csum=3b8e (want de5f) csum_start=54 csum_offset=6
0x195d1f0: complete tx idx=0 addr=8
tx_timestamp:  1696969312152959759 (sec:1696969312.1530)
SW RX-time:   1696969311991283421 (sec:1696969311.9913) to CLOCK_TAI delta sec:0.0101 (10139.862 usec)
HW RX-time:   1696969312125212179 (sec:1696969312.1252) to HW TX-complete-time delta sec:0.0277 (27747.580 usec)
HW TX-complete-time:   1696969312152959759 (sec:1696969312.1530) to CLOCK_TAI delta sec:-0.1515 (-151536.476 usec)

For TX part, I add a bunch of reference points:
1) SW RX-time (meta->xdp_timestamp) vs CLOCK_TAI (aka tai-at-complete-time)
2) HW RX-time (meta->rx_timestamp) vs HW TX-complete-time (new af_xdp timestamp)
3) HW TX-complete-time vs CLOCK_TAI

What do you think? See the patch below.

Note: all 3 of the above should, in theory, be more or less constant (with irq
moderation / etc disabled). But for me on mlx5 (2) they are not and looks
like hw rx timestamp jitters a quite a bit. I don't have a clue rigt
now on why, will try to take a separate look, but it's unrelated to the tx side.


diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index ab83d0ba6763..64a90d7479c1 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -57,6 +57,8 @@ const char *ifname;
 int ifindex;
 int rxq;
 bool skip_tx;
+__u64 last_hw_rx_timestamp;
+__u64 last_sw_rx_timestamp;
 
 void test__fail(void) { /* for network_helpers.c */ }
 
@@ -167,6 +169,16 @@ static __u64 gettime(clockid_t clock_id)
 	return (__u64) t.tv_sec * NANOSEC_PER_SEC + t.tv_nsec;
 }
 
+static void print_tstamp_delta(const char *name, const char *refname, __u64 tstamp, __u64 reference)
+{
+	__s64 delta = (__s64)reference - (__s64)tstamp;
+
+	printf("%s:   %llu (sec:%0.4f) to %s delta sec:%0.4f (%0.3f usec)\n",
+	       name, tstamp, (double)tstamp / NANOSEC_PER_SEC, refname,
+	       (double)delta / NANOSEC_PER_SEC,
+	       (double)delta / 1000);
+}
+
 static void verify_xdp_metadata(void *data, clockid_t clock_id)
 {
 	struct xdp_meta *meta;
@@ -182,22 +194,15 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
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
+
+		/* store received timestamps to calculate a delta at tx */
+		last_hw_rx_timestamp = meta->rx_timestamp;
+		last_sw_rx_timestamp = meta->xdp_timestamp;
 
+		print_tstamp_delta("HW RX-time", "CLOCK_TAI", meta->rx_timestamp, ref_tstamp);
+		print_tstamp_delta("SW RX-time", "CLOCK_TAI", meta->xdp_timestamp, ref_tstamp);
+	}
 }
 
 static void verify_skb_metadata(int fd)
@@ -245,7 +250,7 @@ static void verify_skb_metadata(int fd)
 	printf("skb hwtstamp is not found!\n");
 }
 
-static bool complete_tx(struct xsk *xsk)
+static bool complete_tx(struct xsk *xsk, clockid_t clock_id)
 {
 	struct xsk_tx_metadata *meta;
 	__u64 addr;
@@ -260,9 +265,17 @@ static bool complete_tx(struct xsk *xsk)
 	meta = data - sizeof(struct xsk_tx_metadata);
 
 	printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
-	printf("%p: tx_timestamp:  %llu (sec:%0.4f)\n", xsk,
-	       meta->completion.tx_timestamp,
+
+	printf("tx_timestamp:  %llu (sec:%0.4f)\n", meta->completion.tx_timestamp,
 	       (double)meta->completion.tx_timestamp / NANOSEC_PER_SEC);
+	if (meta->completion.tx_timestamp) {
+		__u64 ref_tstamp = gettime(clock_id);
+
+		print_tstamp_delta("HW TX-complete-time", "CLOCK_TAI", meta->completion.tx_timestamp, ref_tstamp);
+		print_tstamp_delta("SW RX-time", "CLOCK_TAI", last_sw_rx_timestamp, ref_tstamp);
+		print_tstamp_delta("HW RX-time", "HW TX-complete-time", last_hw_rx_timestamp, meta->completion.tx_timestamp);
+	}
+
 	xsk_ring_cons__release(&xsk->comp, 1);
 
 	return true;
@@ -276,7 +289,7 @@ static bool complete_tx(struct xsk *xsk)
 	} \
 } while (0)
 
-static void ping_pong(struct xsk *xsk, void *rx_packet)
+static void ping_pong(struct xsk *xsk, void *rx_packet, clockid_t clock_id)
 {
 	struct xsk_tx_metadata *meta;
 	struct ipv6hdr *ip6h = NULL;
@@ -418,14 +431,14 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
 
 			if (!skip_tx) {
 				/* mirror the packet back */
-				ping_pong(xsk, xsk_umem__get_data(xsk->umem_area, addr));
+				ping_pong(xsk, xsk_umem__get_data(xsk->umem_area, addr), clock_id);
 
 				ret = kick_tx(xsk);
 				if (ret)
 					printf("kick_tx ret=%d\n", ret);
 
 				for (int j = 0; j < 500; j++) {
-					if (complete_tx(xsk))
+					if (complete_tx(xsk, clock_id))
 						break;
 					usleep(10*1000);
 				}


> > > 0x1062cb8: complete rx idx=128 addr=80100
> > > 
> > > mvbz4:~# nc  -Nu -q1 ${MVBZ3_LINK_LOCAL_IP}%eth3 9091
> > > 
> > > mvbz4:~# tcpdump -vvx -i eth3 udp
> > > 	tcpdump: listening on eth3, link-type EN10MB (Ethernet), snapshot length 262144 bytes
> > > 12:26:09.301074 IP6 (flowlabel 0x35fa5, hlim 127, next-header UDP (17) payload length: 11) fe80::1270:fdff:fe48:1087.55807 > fe80::1270:fdff:fe48:1077.9091: [bad udp cksum 0x3b8e -> 0xde7e!] UDP, length 3
> > >          0x0000:  6003 5fa5 000b 117f fe80 0000 0000 0000
> > >          0x0010:  1270 fdff fe48 1087 fe80 0000 0000 0000
> > >          0x0020:  1270 fdff fe48 1077 d9ff 2383 000b 3b8e
> > >          0x0030:  7864 70
> > > 12:26:09.301976 IP6 (flowlabel 0x35fa5, hlim 127, next-header UDP (17) payload length: 11) fe80::1270:fdff:fe48:1077.9091 > fe80::1270:fdff:fe48:1087.55807: [udp sum ok] UDP, length 3
> > >          0x0000:  6003 5fa5 000b 117f fe80 0000 0000 0000
> > >          0x0010:  1270 fdff fe48 1077 fe80 0000 0000 0000
> > >          0x0020:  1270 fdff fe48 1087 2383 d9ff 000b de7e
> > >          0x0030:  7864 70
> > > 
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > >   tools/testing/selftests/bpf/xdp_hw_metadata.c | 202 +++++++++++++++++-
> > >   1 file changed, 192 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > > index 613321eb84c1..ab83d0ba6763 100644
> > > --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > > +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > > @@ -10,7 +10,9 @@
> > >    *   - rx_hash
> > >    *
> > >    * TX:
> > > - * - TBD
> > > + * - UDP 9091 packets trigger TX reply
> > > + * - TX HW timestamp is requested and reported back upon completion
> > > + * - TX checksum is requested
> > >    */
> > >   #include <test_progs.h>
> > > @@ -24,14 +26,17 @@
> > [...]
> > > @@ -51,22 +56,24 @@ struct xsk *rx_xsk;
> > [...]
> > > @@ -129,12 +136,22 @@ static void refill_rx(struct xsk *xsk, __u64 addr)
> > [...]
> > > @@ -228,6 +245,117 @@ static void verify_skb_metadata(int fd)
> > >   	printf("skb hwtstamp is not found!\n");
> > >   }
> > > +static bool complete_tx(struct xsk *xsk)
> > > +{
> > > +	struct xsk_tx_metadata *meta;
> > > +	__u64 addr;
> > > +	void *data;
> > > +	__u32 idx;
> > > +
> > > +	if (!xsk_ring_cons__peek(&xsk->comp, 1, &idx))
> > > +		return false;
> > > +
> > > +	addr = *xsk_ring_cons__comp_addr(&xsk->comp, idx);
> > > +	data = xsk_umem__get_data(xsk->umem_area, addr);
> > > +	meta = data - sizeof(struct xsk_tx_metadata);
> > > +
> > > +	printf("%p: complete tx idx=%u addr=%llx\n", xsk, idx, addr);
> > > +	printf("%p: tx_timestamp:  %llu (sec:%0.4f)\n", xsk,
> > > +	       meta->completion.tx_timestamp,
> > > +	       (double)meta->completion.tx_timestamp / NANOSEC_PER_SEC);
> > > +	xsk_ring_cons__release(&xsk->comp, 1);
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +#define swap(a, b, len) do { \
> > > +	for (int i = 0; i < len; i++) { \
> > > +		__u8 tmp = ((__u8 *)a)[i]; \
> > > +		((__u8 *)a)[i] = ((__u8 *)b)[i]; \
> > > +		((__u8 *)b)[i] = tmp; \
> > > +	} \
> > > +} while (0)
> > > +
> > > +static void ping_pong(struct xsk *xsk, void *rx_packet)
> > > +{
> > > +	struct xsk_tx_metadata *meta;
> > > +	struct ipv6hdr *ip6h = NULL;
> > > +	struct iphdr *iph = NULL;
> > > +	struct xdp_desc *tx_desc;
> > > +	struct udphdr *udph;
> > > +	struct ethhdr *eth;
> > > +	__sum16 want_csum;
> > > +	void *data;
> > > +	__u32 idx;
> > > +	int ret;
> > > +	int len;
> > > +
> > > +	ret = xsk_ring_prod__reserve(&xsk->tx, 1, &idx);
> > > +	if (ret != 1) {
> > > +		printf("%p: failed to reserve tx slot\n", xsk);
> > > +		return;
> > > +	}
> > > +
> > > +	tx_desc = xsk_ring_prod__tx_desc(&xsk->tx, idx);
> > > +	tx_desc->addr = idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE + sizeof(struct xsk_tx_metadata);
> > > +	data = xsk_umem__get_data(xsk->umem_area, tx_desc->addr);
> > > +
> > > +	meta = data - sizeof(struct xsk_tx_metadata);
> > > +	memset(meta, 0, sizeof(*meta));
> > > +	meta->flags = XDP_TX_METADATA_TIMESTAMP;
> > > +
> > > +	eth = rx_packet;
> > > +
> > > +	if (eth->h_proto == htons(ETH_P_IP)) {
> > > +		iph = (void *)(eth + 1);
> > > +		udph = (void *)(iph + 1);
> > > +	} else if (eth->h_proto == htons(ETH_P_IPV6)) {
> > > +		ip6h = (void *)(eth + 1);
> > > +		udph = (void *)(ip6h + 1);
> > > +	} else {
> > > +		printf("%p: failed to detect IP version for ping pong %04x\n", xsk, eth->h_proto);
> > > +		xsk_ring_prod__cancel(&xsk->tx, 1);
> > > +		return;
> > > +	}
> > > +
> > > +	len = ETH_HLEN;
> > > +	if (ip6h)
> > > +		len += sizeof(*ip6h) + ntohs(ip6h->payload_len);
> > > +	if (iph)
> > > +		len += ntohs(iph->tot_len);
> > > +
> > > +	swap(eth->h_dest, eth->h_source, ETH_ALEN);
> > > +	if (iph)
> > > +		swap(&iph->saddr, &iph->daddr, 4);
> > > +	else
> > > +		swap(&ip6h->saddr, &ip6h->daddr, 16);
> > > +	swap(&udph->source, &udph->dest, 2);
> > > +
> > > +	want_csum = udph->check;
> > > +	if (ip6h)
> > > +		udph->check = ~csum_ipv6_magic(&ip6h->saddr, &ip6h->daddr,
> > > +					       ntohs(udph->len), IPPROTO_UDP, 0);
> > > +	else
> > > +		udph->check = ~csum_tcpudp_magic(iph->saddr, iph->daddr,
> > > +						 ntohs(udph->len), IPPROTO_UDP, 0);
> > > +
> > > +	meta->flags |= XDP_TX_METADATA_CHECKSUM;
> > > +	if (iph)
> > > +		meta->csum_start = sizeof(*eth) + sizeof(*iph);
> > > +	else
> > > +		meta->csum_start = sizeof(*eth) + sizeof(*ip6h);
> > > +	meta->csum_offset = offsetof(struct udphdr, check);
> > > +
> > > +	printf("%p: ping-pong with csum=%04x (want %04x) csum_start=%d csum_offset=%d\n",
> > > +	       xsk, ntohs(udph->check), ntohs(want_csum), meta->csum_start, meta->csum_offset);
> > > +
> > > +	memcpy(data, rx_packet, len); /* don't share umem chunk for simplicity */
> > > +	tx_desc->options |= XDP_TX_METADATA;
> > > +	tx_desc->len = len;
> > > +
> > > +	xsk_ring_prod__submit(&xsk->tx, 1);
> > > +}
> > > +
> > >   static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t clock_id)
> > >   {
> > >   	const struct xdp_desc *rx_desc;
> > > @@ -250,6 +378,13 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
> > >   	while (true) {
> > >   		errno = 0;
> > > +
> > > +		for (i = 0; i < rxq; i++) {
> > > +			ret = kick_rx(&rx_xsk[i]);
> > > +			if (ret)
> > > +				printf("kick_rx ret=%d\n", ret);
> > > +		}
> > > +
> > >   		ret = poll(fds, rxq + 1, 1000);
> > >   		printf("poll: %d (%d) skip=%llu fail=%llu redir=%llu\n",
> > >   		       ret, errno, bpf_obj->bss->pkts_skip,
> > > @@ -280,6 +415,22 @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clockid_t
> > >   			       xsk, idx, rx_desc->addr, addr, comp_addr);
> > >   			verify_xdp_metadata(xsk_umem__get_data(xsk->umem_area, addr),
> > >   					    clock_id);
> > > +
> > > +			if (!skip_tx) {
> > > +				/* mirror the packet back */
> > > +				ping_pong(xsk, xsk_umem__get_data(xsk->umem_area, addr));
> > > +
> > > +				ret = kick_tx(xsk);
> > > +				if (ret)
> > > +					printf("kick_tx ret=%d\n", ret);
> > > +
> > > +				for (int j = 0; j < 500; j++) {
> > > +					if (complete_tx(xsk))
> > > +						break;
> > > +					usleep(10*1000);
> > 
> > I don't fully follow why we need this usleep here.
> 
> To avoid the busypoll here (since we don't care too much about perf in
> the test). But I agree, should be ok to drop, will do.

I take that back, I have to keep it. Otherwise I don't have a good
bound on when to stop/abort when waiting for completion. (and the
number of loops needs to go from 500 to unsure-how-many).

