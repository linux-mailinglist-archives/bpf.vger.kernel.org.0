Return-Path: <bpf+bounces-56731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C13AA9D32C
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 22:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F47189A90D
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCDC22259C;
	Fri, 25 Apr 2025 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcNH7fVM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5BA2222C2;
	Fri, 25 Apr 2025 20:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745613697; cv=none; b=PNUW7z5WVQ13Y05oh6d/3DIM+jDS37s4dkV47DbSuAfIk+zDKcxGCW8QtLj1KPf8OElYZaXJnBb5w63CuynINFqcSn1kVhjp36N902o6MVX5A3fgLsSBpVSjZhTyTqz8gy3UB9Ufuhkr81ZhMvxfOATlXHcueRI03brPpFVQq2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745613697; c=relaxed/simple;
	bh=TD1xf72MhlCqzT7aAbu+qBg0/eiPSwLcbP00GlubeRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4rWaP4tcJHaw+6bbjAqIikMH7lo/ZE+WgJRspMHvsFGqm5rUwFrlyZtPDwZHgZWsTpjMGN8hNDKwzOWxxJNndWAtuAWtQcRTh3XHvmhFeKUoldoPy1HavGxaeaD0PkXL+ysBKSM+4DABFcDMai/rU2mUmRlbd7aEizxaxY/oDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcNH7fVM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736bfa487c3so2296659b3a.1;
        Fri, 25 Apr 2025 13:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745613695; x=1746218495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFpR8NYfD4qNv0osvak7vSaFSH/S8yEO4WR6JKy2Mls=;
        b=ZcNH7fVMITiuRnty9ZdaotfYl0V9hmzugMel36qS/IDM1o4OHJk+KecbFNBNZUL9Jk
         zOQbRW5D6MrdpM47+tvfVkvdbcQd+SKuCnmwawlwfjrIVRnoDz6l6F6Z5pzCpMZZbmoM
         P2Kh2ttRZsJ5gV9E1Cr42UT78U2YfafzBnpzQIDYa0LQsRGi15jQzCb22vmTaKk4mZ+A
         xp5GaxyBHjcwMakVttELP2VIS0PdnufHCZPArcboquZaZ/re+yyEUZ7z28POHEj6Lhei
         jxbTumxL6g1jjOK7sdpj6ccxp02lB8yE/plGlySw4p8mrvnh8jDNnthADLCALjL19qnP
         mGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745613695; x=1746218495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFpR8NYfD4qNv0osvak7vSaFSH/S8yEO4WR6JKy2Mls=;
        b=ppIiGA+LAJOECXK9SA+nAygWn3665dKxc0nGjHUW8RS72/7gwBaU6LDsMpsvvox0fp
         RJJlG90AJ+iWtvGm8fPgPiPPpHVs2vcj+FFEfBRS02C0HNxgWg1147te69KLAwA9xE0A
         2L3uVmraQLGSXI4rMqZqhU5mbBQDj88pwy1LEdpjCEsPoEW75j5XYxoiGl4/xduuuQhQ
         yvAq+i5yeECklesQWTkdv0IIxQijS9D+IhjNqCXOv0ZIFRWoCWIEND3q1TQH38o5wclW
         5w0EVNQ91apHp5DHXhnSnjWcIICm+tH6tUHYaSK2/nw8oOIceXTER9OrADl9akyBxVGE
         eEIw==
X-Forwarded-Encrypted: i=1; AJvYcCXMlVk/MRSY6FZtxyrwJlhaZyi0FxMi6S8VqEKnFxHOKluscn+6gMZEgLg8VgtLsryblbx93gFmKQ==@vger.kernel.org, AJvYcCXSForGRV8QC5Sxz549Gx3nSFurkcNWALeWvLg2aQh7F68KKW111sy2AxW9hI0nmgr4bDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyeDFAjWU4ha0rR8cRG27v7AIEV7Pry8yLdgbJnSRdF4egjn69
	tTmPfj2fElV+GjjT2jAjx+WxKRn6w7DlG77pOtnNw3M0U5kbDt84wI4AoAJvuyALdmFY9sii19v
	sOAg97I8rA1n7PBla8MlJjE3zVao=
