Return-Path: <bpf+bounces-1125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1343370E5DA
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 21:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D097E1C20D05
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 19:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF6C21CE9;
	Tue, 23 May 2023 19:42:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3061F934
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 19:42:17 +0000 (UTC)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631868F
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 12:42:15 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-4572fc781daso70141e0c.2
        for <bpf@vger.kernel.org>; Tue, 23 May 2023 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684870934; x=1687462934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XW4S8/5axXkLQBPo3PMevs9zQMqBWRjleyC7QiXziiU=;
        b=IaVeWnJnKMuIvsYV96OqSC5+ZDVceAvzoYY3ITeCZ/sADIvzkQ3IAJ3b4eLXQQmy9J
         ea6hNRdtGIPBrzvCV31TWWvMBwIAmIsdLap4bvNzLRMTCl7RhEmQg8BImX1yPBh8e/tO
         JDcRWZ0kOUpCi5uuypUxMZqjVAsOoBBlBGwu4IO8gqGBY/oL0R6WueJ6yS0HA8A4vCKb
         Hxbv7zmZrGubiMBk5p7tvW63UCvx65fBuQjzKu5pvlDssolT2ddBCn4jy3fsdWwSar+f
         vRthR43TYnNgl61Clx4/G+z5gQ0bO6cIk36/aSRxb5mspJwuewRoAWrTiYOpMDn3VTno
         0CDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870934; x=1687462934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XW4S8/5axXkLQBPo3PMevs9zQMqBWRjleyC7QiXziiU=;
        b=CT08scgfIN7qM6VjbTlzOCUAgmBJRbuYAUweupC4TX+dk5QNf5Kz3EfMa7W5wYOplc
         uQnJ4XcxkpM65n3HGvcIR/eFXvWVGMUC8opzhOtuoSy0SL7nPZU9zbnWs54gCwIB62jj
         vVa4WWmoG/+KmfTXJCmd6hGsZ+fHeM+l0hH3VGb4MFY255MNIrqvfwPIvfJOFj0tpVzt
         0kP/Eho6+TFEya7Ok7jGfwxwv2YuDi3zTnAc8EHR0szwiXGOMzlUT1t0LC9ncVrn5kQz
         skdKOXyM0rJreFJsm2bwICTZ0m+sdY5WJ2MUyhIdolN1sgkGvRGf3+XSU8Uk3cD+WPGO
         jk0w==
X-Gm-Message-State: AC+VfDya+Z5my1eOto5fICVUSKMx53rjUS9uBUy/GWW4wiGWboHL2NqX
	AknMTgEDhkEJqYHaCUeTJM9YfGyOYXUDyMtEayE=
X-Google-Smtp-Source: ACHHUZ7caSKQCdas5kQndA8od3SkfupivrXiyx+iASBrS2g1h4hVFCchn/Yh3ynvZTAEJCmPUJWHtGCAbQnynW23YGw=
X-Received: by 2002:a05:6102:2f4:b0:437:e5d1:a0e0 with SMTP id
 j20-20020a05610202f400b00437e5d1a0e0mr4526592vsj.19.1684870934366; Tue, 23
 May 2023 12:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org> <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org> <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge> <PH7PR21MB3878A4135C14B318DD43365CA340A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523171535.GE20100@maniforge> <20230523190814.GA32582@maniforge>
In-Reply-To: <20230523190814.GA32582@maniforge>
From: Erik Kline <ek.ietf@gmail.com>
Date: Tue, 23 May 2023 12:42:03 -0700
Message-ID: <CAMGpriVpc5qdtqAObO1nu64kidt6C4UFp_FJ_Ht+DThMHNX-CQ@mail.gmail.com>
Subject: Re: [Bpf] IETF BPF working group draft charter
To: David Vernet <void@manifault.com>
Cc: Dave Thaler <dthaler@microsoft.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>, 
	"Suresh Krishnan (sureshk)" <sureshk@cisco.com>, Christoph Hellwig <hch@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

how about if we pull ABI but leave ELF?

