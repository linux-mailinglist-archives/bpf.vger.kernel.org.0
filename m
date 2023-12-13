Return-Path: <bpf+bounces-17634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CAB8107AC
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 02:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04041C20E1F
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 01:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E868FECE;
	Wed, 13 Dec 2023 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv3H7R/W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE86CF
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 17:32:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3332efd75c9so5605171f8f.2
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 17:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702431165; x=1703035965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGTpQmu3GXE7DHNoF7J3vSFJThQGo8kjepksHBry8bc=;
        b=fv3H7R/WJMcGmVGACqi3SGrUw3+bAiQLaR9o1thDZvTo07b1DS8qVF/Zsqg/a2qT0Q
         JCCDbXhwk2X+A4v0S7Ylmo31b19zHOU9ZlDPkpi4VRWjEX5oogVcHEz89xkwig6tjEJK
         wSB7PmI1GNQOPX8FJwk0GOhD2hhgz9mvmREHBjUBsRR2WMb0C0xW4j6hImMBPjJrIaCx
         w4GillEpm6xkgmhPeUor4kCpDtzp/YFe4kYrAFsOQBQDWHzZtpTvFqjysmd++qZP68jy
         ug9C8jqhYQenwejDsFme45TN97oy5F+iwTR35wCDX5WXOaP503PmDPOZ39SVX5ruTvYd
         Id3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702431165; x=1703035965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGTpQmu3GXE7DHNoF7J3vSFJThQGo8kjepksHBry8bc=;
        b=R5pw2bSlXgW/SnxQkjVkzV76mzFpMyOPHBXImz+oqXY6XGo+QJYjLCBK/FoueGOmWj
         mouF7Kfx7cVyUvzn3r+gRFphWhjNjE1vTSJGHVl/eu6wXn01Z5vOs+UOUad5KDqliUih
         q7ZAJSyyt8qLX/JqjZfnifDebI/9l+IwMfVSsPqt6qN1dsLlaN6eY7DpinKHRXZFJ6lv
         yJOM/oddaAF43copH214SVdOBypxeYpWWV5l7tsD8EIbL4tb+nobtdgSCdjmb/8Y40qa
         RiNLs/wXntqWM6ygUjx3CN+ceVG7eYT6alJVC9A56UzYJDCdTZ+oJMcLtEKRF1jU+psB
         nGIA==
X-Gm-Message-State: AOJu0Yw77J6grckGUAbObRupGI7YoQOYG9ZeRYASNcHulrF6Qhl/FPDK
	Uquz6oYf/ZncklmD3V6mk899pTGOC4mx0l+lUIXNMbCA
X-Google-Smtp-Source: AGHT+IFsJBK3NJijxkElIbph59esV9Ms4A/ssi/wmtpGUnUY07juV0rmchatiXkFT22EiVOk8mPyrEzs79FblC7YMXI=
X-Received: by 2002:adf:fb49:0:b0:333:53b9:441b with SMTP id
 c9-20020adffb49000000b0033353b9441bmr2138961wrs.47.1702431165398; Tue, 12 Dec
 2023 17:32:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127201817.GB5421@maniforge> <072101da2558$fe5f5020$fb1df060$@gmail.com>
 <20231207215152.GA168514@maniforge> <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com>
 <20231212214532.GB1222@maniforge> <157b01da2d46$b7453e20$25cfba60$@gmail.com>
 <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com> <20231212233555.GA53579@maniforge>
In-Reply-To: <20231212233555.GA53579@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 12 Dec 2023 17:32:33 -0800
Message-ID: <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
Subject: Re: [Bpf] BPF ISA conformance groups
To: David Vernet <void@manifault.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org, bpf <bpf@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 3:36=E2=80=AFPM David Vernet <void@manifault.com> w=
rote:
>
> > It only supports atomic_add and no other atomics.
>
> Ahh, I misunderstood when I discussed with Kuba. I guess they supported
> only atomic_add because packets can be delivered out of order.

Not sure why it has anything to do with packets.

> So fair
> enough on that point, but I still stand by the claim though that if you
> need one type of atomic, it's reasonable to infer that you may need all
> of them. I would be curious to hear how much work it would have been to
> add support for the others. If there was an atomic conformance group,
> maybe they would have.

The netronome wasn't trying to offload this or that insn to be
in compliance. Together, netronome and bpf folks decided to focus
on a set of real XDP applications and try to offload as much as practical.
At that time there were -mcpu=3Dv1 and v2 insn sets only and offloading
wasn't really working well. alu32 in llvm, verifier and nfp was added
to make offload practical. Eventually it became -mcpu=3Dv3.
So compliance with any future group (basic, atomic, etc) in ISA cannot
be evaluated in isolation, because nfp is not compliant with -mcpu=3Dv4
and not compliant with -mcpu=3Dv1,
but works well with -mcpu=3Dv3 while v3 is an extension of v1 and v2.
Which is nonsensical from standard compliance pov.
netronome offload is a success because it demonstrated
how real production XDP applications can run in a NIC at speeds
that traditional CPUs cannot dream of.
It's a success despite the complexity and ugliness of BPF ISA.
It's working because practical applications compiled with -mcpu=3Dv3 produc=
e
"compliant enough" bpf code.

> Well, maybe not for Netronome, or maybe not even for any vendor (though
> we have no way of knowing that yet), but what about for other contexts
> like Windows / Linux cross-platform compat?

bpf on windows started similar to netronome. The goal was to
demonstrate real cilium progs running on windows. And it was done.
Since windows is a software there was no need to add or remove anything
from ISA, but due to licensing the prevail verifier had to be used which
doesn't support a whole bunch of things.
This software deficiencies of non-linux verifier shouldn't be
dictating grouping of the insns in the standard.
If linux can do it, windows should be able to do it just as well.
So I see no problem saying that bpf on windows will be non-compliant
until they support all of -mcpu=3Dv4 insns. It's a software project
with a deterministic timeline.

The standard should focus on compatibility between
HW-ish offloads where no amount of software can add support for
all of -mcpu=3Dv4.
And here I believe compliance with "basic" is not practical.
When nvme HW architects will get to implement "basic" ISA they might
realize that it has too much.
Producing "conformance groups" without HW folks thinking through the
implementation is not going to be a success.
I worry that it will have the opposite effect.
We'll have a standard with basic, atomic, etc.
Then folks will deliver this standard on the desk of HW architects.
They will give it a try and will reject the idea of implementing BPF in HW,
because not implementing "basic" would mean that this vendor
is not in compliance which means no business.
Hence the standard shouldn't overfocus on compliance and groups.
Just legacy and the rest will do for nvme.
legacy means "don't bother looking at those".
the rest means "pls implement these insns because they are useful,
their semantics and encoding is standardized,
but pick what makes sense for your use case and your HW".

And to make such HW offload a success we'd need to work together.
compiler, kernel, run-time, hw folks.
"Here is a standard. Go implement it" won't work.

