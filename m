Return-Path: <bpf+bounces-12159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0757C8D4D
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 20:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63ED8282E5F
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 18:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49151210F2;
	Fri, 13 Oct 2023 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lyCidhIn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C23A1C29B
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 18:47:47 +0000 (UTC)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD6BBE
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 11:47:42 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-49d14708479so958240e0c.2
        for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 11:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697222862; x=1697827662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftsg76g5LwZSHqrAyd/aTdtx05+UWwF+dn1/RMzX5tc=;
        b=lyCidhInabFdKDRheGS5+7Mj66le+NfrCOt36n1DQFAslp4i/hmtdkMaWiZmH8jM7a
         fFRw13e64nFd0J10WE+sMsfNjkWnsgpdkJujZWqS9aUUhRX9wJozEORp9f1c9lIYl1oS
         T5/l0Gqm2gPDjrIuyizJFzAA0BE+40Kzc2Fo1PTMsGAss8kfKbpcGqpjtSzOWNL4aeUA
         3/50TG5WEJiZX5O0BYa9oR4sK2O3RrzflrQGYKcaTUp+E7bwYACMb9aWFo7P7HrCtE/y
         ojBE9jbAxGmsJNdI+mv2yVadMbDlXsbvXcVy9K7lDovCeBVv5bxbXPIFK1y8IEnoKRB0
         P7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697222862; x=1697827662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftsg76g5LwZSHqrAyd/aTdtx05+UWwF+dn1/RMzX5tc=;
        b=WRVOXXRqTKICUO2alMo9PAO7og6AdDblZ5E4KUHzcnvwyzlXpU7Dmjn3VDNka3+5OI
         uymZoR0UDXMUN7ydn52/dpjpxorR23nWcZulHhRmj2z0gBnuGqD8+aUH0Xvo0TxOKb9K
         oT996G81rn9GNmeL4eQRZDtNEh8zEJbNwRhZQhtKkOJUdtO+AjB2Xk0++cqOwk3AU4f+
         qU7nvBxHR6J3HSVlcecRG/uVptRlz4FeV2aitIAbXQqEcuHprrBJft/HxPIfu3ThgyZ7
         OmHxnFDqYIyqliy2lL3Yp/O8r2U1EoX2mMf1SrC5K6RgXULTohWK//1RB2DmRNNWCtlN
         qMpA==
X-Gm-Message-State: AOJu0YxLN7srUjv9DH7nF6uPbfNTdbPGUTkLSiUPEG+IfRj93E8Xzhte
	03P2nx5EY3EcUbEKgbVZlRqPYhR0kV8+NNva2/8VHJTFu6S8s7lsS8A=
X-Google-Smtp-Source: AGHT+IE6cxOfVDGl2AQXLDdxg54gYWb+Ml62FXL45yJwHWlPlNeshVBhhO+5oac7n9BjIL/nCp7QkJTbkc18bwhk94M=
X-Received: by 2002:a1f:5a06:0:b0:4a4:d34:421b with SMTP id
 o6-20020a1f5a06000000b004a40d34421bmr5469146vkb.7.1697222861735; Fri, 13 Oct
 2023 11:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003200522.1914523-1-sdf@google.com> <20231003200522.1914523-10-sdf@google.com>
 <532af030-f2a6-5569-549b-bbd012ad2640@kernel.org> <ZSQsQMLUIum1hmOI@google.com>
 <ZSW2rn2zjJ0YfXXQ@google.com> <PH0PR11MB58301E7F051FFB67E2C6B379D8D2A@PH0PR11MB5830.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB58301E7F051FFB67E2C6B379D8D2A@PH0PR11MB5830.namprd11.prod.outlook.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 13 Oct 2023 11:47:30 -0700
Message-ID: <CAKH8qBtackkX1vNGVUiNLpNHxDW41Ztn7qzA58Pt-bq7boJi4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 09/10] selftests/bpf: Add TX side to xdp_hw_metadata
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"kuba@kernel.org" <kuba@kernel.org>, "toke@kernel.org" <toke@kernel.org>, 
	"willemb@google.com" <willemb@google.com>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, "bjorn@kernel.org" <bjorn@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 6:14=E2=80=AFPM Song, Yoong Siang
