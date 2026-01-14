Return-Path: <bpf+bounces-78930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCC1D20142
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 17:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E56A5300CB85
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1AB3A1CF8;
	Wed, 14 Jan 2026 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw+tbhkr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B93F184
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406769; cv=none; b=QpFxGtl0myXz8XNguvgLfi/2vk6gsY/dP3xUyy+BZrTWPIMP9hZkLx0a1FQghOgVfFSYnBXYXjhmynjDwh8414MItz1E+WQy8sRGyDOuW0ZDO7jXO92eojygxfJT1QLiHwRGNNGB1NS/S5pU5qN4aPigbURYg9KBnGihaLQikqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406769; c=relaxed/simple;
	bh=fyFkPzA7jD86HDqzxLlGJw1nUhjO3+Q6huQ4gYgSwK8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZvqOBG8V/y4kKjVuSCX0pbSsj+VaP7JXhzMTCBcdrDGXaj2hIv5dyuWlUIOI6o6iHq8FIyioNyeulvfNFRw5rZVgF5C8ond9+fm8++UnscHgpZ7KW45lzs4zeqvjP9qOlQ+bF4c0vwON98M3y2SI7iGfX0wcwzGcjTgRxDH1o/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw+tbhkr; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5013d163e2fso21201801cf.0
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 08:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768406767; x=1769011567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyFkPzA7jD86HDqzxLlGJw1nUhjO3+Q6huQ4gYgSwK8=;
        b=mw+tbhkrQKW6x1k6KhNo8qzRG6GsP6JsbLaKg+pIAbmnfoBC/p+XCL0syseDfYf6Od
         SzLKNvMpQ+Yzwou+Dtn+URCnqv5I5033CDLQUhPqK1Xv3mwcxMMOVBLPKWRf9OMGAlow
         0GT1x15kq9Pn2yHHkofTAMbIpO+qv072Nh/Ea5vb9AP2qLw0J9ohGYA8s1V8PNHFH4G+
         a/Ms2ghkKiGE3myCmU+CmyM0rMMR2aTQMmKvLI1N0RMhTZnUWBRG2DMW+tmoJRptN+pq
         VYfyqmBobjV+/gd9Qbz55Rn4icbN8CQTa1bbD4oAegNnSeiTUERjO44g2dzNFiE+3OTE
         vu4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406767; x=1769011567;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fyFkPzA7jD86HDqzxLlGJw1nUhjO3+Q6huQ4gYgSwK8=;
        b=F2HLdZm6XOheXDlBeFqcOcnhYOWXrkC7AB4fAd/jgZBnmR2wbupvNawX1fWoSayv/l
         q65rq2rgSrIX8ZM+faQqpQQNTATVgP2ANf6SKMQiYq+5QmGGL0homvdATwGaHFySRifN
         jaszUu5cVl29yaJEZwGzE4zpf9G6WoCTitg8EtXrv7kx35c9B4WsFvrYJOk6485ScVwv
         4/MrvQc9uk+IH0OMy8d88JO9FxZ/5p/sK5xRimNUpPkvbJ/Ww4jQrpDf5f+WNwm5z3XY
         MpaNJ5UuXZ0YdmZxaGSCYnyBlTzHOv7qJ4ANm4X5B6lCw8SsqpHWlkCWT3/qs5U8Mx/d
         j2Og==
X-Forwarded-Encrypted: i=1; AJvYcCU4+ZU8uRweevYayVrx+EOnouSAWxBD4sNgK290UdpRNx8svIJTOq8FAq6uTnet0FTuPVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YysVIihZPlUNjKLUTdRIEhrit8xi+5YMnv0SIDcyGRE4tGa8UpN
	DVhn76tXon56JJeWeysYyJ5rsT/QtzoOP7Ij8RaERLGNBXlkF3PFC502gKDbCA==
X-Gm-Gg: AY/fxX6XnskJRU8u/0gT6uCyjKC7qVjlZJ9fKy/IezM/+Rtp3qmbBwi0+erOuYuXCxW
	8DDDQG2jE50ybWvkyossJc+MlDfEuIP5oMhQfRDSILBX4U5XeP1FL1UGA4iNeBd9swae3vu8J43
	iPgoyIUs2rqcEIFhXbwMaC0vlCuQSM7M54wIvTGMZ+mlBt2hr+qOgsiy7tEy4ZRAMNUFQ7a+va8
	eoErfvv+0M23gLU81mIVOPu/g0FP9ZiUx9VwM8M2wIFtREGjSNvrH/lQCz+QMvVSkhTGv+KmFqc
	QunKJuEq1zv89ktUJhmQ+dT2lBQ/MgpRlcan5OgMhTfvLNMh8n0AKyBuW+O31VE/7z7+EZrryrq
	71sIRhICKY20ofj4IyzpxkYWiqlJA0ZbR7dhxfsU72aLOF0OdZ1S27jh1HeBQ3wMYETvjmts3mG
	MqJ5V3VWfPjWdrDQ0jlX7MfzbLRD+iv8R26oW2Vp5q4Jho6J+5CSI8/HMWQ/Q=