X-Gm-Gg: ASbGncsNv+Up8PsSle7pCvO41QbsdiN1DL4N82oL/AlijaZKkCPj6Ks1pWKDMn246wn
	Td5cLaOMtMgiQQctQfrA8FklzIenYD+Kdhpgj8rk4MuosRMD3RUD6NNAP04FBHo12BfvAWT96E+
	/0nKN8g9F09r42UlmCsAXWsAXOkB/zssEWN5jvqg==
X-Google-Smtp-Source: AGHT+IFMEuT4wtRWoBtyQsXUAtd9qIbpu5OLiOO5cWn3xUXH0gFxG7aR7B29l7Lo4kin2/mggdNC3uvwIKzXQFR0I3k=
X-Received: by 2002:a05:6a21:329b:b0:1f5:852a:dd81 with SMTP id
 adf61e73a8af0-2046a6c5a2dmr864992637.34.1745613695184; Fri, 25 Apr 2025
 13:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com> <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
 <4aa02e25-7231-40f4-a0ba-e10db3833d81@oracle.com>
In-Reply-To: <4aa02e25-7231-40f4-a0ba-e10db3833d81@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Apr 2025 13:41:22 -0700
X-Gm-Features: ATxdqUHoqZd9uyz4_ywFNlYR4SUtjCq_AzL16vaLCAqFzjlEP4DQzA6iZZRPgE0
Message-ID: <CAEf4BzYRnNGGafWS8XoXRHd3zje=8xY1o5_8aVw6vxrUSbEehg@mail.gmail.com>
Subject: Re: pahole and gcc-14 issues
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 1:36=E2=80=AFPM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 25/04/2025 18:58, Andrii Nakryiko wrote:
> > On Fri, Apr 25, 2025 at 10:50=E2=80=AFAM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>
> >> On 25/04/2025 15:50, Alexei Starovoitov wrote:
> >>> Hi All,
> >>>
> >>> Looks like pahole fails to deduplicate BTF when kernel and
> >>> kernel module are built with gcc-14.
> >>> I see this issue with various kernel .config-s on bpf and
> >>> bpf-next trees.
> >>> I tried pahole 1.28 and the latest master. Same issues.
> >>>
> >>> BTF in bpf_testmod.ko built with gcc-14 has 2849 types.
> >>> When built with gcc-13 it has 454 types.
> >>> So something is confusing dedup logic.
> >>> Would be great if dedup experts can take a look,
> >>> since this dedup issue is breaking a lot of selftests/bpf.
> >>>
> >>> Also vmlinux.h generated out of the kernel compiled with gcc-13
> >>> and out of the kernel compiled with gcc-14 shows these differences:
> >>>
> >>> --- vmlinux13.h    2025-04-24 21:33:50.556884372 -0700
> >>> +++ vmlinux14.h    2025-04-24 21:39:10.310488992 -0700
> >>> @@ -148815,7 +148815,6 @@
> >>>  extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum
> >>> hid_report_type type, u8 *buf, const size_t buf__sz) __weak __ksym;
> >>>  extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __weak =
__ksym;
> >>>  extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx, enum
> >>> hid_report_type type, u8 *buf, const size_t buf__sz) __weak __ksym;
> >>> -extern bool scx_bpf_consume(u64 dsq_id) __weak __ksym;
> >>>  extern int scx_bpf_cpu_node(s32 cpu) __weak __ksym;
> >>>  extern struct rq *scx_bpf_cpu_rq(s32 cpu) __weak __ksym;
> >>>  extern u32 scx_bpf_cpuperf_cap(s32 cpu) __weak __ksym;
> >>> @@ -148825,12 +148824,8 @@
> >>>  extern void scx_bpf_destroy_dsq(u64 dsq_id) __weak __ksym;
> >>>  extern void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64
> >>> slice, u64 enq_flags) __weak __ksym;
> >>>  extern void scx_bpf_dispatch_cancel(void) __weak __ksym;
> >>> -extern bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq
> >>> *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak
> >>> __ksym;
> >>> -extern void scx_bpf_dispatch_from_dsq_set_slice(struct
> >>> bpf_iter_scx_dsq *it__iter, u64 slice) __weak __ksym;
> >>>  extern void scx_bpf_dispatch_from_dsq_set_vtime(struct
> >>> bpf_iter_scx_dsq *it__iter, u64 vtime) __weak __ksym;
> >>>  extern u32 scx_bpf_dispatch_nr_slots(void) __weak __ksym;
> >>> -extern void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id=
,
> >>> u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
> >>> -extern bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq
> >>> *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak
> >>> __ksym;
> >>>  extern void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u6=
4
> >>> slice, u64 enq_flags) __weak __ksym;
> >>>  extern void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64
> >>> dsq_id, u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
> >>>  extern bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
> >>> struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
> >>>
> >>> gcc-14's kernel is clearly wrong.
> >>> These 5 kfuncs still exist in the kernel.
> >>> I manually checked there is no if __GNUC__ > 13 in the code.
> >>> Also:
> >>> nm bld/vmlinux|grep -w scx_bpf_consume
> >>> ffffffff8159d4b0 T scx_bpf_consume
> >>> ffffffff8120ea81 t scx_bpf_consume.cold
> >>>
> >>> I suspect the second issue is not related to the dedup problem.
> >>> All 5 missing kfuncs have ".cold" optimized bodies.
> >>> But ".cold" maybe a red herring, since
> >>> nm bld/vmlinux|grep -w scx_bpf_dispatch
> >>> ffffffff8159d020 T scx_bpf_dispatch
> >>> ffffffff8120ea0f t scx_bpf_dispatch.cold
> >>> but this kfunc is present in vmlinux14.h
> >>>
> >>> If it makes a difference I have these configs:
> >>> # CONFIG_DEBUG_INFO_DWARF4 is not set
> >>> # CONFIG_DEBUG_INFO_DWARF5 is not set
> >>> # CONFIG_DEBUG_INFO_REDUCED is not set
> >>> CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
> >>> # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
> >>> # CONFIG_DEBUG_INFO_SPLIT is not set
> >>> CONFIG_DEBUG_INFO_BTF=3Dy
> >>> CONFIG_PAHOLE_HAS_SPLIT_BTF=3Dy
> >>> CONFIG_DEBUG_INFO_BTF_MODULES=3Dy
> >>
> >> thanks for the report! I've just reproduced this now with gcc 14; my
> >> initial theory was it might be DWARF5-related, but dedup issues occur
> >> for modules with CONFIG_DEBUG_INFO_DWARF4=3Dy also. I'm seeing task_st=
ruct
> >> duplicates in module BTF among other things, so I will try and dig
> >> further and report back when I find something. Like you I suspect the
> >
> > This is a bizarre case. I have a custom small tool that recursively
> > traverses two parallel subgraphs of BTF types and prints anything that
> > differs between them ([0]). (I had to disable distilled BTF to make
> > use of this, the issue is present both with distilled BTF and
> > without).
> >
> > I see that struct sock both in vmlinux and bpf_testmod.ko are
> > *IDENTICAL*. There is no difference I could detect. So very weird. I'm
> > thinking of bisecting, as this didn't happen before with exactly the
> > same compiler and pahole, so this must be a kernel-side change.
> >
> >   [0] https://github.com/anakryiko/libbpf-bootstrap/tree/btfdiff-hack
> >
>
> thanks for the pointer to this! My initial suspicion was that we had
> some sort of dups of slightly-differently-defined primitive types that
> bubbled up through multiple structs in the module case since the level
> of duplication is so high; a colleague ran across something like this
> recently and indeed if I dump vmlinux BTF in C format I see:
>
> typedef unsigned char u8___2;
>
> ...along with the original u8 definition:
>
> typedef unsigned char __u8;
> typedef __u8 u8;

Are you sure you are not dumping distilled BTF?

>
> However on checking I didn't find any references to the "wrong" u8, so I
> don't think it is the cause (the definition comes from
> crypto/jitterentropy.c so as a .c redefinition it's less likely to cause
> chaos across multiple CUs).
>
> Perhaps we should be thinking of cases where "#ifdef MODULE" leads to
> different structure content, maybe something changed that results in
> that leaking into core kernel structures like task_struct. Haven't had
> any luck finding a common culprit across duplicated structures yet..
>
> Alan

