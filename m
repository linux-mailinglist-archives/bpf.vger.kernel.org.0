Return-Path: <bpf+bounces-43565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7BE9B67F4
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 16:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EDA1F2286D
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 15:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574DD213141;
	Wed, 30 Oct 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/LrNC94"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE971E1312
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302561; cv=none; b=q8uVLJQZp8FNX+PqL8nvr3O/3jN1VshxbvC++OCzotK71RDszqrFd9YzuXgqZFRi4jJOJVaJPYQf3nxyZl5Sur4N6gjTRdIDO3SwQPu1QBvSiv7rEkXlbHYdGTtg5yXg1qnse+aBsvxl4oFuMlCXeaP1z08phlR2mX305kMzAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302561; c=relaxed/simple;
	bh=x0eBrOxcT0goZ5ZQfV6Np7WjPUOkMxRi3jamIGrf9YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQ2CWNZRnjpUUTpe2MvjJMxzZP1NkCInlQlnDD69rvHkUAc9/+bJUV71qo+5gdZujoDmt1OaDRCYMvyTaks9i3CgT0dTw0iDvRMTYT/0ZAz0Jkj5c802EfQng/rJhC8Z3Yc7s5L+932/ohgmuCYf9qmzaAB48Xgolx5eJdeGNKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/LrNC94; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7db238d07b3so11616a12.2
        for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730302559; x=1730907359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ehcM+/OA0cXZoKXhA+oFI8F4DqdBTmR8eq6TZ96pns8=;
        b=J/LrNC94i635bKR30poqL6YTdl50NO7CUz0tIEhCbO+D2XQd/sGYZbxZ+HFhhF1grJ
         ur0wWKi/ZAke7j/jpmPZICE18mIOmzqJ97iUWvMpkV6LM3AWqi/7fIWuIusNsiBmqZXV
         tbCEGvXWveEmlm4ZwZWgMRrmgkRdKhKn1iLfiQMVto4TEJ4DbBqtdy8aqP5ppKtw852m
         cnzjMrHXiKV/KY4RSMBM4rG9cOXIRCS91bw7a/0kyL9YipW5pmVQIjGdGTE/07N0OIYc
         TpGHB8kOC/EUNMyLrk6KkXczs77uHZ+rRNxEkrtPAThio7k3NQA6DhXZZ5j2TWA5Adky
         NX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730302559; x=1730907359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehcM+/OA0cXZoKXhA+oFI8F4DqdBTmR8eq6TZ96pns8=;
        b=egq6EAqgPW60gfvhbPHTsMJNV++RWnX2Bxpe4+/O4DtWqIpwqor8CoJmHHGhN9+XwJ
         7fXkk4VJpD1VEZatRV1hAKkrpNZvlMfVH39wTaPjlp5KX4yDQ/J3kbcFyBiD0UylJjkb
         y0MKhWN8Rbvq+D7s93Vol0T0g5OkK6UQfA47wrVhQoGeYwT1PlojiHrwDbChWRlZJfA9
         eVl+z7M97JW+3rtN04VTh5g5dJdqv51V8i3e0CKx5RsMiKqvTzw02/oL7xNWJ5YMqy0i
         ePvYBrNvE6W1LBHwOjSlP7jxV4NLBv80vODWpgA0OqDSAQeJAplL69UusPbM/XeZTdNs
         2u/g==
X-Forwarded-Encrypted: i=1; AJvYcCVB2g+Hk2xEVbW4uDVDulePh8GtGS96mGAz0CP0lLYSo1IGyn001zwcS79iO1zlQuWuaVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/a1GJUhQWXgJEnuXhunK5Z8YVWVtZoQLdrkue/mX8fb2T2iCV
	xrua6m3ngv8Vh0EvH+jKs6RM+9s83fbN3VV4NHklq8ODtk/Xik8=
