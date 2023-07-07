Return-Path: <bpf+bounces-4438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9512E74B4E5
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2FF2817A1
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 16:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6BC10940;
	Fri,  7 Jul 2023 16:08:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D67D1FA7
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 16:08:02 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D79B1FE0
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:08:00 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6237faa8677so12311896d6.1
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 09:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1688746079; x=1691338079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWM0laKU80a42A/voRGaDlLTH+dN0QntMFG+DQux1v8=;
        b=Fafnh3WXK8/J6hqhkU4urJnRZCboyP2SkMD1CqUZ8p/k1nhNupKjF3Ee49qoDRo7Ut
         WCbrsJE7nHTvhus0g0lRIKpUXtpKRMA1pP2DVAJJls6OXEHbTqyPDo6RUN45TnTHp8IN
         ZnPKwETx60jZ+q86v7T9s5PcqPOdTpdvBnSboP33rKDECUjBPTCoJm+W4mMlFsNi/+KL
         6IAwZXumwMnumlq85TEJQwVs1EIvyVJuRCcyjNY9ro2qcNepV2DiVPmMPybApD2uVJ09
         IhFUKgmzfRf1dYzGOR1G7qiY17hutm+1op7p7vCrHryszkbFZFrJHJrruKPdp8TGurH/
         g+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688746079; x=1691338079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWM0laKU80a42A/voRGaDlLTH+dN0QntMFG+DQux1v8=;
        b=TMpgRvUywebHAxTbHNMkf284p1nkX3GA/hHq1j9iW5jZ4oB5IHcMeRKOUe8gGTxWj2
         lex48CE9zKyNwifJLLfB1JwTuOsGPl9FdGbYDdOR7hXpBOGhlALbw9MtN1aJrDANwL0b
         7AOYQs3aqt/yPP8xoD+VBan0OWo5Ezr1pOpavxn9XvLixQMO8luJOeBqHGsoUT/AtwZ9
         8TviCvqK5gLgsCmKQZVOpjOh+92A9FeIKuE92Vl0BEf/GeYxvUFFKptmSgvc9W/zjXbL
         saRdlNMCB+TcL0itVyjmLESSCNBNzmiRdGnJfibjUfoDzwr+BKRmuduSTW9XFKE4mCzD
         DD7g==
X-Gm-Message-State: ABy/qLaIv0QRCdOYK0CVp2l3dHhqJ2KS+tj5YMb41LrpsgEcON7BOMfy
	saIJDy6ww7dI2ksjqgyCToAbJwb8W7w8FajzoM387Q==
X-Google-Smtp-Source: APBJJlF9hwu/9AwIb6dn0bq9nl9llGXQ1RQJ4cmdTWdHnoR0qV3DOtzTpeyISMnSATqCOmyaDpPHAX8GnrXYAJYK9nk=
X-Received: by 2002:a0c:8b8a:0:b0:635:de52:8383 with SMTP id
 r10-20020a0c8b8a000000b00635de528383mr3902296qva.59.1688746079123; Fri, 07
 Jul 2023 09:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJhfa+g227BX=3LijoXwgh7h3Z5V_ZF8tMeMWNZguAp5g@mail.gmail.com>
 <PH7PR21MB3878DEA7280C274A8A18D082A32DA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQ+ogOVdwZSX4315hHe8bxP-yoYEacNPCP6CTHqn=Xp-uQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+ogOVdwZSX4315hHe8bxP-yoYEacNPCP6CTHqn=Xp-uQ@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Fri, 7 Jul 2023 12:07:48 -0400
Message-ID: <CADx9qWjUj5YP6Dr9g2GY6Yrf4-1K+5-v6wE6gYV_R9e3OjBnLw@mail.gmail.com>
Subject: Re: [Bpf] Instruction set extension policy
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler@microsoft.com>, "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 7, 2023 at 12:01=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 6, 2023 at 6:35=E2=80=AFPM Dave Thaler <dthaler@microsoft.com=
> wrote:
> >
> > I don't see any problem with defining an IANA registry with multiple "k=
ey" fields
> > (opcode+src+imm).  All existing instructions can be done as such.
> >
> > Below is strawman text that I think follows IANA's requirements outline=
d
> > in RFC 8126...
> >
> > -Dave
> >
> > --- snip ---
> > IANA Considerations
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This document proposes a new IANA registry for BPF instructions, as fol=
lows:
> >
> > * Name of the registry: BPF Instruction Set
> > * Name of the registry group: same as registry name
> > * Required information for registrations: The values to appear in the e=
ntry fields.
> > * Syntax of registry entries: Each entry has the following fields:
> >   * opcode: a 1-byte value in hex format indicating the value of the op=
code field
> >   * src: a 4-bit value in hex format indicating the value of the src fi=
eld, or "any"
> >   * imm: either a value in hex format indicating the value of the imm f=
ield, or "any"
> >   * description: description of what the instruction does, typically in=
 pseudocode
> >   * reference: a reference to the defining specification
> >   * status: Permanent, Provisional, or Historical
> > * Registration policy (see RFC 8126 section 4 for details):
> >   * Permanent: Standards action
> >   * Provisional: Specification required
> >   * Historical: Specification required
> > * Initial registrations: See the Appendix. Instructions other than thos=
e listed
> >   as deprecated are Permanent. Any listed as deprecated are Historical.
>
> I think that might work. What is the next step then?
> Who is going to generate such a hex database?

I would be more than happy to do that!
Will

>
> --
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

