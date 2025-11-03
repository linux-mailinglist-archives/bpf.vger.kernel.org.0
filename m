Return-Path: <bpf+bounces-73331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DFEC2AA77
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 09:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B4A1882728
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E8C2E6CDA;
	Mon,  3 Nov 2025 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="fwlfNyOe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB44286D4E
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160181; cv=none; b=Qa1VWCXAKmud3n2k/7wnzUIDjxfbYDXKycx2HkT1O0wJhjpLYvlUm7TOUlZnIzJZ/q58DWQZ4tJAKBECjv+CTXkwLWinQtnvDwxt6/w9IjXWjpip9SROLtR1RxaelDFzH5wUPB33TfwdLjkmCpwHeqAno13lT5ZHmoFeKw82VDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160181; c=relaxed/simple;
	bh=s9vJOxE5e82pBrvQBPj9ee/OkZ31mtk9zkMdIOCvIJs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=j2+o9FddQo7DFqQjzPbGaM5dLEJfkxJspvzIp7k2WqiTCJnITOibTPPnCbZUqX068RAImASpodLZGJ23DrQrVbtPEqId5ZHC6sSs4OEiPTRsfA7UBPSpGxKwtqiKki5NlvkWZ1KCn4JafHXt93l8T3MyphiWNoEScppurAYxNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=pass smtp.mailfrom=xfel.eu; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=fwlfNyOe; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfel.eu
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 2284411F74B
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 09:56:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 2284411F74B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1762160170; bh=nYuMFs25kHrTtG9qeETPPZ0YMqTm+Z3JvCvKGpED0oE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fwlfNyOei89FxjMCjZDJNpccAlBPQ+e2l/myG/GuLdHjUzO7kec/jkv6xkaOiql8J
	 rAlTGfx0JAo+agqlhjA+CWLzcI8cWccWJJFenkLvP1IuQJvYxKwF9MR+e+nhTyAggz
	 lrJ6nZVEEchmTQQYNCEEQTW97lxiEX7CMU2khwgs=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 14F3C20056;
	Mon,  3 Nov 2025 09:56:10 +0100 (CET)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [194.95.233.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 0A236160044;
	Mon,  3 Nov 2025 09:56:10 +0100 (CET)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 29DE73200A8;
	Mon,  3 Nov 2025 09:56:09 +0100 (CET)
Received: from z-mbx-6.desy.de (z-mbx-6.desy.de [131.169.55.144])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 13AAF2004C;
	Mon,  3 Nov 2025 09:56:09 +0100 (CET)
Date: Mon, 3 Nov 2025 09:56:09 +0100 (CET)
From: "Teichmann, Martin" <martin.teichmann@xfel.eu>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Message-ID: <1564653446.19948617.1762160169008.JavaMail.zimbra@xfel.eu>
In-Reply-To: <ec29fa64723036f672afd18686454d02857ea4e9.camel@gmail.com>
References: <20251029105828.1488347-1-martin.teichmann@xfel.eu> <ec29fa64723036f672afd18686454d02857ea4e9.camel@gmail.com>
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
Thread-Index: tUjAAbWHd9EswUkKPBEFoHc//Db2ZQ==

Dear Eduard,

thanks for the review!

> I don't think this is safe to do, consider the following example:
>
>  main:
>    p = pkt
>    foo()
>    use p
>
>  foo: // assume that 'foo' is a static function (local subprogram)
>    if (something) do tail call
>    don't modify packet data

You are absolutely right, this would not work. This should actually be covered by tests... I'll write a test. I also already have an idea how to fix also this problem, and will come back to you once I'm done.

> Alexei vaguely remembers discussion about using decl_tag's to mark
> maps containing programs that don't modify packet pointers.

I am actually against that, I think this would be the wrong way to go. In my use case, I have written a dispatcher for packets that tail call other programs depending on the content of the packet processed. These programs do change during runtime. Until now I had no restrictions on those programs, they could modify the packet or not, as they wished, as the code does not return at all anyways. Tagging the programs would only limit their usefulness, without giving any benefits.

I know that what I am doing is a bit crazy, I actually do motion control with EBPF, and all the EPBF programs are generated directly from Python, so I am not protected by any checking that compilers like LLVM might do. So I am kindof stress testing the EBPF subsystem... (if there is any interest, my code is at https://github.com/tecki/ebpfcat)

Cheers

Martin

