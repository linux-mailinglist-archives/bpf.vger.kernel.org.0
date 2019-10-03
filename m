Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62105C990C
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2019 09:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbfJCHfa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Oct 2019 03:35:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29865 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725613AbfJCHfa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Oct 2019 03:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570088129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahlNzkuv1Gr7jChvdoijfKpS0UvBbY8sDdSq0LbHVqs=;
        b=Lo74LYUJax/XTn3Rnw6ikljUuwcpw/XNC8efCSJBELDkQuyDfleovp/uVE0y/1fn0ZJnIw
        Bai+eyyn3FvjmTTJ3qF0fspolX7MmeLt+Bh2vi5VEITHgKm1rczpuCR8lqj8aZrTxb5eVP
        8oznp1R9gwgMUsMN9G87yZNR4BmJpI0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-vHgQghnmPnSeUYSvS7U_JQ-1; Thu, 03 Oct 2019 03:35:23 -0400
Received: by mail-lj1-f200.google.com with SMTP id y12so552958ljc.8
        for <bpf@vger.kernel.org>; Thu, 03 Oct 2019 00:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5opDUu41kY9xgEvZBTw/lIEBtyZIajraEgqdBUvC+1w=;
        b=fS/sL0KRhNQIQQ2RQCx5uYI+4HsMjyUKH9CIUuQ5/WJnxP0nDBx+QHMQ3k5ajiG0Kh
         4jfADbvYkidz+5px/n1DYwuuK/McEd+QssIJoY+NcAd5A0UQQo3+W/V4ZVcsZipUc1oS
         wgpsVbnMH2SXSr/CuprErGyNXmfXISs5iepoDTtoPOmhEB1oqT3Bfm9bh4y6EC9V5faY
         NF+CkQ+WRxy83Ymg2RIHklds8UtY9F1ZWSxNcOqx2OxdCpwZtZZhBlkh5mjn/Yr1+e/y
         Tx65fGiqTuNqnJbM2DCn1f2oG9v2SCmFPHVymz2WD5NlXZfgpvAr9lxtMNHS6p4hIgGp
         IwhA==
X-Gm-Message-State: APjAAAXQJHYk7u3Mnrc1PFK1zUj1U45WJvjQ0sZAdp3yIS7ar4rDyZN6
        b9agLyju4xzkq3bMlhy0scK4rLgHK/0E+PRIsRt27BAG2Tlnfqc71+482J+xy+YJqiDgbJ4NZcb
        ZDFbnko18fj90
X-Received: by 2002:a2e:5dc6:: with SMTP id v67mr2506729lje.247.1570088122289;
        Thu, 03 Oct 2019 00:35:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzDWZjrhNPsTmkARGvOvjAvXnChZdtor1vHsiLqai4F+X6XM68slctRaXw6jVQI8cgsaLzylg==
X-Received: by 2002:a2e:5dc6:: with SMTP id v67mr2506713lje.247.1570088122101;
        Thu, 03 Oct 2019 00:35:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id k15sm351208ljg.65.2019.10.03.00.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 00:35:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5B5C318063D; Thu,  3 Oct 2019 09:35:20 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH v2 bpf-next 2/7] selftests/bpf: samples/bpf: split off legacy stuff from bpf_helpers.h
In-Reply-To: <20191002215041.1083058-3-andriin@fb.com>
References: <20191002215041.1083058-1-andriin@fb.com> <20191002215041.1083058-3-andriin@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 03 Oct 2019 09:35:20 +0200
Message-ID: <87k19mqo1z.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: vHgQghnmPnSeUYSvS7U_JQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> diff --git a/samples/bpf/map_perf_test_kern.c b/samples/bpf/map_perf_test=
_kern.c
> index 2b2ffb97018b..f47ee513cb7c 100644
> --- a/samples/bpf/map_perf_test_kern.c
> +++ b/samples/bpf/map_perf_test_kern.c
> @@ -9,25 +9,26 @@
>  #include <linux/version.h>
>  #include <uapi/linux/bpf.h>
>  #include "bpf_helpers.h"
> +#include "bpf_legacy.h"
> =20
>  #define MAX_ENTRIES 1000
>  #define MAX_NR_CPUS 1024
> =20
> -struct bpf_map_def SEC("maps") hash_map =3D {
> +struct bpf_map_def_legacy SEC("maps") hash_map =3D {
>  =09.type =3D BPF_MAP_TYPE_HASH,
>  =09.key_size =3D sizeof(u32),
>  =09.value_size =3D sizeof(long),
>  =09.max_entries =3D MAX_ENTRIES,
>  };

Why switch these when they're not actually using any of the extra fields
in map_def_legacy?
> =20
> -struct bpf_map_def SEC("maps") lru_hash_map =3D {
> +struct bpf_map_def_legacy SEC("maps") lru_hash_map =3D {
>  =09.type =3D BPF_MAP_TYPE_LRU_HASH,
>  =09.key_size =3D sizeof(u32),
>  =09.value_size =3D sizeof(long),
>  =09.max_entries =3D 10000,
>  };
> =20
> -struct bpf_map_def SEC("maps") nocommon_lru_hash_map =3D {
> +struct bpf_map_def_legacy SEC("maps") nocommon_lru_hash_map =3D {
>  =09.type =3D BPF_MAP_TYPE_LRU_HASH,
>  =09.key_size =3D sizeof(u32),
>  =09.value_size =3D sizeof(long),
> @@ -35,7 +36,7 @@ struct bpf_map_def SEC("maps") nocommon_lru_hash_map =
=3D {
>  =09.map_flags =3D BPF_F_NO_COMMON_LRU,
>  };
> =20
> -struct bpf_map_def SEC("maps") inner_lru_hash_map =3D {
> +struct bpf_map_def_legacy SEC("maps") inner_lru_hash_map =3D {
>  =09.type =3D BPF_MAP_TYPE_LRU_HASH,
>  =09.key_size =3D sizeof(u32),
>  =09.value_size =3D sizeof(long),
> @@ -44,20 +45,20 @@ struct bpf_map_def SEC("maps") inner_lru_hash_map =3D=
 {
>  =09.numa_node =3D 0,
>  };

Or are you just switching everything because of this one?


-Toke

