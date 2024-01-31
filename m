Return-Path: <bpf+bounces-20862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9DF84477A
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 19:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11981C21F69
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C8A21353;
	Wed, 31 Jan 2024 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJKDwLaR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844F4CA7F
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727062; cv=none; b=CBsWxN0MokbwyLw2v0aT9/lUeer4jFrwVJwyu5MDGk7eI+O2KBcAjbu7rja8cB0/etMgmd8JJuY4yM1OZ8WJQNB6lQYxERWFybhTVpaXjkxvGCyMeYybyfk+MJjUai7dgZxGKSZEQ338wedj9OXQfR8jb4fIf+Z7YrpmfexaBaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727062; c=relaxed/simple;
	bh=DMGFP+7TIphOCRDymGMzkhxbzR2SJzm/3YbQJjbW8/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMEVWYKI07p2CNqP2gMVs5hPJpHwm5gFbITBywlX4T8FZQ+mnVHtDluD1rrFuLGxGqccQyxdQVXogMEas11XOKxdcxlQ6bklHF+yJBn60pg+j8YbkB0HiMZRttCT/9XoCyTJaovr94DpdzdoPHpqE+Ii1ZlcXShXjIQ78i84fmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJKDwLaR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d8ef977f1eso784355ad.0
        for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 10:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706727060; x=1707331860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qtxx0Uawz2bW+V4amMqRX8qn1W3yCT06gmrhA18p1GI=;
        b=mJKDwLaRcY5MqqNhwv9cM0BcYVfSk54zqLzQ6eCX1CPw+tBwiSVAUkuYDHeTl4AdW1
         whQrNbrG2rFPqlpMnebzfOQ9bl2/Ax9yD+u+dUT+3dV1T9nhAdHKGUzihj15m2PSLXH9
         DztzHPKmitgW6qgBZ3Nv7KQf+OWQbAATbi/7FDnoTxGJ074tGHqHRd2/9SrX/M+mO8Rj
         yVbRFq3t+AIRQQKHnsEoJQ6LFaqsldY4BvEE2HKTztprD+ZuNKGllJe3kKrHf3zIAylN
         WrRzbnophUsozdaXTNbkwUNFGMpCeOTBBq0lk6405nINAajLkfP3JCA6uu6+Nxk50anb
         7U+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706727060; x=1707331860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtxx0Uawz2bW+V4amMqRX8qn1W3yCT06gmrhA18p1GI=;
        b=JF+02J+gocv6qZSot0ds3D3OP8Sr6afqW8AhsrVKqKN7t1QQZchNY0yJWZO0UXXaCG
         9oKjhyFPQuJZcgeg63CY+m3r1052HlC555zH/klKb5WlPLh0f1nyq2TxsNq0AYlcUQn1
         lGCrgSMcGpy3BXY8yXlVKlxa300l9puu/Fv6w7cQgpZpx1nh5XCq8+r5oGplpaX08598
         tncp01UftP1HFLudGaEA0NOwYXwBeAx6Eq2DK5g6RqewgGUzvXAMiHyYiF6MxUPgFt9X
         nvVEspB5szlkam764qIhmGc7xdj8W2b3os+ImDLkvLr9/3GqMoMuIJqTxTtTxy4jUK/3
         DwJw==
X-Gm-Message-State: AOJu0YwL8RhVBB0IwZvTMyr5WnrlBJfQ2DsGPlC4pUubswFAZDuSjk37
	lcAYlC7SWNqLqH29fFroqqxuChgGyGGSnQg+QrTtOP2jGprcJlwW
X-Google-Smtp-Source: AGHT+IHc6kFaeh+SDB20xdnqqdOgvuha42ZIm0cVGVQJjycHOvJIQf/FzPfIlsOMukZ7EhbR/2rfBQ==
X-Received: by 2002:a05:6a21:32a5:b0:19c:9f4e:b122 with SMTP id yt37-20020a056a2132a500b0019c9f4eb122mr2873762pzb.20.1706727059623;
        Wed, 31 Jan 2024 10:50:59 -0800 (PST)
Received: from surya ([70.134.61.176])
        by smtp.gmail.com with ESMTPSA id m2-20020a62f202000000b006ddc7de91e9sm10165479pfh.197.2024.01.31.10.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 10:50:59 -0800 (PST)
Date: Wed, 31 Jan 2024 10:50:35 -0800
From: Manu Bretelle <chantr4@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
	eddyz87@gmail.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	yan@cloudflare.com
Subject: Re: [PATCH bpf-next ] selftests/bpf: disable IPv6 for lwt_redirect
 test
