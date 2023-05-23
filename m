Return-Path: <bpf+bounces-1128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DC970E5E9
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 21:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50F831C20D95
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 19:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F56F21CF2;
	Tue, 23 May 2023 19:47:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A56D1F934
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 19:47:14 +0000 (UTC)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950FA139
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 12:47:10 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1q1XyN-0003g7-L4; Tue, 23 May 2023 15:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=DzrZ/h7jcyKJ4mEHXUnBoi307ryxUGh8iTJWX7zqAcQ=; b=nY1OUErRkEqSh0AJ1Auo
	HvI8hAQxXYaakatRMVW9odnZnuX6fF6NBPZPIo5rm+WNMZaMlRp3ZIl9tYPY1msQkAijNzzHXIFJ1
	mt4wzn4wQ+KpvIj5sx8dH0sR1MNROWeZQkbIpVQzAFu/lrBv05u2f3h0j4oMzHAa4cxJMYlLtltLd
	whJg5jpwr7TvTixRfi2aFPtKWwa8ktIsdbLV5WIEQUxDJtLF9sXAcxvXWosC6FzgbwSuSPNB5V4/v
	waoYSV4cQQhtu6xKy63JkjdO1nVhgHpbsyODI7I1i7R4TcFpnc+YPOCUJPDPMg+fJ3Gm8l5ZZBq0k
	g+ke9NcMk667Gg==;
Received: from [141.143.193.79] (helo=termi)
	by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1q1XyN-0001Mx-7R; Tue, 23 May 2023 15:47:07 -0400
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: Erik Kline <ek.ietf@gmail.com>
Cc: David Vernet <void@manifault.com>,  Dave Thaler <dthaler@microsoft.com>,
  "bpf@ietf.org" <bpf@ietf.org>,  bpf <bpf@vger.kernel.org>,  "Suresh
 Krishnan (sureshk)" <sureshk@cisco.com>,  Christoph Hellwig
 <hch@infradead.org>,  Alexei Starovoitov <ast@kernel.org>