X-Received: by 2002:a05:690c:9c0a:b0:78c:25fa:1bb7 with SMTP id 00721157ae682-793a1d6fa34mr22055957b3.60.1768400306350;
        Wed, 14 Jan 2026 06:18:26 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa670ec0sm91265417b3.36.2026.01.14.06.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:18:25 -0800 (PST)
Date: Wed, 14 Jan 2026 09:18:25 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>, 
 Neal Cardwell <ncardwell@google.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "parav@nvidia.com" <parav@nvidia.com>, 
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
 "corbet@lwn.net" <corbet@lwn.net>, 
 "horms@kernel.org" <horms@kernel.org>, 
 "dsahern@kernel.org" <dsahern@kernel.org>, 
 "kuniyu@google.com" <kuniyu@google.com>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "dave.taht@gmail.com" <dave.taht@gmail.com>, 
 "jhs@mojatatu.com" <jhs@mojatatu.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "stephen@networkplumber.org" <stephen@networkplumber.org>, 
 "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, 
 "jiri@resnulli.us" <jiri@resnulli.us>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>, 
 "ast@fiberby.net" <ast@fiberby.net>, 
 "liuhangbin@gmail.com" <liuhangbin@gmail.com>, 
 "shuah@kernel.org" <shuah@kernel.org>, 
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
 "ij@kernel.org" <ij@kernel.org>, 
 "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
 "g.white@cablelabs.com" <g.white@cablelabs.com>, 
 "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
 "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, 
 cheshire <cheshire@apple.com>, 
 "rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
 "Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, 
 Vidhi Goel <vidhi_goel@apple.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.a2eb52bfa5d5@gmail.com>
In-Reply-To: <PAXPR07MB7984F8BDC1261BD144D20DCFA38FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
 <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
 <PAXPR07MB7984F8BDC1261BD144D20DCFA38FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
Subject: RE: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill
 cases
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chia-Yu Chang (Nokia) wrote:
> > -----Original Message-----
> > From: Neal Cardwell <ncardwell@google.com> =

> > Sent: Thursday, January 8, 2026 11:47 PM
> > To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > Cc: pabeni@redhat.com; edumazet@google.com; parav@nvidia.com; linux-d=
oc@vger.kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kernel.org;=
 kuniyu@google.com; bpf@vger.kernel.org; netdev@vger.kernel.org; dave.tah=
t@gmail.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.or=
g; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; andre=
w+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gm=
ail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org=
; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.whit=
e@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@erics=
son.com; cheshire <cheshire@apple.com>; rs.ietf@gmx.at; Jason_Livingood@c=
omcast.com; Vidhi Goel <vidhi_goel@apple.com>; Willem de Bruijn <willemb@=
google.com>
> > Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill pack=
etdrill cases
> > =

> > =

> > CAUTION: This is an external email. Please be very careful when click=
ing links or opening attachments. See the URL nok.it/ext for additional i=
nformation.
> > =

> > =

> > =

> > On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-lab=
s.com> wrote:
> > >
> > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > >
> > > Linux Accurate ECN test sets using ACE counters and AccECN options =
to =

> > > cover several scenarios: Connection teardown, different ACK =

> > > conditions, counter wrapping, SACK space grabbing, fallback schemes=
, =

> > > negotiation retransmission/reorder/loss, AccECN option drop/loss, =

> > > different handshake reflectors, data with marking, and different sy=
sctl values.
> > >
> > > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > > ---
> > =

> > Chia-Yu, thank you for posting the packetdrill tests.
> > =

> > A couple thoughts:
> > =

> > (1) These tests are using the experimental AccECN packetdrill support=
 that is not in mainline packetdrill yet. Can you please share the github=
 URL for the version of packetdrill you used? I will work on merging the =
appropriate experimental AccECN packetdrill support into the Google packe=
tdrill mainline branch.
> > =

> > (2) The last I heard, the tools/testing/selftests/net/packetdrill/
> > infrastructure does not run tests in subdirectories of that packetdri=
ll/ directory, and that is why all the tests in tools/testing/selftests/n=
et/packetdrill/ are in a single directory.
> > When you run these tests, do all the tests actually get run? Just wan=
ted to check this. :-)
> > =

> > Thanks!
> > neal
> =

> Hi Neal,
> =

> Regards (2), I will put all ACCECN cases in the tools/testing/selftests=
/net/packetdrill/
> But I would like to include another script to avoid running these AccEC=
N tests one-by-one manually, does it make sense to you?
> Thanks.

All scripts under tools/testing/selftests/net/packetdrill are already
picked up for automated testing in kselftests:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commi=
t/?id=3D8a405552fd3b

