Return-Path: <bpf+bounces-65484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CAEB23E26
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 04:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51526862EF
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 02:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A151DFE09;
	Wed, 13 Aug 2025 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HUCJ41R9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFC11B6CE9
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755051635; cv=none; b=R619Huw6hS6a3kj249/l489O3HQjFq67+9J/8zMdrneSX6Y62OGLX7H8zkwLsHEkWH20DbmF0WZrVa/3DuPw00g0oUg97985lSTGSj/oX6W0J6+iAjImpTMMjbCrmipp9TkSIBK2gDm9D1bxEfpoUuTtzvZGFBf6SGl/Q4ckjMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755051635; c=relaxed/simple;
	bh=NJ+Pu4qunYCS2H0KAMAkWGhXEIHviWAMqbAGS9tACPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJqGotL0VXgtAjoYZT96Q8w/p2JbKBxyY1uTFwjqjPPsKyFGPbnnYjPCFwh3Wj5SC1OpwloesdHy/tVvm2oSspQAyPK0s/4OlFXHxesDwsJHy4Kt/+AYt2mG/c8C1Dvr5JDK36ROtsgcs+vam3BVHOeYgtK/FcwAA/ZtTuM5AkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HUCJ41R9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bc55f6612so511612b3a.0
        for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 19:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755051633; x=1755656433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq8Ay+9EPnIfeYY6CIxQsvSVzCQv2jRc0S2l1wh01Io=;
        b=HUCJ41R9GSkdXssW98qf7Z+2gPaDndZOdQmsV6W/VA6if1BG3o0yMwYIZbmCysUOTI
         d/FUxsmI9skD+EMkCOTENVvLcB1/fdBw0E9Ibbs4JKhlolkjpbCoj7JplefxEhUGgiOE
         r82eQebKUT1QvMwW4nBm8JbnnTNtBYuKXdUYf8m8XeQKbwpdw78lUwhvaUMLjr/qxixg
         EyHOlb93CHjy4UNz1OI+jT3Bm8jZtgA3aKp62pZ+M8QJtHjydlY2CSbx/JgbMcLj2ZVs
         Ao2lH5dSdjc0Qj6VYUBdE7uPKw1CDSyvSn5aUi9D2lJ0CoGv1a7xe/oLaLMY5HlCk38c
         OJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755051633; x=1755656433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nq8Ay+9EPnIfeYY6CIxQsvSVzCQv2jRc0S2l1wh01Io=;
        b=Y3W0tB+aH1YEal4p7XED9sUFyKh+DhXgRo7NsLJqmDQ8LMwgbIIu/fpkRw/tXBQMbZ
         2M/A0V7AJixxdOqCFhIjQVhRYW2XFGlw5nh72JVzdl4VM+95tJa2Wjl0yE8PAphXM4cd
         Qgl5j95fz1aWr2MAuVz29ijosiS1ZLCod8c52w0Ox9s/IuPCuLeAAstVGKh2+nzMzXSs
         A4faLfg1FuhRZtHTHGDRe+Qag7+1xXAgt4axHRWM1Y9xPNbjMs9VgPFB+jMlOe5aIuj+
         yVMpSdNwrYpt3IPBJp6wP4Y2h6u7jljFd3YLz5c2Qr7q95Difb7huBU4hiE/mVNItwPE
         E0+g==
X-Gm-Message-State: AOJu0YyfyVCpv5l4uN9RDftHwTg5CJRwKd/ObzX1FUJg9XNFdtNk3cN5
	NVpPr52r6uyg8F+gmMhdHk5IYXe++xyUYVscjoTvPuVTS8+T8YNdJZ8kLQEkUFX7Q1Uy2i+cFYJ
	BPalPkhGyqvQoJYqL1k/Vb9VgRp88MMKl6isGqEMf
X-Gm-Gg: ASbGncvRd9apgFMTKPXnqIsLUpuQ/wPQhelBQkJcu/ZDHLW/FVKrL4ktBZnUvfSSjiI
	0uQoPLPADUhhkMwKwwMG53T4oCYVyFW7J91UgMPha6NraZOjmOKT3Ch4lvJRwp+aBppd2cr88JJ
	O5nx91tR84fYfWoG9lag7In3vkzGUZrmoiNcjHqen2rUn/YipPWfk1H5VKawJYeyIoDYeSKGxUH
	g08/H8=
