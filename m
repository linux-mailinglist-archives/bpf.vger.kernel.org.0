Return-Path: <bpf+bounces-60116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3308EAD2A99
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 01:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E212816F76B
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 23:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E121422D9F6;
	Mon,  9 Jun 2025 23:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdFyVinY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4FE21D3DF
	for <bpf@vger.kernel.org>; Mon,  9 Jun 2025 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749512158; cv=none; b=tg8KK0UTgVtdiq1qWYkt21SA0G3L7rEGeafoW3Q3CSavQIJQ8CprQ3Ija2PvnUC7vprqTykhcVmitWK1go95XDFYZGWkzlxciDzK9vm1PW9juhFI3NhZYh1jFM/QSt13mJEEgdFqVYAUUtljw+S2IWJtKvXlYnbtbvSQnLri8Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749512158; c=relaxed/simple;
	bh=feYEfXfPJ8J1G99kgE6ImZdTIDXtc9WeqA7mZ8PoNRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6AorBy9OjaaN63b0WCbo9fcfxcWKZFl5ISufMkfuQT1frRy8x2HwwY1Ympf9iR/lauKYC4FJEa87mwXLM7AxAVbgQdxipKViJqDyjXO6jC+0uXz1/gQMJu7KBwkc+JxBUEGisiB1YLAzEJGK9vFDRPbqZcJbWi/7ehFm23BMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdFyVinY; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af6a315b491so4045408a12.1
        for <bpf@vger.kernel.org>; Mon, 09 Jun 2025 16:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749512156; x=1750116956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87UYU9j8aLag4q8mH1ZwbQ/6bDnr0WJB51TlTTB6uiY=;
        b=VdFyVinYgS06mGSSLI365cS7KX/NudlS5ZqvWrtE2h3LOiLGFKD0FIowiz2YB/xQZx
         c3iTcZYuSR9X5xc6kWlVIt7k94tHTreo0FjclHPi4Mi/8xbn1Eh00t0qYFOSRIVKAwO3
         yezEqGdczN9fDLC/p8NiZ/brgsOnnbHlEwjTJ07oz506e9kM0XH6g5K3cBGcAM1Q/RKS
         XeJ2afo3lMMfDxCxxQYJipGzHpenNkNekji2Zk7Fu8fAYNBt319ZFIuWQUwXnpa0L5Ue
         m6ocuYZy0MkuQRe3bY3qlQ/1AqDZv7iC1soHvw2LqWi5IhOjfFf4KB4AXqQDXudGi+ve
         wwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749512156; x=1750116956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87UYU9j8aLag4q8mH1ZwbQ/6bDnr0WJB51TlTTB6uiY=;
        b=kJNjWKoOocZcZb/hJfF+5LsBXQbRkByhSMqm0SjPeR2A9Na9S+eWc2bz9GKiiaGC6M
         ICIHi20YGAhkYtS3cxSlx9kCTLIfm9gRWwCOEhtylxcoDNK3nYbvaagXxzgDW80Fm4jb
         90tmWdcri663jP4LlMCfUCpVWW+7BhlKJIFEUZ3VClCWNOsYo8D7lrXkYjq7IszNaRSm
         g94mSwCh9aiTxjqgDbf2Ru+1hXQCugbUTwS7oZFHr6cdicT+QVQqsfZSEPStNpC6WXlo
         AW5oQq5XHK32l5L/aFnB5cYplpMsY9eGJWV6lLk9hhj6X2Um7MC7J4LCTeVGae+8Ndoa
         xwLw==
X-Gm-Message-State: AOJu0YzOgMrPtocSbIxVZCVPyKJnMMsb8cIm1B1MREkWvplMw5RxM1co
	7vxlfvIaWvnadlaDgy7o9KLl3oalKK1n16YxFHgN6gcxd3FmNyiCRfju+4s/KHXjBr1sxDbsguC
	Dp09uL0cxGKlcR4yS/j+g2pA0cfBsIlGWO6aDaS0=
X-Gm-Gg: ASbGncsYPGHUL8l63o6uRR01vO+oBhM5uCcN28hjv9w4fQHk+w3VEXYuf4rwr5FLXD7
	7Amm8RwmhYFNS++rcNeB2pBHs8lC4sS5u/PzEQ1Ew3M2PVuYc4A6Oip1zlWQhsYuhMSUsf7KZXM
	fBEzlMYPa6HbaeJekrVlBS3vduokzwd5XUwZeN3iqE72jbxizVtTXlPzEz4EUQOZJxwBWE+w==
