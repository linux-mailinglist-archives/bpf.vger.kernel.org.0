Return-Path: <bpf+bounces-35423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA6A93A808
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 22:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CFC282911
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 20:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB2B142904;
	Tue, 23 Jul 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVPSx1Pd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1A7200A3;
	Tue, 23 Jul 2024 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721766081; cv=none; b=lwvM6MP/sUcO4J1bUf4XzF8FyAzHck1lOTSWja1aHgr8gSias6grBKPg3rb7rEp3zNRi/6VSN0fGeNcHQQxWbkh+eWLNOHQssHOi4WL+olk5EWr/w3yQ2c18XuWtRS5Cf8QsBQ7fTgG8hJavDD5kebUF+5z8ZhE2jPMlun+Yefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721766081; c=relaxed/simple;
	bh=Pt3uFSgWJ6KLhpyK3RKrW9ugEZ5a1HGJna6LZTdzawI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvHJR/+LbzXal20gWrf6CLjVKIdV1aR4VQ0LKkg1Osxmg9EBM7aL0gG3zXrw7NpDUvYBg7uicXKryIQapinb3R4Fec6QMUa1ObQda+FxZg7iGXqmYn/AOrAzDLnURen4Af7z4YV702oui3dU5Sdk6pXQyO/bWE6j8Qz6Ytn1A9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVPSx1Pd; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7163489149eso776487a12.1;
        Tue, 23 Jul 2024 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721766079; x=1722370879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJyDM4wQfFKSMWcLXZeJUEzkFAjb6no6gH2lHgUbiY0=;
        b=NVPSx1PdG7RrVsxcXvUrlv7k0FkEk550N7q61TG7sp+3x+bzYXU0QYR6+8rKAF2OFn
         hZgiyPnzhPSK4+VhrR7prnYzkSSJyQgTLlx9yIbxbVhW2u2dypXBHp4jPBHQKViwkFO+
         7t5s24G/xWT9H80d95+Hme1ua8ltL7PrQuRpdIB+H8cGIMGoNNB5c9yxe0vjQD/XjuWm
         L685MkQrNEXoljUtsDCJ5T/Lz/eA0BfbmiJUaSLY6aFhwyu4pj5/BeCNepdsu4JV9VEE
         YY7SfGktOEQNPPNhxuqpmZXOF+njM9zPWowe29JWx9NTgrABhe/3l40J9zNBkQ6DlJEz
         1CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721766079; x=1722370879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJyDM4wQfFKSMWcLXZeJUEzkFAjb6no6gH2lHgUbiY0=;
        b=L0S22dNYtrHwMdtTh9ers38NBBfiYqcWL/WA+R4GuMdT27UvkEHM/BwYYOcek+QIk9
         sj/x0rhafHlPqP/I8ERd8sgp3Trls+jGwFjRJGhbpraMVQMFt0nrLFWS1gzkHgZatXQ0
         +hfpSezgu/+sDqEEh/KXgfrYHSIQoaYNSGPIV96cvbGUE4ve+YpPB4W7MFx9SQh3i1lw
         bCd3abJuMbELwCzT3WDwW5pFKS0IRBoNrU0oYNYjXY2FKk2HBUqEVwJ6JmTF1p5msgld
         oPQyAm1BVbZ3f1g2N8MMvtf3qECH+7LmndoFmsgYRD+B90DNXDen3SjAHjYU7B/r25tx
         KSmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWulgbP9ax+4aiJzLQApZ3WLxrPvcwVqRoqMhGCW5TXT7LcLW9lTLqqliv6+uFX0W1V5P6pM5VWokne0sQVnu8g+R6oha/AKSjLGlV0iH2VGiu8EwmG/JsVImPrBZAQllsiH8amlTL3AaOJTa2L6BDHGtaVAPy4MNIz
X-Gm-Message-State: AOJu0YxqqlEv1aNcH2F7CrsczDGYXlPKYZIS5IVPKLeKv2pYqDun4zns
	wNvOiWiqycgo3vTxIbaPsu7p9ONM34C04RuHBWp5FT72nZ6+M6zJVvshkQL7xCbggDEmxRrMwmE
	Kn7qge90cHRsea9y3jvVK9fZtw0Y=
X-Google-Smtp-Source: AGHT+IGL3d+M4dMSuvaqoEPboHV3fl9FqNDxyQuBbU+HXcKCsU2Gy+XRKbmrR1dsx6slDGVJ/c4/EBEIN25wzwQ97Fs=
X-Received: by 2002:a17:90b:1a90:b0:2c9:9f2a:2b20 with SMTP id
 98e67ed59e1d1-2cdae340828mr953429a91.22.1721766078990; Tue, 23 Jul 2024
 13:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQKE1Xmjhx3Xwdidmmn=BGzjgc89i+UMhHR7=6HupPQZSA@mail.gmail.com>
 <20240723071031.3389423-1-asavkov@redhat.com>
