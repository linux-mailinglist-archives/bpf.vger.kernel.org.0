Return-Path: <bpf+bounces-76769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE46CC531C
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06C79301098C
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 21:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F5431076D;
	Tue, 16 Dec 2025 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUZXKB+3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35CE2F1FE4
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765920076; cv=none; b=frWsuTaGWeaFLbXovGn11mDdZYSJAyC/riN46DpRxVSOOPbGoozw4h1mbRN/btGeSLLKtZrNg//Hfowelb9KKjUzn3IAGWoDgUCMD7olWQjgba0urgByv9fHnV+t4u2S7IcmF/cdoik/4a9j5LoFDnCTa9+jNPuCc+axVsDVeF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765920076; c=relaxed/simple;
	bh=v95pH7bJavW1yy0EbAc0eMNauC38Nug89wS17zz4aTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQVXstE50/6wXafJuRVIi3Xdp39pth93GnqfhVkyWor1ss6CMYG2eOk+gkjNWBgoOabMpFoQ++4fsk8+5lHZB5b0hTKtEsovQNQNaRPtj7BM6WrDLrzRukOuV5Gtbx2CafXJnLWMjHyFECX5LEZyKMQ1mZctAFQIe4piKSUu87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUZXKB+3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0833b5aeeso54763435ad.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 13:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765920074; x=1766524874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4d6xbGDlPMkC8s0TB0glzVoxYsLUnwcjK38/9AA8CQ=;
        b=IUZXKB+3QrVUHYF83j8Z+1Gg2OIUodNA+U0dh5yuaDbwUrokfdAgIRwMzIb9wk4Xw5
         dh99SAJ+i63KmjUAR5hX5sEHRTirCjPAi37vdTlG/NDIei2YMloy3DuMkykqc9b/9Mus
         r6drbVU12JvI2Zp9fP2leqpnUAs5ZzeGbj6J/6bIQNTJq23hc+v5jpeoKJ8KezmEJo+r
         v/CPO3H8lEnWs46d0g6aFCd284rkSzZGyfuDbmDf5jzYc1P/AAipgYOhX07Vd9oBZ5B+
         FxI18tO87V+yH0+P+S2CF2uP/SKL1BsbcPGdFhbKKYdvzY1L7g0Obw2/KakDnvcofAsT
         EP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765920074; x=1766524874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+4d6xbGDlPMkC8s0TB0glzVoxYsLUnwcjK38/9AA8CQ=;
        b=M0Z+I8Pd18bESToC84hhFmczIjcAL9EgM55DvGs6Zcq2Gv+PoT8AXybd/WhPFrEwDz
         kOni5TtCv7gbYGLqi4+RHI+F8vVN+iQzC3xpZoo0cEeamJKF2x10TgDzVwtj8D/ZcdhF
         qk5vm2bhMVWmMXZ4rT8xBpQeUCUo+5uWJ5LmfFYYDgGaN1yk9UTlgjStiEbXgj2kmYfv
         EmAHZ0ZaPl8WPEA3dQBExRwaXwC0D4yoDj7XOd4o8ZbdxMpvkZlv2JPVS7TE/XSdGtTr
         58j5Tf5bw6lGzO6QEPlZ7mrdSE+ngcMl7zGn+8F5M+lLM/MKzGtmpkU6RJ0lR1Kq9CLm
         SwQw==
X-Forwarded-Encrypted: i=1; AJvYcCXjWy87tvTDbl9lcrzmCDnOkz8nhQDx8wfD/kVE2312i+xHrFgCsp1yTGzCJWP9vGkf4DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9d4J7IVisy8uSnhwUSuqshq8Lpk9IGWmpX/TQq+dWAGrPn0K
	5Xo7uVD5U7bohcj7CliYp3aPMjWr32f6DL7Fwv5GgABCRbkRiSVUez0fqUjspAD87QRwdsY/+xf
	hWO6kaCvvL0SHF+QdDYrqPiu5yronIFw=
X-Gm-Gg: AY/fxX4FDXBK0rNV+mN2NQpTRm6kuwz/RMHWiZuYCtdcHy8cJ8W0NgLXUxsm7mrL2Be
	VDztBFOr9x4kMGJTf/VIR4caotm6uamXJy/DQQKG7D7zCOC5f/OsdqXSsRG9GN95NZVS4TQQYVu
	Ocj6u/vuhUjq7rwuLWEy0snGw76SW9rmtAOjlFBBEVOoORbWCc3m3+U2zn/k2vVIZsJDma9ycwn
	nGP+xQTVLohwpqu7Vb2CWQYzcSDQMNZpfxtItFZ+Y8ZbXK0rYh3TJZU78kvKwCgJzTSqFFYeyKE
	oTfClxWDXpCLGK0FZQ7fXg==
