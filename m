Return-Path: <bpf+bounces-59456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE73ACBC62
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 22:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F911647A9
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5932C1A317A;
	Mon,  2 Jun 2025 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4KAhIBJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B9A1CA81
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 20:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748896774; cv=none; b=jo9dAWEc6t2B/uLRa8FYPQaKytLSS8rFXEro3YkJibSz72b5+CZergI6cWcJAyjlx+VQnSoEIV3TfmnXVEAj2x3ZGtSMVVZIoM9sDMXCsSv9ohFyKnPvuzzgxpsr76gnkFJJI4F5Hmxp/DnLc+U/kZV1fjUv8qPiGq83x4Gp0ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748896774; c=relaxed/simple;
	bh=UyOoCmM3kdmEAp6+yh5OZODOEJzRZ9v/Qx5arc3BSPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TG0K0MiZr8dj0VGlBVKDTa47kusWP+rxJoSGEHz4zwHymj5jXoNfXykaRIwDEWCmo9kYfBgsJOqys82092TpJdEly7Pp49k6mX97GyorllW/ki1EZ38yoMK51CwTXAhR66CFe2ChOiesi1+7wq2nUWeaktYEIrkNZ1wi92vntG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4KAhIBJ; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-60462e180e2so10264701a12.2
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 13:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748896769; x=1749501569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZs/00fI9oofbJZ/gahq0LzmsEeVWVowhjMZ3tNez2U=;
        b=g4KAhIBJCjepp0jK+l4evlVoRNUYuGdfNW1NA/PiYUm1n5GAkfx4mrg6LbrxD7SSH5
         dQsrEQCozUp7sDe1IWeIvy5eEhWMOefVX5N6ZayA3H6cdP9WmQ9DijNLiI4NbxoZGCbb
         Tk1kvrg9yVhoT0x7p8X+3pUq+PkUnVgW21btsIjUnyoRvK5njyhJjLpwiuvSS38w/Qt6
         DZIy3fOjNmFYq0/QzjBfY9QepaSsrK/lt/K/Wl01OYixKnsuu94G2t+Xejl9Yd5T0njL
         R7jJ9Szw3olG/TvCK88N+1Fglmv0vyDyrjiJ9K32A2WkOIEmQuAl2TVXxxnSdkYox8WJ
         7xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748896769; x=1749501569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZs/00fI9oofbJZ/gahq0LzmsEeVWVowhjMZ3tNez2U=;
        b=uDqGdX0+b6hBFXpNWFnDr4dAH+wGf/oWFI4bUXpmxnadH+RUw408KZDRL4Ge9j2LZe
         4MkJpGreEjnBESKPzDpjuU7V6rEKpkwWS/JB1xpzE8gEJ+xqIp+TfTa4V0IAQAJu9FYE
         iXYZWXYxldy9et9dZVgKa4iFg+ReJ8r9NDyw7oHxRKkv4EE6ytrfwnNte9IOZxdzc/00
         Ic+YiAx9PdiMfmJOIVbl7x937/L//woEoUq0ggK09zEKfkuAq2eIGU2fLCDDzsD1Imgq
         vxpxbLPy3yfTz78Sqm5i7qrdbmCzjqGyhhT7+0vKmL9hrOHo1Du45aen+Me2X3Gr3cmC
         ldUg==
X-Gm-Message-State: AOJu0YxVSXCwNOnBDZhfzRMDnFOuQs7EE6H2Q1Je5NwhPy3ncg1p6jdv
	U6G8elgzF29/QV9kCnRz4ToMERydTRUaJtRh/tlFi+enKTANs9k6AL2pW5opNZRyi01bxyvzA/n
	b/veDkTzbfKODlxNlyFtB3/416bKz3PItrBxx
