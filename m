Return-Path: <bpf+bounces-32776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F05F691300C
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 00:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC5B1F25AA9
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 22:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B97717C7CB;
	Fri, 21 Jun 2024 22:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAQ89KgE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C262315FA65
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007468; cv=none; b=i2K6hhp1dRTJYTZUb0+3zduD2VFPy0gFBcX088fpnDxaUjc6ilwFwngk4Jcv4TxZRT5cIKnK6SK4y+/C6W8l/zBHpDVu9D2UT0oU6mOJHu2fWj1tsB+x99bkNc4zkPQcsHbsnV8YQ4kL94m5q8o9ZXQWU6zvbgIRhb9AJYTZivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007468; c=relaxed/simple;
	bh=O+Zl7lK5N8nDm2q3mZbmphQ25z/bJ+1z/S9ycp+dUyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/PSL8SF9xyOnqhU+TOSB7Uvo8ggLpj0NLl830n0OFSzz11fX5B6YIfA4qwtSxsUCWcRYPJCF+BJkIOfd2GaNulKoKS/KSyLWQEpo4miIMP8fhcfzEn8H4sikifJur3tnsgXCyJEF6Fd3wV90la70p8rp7ZsWYrofCJxkteT6f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAQ89KgE; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-707040e3018so1749540a12.1
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 15:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719007466; x=1719612266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrTDFeY/i3TSDWjEJPvEQeAweVn7WOKNwOUd2ZRTfa4=;
        b=DAQ89KgE1OEdXsRdjnv6zEEVm6VmS+YeLRtCKNmiqiXZQfwHQIl9fY/NIls50Gi1VZ
         XanYD9kXBQYWeCMzsqoU2BiOIfMRFO9Gv1q5OLr2VUEOGWwDD0YWGcT+McSEYFNLPbBp
         hJ3e/wL+n7nSuBavqeRQjBmcDA/D8AKz7sGQLnICW2nHaHOd5JtmqM9BujBDuSRdQ+qP
         aXX9vfPE41grsfDBiR0Yi9JhiJQzjWof7p1VIoiTTKscseOpU5PdNo5xEuQPdJLPSd+R
         1gFhV91wafm/jTVuuZPNhqKXmhw65BCeBVEHX7Rs3tZFQH9ljWj/EEIhQwrsk2uI05vu
         nZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007466; x=1719612266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrTDFeY/i3TSDWjEJPvEQeAweVn7WOKNwOUd2ZRTfa4=;
        b=PnbnxZvV2ASh1iLJWfAd0D4vXuUJYOhqtIeFbPRtDDC17teRYf6FIXQlk0I7+mNA3O
         FG2Q+x7LYTr5RFe2zGmQN6TBXA4bZByrFmgedAVB/3z1ll3EGQe4FhJUTUS9x5tvPpzT
         RWmbpiTCdMykQMrlv2RC7goBY+Gqlc/sp6NGiTVItVdyUqrB+T/al/g1ptJ7nLjmUK90
         FyWzchBDIyHk37BbYynxfSImjm91ZB74ivLaXxq8ucVm4zlgQ6D+bXC97Zhfb7HBYBXh
         oUBNNv5TEnzZ5zjt4IKRjLiFtik7mjd1KvUCAa7rV7uSmcxUi9PvlJC2pY8ssgGCGW0M
         vSDw==
X-Gm-Message-State: AOJu0YwQVA3B6I7FcjTfqWALNq+ovtG3ONJE/ByTYha25IqxM6nK1zwi
	ML1jQ8E649RSqjsyN6YWFiG6EFGeHAd3fYJ7vGzJKpCzjBJducVz7wnZUG6eF6CeXNgp/QDJ4/E
	eGnuY9ghrPq9eFRvzLsH1T9hL+dw=
X-Google-Smtp-Source: AGHT+IGB+YSTCb/BMgKjRASLjft2RCfFlSyci5fBUUlT5DpNeSnqCI97qLUb/tOjt6diCmO97dyCi2wBcstpltJO9Bg=
X-Received: by 2002:a17:90b:3542:b0:2c4:a9b2:d4da with SMTP id
 98e67ed59e1d1-2c7b5d5ab34mr9675989a91.30.1719007465956; Fri, 21 Jun 2024
 15:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZmIyMfRSp9DpU7dF@debian.debian>
In-Reply-To: <ZmIyMfRSp9DpU7dF@debian.debian>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Jun 2024 15:04:14 -0700
Message-ID: <CAEf4BzbpSYmsTYSgMws7p8B2i1ihFZum0zge5W7DCo0FR8pSyA@mail.gmail.com>
Subject: Re: Ideal way to read FUNC_PROTO in raw tp?
To: Yan Zhai <yan@cloudflare.com>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:03=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote:
>
> Hi,
>
>  I am building a tracing program around workqueue. But I encountered
> following problem when I try to record a function pointer value from
> trace_workqueue_execute_end on net-next kernel:
>
> ...
> libbpf: prog 'workqueue_end': BPF program load failed: Permission
> denied
> libbpf: prog 'workqueue_end': -- BEGIN PROG LOAD LOG --
> reg type unsupported for arg#0 function workqueue_end#5
> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> ; int BPF_PROG(workqueue_end, struct work_struct *w, work_func_t f)
> 0: (79) r3 =3D *(u64 *)(r1 +8)
> func 'workqueue_execute_end' arg1 type FUNC_PROTO is not a struct
> invalid bpf_context access off=3D8 size=3D8
> processed 1 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'workqueue_end': failed to load: -13
> libbpf: failed to load object 'configs/test.bpf.o'
> Error: failed to load object file
> Warning: bpftool is now running in libbpf strict mode and has more
> stringent requirements about BPF programs.
> If it used to work for this object file but now doesn't, see --legacy
> option for more details.
> ...
>
> A simple reproducer for me is like:
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
>
> SEC("tp_btf/workqueue_execute_end")
> int BPF_PROG(workqueue_end, struct work_struct *w, work_func_t f)
> {
>         u64 addr =3D (u64) f;

you can work around with:

bpf_probe_read_kernel(&addr, sizeof(addr), &ctx[1]); /* ctx[1] is the
second argument */

Not great, but will get you past this easily.

>         bpf_printk("f is %lu\n", addr);
>
>         return 0;
> }
>
> char LICENSE[] SEC("license") =3D "GPL";
>
> I would like to use the function address to decode the kernel symbol
> and track execution of these functions. Replacing raw tp to regular tp
> solves the problem, but I am wondering if there is any go-to approach
> to read the pointer value in a raw tp? Doesn't seem to find one in
> selftests/samples. If not, does it make sense if we allow it in
> the verifier for tracing programs like the attached patch?
>
> Yan
>
> ---
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 821063660d9f..5f000ab4c8d0 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6308,6 +6308,11 @@ bool btf_ctx_access(int off, int size, enum bpf_ac=
cess_type type,
>                         __btf_name_by_offset(btf, t->name_off),
>                         btf_type_str(t));
>                 return false;
> +       } else if (prog->type =3D=3D BPF_PROG_TYPE_TRACING || prog->type =
=3D=3D BPF_PROG_TYPE_RAW_TRACEPOINT) {
> +               /* allow reading function pointer value from a tracing pr=
ogram */
> +               const struct btf_type *pointed =3D btf_type_by_id(btf, t-=
>type);
> +               if (btf_type_is_func_proto(pointed))
> +                       return true;
>         }
>
>         /* check for PTR_TO_RDONLY_BUF_OR_NULL or PTR_TO_RDWR_BUF_OR_NULL=
 */
>

