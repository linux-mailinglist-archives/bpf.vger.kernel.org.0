Return-Path: <bpf+bounces-76778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7A3CC54F3
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 23:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B8953019B9C
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE940335565;
	Tue, 16 Dec 2025 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzQpX1o/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085762737E7
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765923154; cv=none; b=dCLdN+oEoJ46atjbk+EuI7YSD4e4gl6DzRua/lO/cVgO7VZr83ltPTFL7esRPScwJCPrJSV4SV8IPIgWNSxXneziqYeghIEnC2TD5o1Bx1GIcrF0z8ugCKksutgve9GdvHUPspK5lw+zyPxMcCjh/1HzhyapYeyEpjGdcUmhkKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765923154; c=relaxed/simple;
	bh=OaccuZ9PirhWuxNKIWTPw0fPGswGIUO3Skwm5Yk/LjM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l6cHSYsvd684hWoKzckt2+apvUYzL1jRuOhcWePr5n8baGr4gqI7S+ta0HWPgRXYOfqY3qJDf5rwQQNERM3bmA6cJ3hWFoAXbRUHwSIhX0okn5XK3W10mt61wUv5RS57RfQSnsyQyWGFyrSKamvwd6kBTGYPOxlBC24ubBdK2wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzQpX1o/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c213f7690so3544919a91.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 14:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765923152; x=1766527952; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rHQLIhejomuwtO/Yw632vMeFsVuUdUbSyvhg1ogyrHQ=;
        b=YzQpX1o/hyT9rr75h5lNUOHYrFNwiICjORk7dM22RVLCJuCkRn0plfiDy/zf1aF9pC
         Tc2bdAh6z9G5POV6nO2yoPGzy8OnxkDNdW13wD1N4LgniMsluPo0+fUIMppeDuFTjWjP
         9LfHbgu1qL1ALqVuhuNSY3r0sLznFdyx2oIusoSemJ57kYf29O/n+T37evfNwXUpk70r
         9SgDSVo0lbUHGccNEB3zJHy38fGuBOmWwpVPu4ZWLAxc+lYNa1Fh0lkdizq1oow5NaMf
         yVOOdSWuXxEq5nsPrBHJUB9fvPn9rVVvM9/9/lYBfigmCLt3fjx5n/mg14t/D0X9vWXa
         zVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765923152; x=1766527952;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHQLIhejomuwtO/Yw632vMeFsVuUdUbSyvhg1ogyrHQ=;
        b=nwMRapOGiuZm2D5PR8ZUdz2C5IKtfNYlM8l5w70OYtlhD4PSftprGwZdooIrH/hXxi
         CiiO1pUfrR9kxzTNFSX3ydZa+eBzoH7ypxk4OHq5M9hJitTB3H2p+Zarumq72/EHWuiE
         SSAsjwzMQUMsbOjwUB0KfQKJ4H2ZD6Sf9+4M1/HipRv1Jn1fLvAao7mkqpma1uDcihGp
         pHn2TaC1N/szavyAPsiVByZOC3clZd5EAwxDA2PmDMy1XEQml7Zen8mrWNnzMMumGNUz
         ug6Qapo/TOrMsmn5W8/TWSu/xnu37QiiaSYwtsl/zNs50uZRohejISnVQkFh+vjvnXHl
         gCLg==
X-Forwarded-Encrypted: i=1; AJvYcCXgMU5W/2rnY2hLCLDQ3Nyen/GMYMc13qNUGNoTBuWG5l6MvbbBCj8iMDHkU4xHKlYvbDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4qRNabpzVCLC9mOw2bWU7c3/TpfM78Z1zf194L7vF9G0Gppb6
	FlmS3xPR8wKoqpKZUIX3CrKgWNNYcr2Cu8ReBn8e6kEV5Ug0vlPllnxn
X-Gm-Gg: AY/fxX7FbDaS9zifDUo3eNM0BQDBrs7ncdjI1mdLnoREqDaMTsaO3mAma1jEf+s0afe
	qp/fa1mUidLcfTFZg5xXf++VXp/WVGG6SDfAmnnrEm4ba9yqEm/4A33IECmD2wrIHm0yHrMkoy+
	X4fvRV/zWHqxM1AXtFrh67w9K8qmNPu/BPXGs0eDFoMR0RfF0wz+OpYLgZ6xgCqdXO7KcooPj0S
	P9zBmnUWclnbcY6YeuEZQaOT5N31UNxXGubJxHHvA5/9VAT2fZCpMn0kC6uopLH/qTyFnlMxfvI
	MMUc1MP+fRX2otPqt0BkrjE1lYoS9Hm12UCttt6yziOxfb723wjqceuzhk1SWkIh4jnsOFY55p3
	MQnNRWRFiobDVydQY6KPhdBXamEN9NVvkFEaS3WVtpT5+B9y1r2+Ggcs9JYG1hkGpgIAeSgldHv
	M0TwxSdqej
X-Google-Smtp-Source: AGHT+IHjAX4LMj1cgeAoT7Quq+fplUPz2bk+tHlfVYFeABagGkK1H4ER75rmZ/i9WRnjjVmb3x+nWw==
X-Received: by 2002:a17:90b:1f85:b0:34c:3501:d118 with SMTP id 98e67ed59e1d1-34c3501d60dmr11752192a91.1.1765923152373;
        Tue, 16 Dec 2025 14:12:32 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cfda21fa2sm420743a91.13.2025.12.16.14.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 14:12:31 -0800 (PST)
