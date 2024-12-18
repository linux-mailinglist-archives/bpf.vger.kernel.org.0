Return-Path: <bpf+bounces-47275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A3B9F6F5A
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 22:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678971884F6D
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 21:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17871FC7DF;
	Wed, 18 Dec 2024 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNtBJ5rk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D70153824;
	Wed, 18 Dec 2024 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734556698; cv=none; b=e6/maemLtqxrABcfPTRrxMoeiQAIrxAJCCYO/txa/n4dv++IpibK4iCQKddo0Gcw9P2wwAAw3ynNhjHqKVQlQWA1F45rqEj7ZP3cC44lGB4kkZ/DbBLeCdSqpfaTLYlx0d2ox0TrFocKxNUWU923KTF9wOMAeoAN5uKihGZQKtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734556698; c=relaxed/simple;
	bh=+w0xRVweVNiBUn6y0pJ1hZ5Bqmj3yzz15HhTyLqoRsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/d+bzl9U8pnZ+xY88+uKDJHgW3sI9h7PSN8Bb2lyscKikwt9jERCCCqaSGAFsQklbzDBc9T5z2vDSQ0S97Y4KaauVMuA86hr/Hf/5penn7IXM1MfhZhBrukY5Z9mY2kP/FiogGR/EfeZb3Cg9nlm21MycOs8Av+ZcYk3W45xqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNtBJ5rk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso7920365e9.0;
        Wed, 18 Dec 2024 13:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734556695; x=1735161495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9Ut8ams7AEAa5aeidARff5SscZVn1YKTUieqw4Fq5I=;
        b=WNtBJ5rkvU3UeMxX0JYVQz8l94mmrhj8WGBOPtJvi16yQPIxkXV6VbS3XMwF8DFUn3
         8UMp8K577s0WFMXhJ6yyZXZ8PPKSxOL2u31a3wN9Wx5H+9zjFzuFsnSh4jQaMWlg9t5l
         8CVM6JaRcapttXY+Zd4+0qIOTjta0semKOXGqobuPly7PoPxwxatQMQptuwgOJwuEA5E
         OGSZEACMjcI/vwYDWjl1MNpLi7FbOKCAyTYK7VFwmQ5NvBNDPSJ/ZMmgzOUkcU59nmv4
         zhjB8j/RuzryLxJsePIBCYCm7O4E2uVTUpT2nZGITbnB2+hNvqlW1oqatUtRycffiICj
         uuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734556695; x=1735161495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9Ut8ams7AEAa5aeidARff5SscZVn1YKTUieqw4Fq5I=;
        b=YWwpmXJyURHftADClXbasRNLQxZVE3CQ0nhO5r5feMr4ZFJgsWxmLQ1MtCtB4WAu/6
         7o9mSsrlmdgDqffgOBhHU4UvNgtaiccX0FBHwS8xXUTSUHAEKLMDWFspssvs2H8rFdCi
         8qmRQGkjcFJMsqrmYxPc6nzL8bjouPNLNoxRHi+wK6gxAmFdakVt3JJts9hc6W6QAMcy
         8I46Ft6iYzNNEyL8dkyiEF6eo+Ahevre86QIwjI5KEnZRPneteKOGG9nqb10rZa8icv2
         lcjyARCXRz5JsbHITaZsoby4fDUFxOzZULgruCT/asXbPdsr1py9Z9mz8q63Tx8oGNz1
         NiFg==
X-Forwarded-Encrypted: i=1; AJvYcCW2n/jpAujBrBHL9VAOeF7Adr+UP0c5SGdniMjuSUAJl7FHaejMbljA27qkRMZqVccHdro=@vger.kernel.org, AJvYcCWBfz5U8cFDs+GcMjjLOQjUJ2qi4kX4dhEmArjUlJJpvmxB8TLYTs6f2Fo658uWRXuvybzZFB1j6/jdbV8k@vger.kernel.org, AJvYcCXbF5NpWlNjhCgK7DwfSR02rwtp8//Ff/Wc+AcMoAhDnjxbtlSdjiYHmzzxZvA5QwjhhnqVMEo+@vger.kernel.org
X-Gm-Message-State: AOJu0YwVDdIaJ+Hf8kBlV4lZOQwoy3nWyWtMH/1qCVeJrw1CeI9QjRkd
	1Ub+gA1aEH4aIwv6pcSo8O8UDTe+d6nmEEw2x4gf0mEl5UBebHkyROOBGRrWZK8nBno8DXyuZG5
	jimxNBcXBmKfC9cmlUAUSonKw2fU=
X-Gm-Gg: ASbGncs6nVCl/2pUiYRsJamfZZ9I9/U8XU2mazBYbuxFnxazSgpQ+hBm4jyJu4jG0kM
	cXBZF4KDT9v4OvFZfRKNcefVdfhWAYRX7Py5Igg==
X-Google-Smtp-Source: AGHT+IFSm6iuB9G6z1NCx3jz4IXSlIWpcLindjTyjmoUb4/lnUL6SVotyMyirAbU+x+YJ12D3Hw8fXTSiEBmhtK/F+M=
X-Received: by 2002:a7b:cc0f:0:b0:436:1b77:b5aa with SMTP id
 5b1f17b1804b1-4365c775154mr6454125e9.8.1734556694881; Wed, 18 Dec 2024
 13:18:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213-bpf-cond-ids-v1-1-881849997219@weissschuh.net> <173413143374.3187520.16720861618216480481.git-patchwork-notify@kernel.org>
In-Reply-To: <173413143374.3187520.16720861618216480481.git-patchwork-notify@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Dec 2024 13:18:03 -0800
Message-ID: <CAADnVQ+5cuF0vG8X7F-cgOvDeS_m9x70EM88gsey8krRniCx6Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix configuration-dependent BTF function references
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 3:10=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:
>
> On Fri, 13 Dec 2024 00:00:30 +0100 you wrote:
> > These BTF functions are not available unconditionally,
> > only reference them when they are available.
> >
> > Avoid the following build warnings:
> >
> >   BTF     .tmp_vmlinux1.btf.o
> > btf_encoder__tag_kfunc: failed to find kfunc 'bpf_send_signal_task' in =
BTF
> > btf_encoder__tag_kfuncs: failed to tag kfunc 'bpf_send_signal_task'
> >   NM      .tmp_vmlinux1.syms
> >   KSYMS   .tmp_vmlinux1.kallsyms.S
> >   AS      .tmp_vmlinux1.kallsyms.o
> >   LD      .tmp_vmlinux2
> >   NM      .tmp_vmlinux2.syms
> >   KSYMS   .tmp_vmlinux2.kallsyms.S
> >   AS      .tmp_vmlinux2.kallsyms.o
> >   LD      vmlinux
> >   BTFIDS  vmlinux
> > WARN: resolve_btfids: unresolved symbol prog_test_ref_kfunc
> > WARN: resolve_btfids: unresolved symbol bpf_crypto_ctx
> > WARN: resolve_btfids: unresolved symbol bpf_send_signal_task
> > WARN: resolve_btfids: unresolved symbol bpf_modify_return_test_tp
> > WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
> > WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb
> >
> > [...]
>
> Here is the summary with links:
>   - [bpf] bpf: fix configuration-dependent BTF function references
>     https://git.kernel.org/bpf/bpf-next/c/00a5acdbf398

Just noticed that this is broken.
The #ifdef CONFIG_NET part in special_kfunc_list()
needs to match positions in enum special_kfunc_type.
BTF_ID_UNUSED must be used when !CONFIG_NET.

Pls send the fix.

