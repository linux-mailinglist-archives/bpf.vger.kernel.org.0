Return-Path: <bpf+bounces-22128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B88E88573D2
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 03:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B531F24790
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 02:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF73ADF69;
	Fri, 16 Feb 2024 02:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv1BHE3k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2260DF46
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 02:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708051537; cv=none; b=K3tMEMny0MHNceGwJ2nEuQNzpyjXNXAf1gSLyw/iM2uRywlKWxgdLBM0FW7X1PofZdt8aMXoxL0SJAbY6SBEUqJTHjoa3E575o2nG1bLTQkZNsPzMA6tmPWWmCkznwUMXcGk5GGolRvEn2zxDdaKFLlr046QpZzRyYTM2u3PY3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708051537; c=relaxed/simple;
	bh=I6CZrGq98OVoRK5ZGDKJkyz/KU45t3nHWWIZI2sIWzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWYx2TRgPAAONInI/uj04O2/r54UQ0+RdpSJlCi2d04BGx0/QbfKKPhMNHkUTKZZd18enb6El4wMzuej8Q/5af9W10ilWhwTM2IB+TWH2QSigKIWNnLgjE/4PMWhjz3jUhJWsBRR/MSi+USLvy9vXCp4jqRgdjj2wzMZE47n12I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fv1BHE3k; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3392b045e0aso938112f8f.2
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 18:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708051534; x=1708656334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Jq1I98c0HFEH8i89FSBMCINNN8shwU76Ufbohm2ZQ4=;
        b=Fv1BHE3konpsR7iX2cgmMrD9dXU9rbuKSW83hrGB8YPFhc6sZZFILsgEnLYsPTw0ce
         wviuVClDAPUEbR0hRcGPNRupThTktbhpMgmWruO0gbTr6t5lzKWl1N17Pat9L5PnMWvq
         sCVBTXWRNMfFlbCEvQXCa2jjr/0SwkqBWb6LFs1EMZ+01RpDaYq5rP3CytCLMpmeym1Z
         4cqbV8nw0FuTek6nL6JOT0auBzsRhTtt9vCa8q/KrLrxUQ7NFBXZ2MdU+hkRc2dXhvXT
         dXvURiGby4e0Paau7E4PcA8ZJ0EA/CJ1f4nQuKJj2OTFEP3X9pMXjA5Uwv6+qyc4F0LW
         nGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708051534; x=1708656334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Jq1I98c0HFEH8i89FSBMCINNN8shwU76Ufbohm2ZQ4=;
        b=ZdypI5F4OqRLD73ykq1JKctOS6qrd++9fN/Vf3Blb9uXmrv3C2Oq8HIQnshbYsEpt9
         f4x14Bog3Gz6ZCY/l1kECMNDUEamNlGo9qp4dNHC3zo7BNDr/t2PAQZ1oVDaRREBloCH
         E1NbMCG863LYcC4ybEvjA9MoNB8R7x2nkxOPq3gTVyZKtY3Ae7mXiDuI1OSrvzZL/bpS
         fttqVenbQ+Nd1LNN8aaSe1Mp1Phue2u4q+a16bzmJCU5+yjdwFDfK7klg5jqzGsUwGR3
         o2MGLtKHApISjjEbbdYgCzwcvCgiWnrBPS6mcVmqy7prxk3UpL6nrrrEoguuF0SM6GlC
         h+gA==
X-Forwarded-Encrypted: i=1; AJvYcCXdl0A2oBpVmL0KSi4JTEqfjbJloNzSmWVzohNBdh8TCuRntIXMBlsXuUEDDb7qigmnqM37CED+XawCSkNZ4WpIpUyK
X-Gm-Message-State: AOJu0YxanbnKyNzsQ4AmyXhByS1pGL4qqjJ5prKJmiZoJADmO2b9DNfp
	GwnedoW26/Pr6e3dlx7xwxD+j7NN37oO88Vx2LUUbpL09o8AG9KnIC2qI/4cSEDxHZ7Fq7zXLGT
	isNcLgaVohyi9wa2y3FDXTUrHIi/MfBk4kDc=
