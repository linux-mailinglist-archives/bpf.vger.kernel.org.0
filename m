Return-Path: <bpf+bounces-65236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDCDB1DD45
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 21:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECCA918C697F
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 19:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0208D25DB1C;
	Thu,  7 Aug 2025 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NymDQ533"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EDA20FAB2
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593331; cv=none; b=Vjw9Iol7ifL9vUyigbswHl9/5Jwb+nYbx2zXeeqQ42nmm5qcf4AySgfLpbnZBm5Jr/e9N/V5B9yfQsuvPam5+251SCWJ5cwXYVGv11yqQIypB7BGzbZsrNV8JDghmt8MNof6j0gZC5bmg/GxenaccWLpu9t30HsPf4f05uGppgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593331; c=relaxed/simple;
	bh=MhY5w9l/1VY/E2uFM062NpjyRuLV0sG7cdXxo59LI9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBk1ReJdR8YkaW3yqJGrLukt9PltcLc4VYG9NZTvU3BvVBeI2G0dl2WdNadAqmUt8bWKhv9GEazZRaaMSzlkhJi1oTbJzBIta50QrQr2FKnEQQSTk6NgRDfHlckpCQ/AWF47bKm9Q6kgs1HBmd5vHybXWoBu2FQjzXblTdDKvPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NymDQ533; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-af968aa2de4so264737966b.1
        for <bpf@vger.kernel.org>; Thu, 07 Aug 2025 12:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754593328; x=1755198128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2qyWwKFMlIRWGs9L/F/X7q/RJO/j4wQRwY5EBSB9FCo=;
        b=NymDQ533oJzZ6lZPoCzi+qjO3NqgbM5xzm66knwoihbYvuBYrgkxPlCOg5ZVxsmCqe
         wEiop3U6b5ZXwdFkG9Y4oDjz2CZ93HHjjmlpHrSjzEFUMnIfjNzBJF+HETpu5aqtffpS
         SY1MbTYBK0uF6mZIVjsXgdHTN1sABY4ZaK2+xBQ/UsOOTwRx4XATTjd9nL/h88Anw1kv
         RSboMBiPxTSUH49SdQZLZ+WK+vKyfHmicl91QW2ZZ3il0G3jTxdqdEMnbci7kNUmsTwk
         Wlpa2gToyA982t+MTN97DOowNan7JhfcG4sD/c2T6Q/K1QLBqt5ktKsLpCEeKzczn5LO
         VbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754593328; x=1755198128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qyWwKFMlIRWGs9L/F/X7q/RJO/j4wQRwY5EBSB9FCo=;
        b=LQvMvK4Wb96Xjx4vte80l5Yl/sGhjCFu7Ud8EShxTPFnKFW0OWDpWxrJaVOq1heY6t
         HbcfyKEtzefgar06v69c15gAbNERaNi+jFJqk/WfFg5bK8c70MuFHCZuWYsqyscbf1C8
         oNzi++loaCl6gv+rbI5PFLqqjUfQvtmFGqofk1+nMS0T8zBHAuR5NvDpSb+sI9E+LmV0
         36WCmco6neyT2uTiKbeVbWzWNroONo3rDJZRKkxatfZe017rH45q9caHETOE54CeWxa9
         7lSR7CSzyygMHIe1lucyqEE4htRHA7dri3DJQdfejzBThe5dyKA9YdYPyq+5j51sYe1w
         BWsw==
X-Gm-Message-State: AOJu0YysJ9mT77QidDTAeq6ihYXn+VF+1okPvmiyZBUrm3UFF10L7R3X
	/qa5vibvy9yjFQ8puS7ayV6XKX6rdpWFMCoSuJNjkpald+dSrQamxM3bJu40XJMtFA2MlTR44zc
	UARINPxTTTG2q+aFMD7NIpJUx402RpriELpfo
