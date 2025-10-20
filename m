Return-Path: <bpf+bounces-71409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 887FBBF247E
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEF118A200E
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4EF2820A0;
	Mon, 20 Oct 2025 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SDtd4oxj"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929AF27B336
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976116; cv=none; b=G4BW9oR20RcBbeJibB7C81sfv//ecxPLHrtMNIqfk9PLcFO2tDXHE/bYKEqVPmkHk4RO6IkoASphAOi2lvUXYRL4TaD8/Vphr5EIExbZWr9b39GzX15aDnM5E5TwUJZnF/XXYgn5iIw7xSe8o43xMEMbXWsNnClEXIRtxa7kCKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976116; c=relaxed/simple;
	bh=GiHAiIIVbXauH1Q+fNGPsqihBXYbFXABqD6QrGoFOes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueirPgeT38G46Vj9gLdeSChJoSRWpNdaG9ywPaW6/Wdt6uM619VSs4bvf7DDs/RwSfNHhHkKxQ3TgUMctfXAhk+iN+RW5RwKCrHzoR+o3iXLPYnNN1yKrC9Kk5ZDakGMrx6A4MpvWGb3d5mPxNZ0JZkiIKBOhtonVtkFbXzwpCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SDtd4oxj; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <984c45b9-fc67-4077-af52-d9464608fede@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760976112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0QAwz8KGDbw0UVvDjkaTvDgbdVhC3TrDvWfh3leVMw=;
	b=SDtd4oxjDGK+qOi+Chl28pUv3chJzZKU60lvfdvk6XH8+vgealYTTXgZ4lbYQ9G/suGrwB
	Fc4vWQ9MWsdKcIp915HeOlJQ7R8i6Ks1yJ6nVg2yRCEEy5bqnx7yf0qoh/kTaQGHUVJFkF
	TnBLg+3Ak30nqaFHiCRchz6Cr9LuogA=
Date: Mon, 20 Oct 2025 09:01:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves] pahole: Avoid generating artificial inlined
 functions for BTF
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
References: <20251003173620.2892942-1-yonghong.song@linux.dev>
 <2dce0093-9376-4c06-b306-7e7d5660aadf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2dce0093-9376-4c06-b306-7e7d5660aadf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/20/25 3:53 AM, Alan Maguire wrote:
> On 03/10/2025 18:36, Yonghong Song wrote:
>> In llvm pull request [1], the dwarf is changed to accommodate functions
>> whose signatures are different from source level although they have
>> the same name. Other non-source functions are also included in dwarf.
>>
>> The following is an example:
>>
>> The source:
>> ====
>>    $ cat test.c
>>    struct t { int a; };
>>    char *tar(struct t *a, struct t *d);
>>    __attribute__((noinline)) static char * foo(struct t *a, struct t *d, int b)
>>    {
>>      return tar(a, d);
>>    }
>>    char *bar(struct t *a, struct t *d)
>>    {
>>      return foo(a, d, 1);
>>    }
>> ====
>>
>> Part of generated dwarf:
>> ====
>> 0x0000005c:   DW_TAG_subprogram
>>                  DW_AT_low_pc    (0x0000000000000010)
>>                  DW_AT_high_pc   (0x0000000000000015)
>>                  DW_AT_frame_base        (DW_OP_reg7 RSP)
>>                  DW_AT_linkage_name      ("foo")
>>                  DW_AT_name      ("foo")
>>                  DW_AT_decl_file ("/home/yhs/tests/sig-change/deadarg/test.c")
>>                  DW_AT_decl_line (3)
>>                  DW_AT_type      (0x000000bb "char *")
>>                  DW_AT_artificial        (true)
>>                  DW_AT_external  (true)
>>
>> 0x0000006c:     DW_TAG_formal_parameter
>>                    DW_AT_location        (DW_OP_reg5 RDI)
>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadarg/test.c")
>>                    DW_AT_decl_line       (3)
>>                    DW_AT_type    (0x000000c4 "t *")
>>
>> 0x00000075:     DW_TAG_formal_parameter
>>                    DW_AT_location        (DW_OP_reg4 RSI)
>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadarg/test.c")
>>                    DW_AT_decl_line       (3)
>>                    DW_AT_type    (0x000000c4 "t *")
>>
>> 0x0000007e:     DW_TAG_inlined_subroutine
>>                    DW_AT_abstract_origin (0x0000009a "foo")
>>                    DW_AT_low_pc  (0x0000000000000010)
>>                    DW_AT_high_pc (0x0000000000000015)
>>                    DW_AT_call_file       ("/home/yhs/tests/sig-change/deadarg/test.c")
>>                    DW_AT_call_line       (0)
>>
>> 0x0000008a:       DW_TAG_formal_parameter
>>                      DW_AT_location      (DW_OP_reg5 RDI)
>>                      DW_AT_abstract_origin       (0x000000a2 "a")
>>
>> 0x00000091:       DW_TAG_formal_parameter
>>                      DW_AT_location      (DW_OP_reg4 RSI)
>>                      DW_AT_abstract_origin       (0x000000aa "d")
>>
>> 0x00000098:       NULL
>>
>> 0x00000099:     NULL
>>
>> 0x0000009a:   DW_TAG_subprogram
>>                  DW_AT_name      ("foo")
>>                  DW_AT_decl_file ("/home/yhs/tests/sig-change/deadarg/test.c")
>>                  DW_AT_decl_line (3)
>>                  DW_AT_prototyped        (true)
>>                  DW_AT_type      (0x000000bb "char *")
>>                  DW_AT_inline    (DW_INL_inlined)
>>
>> 0x000000a2:     DW_TAG_formal_parameter
>>                    DW_AT_name    ("a")
>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadarg/test.c")
>>                    DW_AT_decl_line       (3)
>>                    DW_AT_type    (0x000000c4 "t *")
>>
>> 0x000000aa:     DW_TAG_formal_parameter
>>                    DW_AT_name    ("d")
>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadarg/test.c")
>>                    DW_AT_decl_line       (3)
>>                    DW_AT_type    (0x000000c4 "t *")
>>
>> 0x000000b2:     DW_TAG_formal_parameter
>>                    DW_AT_name    ("b")
>>                    DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadarg/test.c")
>>                    DW_AT_decl_line       (3)
>>                    DW_AT_type    (0x000000d8 "int")
>>
>> 0x000000ba:     NULL
>> ====
>>
>> In the above, there are two subprograms with the same name 'foo'.
>> Currently btf encoder will consider both functions as ELF functions.
>> Since two subprograms have different signature, the funciton will
>> be ignored.
>>
>> But actually, one of function 'foo' is marked as DW_INL_inlined which means
>> we should not treat it as an elf funciton. The patch fixed this issue
>> by filtering subprograms if the corresponding function__inlined() is true.
>>
>> This will fix the issue for [1]. But it should work fine without [1] too.
>>
>>    [1] https://github.com/llvm/llvm-project/pull/157349
> The change itself looks fine on the surface but it has some odd
> consequences that we need to find a solution for.
>
> Specifically in CI I was seeing an error in BTF-to-DWARF function
> comparison:
>
> https://github.com/alan-maguire/dwarves/actions/runs/18376819644/job/52352757287#step:7:40
>
> 1: Validation of BTF encoding of functions; this may take some time:
> ERROR: mismatch : BTF '__be32 ip6_make_flowlabel(struct net *, struct
> sk_buff *, __be32, struct flowi6 *, bool);' not found; DWARF ''
>
> Further investigation reveals the problem; there is a constprop variant
> of ip6_make_flowlabel():
>
> ffffffff81ecf390 t ip6_make_flowlabel.constprop.0
>
> ..and the problem is it has a different function signature:
>
> __be32 ip6_make_flowlabel(struct net *, struct sk_buff *, __be32, struct
> flowi6 *, bool);
>
> The "real" function (that was inlined, other than the constprop variant)
> looks like this:
>
> static inline __be32 ip6_make_flowlabel(struct net *net, struct sk_buff
> *skb,
>   					__be32 flowlabel, bool autolabel,
>   					struct flowi6 *fl6);
>
> i.e. the last two parameters are in a different order.

It is interesting that gcc optimization may change parameter orders...

>
> Digging into the DWARF representation, the .constprop function uses an
> abstract origin reference to the original function. In the case prior to
> your change, we would have compared function signatures across both
> representations and found the inconsistency and then avoided emitting
> BTF for the function.
>
> However with your change, we no longer add a function representation for
> the inline case to contrast with and detect that inconsistency.
>
> So that's the core problem; your change is trying to avoid comparing
> across inlined and uninlined functions with the same name/prefix, but
> sometimes we need to do exactly that to detect inconsistent
> representations when they really are inlined/uninlined instances of the
> same function. I don't see an easy answer here since it seems to me both
> are legitimate cases.

The upstream does not like llvm pull request (associated with this patch)
so it is totally ok to discard this patch. Sorry, I think generally
we should only care about the *real* functions. But I missed that
you want to compare signatures of the *read* functions and *inlined* functions.

>
> I'm hoping we can use BTF location info [1] to cover cases like this
> where we have inconsistencies between types in parameters. Rather than
> having to decide which case is correct we simply use location
> representations for the cases where we are unsure. This will make such
> cases safely traceable since we have info about where parameters are stored.

Indeed this could solve the inlined functions problem. Again, please discard
this patch for now.

>
> [1]
> https://lore.kernel.org/bpf/20251008173512.731801-1-alan.maguire@oracle.com/
>