X-Google-Smtp-Source: AGHT+IHLIG8k7oqYj6t7NSLoTK5FY10olYtQd8yoVEmQ3abgDYU+6cjqmx1R16JPuz6Mv0m7QLEUxZyD3EtureIDKDY=
X-Received: by 2002:adf:e7cb:0:b0:33b:6773:1481 with SMTP id
 e11-20020adfe7cb000000b0033b67731481mr2611769wrn.56.1708051533878; Thu, 15
 Feb 2024 18:45:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-15-alexei.starovoitov@gmail.com> <e9fbe163f0273448142ba70b2cf8a13b6cca57ad.camel@gmail.com>
 <CAEf4BzYbkqhrPCY1RfyHHY1nq-fmpxP2O-n0gMzWoDFe4Msofw@mail.gmail.com>
 <7af0d2e0cc168eb8f57be0fe185d7fa9caf87824.camel@gmail.com>
 <CAEf4BzZyPDdtV8xyFxpLmPQpKrtO-affGrEfyDkodr_BDHVZcA@mail.gmail.com>
 <CAADnVQKY0UKYRUBmUZ8BPUrcx-t-v6iMz7u0AaBUKLB1-CS0qg@mail.gmail.com>
 <CAEf4BzY8grOqDUOAuvyBw+t1oZh6x_6xubHePv3byxV3sC9uVg@mail.gmail.com> <CAEf4BzapMe_zjrN9j7w41xP05VZOV_Nys9kwks7yCC312Omdpg@mail.gmail.com>
In-Reply-To: <CAEf4BzapMe_zjrN9j7w41xP05VZOV_Nys9kwks7yCC312Omdpg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 15 Feb 2024 18:45:22 -0800
Message-ID: <CAADnVQJROT_DYp_PmQrrM3NU-rt94gynDw1Y=dNc3jgaSVNDHA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global varaibles.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 3:22=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>  {
> @@ -2835,6 +2819,33 @@ static int
> bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
>              return err;
>      }
>
> +    for (i =3D 0; i < obj->nr_maps; i++) {
> +        struct bpf_map *map =3D &obj->maps[i];
> +
> +        if (map->def.type !=3D BPF_MAP_TYPE_ARENA)
> +            continue;
> +
> +        if (obj->arena_map) {
> +            pr_warn("map '%s': only single ARENA map is supported
> (map '%s' is also ARENA)\n",
> +                map->name, obj->arena_map->name);
> +            return -EINVAL;
> +        }
> +        obj->arena_map =3D map;
> +
> +        if (obj->efile.arena_data) {
> +            err =3D init_arena_map_data(obj, map, ARENA_SEC,
> obj->efile.arena_data_shndx,
> +                          obj->efile.arena_data->d_buf,
> +                          obj->efile.arena_data->d_size);
> +            if (err)
> +                return err;
> +        }
> +    }
> +    if (obj->efile.arena_data && !obj->arena_map) {
> +        pr_warn("elf: sec '%s': to use global __arena variables the
> ARENA map should be explicitly declared in SEC(\".maps\")\n",
> +            ARENA_SEC);
> +        return -ENOENT;
> +    }
> +
>      return 0;
>  }
>
> @@ -3699,9 +3710,8 @@ static int bpf_object__elf_collect(struct bpf_objec=
t *obj)
>                  obj->efile.st_ops_link_data =3D data;
>                  obj->efile.st_ops_link_shndx =3D idx;
>              } else if (strcmp(name, ARENA_SEC) =3D=3D 0) {
> -                sec_desc->sec_type =3D SEC_ARENA;
> -                sec_desc->shdr =3D sh;
> -                sec_desc->data =3D data;
> +                obj->efile.arena_data =3D data;
> +                obj->efile.arena_data_shndx =3D idx;

I see. So these two are sort-of main tricks.
Special case ARENA_SEC like ".maps" and then look for this
obj level map in the right spots.
The special case around bpf_map__[set_]initial_value kind break
the layering with:
if (map->def.type =3D=3D BPF_MAP_TYPE_ARENA)
  actual_sz =3D map->obj->arena_data_sz;
but no big deal.

How do you want me to squash the patches?
Keep "rename is_internal_mmapable_map into is_mmapable_map" patch as-is
and then squash mine and your 2nd and 3rd?

