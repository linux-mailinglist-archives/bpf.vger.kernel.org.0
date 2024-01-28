Return-Path: <bpf+bounces-20503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2BA83F285
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 01:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6257428608D
	for <lists+bpf@lfdr.de>; Sun, 28 Jan 2024 00:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C61373;
	Sun, 28 Jan 2024 00:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="B9TJPmWL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="B9TJPmWL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jChqvOU7"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827581109
	for <bpf@vger.kernel.org>; Sun, 28 Jan 2024 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706401616; cv=none; b=JfZs4IykCCfsUM+KEEnRkEgfZQrMHp/heXB8+J+CjO3M1dOniH4VCv3EJfrpOMZTfNPJP+WI+EueJjAlH7aaCA1wqjePp3P5RRIGi0bcJVKeEGk+e0sRrD/l9IQE1kxbdmRjmlFMa/xsqYYV2Mqk3cMYbe8jrvwt+f7mfEupMeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706401616; c=relaxed/simple;
	bh=6GJdhSGYgEnD4Eura7AxisTVOWSzrmZrpZy759DM+C8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Subject:Content-Type; b=qUUUO9hU3wLC/1nZot+UG0TMnT5AuxDZ2iDsbDqh8V6P9JN99JqmhgmNSD/WgiBjO94MGP5wE4TMaoQRt0vuwe8Xdn7Wbun0qNB61jNypYt4fie3OZqpR+UPhYnKaRzmyoni6JetF2Ecz/64DzAC5Wlai9ELMCIH/qJRwtpaurY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=B9TJPmWL; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=B9TJPmWL; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jChqvOU7 reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E3116C14F696
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 16:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706401613; bh=6GJdhSGYgEnD4Eura7AxisTVOWSzrmZrpZy759DM+C8=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=B9TJPmWLPtMjMMIUTbF4mljH4HJ3jhtDV4RPPkHlBAQzkZKFx2ejFyNaq3ClIaKJm
	 94BZYEUs4OXFMX92G4Dm4xmPW4sAg1mvARSyTYI+O3YOwAYKVbQqCbAnY5X0hg4XMK
	 1IDO31TfhhxMh7QQ8/KHUU10r0tS7RfiXKWHzues=
X-Mailbox-Line: From bpf-bounces@ietf.org  Sat Jan 27 16:26:53 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id B99A9C14F60B;
	Sat, 27 Jan 2024 16:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706401613; bh=6GJdhSGYgEnD4Eura7AxisTVOWSzrmZrpZy759DM+C8=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=B9TJPmWLPtMjMMIUTbF4mljH4HJ3jhtDV4RPPkHlBAQzkZKFx2ejFyNaq3ClIaKJm
	 94BZYEUs4OXFMX92G4Dm4xmPW4sAg1mvARSyTYI+O3YOwAYKVbQqCbAnY5X0hg4XMK
	 1IDO31TfhhxMh7QQ8/KHUU10r0tS7RfiXKWHzues=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 82C93C14F60B
 for <bpf@ietfa.amsl.com>; Sat, 27 Jan 2024 16:26:52 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.106
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0F4YwCrfvBKH for <bpf@ietfa.amsl.com>;
 Sat, 27 Jan 2024 16:26:48 -0800 (PST)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com
 [95.215.58.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id EE6A8C14F5FC
 for <bpf@ietf.org>; Sat, 27 Jan 2024 16:26:47 -0800 (PST)
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
Content-Language: en-GB
To: dthaler1968@googlemail.com
Cc: bpf@ietf.org, bpf@vger.kernel.org
References: <006601da5151$a22b2bb0$e6818310$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <006601da5151$a22b2bb0$e6818310$@gmail.com>
X-Migadu-Flow: FLOW_OUT
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/HpSpbPKe-V25bEMdi0YKBbHOT3E>
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

