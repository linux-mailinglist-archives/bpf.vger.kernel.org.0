Return-Path: <bpf+bounces-1190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC2A70FFA6
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 23:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E63F281298
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 21:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB87D2262C;
	Wed, 24 May 2023 21:06:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5BB22627
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 21:06:49 +0000 (UTC)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2912E6
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 14:06:32 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1q1vgk-0000Tf-3O; Wed, 24 May 2023 17:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=KckZTmo9Gc7wmnUqu5f/ww3uf3YmM1kpN4TCRRyqEOY=; b=Gcb3/Hc5igTEL+rpd29U
	Xbs6MS002bwiHmoIl/95jpHSlySpcbkjGn33002bm1DpZYwMbXD+CI4Q3/FGhLtLANkB2AmR4chjo
	JurOkdCIKnhBDIca7Y6jJmGVwUBBILD8TeL7POlXHDRjk2rBaYz3FAslJZIS+NmVrF1OjMprNLo9y
	2HZAf17leaPlcJ8S7YJ7PYuNUmHufogR6urZw3e/w9knyJwfxUbzOT2qe0dAh5+1G5fF9VV+AfQje
	/92XC8FuqKPPfoTnhh91uTghtVX9/3ybqBsJKh3dzugYW5C510T4N13czx95LC2Vrn/NZ4uGi+TfK
	Wn/BmGmU5CXe+w==;
Received: from dynamic-077-015-107-011.77.15.pool.telefonica.de ([77.15.107.11] helo=termi)
	by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1q1vgj-0000lh-KZ; Wed, 24 May 2023 17:06:29 -0400
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: Suresh Krishnan <suresh.krishnan@gmail.com>
Cc: David Vernet <void@manifault.com>,  Michael Richardson
 <mcr+ietf@sandelman.ca>,  "bpf@ietf.org" <bpf@ietf.org>,  bpf
 <bpf@vger.kernel.org>,  Alexei Starovoitov <ast@kernel.org>,  Erik Kline
 <ek.ietf@gmail.com>,  "Suresh Krishnan (sureshk)" <sureshk@cisco.com>,
  Christoph Hellwig <hch@infradead.org>,  Dave Thaler
 <dthaler@microsoft.com>
