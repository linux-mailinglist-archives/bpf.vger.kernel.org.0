Return-Path: <bpf+bounces-59032-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E87AC5D34
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 00:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8229E4A5E03
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 22:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9F920299B;
	Tue, 27 May 2025 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTWyMsff"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800231F03C7
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748385615; cv=none; b=NNwR9v+/SO+2RoUbogNLXMxXNFqW3BYBrnEhyvVheVC/xEkrZXPsdWM+WHNVNasG4pf3YRK67wl/I7tCZ6hByCIqtkInMKbRkVk74ZyuM1k8XeWHe1MvQcQ3jnsIzm7ILkYoxRixyBMTZi/1WVOcMDTEjVmCG5ePYdiobVTWDvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748385615; c=relaxed/simple;
	bh=4ySu+UJK3JPPtwm+LRAizNpUsKW4F7W9m2xVC0GYiok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ecc44x977QHrOilt38EUNvd8tZQwV78Hxb5W1hrTk7w2cULEqIJcLpQC3a7Yz7VM2vG1AWCZqNc6v0YYa9814sVs7wkqOCrwdz3tjgBDSrvOEY0g1CkV5UbcFpQDKBf13AKjC/wjtby8rxF/kRN3JteeFsi0F42Hr1qsUrh/1O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTWyMsff; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a375888297so192265f8f.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748385612; x=1748990412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQDETfBlGYkG/mh8eaFxQKQ/AtpBP5zNFizKDa1Rr1w=;
        b=nTWyMsffMpm1hbvr9RGMNqrQYCsw/H02PiLggF7u6sy35W+xqbxK8pX9/yqfzggeIh
         z1Rfwu9yOlXcjNxGchyrP+hp9sakAAtavz6Lz510RSJX1dV6xTbUvHcsz9drDnITJ64I
         W8Jqcfnvy0QfDR6L/Ya6stuJ5+2peCC3bho9RB+wILyM6QhSYRyWErIW0bhFAO2M0MRU
         qDYSsBxyf72dikh1FAIP+4Q/B0Sj7ZoPpt+2UKUryAYNufMUpznABRTTXqyd10k4XEGX
         XApjx7McF5a0gyCBDAQDWFL/Vv1kFXDBcrx1WSQTxs4W2DqIIsfHHaYtoOUQgChtnpQt
         wmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748385612; x=1748990412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQDETfBlGYkG/mh8eaFxQKQ/AtpBP5zNFizKDa1Rr1w=;
        b=mNeIT6TAnZCSnzntx2BPtHlN6IbNbIFwiU9Dq0hEIPM+YY1ssSHz4+p7MKft9PQ0ny
         JTf0Gqi8USmSPhlC1A6com/TW4rTwjl7UTgiJRrj7fi/JKIsWuDcB1cSLfkFhc+Kg7qG
         FbIf/+yEoyvO7TZlJJCY7HMe097kdiL6FV5RvScQ3r0VQbk+SwEB4CW0T13iZ9np2DuC
         4AmPb/u+G3EWfvvKJdrYfQ7E4EMDMXaDyBGR5GqgkpX9m3JmJAsBXViQJ97jjMGHsxZv
         I2i+cmbEhpYIqQx6Jqgn2vGGXJXEKSIEABYo6n3yBvQbCTZcq5LNvIYEHYOY0s4KPmiM
         Vxvg==
X-Gm-Message-State: AOJu0YxMH9JduGEgdDNjY8ZvIoA8MeVRuIwBgnTYaQZinRi3qntt7kWi
	VAGzit0tOWa+q779QBP9cKGb/m34C8o0EZLKa1WqNEbqFn+NEtVPTjNv7MAhS2ysOifH7z+DpDp
	7XNWMEZgxRfa6pzC2EHuUN5M+b57MIb5a5hdP
X-Gm-Gg: ASbGncsRfNRG+eMsHRgpif1GIbxzXW9UqJRZGBnCTdD7nojhE0JSPwocqKDU9+4YZ/m
	rH40IbGlOTLlxINpqvsv0ZA7KO1CLsEzexQvbPhqnoReNRaJ1MGjy1Mwx8bkxPnyJjQfejnfxoA
	2Qvci9MkIM/Myvbc0dfD6eaPtDTbCi2ARh14rHkNKZJ4qPGC66x+HpvzbXaSowhw/ZH6O9BOm1
X-Google-Smtp-Source: AGHT+IEMa4gmK7bKO97EN+1FBKcsPjWVNE2Pu8xQUaXzFk/fjzAzyYxeDnegjFNmf8mq8dsQy8Yq2EuAnEcWPBsqlTE=
X-Received: by 2002:a05:6000:1445:b0:3a0:b8ba:849f with SMTP id
 ffacd0b85a97d-3a4e5e81969mr1964967f8f.4.1748385611559; Tue, 27 May 2025
 15:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526162146.24429-1-leon.hwang@linux.dev> <20250526162146.24429-3-leon.hwang@linux.dev>
In-Reply-To: <20250526162146.24429-3-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 May 2025 15:40:00 -0700
X-Gm-Features: AX0GCFsyYQyE29YxwboEr--0gEFk2a_IhdSsKUtVJVtCYoIxTKVGfx-nZzVJKwM
Message-ID: <CAADnVQJZ1dpSf3AtfNsvovogfC75eVs=PiYXMivUpDHDow3Row@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf, libbpf: Support global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 9:22=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
> +
> +       data_sz =3D map->def.value_size;
> +       if (is_percpu) {
> +               num_cpus =3D libbpf_num_possible_cpus();
> +               if (num_cpus < 0) {
> +                       err =3D num_cpus;
> +                       return err;
> +               }
> +
> +               data_sz =3D data_sz * num_cpus;
> +               data =3D malloc(data_sz);
> +               if (!data) {
> +                       err =3D -ENOMEM;
> +                       return err;
> +               }
> +
> +               elem_sz =3D map->def.value_size;
> +               for (i =3D 0; i < num_cpus; i++)
> +                       memcpy(data + i * elem_sz, map->mmaped, elem_sz);
> +       } else {
> +               data =3D map->mmaped;
> +       }
>
>         if (obj->gen_loader) {
>                 bpf_gen__map_update_elem(obj->gen_loader, map - obj->maps=
,
> -                                        map->mmaped, map->def.value_size=
);
> +                                        data, data_sz);

I missed it earlier, but now I wonder how this is supposed to work ?
skel and lskel may be generated on a system with N cpus,
but loaded with M cpus.

Another concern is num_cpus multiplier can be huge.
lksel adds all that init data into a global array.
Pls avoid this multiplier.