X-Google-Smtp-Source: AGHT+IGpyGUXH2o05lDMz2l0CrvoF6atdf4hPjiM48ggDm2qIujS2Kakq60uZdE6QIn2QdtyzqJc2w==
X-Received: by 2002:a05:6a20:d8b:b0:1cf:3d14:6921 with SMTP id adf61e73a8af0-1d9a84d168emr22180392637.35.1730302559238;
        Wed, 30 Oct 2024 08:35:59 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205793194dsm9387407b3a.53.2024.10.30.08.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:35:58 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:35:58 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Leon Hwang <hffilwlqm@gmail.com>, bpf@vger.kernel.org, qmo@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf] bpf, bpftool: Fix incorrect disasm pc
Message-ID: <ZyJSXkHf6qFzkMnX@mini-arch>
References: <20241030094741.22929-1-hffilwlqm@gmail.com>
 <e404d1cd-cf40-48dd-8a49-82c03c3b641e@linux.dev>
 <ZyJJJlt1gvsi2Wu0@mini-arch>
 <4b3b1af1-3546-4916-9084-3f10b276998b@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b3b1af1-3546-4916-9084-3f10b276998b@linux.dev>

On 10/30, Leon Hwang wrote:
> 
> 
> On 2024/10/30 22:56, Stanislav Fomichev wrote:
> > On 10/30, Leon Hwang wrote:
> >>
> >>
> >> On 2024/10/30 17:47, Leon Hwang wrote:
> >>> From: Leon Hwang <leon.hwang@linux.dev>
> >>>
> >>> This patch addresses the bpftool issue "Wrong callq address displayed"[0].
> >>>
> >>> The issue stemmed from an incorrect program counter (PC) value used during
> >>> disassembly with LLVM or libbfd. To calculate the correct address for
> >>> relative calls, the PC argument must reflect the actual address in the
> >>> kernel.
> >>>
> >>> [0] https://github.com/libbpf/bpftool/issues/109
> >>>
> >>> Fixes: e1947c750ffe ("bpftool: Refactor disassembler for JIT-ed programs")
> >>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >>> ---
> >>>  tools/bpf/bpftool/jit_disasm.c | 6 +++---
> >>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
> >>> index 7b8d9ec89ebd3..fe8fabba4b05f 100644
> >>> --- a/tools/bpf/bpftool/jit_disasm.c
> >>> +++ b/tools/bpf/bpftool/jit_disasm.c
> >>> @@ -114,8 +114,7 @@ disassemble_insn(disasm_ctx_t *ctx, unsigned char *image, ssize_t len, int pc)
> >>
> >> It seems we should update the type of pc from int to __u64, as the type
> >> of func_ksym is __u64 and the type of pc argument in disassemble
> >> function of LLVM and libbfd is __u64 for 64 bit arch.
> > 
> > I'm assuming u32 is fine as long as the prog size is under 4G?
> > 
> 
> It works well with int. So it's unnecessary to update its type.
> 
> >>>  	char buf[256];
> >>>  	int count;
> >>>  
> > 
> > [..]
> > 
> >>> -	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, pc,
> >>> -				      buf, sizeof(buf));
> >>> +	count = LLVMDisasmInstruction(*ctx, image, len, pc, buf, sizeof(buf));
> > 
> > For my understanding, another way to fix it would be:
> > 	count = LLVMDisasmInstruction(*ctx, image + pc, len - pc, 0,
> > 				      buf, sizeof(buf));
> > 
> > IOW, in the original code, using 0 instead of pc should fix it as well?
> > Or am I missing something?
> 
> No. It does not work when using 0. I just tried it.
> 
> I think it's because LLVM is unable to infer the actual address of the
> disassembling insn when we do not provide func_ksym to LLVM.

Hmm, thanks for checking! I'll leave it up to Quentin to run and confirm
because I clearly don't understand how that LLVMDisasmInstruction works
:-D (and you two have been chatting on GH).

