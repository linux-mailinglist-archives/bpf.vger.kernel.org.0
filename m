Return-Path: <bpf+bounces-40619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF07998B02B
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 00:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D32C1F2362F
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 22:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED041188CA6;
	Mon, 30 Sep 2024 22:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC8Pjf0X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A85B1862B3;
	Mon, 30 Sep 2024 22:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736256; cv=none; b=Zqg0a8k14ie5KILwFKPblnzOr3NRBcbBRBD66DCpZM0lxal4xkjL+yZc8pt772F+gT1GEjfoYM57oT69wNc45JrrwlI/HvVoIAprIy/jB9s3KGbrE59Wma6OyjOKd01PwVBw8gu8jhVP64nJ7DjPJuW7wuOB/SQAVZqzdyA9Ct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736256; c=relaxed/simple;
	bh=t9TdBMIlcQ1ubRNYPC4CQTSE8yciYo94XfTYd6N0CoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trLV3ElpdCvpMdqPQv9mclPbKyXziX4IRevdHRYdHq7z41cDPSyfodUwubOE4/9XYSj+5dXZ1UP1zFOkrz+Pn1s5LYznN2K97tXewsiV+NDngqJRIx/7XB3b3KKnmYmHQnZQfpB4xVtL5SrWlAVIMS7SmBgfII4JEWIjBnvfMI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RC8Pjf0X; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e07ad50a03so3644484a91.3;
        Mon, 30 Sep 2024 15:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727736254; x=1728341054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNsYt/xbpRJD7yZDVY7SPlqhCiYMX5F1k7+su4fB/ak=;
        b=RC8Pjf0XFQN6CgVDWHpemRSvmX+xsMQ+vir4TlJhhRhnQhmRoYag0Ytm4ljSOZNEWT
         mmhMhrS2Dxg0JX1ZV+/ygsbuYjI+8X6GwyruHxjqNt5Hgt+6LGCHmeui+qMWiTcWOJWH
         wV9/YOEUhsbQ/wZE4wOyLShkbl+vk6sSj30hjPqwAIkL3DsEe98qPVm1n9Ht12JBO3w1
         lonGLBwU3BhvWsEEkfvFpKS5rAimlnSDAi7q62BEtMnmABPJwIkkXMJSjMrPPLknDAXC
         f6oEgycXuL/qm1FvM0TVih2UIU8O94NWZN2pKPrUdECEs6xoPrpHd5SKt5Fcgc79c4KZ
         Snjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736254; x=1728341054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNsYt/xbpRJD7yZDVY7SPlqhCiYMX5F1k7+su4fB/ak=;
        b=gh3fRHfwTdw89vZaHbpPOljxDtL4i8NOm65YAzKzzwpn9C7bLwh3NoNeqYoLQoFVPq
         h2oQoYJzxgGvfb9+cJNIAs9AbQeJCm7VvXGMvKQOYR8EX0rCysCAyDH2CHgWxfBQeZCS
         gnYr68JUEY5fSfvC4CSPrG3PM7AcCdOahlf/DoJQeHxYd57dbsAOPOS8yGNUf+loVFC0
         BHqeEJXBESFnFVy1Kx6vkdgz3+8WWKwJUSVw3XUQPNzDLNs0HCyJMg/33teOs44hJwkF
         ryNRhdCb7CWNNj8jK7lixQ/3DIthP+D0a5SFSP2+A/2MAGxbXJRYbBuGuzDj5UEBGOH1
         6baA==
X-Forwarded-Encrypted: i=1; AJvYcCUWds3JDrhK/3+TM3EkyC1OD5T1p7MKJTJgXXYSHZljOasv7Z9LZDefACgfwOvQsVhKWsboEZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZtOpyy3VvOznGeRO3p2XJDguUzrmG93LFvL6ukwpBf18GUUiJ
	O1UNTihuNsUO2XXGXTlqk1AvPy0dw5UCJpKicRyC5SsMTrJIWMP5QRPVTC+vDpg1BKGVRLn3iYD
	CHnaRol2scb8VowBQw7PvuDEfljc02yHk
