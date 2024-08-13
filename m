Return-Path: <bpf+bounces-37079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E625950C97
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 20:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0542828AC
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FC71A3BCB;
	Tue, 13 Aug 2024 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNLzBdKW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35BA1A3BA1;
	Tue, 13 Aug 2024 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575435; cv=none; b=CNyvH/ElhzLwiJvjb028xxbJbf7HsikdV5XXWQ2dYOjrgN42caWz5aEuNsJYL/EapqpFLvmwL0uUKEwDIMx1kRT/WmuVEVSEoEnEsNt8om4KL8b5yjEA9jI9nOblbqROuo7Atg2DJgXNXM9k1cTU1mNBXd7farGsrA1ATXl3eT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575435; c=relaxed/simple;
	bh=hsDRGSZavoBkdTKOpuMk5FH3U9tMNLeSXuRfAQgKNH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5lvUyRT3eDNVSViPNAcpPVWWKc4ztD2oDqZ/JsSTxxedW3PlvtwR1Y01tcDqrfGWNkw0VWhkRWUriojqQw0CjiD7+CVzc/AIvfOi6RPVQNt530i3n3zVcRnw6/2RNAMT4+JI7x1YnfIL8jn8J7P5g1VlKbi1cLVZ64G9PrWv4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNLzBdKW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so45649195e9.1;
        Tue, 13 Aug 2024 11:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723575432; x=1724180232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EsyF9yVNXaGRK+KEfGb2DvjXtKBRwmFv07/hgz6QAk=;
        b=kNLzBdKWLkLpx6Fq2byuoskTEXBPf2bcJvVG3gBz67vvW0ntddjR9i9AzqPJNLCqMj
         5viaYDD7BtRe8iCW98VU3tvw65jkf+B5FWV/TYmA8ylxvExt/6mkaAxALgliOpuHwgFg
         ymNoKwA9OL5/jRHsB7Mr48ybkB3tNUGCatUAKsvJmf89ItLR6X030Dkve2bR3odgurCj
         rAib82vxiYsXqyxOS+EdtmomNY+RipbWv0GgxgQV1R2qXfnJ+aWEszUn/VNjoMR1YqaL
         0dcwqP16/e9M6f/AnQdAbhoSz9RaLAdeRrIZ7GWJkRt2SWGrAPj37ymHNG+VznmBawNB
         JuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723575432; x=1724180232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EsyF9yVNXaGRK+KEfGb2DvjXtKBRwmFv07/hgz6QAk=;
        b=UVxHbMG8gMS990STU70lRg7PEwx33zdrCr7J/V/lpb5j3Zh1RkP3ZqEpbnXT7awMm7
         midEJl0fDePyxDnWmKHFvIpkhmKvVGERPfpijKnjWh1cF8ALtsqbW0I6JcSF6VHa3mWL
         ZBfFXuBTMgOnbOAn85NadPIlKwVtC4HnqZmjv/OcMu8L3GgOeUOhigIgrUrZshWiK+0X
         fTx/3WtP9ASBoRJzHkixUIeYfQSjhMU8C+1ezCZVSIVik2hb2f1LCn3G9fQeXyoba3BJ
         ySwlRq2YG7oB4YW6rjlHXlUbJWxoDQaqFlwjtE8m8tfX/wGhGVJN7+1NyzbV7PZBo8V0
         cgxw==
X-Forwarded-Encrypted: i=1; AJvYcCWzdow6+vWTR1Ed2TDMTdgX9dTjXEfh5d5Zq/XmzFeUqrzicMwtzSIRod5om/NuyYaWPBkCZBIENFJ7L6B31H/QxkjM4okKfKHPOebqJFnyNF0pum3LwSbgEs+R6VsfkpGeriuzVOZOSuyKg+LuRG587XfNJiv+cc3+T2YQ0FipyvN9
X-Gm-Message-State: AOJu0YyB+FGeu5EEvpkz+P5gEVtjhaNA6cjFdetX2+pTxL4VRBuE1TdY
	v7lhIieN88r43yMnCu1ddr3QXC2qKMbHdV/PP0VCoZitcCrLwiPTBIHiVeNVYRLpBp7oCOvAPD6
	5erFF0R9LZLhc1GBc//xxFesq8Mw=
