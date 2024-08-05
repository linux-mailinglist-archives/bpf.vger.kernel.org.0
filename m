Return-Path: <bpf+bounces-36410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E98A69482C4
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 22:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749D4B21337
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 20:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FC416A956;
	Mon,  5 Aug 2024 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fToIKlVh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11AD74059
	for <bpf@vger.kernel.org>; Mon,  5 Aug 2024 20:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888014; cv=none; b=GywqYbh2/E4jxEBrCwhE4dDJIXzgpqHU/lHIQPS9rjDbWaa0Mone779ih84OU5zSRZNC021P6Ndx1sPjzJzUse7oW98jhS/xNozrEuo8ZQM2At959Zpmk/1IODDgXjuTKoPAGVu0WzBlaaPfsjZOz0iA2GKmCDe5LNvn2cA5D0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888014; c=relaxed/simple;
	bh=YKyCkN9KdYzH50Vix3N12m3TFmx0S2gyU0r22s8anRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJryaYGZFH2B2V8wbMm9dhMaTAbaVKwYRqtXZxwRUtwAV5B8UdlxzvAZXRov8GTLZRyZO8AfQPdqzJ+Kbtm6Cnc3ApNcGkEK47flYtDhhiYhs0Zba63h0nqxawZ6h3FkHfdaMtkOexOpyhGV/eDLeYX3c6I8LgQWYKlJcSOndMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fToIKlVh; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-690af536546so19608807b3.3
        for <bpf@vger.kernel.org>; Mon, 05 Aug 2024 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722888011; x=1723492811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLPaKTKvoWSakHkJAoCFrqui3fMCyFsiKhXWih0Lj+4=;
        b=fToIKlVh+UluNnIamm8WaX20LTDqucw0WGX+Cj1KacL5O7bXGXe5fht10IPYDRXhlw
         F0qAW54b8TfZ8zDOBAN6vHQEOW2gn1ACrpWBOzYpgk9KSHxI5gFuNBynUsmqSRyhBEpp
         81vcbnhyU/l044BIR0HNST87mmXlnlAkPZAWXjLKRKoRO2hzS7W2WZb+f0pp35nPlxvR
         Y/xZdGtoQ6MvmsQWvqAfhbf864FXquPpjInbQ4QQn6nrH+b6E1zC4wLqDB1I9JqmEQuD
         egCkxaiCQ9JRZ6LGXIHy2tXb6pnNI+IadI58oOlHzAh7TYdtbkHhZEt7VPa1PIuilZCa
         7HKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722888011; x=1723492811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLPaKTKvoWSakHkJAoCFrqui3fMCyFsiKhXWih0Lj+4=;
        b=BQQD4U1Ym9CGSqTV6VXUbsLCmsiMK9I5eafPui7eV5IzSFrQGmiV1ks+gr5PUN7GUr
         1kxCXWYwTt4LPM4/HD3V6cXosnkhykyVCLQSQWkeJqTC3B1k3VnyUmPAW3vW2PNPrv/U
         /zxCe8Gsaaf0mU4Y1mu9ZHjMHK5eU7oWMb4CklZ/YcPyNWzudcx3uNhN+v8g8QD3ldIU
         Qc7tAwPPFzvKxJ5mbyycqkPHLjG8+ogcmqNNBBVByabYBnsdyrVu9CfItnh+BqKVKXlF
         H4xPYouAHuorx8syQAFuJyaeg1if5Hq0qxFdayS+WoU15zVYDNnzVO1EDEMxqBpWwxPp
         ibGQ==
X-Gm-Message-State: AOJu0YwKeswkKN4hVBy972ZxGqWX5Av3N4KknXrPx0ytf4Fn4FJoeYd2
	yRk2XuRoR8OXrmNqrS3QaiZAW49vJggji2v5SVRSI+l3FVAGoeFA1X2IfVEsLVHsxXf5k02JHI4
	9YylvXd6oNHKL1XENevU+SuMtYyw=
X-Google-Smtp-Source: AGHT+IHpm4p5DAd99TnPaiXPd7HSLxJfyPxReKQ/TKXWRad3bgOBLseL6I8YaGM2EuGV0d3pDYFChTAXGPChLBX4fvA=
X-Received: by 2002:a5b:451:0:b0:e0b:b2a7:d145 with SMTP id
 3f1490d57ef6-e0bde51fbcfmr11693789276.55.1722888011386; Mon, 05 Aug 2024
 13:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803001145.635887-1-amery.hung@bytedance.com>
 <20240803001145.635887-2-amery.hung@bytedance.com> <2921fc67-9129-1b5d-e720-1ca8f64e47fc@huaweicloud.com>
 <CAMB2axMwf07usb4gqocBH_9hgPsu9_VLQYMp83gV0sdazrcc-g@mail.gmail.com> <7b527651-a551-7d57-19d2-15dbff25db92@huaweicloud.com>
In-Reply-To: <7b527651-a551-7d57-19d2-15dbff25db92@huaweicloud.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 5 Aug 2024 13:00:00 -0700
Message-ID: <CAMB2axO3_ZVvaE7A_ZiVf21HSbuHyWf7tRUqKhm8Y_OJDKaQ6A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Search for kptrs in prog BTF structs
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com, 
	davemarchevsky@fb.com, Amery Hung <amery.hung@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 12:32=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 8/5/2024 12:31 PM, Amery Hung wrote:
