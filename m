Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 201D2E0B3B
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 20:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfJVSNV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 22 Oct 2019 14:13:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729909AbfJVSNU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Oct 2019 14:13:20 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB39681F11
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 18:13:19 +0000 (UTC)
Received: by mail-lj1-f199.google.com with SMTP id 62so134594ljj.19
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 11:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+vbRi+3JMlk5PxQiqLnVHJfXouj+zo5niHlRTYkkAyw=;
        b=nd7sJSDc7F2XufU4GL/1FO2mdz/+kIPP+NcfNR4ASu8rbsn9E2ALH2dMnMgGbFI9yR
         30RPESfTe3Ox6eSI0sSQbw8XNtoG1rWrUvF/SMgMY/0huR4zaLP2tMxioTb/uetasCQj
         36hvprVCJuF2IcpXeAV4/SwcfmeqmyRQkf+BACz784qkrnda41O23vcWHi3Fjzwr6Nua
         hxgC56vY+Jf9vx1fTmjz5Y2ND4p5inwYp5wbPcq4tPDoHrJti/rL+u20AaocaYn8ZEnY
         ypJ9c3lCFMmiarqcl8iOnA8XEMyWADy/qc9A/QSVsZSkDYzo3tAAHHEePQ7kGjyL51GL
         c+UQ==
X-Gm-Message-State: APjAAAWm320+J1JcKqL/1VUJhMoGILGxGLwyPd7D8wUY0BJ3Mjxm/yuI
        793xWIjkZ+wU4NNX3sb/qhlwtQfxo4B1tjbtvSPr7cNDkfZF8AmzxRIRxeUPC+MczSuazt7++Qp
        Ak4jRZmnIFIcP
X-Received: by 2002:ac2:5468:: with SMTP id e8mr4267837lfn.31.1571767998351;
        Tue, 22 Oct 2019 11:13:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxQ+GuWoES4jexLS9LLdxFqySe8OZ7a9aoaRWxtlFkFyRLgfHjZYQZw1ycIGaQJ9EWhZXG1VQ==
X-Received: by 2002:ac2:5468:: with SMTP id e8mr4267824lfn.31.1571767998147;
        Tue, 22 Oct 2019 11:13:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id o13sm7709159ljh.35.2019.10.22.11.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 11:13:17 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C06BE1804B1; Tue, 22 Oct 2019 20:13:16 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/3] libbpf: Store map pin path in struct bpf_map
In-Reply-To: <CAEf4BzatAgkOiS2+EpauWsUWymmjM4YRBJcSqYj15Ywk8aP6Lw@mail.gmail.com>
References: <157175668770.112621.17344362302386223623.stgit@toke.dk> <157175668879.112621.10917994557478417780.stgit@toke.dk> <CAEf4BzatAgkOiS2+EpauWsUWymmjM4YRBJcSqYj15Ywk8aP6Lw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 22 Oct 2019 20:13:16 +0200
Message-ID: <87blu8odhf.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Oct 22, 2019 at 9:08 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>>
>> When pinning a map, store the pin path in struct bpf_map so it can be
>> re-used later for un-pinning. This simplifies the later addition of per-map
>> pin paths.
>>
>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> ---
>>  tools/lib/bpf/libbpf.c |   19 ++++++++++---------
>>  1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index cccfd9355134..b4fdd8ee3bbd 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -226,6 +226,7 @@ struct bpf_map {
>>         void *priv;
>>         bpf_map_clear_priv_t clear_priv;
>>         enum libbpf_map_type libbpf_type;
>> +       char *pin_path;
>>  };
>>
>>  struct bpf_secdata {
>> @@ -1929,6 +1930,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
>>         if (err)
>>                 goto err_close_new_fd;
>>         free(map->name);
>> +       zfree(&map->pin_path);
>>
>
> While you are touching this function, can you please also fix error
> handling in it? We should store -errno locally on error, before we
> call close() which might change errno.

Didn't actually look much at the surrounding function, TBH. I do expect
that I will need to go poke into this for the follow-on "automatic reuse
of pinned maps" series anyway. But sure, I can do a bit of cleanup in a
standalone patch first :)

>>         map->fd = new_fd;
>>         map->name = new_name;
>> @@ -4022,6 +4024,7 @@ int bpf_map__pin(struct bpf_map *map, const char *path)
>>                 return -errno;
>>         }
>>
>> +       map->pin_path = strdup(path);
>
> if (!map->pin_path) {
>     err = -errno;
>     goto err_close_new_fd;
> }

Right.

>>         pr_debug("pinned map '%s'\n", path);
>>
>>         return 0;
>> @@ -4031,6 +4034,9 @@ int bpf_map__unpin(struct bpf_map *map, const char *path)
>>  {
>>         int err;
>>
>> +       if (!path)
>> +               path = map->pin_path;
>
> This semantics is kind of weird. Given we now remember pin_path,
> should we instead check that user-provided path is actually correct
> and matches what we stored? Alternatively, bpf_map__unpin() w/o path
> argument looks like a cleaner API.

Yeah, I guess the function without a path argument would make the most
sense. However, we can't really change the API of bpf_map__unpin()
(unless you're proposing a symbol-versioned new version?). Dunno if it's
worth it to include a new, somewhat oddly-named, function to achieve
this? For the internal libbpf uses at least it's easy enough for the
caller to just go bpf_map__unpin(map, map->pin_path), so I could also
just drop this change? WDYT?

-Toke
