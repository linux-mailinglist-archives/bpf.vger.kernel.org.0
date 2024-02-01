Return-Path: <bpf+bounces-20913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D59E1845069
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A31D1F26C1D
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD4A3C478;
	Thu,  1 Feb 2024 04:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GiU8jjJH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6B3B7AA
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 04:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762662; cv=none; b=WOB3PYeCb6btdjPh+lc+PfFOxdbJOU6y/mZWOr3Y9/VBWDP0w2kc0qW5L9PAmlLvonKvCH1qcsne49X1KITqS6Wf/lG6cgxR51NTmfKs2EfH7k9sTaF9f4E6YPRQdb8EexHGkNYEG1zf2foI6viuYgcWZC2n7RrgTvMt1BBpShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762662; c=relaxed/simple;
	bh=WkZl9wflj0IgbRjZ7W26kioFo25r8ZNCZasD5T/dzLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ywh8yVw0MDBKNs/vGNa84VNuTmNzG++/xCHSB+YbZNX4n3xXJCzNPl3dkm6gpOw0tes03Mxs1dJ0eTQV20jDi/ix+KVtbbzBC5tVOSl+9xuaYmHRPZFLKYTLF5acRM8+wLPdsBb5YUY0Y3qd37ught+Wickp4FwbAIrmzQO5wLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GiU8jjJH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a366ad7ad45so46087866b.3
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 20:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1706762659; x=1707367459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w56sn9yaoTSraWqKNmAk9szDYcrTuEVfLNDw17jbO/Y=;
        b=GiU8jjJHMnZNjOlMGG268OyEMWFa+FA6yyKb14eil7NbGIYbix/iGdRYizGa4HYOpe
         NLZUn0vKEUgPe0JEXULLDQl7FuQaSNUwuSt06tYcy6/FY/oay1RFWYs1RaDTA7CI+ya/
         jf+cblSGCjMfmL/dSD7ACQOzc8td+27l1TyUYj0ag7p3i77rO8VCyAe6K9szagZm8T6o
         v6PtjNgBwBQVRGf572Sp53UfWjokCuXyaSyrxZt6kf3k+i3pBulY8FXaXxEB6r5e4aQL
         r12iuvo9y/Jobq9NBaygdqaGfnn5Y0hGxhJfsE5/hpAM7DuwFEwVBoiZZiRKFxmhmuKk
         5F5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706762659; x=1707367459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w56sn9yaoTSraWqKNmAk9szDYcrTuEVfLNDw17jbO/Y=;
        b=IB8ZEqZgC7pw6Hbor2N1mZODwydY3/BqoIXSqwneC4UtkLgrN12Y8gI+x7Dcu4PZOt
         Q7Zd9adfjW1qZH0v0FuerkPAq3WcdUhT2ogtwlqhLdpSnWmwMMXgCwOxkPsFZiU6r4Pz
         MUYxph7eq1CvLXowBGLjsop9Ce8tJohOtoG+1j4mq7TrV9ccBglWDIW9W0GABT3/S6Sj
         bI/yIdH6B2+dinyfwJh9XHDFIp5DEnqOWiFo38yWOy+K+DDhPEnxPW6HluDmW2NaDE0B
         6W2U6juXB1Kd/mrS0xab+pbQHyqOlZG3aLmtgsZg2PxzAXICAIw4WIX2APMyMsT8kAt0
         e3XA==
X-Gm-Message-State: AOJu0YzT0Sag6ltgAmxXwYgzxHjmnlC5r9hliEVDSIAdM0XOEdm2IwAQ
	BFljCV8aLSfVRvMsVpmdbsFDjP486U8ZdNjGSWKWMHxXF1JTuVBJH2BGQUyJoZakLaXHozUGrdJ
	m9VdOwfdzQOQP3PUhVp/tH2F93ue3A6t2W+88WA==
X-Google-Smtp-Source: AGHT+IHz+OzRlUSIqoCqqjj9dpGnbpWdyOXHJ2Iitp0n04IQmLkouSia+JtNs4h45CT1UuEZD3CyE7t3Ivy9HDJPO+c=
X-Received: by 2002:a17:906:6d8:b0:a31:3dc5:6bda with SMTP id
 v24-20020a17090606d800b00a313dc56bdamr2616349ejb.64.1706762658744; Wed, 31
 Jan 2024 20:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131053212.2247527-1-chantr4@gmail.com>