> > On Sun, Aug 4, 2024 at 7:41=E2=80=AFPM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >> Hi,
> >>
> >> On 8/3/2024 8:11 AM, Amery Hung wrote:
> >>> From: Dave Marchevsky <davemarchevsky@fb.com>
> >>>
> >>> Currently btf_parse_fields is used in two places to create struct
> >>> btf_record's for structs: when looking at mapval type, and when looki=
ng
> >>> at any struct in program BTF. The former looks for kptr fields while =
the
> >>> latter does not. This patch modifies the btf_parse_fields call made w=
hen
> >>> looking at prog BTF struct types to search for kptrs as well.
> >>>
> >> SNIP
> >>> On a side note, when building program BTF, the refcount of program BT=
F
> >>> is now initialized before btf_parse_struct_metas() to prevent a
> >>> refcount_inc() on zero warning. This happens when BPF_KPTR is present
> >>> in program BTF: btf_parse_struct_metas() -> btf_parse_fields()
> >>> -> btf_parse_kptr() -> btf_get(). This should be okay as the program =
BTF
> >>> is not available yet outside btf_parse().
> >> If btf_parse_kptr() pins the passed btf, there will be memory leak for
> >> the btf after closing the btf fd, because the invocation of btf_put()
> >> for kptr record in btf->struct_meta_tab depends on the invocation of
> >> btf_free_struct_meta_tab() in btf_free(), but the invocation of
> >> btf_free() depends the final refcnt of the btf is released, so the btf
> >> will not be freed forever. The reason why map value doesn't have such
> >> problem is that the invocation of btf_put() for kptr record doesn't
> >> depends on the release of map value btf and it is accomplished by
> >> bpf_map_free_record().
> >>
> > Thanks for pointing this out. It makes sense to me.
> >
> >> Maybe we should move the common btf used by kptr and graph_root into
> >> btf_record and let the callers of btf_parse_fields() and
> >> btf_record_free() to decide the life cycle of btf in btf_record.
> > Could you maybe explain if and why moving btf of btf_field_kptr and
> > btf_field_graph_root to btf_record is necessary? I think letting
> > callers of btf_parse_fields() and btf_record_free() decide whether or
> > not to change refcount should be enough. Besides, I personally would
> > like to keep individual btf in btf_field_kptr and
> > btf_field_graph_root, so that later we can have special fields
> > referencing different btf.
>
> Sorry, I didn't express the rough idea clearly enough. I didn't mean to
> move btf of btf_field_kptr and btf_field_graph_root to btf_record,
> because there are other btf-s which are different with the btf which
> creates the struct_meta_tab. What I was trying to suggest is to save one
> btf in btf_record and hope it will simplify the pin and the unpin of btf
> in btf_record:
>
> 1) save the btf which owns the btf_record in btf_record.
> 2) during btf_parse_kptr() or similar, if the used btf is the same as
> the btf in btf_record, there is no need to pin the btf
> 3) when freeing the btf_record, if the btf saved in btf_field is the
> same as the btf in btf_record, there is no need to put it
>
> For step 2) and step 3), however I think it is also doable through other
> ways (e.g., pass the btf to btf_record_free or similar).

Thanks for clarifying. I see what you mean in 1), and saving the
owner's btf in btf_record seems to be cleaner than adding additional
arguments to btf_record_free() and other related functions.

Thanks,
Amery

> >
> > Thanks,
> > Amery
> >
> >>> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
> >>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> >>> Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> >>> ---
> >>>  kernel/bpf/btf.c | 6 ++++--
> >>>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> >>> index 95426d5b634e..7b8275e3e500 100644
> >>> --- a/kernel/bpf/btf.c
> >>> +++ b/kernel/bpf/btf.c
> >>> @@ -5585,7 +5585,8 @@ btf_parse_struct_metas(struct bpf_verifier_log =
*log, struct btf *btf)
> >>>               type =3D &tab->types[tab->cnt];
> >>>               type->btf_id =3D i;
> >>>               record =3D btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF=
_LIST_HEAD | BPF_LIST_NODE |
> >>> -                                               BPF_RB_ROOT | BPF_RB_=
NODE | BPF_REFCOUNT, t->size);
> >>> +                                               BPF_RB_ROOT | BPF_RB_=
NODE | BPF_REFCOUNT |
> >>> +                                               BPF_KPTR, t->size);
> >>>               /* The record cannot be unset, treat it as an error if =
so */
> >>>               if (IS_ERR_OR_NULL(record)) {
> >>>                       ret =3D PTR_ERR_OR_ZERO(record) ?: -EFAULT;
> >>> @@ -5737,6 +5738,8 @@ static struct btf *btf_parse(const union bpf_at=
tr *attr, bpfptr_t uattr, u32 uat
> >>>       if (err)
> >>>               goto errout;
> >>>
> >>> +     refcount_set(&btf->refcnt, 1);
> >>> +
> >>>       struct_meta_tab =3D btf_parse_struct_metas(&env->log, btf);
> >>>       if (IS_ERR(struct_meta_tab)) {
> >>>               err =3D PTR_ERR(struct_meta_tab);
> >>> @@ -5759,7 +5762,6 @@ static struct btf *btf_parse(const union bpf_at=
tr *attr, bpfptr_t uattr, u32 uat
> >>>               goto errout_free;
> >>>
> >>>       btf_verifier_env_free(env);
> >>> -     refcount_set(&btf->refcnt, 1);
> >>>       return btf;
> >>>
> >>>  errout_meta:
> > .
>

