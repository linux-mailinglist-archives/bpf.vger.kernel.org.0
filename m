Return-Path: <bpf+bounces-62920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C70B0056A
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 16:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD577542BBB
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 14:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79480272814;
	Thu, 10 Jul 2025 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPesTmnF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102323ABA6
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158318; cv=none; b=YVALSl3O8g+knn93T1NsqHmvfz1uxtJHT0ujkvZe/XaBZp8WDUglYhymOBaM3tSoeFVMIwL71iv1EYaNZja0EK9vvXX0muZccvfuHdLvcWagdJeEa7JB1JgAskLmvCdMyfh1jwwHeUqqwDtvBW5gGdd9NCspnh69cXiPJzwrSHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158318; c=relaxed/simple;
	bh=o04sd/RptuF3JYskTsx+FYUTbYoYwKdPkKRIvYwg01g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVfl9XiK1uwlJGqV6/DtO390rU3fesq7sEdZZN636br5K1myejsp5UdfkpWr87GiJOaCKyJTq//Ox9qyp7QerPAUwA8Uug5ocWoUhwLUkCeDxVxrmKglILFBjrt6XkzHlvyhboWR8kzyAsUgwtQDU/aF+TlZCTs4EaY/CSftff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPesTmnF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so11860765e9.1
        for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752158314; x=1752763114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BozJzckudLngU4mwtBrValq9XBqSRoluHuepjhaQR84=;
        b=MPesTmnFu9BBkGUPass99gOM9Qn37nEQi10oamZhS4b5d0o6iQdzLQT9ZCR5AfvG71
         Oc86wq6kEBhcBny0Y6hrDU1uAqMufaIm9EM7s7ESmc0q/7inZWMnEKbtl+qI//rbMvF1
         wB1RPrT1kUAr53l9S7aAAH2Pg26QiclBtn7X81IRqat4hHSzUElfuZP/tY6ApOUamzXz
         1jtILBRyl4k97G71ZUtiwSG4E7XZ2+1oJ3i42BfHTHheway/lu/8GLNokoUfmduiTEoE
         530jBc1gPvJrswro1flZ7WOawu5+aMau7t3ge0JjsSZMMah9W9oJNVMw+wk5kUJUFi0j
         W3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752158314; x=1752763114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BozJzckudLngU4mwtBrValq9XBqSRoluHuepjhaQR84=;
        b=B0sdkP7ooEX0SJZak92qkEOKH5WB9BUCv63Ub+fucO/Sj1Fyd/lLHef7HYpCfakoLF
         xUBquQJeicuW3fVkzhpulg/79K8Rw7mhTjZtGUB1khEcf1EOBthlTCvBVMX87H5dRaRI
         46FOrjW/FxKQniiu4fZp8kx/u2O6xt8I07UlrUZonG9s8oP944k4UfZid8d2DHpaf5pf
         bGcwSq9JQE5pBSgwRG4b1069RDmOL3fZZk7cnpssRLDsXvfVRU0OSPxz78hcyKfCnX6T
         Ch/9KLZ5MCpULufDMmJtPaYvGQ+6Et2LwqZrXZZs/BlNFhZzxJnlDJc6R9Zbp/cpILIl
         Y2CQ==
X-Gm-Message-State: AOJu0YzQEIlCnl3+RPjR9XnP/PijD2LV3ugp4sYbj7pjJaYG8etg5Pcn
	cmHvbHzlT0WQcnewarJG2r4kQjCvWNPpHLkgDjZUzezOm1h7kX+uB8Eh
X-Gm-Gg: ASbGnct2yOlYyJDo2MHSClgPlWYPPs4QPl2Pl14x/6534RFGUV0p3iszaJYhhgOtLMN
	0bSZFCaYy6AFz40qs4uGQ4aJzw/VAZLQ89ayOF2qgFjxzNniMQur/AFAL8LlJh1nYXUZh/+peMs
	sMNuBg8YeuNS/HXadM+8n1n7mim3QiqccS4LjeY92iupVSO1fxFoHqiY8zPfvb0nJ1k89qlhnSf
	LYifF/dVgNbMPFBwRb4HhR7rnnL39cWrrAOQZ8tSLe6fEm0b+3nqN8iiBI1OcUwXzRVJMKbtGlB
	gyPE5KqiIUUNZx+pv9JMHqV1uZRzw40RIS6BF34lwowHWOJU/AevtOxXznzJgENueh24QXOBSeZ
	T9kPEERou5rgtKoqIMALpEx+MrJeOY72VAtWcOBSif9gMtULteWF9J+rvX7e3dg==
X-Google-Smtp-Source: AGHT+IEewxRSNWvcYZJSzIXy9WSfSuUnf1b8kRtZrd7AUcgbKslCfBciLAf+4xqaatJYEA6tOfq6XA==
X-Received: by 2002:a05:600c:a00c:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-454dd1f3edbmr28496985e9.2.1752158314063;
        Thu, 10 Jul 2025 07:38:34 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00939f1ea551223a20.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:939f:1ea5:5122:3a20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd49841dsm67389785e9.0.2025.07.10.07.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:38:33 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:38:31 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Range analysis test case for
 JSET
Message-ID: <aG_QZ4mfJyS4p6_7@mail.gmail.com>
References: <75b3af3d315d60c1c5bfc8e3929ac69bb57d5cea.1752099022.git.paul.chaignon@gmail.com>
 <9e72d9b0e793c85362c86727911e36a087fe3044.1752099022.git.paul.chaignon@gmail.com>
 <d41cbad6-a31e-464e-b2e3-b74acbf42b48@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d41cbad6-a31e-464e-b2e3-b74acbf42b48@linux.dev>

On Wed, Jul 09, 2025 at 04:09:41PM -0700, Yonghong Song wrote:
> 
> 
> On 7/9/25 3:27 PM, Paul Chaignon wrote:

[...]

> > +SEC("socket")
> > +__description("dead branch on jset, does not result in invariants violation error")
> > +__success __log_level(2)
> > +__retval(0) __flag(BPF_F_TEST_REG_INVARIANTS)
> > +__naked void jset_range_analysis(void)
> > +{
> > +	asm volatile ("						\
> > +	call %[bpf_get_netns_cookie];				\
> > +	if r0 == 0 goto l0_%=;					\
> > +	.8byte %[jset]; /* if r0 & 0xffffffff goto +0 */	\
> 
> why not just use 'if r0 & 0xffffffff goto +0'? It will be equivelant to
> BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 0xffffffff, 0).

I was having issues with some older versions of LLVM. Some didn't
recognize jset instructions, some simply crashed. That said, the CI
seems to be fine, so let me switch this back to the simpler syntax.

> 
> > +l0_%=:	r0 = 0;							\
> > +	exit;							\
> > +"	:
> > +	: __imm(bpf_get_netns_cookie),
> > +	  __imm_insn(jset, BPF_JMP_IMM(BPF_JSET, BPF_REG_0, 0xffffffff, 0))
> > +	: __clobber_all);
> > +}
> > +
> >   char _license[] SEC("license") = "GPL";
> 

