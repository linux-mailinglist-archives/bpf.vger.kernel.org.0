Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA4DF5BD5
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2019 00:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKHXd2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 8 Nov 2019 18:33:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfKHXd2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 18:33:28 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D850E59445
        for <bpf@vger.kernel.org>; Fri,  8 Nov 2019 23:33:27 +0000 (UTC)
Received: by mail-ed1-f72.google.com with SMTP id g16so5914445edp.13
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2019 15:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=aiD5DM7IjlHQUmR9oZ59QRk6NCPbebCs5xbskEv3VzE=;
        b=SuGPlEJgeHh0uPs68Fav6SUbfcgC7Pyh1jcnrc+AC1FCLs6vk2u349dME1d9elUmBF
         fxquzS9rkp9iJF62Omk8I61sO/p9rOQfnKfoB9dizA589rGoS0YFCF+7YAtM2TKem/p6
         nuAgq/4lIs1ktx1hZCi5HAgUwgDHIMg4WKw0vVk/7GgTa3P6OOIMCq8b4P2nBPxcq4Nm
         5BfQ5LAPj187b++244gtdZlkyQPWZXw2qp86SjUhmH6bxY3+q5YgWU/9DvAsHKvuaATY
         4QwUfDDPPp8m5NlHU0HFjOkCxISe/hE1z7nLOgOOEnN7b1uqcLpiFxZQ9pxT03g1qFf+
         MzDQ==
X-Gm-Message-State: APjAAAWv5jE4YTcVnlQ4B6USXNI4pwwVPGqoAlgCvC6d33JhFtZuwznK
        CMN8ThLhUB/+9+8P3FFochF9Tqx1t3uAZ0lDvYerNeJtxyrwLo8nVQCDlRJ4gavRevaTvI86e0I
        /zJ1m/5PRN6St
X-Received: by 2002:a17:906:27cc:: with SMTP id k12mr11453255ejc.181.1573256006575;
        Fri, 08 Nov 2019 15:33:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzaJNtLS4BcxKGjnbmW7YrQygu55+PRtTm50fdDNdSDhaaBAl0XxbkGhe2u5cHNo6Tgwd+5g==
X-Received: by 2002:a17:906:27cc:: with SMTP id k12mr11453240ejc.181.1573256006331;
        Fri, 08 Nov 2019 15:33:26 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id t24sm181060edc.56.2019.11.08.15.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 15:33:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2B1D01800CC; Sat,  9 Nov 2019 00:33:25 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/6] libbpf: Unpin auto-pinned maps if loading fails
In-Reply-To: <CAEf4BzbqwpxtDRkYZLNsM7POc9WHAVpM-vvMX5jnEtYUV2PQaA@mail.gmail.com>
References: <157324878503.910124.12936814523952521484.stgit@toke.dk> <157324878624.910124.5124587166846797199.stgit@toke.dk> <CAEf4BzbqwpxtDRkYZLNsM7POc9WHAVpM-vvMX5jnEtYUV2PQaA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 09 Nov 2019 00:33:25 +0100
Message-ID: <87pni2q6yi.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Nov 8, 2019 at 1:33 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>>
>> Since the automatic map-pinning happens during load, it will leave pinned
>> maps around if the load fails at a later stage. Fix this by unpinning any
>> pinned maps on cleanup. To avoid unpinning pinned maps that were reused
>> rather than newly pinned, add a new boolean property on struct bpf_map to
>> keep track of whether that map was reused or not; and only unpin those maps
>> that were not reused.
>>
>> Fixes: 57a00f41644f ("libbpf: Add auto-pinning of maps when loading BPF objects")
>> Acked-by: Song Liu <songliubraving@fb.com>
>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> ---
>>  tools/lib/bpf/libbpf.c |   16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index be4af95d5a2c..cea61b2ec9d3 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -229,6 +229,7 @@ struct bpf_map {
>>         enum libbpf_map_type libbpf_type;
>>         char *pin_path;
>>         bool pinned;
>> +       bool was_reused;
>
> nit: just reused, similar to pinned?
>
>>  };
>>
>>  struct bpf_secdata {
>> @@ -1995,6 +1996,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
>>         map->def.map_flags = info.map_flags;
>>         map->btf_key_type_id = info.btf_key_type_id;
>>         map->btf_value_type_id = info.btf_value_type_id;
>> +       map->was_reused = true;
>>
>>         return 0;
>>
>> @@ -4007,15 +4009,18 @@ bpf_object__open_buffer(const void *obj_buf, size_t obj_buf_sz,
>>         return bpf_object__open_mem(obj_buf, obj_buf_sz, &opts);
>>  }
>>
>> -int bpf_object__unload(struct bpf_object *obj)
>> +static int __bpf_object__unload(struct bpf_object *obj, bool unpin)
>>  {
>>         size_t i;
>>
>>         if (!obj)
>>                 return -EINVAL;
>>
>> -       for (i = 0; i < obj->nr_maps; i++)
>> +       for (i = 0; i < obj->nr_maps; i++) {
>>                 zclose(obj->maps[i].fd);
>> +               if (unpin && obj->maps[i].pinned && !obj->maps[i].was_reused)
>> +                       bpf_map__unpin(&obj->maps[i], NULL);
>> +       }
>>
>>         for (i = 0; i < obj->nr_programs; i++)
>>                 bpf_program__unload(&obj->programs[i]);
>> @@ -4023,6 +4028,11 @@ int bpf_object__unload(struct bpf_object *obj)
>>         return 0;
>>  }
>>
>> +int bpf_object__unload(struct bpf_object *obj)
>> +{
>> +       return __bpf_object__unload(obj, false);
>> +}
>> +
>>  int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
>>  {
>>         struct bpf_object *obj;
>> @@ -4047,7 +4057,7 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
>>
>>         return 0;
>>  out:
>> -       bpf_object__unload(obj);
>> +       __bpf_object__unload(obj, true);
>
> giving this is the only (special) case of auto-unpinning auto-pinned
> maps, why not do a trivial loop here, instead of having this extra
> unpin flag and extra __bpf_object__unload function?

Oh, you mean just do a loop in addition to the call to __unload? Sure, I
guess we can do that instead...

-Toke
