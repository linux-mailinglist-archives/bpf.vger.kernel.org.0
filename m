Return-Path: <bpf+bounces-58595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B489ABE310
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 20:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D663A9D31
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 18:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3501A3179;
	Tue, 20 May 2025 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMX10bhJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743DD1DE2DF
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766810; cv=none; b=t7YF6jXhHf6xfj2XvKdKdGF9k32QrCQm2eH4rI2YKRA/AhBd39BhObJRbP+yuvhcHLqVP+9ZWDxd92rFAQQO50+XTmJ3XxrSDxtlqmvp+9hmP131OTBjJ1whr4qhzZrGLHNWbS6K44XaEFVN3pcHMB3MK/APdVQqayeu0PyqOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766810; c=relaxed/simple;
	bh=DDYUTBBpdvWmTxw61eIit/vFX08enZ2UpG9p88gXgjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjkpTJcpoNklmeCE0MU7RWX/cFzlUacKruAz4RFuJaGig0YNWnAtH8vPkOdDKtjmjEoT+joMWqHf162y04fJLsTtrGy6nG7a6Z8trSvsdpTT04/6ALQN7sr+OopfmWN252YZO4GUUidKqGmT8ONLb+WP+k/7BYI1gpu9a4kz7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMX10bhJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a36abf5df9so2036217f8f.0
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 11:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747766807; x=1748371607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OIixj2IxL35cBYoSy38TJjjAsTGxSnWnBYB4PufPe4=;
        b=YMX10bhJ69pbUESIWZoiDozD8Dmn2kewbUGiPZ/sTFm4bh0INfvoOFeqQxwKxLQsMc
         k4LkIUGXjX3LbKCuv1rh9SyU4ulbd6gTkX6hbNZE+KJ6VCaFIeNXBhFEm55+pdb+D+f7
         FHNy/P2WEXeqBxJcCNp28y8tKyg1Dcy/ievAcxHKFyaQhm/aFl/uzzDwPb9iZIIAxTJp
         PuFnrUA4M1aHR/YJLAykqVOO9teYvJwzYrukKSiCN+GDIDdwRri7mwHZb0B2Myid7oQx
         ZbJMm54r9s9PfpvURCcjmbpb9x67OmaKpsTE1Ky73o4L6XgEFyqQSmM9hK8/NO/4qBku
         kXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747766807; x=1748371607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OIixj2IxL35cBYoSy38TJjjAsTGxSnWnBYB4PufPe4=;
        b=POHgWXA7wOUXYwivnzw43StUBQDMqPgBj1Dy8QZEiz6U+pkzXhy3WxTARlvAi1NLL0
         bvzUMbauzoZ6xwURN7dhfbX2H7t6jOUoHkWYDYhl2GXwOiickDheNoJniie6NEzHBk+H
         dck3I+91ypou4MTl4KEO44HXWityWuEYrcXoNh9NMiVVRDYGjXvjjkazGFsHdJG887+3
         lTKd6nsYp555PQI2uh2zsMOB6shEXOMYvs8c8+TGRbrHLdhZyKgRTBZweXl6elelYMTq
         ysNBU50S3GkxOcXyzNMNKmAunYtp4vhFJhStUOrYXHM8jdfE8x2aKsNenJDOBFzC9G0b
         T7MA==
X-Forwarded-Encrypted: i=1; AJvYcCUW+pnUZoOInJYBmPUsBoD02OOOdOf9jqNl8RE2/nJn97UbMPqTnMI7YC/vKEFj5jvbGyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm0L4hfdixeji4Je3jVQY5MfIVzSlh4Cl3iMpG6xJJ4g5wIr84
	rOFs1Pl2dblicyFVEWIrlE56nf+yl0sx5KcijNv5bDM8xg5qcMSbmKt25Jb09832PAKqXpTqCqG
	p+2j8PiU+Di4KSv1NIu2jZV1vWw43VBU=
