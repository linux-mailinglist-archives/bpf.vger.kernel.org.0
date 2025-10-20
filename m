Return-Path: <bpf+bounces-71405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BAFBF21D7
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 17:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BBB400D2F
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53473269AEE;
	Mon, 20 Oct 2025 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqNoHb+t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E20264A97
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974324; cv=none; b=adza+BwjjhwPgRtecAmk31QF3IxH6iV74Tp9B96J8v0qLmptTivBSMjRbK+ODDv6LvnUFsEHAYFlgO8cBJoD/031oD60dO+INugE1la1XdWZ1ZXTb5HJK/wK85UwgJajJUbKNad+svzd9UzVqw6jSg/KSbDl/qdfss9oS8X3IZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974324; c=relaxed/simple;
	bh=hTx9HVxfZXSrtxn8CvPjCWWzLhaDyp1TwWQ5eykxT/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSL3uOw+xsEk/kUR3csMqKgJm4VHa+I+MtCoRFP5MU4hRcQnyMa75RKEyJbd1O3fyt/2QjkF/0ZLwJhxEIwp4MuWRoJKN40LD8hZvUtiNVMcIbCm7AFdD1ESz9d29YqqIzQBCH0eiOao5gHnXt3E/Km0bRy4FzMqMtzmm8sALDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqNoHb+t; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-78e4056623fso58429576d6.2
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760974322; x=1761579122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTx9HVxfZXSrtxn8CvPjCWWzLhaDyp1TwWQ5eykxT/c=;
        b=kqNoHb+t9kqF7MM2fykkOUJMAMvWEYQSEXWxHxwHN6cZuWN44kHXULJP6rcpsle7+7
         SPuOlX+UiYQTDnJpuXWWzWzHIdh993F6cdqYx1MBkHujca2jL8MtdjIeW3cg0vZpQp/0
         m1jsXImHyF1HsTi9VPjz4E4JdGKgIWPuy8cL50mYH/rPsclRmyV1Rq3sV37eHiemgje3
         8pvC3B/qldeE2WYKsp+3Bzah5Wzd8kXQ13Suk9wJAaf5NXBf2IH5dPVJybFdD1xIsmxK
         s74jE8sh2oto0wnIULOJ4qw+oTpcwjytD07lMmmWEgy9jXrb6vReS+cDAiZnDF8nBCY/
         q0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760974322; x=1761579122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTx9HVxfZXSrtxn8CvPjCWWzLhaDyp1TwWQ5eykxT/c=;
        b=o2o+CCQPxnMHfnRz/MRK6wdacvn7D3eaTAGJr6jxL5ZiIdmxyx/4moBIFYc38EvOAo
         +etEOLn6glxHMhcGY6fp2Jm3qLC/Nq/HutFfG/Njqww99XDNtli1VWlAA1mREXYUKiyB
         IzsGh/D/mNkGdv5b3z9Wlj1AMyglMX4TIRsn+sXVdZaIj9HWUOSaemZKtI6FOr6sN6st
         wsTTeUkVvyWKG320yKoujFPaRrkqTsREdJX/trrBD3LdFYZIuO0HbWt1uDmdf+o91V+6
         rbz0FlRt1dsdQOsceOnWpMTDPW+W6IozcyTxzesjGuahLGrjKtKQhCpeOu3yy4oHVNmD
         9JyA==
X-Forwarded-Encrypted: i=1; AJvYcCXYybty9S2AjrbPBpxLsrCivQm+De12L/SyieVnWUghftOgyFis5w9t+tGIGzJupvCNbl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys2bzRffmT1iFQxPoPdpxjOm7xSxfxA3cuK/gcAevPRWqzKdUv
	d/vApbvgfi057pmy6B3l4rXeSfpYYF7XrEGuqz98dFR/+RFFbDhIJdRJNnFTeGpl7Kw7OYGlt6G
	C7Q0LQG+PlBtxHuz6WVajHNiuTHnDTY6USM2ZB4ca
X-Gm-Gg: ASbGncu7rjMifIYEiHjlgg6Yy4ejku4zsT6Ip68FQnFSKY9V/AmAUKogfYwdbmAFTGg
	k6KKoFHrNCSv+sjTFlIO+kyuQpBtq5bq7x10H8y9lWdpc6vTXPcn0YKmtRB/yGOsztUZO0XqLcN
	cYbX3idAeRwMkR4u9SM7bgD8YxM6IfDRXJSQzvk9bCLbHbpmzgEfH3dPanA9ILPnkiEOO7ScV/e
	aRwf0ZzqGBJ+ncZ078gijXBeckAgGbF3wkasQZDY5YWPEqU0I7JjnODBMW2KjcaTNacCOI=
X-Google-Smtp-Source: AGHT+IEdHdWyI7mOrpfFqKEne60YjRdxkTiiGct+YFp5FQLwi3H3NnPrv3GzMWIKb1yewXybnZNz6NoRsBAOxXmE8qs=
X-Received: by 2002:a05:622a:613:b0:4e8:b82e:7092 with SMTP id
 d75a77b69052e-4e8b82e7306mr79282891cf.62.1760974321166; Mon, 20 Oct 2025
 08:32:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
 <20251013170331.63539-3-chia-yu.chang@nokia-bell-labs.com>
 <98342f21-08c8-46de-9309-d58dfc44d0a0@redhat.com> <24bc44a8-6045-9565-c798-a9d4597366e8@kernel.org>
 <PAXPR07MB7984DB68F2D9E7468D839BEFA3F5A@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB7984DB68F2D9E7468D839BEFA3F5A@PAXPR07MB7984.eurprd07.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 20 Oct 2025 08:31:50 -0700
