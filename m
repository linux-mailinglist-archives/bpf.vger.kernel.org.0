Return-Path: <bpf+bounces-14156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1887E0B26
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 23:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98911C21207
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8119024A02;
	Fri,  3 Nov 2023 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZteZuTLU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBF6249FA
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 22:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8F1C433C9
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 22:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699050672;
	bh=WPM6k9kn/HmBf0/BCbOY3f2M3fZaAB9WusEqUoIe2kE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZteZuTLUDvu102CClYSpTljC7ZgR4a8TaoGplB2rlBfTCn3izIR3rqtCY/quCXa/h
	 Vrl5Iqrbec35koprF74w3PwnPhOvIeYaEf/X4wvZMIjU2o1+EtbA2Wub6Bx6kBbCaB
	 ftvKHDiFkrT02D0GHpTTBVdwjj56bzcCadQ5ZR2WzfqF98nDX0qGNHUy46QOEHIsCE
	 nZFTrZUe1ejNko9uBVoWhWVHeU9sV9cyCUupT1lTP+Xc9VX4jhUZuXmUHlllhDbnXT
	 1ZWlxBo6gSjop6tUiLYRzN+Re1olEyqPo7gxNTLxA3LXUM0yL8t0+cqsgwVwFyQSL3
	 8kNyirSm/LidQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5079f9675c6so3299595e87.2
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 15:31:12 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxk9QH2WymkkJAZDSGj6e8lqwEXW/K9Epi8lsMS55hJYwLOGxf+
	i7il9yKCMzm8tv2eeaJY5pO3LlAKGEo1I8E5gA0=
X-Google-Smtp-Source: AGHT+IEPzgZH3k8F9rp7SzaHtyZamcutA298rWa6T7g6/zXjun0PPInW97S1guGu+5fKJ1VfRAjS+P16yEA4xu48hhA=
X-Received: by 2002:a05:6512:108e:b0:507:9d71:2a77 with SMTP id
 j14-20020a056512108e00b005079d712a77mr20657143lfg.17.1699050670456; Fri, 03
 Nov 2023 15:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103214535.2674059-1-song@kernel.org> <20231103214535.2674059-5-song@kernel.org>
 <CAEf4BzY2V1Q_V=JMV4uYqHCSnV0ZDsAaLNq6cm0CPt2d8E4XGA@mail.gmail.com>
In-Reply-To: <CAEf4BzY2V1Q_V=JMV4uYqHCSnV0ZDsAaLNq6cm0CPt2d8E4XGA@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 3 Nov 2023 15:30:58 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6yG8zL12KcjZQOB5Q9YbUdf5T3cxyzMx_GF3v_uw=LXA@mail.gmail.com>
Message-ID: <CAPhsuW6yG8zL12KcjZQOB5Q9YbUdf5T3cxyzMx_GF3v_uw=LXA@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next 4/9] bpf: Add kfunc bpf_get_file_xattr
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ebiggers@kernel.org, tytso@mit.edu, 
	roberto.sassu@huaweicloud.com, kpsingh@kernel.org, vadfed@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 3:10=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Nov 3, 2023 at 2:46=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > It is common practice for security solutions to store tags/labels in
> > xattrs. To implement similar functionalities in BPF LSM, add new kfunc
> > bpf_get_file_xattr().
> >
> > The first use case of bpf_get_file_xattr() is to implement file
> > verifications with asymmetric keys. Specificially, security application=
s
> > could use fsverity for file hashes and use xattr to store file signatur=
es.
> > (kfunc for fsverity hash will be added in a separate commit.)
> >
> > Currently, only xattrs with "user." prefix can be read with kfunc
> > bpf_get_file_xattr(). As use cases evolve, we may add a dedicated prefi=
x
> > for bpf_get_file_xattr().
> >
> > To avoid recursion, bpf_get_file_xattr can be only called from LSM hook=
s.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 64 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index bfe6fb83e8d0..82eaa099053b 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/key.h>
> >  #include <linux/verification.h>
> >  #include <linux/namei.h>
> > +#include <linux/fileattr.h>
> >
> >  #include <net/bpf_sk_storage.h>
> >
> > @@ -1431,6 +1432,69 @@ static int __init bpf_key_sig_kfuncs_init(void)
> >  late_initcall(bpf_key_sig_kfuncs_init);
> >  #endif /* CONFIG_KEYS */
> >
> > +/* filesystem kfuncs */
> > +__diag_push();
> > +__diag_ignore_all("-Wmissing-prototypes",
> > +                 "kfuncs which will be used in BPF programs");
> > +
>
> please use __bpf_kfunc_{start,end}_defs macros, from [0]
>
>   [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/=
?id=3D391145ba2acc

Nice! I was thinking about the same issue (-Wmissing-declarations).

But this patch is not pulled into bpf-next yet (only in bpf). How about we =
keep
__diag_ignore_all() etc for now?

Thanks,
Song