X-Google-Smtp-Source: AGHT+IFoep0oLAG/nrLykz8n/8DsH0Rf9tEOMC+sONrcMBfUHwvXvS37ChpiBO4Oe8k8+8D0XWXWjiRrSp2eid8sHfY=
X-Received: by 2002:a17:902:f68e:b0:2a0:9081:8a6 with SMTP id
 d9443c01a7336-2a090810c7dmr138597295ad.20.1765920073876; Tue, 16 Dec 2025
 13:21:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-7-alan.maguire@oracle.com> <1351a3a944fab86e7fe1babf8b31cde4e722077e.camel@gmail.com>
In-Reply-To: <1351a3a944fab86e7fe1babf8b31cde4e722077e.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 13:21:01 -0800
X-Gm-Features: AQt7F2peW1lUI3AxV_2-Ru6CuffwHUb37ImNsAwgjVE87BodZ29bK-HPti6ZDIw
Message-ID: <CAEf4BzbgjZfxUeB78D4u4LRzESsTSdzOgFJAkOqEoQcRWuS=2g@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 06/10] btf: support kernel parsing of BTF with
 kind layout
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 10:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:
>
> If strict kind layout checks are the goal, would it make sense to
> check sizes declared in kind_layout for known types?
>
> [...]
>
> > @@ -5215,23 +5216,36 @@ static s32 btf_check_meta(struct btf_verifier_e=
nv *env,
> >               return -EINVAL;
> >       }
> >
> > -     if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
> > -         BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> > +     if (!btf_name_offset_valid(env->btf, t->name_off)) {
> > +             btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> > +                              env->log_type_id, t->name_off);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> >               btf_verifier_log(env, "[%u] Invalid kind:%u",
> >                                env->log_type_id, BTF_INFO_KIND(t->info)=
);
> >               return -EINVAL;
> >       }
> >
> > -     if (!btf_name_offset_valid(env->btf, t->name_off)) {
> > -             btf_verifier_log(env, "[%u] Invalid name_offset:%u",
> > -                              env->log_type_id, t->name_off);
> > +     if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->kind_layou=
t &&
> > +         ((BTF_INFO_KIND(t->info) + 1) * sizeof(struct btf_kind_layout=
)) <
> > +          env->btf->hdr.kind_layout_len) {
> > +             btf_verifier_log(env, "[%u] unknown but required kind %u"=
,
> > +                              env->log_type_id,
> > +                              BTF_INFO_KIND(t->info));
> >               return -EINVAL;
> > +     } else {
> > +             if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
> > +                     btf_verifier_log(env, "[%u] Invalid kind:%u",
> > +                                      env->log_type_id, BTF_INFO_KIND(=
t->info));
> > +                     return -EINVAL;
> > +             }
> > +             var_meta_size =3D btf_type_ops(t)->check_meta(env, t, met=
a_left);
> > +             if (var_meta_size < 0)
> > +                     return var_meta_size;
> >       }
> >
> > -     var_meta_size =3D btf_type_ops(t)->check_meta(env, t, meta_left);
> > -     if (var_meta_size < 0)
> > -             return var_meta_size;
> > -
> >       meta_left -=3D var_meta_size;
>
> It appears that a smaller change here would achieve same results:
>
>     -        if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
>     +        u32 layout_kind_max =3D env->btf->hdr.kind_layout_len / size=
of(struct btf_kind_layout);
>     +        if (BTF_INFO_KIND(t->info) > layout_kind_max ||
>                  BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
>                      btf_verifier_log(env, "[%u] Invalid kind:%u",
>                                       env->log_type_id, BTF_INFO_KIND(t->=
info));
>                      return -EINVAL;
>              }
>
>     +        if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
>     +                btf_verifier_log(env, "[%u] unknown but required kin=
d %u",
>     +                                 env->log_type_id,
>     +                                 BTF_INFO_KIND(t->info));
>     +        }
>     +
>              if (!btf_name_offset_valid(env->btf, t->name_off)) {
>                      btf_verifier_log(env, "[%u] Invalid name_offset:%u",
>                                       env->log_type_id, t->name_off);
>
> wdyt?
>
> But tbh, the "unknown but required kind" message seems unnecessary,
>

Hm.. Do I understand that this patch will actually allow uploading BTF
with some kinds that are unknown to the kernel? I don't think we
should allow this. If the kernel sees a kind that it knows nothing
about, it should reject the BTF. libbpf will sanitize such BTF so that
the host kernel never sees unknown/unsupported BTF kind.

I think doing layout info validation is a good thing, I'd keep it, but
having layout information is not a substitute for kernel knowing full
semantics of the kind. Let's not relax kernel-side validation for BTF.

> >
> >       return saved_meta_left - meta_left;
> > @@ -5405,7 +5419,8 @@ static int btf_parse_str_sec(struct btf_verifier_=
env *env)
> >       start =3D btf->nohdr_data + hdr->str_off;
> >       end =3D start + hdr->str_len;
> >
> > -     if (end !=3D btf->data + btf->data_size) {
> > +     if (hdr->hdr_len < sizeof(struct btf_header) &&
> > +         end !=3D btf->data + btf->data_size) {
>
> Given that btf_check_sec_info() checks for overlap and total size,
> is this check needed at all?
>
> >               btf_verifier_log(env, "String section is not at the end")=
;
> >               return -EINVAL;
> >       }
>
> [...]

