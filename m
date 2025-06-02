Return-Path: <bpf+bounces-59451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D67EACBC23
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 22:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0D9B1891BAA
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 20:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20EC1A9B52;
	Mon,  2 Jun 2025 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F38adrsi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3962629D
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748894875; cv=none; b=OJNlXXzr7c3bVjksPopugCDpFKKkBmGedX6jvLQpLy5N4mxEMhn/RQTEPlxZJGfEOp2HhCZKjtpgBo8xoKuErCY7904v9k4oO+8sR+32OUMJTG2mzf2TnCQUqz/KDJBHN6FJPfUO7sRKxzfDNsJJtIpf+9Cu838MXEh9b+LXvs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748894875; c=relaxed/simple;
	bh=7LYbjd/BpAZ5cAvUi1O0KWqg3NnZWsscwrxSwz3CkC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHEzQRqDcyqipG/3oOcjpnBcR5pCmlZz2iXFe0zKhHTl+bgWcQqf5TSA//qbEMGyFxG2w04xtVqMKJD2BaTjCq4ABQyWe4stvfYRDXhK5+m/mPKTolD8IKZD5coOsFmFor/CJIctIewbMhlhj9o+VjHWqWt4G6kM+2eKipTg93g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F38adrsi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450ce671a08so30755525e9.3
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748894872; x=1749499672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVJiUxc3VgjmYpypEDxwTkCYaLk1Ux15P7xjVoYk4eg=;
        b=F38adrsisBFrdSXDgrAWJsIovKkc3ljlWchl/yE3PX45WevZBpbU0uyygWLyGTOmYs
         /9GgULEpVZhGFU6hWGexeay5Ujb1OqGr6c75v5SqnChUf0rTY7JMY+HLxZ7I8iaAaN0l
         qOddafnDe0S6NCYwU7DwiiLgi/UV8G//rGkdm1xVR1BFUqPG42goft1qJdrKklkJ+44o
         sfvO9Rb5DZS/SjjRTpAeOXLSVVZShel8KXG3IICVMialOrB4IhqBZijxW950gpK+XsLY
         7VguuoaSsZWiXig94ANZVeI/NQ68ZYDuosk+ZqN/DOdUNuXs0EGmfgbUVXFNbswtlROp
         1hqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748894872; x=1749499672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVJiUxc3VgjmYpypEDxwTkCYaLk1Ux15P7xjVoYk4eg=;
        b=KEoILIWDZyJxowwrDefTGC/t6KxfSpCr9Lr9JqXUb+axivyq44Kav+7zAKVR3Mm9PT
         7cMsvcmuaWSqSPTU1oW5F7t84CKezuhCuOWuPqtXkcXOCu88huQhxgdbS78becyXX3PC
         req2AnwLAc8ZghqMqmwRMkxN0ajnK2GydQiWznForbqmpurvZurQm9MtDCKBIezUdX6N
         YFCeAwNeTR9xJmolBAMXjFsC6maz0xMXA57Xi6zpK/TE/7e+obqUNdMKK0+3s0QvELZN
         vUKUzSp6XiiplmZ1vzCgTTW62KcSe48ppPyFjMA80Ez0eGG8uyR9LJtmMKJZSoNQR9xV
         YEyQ==
X-Gm-Message-State: AOJu0YwxKWdXLU37s+jxUoBJljzI8nBt2lbe0LMTKsmr5ehRLBl/Iu41
	lwpC0mMh7oeVpn19YntmA3Oa4BDgkzYZcXprGHj96qWaAiia6+OvzXmbEd+7mxzSOo8sXO8tm2A
	ltlhRog3hEwcqbkclGPuDOeCD56dwB0qWzxCG
X-Gm-Gg: ASbGncsQrJ7qo0jc4583BKO1OFlNX1vJ+YczyQRQcs9MxF0v5143YK5elZ297IpGsjS
	SdlKTJYP9m27XhNL334pmPr/ghKbqrwMLgNUJ6nvKJ+LnHlvpsAG2jn45xvikg+aC0M/eK/qU2d
	D/PoFD3fo24ixfuR3MiQcGOt52RECzBhrKwWYgvgAOsJ/ENR3p
X-Google-Smtp-Source: AGHT+IHIlli1+MLCTPeVyOfkgPfDCqMoT3VVexiXIcsr+MjslzFltDFqjACY/EREab08ib4xYdAT8YSs45tOjTM4tWc=
X-Received: by 2002:a05:6000:1ac9:b0:3a2:ffbe:3676 with SMTP id
 ffacd0b85a97d-3a4fe399456mr6927912f8f.49.1748894871711; Mon, 02 Jun 2025
 13:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-2-memxor@gmail.com>
