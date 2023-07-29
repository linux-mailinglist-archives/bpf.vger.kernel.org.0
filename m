Return-Path: <bpf+bounces-6298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358477679FE
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 02:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C4E281E34
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 00:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E0A642;
	Sat, 29 Jul 2023 00:48:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BF27C
	for <bpf@vger.kernel.org>; Sat, 29 Jul 2023 00:48:03 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32F6449C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:47:32 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6378cec43ddso15805466d6.2
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1690591591; x=1691196391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnQ1pJAtnegsZHOqhcVYr5A/jKjI0nebfK5TPS3lN5Y=;
        b=NJRPXOAhlRbmxABzgCbhiIvwMb7yJMoMSWa/FAlShGX6sNXHWAiz1UljJZkiok/ZcX
         7QmblUkVs4g7mFZ9sDAKy5WXELyQnt36mb3BOearoV8vOW1zNYcpNRPy5H2rc6PvkyCj
         YGror3jwIggUoDXF5rVqjKrWc+OK8ulc6aZ25qET7fjmA0dCuJntQ3mwcIhTgHOAjr20
         ONG6GQ/q7wu33hGrYEImMvgR6D+X2zqprAmjMNy0rbJxIsxpf6bwV3UYNi8RI9EbhIdJ
         CiiLtmil6hjK8kAVq7bnofclr+pGMJsHw01IqtOOPI/I5boI5lmn02jjpWMdcn97eZFz
         +O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591591; x=1691196391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnQ1pJAtnegsZHOqhcVYr5A/jKjI0nebfK5TPS3lN5Y=;
        b=F4pQxtZl/tEIheLtCE73rCpGtnCmmps6//cbh+Qz+47ezW9O9Pj1aA7vVpqhbyu6O+
         EwsUCazlpTXZxBfIhhar0ciDWMustZ2tsd3l4+9WOEibc7c8zcGhEEqtUF0XymlgieBD
         B+BCj52mgMgnbWVWEL6eD6HuNfB1TyDnCYb4VII2eYhvgqHDAIPvvIJmV+eJJqAflTYB
         tzgyuZDHGwn/l/AtJvEHQzCcPfwsM6oLaHXnqyVpWObGjnIqFuIP5zx7P+JNZP1rNR45
         QjgMs4F9PRfKNzUpd6uBX9IzKT6qD4XozfXFU7YVlRcJVhFbq0e/KhgY08g/3g2dUEVm
         jeHQ==
X-Gm-Message-State: ABy/qLY/PttZ8hD7q5Ed0W9slwg03HnzzFfhg9IsF0wBBe2sFI1PzQPx
	riNbF1qnpG0eFrFwut0u6WuDthMfig3r9mKTsPjibORZqJDVKDNgD4U=
X-Google-Smtp-Source: APBJJlHfHAOftx+trekNjTBM4bPEeqf0DtP5xzoraFGp9Xm4G/25kuzQ1Fw2DMfRsazVeCyK95AELwH6kiLFQfPkiAM=
X-Received: by 2002:a05:6214:5b0e:b0:632:15e6:a75e with SMTP id
 ma14-20020a0562145b0e00b0063215e6a75emr4015677qvb.46.1690591590888; Fri, 28
 Jul 2023 17:46:30 -0700 (PDT)
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
 <CAADnVQ+5d8ztfFLraWnZKszAX23Z-12=pHjJfufNbd3qzWVNsQ@mail.gmail.com>
 <CADx9qWhSqb6xAP=nz5N-vmd2N3+h4TBFtFOGdJUWNfX=LapEBw@mail.gmail.com>
 <CAADnVQJ4yzDc0qQExLUO1b23ndEiEjnYYPv5qC7JJYmLr4X3ew@mail.gmail.com>
 <CADx9qWh6ZUKvjkZow6=eB4gvEgP82mBqn+mMZvmDQynCYAfMWw@mail.gmail.com> <CAADnVQKOiwm1UB58=8QcowDyfPQct-wuMD19citS7w5PmadZ6g@mail.gmail.com>
