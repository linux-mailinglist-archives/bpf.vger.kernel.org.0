Return-Path: <bpf+bounces-78284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 44134D07CE5
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 09:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FF0C30141EF
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 08:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E788340D93;
	Fri,  9 Jan 2026 08:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEM3MfS8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB9C340A49
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947247; cv=none; b=nxdl5l/+1vI8Cc5M1Ppri4GB6I0Mpil9gKNEum5AL07i7cc+aBFvItZ3YpyT5acyiHYFoz2N6x5JZFYSRjTNI00gZ+st3a/l15Nz6O3DdDEau5fbY27ptdppahO3b1Gc48eJOSDoNaiCoYcVjcexVw+xm2O2rRrMaTH60/w7CLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947247; c=relaxed/simple;
	bh=j0CFmj5uXQC/vw/BYL0kK2DjmcG0vUxX40xuyIUIz4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0VXKYOt0YbLGTOn9K1X9I81r/8ABi7TDtD3TNPENPLfZ28rcUbq6V+UAw4EzchQffz5TQvuHD0T8kxIGFj55Gg6QgLdFYdETFH3Fnv99iP1+XX57juzFqiztw8ld6gTngVczP8WBeIKuuus829h4R7gAkv5OyD1siU8JCrW/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GEM3MfS8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b832c65124cso655251966b.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 00:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767947242; x=1768552042; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NhcNVdVQhZPinLKh1jpeqgoQHiibL7zwCLP1Wwv50Rg=;
        b=GEM3MfS8YpbDNZ4BOiYyPWFhvhhRXj0XrJU/jk6kuTrv0Nx52LoFlJ0bUAQKnWX09J
         BOHnCPX1FUuF29OsROzqdIjs0FKXbBaGXs9fcC83pwm+p30UCPyOfKNxuykBy8p25WdZ
         TWdnnekV1e+aPEEmxLwPg8GVUpDsB7Aj6O9uvBy8gjRqbVApV8n7P/Cpmc0k2rYQ7SnL
         L8Mdie+G5Rf1+2ka6mdauIfSjX2aIBeZN9B41d3A/NzX+1ArDxLGBwjcsOppsTfuXCeq
         mfvbIp/1S1/TSXT7vXea7lPQdt0XOpDgtDtcU627CVeePGc6SJrt0SaorKNqlSfvC/CG
         CY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767947242; x=1768552042;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhcNVdVQhZPinLKh1jpeqgoQHiibL7zwCLP1Wwv50Rg=;
        b=IWpzVfmiSp7PWVCASbdPyl6xPDyRTymGFcfqxzJ3zKZv+KitqzQZoaVJFke+Gc2Keq
         oyE+zfPCN3EF9raPOBJyVNJae2g5CSZR4y+wyMOCuKaArCk7BcW153mo8pUhPor+D17Q
         ApqFZjuLZ+Otkrk99NI6Tya5hMu65GCS38auxztb5U4tr0Cl+zEnYMLI9E0q5nCDbVs5
         NoK5Za3IY8+0S3ujWa6+hWv9o7HJsjzO0Gf17rGO/YigXR8AkiH+97vl4vn6h9L+Itj2
         uoMehLNlT2KMw6UdT+/5VAl5LE3M8O2NfZKVvRS1fz/mJg+QhZM/R20NKPgUKTZihfKP
         rCHw==
X-Forwarded-Encrypted: i=1; AJvYcCXl/GyvepWBQ77Nfz8yaBav9n5ODHF05ZRYdlpgjvkcGOS84+5eGtreR3k2NqZQs++6ayI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKSESPC6Cb0vLYbwBuaMor4370qLdRZBOEDHTS6ab5q/py9T/C
	SM7JMuQAm43BarcYblXzoVs5CkSIPNn8EICw14yWZOieyrpxsLfMCKR9L7LGEmaYUw==