On Tue, May 23, 2023 at 12:08=E2=80=AFPM David Vernet <void@manifault.com> =
wrote:
>
> On Tue, May 23, 2023 at 12:15:35PM -0500, David Vernet wrote:
> > On Tue, May 23, 2023 at 04:50:42PM +0000, Dave Thaler wrote:
> > > > -----Original Message-----
> > > > From: David Vernet <void@manifault.com>
> > > > Sent: Tuesday, May 23, 2023 9:32 AM
> > > > To: Dave Thaler <dthaler@microsoft.com>
> > > > Cc: Jose E. Marchesi <jemarch@gnu.org>; bpf@ietf.org; bpf
> > > > <bpf@vger.kernel.org>; Erik Kline <ek.ietf@gmail.com>; Suresh Krish=
nan
> > > > (sureshk) <sureshk@cisco.com>; Christoph Hellwig <hch@infradead.org=
>;
> > > > Alexei Starovoitov <ast@kernel.org>
> > > > Subject: Re: [Bpf] IETF BPF working group draft charter
> > > >
> > > > On Thu, May 18, 2023 at 07:42:11PM +0000, Dave Thaler wrote:
> > > > > Jose E. Marchesi <jemarch@gnu.org> wrote:
> > > > > > I would think that the way the x86_64, aarch64, risc-v, sparc, =
mips,
> > > > > > powerpc architectures, along with their variants, handle their =
ELF
> > > > > > extensions and psABI, ensures interoperability good enough for =
the
> > > > problem at hand, but ok.
> > > > > > I'm definitely not an expert in these matters.
> > > > >
> > > > > I am not familiar enough with those to make any comment about tha=
t.
> > > >
> > > > Hi Dave,
> > > >
> > > > Taking a step back here, perhaps we need to think about all of this=
 more
> > > > generically as "ABI", rather than ELF "extensions", "bindings", etc=
.  In my
> > > > opinion this would include, at a minimum, the following items from =
the current
> > > > proposed WG charter:
> > > >
> > > > * the eBPF bindings for the ELF executable file format,
> > > >
> > > > * the platform support ABI, including calling convention, linker
> > > >   requirements, and relocations,
> > > >
> > > > As far as I know (please correct me if I'm wrong), there isn't real=
ly a precedence
> > > > for standardizing ABIs like this. For example, x86 calling conventi=
ons are not
> > > > standardized.  Solaris, Linux, FreeBSD, macOS, etc all follow the S=
ystem V
> > > > AMD64 ABI, but Microsoft of course does not. As Jose pointed out, s=
uch
> > > > standards extensions do not exist for psABI ELF extensions for vari=
ous
> > > > architectures either.
> > > >
> > > > While it may be that we do end up needing to standardize these ABIs=
 for BPF,
> > > > I'm beginning to think that we should just remove them from the cur=
rent WG
> > > > charter, and consider standardizing them at a later time if it's cl=
ear that it's
> > > > actually necessary. I think this is especially true given that we d=
on't seem to be
> > > > getting any closer to having consensus, and that we're very short o=
n time given
> > > > that Erik is going to be proposing the charter to the rest of the A=
Ds in just two
> > > > days on 5/25.
> > > >
> > > > Thanks,
> > > > David
> > >
> > > I can tell you it's very important to those who work on the ebpf-for-=
windows project that the ELF format is common between Linux and Windows so =
that tools like
> > > llvm-objdump and bpftool and other BPF-specific ELF parsing tools wor=
k for both
> > > Linux and Windows.   We don't want Windows to diverge.
> >
> > Be that as it may, as I said before, to my knowledge there's no
> > precedence at all for standardizing ABI like this. Is there a reason
> > that you think Windows would diverge if we didn't standardize the ABI?
> >
> > I realize that I'm essentially saying, "Hey, pretend there's a standard
> > and don't diverge", but if that's what the entire rest of the industry
> > has done up until this point with all other psABIs, then it seems like =
a
> > reasonable expectation.
> >
> > > As such, I feel strongly that it is a requirement to be standardized =
right away.
> >
> > I have to respectfully disagree. I think there are much bigger fish to
> > fry, such as standardizing the ISA. Unless we really have a good reason
> > for diverging from industry norms, standardizing on ABI now feels to me
> > like we're putting the cart before the horse.
>
> Hi Dave et al,
>
> FYI, I just sent out a GitHub PR to remove these lines from the proposed
> WG charter: https://github.com/ekline/bpf/pull/5/files. I thought it was
> prudent to go ahead and open the PR now given how close we are to the
> 5/25 meeting, and that we don't seem to be any closer to getting
> consensus here.
>
> We can (and should) continue the discussion here, but my two cents is
> that unless there's a strong reason to keep ABI standardization within
> scope of the WG, that it makes sense to remove these bullets.
>
> That said, if the discussion dies down and/or doesn't continue, IMHO it
> would be prudent to merge the PR. I don't think our default position
> should be to deviate from well-established industry-wide precedence,
> with the onus being on those advocating for following industry norms to
> prove that we don't need to discuss it. Again, I may be missing some
> important context here, so apologies if that's the case.
>
> Thanks,
> David
>
> > Just to be very clear: I could be totally wrong here, and it could be
> > very important to deviate from industry norms and standardize ABI as
> > part of the initial WG charter. However, IMHO, a positive claim like
> > that needs to come with clear substantiation. The reality is that
> > deviating from industry norms and standardizing on ABI will have its ow=
n
> > costs and consequences.
> >
> > > Hence I would not want this removed from the charter unless there's a=
n effort
> > > to do it somewhere else right away, which would seem to increase the =
coordination
> > > burden.

