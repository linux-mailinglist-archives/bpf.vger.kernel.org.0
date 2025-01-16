Return-Path: <bpf+bounces-49128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A50A1452D
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA1316A74D
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 23:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A32216602;
	Thu, 16 Jan 2025 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDeNsSoS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE7B1D934C
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069327; cv=none; b=BTvh8J3bDyq+DCtZ8nirSlTYh1Gw8xTj8m7aVC+co2aWefmUmpFDykGhju3G5E9avEgv1kMO+ydOBgS0mKUwJebrF48YjLvVySDk1E0RWVIPvjY76y4Bi2XYTzLr9rXyfVts1WWBfU8qYuWOfWo1pm1d+38CqZa+m+ziXDC+hjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069327; c=relaxed/simple;
	bh=LeCXlPUzEZaNH/ALfvkH87lP5AMuyPLZrTPErcbuDk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhSPoFb+d8Jzuv6nzuF2WB3Js/u9oCpSiBPB/cjPVKCSn4QoSrh0TJkjKDbLX/9Wrj6cjPpQ5FmgEsPoyRIdFKw12IbH65IkuFS3kjClrz8SJikCUdLVUtwapMG8I7UrJRGwmTos74Hi12nGarCsMhfVaZt4cEAw4PwtGFL28MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDeNsSoS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so2809737a91.0
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 15:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737069325; x=1737674125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtDZq0yt1HLdy8u2zM7lkcjZarjR/UdwkCFq4zE+qLc=;
        b=iDeNsSoSTCxtbBNi+nf8lOXHVefrAOOgAe7joOrrESq4QpVRnhDOtp4cFAVMg6lA+d
         Xw55xS6DhuZH5+sSm5ZdHupQ4Ck3wIXPvvSyxDUSThdkUMTgCah9IEYabWdXfJo8XQFa
         Fz24r79RmKHp+J1kj7jk+bUg6ZCGvpo3eCzLlSojD/i618UannNGdefEBqM7JMMFdC9L
         W08Qx9en9DrMkCPJ9WeJbdq/speHplsCXDbffDqUrAWBAfymcyShQILGvd+eVMSe6nw4
         hc6mP5/5+0UH5AG3RA2YXZT9IGBUhW9DphWkzW4yUSz72hWOLp6eJgc9hgyVljqbAPhq
         anEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737069325; x=1737674125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtDZq0yt1HLdy8u2zM7lkcjZarjR/UdwkCFq4zE+qLc=;
        b=jXUkCI5MEwMvnAEBD7+qFk1kaygQlFztqJPZmBbQFZGa4g9BZkLKDsKP15vQJedG8s
         R5ta6fZ+qnuJ5VAFb8d4n7GX8+BD/e974SQB1N1+h7eZn8ngOk4r4TTQ5P0F4VAZbSTY
         1+fzf8YDOpusv6DXJBPT67jQfi8qYV7S6i1Od9LfyXunzFjp4D8lfcDEWrJb+75mfR/N
         neSUOTvzCENAscdxvyutKNw7hNTXdFPmkphW2XIz4gMQx4JjUf2f+296xwGvi/Ksz0R6
         YW3ind+cs8J3yDyEbHqncTk//7PeRdM4sLbjd+09+nJ9djiKp8VQsj2iTUUA0EhrOdLc
         XAIg==
X-Gm-Message-State: AOJu0YzHHLWEFdnW3LTLcsvZYRDY09PUS9i9+BYpsfc4EXiNOj1r1i+e
	LHJBEySluk8YimddjNDPKdLeG6aPbQjANebzY3spsYqOKThcsdbfmFjTzRAKsnADSbmlobDyNyI
	HpiA3I8DkUNd89MfT1KNBOBkYAzo=
X-Gm-Gg: ASbGncvA+oNUfqn1K+f0abGRuoe0wcODgIObVUtdsMoFkcEQGnOhIRdBelGWz5+u3De
	AUgAvj4gpZz8UeXh10p4hhyZD8igtwlObOk2d
X-Google-Smtp-Source: AGHT+IFw8K1z0tTiwDGobE0jU81fce/zQGzrke199/8v1yITpLgF3pMkwhkRlt1kW+tONsB7sQGmvuGhfMk5DkaJhwE=
X-Received: by 2002:a17:90b:53c6:b0:2ee:4982:e59f with SMTP id
 98e67ed59e1d1-2f782cbfa4cmr669996a91.17.1737069324885; Thu, 16 Jan 2025
 15:15:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115223835.919989-1-eddyz87@gmail.com>