In-Reply-To: <CAADnVQKOiwm1UB58=8QcowDyfPQct-wuMD19citS7w5PmadZ6g@mail.gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Fri, 28 Jul 2023 20:46:19 -0400
Message-ID: <CADx9qWjYChRf2qBr=Pt5D-RLCb665YFKmjDYX8WOQfqMx1-bag@mail.gmail.com>
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

On Fri, Jul 28, 2023 at 8:35=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jul 28, 2023 at 5:19=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr> wr=
ote:
> >
> > On Fri, Jul 28, 2023 at 8:05=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jul 28, 2023 at 4:32=E2=80=AFPM Will Hawkins <hawkinsw@obs.cr=
> wrote:
> > > >
> > > > On Thu, Jul 27, 2023 at 9:05=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Wed, Jul 26, 2023 at 12:16=E2=80=AFPM Will Hawkins <hawkinsw@o=
bs.cr> wrote:
> > > > > >
> > > > > > On Tue, Jul 25, 2023 at 2:37=E2=80=AFPM Watson Ladd <watsonblad=
d@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jul 25, 2023 at 9:15=E2=80=AFAM Alexei Starovoitov
> > > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jul 25, 2023 at 7:03=E2=80=AFAM Dave Thaler <dthale=
r@microsoft.com> wrote:
> > > > > > > > >
> > > > > > > > > I am forwarding the email below (after converting HTML to=
 plain text)
> > > > > > > > > to the mailto:bpf@vger.kernel.org list so replies can go =
to both lists.
> > > > > > > > >
> > > > > > > > > Please use this one for any replies.
> > > > > > > > >
> > > > > > > > > Thanks,
> > > > > > > > > Dave
> > > > > > > > >
> > > > > > > > > > From: Bpf <bpf-bounces@ietf.org> On Behalf Of Watson La=
dd
> > > > > > > > > > Sent: Monday, July 24, 2023 10:05 PM
> > > > > > > > > > To: bpf@ietf.org
> > > > > > > > > > Subject: [Bpf] Review of draft-thaler-bpf-isa-01
> > > > > > > > > >
> > > > > > > > > > Dear BPF wg,
> > > > > > > > > >
> > > > > > > > > > I took a look at the draft and think it has some issues=
, unsurprisingly at this stage. One is
> > > > > > > > > > the specification seems to use an underspecified C pseu=
do code for operations vs
> > > > > > > > > > defining them mathematically.
> > > > > > > >
> > > > > > > > Hi Watson,
> > > > > > > >
> > > > > > > > This is not "underspecified C" pseudo code.
> > > > > > > > This is assembly syntax parsed and emitted by GCC, LLVM, ga=
s, Linux Kernel, etc.
> > > > > > >
> > > > > > > I don't see a reference to any description of that in section=
 4.1.
> > > > > > > It's possible I've overlooked this, and if people think this =
style of
> > > > > > > definition is good enough that works for me. But I found tabl=
e 4
> > > > > > > pretty scanty on what exactly happens.
> > > > > >
> > > > > > Hello! Based on Watson's post, I have done some research and wo=
uld
> > > > > > potentially like to offer a path forward. There are several dif=
ferent
> > > > > > ways that ISAs specify the semantics of their operations:
> > > > > >
> > > > > > 1. Intel has a section in their manual that describes the pseud=
ocode
> > > > > > they use to specify their ISA: Section 3.1.1.9 of The Intel=C2=
=AE 64 and
> > > > > > IA-32 Architectures Software Developer=E2=80=99s Manual at
> > > > > > https://cdrdv2.intel.com/v1/dl/getContent/671199
> > > > > > 2. ARM has an equivalent for their variety of pseudocode: Chapt=
er J1
> > > > > > of Arm Architecture Reference Manual for A-profile architecture=
 at