Message-ID: <ZbqWexAs4BR+S4oM@surya>
References: <20240131053212.2247527-1-chantr4@gmail.com>
 <6cd44959-b51e-4f79-9d30-c9026f084ae7@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cd44959-b51e-4f79-9d30-c9026f084ae7@oracle.com>

On Wed, Jan 31, 2024 at 05:49:42PM +0000, Alan Maguire wrote:
> On 31/01/2024 05:32, Manu Bretelle wrote:
> > After a recent change in the vmtest runner, this test started failing
> > sporadically.
> > 
> > Investigation showed that this test was subject to race condition which
> > got exacerbated after the vm runner change. The symptoms being that the
> > logic that waited for an ICMPv4 packet is naive and will break if 5 or
> > more non-ICMPv4 packets make it to tap0.
> > When ICMPv6 is enabled, the kernel will generate traffic such as ICMPv6
> > router solicitation...
> > On a system with good performance, the expected ICMPv4 packet would very
> > likely make it to the network interface promptly, but on a system with
> > poor performance, those "guarantees" do not hold true anymore.
> > 
> > Given that the test is IPv4 only, this change disable IPv6 in the test
> > netns by setting `net.ipv6.conf.all.disable_ipv6` to 1.
> > This essentially leaves "ping" as the sole generator of traffic in the
> > network namespace.
> > If this test was to be made IPv6 compatible, the logic in
> > `wait_for_packet` would need to be modified.
> > 
> 
> Great to fix test flakiness like this; I was curious if you tried
> modifying things from the bpf side; would something like this in
> progs/test_lwt_redirect.c help?
> (haven't been able to test because I can't reproduce the failure):
> 
> static int get_redirect_target(struct __sk_buff *skb)
> {
>         struct iphdr *iph = NULL;
>         void *start = (void *)(long)skb->data;
>         void *end = (void *)(long)skb->data_end;
> 
> +	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
> +		return -1;
> 
> I _think_ that would skip redirection and might solve the problem
> from the bpf side. Might be worth testing, but not a big deal..
> 

No, I did not try this, and it should indeed work.

The repro env is quite a heavy lift and I do not have easy access to access to 
a full toolchain to recompile programs and test this cross-platform within it.

sysctl call was a straightforward code change with high chance of result and
minimal back and forth with BPF CI to get s390x artifacts (which is where the
flakiness manifested), and given that the test runs within its own ephemeral
network namespace, I felt no guilt in using that sledgehammer :)

