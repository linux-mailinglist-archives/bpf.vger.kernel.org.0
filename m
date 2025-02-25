Return-Path: <bpf+bounces-52582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94773A44F90
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 23:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8793B06E6
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 22:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9634F212FAF;
	Tue, 25 Feb 2025 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSfLN1xG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7979E15198B;
	Tue, 25 Feb 2025 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521553; cv=none; b=aIIKI8mICNJlXRJaZwr1xSzTAZfZfNfaseAUZSII8+GSO2cdNhPXDR9bHXufBAV/4Y0FxXIZ8b6URaEQVN+SpkCH9zU3NBPw9KSriLI2OrhPnt1Lgcyjii6raKzubzlSBa9RKPuj9Klcul6FCcYS7SzDSepikUICpVML0j6+u78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521553; c=relaxed/simple;
	bh=jtMwaO560WLi7NX65M/ckoRUUXA/FxAknpJWCBMwbhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKs1vRc+y3vPLhuPRb3hohIYwHf+cF+PX2eMLK3Dn7NvEcKKfclGOGg7BaA5eSlDM7YjU6YHJb9T++ELpyronbNfqkYm3hbpyXKNFHPdh6A1sZaJlkHY7DL9kpDv9XHlnrBrBnLA7bEg4nKZStnrr1uwzm/2BCygCCb6JVkzOj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSfLN1xG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f29a1a93bso4928281f8f.1;
        Tue, 25 Feb 2025 14:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740521550; x=1741126350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXXB4/JXMAoDs/dDMHkFtAYVpOJ69UXZRAkDQh72S8Q=;
        b=LSfLN1xGMXhHOU5AFTN66EM2MoKT5Z5dRS98GRipUbTcHMHklK2rqmCc2x6Ej1tiTN
         U2PlO0wKWgWzhrBYCDXKg0UQVRxr3udbBQWZn04PQa6tybzYkPISs58Qmd+a+HTlztM9
         z6DJRRaimIRtNUH05j6edCsyHxzAag6edO9qO6MrtG3mnZCxuwT/pXyfrKu5gbIOr2Ft
         U4XdJBzzdejaDsf1LGdJgU5Pyf6vb1cDy6rJYp5V0n4jUxWdJOh3db/f3OQFCD3DUT2s
         SzxOfI6KfQPf2x+8U7KjNvSit5pf53Mh3N51giusaVswObkx9Li83cBVkvi6gHFcwSQB
         PPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740521550; x=1741126350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXXB4/JXMAoDs/dDMHkFtAYVpOJ69UXZRAkDQh72S8Q=;
        b=M1p71IJAZnqPndB9di2A//HTuI8XmGvR/YbcxiMCAi71AdSOha+DcQUtNBkH8WvZtk
         wSgbQxsB9MKp1o7l2dVvKCohbsG2kr9DTnxnHPjREDJd4KMfX6Lpl4uQO+XPANQDEiwx
         Z5V+QRSfJHuqMdZ0IxGr0Sa/GdM5hIgccdwqqwht9KFq2suY/jRKZvJ2rJXtz4rvY1Ci
         yBoCXBTM+s8zdocbo/b+jp6Nk3WpvCA8rvIW4ey6e5/HD9cmWywGX/PuBjCiyZ6uLXYd
         eLhlP5qzpnCUqx0qTRqarXuO/KxaEP94c0KsYN83SHPBUcHPGwUwKh2jurWpU6j2ttCw
         nSNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2e47JAfCbG+YrivyELJGRN48B7lAwnLJ6l1Ia0NfAcGr2VzNPM6LyQn1ckmJdxsJQHDU=@vger.kernel.org, AJvYcCV0d1ZIXGTcrsXkD/useTcXbXNDqkXBxoQLsjmEugSEAOwokEa61pxt4+4Iec7zihGa5+WPYmjpio8pXyGX@vger.kernel.org
X-Gm-Message-State: AOJu0YzHaqfXyuR3F6MxH27Lyi2QNXoHllnv0lQl07V85qU0RvjndzES
	xWiZPjRQEqAj2e2EE4pfIqqrElwMKHMg4iSUim2M4etod4bzRzM8Fz/Y6/2Exe5kxdw7iGxo5fi
	vpmI5KrUqM60PijyWfgSMGYF0oXM=
X-Gm-Gg: ASbGncv0+6j3iK3zj/tIxWu53F/kPYGtOwZg1i8/pW/eJnVVdlGjRHDmpljwkw2AvtA
	GX8XKTTNzavfe2uCp8YcBxCnn1UrmSdV4TTAh92BTXSNgepg5CROuTfVifOyzzuriJHX7VPFtHK
	YOToFr4wtXbEGWDEO2gQGUysc=