X-Gm-Gg: AY/fxX4XFf2uU6XNXRxXWT0mkM6Bcy5pMxavuk5UPj0hp+dsAR/6pKJUUPi6SNkqwOG
	XdFvjDNKs4CMx9gCVI1n6+m9OqDAn4gxY9eH9GvE9I7uT4MiGHt5LpaSuuTx8MvrB9RHLRJTXrV
	O9Fqr86Qrc3yMA6YWbckTubbncCqtKzjBFWFvMn3XwhfeI9A6x3xZxl/1qp6OYw7POLzmQ++hyO
	MsUQetYX7FA6gSmevkukXBA33gvt60vIyjLjAMREELTrnqxxBbXw+Dief6VOtpIJOYnvEHhte1K
	uZ5yAvz9CQZj6+I+/YVhSZRSBcYVuXdUbPIdtWlXv8mcYoAk307S3ZwsGlsBo/wXjgKhbYI1yrp
	iMZV5x4F/9f+RsTfctfVWScb6XdmIzRZbI17v+/AQmnupuz9dTEVkp6TtuogQ3hMO7KHRXf+MgI
	vmG06muHtxVYNJhb9xpbLG8UXVNwuAOgRJee/hz0bcBw7cAV899QEj8w==
X-Google-Smtp-Source: AGHT+IGCEJb/8nMNV4ll2AYwkVVw38xNVFNBZWCtO9DA5bm8fJKqYo9GPaWv4xHmda4gm2UOmFufdA==
X-Received: by 2002:a17:907:971d:b0:b83:a754:928c with SMTP id a640c23a62f3a-b8445190226mr920792866b.61.1767947241400;
        Fri, 09 Jan 2026 00:27:21 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507be642f5sm9373828a12.20.2026.01.09.00.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 00:27:20 -0800 (PST)
Date: Fri, 9 Jan 2026 08:27:17 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH dwarves] btf_encoder: prefer strong function definitions
 for BTF generation
Message-ID: <aWC75QonlmNVAGbO@google.com>
References: <20251231085322.3248063-1-mattbobrowski@google.com>
 <926aca4a-d7d5-4e7d-9096-77b27374c5cd@linux.dev>
 <aVt139VXMTka-hYw@google.com>
 <aVuk1e73g7ZTHqMY@google.com>
 <6b0968a3-406b-412f-acbb-c00ac2ad7c93@linux.dev>
 <aVwihhKEszvcyNKo@google.com>
 <ace92738-a52a-4248-b7d8-bcfce6f9af22@oracle.com>
 <aV6sNbs3vwCoGk49@google.com>
 <a25bddfb-4b43-47ab-a23c-03db99279435@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a25bddfb-4b43-47ab-a23c-03db99279435@oracle.com>

