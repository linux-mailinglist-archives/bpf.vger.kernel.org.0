Return-Path: <bpf+bounces-6282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8006767916
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 01:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8391C281E1D
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 23:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5642E20F9F;
	Fri, 28 Jul 2023 23:33:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D310525C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 23:32:59 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD7E3AB4
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:32:58 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-63cf7cce5fbso16463576d6.0
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1690587177; x=1691191977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxCTFaHrTVESGNYLRZvUe6lEIyuB/4+fv2YbMx/txfo=;
        b=tQtVLDq+kn+5hyaQZfNyV7++oK/YuKSIPWq9JIXwMFpbtUYCDBT2y7lhl6ecKVhXGw
         ocZhTmhU/QNPcnn8uobWaDU99FGN1wN44SBbVbGZy+0wLxGScXEEMJoSJtSRZ7s3DN66
         Bs3IzWZf3W0jXLPm/7Of4LkQlD/XKD83D351rTrpXBnJ3bmexfYhC29ioPgBTcq72pqA
         2MZzDtspuLxacRACb+G2k4ayRerosVDdtqqzQVGa5lmgtA/cUYB88JenuEn2NH6z4eSs
         DKOtCPV1HeAZ0EEy35vMeaw+pbQdfwEd2amjDpWgtt+dTuod2MxClmMNMuSe2aDS+ZOd
         FHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690587177; x=1691191977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxCTFaHrTVESGNYLRZvUe6lEIyuB/4+fv2YbMx/txfo=;
        b=dBslJ9TJLxVIurY8IE2lG9Q7mA0i9SSlxd0Ok3GocuSz0GJVhUQDkzD8H5c/yBw+rO
         zK7QvnRvog5EPcgPWbOKQsm0maV24DBwwVzUyuaQAjXlesVpK7KPopcymEBTm8nhKq7n
         PwGsHxDvqZdMPU8oFG6a88mD6TNn3HVt89xwy8TIT8hC89c01xHMh+lR83BnI6FNsl9F
         PqBmzFY7boRTYZuuh3gjUoAz/OE4K0sT6+rSLEPfHLxrmuM1uBZEGdKvIpQ+vhCK/Wt0
         sEwt/cp9jXD2zUqZViBhLpaxDMG4C4ztjS6Inu6ucFh4IVHl0ndbfMqGtUIV47ybX6vz
         +Avw==
X-Gm-Message-State: ABy/qLYVK83+k/kaLLRUU+xezFi5lYFiTgAgDy9Qzkipt3EPI1ChRyRq
	NqduoPcl4LXfSCZvSOxlxmxah8euBdGM4cfJ3jlPswEzfjKmHPWBN/o=
X-Google-Smtp-Source: APBJJlG/UEmQb5AeCTAQMFHj1XH7vGtnuyHr1Tk+quU5votGceS8nN2xWPHUihBJ3jLdUlSUSSFXz+jOOn0lPBlTRuI=
X-Received: by 2002:a05:6214:57c8:b0:63d:311f:c901 with SMTP id
 lw8-20020a05621457c800b0063d311fc901mr4002385qvb.34.1690587177470; Fri, 28
 Jul 2023 16:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CADx9qWi+VQ=do+_Bsd8W4Yc-S1LekVq7Hp4bfD3nz0YP47Sqgg@mail.gmail.com> <CAADnVQ+5d8ztfFLraWnZKszAX23Z-12=pHjJfufNbd3qzWVNsQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+5d8ztfFLraWnZKszAX23Z-12=pHjJfufNbd3qzWVNsQ@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Fri, 28 Jul 2023 19:32:46 -0400
