Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABCFE195708
	for <lists+bpf@lfdr.de>; Fri, 27 Mar 2020 13:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgC0MYp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Mar 2020 08:24:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39753 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbgC0MYp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Mar 2020 08:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585311884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vosgrYq+dIB9YWWJ2hoVCefw2rREFv5Y6PKVFxbbPF8=;
        b=MCc2tYnJs/Dy9yXWqjHZ2mzVaO9q067n/SPxnlqXy1AkzadFfYkd7lPbnM8+26+kcMj81b
        Ile+KdGZZf9uodfkVPWRkA9gY+hnyGMz+1vdxTfGvCf21iwpGlzzJtlpwmkT4zh+8uRJxQ
        XRK04glxZY8k2TyhnamO3Ij4IwD9bA0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-dNZBMZ3WM7uHCYCxL_1APw-1; Fri, 27 Mar 2020 08:24:42 -0400
X-MC-Unique: dNZBMZ3WM7uHCYCxL_1APw-1
Received: by mail-lf1-f69.google.com with SMTP id l3so3469251lfe.22
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2020 05:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vosgrYq+dIB9YWWJ2hoVCefw2rREFv5Y6PKVFxbbPF8=;
        b=TxVzm6nYA/DYc0IGsMeZYSFnaf1TMTj69GxslhB0h246S2KzPLmrhioaqrud5ceIL8
         Q3n5E5xMeOoWfC11bGws+3heGqMIErksc1wpdZbkzEaCXUNllojhn4aDBPoAe429UWtQ
         UVEqMBEvjHQvqCUrwEGOOyKpOl+DfAQdqoaKnwJF6p1Z0P3Qwg3yI4YPk7yxIGd4sFv7
         RkKl9UV0en+8IQGBaQKFj39jy5dZc5X0iyKWrPbwRo1xn+UBTBzTOTKRkkVB5WkFxYmX
         CE6fHEidGdDuEhyVUW9JvZ22Yb9d2AQNzXV7vbV57hY+Mrc4Dy8UmWwVE5Uzrr7L83O3
         LPnw==
X-Gm-Message-State: AGi0PuZEB9nCqKWphhcvzEZLChQ8Gdt28a01blZ4j0lncct8gmjYIFAa
        qDBh5ym6VQEcYQtYSklEd+rsVDfqiHcM3yA8MLkgBYZ6lYiE5ROMW5E56CfWK8nOBsRHisH6I2U
        ZEhDeZrEbsG2x
X-Received: by 2002:a2e:5ce:: with SMTP id 197mr8443874ljf.234.1585311881194;
        Fri, 27 Mar 2020 05:24:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsawMB3aEM37Jpmcuqewkciu2tzCjDejZAco2JHqvmvthSuGn1Bt2m4GUyqM9mRg3sz6u2W3g==
X-Received: by 2002:a2e:5ce:: with SMTP id 197mr8443864ljf.234.1585311880946;
        Fri, 27 Mar 2020 05:24:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h6sm2655635lji.39.2020.03.27.05.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 05:24:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CF82618158B; Fri, 27 Mar 2020 13:24:37 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next] libbpf: Add bpf_object__rodata getter function
In-Reply-To: <CAEf4BzYxJjJygu_ZqJJB03n=ZetxhuUE7eLD9dsbkbvzQ5M08w@mail.gmail.com>
References: <20200326151741.125427-1-toke@redhat.com> <CAEf4BzYxJjJygu_ZqJJB03n=ZetxhuUE7eLD9dsbkbvzQ5M08w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 27 Mar 2020 13:24:37 +0100
Message-ID: <87eetem1dm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Mar 26, 2020 at 8:18 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> This adds a new getter function to libbpf to get the rodata area of a bpf
>> object. This is useful if a program wants to modify the rodata before
>> loading the object. Any such modification needs to be done before loadin=
g,
>> since libbpf freezes the backing map after populating it (to allow the
>> kernel to do dead code elimination based on its contents).
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  tools/lib/bpf/libbpf.c   | 13 +++++++++++++
>>  tools/lib/bpf/libbpf.h   |  1 +
>>  tools/lib/bpf/libbpf.map |  1 +
>>  3 files changed, 15 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 085e41f9b68e..d3e3bbe12f78 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -1352,6 +1352,19 @@ bpf_object__init_internal_map(struct bpf_object *=
obj, enum libbpf_map_type type,
>>         return 0;
>>  }
>>
>> +void *bpf_object__rodata(const struct bpf_object *obj, size_t *size)
>
> We probably don't want to expose this API. It just doesn't scale,
> especially if/when we add support for custom sections names for global
> variables.

Right. I was not aware of any such plans, but OK.

> Also checking for map->mmaped is too restrictive. See how BPF skeleton
> solves this problem and still allows .rodata initialization even on
> kernels that don't support memory-mapping global variables.

Not sure what you mean here? As far as I can tell, the map->mmaped
pointer has nothing to do with the kernel support for mmaping the map
contents. It's just what libbpf does to store the data of any
internal_maps?

I mean, bpf_object__open_skeleton() just does this:

		if (mmaped && (*map)->libbpf_type !=3D LIBBPF_MAP_KCONFIG)
			*mmaped =3D (*map)->mmaped;

which amounts to the same as I'm doing in this patch?

> But basically, why can't you use BPF skeleton?

Couple of reasons:

- I don't need any of the other features of the skeleton
- I don't want to depend on bpftool in the build process
- I don't want to embed the BPF bytecode into the C object

> Also, application can already find that map by looking at name.

Yes, it can find the map, but it can't access the data. But I guess I
could just add a getter for that. Just figured this was easier to
consume; but I can see why it might impose restrictions on future
changes, so I'll send a v2 with such a map-level getter instead.

-Toke

