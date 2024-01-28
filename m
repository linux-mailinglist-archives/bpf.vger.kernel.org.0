Return-Path: <bpf+bounces-20502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 618C483F284
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 01:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C07286015
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 00:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC71EDF;
	Sun, 28 Jan 2024 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jChqvOU7"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A7DEC7
	for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 00:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706401611; cv=none; b=mOleabcg/CmRRMGmjjktBIidK735fiUad6jkiCt0tUz/2H3vNVpp0LyFrIkfIdrZAeUEqplZv2DsmFQYIOCHm860DgMt3UZ6dVpn3Rm2rC3o6Pj0Vtx9HACD8qer3eZUIHWtZAvw+VLGP5/hIPQ8ZErOU942CLw/BcgoqJnfjBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706401611; c=relaxed/simple;
	bh=Gon1URTQnmmpwTRst5EBiiDcprqGCW8SvXuS/2F5uds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdLOgBLvR0hFDXdoJsQ/63rappwsddqIcDJp3jXS0IevfVLbAqECRykcVJiz+EObOLsoYCbWYYq/uxSrluuWlOI3QYAtNVwpKKy6/CVJxfzF2eKwQJyPLdooe/iyHcX0q0XGunEDPNMy6spwlzQLqFQCnBAlDOg6oMKWoJnKIec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jChqvOU7; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0c3d023f-0f19-47c3-8615-6c1ec006e2d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706401605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UlvAGsTsfOQjrLVpShE065FJTUt/3xb5Fyjt0RjXJhA=;
	b=jChqvOU7iQs7mKKGD9jK5545J+izCdL+6Oqu0F5kTHFRgFdxmiEhkzmcnnj7TpEfK+sCNA
	tE7uj16+y6rVsN6Tz7gN20mDikZ47Uugw+61ZA8fgzzPZ4VzNWcN5ZKtbimcNWwbPWdKlc
	OC2aDtOecnDr1/5aNyABDPSQptwRDF4=
Date: Sat, 27 Jan 2024 16:26:39 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: ISA: BPF_MSH and deprecated packet access instructions
Content-Language: en-GB
To: dthaler1968@googlemail.com
Cc: bpf@ietf.org, bpf@vger.kernel.org
References: <006601da5151$a22b2bb0$e6818310$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <006601da5151$a22b2bb0$e6818310$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/27/24 10:50 AM, dthaler1968@googlemail.com wrote:
> Under "Load and store instructions", various mode modifiers are documented.
> I notice that BPF_MSH (0xa0) is not documented, but appears to be in use in
> various projects, including Linux, BSD, seccomp, etc. and is even documented
> in various books such as
> https://www.google.com/books/edition/Programming_Linux_Hacker_Tools_Uncovere
> d/yqHVAwAAQBAJ?hl=en&gbpv=1&dq=%22BPF_MSH%22&pg=PA129&printsec=frontcover
>
> Should we document it as deprecated and add it to the set of deprecated
> instructions (the legacy conformance group) like BPF_ABS and BPF_IND
> already are?
>
> Also, for purposes of the IANA registry of instructions where we list which
> opcodes are "(deprecated, implementation-specific)", I currently list all
> possible BPF_ABS and BPF_IND opcodes regardless of whether they were
> ever used (I didn't check which were used and which might not have been),
> so I could just list all possible BPF_MSH opcodes similarly.  But if we know
> that some were never used then I don't need to do so, so I guess I should
> ask:
> do we have a list of which combinations were actually used or should we
> continue to just deprecate all combinations?
>
> As an example,
> https://github.com/seccomp/libseccomp/blob/main/tools/scmp_bpf_disasm.c#L68
> lists 6 variants of BPF_MSH: LD and LDX, for B, H, and W (but not DW).
> Other sources like the book page referenced above, and the BSD man page,
> list only BPF_LDX | BPF_B | BPF_MSH, which is in Linux sources such as
> https://elixir.bootlin.com/linux/v6.8-rc1/source/lib/test_bpf.c#L368

 From kernel source code (net/core/filter.c), the only supported format is
    BPF_LDX | BPF_MSH | BPF_B

The insn (BPF_LDX | BPF_MSH | BPF_B) is only used when cBPF (classic BPF)
is converted to BPF insn set. If the current BPF program has this insn,
verifier will reject it and bpf kernel interpreter does not support this
insn either. So technically, (BPF_LDX | BPF_MSH | BPF_B) is not supported
by BPF program.

>
> So, should we list the DW variants as deprecated, or never assigned?
> Should we list the H, W, and LD variants as deprecated, or never assigned?
>
> What about DW and LDX variants of BPF_IND and BPF_ABS?
>
>
>