X-Google-Smtp-Source: AGHT+IGfW+feLXo+qwzhpN2lzj2lwGskiciRI1DTCf8PgbVE5d40YAcV6OeiiREOqaJo9JmeqLfuvZXq1FWGtfguhPc=
X-Received: by 2002:a17:90b:3911:b0:311:ab20:159a with SMTP id
 98e67ed59e1d1-31347698038mr19172543a91.29.1749512156030; Mon, 09 Jun 2025
 16:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606163131.2428225-1-yonghong.song@linux.dev> <20250606163141.2428937-1-yonghong.song@linux.dev>
In-Reply-To: <20250606163141.2428937-1-yonghong.song@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Jun 2025 16:35:43 -0700
X-Gm-Features: AX0GCFtZIH1cQnjg8E87WPoKDFKixQHCUQcoJCbrzeEkXX9ffDHYnC5-8JSUncw
Message-ID: <CAEf4BzZjbJBpHE0eguipWgh8KWHG4Jh1jOORjMwsr7pVZ=qa6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/5] bpf: Implement mprog API on top of
 existing cgroup progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 9:31=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Current cgroup prog ordering is appending at attachment time. This is not
> ideal. In some cases, users want specific ordering at a particular cgroup
> level. To address this, the existing mprog API seems an ideal solution wi=
th
> supporting BPF_F_BEFORE and BPF_F_AFTER flags.
>
> But there are a few obstacles to directly use kernel mprog interface.
> Currently cgroup bpf progs already support prog attach/detach/replace
> and link-based attach/detach/replace. For example, in struct
> bpf_prog_array_item, the cgroup_storage field needs to be together
> with bpf prog. But the mprog API struct bpf_mprog_fp only has bpf_prog
> as the member, which makes it difficult to use kernel mprog interface.
>
> In another case, the current cgroup prog detach tries to use the
> same flag as in attach. This is different from mprog kernel interface
> which uses flags passed from user space.
>
> So to avoid modifying existing behavior, I made the following changes to
> support mprog API for cgroup progs:
>  - The support is for prog list at cgroup level. Cross-level prog list
>    (a.k.a. effective prog list) is not supported.
>  - Previously, BPF_F_PREORDER is supported only for prog attach, now
>    BPF_F_PREORDER is also supported by link-based attach.
>  - For attach, BPF_F_BEFORE/BPF_F_AFTER/BPF_F_ID/BPF_F_LINK is supported
>    similar to kernel mprog but with different implementation.
>  - For detach and replace, use the existing implementation.
>  - For attach, detach and replace, the revision for a particular prog
>    list, associated with a particular attach type, will be updated
>    by increasing count by 1.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/uapi/linux/bpf.h       |   7 ++
>  kernel/bpf/cgroup.c            | 188 +++++++++++++++++++++++++++++----
>  kernel/bpf/syscall.c           |  44 +++++---
>  tools/include/uapi/linux/bpf.h |   7 ++
>  4 files changed, 209 insertions(+), 37 deletions(-)
>

[...]

> +static struct bpf_link *bpf_get_anchor_link(u32 flags, u32 id_or_fd)
> +{
> +       struct bpf_link *link =3D ERR_PTR(-EINVAL);
> +
> +       if (flags & BPF_F_ID)
> +               link =3D bpf_link_by_id(id_or_fd);
> +       else if (id_or_fd)
> +               link =3D bpf_link_get_from_fd(id_or_fd);
> +       if (IS_ERR(link))
> +               return ERR_PTR(PTR_ERR(link));

this can be just `return link;` (same below for prog)

simplified while applying

> +
> +       return link;
> +}
> +

[...]

> +       if (is_link) {
> +               anchor_link =3D bpf_get_anchor_link(flags, id_or_fd);
> +               if (IS_ERR(anchor_link))
> +                       return ERR_PTR(PTR_ERR(anchor_link));
> +       } else if (is_id || id_or_fd) {

this can be just `else {` with no conditions, no? Basically, if
BPF_F_LINK -- fetch link, otherwise assume program. Or am I missing
something? I didn't touch this part, but maybe we can simplify this a
bit in the follow up?

> +               anchor_prog =3D bpf_get_anchor_prog(flags, id_or_fd);
> +               if (IS_ERR(anchor_prog))
> +                       return ERR_PTR(PTR_ERR(anchor_prog));
> +       }
> +