X-Google-Smtp-Source: AGHT+IEubMSDkHY3h4TipLeMq33azlwhkB5iBfqFcN8gVjNO2pU1TliIpc/1r4vZVCGepYS2/3WvX/auiAl32cPOj9w=
X-Received: by 2002:a17:90b:11c7:b0:2d8:77cc:85e with SMTP id
 98e67ed59e1d1-2e0b8ec6907mr16010468a91.37.1727736254397; Mon, 30 Sep 2024
 15:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929-libbpf-dup-extern-funcs-v2-0-0cc81de3f79f@hack3r.moe> <20240929-libbpf-dup-extern-funcs-v2-1-0cc81de3f79f@hack3r.moe>
In-Reply-To: <20240929-libbpf-dup-extern-funcs-v2-1-0cc81de3f79f@hack3r.moe>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Sep 2024 15:44:02 -0700
Message-ID: <CAEf4BzZ1sgg26wjrBi2MNAaTT767Kjv7qxS5RY8SVX6O0uaPsg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: do not resolve size on duplicate FUNCs
To: i@hack3r.moe
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 2:31=E2=80=AFAM Eric Long via B4 Relay
<devnull+i.hack3r.moe@kernel.org> wrote:
>
> From: Eric Long <i@hack3r.moe>
>
> FUNCs do not have sizes, thus currently btf__resolve_size will fail
> with -EINVAL. Add conditions so that we only update size when the BTF
> object is not function or function prototype.
>
> Signed-off-by: Eric Long <i@hack3r.moe>
> ---
>  tools/lib/bpf/linker.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 81dbbdd79a7c65a4b048b85e1dba99cb5f7cb56b..cffb388fa40ef054c2661b836=
3120f8a4d3c3784 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -2452,17 +2452,20 @@ static int linker_append_btf(struct bpf_linker *l=
inker, struct src_obj *obj)
>                                 __s64 sz;
>
>                                 dst_var =3D &dst_sec->sec_vars[glob_sym->=
var_idx];
> -                               /* Because underlying BTF type might have
> -                                * changed, so might its size have change=
d, so
> -                                * re-calculate and update it in sec_var.
> -                                */
> -                               sz =3D btf__resolve_size(linker->btf, glo=
b_sym->underlying_btf_id);
> -                               if (sz < 0) {
> -                                       pr_warn("global '%s': failed to r=
esolve size of underlying type: %d\n",
> -                                               name, (int)sz);
> -                                       return -EINVAL;
> +                               t =3D btf__type_by_id(linker->btf, glob_s=
ym->underlying_btf_id);
> +                               if (btf_kind(t) !=3D BTF_KIND_FUNC && btf=
_kind(t) !=3D BTF_KIND_FUNC_PROTO) {

this is sloppy, it can't be both.

Why can't be it a much simpler and cleaner:

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 81dbbdd79a7c..f83c1c29982c 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2451,6 +2451,10 @@ static int linker_append_btf(struct bpf_linker
*linker, struct src_obj *obj)
                        if (glob_sym && glob_sym->var_idx >=3D 0) {
                                __s64 sz;

+                               /* FUNCs don't have size, nothing to update=
 */
+                               if (btf_is_func(t))
+                                       continue;
+
                                dst_var =3D &dst_sec->sec_vars[glob_sym->va=
r_idx];
                                /* Because underlying BTF type might have
                                 * changed, so might its size have changed,=
 so

?

pw-bot: cr

> +                                       /* Because underlying BTF type mi=
ght have
> +                                        * changed, so might its size hav=
e changed, so
> +                                        * re-calculate and update it in =
sec_var.
> +                                        */
> +                                       sz =3D btf__resolve_size(linker->=
btf, glob_sym->underlying_btf_id);
> +                                       if (sz < 0) {
> +                                               pr_warn("global '%s': fai=
led to resolve size of underlying type: %d\n",
> +                                                       name, (int)sz);
> +                                               return -EINVAL;
> +                                       }
> +                                       dst_var->size =3D sz;
>                                 }
> -                               dst_var->size =3D sz;
>                                 continue;
>                         }
>
>
> --
> 2.46.2
>
>