Message-ID: <2355c9c8caeae5769828feac2ae46786df889aef.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 06/10] btf: support kernel parsing of BTF
 with kind layout
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 ast@kernel.org, 	daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 qmo@kernel.org, 	ihor.solodrai@linux.dev, dwarves@vger.kernel.org,
 bpf@vger.kernel.org, 	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Tue, 16 Dec 2025 14:12:29 -0800
In-Reply-To: <CAEf4Bza6=yBpM0QNrFt4MaBHNTCVxvMrE1Sj+eqHGbKh0CcBJQ@mail.gmail.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-7-alan.maguire@oracle.com>
	 <1351a3a944fab86e7fe1babf8b31cde4e722077e.camel@gmail.com>
	 <CAEf4BzbgjZfxUeB78D4u4LRzESsTSdzOgFJAkOqEoQcRWuS=2g@mail.gmail.com>
	 <87d08c49a65a951944e5b2254e605e3c4a064e50.camel@gmail.com>
	 <CAEf4Bza6=yBpM0QNrFt4MaBHNTCVxvMrE1Sj+eqHGbKh0CcBJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-16 at 14:09 -0800, Andrii Nakryiko wrote:
> On Tue, Dec 16, 2025 at 1:25=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Tue, 2025-12-16 at 13:21 -0800, Andrii Nakryiko wrote:
> > > On Mon, Dec 15, 2025 at 10:51=E2=80=AFPM Eduard Zingerman <eddyz87@gm=
ail.com> wrote:
> > > >=20
> > > > On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:
> > > >=20
> > > > If strict kind layout checks are the goal, would it make sense to
> > > > check sizes declared in kind_layout for known types?
> > > >=20
> > > > [...]
> > > >=20
> > > > > @@ -5215,23 +5216,36 @@ static s32 btf_check_meta(struct btf_veri=
fier_env *env,
> > > > >               return -EINVAL;
> > > > >       }
> > > > >=20
> > > > > -     if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
> > > > > -         BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> > > > > +     if (!btf_name_offset_valid(env->btf, t->name_off)) {
> > > > > +             btf_verifier_log(env, "[%u] Invalid name_offset:%u"=
,
> > > > > +                              env->log_type_id, t->name_off);
> > > > > +             return -EINVAL;
> > > > > +     }
> > > > > +
> > > > > +     if (BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> > > > >               btf_verifier_log(env, "[%u] Invalid kind:%u",
> > > > >                                env->log_type_id, BTF_INFO_KIND(t-=
>info));
> > > > >               return -EINVAL;
> > > > >       }
> > > > >=20
> > > > > -     if (!btf_name_offset_valid(env->btf, t->name_off)) {
> > > > > -             btf_verifier_log(env, "[%u] Invalid name_offset:%u"=
,
> > > > > -                              env->log_type_id, t->name_off);
> > > > > +     if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX && env->btf->kind=
_layout &&
> > > > > +         ((BTF_INFO_KIND(t->info) + 1) * sizeof(struct btf_kind_=
layout)) <
> > > > > +          env->btf->hdr.kind_layout_len) {
> > > > > +             btf_verifier_log(env, "[%u] unknown but required ki=
nd %u",
> > > > > +                              env->log_type_id,
> > > > > +                              BTF_INFO_KIND(t->info));
> > > > >               return -EINVAL;
> > > > > +     } else {
> > > > > +             if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
> > > > > +                     btf_verifier_log(env, "[%u] Invalid kind:%u=
",
> > > > > +                                      env->log_type_id, BTF_INFO=
_KIND(t->info));
> > > > > +                     return -EINVAL;
> > > > > +             }
> > > > > +             var_meta_size =3D btf_type_ops(t)->check_meta(env, =
t, meta_left);
> > > > > +             if (var_meta_size < 0)
> > > > > +                     return var_meta_size;
> > > > >       }
> > > > >=20
> > > > > -     var_meta_size =3D btf_type_ops(t)->check_meta(env, t, meta_=
left);
> > > > > -     if (var_meta_size < 0)
> > > > > -             return var_meta_size;
> > > > > -
> > > > >       meta_left -=3D var_meta_size;
> > > >=20
> > > > It appears that a smaller change here would achieve same results:
> > > >=20
> > > >     -        if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX ||
> > > >     +        u32 layout_kind_max =3D env->btf->hdr.kind_layout_len =
/ sizeof(struct btf_kind_layout);
> > > >     +        if (BTF_INFO_KIND(t->info) > layout_kind_max ||
> > > >                  BTF_INFO_KIND(t->info) =3D=3D BTF_KIND_UNKN) {
> > > >                      btf_verifier_log(env, "[%u] Invalid kind:%u",
> > > >                                       env->log_type_id, BTF_INFO_KI=
ND(t->info));
> > > >                      return -EINVAL;
> > > >              }
> > > >=20
> > > >     +        if (BTF_INFO_KIND(t->info) > BTF_KIND_MAX) {
> > > >     +                btf_verifier_log(env, "[%u] unknown but requir=
ed kind %u",
> > > >     +                                 env->log_type_id,
> > > >     +                                 BTF_INFO_KIND(t->info));
>=20
> hm... did you mean to have return -EINVAL here? Then it wouldn't let
> through anything that's not known to verifier.

Oops, yeap, I meant to return error here.
As Alan's original patch does.
Sorry for confusion.

[...]

