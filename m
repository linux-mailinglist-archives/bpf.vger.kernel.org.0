Return-Path: <bpf+bounces-78278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC09DD0738C
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 06:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFC81300CB66
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 05:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A636225A35;
	Fri,  9 Jan 2026 05:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="aHfzTfyi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OtZ7UMkL"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AD178F3E
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 05:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767937034; cv=none; b=uoljICBojbDLU3gG5lUGJ2JeIRgxYgS6R/YDGTqmPq+WK5QrleVf99fP4LMzBgh47AoO4bophGR4SUQoXoZPDeoiPCV5ELYQw9+ceThnI0/WzOlHobCBbqkLl1j3sGcOtUTT8BmIP2V1/8YrcMaLb5+2v+KOZjpGOnjtpl5T428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767937034; c=relaxed/simple;
	bh=eEy8hHxCodw/Zl8D86wtbg6f83QUalRsJ+ihMR9IQDg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OobKXh3DYen+JFEhnKdq1VGiRceRjVrb0WhzzVTCUUeVEGJjYySCE9aTHXmGj479TmKRZ9v849vshOo0Ph43JkfFEtBsgjv12P14BEjVO18waFlu1hhDP4b9IOxCFvt40MhWaqz54vkse3ZflntMJKZvg57jfputaFtnYN3btfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=aHfzTfyi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OtZ7UMkL; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 37B367A0122;
	Fri,  9 Jan 2026 00:37:10 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 00:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767937030;
	 x=1768023430; bh=UHcT9QNQAYnFAiQhNlj6/BokZ8RBlhn9zduw09wu7Zw=; b=
	aHfzTfyi9WWc/DDOcb2bb5+XpsKzlscvWXWZARQ3RcywLgqk9i7n/R7C9b9ZjRZT
	ukBWewI3WVfKsnM4maecGWg6vpPxXP6K6iDPlt8E0yGs5+wni94+y41omD93O6gW
	LmI9jRfQqL4F0ftBjoSu9oxzwNj/nRKBebrHkUNa32QJ9nQGnstNM37Y6qy2cYpA
	yWLCFBqCK3mpG6jMflr8Aj3C6schJ6u95GMF/tIGyz2PaioalWK/nY5Es3LtCGs3
	FvvpI+QuXW+uqioOQe+oPnY75ug1YK7+EjZwjH1++6WIrU9iTbVrGCeAhDUkWVx3
	fiZ4sSaIkE6RKlGokwVRDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767937030; x=
	1768023430; bh=UHcT9QNQAYnFAiQhNlj6/BokZ8RBlhn9zduw09wu7Zw=; b=O
	tZ7UMkLUZUgyxjN0I+S+95xpQc5QyXV8NnajGq8SdMVcfOn24uOGwSli8BLLKbf6
	U4S88tYEGrwZFMdbW0kZ81b7xX7xXo+lJ8xgKnVzD5BNMet2KOH828s45+2XBL61
	hJRUnU3UPVnnkMlNgxnFxYV5364tf8hRRqnHRwUdOyW08dWI3GNSyPB+nditKLoY
	RdR7rdE2PxKyKea+QRLS6wHjzwIV/H2Ulln8DKgH7eJmK3VaKzqHjrvZ8qpE9VWf
	Tjge4QyAxa++089ciTMDFTbUmHiYRvarGdCusgurLS7oXebz6u2gptA1hwQy66mQ
	c4Nib1Wy+F/yqgcSuctWg==
X-ME-Sender: <xms:BJRgaV4PXYliab-2kGGZR37iLMBtjar0HawVbm77AFtmFE0BkmcZPA>
    <xme:BJRgadvSpKK6UWYnX-fVEHe3b16CX9MFSWYTJbR-THqX3w9u8EhESFzqoKwvyfOCB
    hIN6I0FuIgRMvLhcYdlJLp-qDf4CO0gYlQwbtxrT8WOn8w8OeJ9jeI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdejleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfufhtvghf
    rghnucfqkdftvggrrhdfuceoshhorhgvrghrsehfrghsthhmrghilhdrtghomheqnecugg
    ftrfgrthhtvghrnhepgfegfedtuefhfeeuffegleeiveelhfdujeffgeetffefueetjedv
    fedvieduudetnecuffhomhgrihhnpehrihhstghvrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhorhgvrghrsehfrghsthhmrghi
    lhdrtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegurghnihgvlhdrfigvsggvrhestghishhprgdruggvpdhrtghpthhtoheplhhu
    khgrshdrghgvrhhlrggthhestghishhprgdruggvpdhrtghpthhtohepmhhitghhrggvlh
    drshgthhifrghriiestghishhprgdruggvpdhrtghpthhtohepphgrlhhmvghrsegurggs
    sggvlhhtrdgtohhmpdhrtghpthhtoheplhhuihhsrdhgvghrhhhorhhsthesfhgruhdrug
    gvpdhrtghpthhtoheplhhukhgvrdhrrdhnvghlshesghhmrghilhdrtghomhdprhgtphht
    thhopeigihdrfigrnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrnhhivghlse
    hiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtoheprghstheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BZRgaS9FRExT86q-yhEZ_YjVdccUJXZ1MqK8A4EcsE2Cbd0DOcbJjg>
    <xmx:BZRgaTIiOIxFk-j5YizDFVgPF5zINsvjsJNaPEQ8652ZEuqGkoMo1A>
    <xmx:BZRgaXzrmmVddyig6v4Wt-AR9lB4CxychJZ85EKWmKM_K0MKzD1Ptg>
    <xmx:BZRgaW17aWdgcKrM6M5Vka7Ci6_IMv-JprOZqprND-S3KHxnNHZR3A>
    <xmx:BpRgaXfow9VeVERx32sXnRvbTQarEGTLqpnOJWS6xidS3foqXnBOoJdr>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E4F66C40072; Fri,  9 Jan 2026 00:37:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWLaPGf1n143