[...]

> @@ -4244,20 +4266,6 @@ static int bpf_prog_attach(const union bpf_attr *a=
ttr)
>         case BPF_PROG_TYPE_FLOW_DISSECTOR:
>                 ret =3D netns_bpf_prog_attach(attr, prog);
>                 break;
> -       case BPF_PROG_TYPE_CGROUP_DEVICE:
> -       case BPF_PROG_TYPE_CGROUP_SKB:
> -       case BPF_PROG_TYPE_CGROUP_SOCK:
> -       case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
> -       case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> -       case BPF_PROG_TYPE_CGROUP_SYSCTL:
> -       case BPF_PROG_TYPE_SOCK_OPS:
> -       case BPF_PROG_TYPE_LSM:
> -               if (ptype =3D=3D BPF_PROG_TYPE_LSM &&
> -                   prog->expected_attach_type !=3D BPF_LSM_CGROUP)
> -                       ret =3D -EINVAL;
> -               else
> -                       ret =3D cgroup_bpf_prog_attach(attr, ptype, prog)=
;
> -               break;
>         case BPF_PROG_TYPE_SCHED_CLS:
>                 if (attr->attach_type =3D=3D BPF_TCX_INGRESS ||
>                     attr->attach_type =3D=3D BPF_TCX_EGRESS)
> @@ -4266,7 +4274,10 @@ static int bpf_prog_attach(const union bpf_attr *a=
ttr)
>                         ret =3D netkit_prog_attach(attr, prog);
>                 break;
>         default:
> -               ret =3D -EINVAL;
> +               if (!is_cgroup_prog_type(ptype, prog->expected_attach_typ=
e, true))
> +                       ret =3D -EINVAL;
> +               else
> +                       ret =3D cgroup_bpf_prog_attach(attr, ptype, prog)=
;

I tried to get used to this is_cgroup_prog_type() check inside
switch's default, but it feels too surprising and ugly. I moved it to
before the switch to be more explicit. I hope you don't mind.

I ended up with this diff on top of your patches:

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index c3ac5661da27..ffbafbef5010 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -666,9 +666,6 @@ static struct bpf_link *bpf_get_anchor_link(u32
flags, u32 id_or_fd)
                link =3D bpf_link_by_id(id_or_fd);
        else if (id_or_fd)
                link =3D bpf_link_get_from_fd(id_or_fd);
-       if (IS_ERR(link))
-               return ERR_PTR(PTR_ERR(link));
-
        return link;
 }

@@ -680,9 +677,6 @@ static struct bpf_prog *bpf_get_anchor_prog(u32
flags, u32 id_or_fd)
                prog =3D bpf_prog_by_id(id_or_fd);
        else if (id_or_fd)
                prog =3D bpf_prog_get(id_or_fd);
-       if (IS_ERR(prog))
-               return prog;
-
        return prog;
 }

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2035093eeeb3..97ad57ffc404 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4255,6 +4255,11 @@ static int bpf_prog_attach(const union bpf_attr *att=
r)
                return -EINVAL;
        }

+       if (is_cgroup_prog_type(ptype, prog->expected_attach_type, true)) {
+               ret =3D cgroup_bpf_prog_attach(attr, ptype, prog);
+               goto out;
+       }
+
        switch (ptype) {
        case BPF_PROG_TYPE_SK_SKB:
        case BPF_PROG_TYPE_SK_MSG:
@@ -4274,12 +4279,9 @@ static int bpf_prog_attach(const union bpf_attr *att=
r)
                        ret =3D netkit_prog_attach(attr, prog);
                break;
        default:
-               if (!is_cgroup_prog_type(ptype,
prog->expected_attach_type, true))
-                       ret =3D -EINVAL;
-               else
-                       ret =3D cgroup_bpf_prog_attach(attr, ptype, prog);
+               ret =3D -EINVAL;
        }
-
+out:
        if (ret)
                bpf_prog_put(prog);
        return ret;