X-Google-Smtp-Source: AGHT+IFgW/L6HVHu5YjwzYNMM46yXE7YoE0MlGKzYGNFCHPyQeRoJCOkb1wgNuwCVFcfQn6S+RkIX4kM3jMCmSAJZZA=
X-Received: by 2002:a05:6a20:3d1c:b0:238:351a:f960 with SMTP id
 adf61e73a8af0-240ab4304c3mr1359387637.23.1755051632762; Tue, 12 Aug 2025
 19:20:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721211958.1881379-1-kpsingh@kernel.org> <20250721211958.1881379-9-kpsingh@kernel.org>
 <87sei58vy3.fsf@microsoft.com>
In-Reply-To: <87sei58vy3.fsf@microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Aug 2025 22:20:21 -0400
X-Gm-Features: Ac12FXysUcbMuD1nf3ihlEeZxea1ewYPaC5jN8QaJuuVMTwdgLLQNDZ7i3SnxDE
Message-ID: <CAHC9VhTrKnKhh_7oxMfY6QYrhzpL6UQ-ZkpcOYzyb7c4JJCJXA@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] bpf: Implement signature verification for BPF programs
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, KP Singh <kpsingh@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kys@microsoft.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	James.Bottomley@hansenpartnership.com, wufan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 2:28=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
> KP Singh <kpsingh@kernel.org> writes:
> > This patch extends the BPF_PROG_LOAD command by adding three new fields
> > to `union bpf_attr` in the user-space API:
> >
> >   - signature: A pointer to the signature blob.
> >   - signature_size: The size of the signature blob.
> >   - keyring_id: The serial number of a loaded kernel keyring (e.g.,
> >     the user or session keyring) containing the trusted public keys.
> >
> > When a BPF program is loaded with a signature, the kernel:
> >
> > 1.  Retrieves the trusted keyring using the provided `keyring_id`.
> > 2.  Verifies the supplied signature against the BPF program's
> >     instruction buffer.
> > 3.  If the signature is valid and was generated by a key in the trusted
> >     keyring, the program load proceeds.
> > 4.  If no signature is provided, the load proceeds as before, allowing
> >     for backward compatibility. LSMs can chose to restrict unsigned
> >     programs and implement a security policy.
> > 5.  If signature verification fails for any reason,
> >     the program is not loaded.
> [...]
>
> The following is what we propose to build on top of this to implement
> in-kernel hash chain verification. This allows for signature
> verification of arbitrary maps and isn't coupled to light-skeletons or
> any specific implementation.
>
>
> From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> Date: Mon, 28 Jul 2025 08:14:57 -0700
> Subject: bpf: Add hash chain signature support for arbitrary maps
>
> This patch introduces hash chain support for signature verification of
> arbitrary bpf map objects which was described here:
> https://lore.kernel.org/linux-security-module/20250721211958.1881379-1-kp=
singh@kernel.org/
>
> The UAPI is extended to allow for in-kernel checking of maps passed in
> via the fd_array. A hash chain is constructed from the maps, in order
> specified by the signature_maps field. The hash chain is terminated
> with the hash of the program itself.
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  include/uapi/linux/bpf.h       |  6 +++
>  kernel/bpf/syscall.c           | 75 ++++++++++++++++++++++++++++++++--
>  tools/include/uapi/linux/bpf.h |  6 +++
>  3 files changed, 83 insertions(+), 4 deletions(-)

Some minor comments below, but in general I think this approach is
good in that it preserves the signature scheme in KP's patchset while
also supporting a scheme that is not reliant on the lskel or
verification, with the user loading the program/lskel choosing which
signature scheme to use.  Unless something has changed since we've
discussed this last, I believe this should provide the basic BPF
infrastructure needed to satisfy all the different requirements
already described.

Thoughts on this KP (as well as any others who have been following along)?

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 10fd3ea5d91fd..f7e9bcabd9dcc 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2780,15 +2780,36 @@ static bool is_perfmon_prog_type(enum bpf_prog_ty=
pe prog_type)
>         }
>  }
>
> +static inline int bpf_map_get_hash(int map_fd, void *buffer)
> +{
> +       struct bpf_map *map;
> +
> +       CLASS(fd, f)(map_fd);
> +       map =3D __bpf_map_get(f);
> +       if (IS_ERR(map))
> +               return PTR_ERR(map);
> +
> +       if (!map->ops->map_get_hash)
> +               return -EINVAL;
> +
> +       return map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, buffer);
> +}

It would be nice to see some agility on the hash algorithm, but it's
probably not critical for a first effort.  I can easily see an
algorithm field being added to bpf_attr, using the same digest
algorithm as specified in the PKCS7 signature, or something else
sufficiently clever.