X-Gm-Features: AS18NWDUZznJqUfVcx0aI9J1KOrbstIH9YmbS1cOmBVfbpztFwRTg_RHcMvp5sE
Message-ID: <CANn89iKyQFowOpFDXbpewEiEGESdeZ_bgBViOA2NN9n8h6Vkrw@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 02/13] gro: flushing when CWR is set
 negatively affects AccECN
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ij@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"dave.taht@gmail.com" <dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>, 
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>, 
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 8:26=E2=80=AFAM Chia-Yu Chang (Nokia)
<chia-yu.chang@nokia-bell-labs.com> wrote:
>
> > -----Original Message-----
> > From: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Sent: Thursday, October 16, 2025 10:27 PM
> > To: Paolo Abeni <pabeni@redhat.com>
> > Cc: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; edumazet=
@google.com; linux-doc@vger.kernel.org; corbet@lwn.net; horms@kernel.org; d=
sahern@kernel.org; kuniyu@amazon.com; bpf@vger.kernel.org; netdev@vger.kern=
el.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.org; stephen@net=
workplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemlof=
t.net; andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net; liu=
hangbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ncard=
well@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs=
.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehl=
ewind@ericsson.com; cheshire <cheshire@apple.com>; rs.ietf@gmx.at; Jason_Li=
vingood@comcast.com; Vidhi Goel <vidhi_goel@apple.com>
> > Subject: Re: [PATCH v4 net-next 02/13] gro: flushing when CWR is set ne=
gatively affects AccECN
> >
> >
> > CAUTION: This is an external email. Please be very careful when clickin=
g links or opening attachments. See the URL nok.it/ext for additional infor=
mation.
> >
> >
> >
> > On Thu, 16 Oct 2025, Paolo Abeni wrote:
> > > On 10/13/25 7:03 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > > > From: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > >
> > > > As AccECN may keep CWR bit asserted due to different interpretation
> > > > of the bit, flushing with GRO because of CWR may effectively disabl=
e
> > > > GRO until AccECN counter field changes such that CWR-bit becomes 0.
> > > >
> > > > There is no harm done from not immediately forwarding the CWR'ed
> > > > segment with RFC3168 ECN.
> > >
> > > I guess this change could introduce additional latency for RFC3168
> > > notification, which sounds not good.
> > >
> > > @Eric: WDYT?
> >
> > I'm not Eric but I want to add I foresaw somebody making this argument =
and thus wanted to not hide this change into some other patch so it can be =
properly discussed and rejected if so preferred, either way it's not a corr=
ectness issue.
> >
> > I agree it's possible for some delay be added but the question is why w=
ould that matter? "CWR" tells sender did already reduce its sending rate wh=
ich is where congestion control aims to. So the reaction to congestion is a=
lready done when GRO sees CWR (some might have a misconception that deliver=
ing CWR causes sender to reduce sending rate but that's not the case). With=
 RFC 3168 ECN, CWR only tells the receiving end to stop sending ECE. Why do=
es it matter if that information arrives a bit later?
> >
> > If there are other segments, they normally don't have CWR with RFC 3168=
 ECN which normally set CWR once per RTT. A non-CWR'ed segment results in f=
lush after an inter-packet delay due to flags difference. That delay is not=
hing compared to GRO aggregating non-CWR segments en masse which is in n ti=
mes the inter-packet delay (simplification, ignores burstiness, etc.).
> >
> > If there are no other segments, the receiver won't be sending any ECEs =
either, so the extra delay does not seem that impactful.
> >
> > Some might argue that with this "special delivery" for CWR the segment =
could trigger an ACK "sooner", but GRO shouldn't hold the segment forever e=
ither (though I don't recall the details anymore). But if we make that argu=
ment (which is no longer ECN signalling related at all, BTW), why use GRO a=
t all as it add delay for other segments too delaying other ACKs, why is th=
is CWR'ed segment so special that it in particular must elicit ACK ASAP? It=
's hard to justify that distinction/CWR speciality, unless one has that mis=
conception CWR must arrive ASAP to expedite congestion reaction which is ba=
sed on misunderstanding how RFC 3168 ECN works.
> >
> > Thus, what I wrote to the changelog about the delay not being harmful s=
eems well justified.
> >
> > > On the flip side adding too much
> > > AccECN logic to GRO (i.e. to allow aggregation only for AccECN enable=
d
> > > flows) looks overkill.
> >
> > The usual aggregation works on header bits remaining identical which ju=
st happens to also suit AccECN better here. The RFC 3168 CWR trickery is wh=
at is an expection to the rule, and as explained above, it does not seem ev=
en that useful.
> >
> > This CWR special delivery rule, on the other hand, is clearly harmful f=
or aggregating AccECN segments which may have long row of CWR flagged segme=
nts if ACE field remains unchanging. None of them can be aggregated by GRO =
if this particular change is not accepted. Not an end of the world but if w=
e weight the pros and cons, it seems to clearly favor not keeping this spec=
ial delivery rule.
>
> Hi Paolo,
>
> I agree with what was mentioned by Ilpo above.
>
> But if Eric can share extra comments or some particular cases would be he=
lpful.
>
> Shall we submit all patches with changes (and keep this patch unchanged)?=
 Or please suggest other ways to move forward.

Hmm... maybe now is a good time to amend tools/testing/selftests/net/gro.c

In general, the lack of tests in your series is not really appealing to me.