<yoong.siang.song@intel.com> wrote:
>
> On Wednesday, October 11, 2023 4:40 AM, Stanislav Fomichev <sdf@google.co=
m> wrote:
> >On 10/09, Stanislav Fomichev wrote:
> >> On 10/09, Jesper Dangaard Brouer wrote:
> >> >
> >> >
> >> > On 03/10/2023 22.05, Stanislav Fomichev wrote:
> >> > > When we get a packet on port 9091, we swap src/dst and send it out=
.
> >> > > At this point we also request the timestamp and checksum offloads.
> >> > >
> >> > > Checksum offload is verified by looking at the tcpdump on the othe=
r side.
> >> > > The tool prints pseudo-header csum and the final one it expects.
> >> > > The final checksum actually matches the incoming packets checksum
> >> > > because we only flip the src/dst and don't change the payload.
> >> > >
> >> > > Some other related changes:
> >> > > - switched to zerocopy mode by default; new flag can be used to fo=
rce
> >> > >    old behavior
> >> > > - request fixed tx_metadata_len headroom
> >> > > - some other small fixes (umem size, fill idx+i, etc)
> >> > >
> >> > > mvbz3:~# ./xdp_hw_metadata eth3
> >> > > ...
> >> > > 0x1062cb8: rx_desc[0]->addr=3D80100 addr=3D80100 comp_addr=3D80100
> >> > > rx_hash: 0x2E1B50B9 with RSS type:0x2A
> >> > > rx_timestamp:  1691436369532047139 (sec:1691436369.5320)
> >> > > XDP RX-time:   1691436369261756803 (sec:1691436369.2618) delta sec=
:-
> >0.2703 (-270290.336 usec)
> >> >
> >> > I guess system time isn't configured to be in sync with NIC HW time,
> >> > as delta is a negative offset.
> >> >
> >> > > AF_XDP time:   1691436369261878839 (sec:1691436369.2619) delta
> >sec:0.0001 (122.036 usec)
> >> > The AF_XDP time is also software system time and compared to XDP
> >> > RX-time, it shows a delta of 122 usec.  This number indicate to me
> >> > that the CPU is likely configured with power saving sleep states.
> >>
> >> Yes, I don't do any synchronization and don't disable the sleep states=
.
> >>
> >> > > 0x1062cb8: ping-pong with csum=3D3b8e (want de7e) csum_start=3D54
> >> > > csum_offset=3D6
> >> > > 0x1062cb8: complete tx idx=3D0 addr=3D10
> >> > > 0x1062cb8: tx_timestamp:  1691436369598419505
> >> > > (sec:1691436369.5984)
> >> >
> >> > Could we add something that we can relate tx_timestamp to?
> >> >
> >> > Like we do with the other delta calculations, as it helps us to
> >> > understand/validate if the number we get back is sane. Like negative
> >> > offset aboves tells us that system time sync isn't configured, and
> >> > that system have configures C-states.
> >> >
> >> > I suggest delta comparing "tx_timestamp" to "rx_timestamp", as they
> >> > are the same clock domain.  It will tell us the total time spend
> >> > from HW RX to HW TX, counting all the time used by software "ping-po=
ng".
> >> >
> >> >  1691436369.5984-1691436369.5320 =3D 0.0664 sec =3D 66.4 ms
> >> >
> >> > When implementing this, it could be (1) practical to store the
> >> > "rx_timestamp" in the metadata area of the completion packet, or (2)
> >> > should we have a mechanism for external storage that can be keyed on
> >> > the umem "addr"?
> >>
> >> Sounds good. I can probably just store last rx_timestamp somewhere in
> >> the global var and do a delta on tx? Since the test is single threaded
> >> and sequential, not sure we need the mechanism to pass the tstamp arou=
nd.
> >> LMK if you disagree and I'm missing something.
> >
> >I ended up reshuffling current code a bit to basically use clock tai as =
a reference for
> >every line. Feels like its a bit simpler when everything is referenced a=
gainst the
> >same clock?
> >
> >For RX part, I rename existing XDP/AF_XDP to HW/SW and dump them both
> >relative to tai.
> >
> >0x195d1f0: rx_desc[0]->addr=3D80100 addr=3D80100 comp_addr=3D80100
> >rx_hash: 0xEE2BBD59 with RSS type:0x2A
> >rx_timestamp:  1696969312125212179 (sec:1696969312.1252)
> >HW RX-time:   1696969312125212179 (sec:1696969312.1252) to CLOCK_TAI del=
ta
> >sec:-0.1339 (-133862.968 usec)
> >SW RX-time:   1696969311991283421 (sec:1696969311.9913) to CLOCK_TAI del=
ta
> >sec:0.0001 (65.790 usec)
> >0x195d1f0: ping-pong with csum=3D3b8e (want de5f) csum_start=3D54 csum_o=
ffset=3D6
> >0x195d1f0: complete tx idx=3D0 addr=3D8
> >tx_timestamp:  1696969312152959759 (sec:1696969312.1530)
> >SW RX-time:   1696969311991283421 (sec:1696969311.9913) to CLOCK_TAI del=
ta
> >sec:0.0101 (10139.862 usec)
> >HW RX-time:   1696969312125212179 (sec:1696969312.1252) to HW TX-
> >complete-time delta sec:0.0277 (27747.580 usec)
> >HW TX-complete-time:   1696969312152959759 (sec:1696969312.1530) to
> >CLOCK_TAI delta sec:-0.1515 (-151536.476 usec)
> >
> >For TX part, I add a bunch of reference points:
> >1) SW RX-time (meta->xdp_timestamp) vs CLOCK_TAI (aka tai-at-complete-ti=
me)
> >2) HW RX-time (meta->rx_timestamp) vs HW TX-complete-time (new af_xdp
> >timestamp)
> >3) HW TX-complete-time vs CLOCK_TAI
> >
> >What do you think? See the patch below.
>
> Hi Stanislav,
>
> For me, the "CLOCK_TAI" in the printing is a bit confusing because
>  1. There are two value of tai which refer to different moment but having=
 the same name "CLOCK_TAI"
