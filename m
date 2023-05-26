Return-Path: <bpf+bounces-1326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9B7712BB4
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 19:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676101C21089
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 17:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE9328C28;
	Fri, 26 May 2023 17:25:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82977271F6
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 17:25:32 +0000 (UTC)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA61A1AC
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 10:25:28 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1q2bBt-00083y-Du; Fri, 26 May 2023 13:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=HuW/R6IXedz7Sh0fnYj2KaW+G+r0Nn5MKUUor+E3Onk=; b=iE2mpqEtmXowfHG8D0ID
	XYequGFhaCOtLzFAMADhsWxCZT2QKXuY94meqptvsGnxp8cdmF1lT9Fng9cVHXBVDprhDRwmD979t
	VjR3FF23kxRTvXKQK7KAsYABRQCaa5ejEIbmR9MxDmBCAHrd+yvL8GxLtuEBKYtS3itJVGwqFCfZ4
	jgeSaI9nODXREY4Vaw4qchhZ2/QSLYmPcWc8o2nY5UXqjc49xJMnF5wGmFRuZn0hdUN2FFkaFFsTM
	vxdzqvjjB2ekWtcnF4DRZgULMqXjq7JoXNfgpatb6rm4hCkw7S/afleZg14Gxaai4ocT3iohtH/Di
	MlbW9OyhhHKRBQ==;
Received: from [141.143.193.71] (helo=termi)
	by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1q2bBp-0000mo-L5; Fri, 26 May 2023 13:25:23 -0400
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: Dave Thaler <dthaler@microsoft.com>
Cc: Suresh Krishnan <suresh.krishnan@gmail.com>,  David Vernet
 <void@manifault.com>,  Michael Richardson <mcr+ietf@sandelman.ca>,
  "bpf@ietf.org" <bpf@ietf.org>,  bpf <bpf@vger.kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Erik Kline <ek.ietf@gmail.com>,  "Suresh
 Krishnan (sureshk)" <sureshk@cisco.com>,  Christoph Hellwig
 <hch@infradead.org>
Subject: Re: [Bpf] IETF BPF working group draft charter
In-Reply-To: <PH7PR21MB3878F7518729EB48F116978EA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
	(Dave Thaler's message of "Fri, 26 May 2023 16:05:44 +0000")
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
	<87v8grkn67.fsf@gnu.org>
	<PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
	<87r0rdy26o.fsf@gnu.org>
	<PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
	<20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
	<20230523202827.GA33347@maniforge>
	<8FA12EFB-DB5A-4C6B-83BC-A3CBBE44F80B@gmail.com>
	<87a5xto2wg.fsf@gnu.org>
	<PH7PR21MB3878F7518729EB48F116978EA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
Date: Fri, 26 May 2023 19:25:11 +0200
Message-ID: <874jnzgg3s.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> Jose E. Marchesi <jemarch@gnu.org> writes: 
> [...]
>> I wonder.  Lets suppose the ABI and ELF extensions are maintained and evolved
>> in the usual way it is done for all other architectures, i.e.
>> in the kernel git repository or a dedicatd public one, in textual form, under a
>> free software license, not requiring copyright assignments nor bureocratic
>> processes to be updated, etc.
>
> Let's not confuse code and documentation.  Here we are discussing documentation
> not code.

Hm.  I don't think anyone is confusing code and documentation here.

> For documentation, see the RISC-V standard in my previous email.  The
> calling convention document isn't part of a kernel git repository,
> it's part of a standards group that is specific to RISC-V.  That's
> what we're talking about here.

The PDF you sent is an (outdated) fragment of the specification of the
ISA and some official ISA extensions, that just happens to contain a two
pages providing a very general indications on the calling conventions.
That is _not_ the ABI.

The official RISC-V psABI is maintained in [1], which is a git
repository, it is distributed under a creative-commons license CC-BY, is
updated, and it is open to external contributions via pull requests.

And yes, it happens that particular psABI is maintained by RISC-V via a
TG (Task Group) with a chair and a co-chair, and there is a well defined
process, documented in the policy.md file in that git repo.  All the
bells and whistles.  Sure.

In a similar way than the x86_64 psABI is maintained by Intel via HJ Lu
in another git repo, distributed under a creative-commons license CC-BY,
updated often, and open to external contributions via pull requests or
patches.  Less bells and whistles (as far as I know HJ is no chair of
anything, gotta ask him) but a similar implementation.

I am attaching the RISC-V ABI policy at the end of this email.
Can IETF implement a similar process?

In particular:

1) Maintaining the ABI in a public git repository.

   Like the RISC-V Foundation does.

