Return-Path: <bpf+bounces-79380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 783FCD397BB
	for <lists+bpf@lfdr.de>; Sun, 18 Jan 2026 17:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E2AB3002843
	for <lists+bpf@lfdr.de>; Sun, 18 Jan 2026 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8561D23185E;
	Sun, 18 Jan 2026 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6XaMVfe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D128D215F5C
	for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768752663; cv=pass; b=pB2y6HVpG4Ts16aeLhLMbXm1BoqIrcV2zvgEOVOM3vCm+t6yCeg5x7u+YV1mSWaZ/4iCwO1TNt4vyImVnxv9Kl08BK4zo1IRRcgXGafuEpR0zZwPkKpv+rGDZVfPZgH1bKYiDU0B+1A7UZK/7IvnV4ypGWWIvL3VT1sp3lyMXrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768752663; c=relaxed/simple;
	bh=0JEpv1u8AAklgZXOaUjF/uve3gSlITzDcBypad/O0O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aS3l2pQjhM1eG2oXMnBji6gs4KzvadjVGwrDYysdAXHaHh50VoyVJTQ+Ei6dQjf81p4vBp3wmIylW/HD8+VIsjOle1N02Hz7PkabT58tEFnVpp3wfI9+DuKtRUEwS57MWtUfjonLzHmdpTXbM+HzCel1tQPMJD4TY4Wzx/+fZiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6XaMVfe; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50299648ae9so539351cf.1
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 08:11:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768752660; cv=none;
        d=google.com; s=arc-20240605;
        b=TQ1heRWGSd38ueG0/tyR5xzbIlKqrTQ5pHJlyMKAmpkxws2jQ6LaLJQDDW1fT2cdTO
         onYh9vvqd8Ehn6ciOofmQenc3bTF7hw72yoA4NiD6th4WXzbG3Z+X2W9jCEX6erWITEr
         BSWN8gjfmlJCp0s1s7nT/VtcFu/JCnjmSdpA1qxMf5hGkTyE+nLmGym9uGyJ76DEX7BK
         nrwp0B80/MqHI9iW6VwvZY5ArT3tDz2F3NxiZchMCKEXhB9HxmHyvHuVoTG/KYCfpf/0
         d6xcqGnooXOV1Mve1X/dMMVTQvwiE4KCKGG7Q2dHX28bz9WsIy/URTawNPClBqhWfRXG
         q6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uOQOX9EFLjUIlu2BazfXCgVYe+lL7//UbrC4sKaqc4w=;
        fh=eSkwxWTlk6aUME+ycKaEYoxpvyhr2O/p0jVD93+fsyE=;
        b=ffm3yFkwNvRe7LhOm79fzL6/oleMEderamBYIrvBICHaMsedBi84aOulo/MM7Hm6n6
         AtCH+izFLYtpPPOZ6evvqlQGXSVBAeacwPFRwc9zSRrtVWAl1PzU6Af3b+Jn/PMScQ8p
         ooMXR2sCmMcGte+3bnF9Pyy1huft8zZb1pnLJW3X7uz3gJ01bxL5IWvW7D4dbujV+aWU
         Lppa6Bw336oPuMd+rirOjM8cvx1sb8wzLAHi21h72ZNgcRdZZBuxrLYBIHoANAarVm0q
         rloH7tzy9FGUZF6mUi6UgrV9/enMjtAL04Hpju+oOygqUzSnnihoUfssnsqfc9YZkmvn
         wbAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768752660; x=1769357460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOQOX9EFLjUIlu2BazfXCgVYe+lL7//UbrC4sKaqc4w=;
        b=o6XaMVfeClkjpRcSgzZz6ylPmhY4DzRtt9TKBZgcXgb9UBFd4eGSJy3wouiKYeoxFZ
         +dS00Qq+oyGb1YwCrkvooeHOr0y5bV/hGVGwIrhbmVGkcVH7PJJE01wr4anVeqSzQobf
         66NZEO7pbzaQftNGzUWh5O3JtHyWCC902akFDKCQpxLgyZ6/jUTmUbQZh7C3HUevO5TP
         3337NTE9Mu43ev+xQsctB1vLMjQUe4Lp4pAsQvhCUNp2qJNn5Sh9fDkSfXpcKoCJMUhP
         vTjHYNT/7aXvP+tzo0d6oAVG6NGcAwRdBd4I9+waz5sVmzsYBPC+suwxJvrX4W3lIf6Z
         LO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768752660; x=1769357460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uOQOX9EFLjUIlu2BazfXCgVYe+lL7//UbrC4sKaqc4w=;
        b=cPMJWBGFj3UHru9MS7mdAc3HKSTjM4HrWSkPv6Caashxouju/rqiW97fAZmMrCYp9C
         nG4K5pzDcZ6Jx//siMj0FqTh3fhB2ev/zEwpzNCNHyV/sUQDr4ikPITfF3ROCR7ACxJk
         ZSxotfbJgu1VmGMm7XKbvIlbHTGMgvGhxE4J1N1AHm2WyQU4amimFCie/n86DpTMG5if
         k2vYRzaj2aNjh9KxQsFhyj9O4zHJqQZQPV4/RxKwfjMh0RF57EWZ7d4Fmp3vO31O13tN
         nyRik8BukgSxTyaSsPZkmd82YAkzBJtHulK6ztQnwDThNIlughLRCzAJRCEvdsAohIEF
         vE6w==