On Thu, Jan 08, 2026 at 06:18:07PM +0000, Alan Maguire wrote:
> On 07/01/2026 18:55, Matt Bobrowski wrote:
> > On Wed, Jan 07, 2026 at 03:50:40PM +0000, Alan Maguire wrote:
> >> On 05/01/2026 20:43, Matt Bobrowski wrote:
> >>> On Mon, Jan 05, 2026 at 08:23:29AM -0800, Yonghong Song wrote:
> >>>>
> >>>>
> >>>> On 1/5/26 3:47 AM, Matt Bobrowski wrote:
> >>>>> On Mon, Jan 05, 2026 at 08:27:11AM +0000, Matt Bobrowski wrote:
> >>>>>> On Fri, Jan 02, 2026 at 10:46:00AM -0800, Yonghong Song wrote:
> >>>>>>>
> >>>>>>> On 12/31/25 12:53 AM, Matt Bobrowski wrote:
> >>>>>>>> Currently, when a function has both a weak and a strong definition
> >>>>>>>> across different compilation units (CUs), the BTF encoder arbitrarily
> >>>>>>>> selects one to generate the BTF entry. This selection fundamentally is
> >>>>>>>> dependent on the order in which pahole processes the CUs.
> >>>>>>>>
> >>>>>>>> This indifference often leads to a mismatch where the generated BTF
> >>>>>>>> reflects the weak definition's prototype, even though the linker
> >>>>>>>> selected the strong definition for the final vmlinux binary.
> >>>>>>>>
> >>>>>>>> A notable example described in [0] involving function
> >>>>>>>> bpf_lsm_mmap_file(). Both weak and strong definitions exist,
> >>>>>>>> distinguished only by parameter names (e.g., file vs
> >>>>>>>> file__nullable). While the strong definition is linked into the
> >>>>>>>> vmlinux object, the generated BTF contained the prototype for the weak
> >>>>>>>> definition. This causes issues for BPF verifier (e.g., __nullable
> >>>>>>>> annotation semantics), or tools relying on accurate type information.
> >>>>>>>>
> >>>>>>>> To fix this, ensure the BTF encoder selects the function definition
> >>>>>>>> corresponding to the actual code linked into the binary. This is
> >>>>>>>> achieved by comparing the DWARF function address (DW_AT_low_pc) with
> >>>>>>>> the ELF symbol address (st_value). Only the DWARF entry for the strong
> >>>>>>>> definition will match the final resolved ELF symbol address.
> >>>>>>>>
> >>>>>>>> [0] https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
> >>>>>>>>
> >>>>>>>> Link: https://lore.kernel.org/all/aVJY9H-e83T7ivT4@google.com/
> >>>>>>>> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> >>>>>>> LGTM with some nits below.
> >>>>>> Thanks for the review.
> >>>>>>
> >>>>>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >>>>>>>
> >>>>>>>> ---
> >>>>>>>>    btf_encoder.c | 36 ++++++++++++++++++++++++++++++++++++
> >>>>>>>>    1 file changed, 36 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/btf_encoder.c b/btf_encoder.c
> >>>>>>>> index b37ee7f..0462094 100644
> >>>>>>>> --- a/btf_encoder.c
> >>>>>>>> +++ b/btf_encoder.c
> >>>>>>>> @@ -79,6 +79,7 @@ struct btf_encoder_func_annot {
> >>>>>>>>    /* state used to do later encoding of saved functions */
> >>>>>>>>    struct btf_encoder_func_state {
> >>>>>>>> +	uint64_t addr;
> >>>>>>>>    	struct elf_function *elf;
> >>>>>>>>    	uint32_t type_id_off;
> >>>>>>>>    	uint16_t nr_parms;
> >>>>>>>> @@ -1258,6 +1259,7 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
> >>>>>>>>    	if (!state)
> >>>>>>>>    		return -ENOMEM;
> >>>>>>>> +	state->addr = function__addr(fn);
> >>>>>>>>    	state->elf = func;
> >>>>>>>>    	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
> >>>>>>>>    	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
> >>>>>>>> @@ -1477,6 +1479,29 @@ static void btf_encoder__delete_saved_funcs(struct btf_encoder *encoder)
> >>>>>>>>    	encoder->func_states.cap = 0;
> >>>>>>>>    }
> >>>>>>>> +static struct btf_encoder_func_state *btf_encoder__select_canonical_state(struct btf_encoder_func_state *combined_states,
> >>>>>>>> +									  int combined_cnt)
> >>>>>>>> +{
> >>>>>>>> +	int i, j;
> >>>>>>>> +
> >>>>>>>> +	/*
> >>>>>>>> +	 * The same elf_function is shared amongst combined functions,
> >>>>>>>> +	 * as per saved_functions_combine().
> >>>>>>>> +	 */
> >>>>>>>> +	struct elf_function *elf = combined_states[0].elf;
> >>>>>>> The logic is okay. But can we limit elf->sym_cnt to be 1 here?
> >>>>>>> This will match the case where two functions (weak and strong)
> >>>>>>> co-exist in compiler and eventually only strong/global function
> >>>>>>> will survive.
> >>>>>> In fact, checking again I believe that the loop is redundant because
> >>>>>> elf_function__has_ambiguous_address() ensures that if we reach this
> >>>>>> point, all symbols for the function share the same address. Therefore,
> >>>>>> checking the first symbol (elf->syms[0]) should be sufficient and
> >>>>>> equivalent to checking all of them.
> >>>>>>
> >>>>>> Will send through a v2 with this amendment.
> >>>>> Hm, actually, no. I don't think the addresses stored within
> >>>>> elf->syms[#].addr should all be assumed to be the same at the point
> >>>>> which the new btf_encoder__select_canonical_state() function is called
> >>>>> (due to things like skip_encoding_inconsistent_proto possibly taking
> >>>>> effect). Therefore, I think it's best that we leave things as is and
> >>>>> exhaustively iterate through all elf->syms? I don't believe there's
> >>>>> any adverse effects in doing it this way anyway?
> >>>>
> >>>> No. Your code is correct. For elf->sym_cnt, it covers both sym_cnt
> >>>> is 1 or more than 1. My previous suggestion is to single out the
> >>>> sym_cnt = 1 case since it is what you try to fix.
> >>>>
> >>>> I am okay with the current implementation since it is correct.
> >>>> Maybe Alan and Arnaldo have additional comments about the code.
> >>>
> >>> Sure, sounds good. I think leaving it as is probably our best bet at
> >>> this point.
> >>>
> >>
> >> hi Matt, I ran the change through github CI and there is some differences in
> >> the set of generated functions from vmlinux (see the "Compare functions generated"
> >> step):
> >>
> >> https://github.com/alan-maguire/dwarves/actions/runs/20786255742/job/59698755550
> >>
> >> Specifically we see changes in some function signatures like this:
> >>
> >> < int neightbl_fill_info(struct sk_buff * skb, struct neigh_table * tbl, u32 pid, u32 seq, int type, int flags);
> >> ---
> >>> int neightbl_fill_info(struct sk_buff * skb, struct neigh_table * tbl, u32 pid, u32 seq, int flags, int type);
> >>
> >> Note the reordering of the last two parameters. The "<" line matches the source code, and the
> >> ">" line is what we get from pahole with your change. We've seen this before and the reason is 
> >> that we're not paying close enough attention to cases where the actual function omits parameters
> >> due to optimization; that last "type" parameter doesn't have a DW_AT_location and that indicates 
> >> it's been optimized out. We should really get in this case is:
> >>
> >> int neightbl_fill_info.constprop.0(struct sk_buff * skb, struct neigh_table * tbl, u32 pid, u32 seq, int flags);
> >>
> >> So it's not that your change causes this exactly; it's that paradoxically because
> >> your change does a better job of selecting the real function signature in the CU
> >> (and then we go on to misrepresent it) the problem is more glaringly exposed.
> >>
> >> The good news is I think I have a workable fix for this problem; what I'd propose is - 
> >> presuming it works - we land it prior to your change. Once I've tested that out a bit
> >> I'll follow up. Thanks!
> > 
> > Ha, interesting! Curious, should the .constprop.0 based functions also
> > not be emitted within the generated BTF given that they too
> > technically would exist in the .text section and can be called?
> 
> Yep, but the original policy - that we are changing - was to avoid encoding
> anything that violated source-level expectations. So if a .constprop
> function omitted a parameter it was left out of BTF encoding. But annoyingly
> we often weren't detecting that correctly, so we would up with function signatures
> that had out-of-order parameters which should have been recognized as having
> missng parameters (and thus omitted). We're moving towards the concept of "true" 
> function signatures where we emit a possibly changed function with its "." suffix
> name; see Yonghong's presentation at Linux Plumbers for more details.

Noted, and appreciate the explanation here. I'll also watch Yonghong's
presentation [0] to get a little bit more of an idea on what we're
effectively moving towards.

> I've put together a series that weaves together better detection of
> misordered/missing parameters, optional support for emitting true function 
> signatures for optimized functions and finally your patch. With the prerequisite
> patches in place, your patch (which needed some merging but is essentially the
> same) no longer emits signatures with different ordered parameters; we better
> detect such cases. See [1]; changes are in branch in [2].
> 
> Most of the detected function signature changes are syscalls which have
> the pt_regs "regs" name rather than "__unused"; but in this case:
> 
> < int pcibios_enable_device(struct pci_dev * dev, int bars);
> < void pcibios_fixup_bus(struct pci_bus * bus);
> ---
> > int pcibios_enable_device(struct pci_dev * dev, int mask);
> > void pcibios_fixup_bus(struct pci_bus * b);
> 
> the signatures match the strong rather than weak declarations:
> 
> strong: 
> 
>  int pcibios_enable_device(struct pci_dev *dev, int mask);
>  void pcibios_fixup_bus(struct pci_bus *b);
> 
> weak:
> 
>   int __weak pcibios_enable_device(struct pci_dev *dev, int bars);
>   void __weak pcibios_fixup_bus(struct pci_bus *bus);
> 
> 
> so that's what we want.
>
> I need to do a bit more testing but it seems like this gets the behaviour
> you want without the side-effects due to existing brokenness in pahole.
> Let me know what you think. Thanks!

The prerequisite patches look OK to me, and the detected function
signature modifications bring us closer to where we want to be
IMO. So, LGTM overall.

> [1] https://github.com/alan-maguire/dwarves/actions/runs/20813525302/job/59783355126
> [2] https://github.com/acmel/dwarves/compare/master...alan-maguire:dwarves:refs/heads/pahole-next-true-sig-gcc
> 
> 
> > Apologies if I'm not understanding something correctly here, but my
> > current understanding is that non-.constprop.0 and .constprop.0
> > variants share differing addresses.
> > 
> > Anyway, please keep me updated on how you're progressing with the fix
> > that you're intending to work on.

[0] https://www.youtube.com/watch?v=u4-yWFiIZ98