In-Reply-To: <20240723071031.3389423-1-asavkov@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jul 2024 13:21:07 -0700
Message-ID: <CAEf4BzbYwBhpAXFkpbzd18gK=hM0mXpLcS7ZAHeoP-ECa9wi1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: fix compilation failure when CONFIG_NET_FOU!=y
To: Artem Savkov <asavkov@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 12:10=E2=80=AFAM Artem Savkov <asavkov@redhat.com> =
wrote:
>
> Without CONFIG_NET_FOU bpf selftests are unable to build because of
> missing definitions. Add ___local versions of struct bpf_fou_encap and
> enum bpf_fou_encap_type to fix the issue.
>
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
>
> ---
> v3: swith from using BPF_NO_KFUNC_PROTOTYPES to casting to keep kfunc
> prototype intact.
>
> v2: added BPF_NO_KFUNC_PROTOTYPES define to avoid issues when
> CONFIG_NET_FOU is set.
> ---
>  .../selftests/bpf/progs/test_tunnel_kern.c    | 26 ++++++++++++++-----
>  1 file changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools=
/testing/selftests/bpf/progs/test_tunnel_kern.c
> index 3f5abcf3ff136..fcff3010d8a60 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -26,6 +26,18 @@
>   */
>  #define ASSIGNED_ADDR_VETH1 0xac1001c8
>
> +struct bpf_fou_encap___local {
> +       __be16 sport;
> +       __be16 dport;
> +};
> +
> +enum bpf_fou_encap_type___local {
> +       FOU_BPF_ENCAP_FOU___local,
> +       FOU_BPF_ENCAP_GUE___local,
> +};

both of the above are internal kernel types (not UAPI ones), so I
added preserve_access_index to the struct and ...

> +
> +struct bpf_fou_encap;
> +
>  int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
>                           struct bpf_fou_encap *encap, int type) __ksym;
>  int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
> @@ -745,7 +757,7 @@ SEC("tc")
>  int ipip_gue_set_tunnel(struct __sk_buff *skb)
>  {
>         struct bpf_tunnel_key key =3D {};
> -       struct bpf_fou_encap encap =3D {};
> +       struct bpf_fou_encap___local encap =3D {};
>         void *data =3D (void *)(long)skb->data;
>         struct iphdr *iph =3D data;
>         void *data_end =3D (void *)(long)skb->data_end;
> @@ -769,7 +781,8 @@ int ipip_gue_set_tunnel(struct __sk_buff *skb)
>         encap.sport =3D 0;
>         encap.dport =3D bpf_htons(5555);
>
> -       ret =3D bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_GUE);
> +       ret =3D bpf_skb_set_fou_encap(skb, (struct bpf_fou_encap *)&encap=
,
> +                                   FOU_BPF_ENCAP_GUE___local);
>         if (ret < 0) {
>                 log_err(ret);
>                 return TC_ACT_SHOT;
> @@ -782,7 +795,7 @@ SEC("tc")
>  int ipip_fou_set_tunnel(struct __sk_buff *skb)
>  {
>         struct bpf_tunnel_key key =3D {};
> -       struct bpf_fou_encap encap =3D {};
> +       struct bpf_fou_encap___local encap =3D {};
>         void *data =3D (void *)(long)skb->data;
>         struct iphdr *iph =3D data;
>         void *data_end =3D (void *)(long)skb->data_end;
> @@ -806,7 +819,8 @@ int ipip_fou_set_tunnel(struct __sk_buff *skb)
>         encap.sport =3D 0;
>         encap.dport =3D bpf_htons(5555);
>
> -       ret =3D bpf_skb_set_fou_encap(skb, &encap, FOU_BPF_ENCAP_FOU);
> +       ret =3D bpf_skb_set_fou_encap(skb, (struct bpf_fou_encap *)&encap=
,
> +                                   FOU_BPF_ENCAP_FOU___local);


use bpf_core_enum_value() here for getting enum value in CO-RE-relocatable =
way

(also fixed spaces vs tabs issue that were pointed out)

pushed to bpf-next


>         if (ret < 0) {
>                 log_err(ret);
>                 return TC_ACT_SHOT;
> @@ -820,7 +834,7 @@ int ipip_encap_get_tunnel(struct __sk_buff *skb)
>  {
>         int ret;
>         struct bpf_tunnel_key key =3D {};
> -       struct bpf_fou_encap encap =3D {};
> +       struct bpf_fou_encap___local encap =3D {};
>
>         ret =3D bpf_skb_get_tunnel_key(skb, &key, sizeof(key), 0);
>         if (ret < 0) {
> @@ -828,7 +842,7 @@ int ipip_encap_get_tunnel(struct __sk_buff *skb)
>                 return TC_ACT_SHOT;
>         }
>
> -       ret =3D bpf_skb_get_fou_encap(skb, &encap);
> +       ret =3D bpf_skb_get_fou_encap(skb, (struct bpf_fou_encap *)&encap=
);
>         if (ret < 0) {
>                 log_err(ret);
>                 return TC_ACT_SHOT;
> --
> 2.45.2
>