Date: Fri, 09 Jan 2026 00:36:48 -0500
From: "Stefan O'Rear" <sorear@fastmail.com>
To: tech-speculation-barriers@lists.riscv.org,
 "Lukas Gerlach" <lukas.gerlach@cispa.de>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org
Cc: =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, luke.r.nels@gmail.com,
 xi.wang@gmail.com, "Palmer Dabbelt" <palmer@dabbelt.com>,
 luis.gerhorst@fau.de, daniel.weber@cispa.de, marton.bognar@kuleuven.be,
 jo.vanbulck@kuleuven.be, michael.schwarz@cispa.de
Message-Id: <bc21940d-08ef-4d09-90e0-8611ebddc56d@app.fastmail.com>
In-Reply-To: <702eb23c-7205-4de1-b56d-eedac6feae46@gmail.com>
References: <20251228173753.56767-1-lukas.gerlach@cispa.de>
 <702eb23c-7205-4de1-b56d-eedac6feae46@gmail.com>
Subject: Re: [tech-speculation-barriers] [PATCH] riscv, bpf: Emit fence.i for
 BPF_NOSPEC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jan 8, 2026, at 10:37 PM, Bo Gan via lists.riscv.org wrote:
> Hi Lukas,
>
> Stefan and I have some doubts on fence.i's effectiveness as speculation
> barrier. Flushing entire local instruction cache and instruction pipeline
> is not absolutely necessary on impl having coherent I/D caches. Quoting
> from Unprivileged SPEC ver. 20250508:
>
> "The FENCE.I instruction was designed to support a wide variety of
>   implementations. A simple implementation can flush the local instruction
>   cache and the instruction pipeline when the FENCE.I is executed. A more
>   complex implementation might snoop the instruction (data) cache on every
>   data (instruction) cache miss, or use an inclusive unified private L2
>   cache to invalidate lines from the primary instruction cache when they
>   are being written by a local store instruction. If instruction and data
>   caches are kept coherent in this way, or if the memory system consists of
>   only uncached RAMs, then just the fetch pipeline needs to be flushed at a
>   FENCE.I"

Note that this is non-normative text and the actual range of allowed
implementations is wider than this.

I'm particularly concerned that the security property we appear to need (I am
more familiar with u-arch vulnerabilities than BPF ISA details) is an _issue
barrier_, but correctness for FENCE.I as currently specified only requires
a _retirement barrier_.

FENCE.I requires that instructions after the FENCE.I in program order not
retire unless the hart can verify that they were not overwritten in memory
between the time they were fetched and the memory-order point of the FENCE.I.
Simple implementations will probably achieve this by re-fetching and
preventing retirement of all instructions after the FENCE.I, but if the
instructions speculatively execute then it is not useful for a Spectre v1
barrier. Issuing an instruction which cannot possibly retire wastes energy,
but if FENCE.I is assumed to be an extremely rare operation this may not be
a priority.

Particularly complex implementations can go as far as to treat FENCE.I as a
no-op if they snoop the reorder buffer as well as the instruction cache.

> There's the question on overhead, too. Perhaps there's a more accurate and
> lightweight insn available? I'm not an expert in u-arch. My gut feeling is
> that we should not be dependent on specific impl's behavior and the riscv
> SPEC should provide guidelines on speculation barrier instructions and how
> to use them. Thus, I'm forwarding this to the Speculation Barriers Task-
> Group, which I hope should be the perfect place to discuss such kind of
> issues. @Speculation Barriers TG Please share your thoughts. Note that we
> are dealing with existing HW, so we expect something to be working with
> current SPEC and actual silicon. I'd be happy if I'm proven wrong, and
> fence.i can actually be a speculation barrier. That's also a relief. Thank
> you everyone.

The JH7110 has 512 I-cache lines per core, all of which must be invalidated
on a FENCE.I. I'm not sure how many cycles that takes for the invalidation,
but some fraction of those will subsequently be needed before they would
otherwise be evicted, which could add up to several thousand cycles of
overhead depending on the cache miss latency, for a BPF program with a single
BPF_NOSPEC. Compared to roughly one thousand cycles for a kernel entry and
exit, it may be more practical to disable BPF and rely on userspace event
processing for affected hardware, even if FENCE.I is otherwise useful as a
speculation barrier.