X-Gm-Gg: ASbGncswkbvmsDJSiaXmkgMcrTRBfKbV2MFDRYDmgbjZx7JKhNtiH5hDWjRVHUtnNPH
	0rndaD5PHGdH17k7B+1TgkAl1JhZxw/C6nLFtcEgvqkglVL4FrNGu6KyrcshGVMvMDuwxiuELF9
	kM5IoKZYUcFu5duWZ0wX/myZ+03Js2oG6tyuKv3HFzK0/2Vf2Bi7fy8CiCVTr4TxfiCUCuqMZvp
	yCw4Q==
X-Google-Smtp-Source: AGHT+IFwGtxmYOPjfv9fapKFelbdrw+tl32KrYCIPv75CB7em01Ix6hArNuBcpH3QSfYAAcmIrLD5cqYvNqwYKenBTk=
X-Received: by 2002:a17:907:7241:b0:ad5:27f5:717c with SMTP id
 a640c23a62f3a-adb36b057cemr1361667566b.10.1748896298758; Mon, 02 Jun 2025
 13:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-2-memxor@gmail.com>
 <CAADnVQ+T3Srjvcx0PQjVE9BUg0PKwrv22QDnkLjiaROrm=ggjA@mail.gmail.com>
In-Reply-To: <CAADnVQ+T3Srjvcx0PQjVE9BUg0PKwrv22QDnkLjiaROrm=ggjA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 2 Jun 2025 22:31:02 +0200
X-Gm-Features: AX0GCFv9sBZW41orCdwRpMdDpilPvzlZAaOaOuL-WXY1VOVIuFR45NBWVifxqN0
Message-ID: <CAP01T74kVhSH7U65npPqHcQHG-_p5sSY6Y7Ci1D9n_A+zX9h9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/11] bpf: Introduce BPF standard streams
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Jun 2025 at 22:07, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, May 23, 2025 at 6:18=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> >         for (i =3D 0; i < aux->real_func_cnt; i++) {
> > +#ifdef CONFIG_BPF_SYSCALL
> > +               /* Ensure we don't push to subprog lists. */
> > +               if (bpf_is_subprog(aux->func[i])) {
> > +                       WARN_ON_ONCE(!llist_empty(&aux->func[i]->aux->s=
tream[0].log));
> > +                       WARN_ON_ONCE(!llist_empty(&aux->func[i]->aux->s=
tream[1].log));
> > +               }
>
> Why check for subprogs only ?
>

Stream elements should only be populated for main progs, so it would
be a bug if we did it for subprogs.
I guess I can drop it.

>
> > -/* Per-cpu temp buffers used by printf-like helpers to store the bprin=
tf binary
> > - * arguments representation.
> > - */
> > -#define MAX_BPRINTF_BIN_ARGS   512
> > -
> >  /* Support executing three nested bprintf helper calls on a given CPU =
*/
> >  #define MAX_BPRINTF_NEST_LEVEL 3
> > -struct bpf_bprintf_buffers {
> > -       char bin_args[MAX_BPRINTF_BIN_ARGS];
> > -       char buf[MAX_BPRINTF_BUF];
> > -};
>
> Pls split the refactor into another patch.

Ack.

>
> > +static int bpf_stream_read(struct bpf_stream *stream, void __user *buf=
, int len)
> > +{
> > +       int rem_len =3D len, cons_len, ret =3D 0;
> > +       struct bpf_stream_elem *elem =3D NULL;
> > +       struct llist_node *node;
> > +       unsigned long flags;
> > +
> > +       if (raw_res_spin_lock_irqsave(&stream->lock, flags))
> > +               return -EDEADLK;
> > +
> > +       while (rem_len) {
> > +               int pos =3D len - rem_len;
> > +               bool cont;
> > +
> > +               node =3D bpf_stream_backlog_peek(stream);
> > +               if (!node) {
> > +                       bpf_stream_backlog_fill(stream);
> > +                       node =3D bpf_stream_backlog_peek(stream);
> > +               }
> > +               if (!node)
> > +                       break;
> > +               elem =3D container_of(node, typeof(*elem), node);
> > +
> > +               cons_len =3D elem->consumed_len;
> > +               cont =3D bpf_stream_consume_elem(elem, &rem_len) =3D=3D=
 false;
> > +
> > +               ret =3D copy_to_user_nofault(buf + pos, elem->str + con=
s_len,
> > +                                          elem->consumed_len - cons_le=
n);
>
> _nofault() because res_spin_lock() is held, right?
> But this is only called from sys_bpf. It's sleepable and faultable.
> In v1 bpf_prog_stream_read() was callable from bpf prog, iirc,
> but not anymore.
> Let's use proper mutex and copy_to_user() ?

Yes, will do.

>
> > +               /* Restore in case of error. */
> > +               if (ret) {
> > +                       elem->consumed_len =3D cons_len;
> > +                       break;
> > +               }
> > +
> > +               if (cont)
> > +                       continue;
> > +               bpf_stream_backlog_pop(stream);
> > +               bpf_stream_release_capacity(stream, elem);
> > +               bpf_stream_free_elem(elem);
> > +       }
> > +
> > +       raw_res_spin_unlock_irqrestore(&stream->lock, flags);
> > +       return ret ? ret : len - rem_len;
> > +}
> > +
> > +int bpf_prog_stream_read(struct bpf_prog *prog, enum bpf_stream_id str=
eam_id, void __user *buf, int len)
> > +{
> > +       struct bpf_stream *stream;
> > +
> > +       stream =3D bpf_stream_get(stream_id, prog->aux);
> > +       if (!stream)
> > +               return -ENOENT;
> > +       return bpf_stream_read(stream, buf, len);
> > +}
> > +
> > +__bpf_kfunc_start_defs();
> > +
> > +/*
> > + * Avoid using enum bpf_stream_id so that kfunc users don't have to pu=
ll in the
> > + * enum in headers.
> > + */
> > +__bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str=
, const void *args, u32 len__sz, void *aux__prog)
> > +{
> > +       struct bpf_bprintf_data data =3D {
> > +               .get_bin_args   =3D true,
> > +               .get_buf        =3D true,
> > +       };
> > +       struct bpf_prog_aux *aux =3D aux__prog;
> > +       u32 fmt_size =3D strlen(fmt__str) + 1;
> > +       struct bpf_stream *stream;
> > +       u32 data_len =3D len__sz;
> > +       int ret, num_args;
> > +
> > +       stream =3D bpf_stream_get(stream_id, aux);
> > +       if (!stream)
> > +               return -ENOENT;
> > +
> > +       if (data_len & 7 || data_len > MAX_BPRINTF_VARARGS * 8 ||
> > +           (data_len && !args))
> > +               return -EINVAL;
> > +       num_args =3D data_len / 8;
> > +
> > +       ret =3D bpf_bprintf_prepare(fmt__str, fmt_size, args, num_args,=
 &data);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt__str, data.b=
in_args);
> > +       /* If the string was truncated, we only wrote until the size of=
 buffer. */
> > +       ret =3D min_t(u32, ret + 1, MAX_BPRINTF_BUF);
> > +       ret =3D bpf_stream_push_str(stream, data.buf, ret);
> > +       bpf_bprintf_cleanup(&data);
> > +
> > +       return ret;
> > +}
> > +
> > +__bpf_kfunc_end_defs();
> > +
> > +BTF_KFUNCS_START(stream_kfunc_set)
> > +BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
> > +BTF_KFUNCS_END(stream_kfunc_set)
> > +
> > +static const struct btf_kfunc_id_set bpf_stream_kfunc_set =3D {
> > +       .owner =3D THIS_MODULE,
> > +       .set =3D &stream_kfunc_set,
> > +};
> > +
> > +static int __init bpf_stream_kfunc_init(void)
> > +{
> > +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_str=
eam_kfunc_set);
> > +}
> > +late_initcall(bpf_stream_kfunc_init);
>
> let's avoid all these little initcall-s and individual
> stream_kfunc_set-s.
> Add bpf_stream_vprintk() to common_btf_ids[].

Ok, I will move it there.