In-Reply-To: <20250115223835.919989-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 16 Jan 2025 15:15:12 -0800
X-Gm-Features: AbW1kvam_sMvIpvDtRwCB8UM3xfjLZEj9aEPSQ9LREdZ3gsPBqmeixqPshgk_Vo
Message-ID: <CAEf4BzYctSGEU3jELirr50W3Mxf0zBt6s2GpCSsdjDY6bva0Tw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] veristat: load struct_ops programs only once
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, yatsenko@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 2:39=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> libbpf automatically adjusts autoload for struct_ops programs,
> see libbpf.c:bpf_object_adjust_struct_ops_autoload.
>
> For example, if there is a map:
>
>     SEC(".struct_ops.link")
>     struct sched_ext_ops ops =3D {
>         .enqueue =3D foo,
>         .tick =3D bar,
>     };
>
> Both 'foo' and 'bar' would be loaded if 'ops' autocreate is true,
> both 'foo' and 'bar' would be skipped if 'ops' autocreate is false.
>
> This means that when veristat processes object file with 'ops',
> it would load 4 programs in total: two programs per each
> 'process_prog' call.
>
> The adjustment occurs at object load time, and libbpf remembers
> association between 'ops' and 'foo'/'bar' at object open time.
> The only way to persuade libbpf to load one of two is to adjust map
> initial value, such that only one program is referenced.
> This patch does exactly that, significantly reducing time to process
> object files with big number of struct_ops programs.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/testing/selftests/bpf/veristat.c | 39 ++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index b47836ee7d4d..23b64faa54ab 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -1103,6 +1103,42 @@ static int guess_prog_type_by_ctx_name(const char =
*ctx_name,
>         return -ESRCH;
>  }
>
> +/* Make sure only target program is referenced from struct_ops map,
> + * otherwise libbpf would automatically set autocreate for all
> + * referenced programs.
> + * See libbpf.c:bpf_object_adjust_struct_ops_autoload.
> + */
> +static void mask_unrelated_struct_ops_progs(struct bpf_object *obj,
> +                                           struct bpf_map *map,
> +                                           struct bpf_program *prog)
> +{
> +       struct btf *btf =3D bpf_object__btf(obj);
> +       const struct btf_type *t, *mt;
> +       struct btf_member *m;
> +       int i, ptr_sz, moff;
> +       size_t data_sz;
> +       void *data;
> +
> +       t =3D btf__type_by_id(btf, bpf_map__btf_value_type_id(map));
> +       if (!btf_is_struct(t))
> +               return;
> +
> +       data =3D bpf_map__initial_value(map, &data_sz);
> +       ptr_sz =3D min(btf__pointer_size(btf), sizeof(void *));

btf__pointer_size() for .bpf.o should always be 8, so this min is
pointless, I think. I can simplify to just ptr_sz =3D sizeof(void *)
while applying, if you agree. Let me know.

Other than that looks good.

> +       for (i =3D 0; i < btf_vlen(t); i++) {
> +               m =3D &btf_members(t)[i];
> +               mt =3D btf__type_by_id(btf, m->type);
> +               if (!btf_is_ptr(mt))
> +                       continue;
> +               moff =3D m->offset / 8;
> +               if (moff + ptr_sz > data_sz)
> +                       continue;
> +               if (memcmp(data + moff, &prog, ptr_sz) =3D=3D 0)
> +                       continue;
> +               memset(data + moff, 0, ptr_sz);
> +       }
> +}
> +
>  static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, =
const char *filename)
>  {
>         struct bpf_map *map;
> @@ -1118,6 +1154,9 @@ static void fixup_obj(struct bpf_object *obj, struc=
t bpf_program *prog, const ch
>                 case BPF_MAP_TYPE_INODE_STORAGE:
>                 case BPF_MAP_TYPE_CGROUP_STORAGE:
>                         break;
> +               case BPF_MAP_TYPE_STRUCT_OPS:
> +                       mask_unrelated_struct_ops_progs(obj, map, prog);
> +                       break;
>                 default:
>                         if (bpf_map__max_entries(map) =3D=3D 0)
>                                 bpf_map__set_max_entries(map, 1);
> --
> 2.47.1
>

