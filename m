Return-Path: <bpf+bounces-68284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC52BB55AAE
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 02:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D397A2350
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 00:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015EA2CCDB;
	Sat, 13 Sep 2025 00:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1JHHCgL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363D1A285
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 00:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723220; cv=none; b=ZAkf4ianaW99gOGIFYWqn4CY9iEAT4GzG+LhfuAZBMrCezAtoRQewmc6+0CnS4ZIH60w6u0JfhNwi5P/W3RlO0HdOyz8+ZMfiEcnD9ZsL+pPmKkPY40W2WdH7CEuoHE2whWIoQGHNXrddjTr/BhElwQDYLzO62r5orPjOI4XabI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723220; c=relaxed/simple;
	bh=7De8C4LPfSfKBDjoZsL6FQDNMzeeGj+UX5t8JpDrZfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WihXi1Y4eSWwal7Q5JMIfmiMQ2HkWGwTmkacPB7/j7E2LX21pV8YOMBZxMtH92ho3E+KYXnkqsdXbKFfqgIfLh/WvzcDjy0CCguORimw9aYZ4kok5LRvU+KKjH+lnqL+XMYA4Miw8Q34gTl7hAJYK6t/CZ6R7e46z+aA8UqlcKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1JHHCgL; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-606b375eeb3so1284849d50.1
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 17:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757723218; x=1758328018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Db2vSflCVgrHvq+yHnqzgVenyPXGDCJMtnngQZhuEWM=;
        b=N1JHHCgLR7ZVjfE2ZYIV1hVJfpnLZuPm9e/VuBVj/5yMHhQmtQfjEktbJgv9r7PGxI
         S3O7VGJu5PMz/Q9yl6vuq7KoWshEfw1WMSS2y8qx18mnEfzBhy+6FhSyqcSiuk3zmgEq
         jduBi/shQfT0FavF+RtgBy1VqzlNCKO2eR7qGZ5sJiCriv8KHd8uc2amH/8zumIcE9XN
         mDn8tgK+mzVbi6wMbuNHt74eSRxSnQdZs2wCP+3xxRCI8RmD5sgur5qhSza0T2rH3ieh
         0BKsoI62Wox+X/y44u4TDoCg7xN3ad6wDODfN7YC+shqrJsmPtGhMRGX/ga/amSeFebj
         4DFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757723218; x=1758328018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Db2vSflCVgrHvq+yHnqzgVenyPXGDCJMtnngQZhuEWM=;
        b=LW12tps3Fh05UMHBkWGH6Gh8y5jG+rcocq3Q0DM5CGTTsOfNsTWQAW++jddmLnl1It
         UHnQJUQ6J2ncLMcoUVqzTOwtUBoSSilcl/5Lif1Ni0CrAOKQ84DJlE/C85eRjDm9f5nP
         R4xUQ4QlB3OfgT3Aa00XKTAmGBnOPG4RK6bmD9tVQJEbgkKVwTAeIBB0uYVLqe8q3+0V
         00WTHyPjzCdqmx+87A6NDJdF/mMN2b9UBISRlg5W8K6YC+RXv1SezOXXhjzyP2GRJT+3
         4fPCWQHcFDHPyLxhS+2wHknMT8+HPQouJICpXmX0F/EAN2Ujyv/6fN7joPBs+D88KDo9
         ztQw==
X-Gm-Message-State: AOJu0YygCOrO+0TRJvkkx8gIznyCD3wobvi56p4/2qKotVmrWaQC6qBJ
	Hh5WPWaDw1iLdo9acf7rPShsol35Y7p/z+rqSzs5JQvvzGhINu3/wxawA+jKTziNVKxooaNuP8P
	JCMLonvrUwKxaKGxulyns9lD4dyG9xvg=
X-Gm-Gg: ASbGnctlUgmzYgX+aeox9I7I6N2Pz4vDCuklK8k1NE0P/LgLenKXozrqFdKhd9IFeTc
	b0LFhlxL67+h2cVoE41kFQTwUXOavSVV3VtTs6vwLWL/v4AnHmi7HKe3ejCKWD7psWBIu2I6POX
	Qf8cxkU25TmRMJV2OuLFhRQtS3/A+FzWYYkrFEsj/krYbOeLhyJBBOxNXzoXaQtDNk/9CB+Wtkv
	FXN5qCfWPsmzBlgoRFF0Jr+is+m3KPp1tP7qOZags0xSzkjr/Gx4HebWJBOYw==
X-Google-Smtp-Source: AGHT+IGvjtOi4f56GCN/JEmTJb9S0wSqeF8sk3/0x6iNyNLj7ANY1wppeY7CGVruESYgFiM4GBNIh7rm5RVxzWjJXiY=
X-Received: by 2002:a53:d009:0:b0:629:2010:8770 with SMTP id
 956f58d0204a3-629201089f1mr2679922d50.18.1757723217895; Fri, 12 Sep 2025
 17:26:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912222539.149952-1-dwindsor@gmail.com> <20250912222539.149952-2-dwindsor@gmail.com>
 <CAPhsuW4phthSOfSGCrf5iFHqZH8DpTiGW+zgmTJQzNu0LByshw@mail.gmail.com>