> > In more details...
> > 
> > At a high level, the test does:
> > - create a new namespace
> > - in `setup_redirect_target` set up lo, tap0, and link_err interfaces as
> >   well as add 2 routes that attaches ingress/egress sections of
> >   `test_lwt_redirect.bpf.o` to the xmit path.
> > - in `send_and_capture_test_packets` send an ICMP packet and read off
> >   the tap interface (using `wait_for_packet`) to check that a ICMP packet
> >   with the right size is read.
> > 
> > `wait_for_packet` will try to read `max_retry` (5) times from the tap0
> > fd looking for an ICMPv4 packet matching some criteria.
> > 
> > The problem is that when we set up the `tap0` interface, because IPv6 is
> > enabled by default, traffic such as Router solicitation is sent through
> > tap0, as in:
> > 
> >   # tcpdump -r /tmp/lwt_redirect.pc
> >   reading from file /tmp/lwt_redirect.pcap, link-type EN10MB (Ethernet)
> >   04:46:23.578352 IP6 :: > ff02::1:ffc0:4427: ICMP6, neighbor solicitation, who has fe80::fcba:dff:fec0:4427, length 32
> >   04:46:23.659522 IP6 :: > ff02::16: HBH ICMP6, multicast listener report v2, 1 group record(s), length 28
> >   04:46:24.389169 IP 10.0.0.1 > 20.0.0.9: ICMP echo request, id 122, seq 1, length 108
> >   04:46:24.618599 IP6 fe80::fcba:dff:fec0:4427 > ff02::16: HBH ICMP6, multicast listener report v2, 1 group record(s), length 28
> >   04:46:24.619985 IP6 fe80::fcba:dff:fec0:4427 > ff02::2: ICMP6, router solicitation, length 16
> >   04:46:24.767326 IP6 fe80::fcba:dff:fec0:4427 > ff02::16: HBH ICMP6, multicast listener report v2, 1 group record(s), length 28
> >   04:46:28.936402 IP6 fe80::fcba:dff:fec0:4427 > ff02::2: ICMP6, router solicitation, length 16
> > 
> > If `wait_for_packet` sees 5 non-ICMPv4 packets, it will return 0, which is what we see in:
> > 
> >   2024-01-31T03:51:25.0336992Z test_lwt_redirect_run:PASS:netns_create 0 nsec
> >   2024-01-31T03:51:25.0341309Z open_netns:PASS:malloc token 0 nsec
> >   2024-01-31T03:51:25.0344844Z open_netns:PASS:open /proc/self/ns/net 0 nsec
> >   2024-01-31T03:51:25.0350071Z open_netns:PASS:open netns fd 0 nsec
> >   2024-01-31T03:51:25.0353516Z open_netns:PASS:setns 0 nsec
> >   2024-01-31T03:51:25.0356560Z test_lwt_redirect_run:PASS:setns 0 nsec
> >   2024-01-31T03:51:25.0360140Z open_tuntap:PASS:open(/dev/net/tun) 0 nsec
> >   2024-01-31T03:51:25.0363822Z open_tuntap:PASS:ioctl(TUNSETIFF) 0 nsec
> >   2024-01-31T03:51:25.0367402Z open_tuntap:PASS:fcntl(O_NONBLOCK) 0 nsec
> >   2024-01-31T03:51:25.0371167Z setup_redirect_target:PASS:open_tuntap 0 nsec
> >   2024-01-31T03:51:25.0375180Z setup_redirect_target:PASS:if_nametoindex 0 nsec
> >   2024-01-31T03:51:25.0379929Z setup_redirect_target:PASS:ip link add link_err type dummy 0 nsec
> >   2024-01-31T03:51:25.0384874Z setup_redirect_target:PASS:ip link set lo up 0 nsec
> >   2024-01-31T03:51:25.0389678Z setup_redirect_target:PASS:ip addr add dev lo 10.0.0.1/32 0 nsec
> >   2024-01-31T03:51:25.0394814Z setup_redirect_target:PASS:ip link set link_err up 0 nsec
> >   2024-01-31T03:51:25.0399874Z setup_redirect_target:PASS:ip link set tap0 up 0 nsec
> >   2024-01-31T03:51:25.0407731Z setup_redirect_target:PASS:ip route add 10.0.0.0/24 dev link_err encap bpf xmit obj test_lwt_redirect.bpf.o sec redir_ingress 0 nsec
> >   2024-01-31T03:51:25.0419105Z setup_redirect_target:PASS:ip route add 20.0.0.0/24 dev link_err encap bpf xmit obj test_lwt_redirect.bpf.o sec redir_egress 0 nsec
> >   2024-01-31T03:51:25.0427209Z test_lwt_redirect_normal:PASS:setup_redirect_target 0 nsec
> >   2024-01-31T03:51:25.0431424Z ping_dev:PASS:if_nametoindex 0 nsec
> >   2024-01-31T03:51:25.0437222Z send_and_capture_test_packets:FAIL:wait_for_epacket unexpected wait_for_epacket: actual 0 != expected 1
> >   2024-01-31T03:51:25.0448298Z (/tmp/work/bpf/bpf/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c:175: errno: Success) test_lwt_redirect_normal egress test fails
> >   2024-01-31T03:51:25.0457124Z close_netns:PASS:setns 0 nsec
> > 
> > When running in a VM which potential resource contrains, the odds that calling
> > `ping` is not scheduled very soon after bringing `tap0` up increases,
> > and with this the chances to get our ICMP packet pushed to position 6+
> > in the network trace.
> > 
> > To confirm this indeed solves the issue, I ran the test 100 times in a
> > row with:
> > 
> >   errors=0
> >   successes=0
> >   for i in `seq 1 100`
> >   do
> >     ./test_progs -t lwt_redirect/lwt_redirect_normal
> >     if [ $? -eq 0 ]; then
> >       successes=$((successes+1))
> >     else
> >       errors=$((errors+1))
> >     fi
> >   done
> >   echo "successes: $successes/errors: $errors"
> > 
> > While this test would at least fail a couple of time every 10 runs, here
> > it ran 100 times with no error.
> > 
> > Fixes: 43a7c3ef8a15 ("selftests/bpf: Add lwt_xmit tests for BPF_REDIRECT")
> > Signed-off-by: Manu Bretelle <chantr4@gmail.com>
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> 
> > ---
> >  tools/testing/selftests/bpf/prog_tests/lwt_redirect.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
> > index beeb3ac1c361..b5b9e74b1044 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/lwt_redirect.c
> > @@ -203,6 +203,7 @@ static int setup_redirect_target(const char *target_dev, bool need_mac)
> >  	if (!ASSERT_GE(target_index, 0, "if_nametoindex"))
> >  		goto fail;
> >  
> > +	SYS(fail, "sysctl -w net.ipv6.conf.all.disable_ipv6=1");
> >  	SYS(fail, "ip link add link_err type dummy");
> >  	SYS(fail, "ip link set lo up");
> >  	SYS(fail, "ip addr add dev lo " LOCAL_SRC "/32");

