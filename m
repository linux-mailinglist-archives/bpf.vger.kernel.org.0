Return-Path: <bpf+bounces-12346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5B07CB3BE
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 22:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 244E4B20ED7
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 20:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A533936AFB;
	Mon, 16 Oct 2023 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1Ctkfme"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8B9341AD
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 20:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E605C43391
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 20:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697487054;
	bh=As452/dlUWtasGwS8n21HlPVjaukoU59Bj8bloxjCz8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b1CtkfmelgA3AftUddwZM9Bp3BYgSgeSXigzzHtU7DSEUlzmWocOHteFbtojCyaXr
	 SacHLGhImcjq/Svq0KFLuE8c6f5woNMLL/Oe0qSxScFFSoCvEaByrs2M5HBYTHuPg5
	 Y3LewLDydBUlktZjwecsWLB7L9LSsdg96Le+8zQTTaAXSY8O07H7foO8YThg0IApBY
	 HxpzTGTFgXqekt5L7A2ypiHc+AOGd/4vs25tOOcSPgWz95HSSdb1J+E9oxxN9OBMBd
	 oo04Un6Ughyh/I+04iiYCOJg8EsYpWaf0poDDyFbtLhE3PNxdV330ZfUG/vDNjfZdh
	 m+TbntV9MnZwQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-503056c8195so6358613e87.1
        for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 13:10:54 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz2L+n4ALiajKQQhFSBrVWzRcUcC4Vx3cDKtec/PKcr1ZnhBKvv
	nHZE1Eez+MydCx9Oxhd/72+Cyg4aJ4t9Kkej7Ps=
X-Google-Smtp-Source: AGHT+IEV2qoS2OeGDjmCsgQWEDugOC+nrmQBsaEui/Bcw/pH+omTIspE2YNzROawi0YKMNSFjdfoSSiP6omXE9zrsVY=
X-Received: by 2002:a05:6512:b9f:b0:503:2555:d1e7 with SMTP id
 b31-20020a0565120b9f00b005032555d1e7mr323591lfv.45.1697487052662; Mon, 16 Oct
 2023 13:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231013182644.2346458-1-song@kernel.org> <20231013182644.2346458-3-song@kernel.org>
 <20231015070714.GF10525@sol.localdomain>
In-Reply-To: <20231015070714.GF10525@sol.localdomain>
From: Song Liu <song@kernel.org>
Date: Mon, 16 Oct 2023 13:10:40 -0700
X-Gmail-Original-Message-ID: <CAPhsuW42L6cfyxLR30kc1zSWQr8_JyxoUv1EuRVZpoAix3bm8A@mail.gmail.com>
Message-ID: <CAPhsuW42L6cfyxLR30kc1zSWQr8_JyxoUv1EuRVZpoAix3bm8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf, fsverity: Add kfunc bpf_get_fsverity_digest
To: Eric Biggers <ebiggers@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, tytso@mit.edu, roberto.sassu@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 15, 2023 at 12:07=E2=80=AFAM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
[...]
> > + */
> > +__bpf_kfunc int bpf_get_fsverity_digest(struct file *file, struct bpf_=
dynptr_kern *digest_ptr)
> > +{
> > +     const struct inode *inode =3D file_inode(file);
> > +     struct fsverity_digest *arg =3D digest_ptr->data;
>
> What alignment is guaranteed here?

drnptr doesn't not provide alignment guarantee for digest_ptr->data.
If we need alignment guarantee, we need to add it here.

>
> > +     const struct fsverity_info *vi;
> > +     const struct fsverity_hash_alg *hash_alg;
> > +     int out_digest_sz;
> > +
> > +     if (__bpf_dynptr_size(digest_ptr) < sizeof(struct fsverity_digest=
))
> > +             return -EINVAL;
> > +
> > +     vi =3D fsverity_get_info(inode);
> > +     if (!vi)
> > +             return -ENODATA; /* not a verity file */
> > +
> > +     hash_alg =3D vi->tree_params.hash_alg;
> > +
> > +     arg->digest_algorithm =3D hash_alg - fsverity_hash_algs;
> > +     arg->digest_size =3D hash_alg->digest_size;
> > +
> > +     out_digest_sz =3D __bpf_dynptr_size(digest_ptr) - sizeof(struct f=
sverity_digest);
> > +
> > +     /* copy digest */
> > +     memcpy(arg->digest, vi->file_digest,  min_t(int, hash_alg->digest=
_size, out_digest_sz));
> > +
> > +     /* fill the extra buffer with zeros */
> > +     memset(arg->digest + arg->digest_size, 0, out_digest_sz - hash_al=
g->digest_size);
>
> Can't 'out_digest_sz - hash_alg->digest_size' underflow?

Will fix this in the next version.

>
> > +
> > +     return 0;
> > +}
> > +
> > +__diag_pop();
> > +
> > +BTF_SET8_START(fsverity_set)
> > +BTF_ID_FLAGS(func, bpf_get_fsverity_digest, KF_SLEEPABLE)
>
> Should it be sleepable?  Nothing in it sleeps, as far as I can tell.

Indeed, we can remove sleepable requirement here.

>
> > +BTF_SET8_END(fsverity_set)
> > +
> > +const struct btf_kfunc_id_set bpf_fsverity_set =3D {
> > +     .owner =3D THIS_MODULE,
> > +     .set =3D &fsverity_set,
> > +};
>
> static const?

Will fix in v2.

>
> > +
> > +static int __init bpf_fsverity_init(void)
> > +{
> > +     return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> > +                                      &bpf_fsverity_set);
> > +}
> > +
> > +late_initcall(bpf_fsverity_init);
>
> Maybe this should be called by the existing fsverity_init() initcall inst=
ead of
> having a brand new initcall just for this.

Yeah, that would also work.

>
> Also, doesn't this all need to be guarded by a kconfig such as CONFIG_BPF=
?

Will add this in v2.

>
> Also, it looks like I'm being signed up to maintain this.  This isn't a s=
table
> UAPI, right?  No need to document this in Documentation/?

BPF kfuncs are not UAPI. They are as stable as exported symbols.
We do have some documents for BPF kfuncs, for example in
Documentation/bpf/cpumasks.rst.

Do you have a recommendation or preference on where we should
document this? AFAICT, we can either add it to fsverity.rst or somewhere
in Documentation/bpf/.

Thanks,
Song

