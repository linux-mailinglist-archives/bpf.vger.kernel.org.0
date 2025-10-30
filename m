Return-Path: <bpf+bounces-72957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5DDC1E001
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 02:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D59704E4F67
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9989B2459F8;
	Thu, 30 Oct 2025 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLntSBM4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB322576E
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 01:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786816; cv=none; b=YM4ylcsSKM1wdrpUry26sKigOlndwcvKrKOHpgqxmFBbpyOP5pZgv3EbkUeGIbTDs+MpLMFIS4cxre8kFfnk5yFNBwC3GEbGOk80b2TQ0PnU3No0/p1BZdzMHxfOSSgWilORsZlbIasZlG9GTC+xQYHFUdRRxHh+kj4jnNNvG30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786816; c=relaxed/simple;
	bh=zp2dMt+yjhF3eyIHLjTj4HyNRzZlB75SPMjDbLBUtJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ge5+Wyo0KzyNOfrU++QTOfG0+GD4IroeO4tzyj4LVEvWIiRDNwGxmWblTPElKbY41uteeoH0kRxi4kP8qnh7Sw5S7Qg+Avyja/BiRWWJbIzruBcx3PG7aah6Ayrapl9Whenyjyb6IwGm/oSZhxYKdErfY6nQ7Uxe5dvqGNjvcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLntSBM4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso441597f8f.1
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 18:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761786813; x=1762391613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfdC6BA3C55DAY0eYCH2R7BL+WQipDPcFzwnCGu7Q0U=;
        b=RLntSBM4toOk35dXK66sbqTdmdhOf/v3xnKkcZ+wbdlvgKQmZGxlx71ffwbjFindPc
         JcfwxIHz7vDrF4GSB9G1ISUGQyljnKJBODTgrQjbUYZiVDE54iLX143M+YPAO9dE5wwA
         uz64m7xuaQIdjrV4LRDuTiyhcWFY+bv528mDQMUyaNbIkRxL1ZLGQgGF24lmxhu5buX5
         BC6hy/nqHmdvO92eMvmikMFSCwVMn5oiqZ5w4PVLGrRFYZkZsyENU/PDxqlttHZxbmPe
         UFrLiEhpEIlk0tIms4N96swNZpeIvx4S9RqMJMb16T+0+K2GddqNo8bay0DXH9+WH+iF
         tz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761786813; x=1762391613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfdC6BA3C55DAY0eYCH2R7BL+WQipDPcFzwnCGu7Q0U=;
        b=vgsp1MYXu2+YZsAlMcRu4sz0DDTLGu/c91jX8Mv+ka0EIRjjnk08RTVxeKf8lHkW/T
         dPRl5drtERwPwxzRXu9EwHWjyY/XQYWiUVBQskLoxPvF9OIcLXlEnYCP8e/JUWWVOAxK
         sA+a6UJuhAjSItOQWkM1T3A/o3bWuMpT5X7g0dL4sjL9TH8B+6zRX8fFv2RDn8ITOnfN
         AmqcqoJIKNqeG8u28zRyp4wzlN7qURD0XhyiFKp19FfVHmDIsSPVAOEUj2NitY7a3n86
         aQekMyMwp7uAAA16n7Rbixrw8qo9RbzEKLYMyLO65E4x8H6MhNgD5diYhrmAmchoPcwE
         Q9mw==
X-Gm-Message-State: AOJu0YydSmxTgpTMw0MsKMuZPcGug7tzVgc0rBeA1gPekilDAPDrtFMs
	/5AH3qgp8QM3BtzBEV39C724dlxyChE/Ts04oyPPFsmR1WCs/YxZe/i0jTZah2Oo6gmY7tLQcqg
	rcwwPShO0fbNYVZnWoOLuS8tiocw72K8=
X-Gm-Gg: ASbGncth0G16XmGiSITa0P420nttfnwRndbVhhIkuF85Q9MYmj2LkZ5oTBVgl2w0z3u
	bcKI37Hpq3Mn5MYoMZhzajwhn9Ixz03+dcJscJ0ldqLETA2FYgGDdPwzc93iE4hdJRRpLnShByn
	tIK1QJvWKVFrrdhFowy37PPqGtIhvfzOkt+oZzfM6CHMtZIcWDBprvsjxmf8BeP15iY7CLOJSva
	DYAbsq66T40EXFbsQ1j+ayIZVDhbHnu7idzerDzfHf4Kr7tP6ZJzjoxviA4bsVmug7xw1vP4Ftb
	ZxwySDcG/aVxe5Z+5tRnQqPDc2Sf
