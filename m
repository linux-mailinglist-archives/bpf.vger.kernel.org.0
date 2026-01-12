Return-Path: <bpf+bounces-78595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7397ED13F61
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 17:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE778304A937
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD013659ED;
	Mon, 12 Jan 2026 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="ZHtdUA7u"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-3.rrze.uni-erlangen.de (mx-rz-3.rrze.uni-erlangen.de [131.188.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B52F253B58
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234809; cv=none; b=r9rapeBoeQMEeaWpJjWGB2eZq7Cj8BmmUX8ybtTUlmQfsyyUJQdP/MNL6Kmld4/c77sxGFv7MGVwiocsXZbs0GB0ZMQoy5vAMfz+ufFbs85pvNQ5ycMyXQHAXbB2HG7IjWoA/gbIUYux625S+Yuhb1uzXuxhOpPFdsoCAFYos3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234809; c=relaxed/simple;
	bh=tUc9Q/oMnYnODW3Z++sE1me+kjKQ9hSxhuEmMaYyGlY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u5w61siGABkQdmC1+f5sVDetfbooDg5l4IlpkyvHH/OSSpnfo3QYHLyaQMrw1PsVPE94AZ3oCK7hD2TM7TsgorlM0nX/+t+mwkzkXSV2m/AlgnMIObxI6Bqlvr4CWqOWSLRUA9CbNihT3FByM6vuyEv3AxueUCpFJkEND2PbucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=ZHtdUA7u; arc=none smtp.client-ip=131.188.11.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1768234797; bh=RqX/vky+UNW9xKSctpg5nFA8rzq/cW5E6wMsBZvyU8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=ZHtdUA7uH3O9YWXDsMZ+YAwzejWDldOUMQ1X8LdSJvngxspuoaWwYlZrtL1FxbMW0
	 WLr8eC1PMTtCIxFKdRISEUZKcFaqpKvAuqb4250m30XfBNaMRO4maO5XUlmoqA5aLD
	 IpQiUQcvtSeKSoHL++LbfVwiZDtlB29xRCIBaa+H94v0Vjt7LXZpgncMYEN6XzKFw2
	 KcbyzdamQfomqU0J0fkDysJLPXjYTSDQ8qxzDhQRy6wa2c3MgKXXw6IuM1RzUeoa1f
	 R5S0S+VzJLasGEvuxqV9iNlOb+YjRlq5JxhHmAlbITvNu2B/3yH0qnjll1DckJUu0R
	 +6MAwOFo/F1Mg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4dqczK5Ghqz1xwY;
	Mon, 12 Jan 2026 17:19:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.188.34.184
Received: from localhost (i4laptop33.informatik.uni-erlangen.de [10.188.34.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX187v+eh7YPaxIMjP2GckqUrelMzN9JbkRM=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4dqczG6ggBz20VM;
	Mon, 12 Jan 2026 17:19:54 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: "Stefan O'Rear" <sorear@fastmail.com>,  "Lukas Gerlach"
 <lukas.gerlach@cispa.de>
Cc: tech-speculation-barriers@lists.riscv.org,  bpf@vger.kernel.org,
  linux-riscv@lists.infradead.org,  =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>,
  "Alexei Starovoitov" <ast@kernel.org>,  "Daniel Borkmann"
 <daniel@iogearbox.net>,  luke.r.nels@gmail.com,  xi.wang@gmail.com,
  "Palmer Dabbelt" <palmer@dabbelt.com>,  daniel.weber@cispa.de,
  marton.bognar@kuleuven.be,  jo.vanbulck@kuleuven.be,
  michael.schwarz@cispa.de
Subject: Re: [tech-speculation-barriers] [PATCH] riscv, bpf: Emit fence.i
 for BPF_NOSPEC
In-Reply-To: <bc21940d-08ef-4d09-90e0-8611ebddc56d@app.fastmail.com> (Stefan
	O'Rear's message of "Fri, 09 Jan 2026 00:36:48 -0500")
References: <20251228173753.56767-1-lukas.gerlach@cispa.de>
	<702eb23c-7205-4de1-b56d-eedac6feae46@gmail.com>
	<bc21940d-08ef-4d09-90e0-8611ebddc56d@app.fastmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 12 Jan 2026 17:19:54 +0100
Message-ID: <87zf6iiz11.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Stefan O'Rear" <sorear@fastmail.com> writes:

> On Thu, Jan 8, 2026, at 10:37 PM, Bo Gan via lists.riscv.org wrote:
>> Hi Lukas,
>>
>> Stefan and I have some doubts on fence.i's effectiveness as speculation
>> barrier. Flushing entire local instruction cache and instruction pipeline
>> is not absolutely necessary on impl having coherent I/D caches. Quoting
>> from Unprivileged SPEC ver. 20250508:
>>
>> "The FENCE.I instruction was designed to support a wide variety of
>>   implementations. A simple implementation can flush the local instruction
>>   cache and the instruction pipeline when the FENCE.I is executed. A more
>>   complex implementation might snoop the instruction (data) cache on every
>>   data (instruction) cache miss, or use an inclusive unified private L2
>>   cache to invalidate lines from the primary instruction cache when they
>>   are being written by a local store instruction. If instruction and data
>>   caches are kept coherent in this way, or if the memory system consists of
>>   only uncached RAMs, then just the fetch pipeline needs to be flushed at a
>>   FENCE.I"
>
> Note that this is non-normative text and the actual range of allowed
> implementations is wider than this.
>
> I'm particularly concerned that the security property we appear to need (I am
> more familiar with u-arch vulnerabilities than BPF ISA details) is an _issue
> barrier_, but correctness for FENCE.I as currently specified only requires
> a _retirement barrier_.

> FENCE.I requires that instructions after the FENCE.I in program order not
> retire unless the hart can verify that they were not overwritten in memory
> between the time they were fetched and the memory-order point of the FENCE.I.
> Simple implementations will probably achieve this by re-fetching and
> preventing retirement of all instructions after the FENCE.I,

Are you aware of any CPU implementation that works like this?

> but if the
> instructions speculatively execute then it is not useful for a Spectre v1
> barrier.

You are correct. However, I believe a retirement barrier would still
already be useful as a stopgap solution as it should still reduce the
success rate and therefore the bandwith of the exploit. Also, because
the verifier currently adds barriers very early (it does not only add
the barrier before the non-CT operation on a secret but already when
anything that is not allowed architecturally happens), it might actually
prevent some exploits. This does of course not offer full protection,
but it still makes it harder to develop working exploits.

> Issuing an instruction which cannot possibly retire wastes energy,
> but if FENCE.I is assumed to be an extremely rare operation this may not be
> a priority.
>
> Particularly complex implementations can go as far as to treat FENCE.I as a
> no-op if they snoop the reorder buffer as well as the instruction cache.
>
>> There's the question on overhead, too. Perhaps there's a more accurate and
>> lightweight insn available? I'm not an expert in u-arch. My gut feeling is
>> that we should not be dependent on specific impl's behavior and the riscv
>> SPEC should provide guidelines on speculation barrier instructions and how
>> to use them. Thus, I'm forwarding this to the Speculation Barriers Task-
>> Group, which I hope should be the perfect place to discuss such kind of
>> issues. @Speculation Barriers TG Please share your thoughts. Note that we
>> are dealing with existing HW, so we expect something to be working with
>> current SPEC and actual silicon. I'd be happy if I'm proven wrong, and
>> fence.i can actually be a speculation barrier. That's also a relief. Thank
>> you everyone.
>
> The JH7110 has 512 I-cache lines per core, all of which must be invalidated
> on a FENCE.I. I'm not sure how many cycles that takes for the invalidation,
> but some fraction of those will subsequently be needed before they would
> otherwise be evicted, which could add up to several thousand cycles of
> overhead depending on the cache miss latency, for a BPF program with a single
> BPF_NOSPEC. Compared to roughly one thousand cycles for a kernel entry and
> exit, it may be more practical to disable BPF and rely on userspace event
> processing for affected hardware, even if FENCE.I is otherwise useful as a
> speculation barrier.

Thank you very much. For JH7110 I think it would then be best to avoid
adding anything unless there is any strong evidence showing this CPU is
vulnerable to Spectre v1. (A quick search yielded no result but maybe
someone else has more information on this.) Even if it is vulnerable,
people might want performant unprivileged eBPF simply for compatibility
reasons. As we can not know whether untrusted unprivileged users are
actually a concern, a dmesg warning might be best then. Or maybe there
is some other construct that achieves the desired effect on JH7110.

> I don't think it's possible to define a set of speculation barriers that apply
> to all possible existing and future hardware with the current specifications,
> because the ratified specifications cannot be changed and other than Zkt/Zvkt
> do not constrain uarch side channels.
>
> The TG is defining a new specification which includes semantically rich
> barriers that can have optimal overhead on new hardware. If we find a set of
> speculation barriers that work on some or (optimistically) all existing
> hardware, we would need to define a retroactive specification which documents
> that behavior, much like Zkt/Zvkt or many of the extensions defined in the
> profiles specification.

That would be very useful to eBPF.

Are you aware of any existing RISC-V CPU implementations where FENCE.I,
or any other instruction, does delay issueing/retirement by a few cycles
(e.g., until concurrent stores have completed)? (I am aware that
retirement is not sufficient formally, but it is better than nothing.)
Anything like this might be preferable over simply filling up the
reorder buffer with some NOP instruction. And even if a part of the CPU
state may still be speculative, any such instruction would already be
useful as a (partial) stopgap solution.

Or does FENCE.I do this on any concrete CPU other than JH7110?

