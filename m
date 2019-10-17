Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C3ADA9F1
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2019 12:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405815AbfJQK2M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 06:28:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50559 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405108AbfJQK2L (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 17 Oct 2019 06:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571308090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SUrbnQiqmpqS/YlT1VuyBnuaYpXOzD+Q3aYbuct/XkI=;
        b=J+ZTbI3tZOm9XRtBm7yw7s77TXpr8BCxm+rpMdSBoX4RnFNKV5Iy0BMO67u1M0dzxm/P3S
        1zCB57QEgUZ0S8s1rDP3sVX90Pw3OZpZ6OnWGCdGHAeGj+KRREscZq67wAzvEfzxLQzdqu
        6fITK6+ezDO4MLk35UePPcQEFwHZj1I=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-0CWPf-XoMTahNkseGfGO4g-1; Thu, 17 Oct 2019 06:28:08 -0400
Received: by mail-lj1-f197.google.com with SMTP id l13so332349lji.7
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2019 03:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SUrbnQiqmpqS/YlT1VuyBnuaYpXOzD+Q3aYbuct/XkI=;
        b=m6nuqOhuW4zSw3h4Mb0oww0LMQ7M5WFhTm4kRxKyB2QfBoD+d13FvcTl1X094UgcEI
         D3oDnLORaWphe4VAGbhzpYhs3KMauXlGj2Vk8MU+VGnLXvdR7DLSLM6sT0njy91oaG4D
         krZHFdl9fje8P005kDKUWZbnZHrAmwiKfj8ARrxjVX6hokpACi/5JxMeSnAWJ89oeZ/o
         sdPZy8HtkfQW4BNA8R9RGt1VqBxnyR69dKZ92hB+tomi0hsGftlNdG4apRvgQEDel+e7
         jr/eutI4X84loFzUV3/Cynls4/KikZmmNIKy34E9uOtz4P+9u9Yvinjv0ge1g8/kXNQF
         smQQ==
X-Gm-Message-State: APjAAAWYg7cMOiENyLgfXfhi+4R9S6kvnJBUCJktvfiyEz7vJWxFkK0Y
        TsfOw9K+DkfyJo+skHvLawn1DdCNPK6sKiP/FK78Iuu4pa49wfqcdItSdaBCgJ+CiZXzqApITz8
        CjvuO7pRIdLpZ
X-Received: by 2002:a2e:9a88:: with SMTP id p8mr1806382lji.249.1571308087115;
        Thu, 17 Oct 2019 03:28:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxyBztTJDKmj6PcLaxgXYLtGs9TS2JLgmdk8pt41jJm1scVvVFX6e5E/w+XHIcT1Em6yVLZMg==
X-Received: by 2002:a2e:9a88:: with SMTP id p8mr1806365lji.249.1571308086893;
        Thu, 17 Oct 2019 03:28:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id q19sm2599515lfj.9.2019.10.17.03.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 03:28:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id ABEDC1804C9; Thu, 17 Oct 2019 12:28:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     daniel@iogearbox.net, ast@fb.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf] xdp: Handle device unregister for devmap_hash map type
In-Reply-To: <2d516208-8c46-707c-4484-4547e66fc128@i-love.sakura.ne.jp>
References: <20191016132802.2760149-1-toke@redhat.com> <2d516208-8c46-707c-4484-4547e66fc128@i-love.sakura.ne.jp>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 17 Oct 2019 12:28:05 +0200
Message-ID: <87ftjrfyyy.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 0CWPf-XoMTahNkseGfGO4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:

> On 2019/10/16 22:28, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> It seems I forgot to add handling of devmap_hash type maps to the device
>> unregister hook for devmaps. This omission causes devices to not be
>> properly released, which causes hangs.
>>=20
>> Fix this by adding the missing handler.
>>=20
>> Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devic=
es by hashed index")
>> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> Well, regarding 6f9d451ab1a3, I think that we want explicit "(u64)" cast
>
> @@ -97,6 +123,14 @@ static int dev_map_init_map(struct bpf_dtab *dtab, un=
ion bpf_attr *attr)
>         cost =3D (u64) dtab->map.max_entries * sizeof(struct bpf_dtab_net=
dev *);
>         cost +=3D sizeof(struct list_head) * num_possible_cpus();
>
> +       if (attr->map_type =3D=3D BPF_MAP_TYPE_DEVMAP_HASH) {
> +               dtab->n_buckets =3D roundup_pow_of_two(dtab->map.max_entr=
ies);
> +
> +               if (!dtab->n_buckets) /* Overflow check */
> +                       return -EINVAL;
> +               cost +=3D sizeof(struct hlist_head) * dtab->n_buckets;
>
>                                                     ^here
>
> +       }
> +
>         /* if map size is larger than memlock limit, reject it */
>         err =3D bpf_map_charge_init(&dtab->map.memory, cost);
>         if (err)
>
> like "(u64) dtab->map.max_entries * sizeof(struct bpf_dtab_netdev *)" doe=
s.
> Otherwise, on 32bits build, "sizeof(struct hlist_head) * dtab->n_buckets"=
 can become 0.

Oh, right. I kinda assumed the compiler would be smart enough to figure
that out based on the type of the LHS; will send a separate fix for this.

-Toke

