Return-Path: <bpf+bounces-67626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3D4B4658A
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA9D1C819B3
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106CF2C3770;
	Fri,  5 Sep 2025 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUDxgRVk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2754C284886
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107904; cv=none; b=MIqfV06/VSxmyr3Rt5VgHvE/YYiFNZRtwyLJDEkn2vbFX52EYNTSdlztCmSvr4pElLWgRIKtpFoDR2IUb+g1Y62BLG9W3eP4BfQ2W8ESLWYS4Hb02KG0ZNjELSAIzxUOXVaNIeI40LslibN6hsTOi5h7WmQ5MKOutZO5fHaPZkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107904; c=relaxed/simple;
	bh=svNfx3xuwzuPr987veBTN48mSZCjTHBTKfLMFuVJwmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fs9uRcRnPwawHhiU1YrN6Fk1clzRsxUMz82nCkmmBAq3KYKA/2ypeHuUKwUvqGed7/OQL0XPjN2ZvZx/xSoM1tjcWTUJmaWemyJGFRD8/UeUF3MvO9fqKWAPTTWiFaVKXYslTQZlnQIKlxm1Mr/Wv6EdUUDLbRk2zjebs8tcw0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUDxgRVk; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772301f8ae2so2306445b3a.0
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757107902; x=1757712702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtnScDWZaLPhHDNQI23lwWRAxSpOIG6w2SGMHhBcAxQ=;
        b=FUDxgRVkXdGam0iyCnvj8oOt6mnc4JEPBvAF/vW8rYKvilHWQjkwprMxJ9R3zzOsqL
         H5irgnnj+sj76SUv8qRrDMaWXZU+F4yKqJi5oDBVey9mDRG5sY6uB5CjA5lRJoE0b5gL
         tEytCMxOyxRGSp91qUlFfV5Br/5m+/fWwdJpFXoTKg11gwCyntmwFMJjrtqzqNPMgUlS
         c+nvGGL0zlN5B5k8jPFM56wsy2VgpfYfqCoGTw3L1cJ1ywDLdADvOTqYZXhLaEBpR1Dd
         kwrGUacNl8jryGe1Gc2N4a+d006dIuljMP1YfU5+vvaursCBY7gnun1akh22ckze4w8A
         wshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757107902; x=1757712702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EtnScDWZaLPhHDNQI23lwWRAxSpOIG6w2SGMHhBcAxQ=;
        b=kwyZ7HEkk+vc7OjxdK1/+W0lb1n7DtKDneA4Wp0Sg/q7919xr2B48hjkdyyJmcRIA0
         veCPmeQJJdVnA1UPDOkwVgRQS+bmZimjTz2ggMqnufJxkyF/ViTSbg6gWhNVTYQJLXXQ
         NwaE4a6b10a9JPl+XQOFAXmBy8IiEw8s2KVJwyiHdJHbGNoZeF0RXiDJ2f44eYiF1+Rv
         Rfc9mGP51y1riFJxNFPhY4miSNYPyba1JremAzO8asyE4PZALlXyb/G+hXP2VC76zvOV
         mm0xGGdARgwxuIcXYEIQl8ouSmnKSY4IeIgq2jWKKzTZ+3d03gSJFlvJU/cYKP4tpE15
         n0yw==
X-Gm-Message-State: AOJu0YzzUFaoTO7tGn9xrBWtDkOjNBMLjNYf+UFYtmnjsp8XMP/XqbYd
	JPN9D1LCypwlK/bEiCOh+9Iw4Anway2J6S+UpSiDxOdBYFm3oX3mulFE64mtZLImisITUDAwlIC
	a59GW7ymJjSQekaR5HhaGIlUi+ctAqUGoyg==