X-Google-Smtp-Source: AGHT+IH00vgcbsozIfKojmhfU1AUU1j6OChnUu1jJ43Kfc47+DoIIDzZgEVzUlCbOboNzdSViig/neF1ooanGVJD3ow=
X-Received: by 2002:a5d:64c4:0:b0:38f:2a44:8079 with SMTP id
 ffacd0b85a97d-390d4f4d2a1mr628128f8f.32.1740521549493; Tue, 25 Feb 2025
 14:12:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080FFF4113C70F7862AAA5D99FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5080FFF4113C70F7862AAA5D99FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Feb 2025 14:12:16 -0800
X-Gm-Features: AWEUYZnc16-rvZFBgv2kcFhs_t4uU2yOO4lAtsxgxdjkF4UxyLzkE0xJz-7qNXg
Message-ID: <CAADnVQLR0=L7xwh1SpDfcxRUhVE18k_L8g3Kx+Ykidt7f+=UhQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 4/6] bpf: Add bpf runtime hooks for tracking
 runtime acquire/release
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 4:36=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> +void *bpf_runtime_acquire_hook(void *arg1, void *arg2, void *arg3,
> +                              void *arg4, void *arg5, void *arg6 /* kfun=
c addr */)
> +{
> +       struct btf_struct_kfunc *struct_kfunc, dummy_key;
> +       struct btf_struct_kfunc_tab *tab;
> +       struct bpf_run_ctx *bpf_ctx;
> +       struct bpf_ref_node *node;
> +       bpf_kfunc_t kfunc;
> +       struct btf *btf;
> +       void *kfunc_ret;
> +
> +       kfunc =3D (bpf_kfunc_t)arg6;
> +       kfunc_ret =3D kfunc(arg1, arg2, arg3, arg4, arg5);
> +
> +       if (!kfunc_ret)
> +               return kfunc_ret;
> +
> +       bpf_ctx =3D current->bpf_ctx;
> +       btf =3D bpf_get_btf_vmlinux();
> +
> +       tab =3D btf->acquire_kfunc_tab;
> +       if (!tab)
> +               return kfunc_ret;
> +
> +       dummy_key.kfunc_addr =3D (unsigned long)arg6;
> +       struct_kfunc =3D bsearch(&dummy_key, tab->set, tab->cnt,
> +                              sizeof(struct btf_struct_kfunc),
> +                              btf_kfunc_addr_cmp_func);
> +
> +       node =3D list_first_entry(&bpf_ctx->free_ref_list, struct bpf_ref=
_node, lnode);
> +       node->obj_addr =3D (unsigned long)kfunc_ret;
> +       node->struct_btf_id =3D struct_kfunc->struct_btf_id;
> +
> +       list_del(&node->lnode);
> +       hash_add(bpf_ctx->active_ref_list, &node->hnode, node->obj_addr);
> +
> +       pr_info("bpf prog acquire obj addr =3D %lx, btf id =3D %d\n",
> +               node->obj_addr, node->struct_btf_id);
> +       print_bpf_active_refs();
> +
> +       return kfunc_ret;
> +}
> +
> +void bpf_runtime_release_hook(void *arg1, void *arg2, void *arg3,
> +                             void *arg4, void *arg5, void *arg6 /* kfunc=
 addr */)
> +{
> +       struct bpf_run_ctx *bpf_ctx;
> +       struct bpf_ref_node *node;
> +       bpf_kfunc_t kfunc;
> +
> +       kfunc =3D (bpf_kfunc_t)arg6;
> +       kfunc(arg1, arg2, arg3, arg4, arg5);
> +
> +       bpf_ctx =3D current->bpf_ctx;
> +
> +       hash_for_each_possible(bpf_ctx->active_ref_list, node, hnode, (un=
signed long)arg1) {
> +               if (node->obj_addr =3D=3D (unsigned long)arg1) {
> +                       hash_del(&node->hnode);
> +                       list_add(&node->lnode, &bpf_ctx->free_ref_list);
> +
> +                       pr_info("bpf prog release obj addr =3D %lx, btf i=
d =3D %d\n",
> +                               node->obj_addr, node->struct_btf_id);
> +               }
> +       }
> +
> +       print_bpf_active_refs();
> +}

So for every acq/rel the above two function will be called
and you call this:
"
perhaps we can use some low overhead runtime solution first as a
not too bad alternative
"

low overhead ?!

acq/rel kfuncs can be very hot.
To the level that single atomic_inc() is a noticeable overhead.
Doing above is an obvious no-go in any production setup.

> Before the bpf program actually runs, we can allocate the maximum
> possible number of reference nodes to record reference information.

This is an incorrect assumption.
Look at register_btf_id_dtor_kfuncs()
that patch 1 is sort-of trying to reinvent.
Acquired objects can be stashed with single xchg instruction and
people are not happy with performance either.
An acquire kfunc plus inlined bpf_kptr_xchg is too slow in some cases.
A bunch of bpf progs operate under constraints where nanoseconds count.
That's why we rely on static verification where possible.
Everytime we introduce run-time safety checks (like bpf_arena) we
sacrifice some use cases.
So, no, this proposal is not a solution.

