Return-Path: <bpf+bounces-22349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE53485CA83
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 23:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A953628387E
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 22:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA5D152E0D;
	Tue, 20 Feb 2024 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKRBQRgy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EDB152DEA;
	Tue, 20 Feb 2024 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467183; cv=none; b=kPPoZ/v/1T89t1StAkY2L+lrJJiPCY/JnoXG1e8yvCFfm060BxV212GFoY4gM978PXpbquf1vibVMPL4ytGRg/tdVocYjYt/k5QnHYVcs9iKXh450oCcVbTVLuwdQib6egitGcEmc01fAz/VUUDhLwccGQwhdQGnHg8BtZoRk8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467183; c=relaxed/simple;
	bh=NMnvtcFQbtH5ja7Aet4YcIxkr6TQTCFMy2RG04JdvTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frmnfStjg11vhm/eFSiusxPMv9F9LJqHw0SwKgCr4xXUe3N1Ee7QMKv4I/hObcv1ngaPGhNKLCplHlxVdaCf5/4VtY6sfk3mp9wiBShPaqAwbAHygfJiPeKkDIuC63R1fkYdu9ndYa39U2dSjECsXrMYLjKokgjyg6J26SXO2ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKRBQRgy; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a3d484a58f6so795979566b.3;
        Tue, 20 Feb 2024 14:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708467180; x=1709071980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tbrC1YiirDZo5WRjo6LZPZ9F6/4YXywYDLbK8hkWWzs=;
        b=OKRBQRgydpfgGkqkaDNnTHko/ZrYOMdZTXzt4nsOxecdgjZ3eFu5C+xTqwIQjUMwcF
         NFivwIGKSg/kKmbF7RdpVj9FKvphKDVr9wzB2if1W0k993ct1rhpxV8FmPnzPyqMKwiN
         DkMVNLmiqyjdLGD2ZbQ6nQEQ8yM38J4NJQDAd/nbnN8id9wWFF73b8BLHInUPNu3ISjf
         tLBCYfC+3Dlmi0toUECRuyVS9YrAYc9qCUQoQEYaU9Sm3rzQBI8YETnkNK5H0SnPtD9a
         zX4hokkP0FDib9PD0WQvZD5pOUwkzE6WNRnoU3ImDJddUX3//g5q/Aizr9MM2f45LILP
         /YUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708467180; x=1709071980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbrC1YiirDZo5WRjo6LZPZ9F6/4YXywYDLbK8hkWWzs=;
        b=YZng+MoEt0NDvEHruuwvS2lONTD6/s+2/rALcS47qB+DGoa6NgECXvMyQx6Q2wEGxR
         WOlM1SC9KnDyE1YGuKTXbk3sPJcWBmGxNRGbBjAbES/NKYlZAd8gu2t+LyP+PyyTxQ6l
         XiIWXIxCmqbY+Tkr/xH7zwjREzPbvFjVza1/5T3cvP9WqnI/KPerFRNmzRC6qQlSs7hg
         zzaDDlifYsv9BGMlEWuE/X7cvQgJZjqCBvCorha7UUnVnu0/AjKSKoxA/+BF6zfPGFwH
         tm/mn4mI1qEWLPQUOCO49tUVJgaB77HwbblRbsEQmsvRiQ6CJXmwk4EalOztR3hTxS+K
         oGyw==
X-Forwarded-Encrypted: i=1; AJvYcCWiKf1S9J3qootWee0ltBu2/oeji5b7KzEZpWCNXYKV8HjjvK7bmjN0QXrwNZzKHkR+bgKm8o0mr8SjmC/MHGvaIUNsL3or1j7TjR6IxuKUTOQ+RkLexRXlqkZjK+3DzNPJ
X-Gm-Message-State: AOJu0YzMUviVn61fxBNr8JG/FBRrBOaFcvbfMcr/BgBvpHfKbFNVIDnr
	VFV9XgCDj3QdniO+96sJE94IhvWlh7jWoqdXj07ijgE8ksBQ7yYpIJtDoM5z869p0IST0iYn+T8
	yBcEBvjyzzGt/GvImfCBVg1h3mIo=
X-Google-Smtp-Source: AGHT+IG/biI47FZn+VFGVms1qWr/aUkDXB7nT+6FF1bd6JWckaYWVARNruzbSaQG94R0zQqOV3R6Hpk7/bMaG5oOyZk=
X-Received: by 2002:a17:906:b24c:b0:a3f:1cd:69bc with SMTP id
 ce12-20020a170906b24c00b00a3f01cd69bcmr2102892ejb.15.1708467179708; Tue, 20
 Feb 2024 14:12:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125225.72796-1-puranjay12@gmail.com>
In-Reply-To: <20240201125225.72796-1-puranjay12@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 20 Feb 2024 23:12:23 +0100
Message-ID: <CAP01T77ttCeO_joYWqYxjyj_AdHEX34rk31H5y6voNJQz_dXFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/2] bpf, arm64: Support Exceptions
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 13:52, Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Changes in V2->V3:
> V2: https://lore.kernel.org/all/20230917000045.56377-1-puranjay12@gmail.com/
> - Use unwinder from stacktrace.c rather than open coding the unwind logic.
> - Fix a bug in the prologue related to BPF_FP (Xu Kuohai)
>
> Changes in V1->V2:
> V1: https://lore.kernel.org/all/20230912233942.6734-1-puranjay12@gmail.com/
> - Remove exceptions from DENYLIST.aarch64 as they are supported now.
>
> The base support for exceptions was merged with [1] and it was enabled for
> x86-64.
>
> This patch set enables the support on ARM64, all sefltests are passing:
>
> # ./test_progs -a exceptions
> #74/1    exceptions/exception_throw_always_1:OK
> [...]

I think this looks ok, would be nice if it received acks from arm64 experts.

If you have cycles to spare, please also look into
https://lore.kernel.org/bpf/20240201042109.1150490-1-memxor@gmail.com
and let me know how architecture independent the cleanup code right
now in the x86 JIT should be made so that we can do the
same for arm64 as well later. That would be required to complete the
support for cleanups.

I guess we just need bpf_frame_spilled_caller_reg_off to be arch
specific and lift the rest out into the BPF core.
I will make that change in v2 in any case.

Just a note but based on our off-list discussion for supporting this
stuff on riscv as well (where a lot of registers would have to be
saved on entry),
the hidden subprog trampoline could be a way to avoid that. They can
be pushed by this subprog before entry into bpf_throw, and since the
BPF program does not touch the extra callee-saved registers, they
should be what the kernel had originally upon entry into the BPF
program itself. The same could be done on arm64 and x86, but the
returns would be diminishing. It would be nice to quantify how much
this saves in terms of costs of pushing extra registers, before doing
this.