Subject: Re: [Bpf] IETF BPF working group draft charter
In-Reply-To: <8FA12EFB-DB5A-4C6B-83BC-A3CBBE44F80B@gmail.com> (Suresh
	Krishnan's message of "Wed, 24 May 2023 16:38:12 -0400")
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
	<87v8grkn67.fsf@gnu.org>
	<PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
	<87r0rdy26o.fsf@gnu.org>
	<PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
	<20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
	<20230523202827.GA33347@maniforge>
	<8FA12EFB-DB5A-4C6B-83BC-A3CBBE44F80B@gmail.com>
Date: Wed, 24 May 2023 23:06:23 +0200
Message-ID: <87a5xto2wg.fsf@gnu.org>
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
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> Hi David,
>   I just want to provide a quick clarification from the IETF side
> regarding categories of RFCs. Not all the RFCs we produce are
> standards. On a broad level we have standards track and informational
> documents (among others; more details in RFC2026). I do believe there
> is value in *documenting* some of the items that belong in an ABI such
> as the calling convention (similar to what is in Section 2 of the ISA
> draft). Similarly, there is value in documenting conventions and
> guidelines for creating portable binaries if we believe that is a
> useful goal, even though there will be a lot of programs that will not
> be portable (e.g. using cgroups). I would not expect these to be
> Standards track documents but rather Informational specifications to
> help implementers. If that sounds reasonable we can keep the text in
> the charter (with some minor rewording) and work on categorizing
> potential deliverables by Document Status (as would anyway be
> necessitated by =C3=89ric Vyncke=E2=80=99s BLOCK).

I wonder.  Lets suppose the ABI and ELF extensions are maintained and
evolved in the usual way it is done for all other architectures, i.e.
in the kernel git repository or a dedicatd public one, in textual form,
under a free software license, not requiring copyright assignments nor
bureocratic processes to be updated, etc.  Could then the WG edit and
publish "snapshots" whenever considered appropriate, and release them as
subsequent versions of an IETF Informational specification, or some
other suitable kind of IETF document?

If something like that would be doable, maybe we could concile the
practicality of the usual approach with the more formal character of an
IETF document?

> Regards
> Suresh
>
>> On May 23, 2023, at 4:28 PM, David Vernet <void@manifault.com> wrote:
>>=20
>> On Tue, May 23, 2023 at 01:58:18PM -0400, Michael Richardson wrote:
>>>=20
>>> David Vernet <void@manifault.com <mailto:void@manifault.com>> wrote:
>>>> As far as I know (please correct me if I'm wrong), there isn't really a
>>>> precedence for standardizing ABIs like this. For example, x86 calling
>>>=20
>>> All of the eBPF work seems unprecedented.
>>> I don't see having this in the charter is a problem.
>>>=20
>>> We may fail to get consensus on it, and not make a milestone, but I don=
't see
>>> a reason not to be allowed to talk about this.
>>> (and maybe in the end, it's a no-op)
>>=20
>> Hi Michael,
>>=20
>> So apologies in advance if my lack of experience with IETF proceedings
>> is glaringly obvious, and I'd appreciate clarification in any situation
>> in which I'm mistaken.
>>=20
>> My understanding based on the conversations that I've had thus far is
>> that part of the goal of arriving at the finalized WG charter is to
>> determine what's in scope and out of scope. It's a bit of a murky
>> proposition because some things that we think _could_ be in scope, such
>> as in this case topics related to psABI, may not end up having a
>> document if we can't get consensus. In other words, being in the WG
>> charter doesn't imply that something is in-scope and will have a
>> document written, but _not_ being in the charter does preclude it from
>> being discussed in this iteration of the WG because of this line:
>>=20
>>> The working group shall not adopt new work until these
>>> documents have progressed to working group last call.
>>=20
>> The implication of this is that it's not necessarily a problem to have
>> some false-positives in terms of what we cover, but it can be
>> problematic if we leave out something important because we'll have to
>> cover all of the other topics first. I'd imagine this would tend to make
>> the default behavior for deciding scope in WG charters to be permissive
>> rather than dissmive, which makes sense to me.
>>=20
>> Assuming I haven't already gone off the rails in terms of my
>> understanding, let me try to clarify why despite all that, I still think
>> it's warranted for us to remove psABI as part of the scope of the WG.
>> There are really two main reasons:
>>=20
>> 1. As is hopefully clear at this point, there is a wide and historical
>>   industry precedence for not standardizing on psABI. For example, to
>>   my knowledge, RISC-V [0] develops and ratifies the RISC-V ISA through
>>   the RISC-V International Technical Working Groups, but there is no
>>   such ratified standard or specification for RISC-V calling
>>   conventions (the operative word of course being "convention"). The
>>   same is true (to my knowledge) of _all_ psABI ELF extensions, as Jose
>>   pointed out earlier in the conversation.
>>=20
>> [0]: https://riscv.org/technical/specifications/ <https://riscv.org/tech=
nical/specifications/>
>>=20
>>   With all that said, unless there's more context behind why we think we
>>   need to standardize psABI which hasn't yet been brought forward, I
>>   don't see any way we'd achieve consensus when we discuss it in the
>>   WG. And the reason I specifically think that's the case for ABI (ELF
>>   or otherwise) is that there's such a well-established precedence
>>   already for not standardizing it. I guess it's true that there's no
>>   harm in including it and discussing it, but as things currently
>>   stand, it also doesn't seem very productive to include it if there's
>>   already (IMHO) reasonably clear evidence that it's out of scope. To
>>   go back to my claim made in another email, I think the onus is on the
>>   folks who think it's in scope to explain why, rather than the folks
>>   who think we should follow industry precedence to justify that.
>>=20
>> 2. Assuming that I'm wrong, and ABI / ELF are in scope for
>>   standardization, we would still have to do a lot of premliminary
>>   work to determine that. For example, we may end up wanting to
>>   standardize that maps are put into .maps sections in an ELF file, but
>>   that would only make sense if we created a document standardizing
>>   cross-platform map types. The same holds true for cross-platform
>>   program types, etc. The dependency DAG for discussing ELF has a depth
>>   of at least 2, and given that it's as-yet unclear whether ELF / psABI
>>   is an appropriate topic for standardization in the first place, it
>>   really feels to me like leaving it out of the WG is the right move.
>>=20
>> Thanks,
>> David
>>=20
>>>=20
>>> --
>>> Michael Richardson <mcr+IETF@sandelman.ca>   . o O ( IPv6 I=C3=B8T cons=
ulting )
>>>           Sandelman Software Works Inc, Ottawa and Worldwide
>>>=20
>>>=20
>>>=20
>>>=20
>>=20
>>=20
>>=20
>>> --=20
>>> Bpf mailing list
>>> Bpf@ietf.org
>>> https://www.ietf.org/mailman/listinfo/bpf
>>=20
>> --=20
>> Bpf mailing list
>> Bpf@ietf.org <mailto:Bpf@ietf.org>
>> https://www.ietf.org/mailman/listinfo/bpf <https://www.ietf.org/mailman/=
listinfo/bpf>

