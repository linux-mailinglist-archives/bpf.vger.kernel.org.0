Return-Path: <bpf+bounces-28218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200498B669F
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439951C21C17
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E25194C72;
	Mon, 29 Apr 2024 23:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTxtQX3U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9C56CDD3
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 23:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714434315; cv=none; b=hXNOUgiKsWRPWKRrfVpGi8jpK0PVwyVVyn9Q+Xfamlu/QR/6N//1v2Ry08BlHK2zTzNobu916HG8ehWaKFpD5qCEOX4tNeBFz5Mo9/HAjSd10jOKeAD0C5jXL0NZKA9kbxseRDTPbhlRZ2Icnixj8mYL/iMPltcGxOI5E0pmg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714434315; c=relaxed/simple;
	bh=y/21S8qcl6F+8/ASHtIuRinG8fqiKM/IjgJX06Wc+4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jl0HipY3mC2eGKSIQkKeMxQY8hgL0Pz60nX4AtVDlVEJ7wBCry2+P2gMMDT/nvVa+V6Eyo7LSwNtbWGHwa+XzboLbMvPfJ3HJ6NKJ+/CwMOo+ID4gcBGbNEQTlUCWyVPbBbGvs8+ihCUwgkiL6asu+W4YznIpbE7Qd/fagbLrKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTxtQX3U; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso4273423a12.2
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 16:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714434313; x=1715039113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZFWCR9MFCAxJn1HS16/uVN0iXltUxYNJJKxAsC3MqM=;
        b=WTxtQX3UoITaFw89uHtTBTtPkPnXXy9TW+cajawHszwMB5K0dinUeOrNNco1rBdhfN
         fe/v3KPy/RXZOhnthZhFIJ7AYL2CKRdi6Yt2KqtLJlvhFPvYV1iLFlnWbzj8X81my2Ft
         DhyUuXrkO1lSNzTqqKEbqxfYRk+vMRMFYeLnwLsrxKQlReAiYnLPxhpxqT/mU0qTo+W0
         KUmzcEVtATmO+bGuV/q4n457V3s+QvsfUYXrIyBF6VagZ9NKVM9T9btQlpbTy9lRP78l
         Obi2aXXhl+Ux93/Uy7ixcJBJN9tKuRAur1FayzNZZI7ozOzWDmd/vQXVVjWCHm0CyLZA
         gKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714434313; x=1715039113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZFWCR9MFCAxJn1HS16/uVN0iXltUxYNJJKxAsC3MqM=;
        b=sYc3iUWWzDI8W+FTTBwFbEGt7TfiWsMjsrQkI8sNo3P+j2W78llqd/iczLgi6gleoX
         nl8d08vL3xE6ppkAi0C8dyhBXfFCYbxJPTQXoQ+BTBjgs8rA53qW6s4/98TAAhs0Imc2
         fnQXdVw0KzyZqD1MKP9XPC+rI3Gb4E4vZS2sr2n3VgZJ+cF1MqFtQU7IlP9Su4TUf4Id
         a5D+u5f6/mtt9xtN8Tvkbv0xp+Ivg7TThokgP24ewbA2myqWonbJeclyoYJo4pQV20GO
         wRPytLpaBzD9x/maOtthtvs1tCBsQc8fyTgW65gGcgXfvKbCOifv9DMLp2Uz3w+DOZA7
         pLuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEgvqaHEcObXeHhXpurs3r+txTEHm2osSU6MeTBf6Vg6yqVGJiYFNVbHcoSMWFJoFrCUclEqKWL1nRqRQkcVIAtkLo
X-Gm-Message-State: AOJu0YyMWXS2GD8S/NQyInn+YV7kUfCwl9QxPuhXhNd5KxXISMsF8OyM
	O6TNOF0dBq51zH/YYmNqqFUoKdmcpbCz/Z/QOzT6kwqPZ6k5isSIVMJcMwIzvnr1DuA+IGYspIG
	tHjEjjCgJup7+ohcvhb2USZvpOgU=
X-Google-Smtp-Source: AGHT+IFhjBitfolU4/KbKD+vaJrapH8uCN+KeNdDdMM8hsesUFtXOkrcob4uQtgHlVPwLLSOOr8s9ECq1RBErjx1Roo=
X-Received: by 2002:a17:90a:718b:b0:2b2:2793:9394 with SMTP id
 i11-20020a17090a718b00b002b227939394mr2389563pjk.2.1714434313671; Mon, 29 Apr
 2024 16:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424154806.3417662-1-alan.maguire@oracle.com> <20240424154806.3417662-8-alan.maguire@oracle.com>
In-Reply-To: <20240424154806.3417662-8-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 16:45:01 -0700
Message-ID: <CAEf4BzYkMpSbb+tBJ_SgEJSyYp+EWww4jLUkjjCg=krfYjzk0Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 07/13] resolve_btfids: use .BTF.base ELF
 section as base BTF if -B option is used
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 8:49=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> When resolving BTF ids, use the BTF in the module .BTF.base section
> when passed the -B option.  Both references to base BTF from split
> BTF and BTF ids will be relocated for base vmlinux on module load.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/bpf/resolve_btfids/main.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index d9520cb826b3..c5b622a31f18 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -115,6 +115,7 @@ struct object {
>         const char *path;
>         const char *btf;
>         const char *base_btf_path;
> +       int base;
>
>         struct {
>                 int              fd;
> @@ -532,11 +533,26 @@ static int symbols_resolve(struct object *obj)
>         __u32 nr_types;
>
>         if (obj->base_btf_path) {
> -               base_btf =3D btf__parse(obj->base_btf_path, NULL);
> +               LIBBPF_OPTS(btf_parse_opts, optp);
> +               const char *path;
> +
> +               if (obj->base) {
> +                       optp.btf_sec =3D BTF_BASE_ELF_SEC;
> +                       path =3D obj->path;
> +                       base_btf =3D btf__parse_opts(path, &optp);
> +                       /* fall back to normal base parsing if no BTF_BAS=
E_ELF_SEC */
> +                       if (libbpf_get_error(base_btf))

don't add new uses of libbpf_get_error(), it will be eventually
removed, as it's now quire error prone. Just check pointer and then
access errno, if necessary

> +                               base_btf =3D NULL;
> +               }
> +               if (!base_btf) {
> +                       optp.btf_sec =3D BTF_ELF_SEC;
> +                       path =3D obj->base_btf_path;
> +                       base_btf =3D btf__parse_opts(path, &optp);
> +               }
>                 err =3D libbpf_get_error(base_btf);
>                 if (err) {
>                         pr_err("FAILED: load base BTF from %s: %s\n",
> -                              obj->base_btf_path, strerror(-err));
> +                              path, strerror(-err));
>                         return -1;
>                 }
>         }
> @@ -781,6 +797,8 @@ int main(int argc, const char **argv)
>                            "BTF data"),
>                 OPT_STRING('b', "btf_base", &obj.base_btf_path, "file",
>                            "path of file providing base BTF"),
> +               OPT_INCR('B', "base", &obj.base,
> +                        "use " BTF_BASE_ELF_SEC " ELF section BTF as bas=
e"),
>                 OPT_END()
>         };
>         int err =3D -1;
> --
> 2.31.1
>