2) Releasing the files in that repo under a free software license like
   dual GPL/BSD, or a suitable Creative Commons like CC-BY.

   Like the RISC-V Foundation does.

3) Allowing third-party like particulars and corporations to contribute
   to the ABI (via patches to mailing list or pull requests) without the
   need of a copyright assignment?

   Like the RISC-V Foundation does.

4) Explicitly referring implementors to the git repo as the latest and
   authoritative version of the document.

   Like the RISC-V Foundation does.

If the answer is yes, then I will shut up, apologize for the noise, and
be as happy as a clam.

If the answer is no, well, I think I will still shut up, because I'm
getting a bit tired of always being the party pooper around here, and
the point has been made for your consideration, so more I cannot do.

[1] https://github.com/riscv-non-isa/riscv-elf-psabi-doc

---
policy.md

# Policy for Merging Pull Requests

Each type of modification has a different policy, based on the following rules:

- Changes requiring linker changes
  - Require an open source PoC implementation for binutils or LLD, either as a
    patch on the mailing list/Phabricator as appropriate or in a GitHub fork
  - Require at least one binutils developer **_AND_** one LLD developer to
    approve

- Changes requiring compiler changes
  - Require an open source PoC implementation for GCC or LLVM, either as a
    patch on the mailing list/Phabricator as appropriate or in a GitHub fork
  - Require at least one GCC developer **_AND_** one LLVM developer to approve

- Clarifications for currently-implemented behaviour
  - Require approval from a developer of the corresponding component
    (binutils/LLD or GCC/LLVM)

- General improvements and clarification
  - One of the psABI TG chair or co-chair.

- Do **_NOT_** make incompatible changes
  - Changes that break compatibility are generally not acceptable
  - In the rare case there is a bug in the ABI that needs fixing and that
    cannot be done in a backwards-compatible way, or possibly for some
    edge-case behaviour that is not currently relied upon, breaking the ABI can
    be considered, but will require both the psABI TG chair and co-chair to
    approve, and is subject to the above requirements as appropriate

# FAQ

- Can I leave a comment, LGTM or approve the PR even if I am not a toolchain
  developer or chair/co-chair?
  - Don't hesitate to leave your comment, we encourage anyone who intends
    to contribute to the RISC-V community to participate in discussion.

- When do I need to modify the compiler and/or linker?
  - Changes and additions to the ELF format itself generally require linker
    changes, e.g. new relocation types, new flags in the `e_flags` field, new
    sections and new symbol flags.
  - Changes and additions to calling conventions and code models generally
    require compiler changes.

- Who are the psABI TG chair and co-chair?
  - The current chair is Kito Cheng ([@kito-cheng]) and the current co-chair is
    Jessica Clarke ([@jrtc27]).

- Where can I find a RISC-V GCC/LLVM/binutils/LLD developer to review my PR?
  - The psABI TG chair or co-chair will generally contact the right people as
    needed for reviews, but in case you want to reach out yourself you can find
    an incomplete list from [RISC-V International's wiki page].

[@kito-cheng]: https://github.com/kito-cheng
[@jrtc27]: https://github.com/jrtc27
[RISC-V International's wiki page]: https://wiki.riscv.org/display/TECH/Toolchain+Projects

