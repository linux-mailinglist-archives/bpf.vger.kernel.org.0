Return-Path: <bpf+bounces-75982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4B6CA0D7B
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 19:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19CD0332416D
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28C8398FBA;
	Wed,  3 Dec 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HeJ8XFDw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7FD398FAF
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764781140; cv=none; b=UJG9c9yAleXti58AKuZpIlD4+ArTBLSb/3stVYLqpAl+K9rfZtSi1n1cA1z70ntovgTU6EQRcN/Wl87hYAivL5yP6AZ53inKSQTHd4vYaprrIDJ2pmc83VZ8nx30c3DBVXRjV3sIxHO07BOIqE/W55Cbah9XjzWNcwoSf/48xOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764781140; c=relaxed/simple;
	bh=+w1fh0CLrnEXL5kEY/A4dLuPSBwVUZezWvTx+H8HRaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLIRb31aNtrJTK2zMqxcFJOme7QSA8rLxu8vYadsDVcQzTWdMOMTpo2KO0dMTelxNfzlsLhwHnlHzT9qeVq129+p24KCzB0esnUJsSNHn61H/0GLKLlcWzCpf2zt6jyAju0OLstT3ZCSxkUeMI8gDdw05yqjODEgBABP7ab5OM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HeJ8XFDw; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ed67a143c5so629281cf.0
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 08:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764781131; x=1765385931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWXC9hyoBsRhxJFVF8r6pSxMVZV+OmkuKYv5ee8pQww=;
        b=HeJ8XFDwdWekDq9V1b9WJsNTFib2PsBhNTiX2rmGrMIcmsVSCkVMDiqiuq9OlqQg9a
         Ay7EDzHuaOQu3QWfs6/m7Q3KMm4YOTY7Q1RHirjo+KH3AjM+4I020XQpQqigcDGHeMA5
         PmEoJtrAlSkb4bPPDYI2xhaMFa5a1Z5YCZmmaw3ge5rK/YsJOBM73EXxmtTsMDcTbWKj
         GhPpH+p7RnOvYWP7fPkg+bOA9V4xqBf7JUrmaPLD9D/VnJExi/NMadW+EEKnZwG6UqP1
         QzihSSd3ARliBhugxPMbyqOjwJ/r+6UaBuNwML+v7GS1ZWXmBv2jivFhYvOBCflqqwQ4
         nOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764781131; x=1765385931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aWXC9hyoBsRhxJFVF8r6pSxMVZV+OmkuKYv5ee8pQww=;
        b=vXINsqRKKiicWzhRHQ6nqXpBFJxd4sreac8Og/4374+U72EJtMR21FDfCJ3P0V34Jm
         Uht2WoR12IoTo5Pa/WH8v7Qp9H3Slsbvx3MMu0hT06h6cxm4b++uBam+CbLpmWlOGVBp
         eBeycgW8ljrXBvbsfsM4vkNcFCBdi1XOMO4aekAFxFgADOs8Jy+0lG88YGQx8G8uGXI7
         YJsk8mOKmfrjr3Xf3FBKduEibIMdfsOtp2EM8b4CKNsTxyXK/RW5rsGYb+9aU4QU/sTe
         pGVhpJe2DVfSNS3RJn3IStBRpkYy6N3sbsU2Bo0QzG3Pt/wmtAB/iec5fx8V31vM3P+l
         MHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJyAUcA/2JaMYjfQ/89bVG+wnFDoLuAqNetzf0RVg8xjeoSCXLIVMy1UhgoCzQocYuf2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBtk6GAoA8ww0mSrobyTaWRpLjy2XTLuVT8w1LOgBa/ZGtZL7
	zCfX0NeNkbe1CrG4UAjjtYBSrLHN/6SZAByuf8a6y+TRIWYskk0UKwrrLWbovrocjeoj7GWbWA1
	ZbfSB1JQ1GoZR9kkEongg0n10ZEwAkQ3NvI/Y23IZ
X-Gm-Gg: ASbGncsJJyaJO6OOIx8t6PrCJQUSHE4TomH+5BxD/avmRaY73s1hWP2hCpoP3au91f8
	8PCDmiFAeMsxBsGdELFuoGqCxMTr7E7E6GJCv6LprXUAgcHDCeiCrR2W6TF28j1TKtyF/DKaQwd
	IifKoQG85InJly5Xdnl2cMWJisIfnMfSnJR4YdMmRIxfduPOLQgplKQ577i/6G5jN0fEP/XR1So
	B6fXqLOcO0ALcx3DEGZm+Ge9u2xSE9uqgQExmQUwG7Zv3N5cuLssdFEXSl60bwS97whylZb4RIK
	1voquA31IzyWhYi7InFajui4e9V/nz4tcV/f+lh36vqVhs7D4JhlHWTAMzJf
X-Google-Smtp-Source: AGHT+IEwQDGOVT8Lgzi1wTqV6Us8oL3zoJ/xquBSspLWs/EEWhA+DJcMaq/DF7hunAbCMnNSctvo80o0agoxsFagOgY=
X-Received: by 2002:a05:622a:15ce:b0:4ed:8103:8c37 with SMTP id
 d75a77b69052e-4f015798fffmr13757201cf.12.1764781131112; Wed, 03 Dec 2025
 08:58:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com> <20251201150509.6cd9fefc@kernel.org>
In-Reply-To: <20251201150509.6cd9fefc@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 3 Dec 2025 11:58:34 -0500
X-Gm-Features: AWmQ_bmmK0qcQ0MMg8A5oddcgrqcwdNw6rP5OvhiWOfo_lx74r4d17hh5ndUNnw
Message-ID: <CADVnQynFTrWf_waxGPH6VVPSZapSuxUb6LFdFUGj0NfiADAa7Q@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 00/13] AccECN protocol case handling series
To: Jakub Kicinski <kuba@kernel.org>
Cc: chia-yu.chang@nokia-bell-labs.com, pabeni@redhat.com, edumazet@google.com, 
	parav@nvidia.com, linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, andrew+netdev@lunn.ch, donald.hunter@gmail.com, 
	ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 6:05=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  1 Dec 2025 17:37:47 +0100 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > Plesae find the v7 AccECN case handling patch series, which covers
> > several excpetional case handling of Accurate ECN spec (RFC9768),
> > adds new identifiers to be used by CC modules, adds ecn_delta into
> > rate_sample, and keeps the ACE counter for computation, etc.
> >
> > This patch series is part of the full AccECN patch series, which is ava=
ilable at
> > https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Hi Chia-Yu,

My understanding is that you still have a set of packetdrill tests you
have been using to test this AccECN patch series. For the Linux
networking stack, the recent best practice for a significant patch
series like this is to add packetdrill tests to the
tools/testing/selftests/net/packetdrill/ directory as a separate
commit in the patch series.

For a recent example, see:

  selftest: packetdrill: Add max RTO test for SYN+ACK.
  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commi=
t/?id=3Dffc56c90819e86d3a8c4eff6f831317d1c1476b6

When you next post the AccECN patch series for review, can you please
include a patch at the end of the series that posts your packetdrill
tests in the tools/testing/selftests/net/packetdrill/ directory? In
the commit description for that patch, please include a mention of the
packetdrill SHA1 you are using and a link to the packetdrill branch
you are using, somewhere on github or similar. Then I will look into
merging any packetdrill tool changes that you are depending on, if
there are packetdrill commits that you depend on that I have not
merged into packetdrill yet.

Thanks!
neal