Message-ID: <CADx9qWhSqb6xAP=nz5N-vmd2N3+h4TBFtFOGdJUWNfX=LapEBw@mail.gmail.com>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 9:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jul 26, 2023 at 12:16=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> w=
rote:
> >
> > On Tue, Jul 25, 2023 at 2:37=E2=80=AFPM Watson Ladd <watsonbladd@gmail.=
com> wrote:
> > >
> > > On Tue, Jul 25, 2023 at 9:15=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Tue, Jul 25, 2023 at 7:03=E2=80=AFAM Dave Thaler <dthaler@micros=
oft.com> wrote:
> > > > >
> > > > > I am forwarding the email below (after converting HTML to plain t=
ext)
> > > > > to the mailto:bpf@vger.kernel.org list so replies can go to both =
lists.
> > > > >
> > > > > Please use this one for any replies.
> > > > >
> > > > > Thanks,
> > > > > Dave
> > > > >
> > > > > > From: Bpf <bpf-bounces@ietf.org> On Behalf Of Watson Ladd
> > > > > > Sent: Monday, July 24, 2023 10:05 PM
> > > > > > To: bpf@ietf.org
> > > > > > Subject: [Bpf] Review of draft-thaler-bpf-isa-01
> > > > > >
> > > > > > Dear BPF wg,
> > > > > >
> > > > > > I took a look at the draft and think it has some issues, unsurp=
risingly at this stage. One is
> > > > > > the specification seems to use an underspecified C pseudo code =
for operations vs
> > > > > > defining them mathematically.
> > > >
> > > > Hi Watson,
> > > >
> > > > This is not "underspecified C" pseudo code.
> > > > This is assembly syntax parsed and emitted by GCC, LLVM, gas, Linux=
 Kernel, etc.
> > >
> > > I don't see a reference to any description of that in section 4.1.
> > > It's possible I've overlooked this, and if people think this style of
> > > definition is good enough that works for me. But I found table 4
> > > pretty scanty on what exactly happens.
> >
> > Hello! Based on Watson's post, I have done some research and would
> > potentially like to offer a path forward. There are several different
> > ways that ISAs specify the semantics of their operations:
> >
> > 1. Intel has a section in their manual that describes the pseudocode
> > they use to specify their ISA: Section 3.1.1.9 of The Intel=C2=AE 64 an=
d
> > IA-32 Architectures Software Developer=E2=80=99s Manual at
> > https://cdrdv2.intel.com/v1/dl/getContent/671199
> > 2. ARM has an equivalent for their variety of pseudocode: Chapter J1
> > of Arm Architecture Reference Manual for A-profile architecture at
> > https://developer.arm.com/documentation/ddi0487/latest/
> > 3. Sail "is a language for describing the instruction-set architecture
> > (ISA) semantics of processors."
> > (https://www.cl.cam.ac.uk/~pes20/sail/)
> >
> > Given the commercial nature of (1) and (2), perhaps Sail is a way to
> > proceed. If people are interested, I would be happy to lead an effort
> > to encode the eBPF ISA semantics in Sail (or find someone who already
> > has) and incorporate them in the draft.
>
> imo Sail is too researchy to have practical use.
> Looking at arm64 or x86 Sail description I really don't see how
> it would map to an IETF standard.
> It's done in a "sail" language that people need to learn first to be
> able to read it.
> Say we had bpf.sail somewhere on github. What value does it bring to
> BPF ISA standard? I don't see an immediate benefit to standardization.
> There could be other use cases, no doubt, but standardization is our goal=
.
>
> As far as 1 and 2. Intel and Arm use their own pseudocode, so they had
> to add a paragraph to describe it. We are using C to describe BPF ISA


I cannot find a reference in the current version that specifies what
we are using to describe the operations. I'd like to add that, but
want to make sure that I clarify two statements that seem to be at
odds.

Immediately above you say that we are using "C to describe the BPF
ISA" and further above you say "This is assembly syntax parsed and
emitted by GCC, LLVM, gas, Linux Kernel, etc."

My own reading is that it is the former, and not the latter. But, I
want to double check before adding the appropriate statements to the
Convention section.

Will

> semantics. I don't think we need to explain C in the BPF ISA doc.
> The only exception is "s>=3D", but it is explained in the doc already.

