Return-Path: <bpf+bounces-71825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DECABFD578
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 18:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E08DA34FA37
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 16:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFFD33DECC;
	Wed, 22 Oct 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMRCjZUd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F0A26FA70
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151461; cv=none; b=cZdypTQA+TlREfM0M6Q66n57o3cpImcossg2UBvBej76SdBtT3VJWZmPmosvMR3HGftXiFhsHg5s2Jj9WFkkeLRTucxlAk/vOCn7QXIEuZdc+ebzJtXPSTpeqQ1ZnD847Gb86KBPcU9RQjbPLOxw57iC0NuAftBhDwXoln37ZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151461; c=relaxed/simple;
	bh=j4tvMOGoWp+6/LQDA5S0P6afK9AwH6IIUHE/pmi2IAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWXfe6W+yJTjpLeramKB9JKabVwBcedQFSjUjHN9AYFOOwrD8aUr4e1O+eoctilhG+KobQYyguRetLthA9eQ4DEhVrD0oE4uuWOheMxyhXvbP0Zh0qQuxiAiZ5yHBwVqin08AN2vErgDqAlX3owkEGhYmQTreLYb3YUCu4vJPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMRCjZUd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee130237a8so4639545f8f.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761151458; x=1761756258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygaNDNbabPv3r2xGJYgwETszLPm4Qf+7vTtVF4xoUiU=;
        b=kMRCjZUdMW1Owzb4tWtvNB+hEv7/H1VUUuZ3F8TuB+baR5ROulyizYhenLuDbq51Pt
         slahJs85//Tk3RjzhP+SSnHZt1Wgf42fXt+Z+QifsRCTQp1NnmqajZ1LYmuOcB+aGH7K
         t4cRiy7vkSlOQsybx6xXajkgLbhaj1IvzPlWXkEBBp2T9OqBEjnwz1+mfHk4hJYVN03Q
         HNwH1bPhEhSic/xJm622kyrRzMM+uP4LtoX6Sm/WECQSxQJU5TstQVMNqoA7n8sZLIaa
         sO/FU85JLHCyKiCvu30Mv4WyGVYy9Uxd/rruFpBXT4UPOjNYDfT0kN+bK3jutr6DlzCO
         lwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151458; x=1761756258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygaNDNbabPv3r2xGJYgwETszLPm4Qf+7vTtVF4xoUiU=;
        b=xEiCI2Ntv4EaZ5ScaYOsgGAnaLly7H6mukz27YmKjWW0uk8IJEM1h29P3+i7354ccK
         wNdtCZz2//ywr774/oh7sfSM3x4UUr8xdl5T5uhhtKfjRjJntzl5e3WIPf2KA2haHcGU
         KooZZGYU/Jb59Oo++Z9art+ehyiITbZqX+ViOQ2sNO8zQJGBEtvTEnU8Rcj/cXeyXIx1
         KwkZxqfO1Qhuir5JQuujIEIcZFhg2X+e9TU/6QEJLy7YZJPMYPsyqeSKZI7fAOynidtY
         7A0dw+baXRX4jnjw5inSzrRtELMyUqmRJrXpB9+zgXrvspaSAWhncUzdBKysO60iN7m+
         vpPw==
X-Forwarded-Encrypted: i=1; AJvYcCU9byyxZBP+8ae3gss5b/MVINk9MbGpyGmflqNQUr2rh/egFSneU6mYKBGndsYgqUyxF5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzggyC+QRLvInKkaZTz36h2Y3jC/SaLly+ygrAXtkE2Xt5g5x08
	T/4vnmhpWNBWC0GYgPsPLSPk03JDcDq9dVHAP60e5JoFLpc1E6yvYhpAYuJ2UdKzWyYVrdgK28U
	HoDPpwJXo0/TDynFw+ILsMZW8MuO8bbU=
X-Gm-Gg: ASbGncuL4Kwmtymxmqy+GnXdVm4MsbjjKhQlWdDLIF/6Q2L0YQpiSWTAKejKdFxtIZf
	xZuL8RlTlAfGMMHO/aEYFgULM4ZwRqeqG0PwvLHqp2YVbjzULVbQsK0962Jk/ik3K/ocTk/kZf1
	HUcDQqACPj+oF0B7vEiEdAV3l9JHbd/mv26sU9O+jnD5x8ucX6Et6G8LOE89rri1IVF2Gy3PSHt
	IFc9IyOOdE2Ng2k/gbQV3MKvemPGOvR9RjxyO/X4ySVTU/oPkn0inzkhJr5s+2KyxrnU7BKcWkS
	R3fJlp7Mk61s/WA0pw==
