Return-Path: <bpf+bounces-43559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 054919B66A5
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 15:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F231C2033E
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7021F473A;
	Wed, 30 Oct 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2bRJrZ6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772451F471A
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300202; cv=none; b=TluTAkqjMlUv7qIXOqioBUOSe3wH4F0mNbIOF8glx9dH9UJbImh+/TXbpl9A3odI2Nsw1+Vg8C01UqkHpFThleOqNbe66LsZwCmVIAkqtgxd/s47fHYW9vwDPXETEw5XPO+6JdxinZQfIUp7hQwbkgR9nf2tAbrQGwuNFNuYcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300202; c=relaxed/simple;
	bh=a2tj0GoN4jzqENCjUNUIOvKsSTAv4lfJIBViLAxswP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGkkTRGElZfJhl44fYCOLAUy64OkEZRwK+pPQTt6x9QIoHKbOZJmJNzRIt5rivYLoon+bV51ZkYd3/3IxD14cB9HyWXuKSfS1Qtowmg0GKF+ibESojWFpaSZPm9G6B9y+wDw4udsVy7Klw93+wA7dEP7oTLzxRlb9ApD8it1Bmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2bRJrZ6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c7edf2872so7862965ad.1
        for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730300200; x=1730905000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XTQvAg8EJyUPN0nuoQp3K/i2Wfjz01agtxKEuHLLfq8=;
        b=m2bRJrZ6y/SmzuQUV10rygEB5TfVsXye1S75S1v/B6+TIFhAbgGzQL47qEwKtQtkbQ
         6JPV3FE+qSJUfTqF7wP4OFQrpt8EjhZjh3D/QceEfk6NQIePWbk1Pz0hXPsezDLdQgmQ
         xsbqyusMjAthKfCF2cE/K/1TF2j+NafZ2sWcpKvGIl0WukxieNXTUdNUn5nMUEcLCc/0
         4iV7dT1C3ix4bfmgQ8tlXZax9v7MoTk6feyUX4cLRa+qip7Tucelu5c4iZ3nsOcarWew
         v7iMdP8wuW1Nx8AKZiXzSiOaTA5syEGqD4Zn/5esB6tZiHcAce160Mi1xl76do34gj7T
         /BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300200; x=1730905000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTQvAg8EJyUPN0nuoQp3K/i2Wfjz01agtxKEuHLLfq8=;
        b=fLHKSOacTVJwkGfug3BSXg7YEp6BQFkb2TdaVLb+1CKyV9pYCfKsgq+yJg2Ojy/TAC
         NzdVfQ519VOz74LGOIPogdjBfjnJo4/nPBQZS0ryxjgjhLDy73RCbn7pwJVjRPcxh5+w
         oRZ8nQHMoSmiNQChhZ/jzEL8qC21JJloHSA2B3c0nDUAFbtswIP5w9ZgfYsr1OZ3iwHK
         ZB91eeG4yDua1fcGtbRU9W84VgLUNndiUXqshdpXI55we8AJdopjM2WC1FwFJzFAppCX
         K4t4pqzqEMvFAlWgic54U3FUkGrhEXZBqqX/7Q5N+iCw3EHBuGWKkzwHJ214tbHk2b6t
         cMWw==
X-Forwarded-Encrypted: i=1; AJvYcCXNpKATkv1Ympo7TmqUX80PLFdXXpcWy9t+0ET6Ygh1GEhfEm4bnIPZssOjrNpK4Et+mrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwsc3W+H4lWVPjs563dJYeFXoO0nU6IulPnbITFStN6SAROM1J
	BkUU39/ks0HfcbDZxUZ5RcYxPsSwFyQFBXTcjDQsGScxShDOGbg=
X-Google-Smtp-Source: AGHT+IGe3esASvV4CaoYvK0Uke30dJhlHY0Yhj+OVrdkK7Q0Ox0Q36KhSPR+0BPdY1eS/X68u2h2tw==
X-Received: by 2002:a17:902:c40c:b0:20c:c18f:c39e with SMTP id d9443c01a7336-210f90300bemr38567505ad.21.1730300199574;
        Wed, 30 Oct 2024 07:56:39 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc013477sm82264255ad.175.2024.10.30.07.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:56:39 -0700 (PDT)
Date: Wed, 30 Oct 2024 07:56:38 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org, qmo@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf] bpf, bpftool: Fix incorrect disasm pc
Message-ID: <ZyJJJlt1gvsi2Wu0@mini-arch>
References: <20241030094741.22929-1-hffilwlqm@gmail.com>
 <e404d1cd-cf40-48dd-8a49-82c03c3b641e@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e404d1cd-cf40-48dd-8a49-82c03c3b641e@linux.dev>

On 10/30, Leon Hwang wrote:
> 
> 
> On 2024/10/30 17:47, Leon Hwang wrote:
> > From: Leon Hwang <leon.hwang@linux.dev>
> > 
> > This patch addresses the bpftool issue "Wrong callq address displayed"[0].
> > 
> > The issue stemmed from an incorrect program counter (PC) value used during
> > disassembly with LLVM or libbfd. To calculate the correct address for
> > relative calls, the PC argument must reflect the actual address in the
> > kernel.
> > 
> > [0] https://github.com/libbpf/bpftool/issues/109
> > 
> > Fixes: e1947c750ffe ("bpftool: Refactor disassembler for JIT-ed programs")
> > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> >  tools/bpf/bpftool/jit_disasm.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
> > index 7b8d9ec89ebd3..fe8fabba4b05f 100644
> > --- a/tools/bpf/bpftool/jit_disasm.c
> > +++ b/tools/bpf/bpftool/jit_disasm.c
> > @@ -114,8 +114,7 @@ disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc)
> 
> It seems we should update the type of pc from int to __u64, as the type
> of func_ksym is __u64 and the type of pc argument in disassemble
> function of LLVM and libbfd is __u64 for 64 bit arch.

I'm assuming u32 is fine as long as the prog size is under 4G?

> >  	char buf[256];
> >  	int count;
> >  

[..]

> > -	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, pc,
> > -				      buf, sizeof(buf));
> > +	count = LLVMDisasmInstruction(*ctx, image, len, pc, buf, sizeof(buf));

For my understanding, another way to fix it would be:
	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, 0,
				      buf, sizeof(buf));

IOW, in the original code, using 0 instead of pc should fix it as well?
Or am I missing something?

