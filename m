Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A30C0ECE2D
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2019 11:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfKBK5H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 2 Nov 2019 06:57:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfKBK5H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Nov 2019 06:57:07 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 965C6368E6
        for <bpf@vger.kernel.org>; Sat,  2 Nov 2019 10:57:06 +0000 (UTC)
Received: by mail-lf1-f70.google.com with SMTP id m17so2375932lfl.11
        for <bpf@vger.kernel.org>; Sat, 02 Nov 2019 03:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lErh/tnnnukiwNjkmW5L2seotGD7DCMDEfKs41x9nVg=;
        b=MMWSUw6Dnr6p7l86cW6AzqwaLPDXpI1oR0Wyjj7tIWvF0Xu1fs6ZwO6+sZbl+31+hW
         lL3O6LTjxaSYwTrxNdd1JYMMsPDAimMjY4ACRsi/wKzS30ZF2tWoqpNKPUhoU4IzbJxY
         3Mo9/Mt+/nymAMbMyo0JusSEMZ6ncQXEcAbGmwAal800i/gi2BDVKhmANTpWKUDEiSSg
         Jd0gEOslcNwazYlsfFKw6eQ02VNstJctyNV2jeHLnspAXLkOa80f7GU24QfwjZuuTbdY
         O4lqWzt9MXYnGrJ8myovxrA9wG8TvVEdSGqM4dUKNHrJ2vaTGszFmPct4KBemrqzYy59
         Gyng==
X-Gm-Message-State: APjAAAX8EBpgZLiDftmpVCy1l/xYa0qYZ9wTKKogMCIVA64MfWTWq3fH
        ybxLIVt8Kci0l02/14HBFoKR/XAQE4fM+Vkn+GThKobQOCRlPYKNtlFOFmmxR8xP8RG4a/4QMdX
        Cd04nAEl0bmGg
X-Received: by 2002:ac2:5bc2:: with SMTP id u2mr10322834lfn.173.1572692225123;
        Sat, 02 Nov 2019 03:57:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqylS7SRW6T6vq9+u/R+Xia4YAwhEEtL0RvF5Szq3bbXKEhIdCVjUQDL+idRabnRJKnhvsbFwQ==
X-Received: by 2002:ac2:5bc2:: with SMTP id u2mr10322824lfn.173.1572692224942;
        Sat, 02 Nov 2019 03:57:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id k68sm4443837lje.86.2019.11.02.03.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2019 03:57:04 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 86FF11818B5; Sat,  2 Nov 2019 11:57:03 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 2/5] libbpf: Store map pin path and status in struct bpf_map
In-Reply-To: <CAEf4BzZMO7j1LsESEetTJCRpw4HDZ994C5RigFU+uQ1tgQa_PQ@mail.gmail.com>
References: <157260197645.335202.2393286837980792460.stgit@toke.dk> <157260197871.335202.12855636074438881848.stgit@toke.dk> <CAEf4BzZMO7j1LsESEetTJCRpw4HDZ994C5RigFU+uQ1tgQa_PQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 02 Nov 2019 11:57:03 +0100
Message-ID: <8736f6mtq8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Nov 1, 2019 at 2:53 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>>
>> Support storing and setting a pin path in struct bpf_map, which can be used
>> for automatic pinning. Also store the pin status so we can avoid attempts
>> to re-pin a map that has already been pinned (or reused from a previous
>> pinning).
>>
>> The behaviour of bpf_object__{un,}pin_maps() is changed so that if it is
>> called with a NULL path argument (which was previously illegal), it will
>> (un)pin only those maps that have a pin_path set.
>>
>> Acked-by: Andrii Nakryiko <andriin@fb.com>
>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>> ---
>>  tools/lib/bpf/libbpf.c   |  164 +++++++++++++++++++++++++++++++++++-----------
>>  tools/lib/bpf/libbpf.h   |    8 ++
>>  tools/lib/bpf/libbpf.map |    3 +
>>  3 files changed, 134 insertions(+), 41 deletions(-)
>>
>
> [...]
>
>>  LIBBPF_API int bpf_object__pin_maps(struct bpf_object *obj, const char *path);
>>  LIBBPF_API int bpf_object__unpin_maps(struct bpf_object *obj,
>>                                       const char *path);
>> @@ -385,6 +390,9 @@ LIBBPF_API int bpf_map__resize(struct bpf_map *map, __u32 max_entries);
>>  LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
>>  LIBBPF_API bool bpf_map__is_internal(const struct bpf_map *map);
>>  LIBBPF_API void bpf_map__set_ifindex(struct bpf_map *map, __u32 ifindex);
>> +LIBBPF_API int bpf_map__set_pin_path(struct bpf_map *map, const char *path);
>> +LIBBPF_API const char *bpf_map__get_pin_path(struct bpf_map *map);
>> +LIBBPF_API bool bpf_map__is_pinned(struct bpf_map *map);
>
>
> Didn't notice this before and wasn't going to force another version
> just for this, but given you'll be fixing last patch anyways...
> bpf_map__is_pinned and bpf_map__get_pin_path are read-only "getters",
> so it would be appropriate for them to accept "const struct bpf_map *"
> instead.

Can do :)