X-Gm-Gg: ASbGncvWvIa7Zj8O7fCQZkdjKoUEYjqQ2kPhLKQ1fkstCqk+Tr2hkBQnafkFSz2/N5E
	+hgwKqdeYYXHwPTmp7GPIs8dK6kqv0apobbgMD1h1IBcQ9PmaUR3FtN5vZXlX+xo2kK0Z8+RcFP
	RPsz2OzsJb1w9XuolXYWHPmF4aH2dIHCVZuiBvxh1PC7A2XcEYzx9DPbnWt7Aaj8PkZmbLK8xt/
	Kz1
X-Google-Smtp-Source: AGHT+IG2VOWaGoa+aolY/6ia6js2xr3HMwJo+HkeddQ6X5yErIMAjkMHx3IjyI2FhKcyMo4RYHO1mtRDQJLZGbAcAcM=
X-Received: by 2002:a17:902:e94f:b0:24a:fd5a:6b58 with SMTP id
 d9443c01a7336-251738ca0demr1411905ad.50.1757107902250; Fri, 05 Sep 2025
 14:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com> <20250905164508.1489482-4-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250905164508.1489482-4-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 5 Sep 2025 14:31:29 -0700
X-Gm-Features: Ac12FXzw55K26uH6eF1TwTJxZlweY0la9MqFBzwQpTBZpNXwRQVYFuxqoQxXP-8
Message-ID: <CAEf4Bzaxyw+jQw-_e-QkcufYZUqHmsugO_fiC2=9Uj4bdvJHpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/7] bpf: htab: extract helper for freeing
 special structs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	memxor@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 9:45=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Extract the cleanup of known embedded structs into the dedicated helper.
> Remove duplication and introduce a single source of truth for freeing
> special embedded structs in hashtab.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/hashtab.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>

lgtm

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 71f9931ac64c..2319f8f8fa3e 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -215,6 +215,16 @@ static bool htab_has_extra_elems(struct bpf_htab *ht=
ab)
>         return !htab_is_percpu(htab) && !htab_is_lru(htab) && !is_fd_htab=
(htab);
>  }
>
> +static void htab_free_internal_structs(struct bpf_htab *htab, struct hta=
b_elem *elem)
> +{
> +       if (btf_record_has_field(htab->map.record, BPF_TIMER))
> +               bpf_obj_free_timer(htab->map.record,
> +                                  htab_elem_value(elem, htab->map.key_si=
ze));
> +       if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
> +               bpf_obj_free_workqueue(htab->map.record,
> +                                      htab_elem_value(elem, htab->map.ke=
y_size));
> +}
> +
>  static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
>  {
>         u32 num_entries =3D htab->map.max_entries;
> @@ -227,12 +237,7 @@ static void htab_free_prealloced_timers_and_wq(struc=
t bpf_htab *htab)
>                 struct htab_elem *elem;
>
>                 elem =3D get_htab_elem(htab, i);
> -               if (btf_record_has_field(htab->map.record, BPF_TIMER))
> -                       bpf_obj_free_timer(htab->map.record,
> -                                          htab_elem_value(elem, htab->ma=
p.key_size));
> -               if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE)=
)
> -                       bpf_obj_free_workqueue(htab->map.record,
> -                                              htab_elem_value(elem, htab=
->map.key_size));
> +               htab_free_internal_structs(htab, elem);
>                 cond_resched();
>         }
>  }
> @@ -1502,12 +1507,7 @@ static void htab_free_malloced_timers_and_wq(struc=
t bpf_htab *htab)
>
>                 hlist_nulls_for_each_entry(l, n, head, hash_node) {
>                         /* We only free timer on uref dropping to zero */
> -                       if (btf_record_has_field(htab->map.record, BPF_TI=
MER))
> -                               bpf_obj_free_timer(htab->map.record,
> -                                                  htab_elem_value(l, hta=
b->map.key_size));
> -                       if (btf_record_has_field(htab->map.record, BPF_WO=
RKQUEUE))
> -                               bpf_obj_free_workqueue(htab->map.record,
> -                                                      htab_elem_value(l,=
 htab->map.key_size));
> +                       htab_free_internal_structs(htab, l);
>                 }
>                 cond_resched_rcu();
>         }
> --
> 2.51.0
>