X-Google-Smtp-Source: AGHT+IEeA+u2C8HDsmRyCPGG/cPhZrlEpCc1wvAnTbgxCK6YiznAOJ9G8dYU+J2JrtpXIcDrafHNxDeCUDbx+yjeByw=
X-Received: by 2002:a05:600c:1989:b0:426:5b3a:96c with SMTP id
 5b1f17b1804b1-429dd264eb0mr2878255e9.28.1723575431828; Tue, 13 Aug 2024
 11:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813151752.95161-2-thorsten.blum@toblux.com>
 <CAADnVQKEgG5bXvLMLYupAZO6xahWHU7mc06KFfseNoYUvoJbRQ@mail.gmail.com> <2A7DB1E6-4CCE-446E-B6F1-4A99D3F87B57@toblux.com>
In-Reply-To: <2A7DB1E6-4CCE-446E-B6F1-4A99D3F87B57@toblux.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Aug 2024 11:57:00 -0700
Message-ID: <CAADnVQKw5x6sTwj62p4vxSqtjdisHEKhtKdPp_zK4t7rtDuWhQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Annotate struct bpf_cand_cache with __counted_by()
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 10:59=E2=80=AFAM Thorsten Blum <thorsten.blum@toblu=
x.com> wrote:
>
> On 13. Aug 2024, at 18:28, Alexei Starovoitov <alexei.starovoitov@gmail.c=
om> wrote:
> > On Tue, Aug 13, 2024 at 8:19=E2=80=AFAM Thorsten Blum <thorsten.blum@to=
blux.com> wrote:
> >>
> >> Add the __counted_by compiler attribute to the flexible array member
> >> cands to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> >> CONFIG_FORTIFY_SOURCE.
> >>
> >> Increment cnt before adding a new struct to the cands array.
> >
> > why? What happens otherwise?
>
> If you try to access cands->cands[cands->cnt] without incrementing
> cands->cnt first, you're essentially accessing the array out of bounds
> which will fail during runtime.

What kind of error/warn do you see ?
Is it runtime or compile time?

Is this the only place?
what about:
        new_cands =3D kmemdup(cands, sizeof_cands(cands->cnt), GFP_KERNEL);

cnt field gets copied with other fields.
Can compiler/runtime catch that?

> You can read more about it at [1] and [2].
>
> > Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> >> ---
> >> kernel/bpf/btf.c | 6 +++---
> >> 1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> >> index 520f49f422fe..42bc70a56fcd 100644
> >> --- a/kernel/bpf/btf.c
> >> +++ b/kernel/bpf/btf.c
> >> @@ -7240,7 +7240,7 @@ struct bpf_cand_cache {
> >>        struct {
> >>                const struct btf *btf;
> >>                u32 id;
> >> -       } cands[];
> >> +       } cands[] __counted_by(cnt);
> >> };
> >>
> >> static DEFINE_MUTEX(cand_cache_mutex);
> >> @@ -8784,9 +8784,9 @@ bpf_core_add_cands(struct bpf_cand_cache *cands,=
 const struct btf *targ_btf,
> >>                memcpy(new_cands, cands, sizeof_cands(cands->cnt));
> >>                bpf_free_cands(cands);
> >>                cands =3D new_cands;
> >> -               cands->cands[cands->cnt].btf =3D targ_btf;
> >> -               cands->cands[cands->cnt].id =3D i;
> >>                cands->cnt++;
> >> +               cands->cands[cands->cnt - 1].btf =3D targ_btf;
> >> +               cands->cands[cands->cnt - 1].id =3D i;
> >>        }
> >>        return cands;
> >> }
> >> --
> >> 2.46.0
> >>
>
> [1] https://opensource.googleblog.com/2024/07/bounds-checking-flexible-ar=
ray-members.html
> [2] https://embeddedor.com/blog/2024/06/18/how-to-use-the-new-counted_by-=
attribute-in-c-and-linux/