Subject: Re: [Bpf] IETF BPF working group draft charter
In-Reply-To: <CAMGpriVpc5qdtqAObO1nu64kidt6C4UFp_FJ_Ht+DThMHNX-CQ@mail.gmail.com>
	(Erik Kline's message of "Tue, 23 May 2023 12:42:03 -0700")
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
	<87v8grkn67.fsf@gnu.org>
	<PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
	<87r0rdy26o.fsf@gnu.org>
	<PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
	<20230523163200.GD20100@maniforge>
	<PH7PR21MB3878A4135C14B318DD43365CA340A@PH7PR21MB3878.namprd21.prod.outlook.com>
	<20230523171535.GE20100@maniforge> <20230523190814.GA32582@maniforge>
	<CAMGpriVpc5qdtqAObO1nu64kidt6C4UFp_FJ_Ht+DThMHNX-CQ@mail.gmail.com>
Date: Tue, 23 May 2023 21:47:03 +0200
Message-ID: <87leheu8y0.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> how about if we pull ABI but leave ELF?

The ELF architecture-specific configuration and extensions are
traditionally part of the psABI.  Chapter 4 Object Files.

>
> On Tue, May 23, 2023 at 12:08=E2=80=AFPM David Vernet <void@manifault.com=
> wrote:
>>
>> On Tue, May 23, 2023 at 12:15:35PM -0500, David Vernet wrote:
>> > On Tue, May 23, 2023 at 04:50:42PM +0000, Dave Thaler wrote:
>> > > > -----Original Message-----
>> > > > From: David Vernet <void@manifault.com>
>> > > > Sent: Tuesday, May 23, 2023 9:32 AM
>> > > > To: Dave Thaler <dthaler@microsoft.com>
>> > > > Cc: Jose E. Marchesi <jemarch@gnu.org>; bpf@ietf.org; bpf
>> > > > <bpf@vger.kernel.org>; Erik Kline <ek.ietf@gmail.com>; Suresh Kris=
hnan
>> > > > (sureshk) <sureshk@cisco.com>; Christoph Hellwig <hch@infradead.or=
g>;
>> > > > Alexei Starovoitov <ast@kernel.org>
>> > > > Subject: Re: [Bpf] IETF BPF working group draft charter
>> > > >
>> > > > On Thu, May 18, 2023 at 07:42:11PM +0000, Dave Thaler wrote:
>> > > > > Jose E. Marchesi <jemarch@gnu.org> wrote:
>> > > > > > I would think that the way the x86_64, aarch64, risc-v, sparc,=
 mips,
>> > > > > > powerpc architectures, along with their variants, handle their=
 ELF
>> > > > > > extensions and psABI, ensures interoperability good enough for=
 the
>> > > > problem at hand, but ok.
>> > > > > > I'm definitely not an expert in these matters.
>> > > > >
>> > > > > I am not familiar enough with those to make any comment about th=
at.
>> > > >
>> > > > Hi Dave,
>> > > >
>> > > > Taking a step back here, perhaps we need to think about all of thi=
s more
>> > > > generically as "ABI", rather than ELF "extensions", "bindings", et=
c.  In my
>> > > > opinion this would include, at a minimum, the following items from=
 the current
>> > > > proposed WG charter:
>> > > >
>> > > > * the eBPF bindings for the ELF executable file format,
>> > > >
>> > > > * the platform support ABI, including calling convention, linker
>> > > >   requirements, and relocations,
>> > > >
>> > > > As far as I know (please correct me if I'm wrong), there isn't rea=
lly a precedence
>> > > > for standardizing ABIs like this. For example, x86 calling convent=
ions are not
>> > > > standardized.  Solaris, Linux, FreeBSD, macOS, etc all follow the =
System V
>> > > > AMD64 ABI, but Microsoft of course does not. As Jose pointed out, =
such
>> > > > standards extensions do not exist for psABI ELF extensions for var=
ious
>> > > > architectures either.
>> > > >
>> > > > While it may be that we do end up needing to standardize these ABI=
s for BPF,
>> > > > I'm beginning to think that we should just remove them from the cu=
rrent WG
>> > > > charter, and consider standardizing them at a later time if it's c=
lear that it's
>> > > > actually necessary. I think this is especially true given that we =
don't seem to be
>> > > > getting any closer to having consensus, and that we're very short =
on time given
>> > > > that Erik is going to be proposing the charter to the rest of the =
ADs in just two
>> > > > days on 5/25.
>> > > >
>> > > > Thanks,
>> > > > David
>> > >
>> > > I can tell you it's very important to those who work on the
>> > > ebpf-for-windows project that the ELF format is common between
>> > > Linux and Windows so that tools like
>> > > llvm-objdump and bpftool and other BPF-specific ELF parsing tools wo=
rk for both
>> > > Linux and Windows.   We don't want Windows to diverge.
>> >
>> > Be that as it may, as I said before, to my knowledge there's no
>> > precedence at all for standardizing ABI like this. Is there a reason
>> > that you think Windows would diverge if we didn't standardize the ABI?
>> >
>> > I realize that I'm essentially saying, "Hey, pretend there's a standard
>> > and don't diverge", but if that's what the entire rest of the industry
>> > has done up until this point with all other psABIs, then it seems like=
 a
>> > reasonable expectation.
>> >
>> > > As such, I feel strongly that it is a requirement to be standardized=
 right away.
>> >
>> > I have to respectfully disagree. I think there are much bigger fish to
>> > fry, such as standardizing the ISA. Unless we really have a good reason
>> > for diverging from industry norms, standardizing on ABI now feels to me
>> > like we're putting the cart before the horse.
>>
>> Hi Dave et al,
>>
>> FYI, I just sent out a GitHub PR to remove these lines from the proposed
>> WG charter: https://github.com/ekline/bpf/pull/5/files. I thought it was
>> prudent to go ahead and open the PR now given how close we are to the
>> 5/25 meeting, and that we don't seem to be any closer to getting
>> consensus here.
>>
>> We can (and should) continue the discussion here, but my two cents is
>> that unless there's a strong reason to keep ABI standardization within
>> scope of the WG, that it makes sense to remove these bullets.
>>
>> That said, if the discussion dies down and/or doesn't continue, IMHO it
>> would be prudent to merge the PR. I don't think our default position
>> should be to deviate from well-established industry-wide precedence,
>> with the onus being on those advocating for following industry norms to
>> prove that we don't need to discuss it. Again, I may be missing some
>> important context here, so apologies if that's the case.
>>
>> Thanks,
>> David
>>
>> > Just to be very clear: I could be totally wrong here, and it could be
>> > very important to deviate from industry norms and standardize ABI as
>> > part of the initial WG charter. However, IMHO, a positive claim like
>> > that needs to come with clear substantiation. The reality is that
>> > deviating from industry norms and standardizing on ABI will have its o=
wn
>> > costs and consequences.
>> >
>> > > Hence I would not want this removed from the charter unless there's =
an effort
>> > > to do it somewhere else right away, which would seem to increase the=
 coordination
>> > > burden.

