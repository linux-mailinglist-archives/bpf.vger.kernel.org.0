Return-Path: <bpf+bounces-41649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 289F8999459
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 23:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBC11F24502
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 21:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC6A1E2830;
	Thu, 10 Oct 2024 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBfV/9Nv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D081CDFD4
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728595353; cv=none; b=dNHsHLgZE3s3hEgk0P3XOJiEDxEUuFyE4qDVuOq2JNZHIdXHFgLEyvLeEPpo0/zM2VMvTZX5cevHT8eoXA1EAFXB4x/rY7GDlavgRXB04ZGJZKWFEfJfFSWStzBsDAviS8UFm5CEsZ1FdhuXa7k0eBd3AbzLVMqIJkXSoBe4iuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728595353; c=relaxed/simple;
	bh=eBtGsv5+XN/76DQH18Musmw7aQoOXW8eycRdZbYfpMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nhgsa/lz0tjoOSVeKPVcJW7lauE92wFzJxjoSjHWgeA1Qp9J45FdCiQaH8BzR6fKB7ii3g91ttPZfkNISxbNTHm4Q3UhJaKTrrC1oBRgOrX1yJQ1jnl59iILbeUT+CcVmnK36k6I6ahyq0DGK9lNJXGdxOVRvtfE3KW6ah7YoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBfV/9Nv; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6bce380eb96so819656a12.0
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728595352; x=1729200152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jRX5nGG7OWvd0H6Xc7lVhxNfeCubLD6H5w8yWf0+6c=;
        b=EBfV/9NvsAEO0K9PbrRGB7FVlDTmVeE6goJjQ3bWDlyvcd6KTU84RGDSSf6cn0h140
         vr310ahed3s8rPcBtB5wKwECiqSQWmvDTHmnsZYXRwWJgHYfn3ffyFl0bJceQLUQsv6O
         zYJNzqIfw/R+ko/I/XjeUsojdMm7dcPjhmehJBuiaQ0zsKqlJUupQtZxMFCLP5xDKLns
         CZjIYrdtXWJYsulF90lOIRd/sgZIGJqArCwirDzrg3826mOPLVJgWrBbaip0FrAFDRrv
         qi8k56D/kloLTOvfoFSKTbR+bIjZ0dVAq9f0ioTPY1Lc5aQ2lFmswGeAQaECgC25QKSV
         jcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728595352; x=1729200152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jRX5nGG7OWvd0H6Xc7lVhxNfeCubLD6H5w8yWf0+6c=;
        b=lcWybGX/Ars4or31tAlVcBiFyM5f8Jlk7hwPpI96WGOsiOd1001DVla73het5LsCK1
         kANw8AkW+nGqnj8zc3SR2WksrGyIWKC9QrcucMKQzIUy0+h/lTPwzyp/VOA42QecwLnC
         SoDWc/sGUZJ41roy4L3fxbm/hI9SImgnn/1OTIpGTPTDBedEKmPW9G5MDCt9zJWR+lH3
         iPsnSW3ud3pnYWgTefvVKWXhhpIg32UUx2IVGhuAbFpcUZytA9JHwagaGTCFYk/mviWw
         5F6HdBp1lnCh8/q7zOn+G2zywBCy1q/ESZBKemy8eoxqpYEab7lA+/bevP89h9SYOr6O
         Io8A==
X-Gm-Message-State: AOJu0YzlMSqED7hdTEEMbX1CjjFtEc1YY8ZrZyoX0WfDGkngubmPNiCW
	+gGmqBdd4ad9j4Er9S+KWQ76wLFJpHHXDVq3sHYqkOs8QvYlW8ATEmxpytBsq9QO8YK7YF3p82M
	wqog1iV9s79F7ZTCAvtua0mo18LM=
X-Google-Smtp-Source: AGHT+IEF+STeaq/kcsJNxa5d4W4Uqkv9RRBTNZMum3Zl+fpgfiPv5Y79DcgSNhMwneDZJSeckrV9pMJZO7tYMtVLikk=
X-Received: by 2002:a17:90b:3594:b0:2e2:d112:3b5c with SMTP id
 98e67ed59e1d1-2e2f0dc7e9cmr710525a91.37.1728595351741; Thu, 10 Oct 2024
 14:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010211731.4121837-1-andrii@kernel.org> <20241010211731.4121837-2-andrii@kernel.org>
In-Reply-To: <20241010211731.4121837-2-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 14:22:19 -0700
Message-ID: <CAEf4BzZ95-BQcbfscj+f=4WSesi6+O=kdwFSbbCAofrthg-=_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add subprog to BPF object
 file with no entry programs
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 2:17=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Add a subprogram to BPF object file that otherwise has no entry BPF
> programs to validate that libbpf can still load this correctly.
>
> Until this was fixed, user could expect this very confusing error message=
:
>
>   libbpf: prog 'dangling_subprog': missing BPF prog type, check ELF secti=
on name '.text'
>   libbpf: prog 'dangling_subprog': failed to load: -22
>   libbpf: failed to load object 'struct_ops_detach'
>   libbpf: failed to load BPF skeleton 'struct_ops_detach': -22
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/progs/struct_ops_detach.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_detach.c b/tool=
s/testing/selftests/bpf/progs/struct_ops_detach.c
> index 56b787a89876..5222d58592a7 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_detach.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_detach.c
> @@ -6,5 +6,11 @@
>
>  char _license[] SEC("license") =3D "GPL";
>

argh, I had this comment here, which I missed to amend into this
patch, maybe whoever applies can just add it so I don't spam the
mailing list:

/* This subprogram validates that libbpf handles the situation in which BPF
 * object has subprograms in .text section, but has no entry BPF programs.
 * At some point that was causing issues due to legacy logic of treating su=
ch
 * subprogram as entry program (with unknown program type, which would fail=
).
 */
> +int dangling_subprog(void)
> +{
> +       /* do nothing, just be here */
> +       return 0;
> +}
> +
>  SEC(".struct_ops.link")
>  struct bpf_testmod_ops testmod_do_detach;
> --
> 2.43.5
>

