Return-Path: <bpf+bounces-14159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C057E0B50
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62ED281FEC
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF7024A0E;
	Fri,  3 Nov 2023 22:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBzViJ1r"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965524A03
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 22:54:03 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25058D65
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 15:54:02 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9dd5879a126so139595166b.3
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699052040; x=1699656840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDjO6lIkMKFXpFrGVUwAbyrybMO4fvAZwVAGS0l+WqA=;
        b=RBzViJ1rHAXmtQGkkggs4gtqBetj6wCqCbff36aqf/niwVFcxhxSMBpBjyNq1BBlLu
         ZzKt21X6IUciUiV41N0ESUO1BkV5dY/FsfwAIOnAqThhIDZFnZiBu7aqc26mIyBHzBDE
         vrGPGbLglE3qa2O18bnVn+OLIxkfP4GlsKLDqDopZ07DiyADNIYTDMcrzvczg590iB5y
         WtjlbZrDYalL2WU7sOQAUi15m28A9k/BOfG5DakQax3ZEHleik6Fz63US5yCwe4kKgGZ
         hmeHv9E7+jYrCFA1FwZDUJS8vzBKxazllOVee6eYaWuQYZ7ynAwRw8LwZmZTd6mIKA5R
         aXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699052040; x=1699656840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDjO6lIkMKFXpFrGVUwAbyrybMO4fvAZwVAGS0l+WqA=;
        b=EucYNrx0ve4KYnRWa+7+t9mLD/Pv02DCrwFh4j0EuNin3sWTKofJk4Se+xmga9nVo/
         PgM3KOg4YvF0ykO7Uq8yr7yOgBcqzq6oEVZK3CxRTDUt85MHfJ+TlhMWazkQgWtlKr3n
         3Q4OdFIhND+sK6XclAQvGxG7xqBNbrRZEt0ZTS/ehpzB3B+aaerDr4Rwt6UunXJHgfk1
         7b80keBF2LQpUrJK2EHtDx/653NN7FldFYE02SuFVZY2O61cwS9oVbCMy9dPXxZwMI85
         p0OPnD6AW2k6ar8uUAFZyeKWOavXAa9VhukZpIKC2Lze09MKbL6uUXKFQvwHHskBv4Wv
         Io2Q==
X-Gm-Message-State: AOJu0YyXWSDEj74RGhv+CZYiaCNcfYvajC4EGHBc7DDIcMxpHq6IYyT6
	mMQ2U1YC/CTB9BwprhqvuOLYXDPBWRLPm9iLiK4=
X-Google-Smtp-Source: AGHT+IHDfOPEkBEKXx+ucASoxCb5eKpB87iaOs7N/oNTA0+13giMgN/gRU+ZR+yYWQZ2Y+Ag/alK0b06Mn4HFH385lw=
X-Received: by 2002:a17:907:7f19:b0:9bd:fe2f:3949 with SMTP id
 qf25-20020a1709077f1900b009bdfe2f3949mr9232237ejc.51.1699052040506; Fri, 03
 Nov 2023 15:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103214535.2674059-1-song@kernel.org> <20231103214535.2674059-5-song@kernel.org>
 <CAEf4BzY2V1Q_V=JMV4uYqHCSnV0ZDsAaLNq6cm0CPt2d8E4XGA@mail.gmail.com>
 <CAPhsuW6yG8zL12KcjZQOB5Q9YbUdf5T3cxyzMx_GF3v_uw=LXA@mail.gmail.com> <CAPhsuW5Y4=e5Zhhcc2J+O55AVuuSAF=YfajqOiuE8VZyXbxvkQ@mail.gmail.com>
In-Reply-To: <CAPhsuW5Y4=e5Zhhcc2J+O55AVuuSAF=YfajqOiuE8VZyXbxvkQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Nov 2023 15:53:49 -0700
Message-ID: <CAEf4Bzbe0mW9ETZbFzn_XH6v=J1_4ZijvGFsTQRodKJ=0skrnA@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 4/9] bpf: Add kfunc bpf_get_file_xattr
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com, kpsingh@kernel.org, vadfed@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 3:38=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Fri, Nov 3, 2023 at 3:30=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > On Fri, Nov 3, 2023 at 3:10=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Nov 3, 2023 at 2:46=E2=80=AFPM Song Liu <song@kernel.org> wro=
te:
> > > >
> > > > It is common practice for security solutions to store tags/labels i=
n
> > > > xattrs. To implement similar functionalities in BPF LSM, add new kf=
unc
> > > > bpf_get_file_xattr().
> > > >
> > > > The first use case of bpf_get_file_xattr() is to implement file
> > > > verifications with asymmetric keys. Specificially, security applica=
tions
> > > > could use fsverity for file hashes and use xattr to store file sign=
atures.
> > > > (kfunc for fsverity hash will be added in a separate commit.)
> > > >
> > > > Currently, only xattrs with "user." prefix can be read with kfunc
> > > > bpf_get_file_xattr(). As use cases evolve, we may add a dedicated p=
refix
> > > > for bpf_get_file_xattr().
> > > >
> > > > To avoid recursion, bpf_get_file_xattr can be only called from LSM =
hooks.
> > > >
> > > > Signed-off-by: Song Liu <song@kernel.org>
> > > > ---
> > > >  kernel/trace/bpf_trace.c | 64 ++++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 64 insertions(+)
> > > >
> > > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > > index bfe6fb83e8d0..82eaa099053b 100644
> > > > --- a/kernel/trace/bpf_trace.c
> > > > +++ b/kernel/trace/bpf_trace.c
> > > > @@ -24,6 +24,7 @@
> > > >  #include <linux/key.h>
> > > >  #include <linux/verification.h>
> > > >  #include <linux/namei.h>
> > > > +#include <linux/fileattr.h>
> > > >
> > > >  #include <net/bpf_sk_storage.h>
> > > >
> > > > @@ -1431,6 +1432,69 @@ static int __init bpf_key_sig_kfuncs_init(vo=
id)
> > > >  late_initcall(bpf_key_sig_kfuncs_init);
> > > >  #endif /* CONFIG_KEYS */
> > > >
> > > > +/* filesystem kfuncs */
> > > > +__diag_push();
> > > > +__diag_ignore_all("-Wmissing-prototypes",
> > > > +                 "kfuncs which will be used in BPF programs");
> > > > +
> > >
> > > please use __bpf_kfunc_{start,end}_defs macros, from [0]
> > >
> > >   [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/com=
mit/?id=3D391145ba2acc
> >
> > Nice! I was thinking about the same issue (-Wmissing-declarations).
> >
> > But this patch is not pulled into bpf-next yet (only in bpf). How about=
 we keep
> > __diag_ignore_all() etc for now?
>
> I will add __diag_ignore_all("-Wmissing-declarations",) so it is
> equivalent to the marcos.

Ah, it's bpf tree, not bpf-next, I see. Ok, we'll have to leave it as
is for now and then clean up later.

>
> Thanks,
> Song

