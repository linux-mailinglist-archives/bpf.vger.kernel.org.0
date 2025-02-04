Return-Path: <bpf+bounces-50392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771DBA26F19
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 11:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DF2D7A02CD
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 10:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC42A2080E5;
	Tue,  4 Feb 2025 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+pmHr4y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA2E2080C3
	for <bpf@vger.kernel.org>; Tue,  4 Feb 2025 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738663858; cv=none; b=PMW6Z++ALaCnz4ZNdq/eJyZ2ROq2lbipZEMUA1NFr1yM94GCE20OLNEl2GXbtOU0UgLEQrOcYAxL4Ij/Fu5PIzMd6p/933AfD4Bl8sI2WrIPqrYIncB/V33bDh/Y9wBfOCYyU8WmdV8bL7VKcjTW6k4GU2Oib60yX+hLnV1oWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738663858; c=relaxed/simple;
	bh=mHj6Md4adK8XS4Ew1wHAcIDEFdCZGEvMDijB6ZLlhoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3C+Cpxrnrl9dFUTNzSWmn8aXqSkg/YCwIgL/lZfjPzFHqnRc6rAIP/qcSTmLmUOATDAmF4KebyZXwR+AvjRjmkHu6Way4XeVMWusMMovfsvnLsHzYjo5jxs8ZIySv95xQyuqbJa9JRiVG449AhVu2wtgXyyzwziSRxcnfvawLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+pmHr4y; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43621d27adeso36683385e9.2
        for <bpf@vger.kernel.org>; Tue, 04 Feb 2025 02:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738663855; x=1739268655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRgQ7dG9wqKIAVX+6Sbx5QxZgsQ1LsB6hYow6pKgi8U=;
        b=m+pmHr4yrj7lXfEqYFN2f2KGxQnn8cMA1tJpO5MeIJFXifWJTuWLZqrHGd7BRMqlic
         MajukNJegeVwK3oTUSsDZGhEKEjXnX7A2lgJJb9E9JhvMoQM8j00K4NPhbFZ9rL2YczX
         JqR8jnEzZEKtx+0VuxQOKvMQEPArLd52jViLGtW0D9mb2CubbVECScvtwV4CxqEL04pF
         E9sXfNTDON9/H031K5ustmwO3t1VjruOl7jCEM3mT4SNmhev/JZjxQa+nlrl51SrssgA
         /s9OS6FYgBDfX/wplBBXfhgsZu2NL5aBgG/coKkuYn1PsmnIEPBVcZjmtQtHGuWjcvv9
         OExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738663855; x=1739268655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRgQ7dG9wqKIAVX+6Sbx5QxZgsQ1LsB6hYow6pKgi8U=;
        b=XPSI+oFUMvMoocZ42cWY1zfHSIi27DUA7sWEyEx8s5L6C4XmzTWhlgfNlO31uH2A98
         B2plP7P0YZbIf2US2JhgSogGVgRkyiodesS5sUK4wXLnqOYqBWIkXucCpSofzh8bfrzK
         8QwIuU+onJc4HhfoHioGsDFKGwt7zIJSnLpB3qhI2zFUk/6YLqdIZPmXkHtHFjT+Bvtc
         EHbZWeWBrb3CQaEUlWZ7CP1zFKeQCe2eJtmFKwq1GXRf4H/6/ud/7bDTHa3StT9yHsO0
         AHIMrsay+55i7truKm1zwGeDeJIFlCL5M5wBv7Rmw65zYGToNAFeRQHFbCtmRaHljanN
         6SXw==
X-Forwarded-Encrypted: i=1; AJvYcCXmlBBEiKLLchXt48QLyezlscsffBT2655TzI1OK+rIQMkOFirAPUWvaWyhGVA2YUsP2mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdPJdVNqKCWDVxcxLms1WMvKZkVU5n+7gN1TJ19uKMUJMhcBA4
	gZa384YXEpkZ3kC6t8a9FNCbaTUd8kKPaxuG/1IVN3FMlH1kTXmIsIjniX5UULrwqvYBoi+x7CC
	jUeKgezmqUUSCeqg6lxjDMlC+m4AGSrGcAVo1fQ==
X-Gm-Gg: ASbGncuPD1Z1d3duWHgzPxjicPxVMg7q5kBeLrT/zxBRGoZHwxTocOWkuVO42l6QgYl
	HoXbmPEOQ8CKqayZOLvq+rKdNI0Om0Q0WIrKGct9vM2ZvKbLcKTYjiwtqpy4hB/upoUKpx66klx
	UcxWiEZfdVjLUB
