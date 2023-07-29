Return-Path: <bpf+bounces-6290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B35767953
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 02:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F641C21217
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB05C198;
	Sat, 29 Jul 2023 00:05:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C34B17E
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 00:05:15 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425093C24
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:05:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b933bbd3eeso40868231fa.1
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690589111; x=1691193911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQvl+XFQJV/FyplddWoLNv6tROKq+wIg/f+EmRjgswA=;
        b=INpmmkJTSjYfP8EzrNF6YpQv0P9Mk4UzqJzO4icSOsyTCY8iKTqFjGVlV+NxxFrmC8
         evjIOuO6ZMz5fr6BXnZsSnR2D1UNg66HhygdGVGi9qlYtmPdnCbjegLyRr/8sgWQNKua
         6r/iZS7QW6o7QaqUu0X7x8uiNGjNM4/GEXVI/zFSc1tyDd3dxXcp1KSa/tDkf6af+X1M
         57//edYa5Seb0QVOmhFB/5ENo9zt3KamVhituOL1yCqJMEkXIRe/J5I3JAYxPVGLCjN3
         AJvpFwgzeXyzSNU7rV8F8yWXX3s98ezQ2HEbIJclrQVq5yh6h5ZCQyxlRbdUzVc7xmja
         JiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690589111; x=1691193911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQvl+XFQJV/FyplddWoLNv6tROKq+wIg/f+EmRjgswA=;
        b=XD2wTd/HJrSjU/+/GnWQawK6CjXvtaRbBHttfAjLseUinn4Xi3WcoS6jAoO+3JmjnW
         qNtC0mGqUjUMYzWuLksKnsYdVG5atqW0cSS+DtxTdk4fc06+jiEllm5Ub5WKL78ucEfh
         RCC/yAbDSM1A/YtCc1Bif34ZOXN9OohuqTtTjdmwEDEiYUKX8ukqQJxdQsAm8P4RweEu
         7bzEnEEQS2dXY2ikF/1NHkunX/Ip5Sty47J0MjhVVMBtNua5nFVOBI5jfQX0Fz8M5BdL
         zTq/9i5eq23GUAQb+NeAJAuPhlo7FeXtGltCKrkD3fGGpjwNyUvgU7PLlMa5uCE17LGq
         5Wvg==
X-Gm-Message-State: ABy/qLZkPjMxfajOsEXs1t4qEMOwbOO7Esxm6Z3DNAh+FtpkJ/tXIvY6
	4ldKy8nYhbLOj28/vjeDEeW8onghUu6zhj2fGbc=
X-Google-Smtp-Source: APBJJlGxrbDavYSe9WYUqYj9Y9egecU1sNaONRWlrT90MspDEkfPoVyoyILOzZQL4X+K8o2o3te54aHs68QridEJgbA=
X-Received: by 2002:a2e:98c2:0:b0:2b6:9ed0:46f4 with SMTP id
 s2-20020a2e98c2000000b002b69ed046f4mr2861634ljj.23.1690589111218; Fri, 28 Jul
 2023 17:05:11 -0700 (PDT)
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
 <CADx9qWi+VQ=do+_Bsd8W4Yc-S1LekVq7Hp4bfD3nz0YP47Sqgg@mail.gmail.com>
 <CAADnVQ+5d8ztfFLraWnZKszAX23Z-12=pHjJfufNbd3qzWVNsQ@mail.gmail.com> <CADx9qWhSqb6xAP=nz5N-vmd2N3+h4TBFtFOGdJUWNfX=LapEBw@mail.gmail.com>
In-Reply-To: <CADx9qWhSqb6xAP=nz5N-vmd2N3+h4TBFtFOGdJUWNfX=LapEBw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 28 Jul 2023 17:04:59 -0700
Message-ID: <CAADnVQJ4yzDc0qQExLUO1b23ndEiEjnYYPv5qC7JJYmLr4X3ew@mail.gmail.com>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
To: Will Hawkins <hawkinsw@obs.cr>
Cc: Watson Ladd <watsonbladd@gmail.com>, Dave Thaler <dthaler@microsoft.com>, 
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 4:32=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wrot=
e:
>
> On Thu, Jul 27, 2023 at 9:05=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Jul 26, 2023 at 12:16=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr>=
 wrote:
> > >
> > > On Tue, Jul 25, 2023 at 2:37=E2=80=AFPM Watson Ladd <watsonbladd@gmai=
l.com> wrote:
> > > >
> > > > On Tue, Jul 25, 2023 at 9:15=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Tue, Jul 25, 2023 at 7:03=E2=80=AFAM Dave Thaler <dthaler@micr=
osoft.com> wrote:
> > > > > >
> > > > > > I am forwarding the email below (after converting HTML to plain=
 text)
> > > > > > to the mailto:bpf@vger.kernel.org list so replies can go to bot=
h lists.
> > > > > >
> > > > > > Please use this one for any replies.
> > > > > >
> > > > > > Thanks,
> > > > > > Dave
> > > > > >
> > > > > > > From: Bpf <bpf-bounces@ietf.org> On Behalf Of Watson Ladd
> > > > > > > Sent: Monday, July 24, 2023 10:05 PM
> > > > > > > To: bpf@ietf.org
> > > > > > > Subject: [Bpf] Review of draft-thaler-bpf-isa-01
> > > > > > >
> > > > > > > Dear BPF wg,
> > > > > > >
> > > > > > > I took a look at the draft and think it has some issues, unsu=
rprisingly at this stage. One is
> > > > > > > the specification seems to use an underspecified C pseudo cod=
e for operations vs
> > > > > > > defining them mathematically.
> > > > >
> > > > > Hi Watson,
> > > > >
> > > > > This is not "underspecified C" pseudo code.
> > > > > This is assembly syntax parsed and emitted by GCC, LLVM, gas, Lin=
ux Kernel, etc.
> > > >
> > > > I don't see a reference to any description of that in section 4.1.
> > > > It's possible I've overlooked this, and if people think this style =
of
> > > > definition is good enough that works for me. But I found table 4
> > > > pretty scanty on what exactly happens.
> > >
> > > Hello! Based on Watson's post, I have done some research and would
> > > potentially like to offer a path forward. There are several different
> > > ways that ISAs specify the semantics of their operations:
> > >
> > > 1. Intel has a section in their manual that describes the pseudocode
> > > they use to specify their ISA: Section 3.1.1.9 of The Intel=C2=AE 64 =
and
> > > IA-32 Architectures Software Developer=E2=80=99s Manual at
> > > https://cdrdv2.intel.com/v1/dl/getContent/671199
> > > 2. ARM has an equivalent for their variety of pseudocode: Chapter J1
> > > of Arm Architecture Reference Manual for A-profile architecture at
> > > https://developer.arm.com/documentation/ddi0487/latest/
> > > 3. Sail "is a language for describing the instruction-set architectur=
e
> > > (ISA) semantics of processors."
> > > (https://www.cl.cam.ac.uk/~pes20/sail/)
> > >
> > > Given the commercial nature of (1) and (2), perhaps Sail is a way to
> > > proceed. If people are interested, I would be happy to lead an effort
> > > to encode the eBPF ISA semantics in Sail (or find someone who already
> > > has) and incorporate them in the draft.
> >
> > imo Sail is too researchy to have practical use.
> > Looking at arm64 or x86 Sail description I really don't see how
> > it would map to an IETF standard.
> > It's done in a "sail" language that people need to learn first to be
> > able to read it.
> > Say we had bpf.sail somewhere on github. What value does it bring to
> > BPF ISA standard? I don't see an immediate benefit to standardization.
> > There could be other use cases, no doubt, but standardization is our go=
al.
> >
> > As far as 1 and 2. Intel and Arm use their own pseudocode, so they had
> > to add a paragraph to describe it. We are using C to describe BPF ISA
>
>
> I cannot find a reference in the current version that specifies what
> we are using to describe the operations. I'd like to add that, but
> want to make sure that I clarify two statements that seem to be at
> odds.
>
> Immediately above you say that we are using "C to describe the BPF
> ISA" and further above you say "This is assembly syntax parsed and
> emitted by GCC, LLVM, gas, Linux Kernel, etc."
>
> My own reading is that it is the former, and not the latter. But, I
> want to double check before adding the appropriate statements to the
> Convention section.

It's both. I'm not sure where you see a contradiction.
It's a normal C syntax and it's emitted by the kernel verifier,
parsed by clang/gcc assemblers and emitted by compilers.

