Return-Path: <bpf+bounces-14158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684AB7E0B32
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC55628201F
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656E5249E8;
	Fri,  3 Nov 2023 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piq2Xbfc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B207E1F60A
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 22:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873F0C433C9
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 22:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699051109;
	bh=rwZYuCDTu3QKq02PnV+Y8+YL8wJQD1ZL3YtkXrfKlaM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=piq2Xbfca6c0LozRQm3uA2++cKtx4JjdcQC7IM22DeUTT7lNW1H7Dvv/b+UqQN8am
	 lDzI4EoBd1B6Rh1YtZ+EG7n4AF2jjxPqtfpeKwiIzL0k2SV0p5Nxb2HIPh8AluIq+w
	 cM4Y0tggAcFKvi8+AwunhTVwRQGEGsPE0KRGFa7Cvd0tbxz4lfcVUNg6X7xH5WbDvr
	 6W6JBktnsVyL8WkwiZ7/htXE5DfcssqQrlUr5xeAQO8uqhQCzbpEu6h7PmIF3J6TZj
	 lE55Pe0d2IX8amTfBhZl6RJpG2rmH/NKOO7P1Tk/FFQGJ76qCCFeO2uQXS3JREAj6b
	 1A5FQEg4P/Iew==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-507a29c7eefso3198712e87.1
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 15:38:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YySOyf53nYPm3btvQPPpQopwEHX4F6XlQsx4osmWYJaaIVElUEb
	DF0vH3LVPmpaQejaWHwNMwFQ7kUYK6ba6yUIoNQ=
X-Google-Smtp-Source: AGHT+IGv0APfyo/yc82yo4pqN1mIhmcEo77o8b1SEMjnWnl14p4htkDs/Xq3+71y6JnRczMNHJObjh8J/PQLmAnUZ38=
X-Received: by 2002:a05:6512:3282:b0:503:28cb:c087 with SMTP id
 p2-20020a056512328200b0050328cbc087mr16556506lfe.29.1699051107766; Fri, 03
 Nov 2023 15:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103214535.2674059-1-song@kernel.org> <20231103214535.2674059-5-song@kernel.org>
 <CAEf4BzY2V1Q_V=JMV4uYqHCSnV0ZDsAaLNq6cm0CPt2d8E4XGA@mail.gmail.com> <CAPhsuW6yG8zL12KcjZQOB5Q9YbUdf5T3cxyzMx_GF3v_uw=LXA@mail.gmail.com>
In-Reply-To: <CAPhsuW6yG8zL12KcjZQOB5Q9YbUdf5T3cxyzMx_GF3v_uw=LXA@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 3 Nov 2023 15:38:15 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Y4=e5Zhhcc2J+O55AVuuSAF=YfajqOiuE8VZyXbxvkQ@mail.gmail.com>
Message-ID: <CAPhsuW5Y4=e5Zhhcc2J+O55AVuuSAF=YfajqOiuE8VZyXbxvkQ@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 4/9] bpf: Add kfunc bpf_get_file_xattr
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com, kpsingh@kernel.org, vadfed@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 3:30=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Fri, Nov 3, 2023 at 3:10=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Nov 3, 2023 at 2:46=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
> > >
> > > It is common practice for security solutions to store tags/labels in
> > > xattrs. To implement similar functionalities in BPF LSM, add new kfun=
c
> > > bpf_get_file_xattr().
> > >
> > > The first use case of bpf_get_file_xattr() is to implement file
> > > verifications with asymmetric keys. Specificially, security applicati=
ons
> > > could use fsverity for file hashes and use xattr to store file signat=
ures.
> > > (kfunc for fsverity hash will be added in a separate commit.)
> > >
> > > Currently, only xattrs with "user." prefix can be read with kfunc
> > > bpf_get_file_xattr(). As use cases evolve, we may add a dedicated pre=
fix
> > > for bpf_get_file_xattr().
> > >
> > > To avoid recursion, bpf_get_file_xattr can be only called from LSM ho=
oks.
> > >
> > > Signed-off-by: Song Liu <song@kernel.org>
> > > ---
> > >  kernel/trace/bpf_trace.c | 64 ++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 64 insertions(+)
> > >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index bfe6fb83e8d0..82eaa099053b 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/key.h>
> > >  #include <linux/verification.h>
> > >  #include <linux/namei.h>
> > > +#include <linux/fileattr.h>
> > >
> > >  #include <net/bpf_sk_storage.h>
> > >
> > > @@ -1431,6 +1432,69 @@ static int __init bpf_key_sig_kfuncs_init(void=
)
> > >  late_initcall(bpf_key_sig_kfuncs_init);
> > >  #endif /* CONFIG_KEYS */
> > >
> > > +/* filesystem kfuncs */
> > > +__diag_push();
> > > +__diag_ignore_all("-Wmissing-prototypes",
> > > +                 "kfuncs which will be used in BPF programs");
> > > +
> >
> > please use __bpf_kfunc_{start,end}_defs macros, from [0]
> >
> >   [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commi=
t/?id=3D391145ba2acc
>
> Nice! I was thinking about the same issue (-Wmissing-declarations).
>
> But this patch is not pulled into bpf-next yet (only in bpf). How about w=
e keep
> __diag_ignore_all() etc for now?

I will add __diag_ignore_all("-Wmissing-declarations",) so it is
equivalent to the marcos.

Thanks,
Song

