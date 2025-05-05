Return-Path: <bpf+bounces-57351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BEFAA9936
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 18:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A36E3B2857
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 16:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7A725D21A;
	Mon,  5 May 2025 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fjjqu5kx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA9C8FE
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462845; cv=none; b=Hb59BQpUm61P2dQmuJxZjgCS+FYZr3fludKpRYUndDTIGocrVfpsNksDgP0wPGI28jt0TMb95xVA+52/imBTFYdj6pNTjI79m0y22xYbiZx0nJGZB9/+ig+255THgNBpOP8yaRjoRpegPnMIQX3Gr7MFyz+GxOljU20HCCekaFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462845; c=relaxed/simple;
	bh=ZUdQ8e073ixU4cLB0bqOKNy/fnMe5Asq5Q6r+NH3CdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqgn7L185Fy5/hrkSLKJST5TTkdVaulUsGyB+PIqMGzZ3Jnnui8BbwrgUsH6o2zwB+GWBebWkgdq/QJEuouy7vdIeAvMwH4Bfdy+MjACNnTJ4WcPN6MAFzAgIFvORdtqwDTL4+SvkdDXVq1wMHNEhjdhiQmQhQJ4BVFk9vexCQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fjjqu5kx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ef83a6bfaso104495e9.1
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 09:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746462841; x=1747067641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp9xG8IzZ6A+sCM3e//b/xF89Qt5DTbc6K0sQ70LgNM=;
        b=Fjjqu5kxIDckj/65HS0mnj4PmCeuvUCrvF0cRmUVwiHHxOOfD4LC776bWU4ryYAJZ+
         FP1hQkCGBa4A+yJgaKUr1YqEvbGYwu0P1cY7GQ7g1IDDNdgVPtznnMIZvgcIPiNnHlQR
         IGTnSnmoPayqp7+zO3vzR+yp4V7ktqDPEUtiCw8TKnVQPa4OO7v60QMC9XkEsXYQdhFA
         DcFDp7QmsJlGXPRhmmE4Hq2sniOamQIn2aICjZFtGcptcyMQ2NRQn84fnyNN2n2rOXHu
         xYjb2prfU7LNup9idIy3crcsJuGniV9Yx16Ti25GWb8sse/qbWlyw2CcoWiMI/Fne+xj
         iL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746462841; x=1747067641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cp9xG8IzZ6A+sCM3e//b/xF89Qt5DTbc6K0sQ70LgNM=;
        b=lWiE5J2NwnWJyAl/U3nYh5PzJCzkR8UJgPj9mukro/sfrjW7XZfSi+8tsrqitGi5ig
         xt/1eg3keubxWRzNN0Utz5JvCv2PisK4fudfE3SM9R2zIK6WCC8KL7dXv3KvRJsFPxBp
         +oqNeU/wEviUAglAcM6nvo9iSg/Xq/JlHBI/jOUWClSQGUa1KS+BdoOhwYtOZbrc+L33
         Nwu1kUk0bJB3+igTbqQ4DXwnMmxmUQRJnGArMss+AMRDO3Uid0SlSTSMMqgo54ZbxbxJ
         /sSLD2chwC40psnTxh6vlAlGXBhsFTi0lqGRvwdkRnliNLTqXqLgRYalt3QGv8LSro4p
         hqtA==
X-Forwarded-Encrypted: i=1; AJvYcCU62gqz2IXgsDOMg/6KEIFZZ3jMxuPpJ4ox8N5j+bNRhplYrr0/LJPsIme0uImaLF69Rtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFm4dKSOFewPo1vlYKsPC+Iwe6J59MtN9C3byaNgaTbI/qt2zm
	ldEa/4Oo1ZsLVnZV/lG7NQDJZJf2uSTVYDBOCveMsPdd9ggecYKX6/FvSO08owUrsMiIAaSt830
	MueOpF2Gm7il95ueDoQR6ge7HBhRUujJqCN3O
X-Gm-Gg: ASbGnctXtwyg45cndj0tOoc1fudGhHTPJL8iEkpx13Ld9AMp24BwH4965iSDeYauhg8
	705DzljeDOZLml06x6ItQca+EjQxwV6mUl7UKCilUQ2hKcnshnocEdbk6MmEklOBrv2LC53m9zA
	kBKWVV55bFlILgFyUAEhi9
X-Google-Smtp-Source: AGHT+IGQyGO5uVSmpnPnkE3FDZ4KT+CnyY7gWk8P1H5yWIU1LA4t6+ZiezZ9eO866m7rRnEE4b46YYgj28ToiihwpHE=
X-Received: by 2002:a05:600c:3b82:b0:439:9434:1b6c with SMTP id
 5b1f17b1804b1-441cf9b141dmr171795e9.3.1746462840937; Mon, 05 May 2025
 09:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250504224149.1033867-1-tjmercier@google.com>
 <20250504224149.1033867-3-tjmercier@google.com> <26ca8ddf-0d78-462f-a47d-a1128b2e058f@amd.com>
