Return-Path: <bpf+bounces-14432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2257B7E462B
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 17:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2E1281345
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8323315BC;
	Tue,  7 Nov 2023 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCW0RaxY"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F1F30FBE
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 16:38:06 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59FC83
	for <bpf@vger.kernel.org>; Tue,  7 Nov 2023 08:38:05 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4084de32db5so50768675e9.0
        for <bpf@vger.kernel.org>; Tue, 07 Nov 2023 08:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699375084; x=1699979884; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9lBHXUl2l1hiWh1a9SwFzvDGbYsB2ghag8AuRtr0nM8=;
        b=PCW0RaxYtVq1Z83jEe+qXzQeWWfx7Die2MQWdqb8LITEe2+fFG5VNFdy2djevpT6Sf
         Avw7abHH+avlWYoHnkSXe/Xy/Vdk9+FLN8apVJjokyaLHyJq/i7J1FICUAAsRj35apTU
         jTWXwuDQCrn8nSEBxUDJ7SzNSU4mz9X3tEyVZZkPXfiQo7igkICqNeTIREAccEbWPJww
         AuU7cMzHIcaYpNNenPWBIuLdsRcHLyQ3RJhePzD6d0MunHyQUwa9F+bDz1O4340hPZ9K
         wVoCPJbEWqQvpR/Dkq3gY6b1LgisXfcaUe3c7Fi0Lg+Kt+d66Dw/GSagNO7e5Dog0/VV
         2kMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699375084; x=1699979884;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lBHXUl2l1hiWh1a9SwFzvDGbYsB2ghag8AuRtr0nM8=;
        b=sgVAYYnUrzTPg0XFZLtWXPcvvxuRMjGe/TKMX2jATeBxZFuXxbnvRjzbmohE//l2Ns
         6s6SEypoUeGyeLoLZOANt6KfVMTAgGADpVq6kb4tfzuEXxRi0LJ4UHJWzGwMTj4ypqLl
         VWjkh1iR82VR7vBxLuyQGPAFW87SXOlnf7/YMLn0Wo1uPLmwdx4+ZhxBNPlAKYJ1BrLn
         5Z+xaUL7J4uXdeWK13dSKDoNvf6R2yDMyYNOHr2oGyfs86d7qOLM3eoKsQehJXsaUcbY
         VsJcY3BVI6/4OiA9Hyi6Ok4emqpGsd2wwhEhI8QwIua91mIJon3KOlNGdfJCCvri8RBl
         abEA==
X-Gm-Message-State: AOJu0YxtAWN4SmQxGbTD7uohVVa2q3ozxy3smzzprk+bysA4tFXlOOXH
	yDlM1r5RUSoEkAhfsHaZx5I=
X-Google-Smtp-Source: AGHT+IGVzziLVbSYtLcWdB5VJQxKYGSSTsXFwHI8DvpdNZiUcpCPuEz57K035xX5Oaj2Z0QZDHg4EQ==
X-Received: by 2002:a05:600c:19c8:b0:401:be5a:989 with SMTP id u8-20020a05600c19c800b00401be5a0989mr2758717wmq.23.1699375084051;
        Tue, 07 Nov 2023 08:38:04 -0800 (PST)
Received: from Mem (2a01cb0890a26e002f53c1001bea4681.ipv6.abo.wanadoo.fr. [2a01:cb08:90a2:6e00:2f53:c100:1bea:4681])
        by smtp.gmail.com with ESMTPSA id b5-20020a05600c4e0500b00407b93d8085sm16435072wmq.27.2023.11.07.08.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 08:38:03 -0800 (PST)
Date: Tue, 7 Nov 2023 17:38:01 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Paul Chaignon <paul@isovalent.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"martin.lau@kernel.org" <martin.lau@kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH v5 bpf-next 00/23] BPF register bounds logic and testing
 improvements
Message-ID: <ZUpn6fI0k/KblM9t@Mem>
References: <20231027181346.4019398-1-andrii@kernel.org>
 <20231030175513.4zy3ubkpse2f6gqz@MacBook-Pro-49.local>
 <CAEf4BzZyLwO_ZppGObkY=4aXZEGE+k+tTtJug7MP63DffoxrYA@mail.gmail.com>
 <ZUJGkRGnw+qI15Pv@Mem>
 <CAEf4BzavMQ9kqjVWhasdOMweZKuvwfmthzfz8i38kLwp6jd8SA@mail.gmail.com>
 <SJ2PR14MB650157D056A11DBD3FD25E438EA9A@SJ2PR14MB6501.namprd14.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ2PR14MB650157D056A11DBD3FD25E438EA9A@SJ2PR14MB6501.namprd14.prod.outlook.com>