I don't think it's possible to define a set of speculation barriers that apply
to all possible existing and future hardware with the current specifications,
because the ratified specifications cannot be changed and other than Zkt/Zvkt
do not constrain uarch side channels.

The TG is defining a new specification which includes semantically rich
barriers that can have optimal overhead on new hardware. If we find a set of
speculation barriers that work on some or (optimistically) all existing
hardware, we would need to define a retroactive specification which documents
that behavior, much like Zkt/Zvkt or many of the extensions defined in the
profiles specification.

> BTW, per SPEC:
>
>   "The FENCE.I only synchronizes the local hart, and the OS can reschedule
>    the user hart to a different physical hart after the FENCE.I. This would
>    require the OS to execute an additional FENCE.I as part of every context
>    migration"
>
> fence.i is local. I know some core does a broadcast and try to make it a
> global fence.i, but this is not required by the SPEC.

The speculation fences that are used on other architectures are all core-local
operations so I don't think this is, itself, a problem.

-s

> Bo
>
> On 12/28/25 09:37, Lukas Gerlach wrote:
>> The BPF verifier inserts BPF_NOSPEC instructions to create speculation
>> barriers. However, the RISC-V BPF JIT emits nothing for this
>> instruction, leaving programs vulnerable to speculative execution
>> attacks.
>> 
>> Originally, BPF_NOSPEC was used only for Spectre v4 mitigation, programs
>> containing potential Spectre v1 gadgets were rejected by the verifier.
>> With the VeriFence changes, the verifier now accepts these
>> programs and inserts BPF_NOSPEC barriers for Spectre v1 mitigation as
>> well. On RISC-V, this means programs that were previously rejected are
>> now accepted but left unprotected against both v1 and v4 attacks.
>> 
>> RISC-V lacks a dedicated speculation barrier instruction.
>> This patch uses the fence.i instruction as a stopgap solution.
>> However an alternative and safer approach would be to reject vulnerable bpf
>> programs again.
>> 
>> Fixes: f5e81d111750 ("bpf: Introduce BPF nospec instruction for mitigating Spectre v4")
>> Fixes: 5fcf896efe28 ("Merge branch 'bpf-mitigate-spectre-v1-using-barriers'")
>> Signed-off-by: Lukas Gerlach <lukas.gerlach@cispa.de>
>> ---
>>   arch/riscv/net/bpf_jit.h        | 10 ++++++++++
>>   arch/riscv/net/bpf_jit_comp32.c |  6 +++++-
>>   arch/riscv/net/bpf_jit_comp64.c |  6 +++++-
>>   3 files changed, 20 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>> index 632ced07bca4..e70b3bc19206 100644
>> --- a/arch/riscv/net/bpf_jit.h
>> +++ b/arch/riscv/net/bpf_jit.h
>> @@ -619,6 +619,16 @@ static inline void emit_fence_rw_rw(struct rv_jit_context *ctx)
>>   	emit(rv_fence(0x3, 0x3), ctx);
>>   }
>>   
>> +static inline u32 rv_fence_i(void)
>> +{
>> +	return rv_i_insn(0, 0, 1, 0, 0x0f);
>> +}
>> +
>> +static inline void emit_fence_i(struct rv_jit_context *ctx)
>> +{
>> +	emit(rv_fence_i(), ctx);
>> +}
>> +
>>   static inline u32 rv_nop(void)
>>   {
>>   	return rv_i_insn(0, 0, 0, 0, 0x13);
>> diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
>> index 592dd86fbf81..d9a6f55a7e8e 100644
>> --- a/arch/riscv/net/bpf_jit_comp32.c
>> +++ b/arch/riscv/net/bpf_jit_comp32.c
>> @@ -1248,8 +1248,12 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>   			return -1;
>>   		break;
>>   
>> -	/* speculation barrier */
>> +	/*
>> +	 * Speculation barrier using fence.i for pipeline serialization.
>> +	 * RISC-V lacks a dedicated speculation barrier instruction.
>> +	 */
>>   	case BPF_ST | BPF_NOSPEC:
>> +		emit_fence_i(ctx);
>>   		break;
>>   
>>   	case BPF_ST | BPF_MEM | BPF_B:
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index 45cbc7c6fe49..fabafbebde0c 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -1864,8 +1864,12 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>>   		break;
>>   	}
>>   
>> -	/* speculation barrier */
>> +	/*
>> +	 * Speculation barrier using fence.i for pipeline serialization.
>> +	 * RISC-V lacks a dedicated speculation barrier instruction.
>> +	 */
>>   	case BPF_ST | BPF_NOSPEC:
>> +		emit_fence_i(ctx);
>>   		break;
>>   
>>   	/* ST: *(size *)(dst + off) = imm */
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19): 
> https://lists.riscv.org/g/tech-speculation-barriers/message/19
> Mute This Topic: https://lists.riscv.org/mt/117170030/7725087
> Group Owner: tech-speculation-barriers+owner@lists.riscv.org
> Unsubscribe: 
> https://lists.riscv.org/g/tech-speculation-barriers/leave/14814957/7725087/301854996/xyzzy 
> [sorear@fastmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-