X-Gm-Gg: ASbGnctGc9qLplffsgVADNhsI4b8qPQAd1CgU/0yZsOwBM4BEV9LMPMmB0srnQ8Y4B/
	VsdAP9N/uwG3/5SbszC2GxyDMyqDuHw7EHHM1FCf7o6eYfaBQaFV+snl8CuN6bsBx1hKGtWi/YS
	owAv4jFKJWmBF6zvtsrAPy6Hvn8oUvq9US8gR7I4+SZ8we2J17
X-Google-Smtp-Source: AGHT+IGyPmzBH41WQxqxOW7oFuWxks88TrjvSAvYrhw2BSRQk8yek8e+5PKcRPGtxPfFvfCfK3+QWWwBLGeL2S6uL/4=
X-Received: by 2002:adf:f1c2:0:b0:3a3:621a:d3c8 with SMTP id
 ffacd0b85a97d-3a3621ad491mr11776479f8f.19.1747766806568; Tue, 20 May 2025
 11:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519203339.2060080-1-yonghong.song@linux.dev>
 <20250519203344.2060544-1-yonghong.song@linux.dev> <CAADnVQKR=i3qqxHcs3d2zcCEejz71z8GE2y=tghDPF2rFZUObg@mail.gmail.com>
 <85503b11-ccce-412e-b031-cc9654d6291d@linux.dev> <CAADnVQLvN-TshyvkY3u9MYc7h_og=LWz7Ldf2k_33VRDqKsUZw@mail.gmail.com>
 <1330496e-5dda-4b42-9524-4bfcfeb50ba7@linux.dev> <CAADnVQKipc=mML1ZjcMjKgKrP_L+wUPhAo0feFf6=DVqdWpCPQ@mail.gmail.com>
In-Reply-To: <CAADnVQKipc=mML1ZjcMjKgKrP_L+wUPhAo0feFf6=DVqdWpCPQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 May 2025 11:46:35 -0700
X-Gm-Features: AX0GCFsS6Mdnw59XtCrNRSEfmJ9l-epbQxkHQRGbYAc3gt78A5xGtNewrPt7MAs
Message-ID: <CAADnVQL7mrgvPbDCnsFAG5vhzmkEfxP9Z9nxRHR15gdtBHDsBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Warn with bpf_unreachable() kfunc
 maybe due to uninitialized variable
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 11:39=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> So another idea...
>
> maybe we should remove special_kfunc_set instead?
>
> I recall we argued with Kumar years ago about it.
> I don't remember why we kept it
> and what purpose it serves now.
>
> What will break if we do:
>
> -               if (meta.btf =3D=3D btf_vmlinux &&
> btf_id_set_contains(&special_kfunc_set, meta.func_id)) {
> +               if (meta.btf =3D=3D btf_vmlinux) {
>                         if (meta.func_id =3D=3D
> special_kfunc_list[KF_bpf_obj_new_impl] ||
>                             meta.func_id =3D=3D
> special_kfunc_list[KF_bpf_percpu_obj_new_impl]) {
>                                 struct btf_struct_meta *struct_meta;
> @@ -13838,10 +13838,6 @@ static int check_kfunc_call(struct
> bpf_verifier_env *env, struct bpf_insn *insn,
>                                  * because packet slices are not refcount=
ed (see
>                                  * dynptr_type_refcounted)
>                                  */
> -                       } else {
> -                               verbose(env, "kernel function %s
> unhandled dynamic return type\n",
> -                                       meta.func_name);
> -                               return -EFAULT;
>                         }
>
> ?

Found old Kumar's reply:
https://lore.kernel.org/bpf/20221120204625.ndtr7ygh7zgjxrsz@apollo/

and my old reply:
https://lore.kernel.org/bpf/20221120222922.udsuzkr5hcvjzot5@macbook-pro-5.d=
hcp.thefacebook.com/

I think we need to remove special_kfunc_set,
and then special_kfunc_list[] can stay as-is,
and we can keep adding new kfuncs to it like bpf_unreachable in this case.

