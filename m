Return-Path: <bpf+bounces-59035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D57AC5DE8
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 01:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A04B4A0FF0
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 23:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368FF2192EB;
	Tue, 27 May 2025 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOLLZ2ro"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC591862
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748390160; cv=none; b=MTR7hs1jYru76da+G8TY+oCddLTC2QfODCcclv77Q9/RpC7JsmlaARq84CRLhdD3KgIEO9f/d8GmrkG84ShPvXo+mgHUXJezUIuj2NbFlVOOAezxDO/OiFmzxEgxyi4aL3aiylYwEXL4YQCXM94n/eV+M4FPOSp2RllPMo/U6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748390160; c=relaxed/simple;
	bh=foP+LH78R2dWOAe4TKlhSS+22lG++6XMwQo5eFNd/sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDjVxnVYAzFEyPFMB9Mb4ga5+G5XGqUupAjLV++YJZyvrGKt36ziDgygYyUX5TEZV9EEIOfaxKh2bY11B4I7QqSSz8xfivkgOUIw8oqTcMKBsdV62CD8DQ9czrJwx2ASV5LHU4YoOoWy2qWV+7uMM0oq2t7OdODjo0XZkMSGlbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOLLZ2ro; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ad52dfe06ceso474352466b.3
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 16:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748390157; x=1748994957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FXXof5urZP9RYAIL5hIGi/+uayjI+8/xkXCN4FufoBo=;
        b=lOLLZ2ror7gmleUU4buAMD+oAneSW8tIjyHeJQx2adymIdh5J6UnW8gjax9HO6a8UU
         uBd1yNHNgJt4GahErfZmuUVHRwTed8DvRBiW+54VNL793dxKgfG1F7eJBRVwphnFLMth
         iYbrn0nqLrl5j53cKrFJ2rjLAvVbR/KRgcGf2u0CJ+FDFdufNPZpNvea/sNL8TUOZ116
         O35Lg1M3qoug6xUuRVZwhgVBFE2SULRWeo9HgrC0Ghv/w3wi9sb62YCGfwbWkRtObKPV
         DrVobQjgrxbsZ6ahmUoi97RfGvGdTEdRl+b5rhldFpqxARHPT8/h9wnHv2b8AFXTE6GN
         WydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748390157; x=1748994957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXXof5urZP9RYAIL5hIGi/+uayjI+8/xkXCN4FufoBo=;
        b=HT9x4555/espRQd88eqIWp/fg0XbxvCh0JtdQlUv54OM18Qh4c1K/70J2iC2uUmGHQ
         4o472T7oeHoMvCsuVuJLzlO2v17HVVKjxmgXOfQUn7yTmSybq1iO4G8inInpXAx3BzI9
         ArTqmVsxq4zT0Gfto3/KgXCF4JC6uNRXNtuT3Bkjv4KGN/62V9/cBrJEU0Zp6nn+r0Cs
         qtvnT04vxMlU+RvkVWyAp0IoPwASpY7BVqWkq0Qt6dfsKb2oCMtcSaaO079Q8N3vUYBL
         4jsxkfsmDlu5d+A5VAvoSc88douUO3ogoDNtTZIpZW398qU5faQDp0L8inEZbFCsLitJ
         L6Dg==
X-Gm-Message-State: AOJu0YypLlcb4VaktZvd9qIgWl6V9KRSA9snNzd8bNpVNXk8FnVbl8mu
	ZSEAS3JBuZD2qc7RJ4oYsEuDsmlD5KR6lYoHjb6mVT+zh6MuEAJzoSuu702GqFzimlO0d6bGBdM
	YWHE3GZWvDkkh2vmBM9szxQSOQFYng0Hl6GAq
X-Gm-Gg: ASbGncsFYS4BBKk4akhfRZIx5i0so5EstyuYMuQpgZp1CR5XlkfWUiSC3uYMuvB0bk2
	oxzzUydbZCV/oJ/z5yzUSA1YCfuUnbsa50o5lHrcfKY5C0t3815LxkOaQ8R9Hy0EIYzSWe98ZH8
	FP3A21XwW9VDLKvygi8edmO07sM+R9AbdgQNXEXKRXmawqxTb3XFbs0djbV3PfFLlJ33oLkSzz3
	Gj/Nw==
X-Google-Smtp-Source: AGHT+IGv1LTb+lvBMsUuUnCzZgxZ9nfUOIoWezh6UILTbEHmhW+D1Wt7/GdIbncYhFRvbr9CUrpNG/inMDrh1yyMy/0=
X-Received: by 2002:a17:907:7295:b0:ad8:96d2:f3b with SMTP id
 a640c23a62f3a-ad896d213admr299197966b.27.1748390157023; Tue, 27 May 2025
 16:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-2-memxor@gmail.com>
 <m2cybt62gp.fsf@gmail.com>