> > > > > > https://developer.arm.com/documentation/ddi0487/latest/
> > > > > > 3. Sail "is a language for describing the instruction-set archi=
tecture
> > > > > > (ISA) semantics of processors."
> > > > > > (https://www.cl.cam.ac.uk/~pes20/sail/)
> > > > > >
> > > > > > Given the commercial nature of (1) and (2), perhaps Sail is a w=
ay to
> > > > > > proceed. If people are interested, I would be happy to lead an =
effort
> > > > > > to encode the eBPF ISA semantics in Sail (or find someone who a=
lready
> > > > > > has) and incorporate them in the draft.
> > > > >
> > > > > imo Sail is too researchy to have practical use.
> > > > > Looking at arm64 or x86 Sail description I really don't see how
> > > > > it would map to an IETF standard.
> > > > > It's done in a "sail" language that people need to learn first to=
 be
> > > > > able to read it.
> > > > > Say we had bpf.sail somewhere on github. What value does it bring=
 to
> > > > > BPF ISA standard? I don't see an immediate benefit to standardiza=
tion.
> > > > > There could be other use cases, no doubt, but standardization is =
our goal.
> > > > >
> > > > > As far as 1 and 2. Intel and Arm use their own pseudocode, so the=
y had
> > > > > to add a paragraph to describe it. We are using C to describe BPF=
 ISA
> > > >
> > > >
> > > > I cannot find a reference in the current version that specifies wha=
t
> > > > we are using to describe the operations. I'd like to add that, but
> > > > want to make sure that I clarify two statements that seem to be at
> > > > odds.
> > > >
> > > > Immediately above you say that we are using "C to describe the BPF
> > > > ISA" and further above you say "This is assembly syntax parsed and
> > > > emitted by GCC, LLVM, gas, Linux Kernel, etc."
> > > >
> > > > My own reading is that it is the former, and not the latter. But, I
> > > > want to double check before adding the appropriate statements to th=
e
> > > > Convention section.
> > >
> > > It's both. I'm not sure where you see a contradiction.
> > > It's a normal C syntax and it's emitted by the kernel verifier,
> > > parsed by clang/gcc assemblers and emitted by compilers.
> >
> >
> > Okay. I apologize. I am sincerely confused. For instance,
> >
> > if (u32)dst >=3D (u32)src goto +offset
> >
> > Looks like nothing that I have ever seen in "normal C syntax".
>
> I thought we're talking about table 4 and ALU ops.
> Above is not a pure C, but it's obvious enough without explanation, no?

To "us", yes. Although I am not an expert, it seems like being
explicit is important when it comes to writing a spec. I suppose we
should leave that to Dave and the chairs.

> Also I don't see above anywhere in the doc.

That is from the Appendix. It is currently in Dave's tree and gets
amalgamated with other files to build the final draft.

https://datatracker.ietf.org/doc/draft-thaler-bpf-isa/

> We describe conditionals like:
> BPF_JGE   0x3    any  PC +=3D offset if dst >=3D src
>
> > There also appear to be a few other places where things might be a bit =
wonky:
> >
> > 1. Address arithmetic in the description of the load/store
> > instructions will depend on the type of the target: E.g.,
> >
> > *(u64 *)(dst + offset) =3D imm
> >
> > The address to which the store is done will be offset*sizeof(X) bytes
> > from dst where X is the type of the target of dst. If we are assuming
> > that dst (or its equivalent in similar instructions) is being treated
> > simply as an unsigned integer, I believe that we will have to say that
> > explicitly, especially given that we describe offset as "signed
> > integer offset used with pointer arithmetic" in the Instruction
> > encoding section.
>
> It's not:
> *((u64 *)(dst) + offset) =3D imm
>
> The doc doesn't say that 'dst' is a pointer 'u64 *dst' type.
> Instead it says:
> --
> The 'code' field encodes the operation as below, where 'src' and 'dst' re=
fer
> to the values of the source and destination registers, respectively.
> --
>
> so dst + offset is a plain addition of two values and then type cast.

Again I of course understand and "we" know what that means. However,
it seems to me that an earlier description of offset as "signed
integer offset used with pointer arithmetic" might signal something
else to an unfamiliar reader.

Will

>
> >
> > 2. hto[bl]eN functions are not specified by standard C and, while
> > "obvious" what they do, are not defined in the document anywhere.
>
> yeah. we can add a short sentence about htoln.