X-Google-Smtp-Source: AGHT+IG8PotEN+a4eXRonUtwAj3rbW+NEcQG8KtHZl4hlsvXRedBaBpDgp56n6VfESdp1DVnSACGAph72ACzXHQzamg=
X-Received: by 2002:a05:6000:40df:b0:427:8c85:a4ac with SMTP id
 ffacd0b85a97d-4278c85aac0mr14251693f8f.47.1761151457697; Wed, 22 Oct 2025
 09:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-tc_tunnel-v2-0-a44a0bd52902@bootlin.com>
 <20251022-tc_tunnel-v2-3-a44a0bd52902@bootlin.com> <DDOOS5LR0GZH.ITEM5495FPOX@bootlin.com>
In-Reply-To: <DDOOS5LR0GZH.ITEM5495FPOX@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Oct 2025 09:44:05 -0700
X-Gm-Features: AS18NWDLP0NjwQEzYp_qrJd1MU37XauNkLfKjad0wMcbqRCgfSv54aOHXJEi0bg
Message-ID: <CAADnVQJ6zKbThz8B5bqBpwz=gyqeindZb1kwCmM90PsR4-7iQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: integrate
 test_tc_tunnel.sh tests into test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 12:52=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> On Wed Oct 22, 2025 at 9:39 AM CEST, Alexis Lothor=C3=A9 (eBPF Foundation=
) wrote:
> > The test_tc_tunnel.sh script checks that a large variety of tunneling
> > mechanisms handled by the kernel can be handled as well by eBPF
> > programs. While this test shares similarities with test_tunnel.c (which
> > is already integrated in test_progs), those are testing slightly
> > different things:
> > - test_tunnel.c creates a tunnel interface, and then get and set tunnel
> >   keys in packet metadata, from BPF programs.
> > - test_tc_tunnels.sh manually parses/crafts packets content
> >
> > Bring the tests covered by test_tc_tunnel.sh into the test_progs
> > framework, by creating a dedicated test_tc_tunnel.sh. This new test
> > defines a "generic" runner which, for each test configuration:
> > - will configure the relevant veth pair, each of those isolated in a
> >   dedicated namespace
> > - will check that traffic will fail if there is only an encapsulating
> >   program attached to one veth egress
> > - will check that traffic succeed if we enable some decapsulation modul=
e
> >   on kernel side
> > - will check that traffic still succeeds if we replace the kernel
> >   decapsulation with some eBPF ingress decapsulation.
> >
> > Example of the new test execution:
> >
> >   # ./test_progs -a tc_tunnel
> >   #447/1   tc_tunnel/ipip_none:OK
> >   #447/2   tc_tunnel/ipip6_none:OK
> >   #447/3   tc_tunnel/ip6tnl_none:OK
> >   #447/4   tc_tunnel/sit_none:OK
> >   #447/5   tc_tunnel/vxlan_eth:OK
> >   #447/6   tc_tunnel/ip6vxlan_eth:OK
> >   #447/7   tc_tunnel/gre_none:OK
> >   #447/8   tc_tunnel/gre_eth:OK
> >   #447/9   tc_tunnel/gre_mpls:OK
> >   #447/10  tc_tunnel/ip6gre_none:OK
> >   #447/11  tc_tunnel/ip6gre_eth:OK
> >   #447/12  tc_tunnel/ip6gre_mpls:OK
> >   #447/13  tc_tunnel/udp_none:OK
> >   #447/14  tc_tunnel/udp_eth:OK
> >   #447/15  tc_tunnel/udp_mpls:OK
> >   #447/16  tc_tunnel/ip6udp_none:OK
> >   #447/17  tc_tunnel/ip6udp_eth:OK
> >   #447/18  tc_tunnel/ip6udp_mpls:OK
> >   #447     tc_tunnel:OK
> >   Summary: 1/18 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bo=
otlin.com>
>
> A note about test duration:
> the overall test duration, in my setup (x86 qemu-based setup, running on
> x86), is around 13s. Reviews on similar series ([1]) shows that such a
> duration is not really desirable for CI integration. I checked how to
> reduce it, and it appears that most of it is due to the fact that for eac=
h
> subtest, we verify that if we insert bpf encapsulation (egress) program,
> and nothing on server side, we properly fail to connect client to server.
> This test then relies on timeout connection,  and I already reduced it as
> much as possible, but I guess going below the current value (500ms) will
> just start to make the whole test flaky.
>
> I took this "check connection failure" from the original script, and kind
> of like it for its capacity to detect false negatives, but should I
> eventually get rid of it ?

I vote to get rid of it.
I'd rather have test_progs that are quick enough to execute for CI and
for all developers then more in depth coverage for the corner case.
Note that for the verifier range test we randomize the test coverage,
since the whole permutation takes hours to run. Instead we randomly
pick a couple tests and run only those. Since CI runs for every patch
the overall coverage is good enough.
Would something like that possible here ? and in the other xsk test?

