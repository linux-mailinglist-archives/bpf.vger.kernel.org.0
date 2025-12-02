Return-Path: <bpf+bounces-75902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E86C9C66A
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 18:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68E53A5A2D
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B012BEFE0;
	Tue,  2 Dec 2025 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huZ5mDda"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C8228468D
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696730; cv=none; b=FZGTd3zhha6PPbhkmHwB4JsIxVewqOvqrURFEHRn+bn4Gg2NjEcDrLZDTX7wOaozvPyRDfFHik/PHgXh8yyYwB6ugbTJfbrm0fU+S/BRzQdYCm21f1skJzQ3VYmtFqy14Gw9Fp5+n97ok1092yHCTiKCisSlncQxwMs5/+03RGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696730; c=relaxed/simple;
	bh=0xAiPLicgB03cktuxcQuchZBR+UbZFRbsMP564Obddc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8NqFhEepxYGyBpKDYMkCfLeUnV7a8vu98OJiwOvpRtM/xSfgDbo1n6AdChsyTHFTkoxl7E2VE7R9tlnirZ5igUpT0vouc+LEs+vW+MNBZRrMhnbDJeGipSri3GtzrRK6KRthvP558piYPzaGc8di0iDTUGGZ6WzdoezcOFWhDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huZ5mDda; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42e2b78d45bso1569936f8f.0
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 09:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764696726; x=1765301526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZFItyLY22Boxo7GM+d0AYn069sCXHjKGVjBq4SXALY=;
        b=huZ5mDdamWjyaEE60MqnOA5maWKL99SypcSNchj5RcUI9bcuZUEMrGsI+Vk2VudkLv
         4rbuzgWKwMkjTXYS29+PQxdRxT+UiO5OC2v/9v1tmKxdTw/Q1qe4vCA4pVoW4immU1/J
         anze5BGTnxtq4fEan8jByrm/cI5Qmcw58O8o/KA2OwGatX272E7JJfGAbOvVkhi77FrV
         QbvBLnkZhhXaeQUt6aUrrpPWvd06vyVPYL8tdVEab7tXS2KcHnGWX5+8gRR7NQbTJixa
         hhS44pLhaKk04rL548s1uUryO8fWoGkX+ONqumXrR4TuExNrMF/oYWkAKedoKlx1qq1F
         TqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764696726; x=1765301526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nZFItyLY22Boxo7GM+d0AYn069sCXHjKGVjBq4SXALY=;
        b=Kw1Ak+EpCQjhpz7DeM/IDrNh/Yj8K0v9BPf9UnPXmrzMVwwb4kfF67NhH+1Wvy5rY/
         W5Dt6atHKiaarsfCM1RaEcQJ6NHjfvGTo+qNZSLuaB8Ieylo2CJEgk1C/I+Hf74GuFtP
         n+y4U2OyWnkSpq5KkjAoDPAnwATDe/Xl77GM4zH43eTBcqCTqaGTBb3ojdTPfNR1ZLpa
         a3F751uoPkCQuUlg+lErYq4iZO5Xb9vec/YugHD6udkWsuNdSQK1x1qaCtsuZ8YdM3R0
         S0I4/FoHOnHFp647t2t3MD2ZTHO0HR9j8iy4wL8lagvs6bSPgfZGlnP81e1oh0xIURZ+
         9dYw==
X-Gm-Message-State: AOJu0Yw3hxIc1CEs8/p0CH1JhfeeEqX7cyw2jspGc9M1DKkgarotG9Bf
	7Np/eCFMAxf3aG1xSGkS3+Rk3RnuSzsceS+sg5qxrbPldjK7yYqpIO7DG3/cfrLDhuoymi4j/Gf
	Os1nVPyOOO8zmYsxsCDhhOhnSB9kxJ+I=
X-Gm-Gg: ASbGncuKJDywpDiuu6mgZEOs05tyLoS2FKpUuffxtYSgkGZusLW/pChv2rp7LRdoNCA
	Wqaqd6/iN/GsyLzYx1yivkruBBZ3fPfNEFlvTGfWWCyCCV6aHFClnFQF1injAcgtvzXa5vqe696
	+rVa9xqGoHVbm9EqpTXug1Ai0wJiYgVvCMNZr/9l3bAKiSCrLG/IA1FUW3w+8bOm1B5aR+Uf9cA
	8mfnQwpDtyDmMQ7FPwWYrLNe7Jis90Xq9I5aeEquuHRPljDp7UVUckXn0RakqCl9KrXUHu7TW1e
	dfUuP3QZgf8ep71RoUyffhAeFZNp
X-Google-Smtp-Source: AGHT+IEAFgWi6gP2U+zqOrhDN9UN8+v6KtZ+Qnk7WwAuexnI0r211s/FhNyKtGzUTYaYH0Q4SdHFHpeqneIOWU1FExM=
X-Received: by 2002:a05:6000:1a8e:b0:429:cf88:f7ac with SMTP id
 ffacd0b85a97d-42cc1d35d6dmr43796524f8f.44.1764696726355; Tue, 02 Dec 2025
 09:32:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202171615.1027536-1-ameryhung@gmail.com>
In-Reply-To: <20251202171615.1027536-1-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Dec 2025 09:31:55 -0800
X-Gm-Features: AWmQ_bmnMVc5ThyHPiVbWV1Iz9SOLG4q3niwo-bZHB9zmrHf3MJLwg2YOziSTbg
Message-ID: <CAADnVQKvRYnKME8-Q24=CqaNz24ibqfbczrRB4_BJxbNcj2oNQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Disallow tail call to programs that use
 cgroup storage
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 9:16=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> Mitigate a possible NULL pointer dereference in bpf_get_local_storage()
> by disallowing tail call to programs that use cgroup storage. Cgroup
> storage is allocated lazily when attaching a cgroup bpf program. With
> tail call, it is possible for a callee BPF program to see a NULL
> storage pointer if the caller prorgam does not use cgroup storage.
>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/c9ac63d7-73be-49c5-a4ac-eb07f7521adb@=
hust.edu.cn/
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/arraymap.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 1eeb31c5b317..9c3f86ef9d16 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -884,8 +884,9 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map,=
 struct file *map_file,
>                                  void *key, void *value, u64 map_flags)
>  {
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> +       u32 i, index =3D *(u32 *)key, ufd;
>         void *new_ptr, *old_ptr;
> -       u32 index =3D *(u32 *)key, ufd;
> +       struct bpf_prog *prog;
>
>         if (map_flags !=3D BPF_ANY)
>                 return -EINVAL;
> @@ -898,6 +899,14 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map=
, struct file *map_file,
>         if (IS_ERR(new_ptr))
>                 return PTR_ERR(new_ptr);
>
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_PROG_ARRAY) {
> +               prog =3D (struct bpf_prog *)new_ptr;
> +
> +               for_each_cgroup_storage_type(i)
> +                       if (prog->aux->cgroup_storage[i])
> +                               return -EINVAL;

hmm. I think AI was right that prog refcnt is leaked.