In-Reply-To: <20240131053212.2247527-1-chantr4@gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 31 Jan 2024 22:44:07 -0600
Message-ID: <CAO3-PboMzPXAey7a1LQ1Gme_pgV4QMyFBx-y=R7PUQBPrGfRvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next ] selftests/bpf: disable IPv6 for lwt_redirect test
To: Manu Bretelle <chantr4@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	ast@kernel.org, martin.lau@linux.dev, song@kernel.org, eddyz87@gmail.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manu,

On Tue, Jan 30, 2024 at 11:32=E2=80=AFPM Manu Bretelle <chantr4@gmail.com> =
wrote:
>
> After a recent change in the vmtest runner, this test started failing
> sporadically.
>
> Investigation showed that this test was subject to race condition which
> got exacerbated after the vm runner change. The symptoms being that the
> logic that waited for an ICMPv4 packet is naive and will break if 5 or
> more non-ICMPv4 packets make it to tap0.
> When ICMPv6 is enabled, the kernel will generate traffic such as ICMPv6
> router solicitation...
> On a system with good performance, the expected ICMPv4 packet would very
> likely make it to the network interface promptly, but on a system with
> poor performance, those "guarantees" do not hold true anymore.
>
> Given that the test is IPv4 only, this change disable IPv6 in the test
> netns by setting `net.ipv6.conf.all.disable_ipv6` to 1.
> This essentially leaves "ping" as the sole generator of traffic in the
> network namespace.
> If this test was to be made IPv6 compatible, the logic in
> `wait_for_packet` would need to be modified.
>
> In more details...
>
> At a high level, the test does:
> - create a new namespace
> - in `setup_redirect_target` set up lo, tap0, and link_err interfaces as
>   well as add 2 routes that attaches ingress/egress sections of
>   `test_lwt_redirect.bpf.o` to the xmit path.
> - in `send_and_capture_test_packets` send an ICMP packet and read off
>   the tap interface (using `wait_for_packet`) to check that a ICMP packet
>   with the right size is read.
>
> `wait_for_packet` will try to read `max_retry` (5) times from the tap0
> fd looking for an ICMPv4 packet matching some criteria.
>
> The problem is that when we set up the `tap0` interface, because IPv6 is
> enabled by default, traffic such as Router solicitation is sent through
> tap0, as in:
>
>   # tcpdump -r /tmp/lwt_redirect.pc
>   reading from file /tmp/lwt_redirect.pcap, link-type EN10MB (Ethernet)
>   04:46:23.578352 IP6 :: > ff02::1:ffc0:4427: ICMP6, neighbor solicitatio=
n, who has fe80::fcba:dff:fec0:4427, length 32
>   04:46:23.659522 IP6 :: > ff02::16: HBH ICMP6, multicast listener report=
 v2, 1 group record(s), length 28
>   04:46:24.389169 IP 10.0.0.1 > 20.0.0.9: ICMP echo request, id 122, seq =
1, length 108
>   04:46:24.618599 IP6 fe80::fcba:dff:fec0:4427 > ff02::16: HBH ICMP6, mul=
ticast listener report v2, 1 group record(s), length 28
>   04:46:24.619985 IP6 fe80::fcba:dff:fec0:4427 > ff02::2: ICMP6, router s=
olicitation, length 16
>   04:46:24.767326 IP6 fe80::fcba:dff:fec0:4427 > ff02::16: HBH ICMP6, mul=
ticast listener report v2, 1 group record(s), length 28
>   04:46:28.936402 IP6 fe80::fcba:dff:fec0:4427 > ff02::2: ICMP6, router s=
olicitation, length 16
>
> If `wait_for_packet` sees 5 non-ICMPv4 packets, it will return 0, which i=
s what we see in:
>
>   2024-01-31T03:51:25.0336992Z test_lwt_redirect_run:PASS:netns_create 0 =
nsec
>   2024-01-31T03:51:25.0341309Z open_netns:PASS:malloc token 0 nsec
>   2024-01-31T03:51:25.0344844Z open_netns:PASS:open /proc/self/ns/net 0 n=
sec
>   2024-01-31T03:51:25.0350071Z open_netns:PASS:open netns fd 0 nsec
>   2024-01-31T03:51:25.0353516Z open_netns:PASS:setns 0 nsec
>   2024-01-31T03:51:25.0356560Z test_lwt_redirect_run:PASS:setns 0 nsec
>   2024-01-31T03:51:25.0360140Z open_tuntap:PASS:open(/dev/net/tun) 0 nsec
>   2024-01-31T03:51:25.0363822Z open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
>   2024-01-31T03:51:25.0367402Z open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
>   2024-01-31T03:51:25.0371167Z setup_redirect_target:PASS:open_tuntap 0 n=
sec
>   2024-01-31T03:51:25.0375180Z setup_redirect_target:PASS:if_nametoindex =
0 nsec
>   2024-01-31T03:51:25.0379929Z setup_redirect_target:PASS:ip link add lin=
k_err type dummy 0 nsec
>   2024-01-31T03:51:25.0384874Z setup_redirect_target:PASS:ip link set lo =
up 0 nsec
>   2024-01-31T03:51:25.0389678Z setup_redirect_target:PASS:ip addr add dev=
 lo 10.0.0.1/32 0 nsec