X-Forwarded-Encrypted: i=1; AJvYcCVoeE1Po8mdi1AS3MWUoi/ScGiJ3NxFgAI53366gRc/TbasxSUABaFA4EjBRyMPpHFMo5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOxYs0K/u+NQF5nlba9Pzn8WpsyfnZzCGfvTOMmKK76hd0GYpD
	7gEOdT9X6C+KEYYAvQqRAZxUiMfU+fSlSt6JNKyx98wdENr4zCHFsCijhkNhHnIoujnvhsX8dxi
	qJfvYAgsaq7jB7E4Tihj3oakJ0vhUTjPDjvtGoPI+
X-Gm-Gg: AY/fxX4BCKKN+jQzZhAjj10NcUPxjnqupUdB8v3aXOchaRHdAPQ9sU6uHamFOUlPCKY
	51DOCFCOhu2OZAO4Jvb1n3F+AZgT6bH0QfQ7yRd7Ljlupq0LA5VKOnWMJQxtzZJUip2qxEqqx5f
	f/nOrMZ8YK8HQIUK3ijLdh0hFm0tK57CaR+Abyi/q8oHheqbnSaVX/9QlHla2kdMBZIGZP1ppAB
	rLEhD21RjCdqp7SNezS7Q1kbRGRoZ89PFEtomlyenspnbOw1A9V/FKUHqlpW1vaCnbLROQVdLLQ
	XZRkKQeawochivpdLi0hK82OSBOzjJaXyMqqGjSfT4Sbm+LnD7nVqy6oozQt
X-Received: by 2002:a05:622a:1342:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-502b0673b32mr11255181cf.3.1768752659324; Sun, 18 Jan 2026
 08:10:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com> <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
In-Reply-To: <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sun, 18 Jan 2026 11:10:42 -0500
X-Gm-Features: AZwV_QiOr26zAWiUyzYVGxtB4uUNxYcdhHaXiVDyCTcYKsivAZl7luiVeGFtNPs
Message-ID: <CADVnQynBnqkND3nTS==f6MGy_9yUPBFb3RgBPnEuJ446Hkb-7g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill cases
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com, 
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:46=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.co=
m> wrote:
> >
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Linux Accurate ECN test sets using ACE counters and AccECN options to
> > cover several scenarios: Connection teardown, different ACK conditions,
> > counter wrapping, SACK space grabbing, fallback schemes, negotiation
> > retransmission/reorder/loss, AccECN option drop/loss, different
> > handshake reflectors, data with marking, and different sysctl values.
> >
> > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > ---
>
> Chia-Yu, thank you for posting the packetdrill tests.
>
> A couple thoughts:
>
> (1) These tests are using the experimental AccECN packetdrill support
> that is not in mainline packetdrill yet. Can you please share the
> github URL for the version of packetdrill you used? I will work on
> merging the appropriate experimental AccECN packetdrill support into
> the Google packetdrill mainline branch.

An update on the 3 patches at:

https://github.com/google/packetdrill/pull/96

(1) I have merged the following patch into the google packetdrill repo
to facilitate testing of the AccECN patch series:

"net-test: packetdrill: add Accurate ECN (AccECN) option support"
https://github.com/google/packetdrill/pull/96/changes/f6861f888bc7f1e08026d=
e4825519a95504d1047

(2) The following patch I did not yet merge, because it proposes to
add an odd number of u32 fields to tcp_info, so AFAICT leaves a 4-byte
padding hole at the end of tcp_info:

  net-test: packetdrill: Support AccECN counters through tcpi
  https://github.com/google/packetdrill/pull/96/changes/f43649c87a2aa79a33a=
78111d3d7e5f027d13a7f

I think we'll need to tweak the AccECN kernel patch series so that it
does not leave a 4-byte padding hole at the end of tcp_info, then
update this packetdrill patch to match the kernel patch.

Let's come up with another useful u32 field we can add to the tcp_info
struct, so that the kernel patch doesn't add a padding hole at the end
of tcp_info.

One idea would be to add another field to represent newer options and
connection features that are enabled. AFAICT all 8 bits of the
tcpi_options field have been used, so we can't use more bits in that
field. I'd suggest we add a u32 tcpi_more_options field before the
tcpi_received_ce field, so we can encode other useful info, like:

+ 1 bit to indicate whether AccECN was negotiated (this can go in a
separate patch)

+ 1 bit to indicate whether TCP_NODELAY was set (since forgetting to
use TCP_NODELAY is a classic cause of performance problems; again this
can go in a separate patch)

(And there will be future bits of info we want to add...)

Also, regarding the comment in this line:
  __u32   tcpi_received_ce;    /* # of CE marks received */

That comment is ambiguous, since it doesn't indicate whether it's
counting (potentially LRO/GRO) skbs or TCP segments. I would suggest
clarifying that this is counting segments:

__u32   tcpi_received_ce;    /* # of CE marked segments received */

(3) The following patch I did not merge, because I'd like to migrate
to having all packetdrill tests for the Linux kernel reside in one
place, in the Linux kernel source tree (not the Google packetdrill
repo):

  net-test: add TCP Accurate ECN cases
  https://github.com/google/packetdrill/pull/96/changes/fe4c7293ea640a4c811=
78b6c88744d7a5d209fd6

Thanks!
neal

