Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E44D419623B
	for <lists+bpf@lfdr.de>; Sat, 28 Mar 2020 01:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgC1AIj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 20:08:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56859 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726134AbgC1AIi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Mar 2020 20:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585354118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=otWCEir7IYJfxu0CGGMLqK2E4I+ErEpDz7+9YzTPq0M=;
        b=GEoe9QFBQOtYgQ0lx8t1k1A2wqYDmAQd+pAgEahMbb2PfRp7eI1bOCamqYuwbfzfKkE+P2
        cxJhDUrBTZdSou5/fcNQasidtKhphhqWn1IIdv0pgj+dh6p8raqpggkriKubDa6ImqxypJ
        p/yAEo2dJGgvNn1PNmcOOYXvHKcV8dY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-C8UcbF2-MTGrMGGN7peUzQ-1; Fri, 27 Mar 2020 20:08:36 -0400
X-MC-Unique: C8UcbF2-MTGrMGGN7peUzQ-1
Received: by mail-lj1-f197.google.com with SMTP id v5so1416443ljg.20
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 17:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=otWCEir7IYJfxu0CGGMLqK2E4I+ErEpDz7+9YzTPq0M=;
        b=I/TvdxB8dLXP6BSFn8KqUjIdIjiovph8OuXktswh/tOhEnq46/fYemYUCh3KXxOH6A
         MkhXG8M//QfMwFBusl8+zexEzPno5RMdOOJwsFwqz1bkFY8YuA+9/tZOEbzde2pSHt1X
         J00GdZWbaXdmCddcfOZKkl85jZescyWVilhBghV8N0DX2/Pw4xQHkoIEDsvtnP9gE602
         lNkvD8VXABaAEhjb9kusupYNjEDW4Hkn1K3MK/1M5Y+gcCI07zDXufS7rsPsWYjaLgjc
         01JWV7TzsGIw1j0qeHDbDdSsB3qXlffSrEAZaw/QwZymC7CiKTY/bzn6TEbfUHfxG1VU
         FshA==
X-Gm-Message-State: AGi0PuYLAeruwG4hoDOMe1bhie5X/zYth5Ofl6+QpC+efk/jDaL2lCpE
        saMy94lXdzR0Y8eRIg7Dsi9nwmbnRlraslH4a9pZYjxHNxyR3CYcRvwc4dNWuZGORkfQb5MkIhS
        MDvAwQUewZ0gc
X-Received: by 2002:a2e:9ed6:: with SMTP id h22mr832250ljk.211.1585354114956;
        Fri, 27 Mar 2020 17:08:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypKEOehrM0VYfIYlmwlZFMo9ZaD0uaxFLhFzefD/gCn1/Zyk3Kpxv+zA3Za8g9czJy4AImXJOQ==
X-Received: by 2002:a2e:9ed6:: with SMTP id h22mr832235ljk.211.1585354114653;
        Fri, 27 Mar 2020 17:08:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k24sm3336107ljc.25.2020.03.27.17.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 17:08:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0234418158B; Sat, 28 Mar 2020 01:08:28 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] libbpf: Add getter for pointer to data area for internal maps
In-Reply-To: <dc1ad5b0-d575-034a-ffa5-710bcf94d8f0@fb.com>
References: <20200326151741.125427-1-toke@redhat.com> <20200327125818.155522-1-toke@redhat.com> <CAEf4BzbEyYQeLEsw0tzYYHeKi+q7a+vxavya9O3jykwsH3ki9g@mail.gmail.com> <87tv29l9ia.fsf@toke.dk> <dc1ad5b0-d575-034a-ffa5-710bcf94d8f0@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sat, 28 Mar 2020 01:08:28 +0100
Message-ID: <87r1xdl4sj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <ast@fb.com> writes:

> On 3/27/20 3:26 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>=20
>>> On Fri, Mar 27, 2020 at 5:58 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
>>>>
>>>> For internal maps (most notably the maps backing global variables), li=
bbpf
>>>> uses an internal mmaped area to store the data after opening the objec=
t.
>>>> This data is subsequently copied into the kernel map when the object is
>>>> loaded.
>>>>
>>>> This adds a getter for the pointer to that internal data store. This c=
an be
>>>> used to modify the data before it is loaded into the kernel, which is
>>>> especially relevant for RODATA, which is frozen on load. This same poi=
nter
>>>> is already exposed to the auto-generated skeletons, so access to it is
>>>> already API; this just adds a way to get at it without pulling in the =
full
>>>> skeleton infrastructure.
>>>>
>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>>> ---
>>>> v2:
>>>>    - Add per-map getter for data area instead of a global rodata gette=
r for bpf_obj
>>>>
>>>> tools/lib/bpf/libbpf.c   | 9 +++++++++
>>>>   tools/lib/bpf/libbpf.h   | 1 +
>>>>   tools/lib/bpf/libbpf.map | 1 +
>>>>   3 files changed, 11 insertions(+)
>>>>
>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>> index 085e41f9b68e..a0055f8908fd 100644
>>>> --- a/tools/lib/bpf/libbpf.c
>>>> +++ b/tools/lib/bpf/libbpf.c
>>>> @@ -6756,6 +6756,15 @@ void *bpf_map__priv(const struct bpf_map *map)
>>>>          return map ? map->priv : ERR_PTR(-EINVAL);
>>>>   }
>>>>
>>>> +void *bpf_map__data_area(const struct bpf_map *map, size_t *size)
>>>
>>> I'm not entirely thrilled about "data_area" name. This is entirely for
>>> providing initial value for maps, so maybe something like
>>> bpf_map__init_value() or something along those lines?
>>>
>>> Actually, how about a different API altogether:
>>>
>>> bpf_map__set_init_value(struct bpf_map *map, void *data, size_t size)?
>>>
>>> Application will have to prepare data of correct size, which will be
>>> copied to libbpf's internal storage. It also doesn't expose any of
>>> internal pointer. I don't think extra memcopy is a big deal here.
>>> Thoughts?
>>=20
>> Huh, yeah, that's way better. Why didn't I think of that? Think maybe I
>> was too focused on doing this the same way the skeleton code is. I'll
>> send a v3 :)
>
> Could you please add a selftest as well?
> I'm not excited about new features without tests.

Sure, will do.

-Toke