X-Gm-Gg: ASbGncuO9MB8rno4uhvEMDHlJ8mDySRfcTokj99/LxELbV6dOt0dX3CMcs9hFTBe2bm
	KTJEkfkOuhiS9o7+R5XXrACMw8WTFVGmU0l/B4rpt86GOLh8KwiPOrgVAWSXIuHt0kENKDlLdT2
	fhYlSIPue86/ua8igfQtsCL8lIij3F0kgABByBDaE0XTBklrWJ/HoXN3D7wSJxrZmm3e2BRjT92
	KqzY8FC1R+l1vTNq3uodPj8fVGayqesDTNEdq/2
X-Google-Smtp-Source: AGHT+IFFtkFopc4GrV2XsDv4SuWLS7xfiY8+gq8rGu+sW7rZPgoPISnDUyJyo/HCE3Mfb68/uzZ9WB2J+R+jPEG0ees=
X-Received: by 2002:a17:906:6a07:b0:ade:44f8:569 with SMTP id
 a640c23a62f3a-af9c653e5admr5687866b.42.1754593327822; Thu, 07 Aug 2025
 12:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com> <20250806144554.576706-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250806144554.576706-3-mykyta.yatsenko5@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 7 Aug 2025 21:01:31 +0200
X-Gm-Features: Ac12FXzQlZKm70K7HU0Clam2n19O8meiACgjudj8ORxo6-iiM6yw2rfU4AX-l5o
Message-ID: <CAP01T74oNNA=uQs9N5dtX6drLP5FgocVVZ0rWHP=ruDYH8Hvwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: extract map key pointer calculation
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Aug 2025 at 16:46, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Calculation of the BPF map key, given the pointer to a value is
> duplicated in a couple of places in helpers already, in the next patch
> another use case is introduced as well.
> This patch extracts that functionality into a separate function.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  kernel/bpf/helpers.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 322ffcaedc38..516286f67f0d 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1084,6 +1084,18 @@ const struct bpf_func_proto bpf_snprintf_proto = {
>         .arg5_type      = ARG_CONST_SIZE_OR_ZERO,
>  };
>
> +static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
> +{
> +       if (map->map_type == BPF_MAP_TYPE_ARRAY) {
> +               struct bpf_array *array =
> +                       container_of(map, struct bpf_array, map);

nit: Can we keep it on the same line?

> +
> +               *arr_idx = ((char *)value - array->value) / array->elem_size;
> +               return arr_idx;
> +       }
> +       return (void *)value - round_up(map->key_size, 8);
> +}
> +
>  struct bpf_async_cb {
>         struct bpf_map *map;
>         struct bpf_prog *prog;
> @@ -1166,15 +1178,8 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>          * bpf_map_delete_elem() on the same timer.
>          */
>         this_cpu_write(hrtimer_running, t);
> -       if (map->map_type == BPF_MAP_TYPE_ARRAY) {
> -               struct bpf_array *array = container_of(map, struct bpf_array, map);
>
> -               /* compute the key */
> -               idx = ((char *)value - array->value) / array->elem_size;
> -               key = &idx;
> -       } else { /* hash or lru */
> -               key = value - round_up(map->key_size, 8);
> -       }
> +       key = map_key_from_value(map, value, &idx);
>
>         callback_fn((u64)(long)map, (u64)(long)key, (u64)(long)value, 0, 0);
>         /* The verifier checked that return value is zero. */
> @@ -1200,15 +1205,7 @@ static void bpf_wq_work(struct work_struct *work)
>         if (!callback_fn)
>                 return;
>
> -       if (map->map_type == BPF_MAP_TYPE_ARRAY) {
> -               struct bpf_array *array = container_of(map, struct bpf_array, map);
> -
> -               /* compute the key */
> -               idx = ((char *)value - array->value) / array->elem_size;
> -               key = &idx;
> -       } else { /* hash or lru */
> -               key = value - round_up(map->key_size, 8);
> -       }
> +       key = map_key_from_value(map, value, &idx);
>
>          rcu_read_lock_trace();
>          migrate_disable();
> --
> 2.50.1
>
>