In-Reply-To: <m2cybt62gp.fsf@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 May 2025 01:55:20 +0200
X-Gm-Features: AX0GCFubEZvat07PAlp1dAlPH18YJ25Rx_Y5fejeYstKZYIjcpNt8CHwlTiNE_s
Message-ID: <CAP01T77zkuR1MGOmBXCnsjjQPezLHfz0RRayfqDYZ0_h0Z4X9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/11] bpf: Introduce BPF standard streams
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 May 2025 at 01:47, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> Overall logic seems right to me, a few comments below.
>
> [...]
>
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 5b25d278409b..d298746f4dcc 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1538,6 +1538,41 @@ struct btf_mod_pair {
> >
> >  struct bpf_kfunc_desc_tab;
> >
> > +enum bpf_stream_id {
> > +     BPF_STDOUT = 1,
> > +     BPF_STDERR = 2,
> > +};
> > +
> > +struct bpf_stream_elem {
> > +     struct llist_node node;
> > +     int total_len;
> > +     int consumed_len;
> > +     char str[];
> > +};
> > +
> > +struct bpf_stream_elem_batch {
> > +     struct llist_node *node;
> > +};
>
> This type is not used anymore.
>

Will drop.

> > +
> > +enum {
> > +     BPF_STREAM_MAX_CAPACITY = (4 * 1024U * 1024U),
> > +};
> > +
> > +struct bpf_stream {
> > +     enum bpf_stream_id stream_id;
>
> Nit: `stream_id` is never read, as streams are identified by a position
>      in the bpf_prog_aux->stream.

Ack.

>
> > +     atomic_t capacity;
> > +     struct llist_head log;
> > +
> > +     rqspinlock_t lock;
> > +     struct llist_node *backlog_head;
> > +     struct llist_node *backlog_tail;
>
> Nit: maybe add comments describing what kind of data is in the llist_{head,node}? E.g.:
>
>         atomic_t capacity;
>         struct llist_head log;           /* list of struct bpf_stream_elem in LIFO order */
>
>         rqspinlock_t lock;               /* backlog_{head,tail} lock */
>         struct llist_node *backlog_head; /* list of struct bpf_stream_elem in FIFO order */
>         struct llist_node *backlog_tail;
>
>

Will do.

> > +};
> > +
> > +struct bpf_stream_stage {
> > +     struct llist_head log;
> > +     int len;
> > +};
> > +
>
> [...]
>
> > diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> > new file mode 100644
> > index 000000000000..b9e6f7a43b1b
> > --- /dev/null
> > +++ b/kernel/bpf/stream.c
>
> [...]
>
> > +int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
> > +                         enum bpf_stream_id stream_id)
> > +{
> > +     struct llist_node *list, *head, *tail;
> > +     struct bpf_stream *stream;
> > +     int ret;
> > +
> > +     stream = bpf_stream_get(stream_id, prog->aux);
> > +     if (!stream)
> > +             return -EINVAL;
> > +
> > +     ret = bpf_stream_consume_capacity(stream, ss->len);
> > +     if (ret)
> > +             return ret;
> > +
> > +     list = llist_del_all(&ss->log);
> > +     head = list;
> > +
> > +     if (!list)
> > +             return 0;
> > +     while (llist_next(list)) {
> > +             tail = llist_next(list);
> > +             list = tail;
> > +     }
> > +     llist_add_batch(head, tail, &stream->log);
>
> If `llist_next(list) == NULL` at entry `tail` is never assigned?

The assumption is llist_del_all being non-NULL means llist_next is
going to return a non-NULL value at least once.
Does that address your concern?

>
> > +     return 0;
> > +}
>
> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d5807d2efc92..5ab8742d2c00 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -13882,10 +13882,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >                       regs[BPF_REG_0].type = PTR_TO_BTF_ID;
> >                       regs[BPF_REG_0].btf_id = ptr_type_id;
> >
> > -                     if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache])
> > +                     if (meta.func_id == special_kfunc_list[KF_bpf_get_kmem_cache]) {
> >                               regs[BPF_REG_0].type |= PTR_UNTRUSTED;
> > -
> > -                     if (is_iter_next_kfunc(&meta)) {
> > +                     } else if (is_iter_next_kfunc(&meta)) {
>
> Nit: unrelated change?

Yeah, will drop.

>
> >                               struct bpf_reg_state *cur_iter;
> >
> >                               cur_iter = get_iter_from_state(env->cur_state, &meta);
>
> [...]

Thanks!