X-Google-Smtp-Source: AGHT+IE/5cBzEXCX+so8itvjyp18Ie2ylHVUwzxHgT4s9Mq+PJQYv6AulMARj0Vissn86UffXRwyNM3YwOdZZg2mwvM=
X-Received: by 2002:a05:6000:2507:b0:427:83d:34b6 with SMTP id
 ffacd0b85a97d-429b4c9e9bcmr1164257f8f.42.1761786812599; Wed, 29 Oct 2025
 18:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029183646.3811774-1-yonghong.song@linux.dev>
In-Reply-To: <20251029183646.3811774-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 18:13:21 -0700
X-Gm-Features: AWmQ_bnIdG79Kolrv3suemlb9doMiBPi479vjuglhp-L9tq7ianh9k8cRkplRz8
Message-ID: <CAADnVQJbat5mwSoDUUf9yNheTe6h58f3JFM=UMpgOSytnCCWuw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Make migrate_{disable,enable} always inline if
 in header file
To: Yonghong Song <yonghong.song@linux.dev>, Peter Zijlstra <peterz@infradead.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Menglong Dong <menglong8.dong@gmail.com>, Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:37=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> With latest bpf/bpf-next tree and latest pahole master, I got the followi=
ng
> build failure:
>
>   $ make LLVM=3D1 -j
>     ...
>     LD      vmlinux.o
>     GEN     .vmlinux.objs
>     ...
>     BTF     .tmp_vmlinux1.btf.o
>     ...
>     AS      .tmp_vmlinux2.kallsyms.o
>     LD      vmlinux.unstripped
>     BTFIDS  vmlinux.unstripped
>   WARN: resolve_btfids: unresolved symbol migrate_enable
>   WARN: resolve_btfids: unresolved symbol migrate_disable
>   make[2]: *** [/home/yhs/work/bpf-next/scripts/Makefile.vmlinux:72: vmli=
nux.unstripped] Error 255
>   make[2]: *** Deleting file 'vmlinux.unstripped'
>   make[1]: *** [/home/yhs/work/bpf-next/Makefile:1242: vmlinux] Error 2
>   make: *** [/home/yhs/work/bpf-next/Makefile:248: __sub-make] Error 2
>
> In pahole patch [1], if two functions having identical names but differen=
t
> addresses, then this function name is considered ambiguous and later on
> this function will not be added to vmlinux/module BTF.
>
> Commit 378b7708194f ("sched: Make migrate_{en,dis}able() inline") changed
> original global funcitons migrate_{enable,disable} to
>   - in kernel/sched/core.c, migrate_{enable,disable} are global funcitons=
.
>   - in other places, migrate_{enable,disable} may survive as static funct=
ions
>     since they are marked as 'inline' in include/linux/sched.h and the
>     'inline' attribute does not garantee inlining.
>
> If I build with clang compiler (make LLVM=3D1 -j) (llvm21 and llvm22), I =
found
> there are four symbols for migrate_{enable,disable} respectively, three
> static functions and one global function. With the above pahole patch [1]=
,
> migrate_{enable,disable} are not in vmlinux BTF and this will cause
> later resolve_btfids failure.
>
> Making migrate_{enable,disable} always inline in include/linux/sched.h
> can fix the problem.
>
>   [1] https://lore.kernel.org/dwarves/79a329ef-9bb3-454e-9135-731f2fd5195=
1@oracle.com/
>
> Fixes: 378b7708194f ("sched: Make migrate_{en,dis}able() inline")
> Cc: Menglong Dong <menglong8.dong@gmail.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/sched.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index cbb7340c5866..b469878de25c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2407,12 +2407,12 @@ static inline void __migrate_enable(void) { }
>   * be defined in kernel/sched/core.c.
>   */
>  #ifndef INSTANTIATE_EXPORTED_MIGRATE_DISABLE
> -static inline void migrate_disable(void)
> +static __always_inline void migrate_disable(void)
>  {
>         __migrate_disable();
>  }
>
> -static inline void migrate_enable(void)
> +static __always_inline void migrate_enable(void)
>  {
>         __migrate_enable();
>  }

Peter,

Are you ok if we take this?

I cannot think of a good alternative.

We can mark [__]migrate_disable/enable as notrace, nokprobe,
but attaching to them is only problematic for bpf.
Hence we keep them in our own deny list on the verifier side
which causes above issues with partial inlining.