In-Reply-To: <26ca8ddf-0d78-462f-a47d-a1128b2e058f@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 5 May 2025 09:33:48 -0700
X-Gm-Features: ATxdqUHRGgaUPb2TsqMguMaRajHe7gmAlhGQ8JWKvVw_IFJV369f1ssTaaa65I4
Message-ID: <CABdmKX2iNk22h-KxUr4yvZO80yeRRjMfoC7yjiZ-aR_f1k402g@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] bpf: Add dmabuf iterator
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: sumit.semwal@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, skhan@linuxfoundation.org, 
	song@kernel.org, alexei.starovoitov@gmail.com, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, android-mm@google.com, 
	simona@ffwll.ch, corbet@lwn.net, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 4:17=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 5/5/25 00:41, T.J. Mercier wrote:
> > The dmabuf iterator traverses the list of all DMA buffers.
> >
> > DMA buffers are refcounted through their associated struct file. A
> > reference is taken on each buffer as the list is iterated to ensure eac=
h
> > buffer persists for the duration of the bpf program execution without
> > holding the list mutex.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >  kernel/bpf/Makefile      |   3 +
> >  kernel/bpf/dmabuf_iter.c | 134 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 137 insertions(+)
> >  create mode 100644 kernel/bpf/dmabuf_iter.c
> >
> > diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> > index 70502f038b92..3a335c50e6e3 100644
> > --- a/kernel/bpf/Makefile
> > +++ b/kernel/bpf/Makefile
> > @@ -53,6 +53,9 @@ obj-$(CONFIG_BPF_SYSCALL) +=3D relo_core.o
> >  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_iter.o
> >  obj-$(CONFIG_BPF_SYSCALL) +=3D btf_relocate.o
> >  obj-$(CONFIG_BPF_SYSCALL) +=3D kmem_cache_iter.o
> > +ifeq ($(CONFIG_DMA_SHARED_BUFFER),y)
> > +obj-$(CONFIG_BPF_SYSCALL) +=3D dmabuf_iter.o
> > +endif
> >
> >  CFLAGS_REMOVE_percpu_freelist.o =3D $(CC_FLAGS_FTRACE)
> >  CFLAGS_REMOVE_bpf_lru_list.o =3D $(CC_FLAGS_FTRACE)
> > diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
> > new file mode 100644
> > index 000000000000..968762e11f73
> > --- /dev/null
> > +++ b/kernel/bpf/dmabuf_iter.c
> > @@ -0,0 +1,134 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2025 Google LLC */
> > +#include <linux/bpf.h>
> > +#include <linux/btf_ids.h>
> > +#include <linux/dma-buf.h>
> > +#include <linux/kernel.h>
> > +#include <linux/seq_file.h>
> > +
> > +BTF_ID_LIST_SINGLE(bpf_dmabuf_btf_id, struct, dma_buf)
> > +DEFINE_BPF_ITER_FUNC(dmabuf, struct bpf_iter_meta *meta, struct dma_bu=
f *dmabuf)
> > +
> > +static struct dma_buf *get_next_dmabuf(struct dma_buf *dmabuf)
> > +{
> > +     struct dma_buf *ret =3D NULL;
> > +
> > +     /*
> > +      * Look for the first/next buffer we can obtain a reference to.
> > +      *
> > +      * The list mutex does not protect a dmabuf's refcount, so it can=
 be
> > +      * zeroed while we are iterating. We cannot call get_dma_buf() si=
nce the
> > +      * caller of this program may not already own a reference to the =
buffer.
> > +      */
> > +     mutex_lock(&dmabuf_list_mutex);
> > +     if (dmabuf) {
>
> That looks like you try to mangle the start and next functionality in jus=
t one function.
>
> I would just inline that into the dmabuf_iter_seq_start() and dmabuf_iter=
_seq_next() functions.

Primarily this is to share between the open coded iterator (next
patch) and this normal iterator since I didn't want to duplicate the
same list traversal code across both of them.
>
>
> > +             dma_buf_put(dmabuf);
> > +             list_for_each_entry_continue(dmabuf, &dmabuf_list, list_n=
ode) {
>
> That you can put the DMA-buf and then still uses it in list_for_each_entr=
y_continue() only works because the mutex is locked in the destroy path.

Yup, this was deliberate.
>
>
> I strongly suggest to just put those two functions into drivers/dma-buf/d=
ma-buf.c right next to the __dma_buf_debugfs_list_add() and __dma_buf_debug=
fs_list_del() functions.

By two functions, you mean a get_first_dmabuf(void) and a
get_next_dmabuf(struct dma_buf*)? To make the dma_buf_put() call a
little less scary since all the mutex ops are right there?
>
>
> Apart from those style suggestions looks good to me from the technical si=
de, but I'm not an expert for the BPF stuff.
>
> Regards,
> Christian.

Thanks for your comments and reviews!

> > +                     if (file_ref_get(&dmabuf->file->f_ref)) {
> > +                             ret =3D dmabuf;
> > +                             break;
> > +                     }
> > +             }
> > +     } else {
> > +             list_for_each_entry(dmabuf, &dmabuf_list, list_node) {
> > +                     if (file_ref_get(&dmabuf->file->f_ref)) {
> > +                             ret =3D dmabuf;
> > +                             break;
> > +                     }
> > +             }
> > +     }
> > +     mutex_unlock(&dmabuf_list_mutex);
> > +     return ret;
> > +}
> > +
> > +static void *dmabuf_iter_seq_start(struct seq_file *seq, loff_t *pos)
> > +{
> > +     if (*pos)
> > +             return NULL;
> > +
> > +     return get_next_dmabuf(NULL);
> > +}
> > +
> > +static void *dmabuf_iter_seq_next(struct seq_file *seq, void *v, loff_=
t *pos)
> > +{
> > +     struct dma_buf *dmabuf =3D v;
> > +
> > +     ++*pos;
> > +
> > +     return get_next_dmabuf(dmabuf);
> > +}
> > +
> > +struct bpf_iter__dmabuf {
> > +     __bpf_md_ptr(struct bpf_iter_meta *, meta);
> > +     __bpf_md_ptr(struct dma_buf *, dmabuf);
> > +};
> > +
> > +static int __dmabuf_seq_show(struct seq_file *seq, void *v, bool in_st=
op)
> > +{
> > +     struct bpf_iter_meta meta =3D {
> > +             .seq =3D seq,
> > +     };
> > +     struct bpf_iter__dmabuf ctx =3D {
> > +             .meta =3D &meta,
> > +             .dmabuf =3D v,
> > +     };
> > +     struct bpf_prog *prog =3D bpf_iter_get_info(&meta, in_stop);
> > +
> > +     if (prog)
> > +             return bpf_iter_run_prog(prog, &ctx);
> > +
> > +     return 0;
> > +}
> > +
> > +static int dmabuf_iter_seq_show(struct seq_file *seq, void *v)
> > +{
> > +     return __dmabuf_seq_show(seq, v, false);
> > +}
> > +
> > +static void dmabuf_iter_seq_stop(struct seq_file *seq, void *v)
> > +{
> > +     struct dma_buf *dmabuf =3D v;
> > +
> > +     if (dmabuf)
> > +             dma_buf_put(dmabuf);
> > +}
> > +
> > +static const struct seq_operations dmabuf_iter_seq_ops =3D {
> > +     .start  =3D dmabuf_iter_seq_start,
> > +     .next   =3D dmabuf_iter_seq_next,
> > +     .stop   =3D dmabuf_iter_seq_stop,
> > +     .show   =3D dmabuf_iter_seq_show,
> > +};
> > +
> > +static void bpf_iter_dmabuf_show_fdinfo(const struct bpf_iter_aux_info=
 *aux,
> > +                                     struct seq_file *seq)
> > +{
> > +     seq_puts(seq, "dmabuf iter\n");
> > +}
> > +
> > +static const struct bpf_iter_seq_info dmabuf_iter_seq_info =3D {
> > +     .seq_ops                =3D &dmabuf_iter_seq_ops,
> > +     .init_seq_private       =3D NULL,
> > +     .fini_seq_private       =3D NULL,
> > +     .seq_priv_size          =3D 0,
> > +};
> > +
> > +static struct bpf_iter_reg bpf_dmabuf_reg_info =3D {
> > +     .target                 =3D "dmabuf",
> > +     .feature                =3D BPF_ITER_RESCHED,
> > +     .show_fdinfo            =3D bpf_iter_dmabuf_show_fdinfo,
> > +     .ctx_arg_info_size      =3D 1,
> > +     .ctx_arg_info           =3D {
> > +             { offsetof(struct bpf_iter__dmabuf, dmabuf),
> > +               PTR_TO_BTF_ID_OR_NULL },
> > +     },
> > +     .seq_info               =3D &dmabuf_iter_seq_info,
> > +};
> > +
> > +static int __init dmabuf_iter_init(void)
> > +{
> > +     bpf_dmabuf_reg_info.ctx_arg_info[0].btf_id =3D bpf_dmabuf_btf_id[=
0];
> > +     return bpf_iter_reg_target(&bpf_dmabuf_reg_info);
> > +}
> > +
> > +late_initcall(dmabuf_iter_init);
>