>   2024-01-31T03:51:25.0394814Z setup_redirect_target:PASS:ip link set lin=
k_err up 0 nsec
>   2024-01-31T03:51:25.0399874Z setup_redirect_target:PASS:ip link set tap=
0 up 0 nsec
>   2024-01-31T03:51:25.0407731Z setup_redirect_target:PASS:ip route add 10=
.0.0.0/24 dev link_err encap bpf xmit obj test_lwt_redirect.bpf.o sec redir=
_ingress 0 nsec
>   2024-01-31T03:51:25.0419105Z setup_redirect_target:PASS:ip route add 20=
.0.0.0/24 dev link_err encap bpf xmit obj test_lwt_redirect.bpf.o sec redir=
_egress 0 nsec
>   2024-01-31T03:51:25.0427209Z test_lwt_redirect_normal:PASS:setup_redire=
ct_target 0 nsec
>   2024-01-31T03:51:25.0431424Z ping_dev:PASS:if_nametoindex 0 nsec
>   2024-01-31T03:51:25.0437222Z send_and_capture_test_packets:FAIL:wait_fo=
r_epacket unexpected wait_for_epacket: actual 0 !=3D expected 1
>   2024-01-31T03:51:25.0448298Z (/tmp/work/bpf/bpf/tools/testing/selftests=
/bpf/prog_tests/lwt_redirect.c:175: errno: Success) test_lwt_redirect_norma=
l egress test fails
>   2024-01-31T03:51:25.0457124Z close_netns:PASS:setns 0 nsec
>
> When running in a VM which potential resource contrains, the odds that ca=
lling
> `ping` is not scheduled very soon after bringing `tap0` up increases,
> and with this the chances to get our ICMP packet pushed to position 6+
> in the network trace.
>
> To confirm this indeed solves the issue, I ran the test 100 times in a
> row with:
>
>   errors=3D0
>   successes=3D0
>   for i in `seq 1 100`
>   do
>     ./test_progs -t lwt_redirect/lwt_redirect_normal
>     if [ $? -eq 0 ]; then
>       successes=3D$((successes+1))
>     else
>       errors=3D$((errors+1))
>     fi
>   done
>   echo "successes: $successes/errors: $errors"
>
> While this test would at least fail a couple of time every 10 runs, here
> it ran 100 times with no error.
>
> Fixes: 43a7c3ef8a15 ("selftests/bpf: Add lwt_xmit tests for BPF_REDIRECT"=
)
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/lwt_redirect.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c b/tool=
s/testing/selftests/bpf/prog_tests/lwt_redirect.c
> index beeb3ac1c361..b5b9e74b1044 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
> +++ b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
> @@ -203,6 +203,7 @@ static int setup_redirect_target(const char *target_d=
ev, bool need_mac)
>         if (!ASSERT_GE(target_index, 0, "if_nametoindex"))
>                 goto fail;
>
> +       SYS(fail, "sysctl -w net.ipv6.conf.all.disable_ipv6=3D1");

Thanks for digging into this! I was totally unprepared for that many
router solicitations when I wrote the wait logic. For now disable v6
is totally good to unblock similar scenarios. But think it twice it is
probably still worthwhile to incorporate v6 later since lwt hooks mess
with both v4/v6 routing. So I'll try to fix up the wait logic later
this week. An exact packet filter is probably best suited to make
icmpv6/arp/nd happy.

best
Yan

>         SYS(fail, "ip link add link_err type dummy");
>         SYS(fail, "ip link set lo up");
>         SYS(fail, "ip addr add dev lo " LOCAL_SRC "/32");
> --
> 2.39.3
>