In-Reply-To: <20250524011849.681425-2-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Jun 2025 13:07:40 -0700
X-Gm-Features: AX0GCFuP1_Ugh2Ja_FBJnwdeoI_8Q6yf3guqHBAdC7uwCmPYEpeu0di6XyOC57w
Message-ID: <CAADnVQ+T3Srjvcx0PQjVE9BUg0PKwrv22QDnkLjiaROrm=ggjA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/11] bpf: Introduce BPF standard streams
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 6:18=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
>         for (i =3D 0; i < aux->real_func_cnt; i++) {
> +#ifdef CONFIG_BPF_SYSCALL
> +               /* Ensure we don't push to subprog lists. */
> +               if (bpf_is_subprog(aux->func[i])) {
> +                       WARN_ON_ONCE(!llist_empty(&aux->func[i]->aux->str=
eam[0].log));
> +                       WARN_ON_ONCE(!llist_empty(&aux->func[i]->aux->str=
eam[1].log));
> +               }

Why check for subprogs only ?


> -/* Per-cpu temp buffers used by printf-like helpers to store the bprintf=
 binary
> - * arguments representation.
> - */
> -#define MAX_BPRINTF_BIN_ARGS   512
> -
>  /* Support executing three nested bprintf helper calls on a given CPU */
>  #define MAX_BPRINTF_NEST_LEVEL 3
> -struct bpf_bprintf_buffers {
> -       char bin_args[MAX_BPRINTF_BIN_ARGS];
> -       char buf[MAX_BPRINTF_BUF];
> -};

Pls split the refactor into another patch.

> +static int bpf_stream_read(struct bpf_stream *stream, void __user *buf, =
int len)
> +{
> +       int rem_len =3D len, cons_len, ret =3D 0;
> +       struct bpf_stream_elem *elem =3D NULL;
> +       struct llist_node *node;
> +       unsigned long flags;
> +
> +       if (raw_res_spin_lock_irqsave(&stream->lock, flags))
> +               return -EDEADLK;
> +
> +       while (rem_len) {
> +               int pos =3D len - rem_len;
> +               bool cont;
> +
> +               node =3D bpf_stream_backlog_peek(stream);
> +               if (!node) {
> +                       bpf_stream_backlog_fill(stream);
> +                       node =3D bpf_stream_backlog_peek(stream);
> +               }
> +               if (!node)
> +                       break;
> +               elem =3D container_of(node, typeof(*elem), node);
> +
> +               cons_len =3D elem->consumed_len;
> +               cont =3D bpf_stream_consume_elem(elem, &rem_len) =3D=3D f=
alse;
> +
> +               ret =3D copy_to_user_nofault(buf + pos, elem->str + cons_=
len,
> +                                          elem->consumed_len - cons_len)=
;

_nofault() because res_spin_lock() is held, right?
But this is only called from sys_bpf. It's sleepable and faultable.
In v1 bpf_prog_stream_read() was callable from bpf prog, iirc,
but not anymore.
Let's use proper mutex and copy_to_user() ?

> +               /* Restore in case of error. */
> +               if (ret) {
> +                       elem->consumed_len =3D cons_len;
> +                       break;
> +               }
> +
> +               if (cont)
> +                       continue;
> +               bpf_stream_backlog_pop(stream);
> +               bpf_stream_release_capacity(stream, elem);
> +               bpf_stream_free_elem(elem);
> +       }
> +
> +       raw_res_spin_unlock_irqrestore(&stream->lock, flags);
> +       return ret ? ret : len - rem_len;
> +}
> +
> +int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id strea=
m_id, void __user *buf, int len)
> +{
> +       struct bpf_stream *stream;
> +
> +       stream =3D bpf_stream_get(stream_id, prog->aux);
> +       if (!stream)
> +               return -ENOENT;
> +       return bpf_stream_read(stream, buf, len);
> +}
> +
> +__bpf_kfunc_start_defs();
> +
> +/*
> + * Avoid using enum bpf_stream_id so that kfunc users don't have to pull=
 in the
> + * enum in headers.
> + */
> +__bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, =
const void *args, u32 len__sz, void *aux__prog)
> +{
> +       struct bpf_bprintf_data data =3D {
> +               .get_bin_args   =3D true,
> +               .get_buf        =3D true,
> +       };
> +       struct bpf_prog_aux *aux =3D aux__prog;
> +       u32 fmt_size =3D strlen(fmt__str) + 1;
> +       struct bpf_stream *stream;
> +       u32 data_len =3D len__sz;
> +       int ret, num_args;
> +
> +       stream =3D bpf_stream_get(stream_id, aux);
> +       if (!stream)
> +               return -ENOENT;
> +
> +       if (data_len & 7 || data_len > MAX_BPRINTF_VARARGS * 8 ||
> +           (data_len && !args))
> +               return -EINVAL;
> +       num_args =3D data_len / 8;
> +
> +       ret =3D bpf_bprintf_prepare(fmt__str, fmt_size, args, num_args, &=
data);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt__str, data.bin=
_args);
> +       /* If the string was truncated, we only wrote until the size of b=
uffer. */
> +       ret =3D min_t(u32, ret + 1, MAX_BPRINTF_BUF);
> +       ret =3D bpf_stream_push_str(stream, data.buf, ret);
> +       bpf_bprintf_cleanup(&data);
> +
> +       return ret;
> +}
> +
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(stream_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
> +BTF_KFUNCS_END(stream_kfunc_set)
> +
> +static const struct btf_kfunc_id_set bpf_stream_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set =3D &stream_kfunc_set,
> +};
> +
> +static int __init bpf_stream_kfunc_init(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_strea=
m_kfunc_set);
> +}
> +late_initcall(bpf_stream_kfunc_init);

let's avoid all these little initcall-s and individual
stream_kfunc_set-s.
Add bpf_stream_vprintk() to common_btf_ids[].

