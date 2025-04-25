Return-Path: <bpf+bounces-56711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BAFA9D015
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 19:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A501BC2CCA
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04B920B808;
	Fri, 25 Apr 2025 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blZJdoHk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C832F2A;
	Fri, 25 Apr 2025 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745603913; cv=none; b=WxKGCnvz3Ie6VeFHk3UpDAA+8g5sVGebnLFeTQ12skVbPOtNYrjGt4g/cIugX4BAOun9N3Umox+Yo+bIfN6EH4NtkvAQQN10khOhrmrxDvbvEsnkAooXEYJyLrx9WmpqN3E5g4JAowOQoOMPH6GvNXySyoX/hl5k83kvw6OFprA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745603913; c=relaxed/simple;
	bh=uLC5KuMbnc3nAxdin887VPmdeP4JS7kMZkXnbldNTmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8n6Z79K8bbabasIIZnlvZ2fnTNsl/u1hWKsVuNmmRjNtIIUDMXEsuKSe8/mrSwR2t4tk4zWWMYNo1rhM+eaJMbyPsH24qxmfskVteLgiLs3Ujjx9tyi3sOqkZHtt/ktqQ9gfGU1Hduy6q8gUeQbYLM5iXDrKL5OcpvYdP7An/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blZJdoHk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3031354f134so2230311a91.3;
        Fri, 25 Apr 2025 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745603911; x=1746208711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7F2wrv4jQ7pRqzQqiXr/whW+NaJHXxE4q18vYVOU+4=;
        b=blZJdoHkDR4od7NNNfrB8/VagjJScLiOgmMAtDHiH1uQIoWb3EB6Rf2sVCvQ6ROuLT
         wMTTZAoWvNuQroZg9WdHyDUi1hknZR43xk4Tv+vSStWpyByvZAwlQR8/yqJDwA8myv/F
         f9scW0SSd6vP69f/FFygyekQz4oO8xctpqS9XEjLyhAwuweAHYKk/hD22DtdzMl5rza/
         F14Ksj5Z03WqPpE+gdz8Yqockd9DMDB7wtk1seB8oEa5jvukPoHxV+mb5ETaDDBPMH7M
         oSrrFU3oEsgLwqMX7L+LPkIMEE1JxTKweJ14ox6Fn+DEsIdWK2TVwfCsHuYqLui7CC9h
         dGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745603911; x=1746208711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7F2wrv4jQ7pRqzQqiXr/whW+NaJHXxE4q18vYVOU+4=;
        b=bfdaFOSbjG7BiejWQOz9QAswwDkDeO8cw59p9ccyHGBn5RJtRJpzJyNClaGc4LtISq
         kaFtZ0jiBKbGoyrzkL54CG3+gpFWIBlfpUcSIBpJV+5MJY6uCrucu8uwzePacBqf1HWS
         OftW3RABvJVRwL3+N/03DJ15gKEOGm3Pxy31oMxLRhHRTrTIyQa8/fnEk19rKWr67GtK
         KHdPkckoTNAf5iE9GwjnA9l3ZTBe4wkF+AoEtENrKRuC6wsOFimy15YrFPZuIaMQ0crs
         04CcoUQf3volGJTURuWkpoPVHR8Hfr5Ghl/86+M+3k/HVLoERwn6bP4apXRfsCdeGRsg
         Kwig==
X-Forwarded-Encrypted: i=1; AJvYcCUDnEQFNC9+xIJpwB1FEwKIZGAJZS1R9W3/O4LjpuQ5tg0hCjBkE0mGbWaImU6n4G4/v6JDzlzT7Q==@vger.kernel.org, AJvYcCWVykfMyYj1oHXCAnVef+aEQnaphXXhIrEbuibxP8cPXbrrIHTdLuGjq5/YrLP8Xt4soAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIkcU0DpVC28ZpV1jJ2zTl7QRuyQKkfvtuiyMZefHltdFN1GJr
	2N7ux6T1h0W4GlgfHY1PLs4g8s5TtqSuMc1Pk+2UOklczIMALXUgCYI2T2H2DJLjfyTHHNPWI8I
	yTeeCHlMz0l+vE0PLQuccDKFZpCA=
X-Gm-Gg: ASbGnctG9lFFkHUZxjpUy2n+kv4ZRX2QD/JpevjvkEuy52hz6uJjtXCm51LMi284KkK
	z3CTvIiZbSaQ+e432Ic5F/0kHWkO5NNGPyxgMhUysPEOrifdlqkMO3OiV4E3TiVafKei7Iz1B4j
	xQy9C0e+5zNUQ26yj0QxdzIi7eeV84yd6S8Sddbd/W5AIX2/0o
X-Google-Smtp-Source: AGHT+IEdcQwv9qnR4eNLU5AZu8jA8ObNsJ6qK/tI6tVLxJz8ZAZMBkpdze3UDsrY8GNG37GQi5DhyTZP971l84+sZzo=
X-Received: by 2002:a17:90b:1d4d:b0:2ee:f076:20f1 with SMTP id
 98e67ed59e1d1-309f7c62025mr6112275a91.0.1745603910981; Fri, 25 Apr 2025
 10:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com>