In-Reply-To: <CAPhsuW4phthSOfSGCrf5iFHqZH8DpTiGW+zgmTJQzNu0LByshw@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 12 Sep 2025 19:26:46 -0500
X-Gm-Features: Ac12FXwkYAELRR_W9bdH6J86SAhKUC7SXKslhQvLYT3413jmnMJiBlwQuJ139j4
Message-ID: <CAEXv5_gR1=OcH9dKg3TA1MGkq8dRSNX=phuNK6n6UzD=eh6cjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: Add BPF_MAP_TYPE_CRED_STORAGE map type and kfuncs
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 7:12=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Fri, Sep 12, 2025 at 3:25=E2=80=AFPM David Windsor <dwindsor@gmail.com=
> wrote:
> >
> > All other bpf local storage is obtained using helpers which benefit fro=
m
> > RET_PTR_TO_MAP_VALUE_OR_NULL, so can return void * pointers directly to
> > map values. kfuncs don't have that, so return struct
> > bpf_local_storage_data * and access map values through sdata->data.
> >
> > Signed-off-by: David Windsor <dwindsor@gmail.com>
>
> Maybe I missed something, but I think you haven't addressed Alexei's
> question in v1: why this is needed and why hash map is not sufficient.
>
> Other local storage types (task, inode, sk storage) may get a large
> number of entries in a system, and thus would benefit from object
> local storage. I don't think we expect too many creds in a system.
> hash map of a smallish size should be good in most cases, and be
> faster than cred local storage.
>
> Did I get this right?
>
> Thanks,
> Song
>

Yes I think I addressed in the cover letter of -v2:

"Like other local storage types (task, inode, sk), this provides automatic
lifecycle management and is useful for LSM programs tracking credential
state across LSM calls. Lifetime management is necessary for detecting
credential leaks and enforcing time-based security policies."

You're right it's faster and there aren't many creds, but I feel like
in this case, it'll be a nightmare to manual cleanup with hashmaps. I
think the correctness we get with lifetime management is worth it in
this case, but could be convinced otherwise. Many cred usage patterns
are short lived and a hash map could quickly become stale...






> The following are some quick feedbacks of the patch, but let's
> first address the question above.
>
> This is hitting KASAN BUG in CI:
>
> https://github.com/kernel-patches/bpf/actions/runs/17687566710/job/502756=
83479
>
> (You may need to log in GitHub to see details).
>
> [...]
>
> > +
> > +__bpf_kfunc int bpf_cred_storage_delete(struct bpf_map *map, struct cr=
ed *cred)
> > +{
> > +       if (!cred)
> > +               return -EINVAL;
> > +
> > +       return cred_storage_delete(cred, map);
> > +}
> > +
> > +BTF_KFUNCS_START(bpf_cred_storage_kfunc_ids)
> > +BTF_ID_FLAGS(func, bpf_cred_storage_delete, 0)
> > +BTF_ID_FLAGS(func, bpf_cred_storage_get, KF_RET_NULL)
> > +BTF_KFUNCS_END(bpf_cred_storage_kfunc_ids)
> > +
> > +static const struct btf_kfunc_id_set bpf_cred_storage_kfunc_set =3D {
> > +       .owner =3D THIS_MODULE,
> > +       .set   =3D &bpf_cred_storage_kfunc_ids,
> > +};
> > +
> > +static int __init bpf_cred_storage_init(void)
> > +{
> > +       int err;
>
> We need an empty line after the declaration.
> scripts/checkpatch.pl should warn this. Please fix other warnings
> from checkpatch.pl.
>
> > +       err =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_cred_=
storage_kfunc_set);
> > +       if (err) {
>
> [...]
>
> > diff --git a/kernel/cred.c b/kernel/cred.c
> > index 9676965c0981..a1be27fe5f4c 100644
> > --- a/kernel/cred.c
> > +++ b/kernel/cred.c
> > @@ -38,6 +38,10 @@ static struct kmem_cache *cred_jar;
> >  /* init to 2 - one for init_task, one to ensure it is never freed */
> >  static struct group_info init_groups =3D { .usage =3D REFCOUNT_INIT(2)=
 };
> >
> > +#ifdef CONFIG_BPF_LSM
> > +#include <linux/bpf_lsm.h>
> > +#endif
>
> We defined a dummy version of bpf_cred_storage_free
> in bpf_lsm.h, so the ifdef here is not needed.
>
> > +
> >  /*
> >   * The initial credentials for the initial task
> >   */
> > @@ -76,6 +80,9 @@ static void put_cred_rcu(struct rcu_head *rcu)
> >                       cred, atomic_long_read(&cred->usage));
> >
> >         security_cred_free(cred);
> > +#ifdef CONFIG_BPF_LSM
> > +       bpf_cred_storage_free(cred);
> > +#endif
>
> Ditto.
>
> >         key_put(cred->session_keyring);
> >         key_put(cred->process_keyring);
> >         key_put(cred->thread_keyring);
> [...]