On Tue, Nov 07, 2023 at 06:37:46AM +0000, Harishankar Vishwanathan wrote:
> On Wed, Nov 1, 2023 1:13 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Wed, Nov 1, 2023 at 5:37 AM Paul Chaignon <paul.chaignon@gmail.com> wrote:
> > >
> > > On Mon, Oct 30, 2023 at 10:19:01PM -0700, Andrii Nakryiko wrote:
> > > > On Mon, Oct 30, 2023 at 10:55 AM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Fri, Oct 27, 2023 at 11:13:23AM -0700, Andrii Nakryiko wrote:
> > > > > >
> > > > > > Note, this is not unique to <range> vs <range> logic. Just recently ([0])
> > > > > > a related issue was reported for existing verifier logic. This patch set does
> > > > > > fix that issues as well, as pointed out on the mailing list.
> > > > > >
> > > > > >   [0] https://lore.kernel.org/bpf/CAEf4Bzbgf-WQSCz8D4Omh3zFdS4oWS6XELnE7VeoUWgKf3cpig@mail.gmail.com/
> > > > >
> > > > > Quick comment regarding shift out of bound issue.
> > > > > I think this patch set makes Hao Sun's repro not working, but I don't think
> > > > > the range vs range improvement fixes the underlying issue.
> > > >
> > > > Correct, yes, I think adjust_reg_min_max_vals() might still need some fixing.
> > > >
> > > > > Currently we do:
> > > > > if (umax_val >= insn_bitness)
> > > > >   mark_reg_unknown
> > > > > else
> > > > >   here were use src_reg->u32_max_value or src_reg->umax_value
> > > > > I suspect the insn_bitness check is buggy and it's still possible to hit UBSAN splat with
> > > > > out of bounds shift. Just need to try harder.
> > > > > if w8 < 0xffffffff goto +2;
> > > > > if r8 != r6 goto +1;
> > > > > w0 >>= w8;
> > > > > won't be enough anymore.
> > > >
> > > > Agreed, but I felt that fixing adjust_reg_min_max_vals() is out of
> > > > scope for this already large patch set. If someone can take a deeper
> > > > look into reg bounds for arithmetic operations, it would be great.
> > > >
> > > > On the other hand, one of those academic papers claimed to verify
> > > > soundness of verifier's reg bounds, so I wonder why they missed this?
> > >
> > > AFAICS, it should have been able to detect this bug. Equation (3) from
> > > [1, page 10] encodes the soundness condition for conditional jumps and
> > > the implementation definitely covers BPF_JEQ/JNE and the logic in
> > > check_cond_jmp_op. So either there's a bug in the implementation or I'm
> > > missing something about how it works. Let me cc two of the paper's
> > > authors :)
> > >
> > > Hari, Srinivas: Hao Sun recently discovered a bug in the range analysis
> > > logic of the verifier, when comparing two unknown scalars with
> > > non-overlapping ranges. See [2] for Eduard Zingerman's explanation. It
> > > seems to have existed for a while. Any idea why Agni didn't uncover it?
> > >
> > > 1 - https://harishankarv.github.io/assets/files/agni-cav23.pdf
> > > 2 - https://lore.kernel.org/bpf/8731196c9a847ff35073a2034662d3306cea805f.camel@gmail.com/
> > >
> > > > cc Paul, maybe he can clarify (and also, Paul, please try to run all
> > > > that formal verification machinery against this patch set, thanks!)
> > >
> 
> Thanks Paul for bringing this to our notice, and for the valuable clarifications
> you provided. The bug discovered by Hao Sun occurs only during verificaiton,
> when the verifier follows what is essentially dead code. An execution of the
> example eBPF program cannot manifest a mismatch between the verifier's beliefs
> about the values in registers and the actual values during execution. As such,
> the example eBPF program cannot be used to achieve an actual verifier bypass.

There's one caveat here I wanted to double check: speculative execution.
I discussed this a bit with Daniel and it seems likely that the
false/"impossible" path could happen at runtime under speculative
execution. Daniel provided [1, slide 69] as an example of a similar
case. In the verifier, such cases are covered by
sanitize_speculative_path [2].

So this speculative execution case would be a good motivation to cover
both paths in Agni. At the same time, it may not be enough to claim
that Agni also verifies all the verifier's protections against
speculative execution. And I'm also a bit worried about the runtime
cost of weakening Agni's verification condition to detect such bugs.

1 - https://popl22.sigplan.org/details/prisc-2022-papers/11/BPF-and-Spectre-Mitigating-transient-execution-attacks
2 - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9183671af6db

> 
> As pointed out by Eduard Zingerman in the mailing list thread, the issue arises
> when the verifier follows the false (similarly true) branch of a
> jump-if-not-equal (similarly jump-if-equal) instruction, when it is never
> possible that the jump condition is false (similarly true). While it is okay for
> the verifier to follow dead code generally, it so happens that the logic it uses
> to update the registers ranges does not work in this specific case, and ends up
> violating one of the invariants it is supposed to maintain (a <= b for a range
> [a, b]).
> 
> Agni's verification condition [1] is stricter. It follows the false (similarly
> true) branch of a jump-if-not-equal (similarly jump-if-equal) instruction *only*
> when it is possible that the registers are equal (similarly not equal). In
> essence, Agni discards the reported verifier bug as a false positive.
> 
> We can easily weaken Agni's verification condition to detect such bugs. We
> modified Agni's verification condition [2] to follow both the branches of a
> jump-if-not-equal instruction, regardless of whether it is possible that the
> registers can be equal. Indeed, the modified verification condition produced the
> umin > umax verifier bug from Hao's example. The example produced by Agni, and
> an extended discussion can be found at Agni's issue tracker [3].

Nice! Thanks for trying this out so quickly!
Did you notice any difference on the time it took to verify the
conditional jumps?

> 
> [1] https://user-images.githubusercontent.com/8588645/280917882-dc97090d-040a-43b0-9bf8-806081992716.png
> [2] https://user-images.githubusercontent.com/8588645/280925756-19336087-836f-45e5-87fb-c2453558df06.png
> [3] https://github.com/bpfverif/ebpf-range-analysis-verification-cav23/issues/15#issuecomment-1797858245
> 
> > > I tried it yesterday but am running into what looks like a bug in the
> > > LLVM IR to SMT conversion. Probably not something I can fix myself
> > > quickly so I'll need help from Hari & co.
> > >
> > > That said, even without your patchset, I'm running into another issue
> > > where the formal verification takes several times longer (up to weeks
> > > /o\) since v6.4.
> > >
> 
> I'm looking into this next, thanks for the heads up!
> 
> > That's unfortunate. If you figure this out, I'd still be interested in
> > doing an extra check. Meanwhile I'm working on doing more sanity
> > checks in the kernel (and inevitably having to debug and fix issues,
> > still working on this).