In-Reply-To: <076e52f6-248a-4a41-a199-3c705cb3d3c5@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Apr 2025 10:58:18 -0700
X-Gm-Features: ATxdqUHIiQRZyNx2VJkvg9AKhti3brHYcUYdqyB-jo-wzIdwF0e39tpAEgoQxNg
Message-ID: <CAEf4Bzb9ozx056hm3=zh=4Sh_62EydK_wtJkNpgH9Yy0cuSsUQ@mail.gmail.com>
Subject: Re: pahole and gcc-14 issues
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 10:50=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 25/04/2025 15:50, Alexei Starovoitov wrote:
> > Hi All,
> >
> > Looks like pahole fails to deduplicate BTF when kernel and
> > kernel module are built with gcc-14.
> > I see this issue with various kernel .config-s on bpf and
> > bpf-next trees.
> > I tried pahole 1.28 and the latest master. Same issues.
> >
> > BTF in bpf_testmod.ko built with gcc-14 has 2849 types.
> > When built with gcc-13 it has 454 types.
> > So something is confusing dedup logic.
> > Would be great if dedup experts can take a look,
> > since this dedup issue is breaking a lot of selftests/bpf.
> >
> > Also vmlinux.h generated out of the kernel compiled with gcc-13
> > and out of the kernel compiled with gcc-14 shows these differences:
> >
> > --- vmlinux13.h    2025-04-24 21:33:50.556884372 -0700
> > +++ vmlinux14.h    2025-04-24 21:39:10.310488992 -0700
> > @@ -148815,7 +148815,6 @@
> >  extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum
> > hid_report_type type, u8 *buf, const size_t buf__sz) __weak __ksym;
> >  extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __weak __=
ksym;
> >  extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx, enum
> > hid_report_type type, u8 *buf, const size_t buf__sz) __weak __ksym;
> > -extern bool scx_bpf_consume(u64 dsq_id) __weak __ksym;
> >  extern int scx_bpf_cpu_node(s32 cpu) __weak __ksym;
> >  extern struct rq *scx_bpf_cpu_rq(s32 cpu) __weak __ksym;
> >  extern u32 scx_bpf_cpuperf_cap(s32 cpu) __weak __ksym;
> > @@ -148825,12 +148824,8 @@
> >  extern void scx_bpf_destroy_dsq(u64 dsq_id) __weak __ksym;
> >  extern void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64
> > slice, u64 enq_flags) __weak __ksym;
> >  extern void scx_bpf_dispatch_cancel(void) __weak __ksym;
> > -extern bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq
> > *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak
> > __ksym;
> > -extern void scx_bpf_dispatch_from_dsq_set_slice(struct
> > bpf_iter_scx_dsq *it__iter, u64 slice) __weak __ksym;
> >  extern void scx_bpf_dispatch_from_dsq_set_vtime(struct
> > bpf_iter_scx_dsq *it__iter, u64 vtime) __weak __ksym;
> >  extern u32 scx_bpf_dispatch_nr_slots(void) __weak __ksym;
> > -extern void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id,
> > u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
> > -extern bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq
> > *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak
> > __ksym;
> >  extern void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64
> > slice, u64 enq_flags) __weak __ksym;
> >  extern void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64
> > dsq_id, u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
> >  extern bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
> > struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;
> >
> > gcc-14's kernel is clearly wrong.
> > These 5 kfuncs still exist in the kernel.
> > I manually checked there is no if __GNUC__ > 13 in the code.
> > Also:
> > nm bld/vmlinux|grep -w scx_bpf_consume
> > ffffffff8159d4b0 T scx_bpf_consume
> > ffffffff8120ea81 t scx_bpf_consume.cold
> >
> > I suspect the second issue is not related to the dedup problem.
> > All 5 missing kfuncs have ".cold" optimized bodies.
> > But ".cold" maybe a red herring, since
> > nm bld/vmlinux|grep -w scx_bpf_dispatch
> > ffffffff8159d020 T scx_bpf_dispatch
> > ffffffff8120ea0f t scx_bpf_dispatch.cold
> > but this kfunc is present in vmlinux14.h
> >
> > If it makes a difference I have these configs:
> > # CONFIG_DEBUG_INFO_DWARF4 is not set
> > # CONFIG_DEBUG_INFO_DWARF5 is not set
> > # CONFIG_DEBUG_INFO_REDUCED is not set
> > CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
> > # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
> > # CONFIG_DEBUG_INFO_SPLIT is not set
> > CONFIG_DEBUG_INFO_BTF=3Dy
> > CONFIG_PAHOLE_HAS_SPLIT_BTF=3Dy
> > CONFIG_DEBUG_INFO_BTF_MODULES=3Dy
>
> thanks for the report! I've just reproduced this now with gcc 14; my
> initial theory was it might be DWARF5-related, but dedup issues occur
> for modules with CONFIG_DEBUG_INFO_DWARF4=3Dy also. I'm seeing task_struc=
t
> duplicates in module BTF among other things, so I will try and dig
> further and report back when I find something. Like you I suspect the

This is a bizarre case. I have a custom small tool that recursively
traverses two parallel subgraphs of BTF types and prints anything that
differs between them ([0]). (I had to disable distilled BTF to make
use of this, the issue is present both with distilled BTF and
without).

I see that struct sock both in vmlinux and bpf_testmod.ko are
*IDENTICAL*. There is no difference I could detect. So very weird. I'm
thinking of bisecting, as this didn't happen before with exactly the
same compiler and pahole, so this must be a kernel-side change.

  [0] https://github.com/anakryiko/libbpf-bootstrap/tree/btfdiff-hack

> issues with missing kfuncs are different; may be an issue with our logic
> handling inconsistent functions getting confused by the .cold
> components. But right now understanding dedup issues is the top priority.
>
> Alan