X-Google-Smtp-Source: AGHT+IF16tgNqX/928vfYyHykdbpE4Ntg2eJURZ/PQNzJk59jG1ofUcvie+5U5y6/iSI/fiT0cNr4l7VFgg5gVlVWJQ=
X-Received: by 2002:a5d:5988:0:b0:38b:ed1c:a70d with SMTP id
 ffacd0b85a97d-38c5167b477mr22357999f8f.0.1738663854437; Tue, 04 Feb 2025
 02:10:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204092455.3693003-1-alan.maguire@oracle.com>
In-Reply-To: <20250204092455.3693003-1-alan.maguire@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Feb 2025 10:10:43 +0000
X-Gm-Features: AWEUYZkeI1oHVgWojobkNnqCblvElzsubPJU7v0v9CB9jj1ZN9FE8m-mr7ZTyYg
Message-ID: <CAADnVQLPMphk-5RyYfJ5E=UxkkUDdoigLWD7trmLRfT37zG26w@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf/arena: fix softlockup in arena_map_free on 64k
 page kernel
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Colm Harrington <colm.harrington@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 9:25=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On an aarch64 kernel with CONFIG_PAGE_SIZE_64KB=3Dy (64k pages),
> arena_htab tests cause a segmentation fault and soft lockup.
>
> $ sudo ./test_progs -t arena_htab
> Caught signal #11!
> Stack trace:
> ./test_progs(crash_handler+0x1c)[0x7bd4d8]
> linux-vdso.so.1(__kernel_rt_sigreturn+0x0)[0xffffb34a0968]
> ./test_progs[0x420f74]
> ./test_progs(htab_lookup_elem+0x3c)[0x421090]
> ./test_progs[0x421320]
> ./test_progs[0x421bb8]
> ./test_progs(test_arena_htab+0x40)[0x421c14]
> ./test_progs[0x7bda84]
> ./test_progs(main+0x65c)[0x7bf670]
> /usr/lib64/libc.so.6(+0x2caa0)[0xffffb31ecaa0]
> /usr/lib64/libc.so.6(__libc_start_main+0x98)[0xffffb31ecb78]
> ./test_progs(_start+0x30)[0x41b4f0]
>
> Message from syslogd@bpfol9aarch64 at Feb  4 08:50:09 ...
>  kernel:watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworker/u8:4:7=
589]
>
> The same failure is not observed with 4k pages on aarch64.
>
> Investigating further, it turns out arena_map_free() was calling
> apply_to_existing_page_range() with the address returned by
> bpf_arena_get_kern_vm_start().  If this address is not page-aligned -
> as is the case for a 64k page kernel - we wind up calling apply_to_pte_ra=
nge()
> with that unaligned address.  The problem is apply_to_pte_range() implici=
tly
> assumes that the addr passed in is page-aligned, specifically in this loo=
p:
>
>                 do {
>                         if (create || !pte_none(ptep_get(pte))) {
>                                 err =3D fn(pte++, addr, data);
>                                 if (err)
>                                         break;
>                         }
>                 } while (addr +=3D PAGE_SIZE, addr !=3D end);
>
> If addr is _not_ page-aligned, it will never equal end exactly.
>
> One solution is to round up the address returned by bpf_arena_get_kern_vm=
_start()
> to a page-aligned value.  With that change in place the test passes:
>
> $ sudo ./test_progs -t arena_htab
> Summary: 1/1 PASSED, 1 SKIPPED, 0 FAILED
>
> Reported-by: Colm Harrington <colm.harrington@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  kernel/bpf/arena.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 870aeb51d70a..07395c55833e 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -54,7 +54,7 @@ struct bpf_arena {
>
>  u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
>  {
> -       return arena ? (u64) (long) arena->kern_vm->addr + GUARD_SZ / 2 :=
 0;
> +       return arena ? (u64) round_up((long) arena->kern_vm->addr + GUARD=
_SZ / 2, PAGE_SIZE) : 0;

Thanks for the report. The fix is incorrect though.
GUARD_SZ/2 is 32k,
so with roundup the upper guard is gone.
We probably need to:
-#define GUARD_SZ (1ull << sizeof_field(struct bpf_insn, off) * 8)
+#define GUARD_SZ round_up(1ull << sizeof_field(struct bpf_insn, off)
* 8, PAGE_SIZE << 1)

Better ideas?

pw-bot: cr

