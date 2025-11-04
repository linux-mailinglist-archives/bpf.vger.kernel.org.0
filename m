Return-Path: <bpf+bounces-73430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0D9C31171
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 13:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA563BF443
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 12:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EDA2EC576;
	Tue,  4 Nov 2025 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="Q/kOFyk8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B445221FB1
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260898; cv=none; b=Lav6WiQKYO8jcvkdGrpeUCAMOViJVYK5g0To2fEqkmrEus8y2Ejt5Emq29WWdmV6ErC4U/UL2FRbNQGuGLVwkZ0gyDjAN7bnpV4p3rbWcbcPw6llBOGzKMQzRAtDO+rmYWlDlqOMit1H0w19ZdshIoM8P2bNCSL/JaRxtHN2jNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260898; c=relaxed/simple;
	bh=Zyg/jWkgxmL/TrpSdm3SwUTBEJzw9+TjGs5f03o4NNg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NFlAQlz2a20fconaOA25UwiPtSTezJZuq5EB93VCglT8P41auNUJ2SDfVRea54NnSSsxSWy5TKXCD3BmBFIzaN5H+xm61yjsgZ3UO3YVaH4bWsSGT09KWWO1BVDZgF47hkolf1qbYLH7bj9hHZzW9Tc8B0018K4Fyjx0qqxUyeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=pass smtp.mailfrom=xfel.eu; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=Q/kOFyk8; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfel.eu
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-1.desy.de (Postfix) with ESMTP id E116411F749
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 13:54:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de E116411F749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1762260886; bh=Zyg/jWkgxmL/TrpSdm3SwUTBEJzw9+TjGs5f03o4NNg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Q/kOFyk8Tdpp2ae58+jglcMqQ2aJDrqG3OtI/C+rbd8gKMc4Hu9j5EUR50sjVLhR2
	 0WfWMYNV68CV/XPAeLfn/mcg+NcYpbpL11Up2v7B3zO9uBT+QCMBlTbQBYn3cbXJ9C
	 q1xvSMwDnp6KyHJPLx94loxdrpnaFxtXdaRiYNiw=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id D42F1120043;
	Tue,  4 Nov 2025 13:54:46 +0100 (CET)
Received: from b1722.mx.srv.dfn.de (b1722.mx.srv.dfn.de [194.95.235.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id C938416003F;
	Tue,  4 Nov 2025 13:54:46 +0100 (CET)
Received: from smtp-intra-3.desy.de (smtp-intra-3.desy.de [IPv6:2001:638:700:1038::1:45])
	by b1722.mx.srv.dfn.de (Postfix) with ESMTP id 1DBD4160058;
	Tue,  4 Nov 2025 13:54:46 +0100 (CET)
Received: from z-mbx-6.desy.de (z-mbx-6.desy.de [131.169.55.144])
	by smtp-intra-3.desy.de (Postfix) with ESMTP id 06E121A0041;
	Tue,  4 Nov 2025 13:54:46 +0100 (CET)
Date: Tue, 4 Nov 2025 13:54:45 +0100 (CET)
From: "Teichmann, Martin" <martin.teichmann@xfel.eu>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, ast <ast@kernel.org>, andrii <andrii@kernel.org>
Message-ID: <470299695.22604065.1762260885886.JavaMail.zimbra@xfel.eu>
In-Reply-To: <c6fdb21818f04bad1235aa1987db0b53aed070ee.camel@gmail.com>
References: <20251029105828.1488347-1-martin.teichmann@xfel.eu> <ec29fa64723036f672afd18686454d02857ea4e9.camel@gmail.com> <1564653446.19948617.1762160169008.JavaMail.zimbra@xfel.eu> <c6fdb21818f04bad1235aa1987db0b53aed070ee.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: tail calls do not modify packet data
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.1.10_GA_4785 (ZimbraWebClient - FF138 (Linux)/10.1.10_GA_4785)
Thread-Topic: tail calls do not modify packet data
Thread-Index: CptNSEzO+EeOub3qGAs6HX+bl+DNmw==

Dear Eduard,

> But really, I don't see that many options on the table:
> a. Be conservative and assume that every tail call modifies packed data.

That's actually what I want, be conservative. But that means that old programs should continue to run.

I have worked on this in the meantime and I think I found a solution for all cases, I will send it soon.

The origin of the problem is that tail calls just were not designed for ever returning. This way once we required the same scrutiny for the tail call as for the caller, the verifier could just stop at the tail call. Letting tail calls return is actually really weird, especially given that we also have constraints on the return values of a tail call, which are indeed verified in check_return_code. But why would we check that at all if that is not actually the end of the program, but we just return to the caller, which cannot do anything with that return value, or can it?

So if we go along this path, we would like to have new PROG_TYPEs for tail calls, which just check what is needed inside the tail call, but not the return value, as it returns to another program anyways. We would have types like BPF_PROG_TYPE_TAIL_CALL and BPF_PROC_TYPE_TAIL_CALL_PACKET_MODIFYING or so. Then we should start asking why it is a tail call at all, why can't we just call functions from maps, like we call global functions? Then we could even have proper calling conventions like r1 to r5 are parameters, r0 is return.

I do not advocate for any of this, I think this would be a lot of work for not much benefit. So for the time being, I will just try to make my old code work again, as it should. As said, I'll post a patch soon.

Greetings

Martin