>  static noinline int bpf_prog_verify_signature(struct bpf_prog *prog,
>                                               union bpf_attr *attr,
>                                               bool is_kernel)
>  {
>         bpfptr_t usig =3D make_bpfptr(attr->signature, is_kernel);
> -       struct bpf_dynptr_kern sig_ptr, insns_ptr;
> +       bpfptr_t umaps;
> +       struct bpf_dynptr_kern sig_ptr, insns_ptr, hash_ptr;
>         struct bpf_key *key =3D NULL;
>         void *sig;
> +       int *maps;
> +       int map_fd;
>         int err =3D 0;
> +       u64 buffer[8];
> +       u64 hash[4];

It would be good to replace the magic numbers above with something
that is a bit more self documenting, e.g. 'u64 hash[SHA256_DIGEST_SIZE
/ sizeof(u64)]'.  The same goes for some of the pointer offset math
below, assuming the result isn't too ugly.  If the resulting code is
pretty awful to look at, a quick comment or two might be a good idea.

> +       int n;
>
>         if (system_keyring_id_check(attr->keyring_id) =3D=3D 0)
>                 key =3D bpf_lookup_system_key(attr->keyring_id);
> @@ -2808,16 +2829,62 @@ static noinline int bpf_prog_verify_signature(str=
uct bpf_prog *prog,
>         bpf_dynptr_init(&insns_ptr, prog->insnsi, BPF_DYNPTR_TYPE_LOCAL, =
0,
>                         prog->len * sizeof(struct bpf_insn));
>
> -       err =3D bpf_verify_pkcs7_signature((struct bpf_dynptr *)&insns_pt=
r,
> -                                        (struct bpf_dynptr *)&sig_ptr, k=
ey);
> +       if (!attr->signature_maps_size) {
> +               err =3D bpf_verify_pkcs7_signature((struct bpf_dynptr *)&=
insns_ptr,
> +                                                (struct bpf_dynptr *)&si=
g_ptr, key);
> +       } else {
> +               bpf_dynptr_init(&hash_ptr, hash, BPF_DYNPTR_TYPE_LOCAL, 0=
,
> +                               sizeof(hash));
> +               umaps =3D make_bpfptr(attr->signature_maps, is_kernel);
> +               maps =3D kvmemdup_bpfptr(umaps, attr->signature_maps_size=
 * sizeof(*maps));
> +               if (!maps) {
> +                       err =3D -ENOMEM;
> +                       goto out;
> +               }
> +               n =3D attr->signature_maps_size - 1;
> +               err =3D copy_from_bpfptr_offset(&map_fd, make_bpfptr(attr=
->fd_array, is_kernel),
> +                                             maps[n] * sizeof(map_fd),
> +                                             sizeof(map_fd));
> +               if (err < 0)
> +                       goto free_maps;
> +
> +               err =3D bpf_map_get_hash(map_fd, hash);
> +               if (err !=3D 0)
> +                       goto free_maps;
> +
> +               n--;
> +               while (n >=3D 0) {
> +                       memcpy(buffer, hash, sizeof(hash));
> +                       err =3D copy_from_bpfptr_offset(&map_fd,
> +                                                     make_bpfptr(attr->f=
d_array, is_kernel),
> +                                                     maps[n] * sizeof(ma=
p_fd),
> +                                                     sizeof(map_fd));
> +                       if (err < 0)
> +                               goto free_maps;
> +
> +                       err =3D bpf_map_get_hash(map_fd, buffer+4);
> +                       if (err !=3D 0)
> +                               goto free_maps;
> +                       sha256((u8 *)buffer, sizeof(buffer), (u8 *)&hash)=
;
> +                       n--;
> +               }
> +               sha256((u8 *)prog->insnsi, prog->len * sizeof(struct bpf_=
insn), (u8 *)&buffer);
> +               memcpy(buffer+4, hash, sizeof(hash));
> +               sha256((u8 *)buffer, sizeof(buffer), (u8 *)&hash);
> +               err =3D bpf_verify_pkcs7_signature((struct bpf_dynptr *)&=
hash_ptr,
> +                                                (struct bpf_dynptr *)&si=
g_ptr, key);
>
> +free_maps:
> +               kvfree(maps);
> +       }
> +out:
>         bpf_key_put(key);
>         kvfree(sig);
>         return err;
>  }
>
>  /* last field in 'union bpf_attr' used by this command */
> -#define BPF_PROG_LOAD_LAST_FIELD keyring_id
> +#define BPF_PROG_LOAD_LAST_FIELD signature_maps_size
>
>  static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr=
_size)
>  {

--=20
paul-moore.com