>  2. SW RX-time is also a clock tai.
>
> So,  I suggest to change the naming:
>  - HW RX-time: the moment NIC receive the packet (based on PHC)
>  - XDP RX-time: the moment bpf prog parse the packet (based on tai)
>  - SW RX-time: the moment user app receive the packet (based on tai)
>  - HW TX-complete-time: the moment NIC send out the packet (based on PHC)
>  - SW TX-complete-time:  the moment user app know the packet being send o=
ut (based on tai)

SG. Maybe also do s/SW/User/ ? To signify that it's a userspace-level
timestamps?

> Thanks & Regards
> Siang
>
> >
> >Note: all 3 of the above should, in theory, be more or less constant (wi=
th irq
> >moderation / etc disabled). But for me on mlx5 (2) they are not and look=
s like hw rx
> >timestamp jitters a quite a bit. I don't have a clue rigt now on why, wi=
ll try to take a
> >separate look, but it's unrelated to the tx side.
> >
> >
> >diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> >b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> >index ab83d0ba6763..64a90d7479c1 100644
> >--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> >+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> >@@ -57,6 +57,8 @@ const char *ifname;
> > int ifindex;
> > int rxq;
> > bool skip_tx;
> >+__u64 last_hw_rx_timestamp;
> >+__u64 last_sw_rx_timestamp;
> >
> > void test__fail(void) { /* for network_helpers.c */ }
> >
> >@@ -167,6 +169,16 @@ static __u64 gettime(clockid_t clock_id)
> >       return (__u64) t.tv_sec * NANOSEC_PER_SEC + t.tv_nsec;  }
> >
> >+static void print_tstamp_delta(const char *name, const char *refname,
> >+__u64 tstamp, __u64 reference) {
> >+      __s64 delta =3D (__s64)reference - (__s64)tstamp;
> >+
> >+      printf("%s:   %llu (sec:%0.4f) to %s delta sec:%0.4f (%0.3f usec)=
\n",
> >+             name, tstamp, (double)tstamp / NANOSEC_PER_SEC, refname,
> >+             (double)delta / NANOSEC_PER_SEC,
> >+             (double)delta / 1000);
> >+}
> >+
> > static void verify_xdp_metadata(void *data, clockid_t clock_id)  {
> >       struct xdp_meta *meta;
> >@@ -182,22 +194,15 @@ static void verify_xdp_metadata(void *data, clocki=
d_t
> >clock_id)
> >       printf("rx_timestamp:  %llu (sec:%0.4f)\n", meta->rx_timestamp,
> >              (double)meta->rx_timestamp / NANOSEC_PER_SEC);
> >       if (meta->rx_timestamp) {
> >-              __u64 usr_clock =3D gettime(clock_id);
> >-              __u64 xdp_clock =3D meta->xdp_timestamp;
> >-              __s64 delta_X =3D xdp_clock - meta->rx_timestamp;
> >-              __s64 delta_X2U =3D usr_clock - xdp_clock;
> >-
> >-              printf("XDP RX-time:   %llu (sec:%0.4f) delta sec:%0.4f (=
%0.3f
> >usec)\n",
> >-                     xdp_clock, (double)xdp_clock / NANOSEC_PER_SEC,
> >-                     (double)delta_X / NANOSEC_PER_SEC,
> >-                     (double)delta_X / 1000);
> >-
> >-              printf("AF_XDP time:   %llu (sec:%0.4f) delta sec:%0.4f (=
%0.3f
> >usec)\n",
> >-                     usr_clock, (double)usr_clock / NANOSEC_PER_SEC,
> >-                     (double)delta_X2U / NANOSEC_PER_SEC,
> >-                     (double)delta_X2U / 1000);
> >-      }
> >+              __u64 ref_tstamp =3D gettime(clock_id);
> >+
> >+              /* store received timestamps to calculate a delta at tx *=
/
> >+              last_hw_rx_timestamp =3D meta->rx_timestamp;
> >+              last_sw_rx_timestamp =3D meta->xdp_timestamp;
> >
> >+              print_tstamp_delta("HW RX-time", "CLOCK_TAI", meta-
> >>rx_timestamp, ref_tstamp);
> >+              print_tstamp_delta("SW RX-time", "CLOCK_TAI", meta-
> >>xdp_timestamp, ref_tstamp);
> >+      }
> > }
> >
> > static void verify_skb_metadata(int fd) @@ -245,7 +250,7 @@ static void
> >verify_skb_metadata(int fd)
> >       printf("skb hwtstamp is not found!\n");  }
> >
> >-static bool complete_tx(struct xsk *xsk)
> >+static bool complete_tx(struct xsk *xsk, clockid_t clock_id)
> > {
> >       struct xsk_tx_metadata *meta;
> >       __u64 addr;
> >@@ -260,9 +265,17 @@ static bool complete_tx(struct xsk *xsk)
> >       meta =3D data - sizeof(struct xsk_tx_metadata);
> >
> >       printf("%p: complete tx idx=3D%u addr=3D%llx\n", xsk, idx, addr);
> >-      printf("%p: tx_timestamp:  %llu (sec:%0.4f)\n", xsk,
> >-             meta->completion.tx_timestamp,
> >+
> >+      printf("tx_timestamp:  %llu (sec:%0.4f)\n",
> >+meta->completion.tx_timestamp,
> >              (double)meta->completion.tx_timestamp / NANOSEC_PER_SEC);
> >+      if (meta->completion.tx_timestamp) {
> >+              __u64 ref_tstamp =3D gettime(clock_id);
> >+
> >+              print_tstamp_delta("HW TX-complete-time", "CLOCK_TAI", me=
ta-
> >>completion.tx_timestamp, ref_tstamp);
> >+              print_tstamp_delta("SW RX-time", "CLOCK_TAI",
> >last_sw_rx_timestamp, ref_tstamp);
> >+              print_tstamp_delta("HW RX-time", "HW TX-complete-time",
> >last_hw_rx_timestamp, meta->completion.tx_timestamp);
> >+      }
> >+
> >       xsk_ring_cons__release(&xsk->comp, 1);
> >
> >       return true;
> >@@ -276,7 +289,7 @@ static bool complete_tx(struct xsk *xsk)
> >       } \
> > } while (0)
> >
> >-static void ping_pong(struct xsk *xsk, void *rx_packet)
> >+static void ping_pong(struct xsk *xsk, void *rx_packet, clockid_t
> >+clock_id)
> > {
> >       struct xsk_tx_metadata *meta;
> >       struct ipv6hdr *ip6h =3D NULL;
> >@@ -418,14 +431,14 @@ static int verify_metadata(struct xsk *rx_xsk, int=
 rxq, int
> >server_fd, clockid_t
> >
> >                       if (!skip_tx) {
> >                               /* mirror the packet back */
> >-                              ping_pong(xsk, xsk_umem__get_data(xsk-
> >>umem_area, addr));
> >+                              ping_pong(xsk, xsk_umem__get_data(xsk-
> >>umem_area, addr), clock_id);
> >
> >                               ret =3D kick_tx(xsk);
> >                               if (ret)
> >                                       printf("kick_tx ret=3D%d\n", ret)=
;
> >
> >                               for (int j =3D 0; j < 500; j++) {
> >-                                      if (complete_tx(xsk))
> >+                                      if (complete_tx(xsk, clock_id))
> >                                               break;
> >                                       usleep(10*1000);
> >                               }
> >
> >
> >> > > 0x1062cb8: complete rx idx=3D128 addr=3D80100
> >> > >
> >> > > mvbz4:~# nc  -Nu -q1 ${MVBZ3_LINK_LOCAL_IP}%eth3 9091
> >> > >
> >> > > mvbz4:~# tcpdump -vvx -i eth3 udp
> >> > >  tcpdump: listening on eth3, link-type EN10MB (Ethernet), snapshot
> >> > > length 262144 bytes
> >> > > 12:26:09.301074 IP6 (flowlabel 0x35fa5, hlim 127, next-header UDP =
(17)
> >payload length: 11) fe80::1270:fdff:fe48:1087.55807 >
> >fe80::1270:fdff:fe48:1077.9091: [bad udp cksum 0x3b8e -> 0xde7e!] UDP, l=
ength 3
> >> > >          0x0000:  6003 5fa5 000b 117f fe80 0000 0000 0000
> >> > >          0x0010:  1270 fdff fe48 1087 fe80 0000 0000 0000
> >> > >          0x0020:  1270 fdff fe48 1077 d9ff 2383 000b 3b8e
> >> > >          0x0030:  7864 70
> >> > > 12:26:09.301976 IP6 (flowlabel 0x35fa5, hlim 127, next-header UDP =
(17)
> >payload length: 11) fe80::1270:fdff:fe48:1077.9091 >
> >fe80::1270:fdff:fe48:1087.55807: [udp sum ok] UDP, length 3
> >> > >          0x0000:  6003 5fa5 000b 117f fe80 0000 0000 0000
> >> > >          0x0010:  1270 fdff fe48 1077 fe80 0000 0000 0000
> >> > >          0x0020:  1270 fdff fe48 1087 2383 d9ff 000b de7e
> >> > >          0x0030:  7864 70
> >> > >
> >> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >> > > ---
> >> > >   tools/testing/selftests/bpf/xdp_hw_metadata.c | 202
> >+++++++++++++++++-
> >> > >   1 file changed, 192 insertions(+), 10 deletions(-)
> >> > >
> >> > > diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> >> > > b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> >> > > index 613321eb84c1..ab83d0ba6763 100644
> >> > > --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> >> > > +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> >> > > @@ -10,7 +10,9 @@
> >> > >    *   - rx_hash
> >> > >    *
> >> > >    * TX:
> >> > > - * - TBD
> >> > > + * - UDP 9091 packets trigger TX reply
> >> > > + * - TX HW timestamp is requested and reported back upon
> >> > > + completion
> >> > > + * - TX checksum is requested
> >> > >    */
> >> > >   #include <test_progs.h>
> >> > > @@ -24,14 +26,17 @@
> >> > [...]
> >> > > @@ -51,22 +56,24 @@ struct xsk *rx_xsk;
> >> > [...]
> >> > > @@ -129,12 +136,22 @@ static void refill_rx(struct xsk *xsk, __u64
> >> > > addr)
> >> > [...]
> >> > > @@ -228,6 +245,117 @@ static void verify_skb_metadata(int fd)
> >> > >          printf("skb hwtstamp is not found!\n");
> >> > >   }
> >> > > +static bool complete_tx(struct xsk *xsk) {
> >> > > +        struct xsk_tx_metadata *meta;
> >> > > +        __u64 addr;
> >> > > +        void *data;
> >> > > +        __u32 idx;
> >> > > +
> >> > > +        if (!xsk_ring_cons__peek(&xsk->comp, 1, &idx))
> >> > > +                return false;
> >> > > +
> >> > > +        addr =3D *xsk_ring_cons__comp_addr(&xsk->comp, idx);
> >> > > +        data =3D xsk_umem__get_data(xsk->umem_area, addr);
> >> > > +        meta =3D data - sizeof(struct xsk_tx_metadata);
> >> > > +
> >> > > +        printf("%p: complete tx idx=3D%u addr=3D%llx\n", xsk, idx=
, addr);
> >> > > +        printf("%p: tx_timestamp:  %llu (sec:%0.4f)\n", xsk,
> >> > > +               meta->completion.tx_timestamp,
> >> > > +               (double)meta->completion.tx_timestamp / NANOSEC_PE=
R_SEC);
> >> > > +        xsk_ring_cons__release(&xsk->comp, 1);
> >> > > +
> >> > > +        return true;
> >> > > +}
> >> > > +
> >> > > +#define swap(a, b, len) do { \
> >> > > +        for (int i =3D 0; i < len; i++) { \
> >> > > +                __u8 tmp =3D ((__u8 *)a)[i]; \
> >> > > +                ((__u8 *)a)[i] =3D ((__u8 *)b)[i]; \
> >> > > +                ((__u8 *)b)[i] =3D tmp; \
> >> > > +        } \
> >> > > +} while (0)
> >> > > +
> >> > > +static void ping_pong(struct xsk *xsk, void *rx_packet) {
> >> > > +        struct xsk_tx_metadata *meta;
> >> > > +        struct ipv6hdr *ip6h =3D NULL;
> >> > > +        struct iphdr *iph =3D NULL;
> >> > > +        struct xdp_desc *tx_desc;
> >> > > +        struct udphdr *udph;
> >> > > +        struct ethhdr *eth;
> >> > > +        __sum16 want_csum;
> >> > > +        void *data;
> >> > > +        __u32 idx;
> >> > > +        int ret;
> >> > > +        int len;
> >> > > +
> >> > > +        ret =3D xsk_ring_prod__reserve(&xsk->tx, 1, &idx);
> >> > > +        if (ret !=3D 1) {
> >> > > +                printf("%p: failed to reserve tx slot\n", xsk);
> >> > > +                return;
> >> > > +        }
> >> > > +
> >> > > +        tx_desc =3D xsk_ring_prod__tx_desc(&xsk->tx, idx);
> >> > > +        tx_desc->addr =3D idx % (UMEM_NUM / 2) * UMEM_FRAME_SIZE =
+
> >sizeof(struct xsk_tx_metadata);
> >> > > +        data =3D xsk_umem__get_data(xsk->umem_area, tx_desc->addr=
);
> >> > > +
> >> > > +        meta =3D data - sizeof(struct xsk_tx_metadata);
> >> > > +        memset(meta, 0, sizeof(*meta));
> >> > > +        meta->flags =3D XDP_TX_METADATA_TIMESTAMP;
> >> > > +
> >> > > +        eth =3D rx_packet;
> >> > > +
> >> > > +        if (eth->h_proto =3D=3D htons(ETH_P_IP)) {
> >> > > +                iph =3D (void *)(eth + 1);
> >> > > +                udph =3D (void *)(iph + 1);
> >> > > +        } else if (eth->h_proto =3D=3D htons(ETH_P_IPV6)) {
> >> > > +                ip6h =3D (void *)(eth + 1);
> >> > > +                udph =3D (void *)(ip6h + 1);
> >> > > +        } else {
> >> > > +                printf("%p: failed to detect IP version for ping =
pong %04x\n", xsk,
> >eth->h_proto);
> >> > > +                xsk_ring_prod__cancel(&xsk->tx, 1);
> >> > > +                return;
> >> > > +        }
> >> > > +
> >> > > +        len =3D ETH_HLEN;
> >> > > +        if (ip6h)
> >> > > +                len +=3D sizeof(*ip6h) + ntohs(ip6h->payload_len)=
;
> >> > > +        if (iph)
> >> > > +                len +=3D ntohs(iph->tot_len);
> >> > > +
> >> > > +        swap(eth->h_dest, eth->h_source, ETH_ALEN);
> >> > > +        if (iph)
> >> > > +                swap(&iph->saddr, &iph->daddr, 4);
> >> > > +        else
> >> > > +                swap(&ip6h->saddr, &ip6h->daddr, 16);
> >> > > +        swap(&udph->source, &udph->dest, 2);
> >> > > +
> >> > > +        want_csum =3D udph->check;
> >> > > +        if (ip6h)
> >> > > +                udph->check =3D ~csum_ipv6_magic(&ip6h->saddr, &i=
p6h->daddr,
> >> > > +                                               ntohs(udph->len), =
IPPROTO_UDP, 0);
> >> > > +        else
> >> > > +                udph->check =3D ~csum_tcpudp_magic(iph->saddr, ip=
h->daddr,
> >> > > +                                                 ntohs(udph->len)=
,
> >IPPROTO_UDP, 0);
> >> > > +
> >> > > +        meta->flags |=3D XDP_TX_METADATA_CHECKSUM;
> >> > > +        if (iph)
> >> > > +                meta->csum_start =3D sizeof(*eth) + sizeof(*iph);
> >> > > +        else
> >> > > +                meta->csum_start =3D sizeof(*eth) + sizeof(*ip6h)=
;
> >> > > +        meta->csum_offset =3D offsetof(struct udphdr, check);
> >> > > +
> >> > > +        printf("%p: ping-pong with csum=3D%04x (want %04x) csum_s=
tart=3D%d
> >csum_offset=3D%d\n",
> >> > > +               xsk, ntohs(udph->check), ntohs(want_csum),
> >> > > +meta->csum_start, meta->csum_offset);
> >> > > +
> >> > > +        memcpy(data, rx_packet, len); /* don't share umem chunk f=
or simplicity
> >*/
> >> > > +        tx_desc->options |=3D XDP_TX_METADATA;
> >> > > +        tx_desc->len =3D len;
> >> > > +
> >> > > +        xsk_ring_prod__submit(&xsk->tx, 1); }
> >> > > +
> >> > >   static int verify_metadata(struct xsk *rx_xsk, int rxq, int serv=
er_fd, clockid_t
> >clock_id)
> >> > >   {
> >> > >          const struct xdp_desc *rx_desc; @@ -250,6 +378,13 @@ stat=
ic int
> >> > > verify_metadata(struct xsk *rx_xsk, int rxq, int server_fd, clocki=
d_t
> >> > >          while (true) {
> >> > >                  errno =3D 0;
> >> > > +
> >> > > +                for (i =3D 0; i < rxq; i++) {
> >> > > +                        ret =3D kick_rx(&rx_xsk[i]);
> >> > > +                        if (ret)
> >> > > +                                printf("kick_rx ret=3D%d\n", ret)=
;
> >> > > +                }
> >> > > +
> >> > >                  ret =3D poll(fds, rxq + 1, 1000);
> >> > >                  printf("poll: %d (%d) skip=3D%llu fail=3D%llu red=
ir=3D%llu\n",
> >> > >                         ret, errno, bpf_obj->bss->pkts_skip, @@ -2=
80,6 +415,22
> >> > > @@ static int verify_metadata(struct xsk *rx_xsk, int rxq, int ser=
ver_fd,
> >clockid_t
> >> > >                                 xsk, idx, rx_desc->addr, addr, com=
p_addr);
> >> > >                          verify_xdp_metadata(xsk_umem__get_data(xs=
k-
> >>umem_area, addr),
> >> > >                                              clock_id);
> >> > > +
> >> > > +                        if (!skip_tx) {
> >> > > +                                /* mirror the packet back */
> >> > > +                                ping_pong(xsk, xsk_umem__get_data=
(xsk-
> >>umem_area, addr));
> >> > > +
> >> > > +                                ret =3D kick_tx(xsk);
> >> > > +                                if (ret)
> >> > > +                                        printf("kick_tx ret=3D%d\=
n", ret);
> >> > > +
> >> > > +                                for (int j =3D 0; j < 500; j++) {
> >> > > +                                        if (complete_tx(xsk))
> >> > > +                                                break;
> >> > > +                                        usleep(10*1000);
> >> >
> >> > I don't fully follow why we need this usleep here.
> >>
> >> To avoid the busypoll here (since we don't care too much about perf in
> >> the test). But I agree, should be ok to drop, will do.
> >
> >I take that back, I have to keep it. Otherwise I don't have a good bound=
 on when to
> >stop/abort when waiting for completion. (and the number of loops needs t=
o go
> >from 500 to unsure-how-many).

