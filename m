Return-Path: <bpf+bounces-49074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E7DA14143
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 18:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8103A9AC6
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 17:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B2C22BADC;
	Thu, 16 Jan 2025 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gyw6pFlV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3089148855
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737049974; cv=none; b=rdzhZs0V0xtRHEwmqX08wXBfs8eGwq3BGt2FHtQwr98Y7TfIgsRaThohyQDF6IGdxKKO9e70FlpQ9cvDSiElMjMlFRx4vYBy7PVuXktvrzwDhiRxw6QMY/LBs3q9Vn2fXqyjLHKmXsitiJVxO65502bSaJorxszhVvahH055JSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737049974; c=relaxed/simple;
	bh=WJ1atS1u2OjXI0zxuJx8G0gOOQDMhWz58vcH7tyJE3Y=;
	h=From:Content-Type:Mime-Version:Subject:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Pee7nBdzHJNSFC6EKppZIPlXaSAKkiL/3G139Z5VjdpMYuVXOafBAXAVrgLdMRwCUxFdkEau5ZL+4EC9+8qgY9cLCio1HDUbkRtpyAuchDan9kFJwfdnV7WrRgyLaLYBfUa7Nn6J6MRQcQmHmeRm2rhkKieLoc1Tc3VgMNF+k5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gyw6pFlV; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso238208966b.1
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 09:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737049971; x=1737654771; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XZ5DbNX5MP9Zoq5Q7ZnbicZZW6C/ry+5qO+2BNfeaI=;
        b=Gyw6pFlV/2Uu7GR4XOD9LfT3zzSi5mUoA00wokjMNu4OAnvl8xm8rgcwyColk6ibHy
         uzumkdnWytb0lO4bUawKwwlyFF1MU7+I6l2iUUnfF4GQUuEBczFGF2bGdpaG3C/+OP3o
         mP2dJnzvDbQBnyI+FEsac+weLXInM+wfIPDjtauXds+Ig4zCOcJC5j7YSm4jGraABej7
         y8OCHkkAzpTKsGu3IKSk7rQ/N+vhSIGAl026tWmeg1qANZ7LND82WBsGrRgoR9QavRZX
         zHLKOZcaEReGyJiUOSqCwPo9AXe9X981y+9e98QwB7iQdRS3KHtFCZxdj2yYNqrO9J4s
         IOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737049971; x=1737654771;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XZ5DbNX5MP9Zoq5Q7ZnbicZZW6C/ry+5qO+2BNfeaI=;
        b=K3569vV7tIRGTXZzyhFl9+O/nrz8koz4rHYEXjgcqefMoz1ebxbB+Z0tPL0rB49vJv
         CsxtDkUJGUsAOWRMidGZ8lwmXMA7yfZcArvCJ1aEyn/U/lVvZil7NDZrRx5hBZXiVyai
         dKlV8ItN6iyqKfFtDT+0KiluGZpUqN4k0RT7gCqjKyr24ady8PYXYrUbqeQnQms0qv5m
         RYoopuIzgYGo6PSi+VyNP7cZAkwrZm8CTON6yVNiVn0ahanPsyY9g72QT7XLmKGoT/sF
         5Q2rz3A9uLdhg8prpBQjS5EmBeFbD5LWUIE80Ulpp+w/zxZ9DA5hm00qYIln/gyeK7Ot
         Sd5g==
X-Forwarded-Encrypted: i=1; AJvYcCVeBV/A9Qzq/UHaJOkiT5KnkiOYh95BriP6m3qxGMods3OYESS0yWrmloPPIM2DQ+mUCxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiNCaj0hYoVJ3pf/K8W6WcCJszpm8Q7uFpIXXEDh82f3rz2wHi
	lY3P/0EHPnyc8wX7I6Mc+YPpDDbydRH2NWOzDpb0NU3Jp/TOrR5s
X-Gm-Gg: ASbGncuV3u6NaR2eQfyD4dZeZdh8Vs1TWmodoxsCh97Fu0VqDNeoAJLP5SWKrh+hRjZ
	bvcWCwFizcWfR9yeWG67cqdDzQ5T1t+5QT2Oor4tdHQj84kfLCi1/9CfEh6N8J+3zLTfqlopKwS
	MT3bKKpmCu8PNjlje3LAAy6hX9cP+B1euZg3p/9N1b5hTk/1Dv/7PutFsArsIFc97i8YmPwOLNh
	TIRUWhOd+ng2BnojzuHwCLK5F0Vzv6woHHtGX74mqXoiEGGdiEYXRH2rgYIzmcRop0Vjg==
X-Google-Smtp-Source: AGHT+IGrdBBWLNwMg9chZgLjbf/G2853uo4S1cpcYY3xN1hOD1lVRBzFFsVxJYtOundJ5hl/7xSMhg==
X-Received: by 2002:a17:907:9612:b0:ab3:60eb:f858 with SMTP id a640c23a62f3a-ab360ebf999mr480730466b.38.1737049970797;
        Thu, 16 Jan 2025 09:52:50 -0800 (PST)
Received: from smtpclient.apple ([209.38.224.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f8d86esm26821166b.154.2025.01.16.09.52.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jan 2025 09:52:50 -0800 (PST)
From: Nick Zavaritsky <mejedi@gmail.com>
X-Google-Original-From: Nick Zavaritsky <MeJedi@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH bpf-next 0/4] expose number of map entries to userspace
In-Reply-To: <Z4ke1A1agEko41v8@eis>
Date: Thu, 16 Jan 2025 18:52:38 +0100
Cc: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 aspsk2@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AC7968EC-73CA-415B-8FAD-70C805075479@gmail.com>
References: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
 <28acb589-6632-4250-a8ca-00eacda03305@iogearbox.net> <Z3zcTB+SjPK5QOt9@eis>
 <CAAvdH+yNG=GefEd5CcP_52gPzzZexWMMxFAxnM3isX04iErMfQ@mail.gmail.com>
 <CAAvdH+wHjWEvO3e0_=o4imJZq1082pzp-qszbQvj_Ev50eQCrw@mail.gmail.com>
 <Z4AJY8orP8JMzvhW@eis> <68891842-975E-48B0-AED5-875F3ABC5F49@gmail.com>
 <Z4ke1A1agEko41v8@eis>
To: Anton Protopopov <aspsk@isovalent.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)


> On 16. Jan 2025, at 15:59, Anton Protopopov <aspsk@isovalent.com> =
wrote:
>=20
> On 25/01/14 12:38PM, Nick Zavaritsky wrote:
>>=20
>>> On 9. Jan 2025, at 18:37, Anton Protopopov <aspsk@isovalent.com> =
wrote:
>>>=20
>>> On 25/01/07 12:10PM, Charalampos Stylianopoulos wrote:
>>>> (sorry for double posting, this time in plain text)
>>>> Thanks a lot for the feedback!
>>>>=20
>>>> So, to double check, the suggestion is to only extend the libbpf =
API
>>>> with a new helper that does pretty much what get_cur_elements() =
does
>>>> in tools/testing/selftests/bpf/map_tests/map_percpu_stats.c ?
>>>=20
>>> What is your use case for getting the number of elements in a
>>> particular map? Will it work for you to just use a variant of
>>> get_cur_elements() from selftests vs. adding new API to libbpf?
>>=20
>> (On behalf of Charalampos Stylianopoulos) we would like to get the
>> number of elements in some maps for monitoring purposes. The end goal =
is
>> to get someone paged when a fixed-capacity map is about to start
>> rejecting inserts.
>>=20
>> We aim to operate a large number of apps in containers (custom packet
>> processing services, telekom). We find it most convenient for an app
>> itself to expose metrics concerning the maps it has created.
>>=20
>> We currently use a map iterator and a bunch of bpf_probe_read_kernel. =
We
>> foresee the number of maps in our systems getting significantly =
higher
>> in the near future. Therefore enumerating every map in the system to =
get
>> a number of elements in a particular map doesn't look sustainable.
>>=20
>> How do you feel about introducing bpf_map_sum_elem_count_by_fd kfunc,
>> available in syscall programs?
>=20
> This should work already, something like
>=20
>    __s64 bpf_map_sum_elem_count(const struct bpf_map *map) __ksym;
>    __s64 ret_user;
>=20
>    struct {
>            __uint(type, BPF_MAP_TYPE_HASH);
>            __type(key, int);
>            __type(value, int);
>            __uint(max_entries, 4);
>    } your_map SEC(".maps");
>=20
>    SEC("syscall")
>    int sum(void *ctx)
>    {
>            struct bpf_map *map =3D (struct bpf_map *)&your_map;
>=20
>            ret_user =3D bpf_map_sum_elem_count(map);
>=20
>            return 0;
>    }
>=20
>    char _license[] SEC("license") =3D "GPL";
>=20
> Is this sufficient for your use case?

Technically it works. One can add a program similar to the snippet below
to their bpf code to expose the number of elements in every map of
interest.

struct stats { __s64 a, b, c, d; };
SEC(=E2=80=9C.maps=E2=80=9D) struct { ... } a, b, c, d;

SEC(=E2=80=9Csyscall=E2=80=9D)
int sum_element_count_bulk(void *ctx)
{
    struct stats *stats =3D ctx;
    stats->a =3D bpf_map_sum_element_count((void *)a);
    stats->b =3D bpf_map_sum_element_count((void *)b);
    ...
    return 0;
}

The downside is that it is boilerplate code that has to be written every
single time. With the proposed bpf_map_sum_element_count_by_fd, one can
have a library in user space that offers convenient
sum_element_count(int fd).

It could leverage the following bpf program behind the scenes:

SEC(=E2=80=9Csyscall=E2=80=9D)
int sum_element_count(void *ctx)
{
    *(__s64 *)ctx =3D bpf_map_sum_element_count_by_fd(*(int *)ctx);
    return 0;
}

>=20
>>>=20
>>> [Also, please try not to top-post, see =
https://www.idallen.com/topposting.html]
>>>=20
>>>>> On Tue, 7 Jan 2025 at 08:44, Anton Protopopov =
<aspsk@isovalent.com> wrote:
>>>>>>=20
>>>>>> On 25/01/06 05:19PM, Daniel Borkmann wrote:
>>>>>>> On 1/6/25 3:53 PM, Charalampos Stylianopoulos wrote:
>>>>>>>> This patch series provides an easy way for userspace =
applications to
>>>>>>>> query the number of entries currently present in a map.
>>>>>>>>=20
>>>>>>>> Currently, the number of entries in a map is accessible only =
from kernel space
>>>>>>>> and eBPF programs. A userspace program that wants to track map =
utilization has to
>>>>>>>> create and attach an eBPF program solely for that purpose.
>>>>>>>>=20
>>>>>>>> This series makes the number of entries in a map easily =
accessible, by extending the
>>>>>>>> main bpf syscall with a new command. The command supports only =
maps that already
>>>>>>>> track utilization, namely hash maps, LPM maps and queue/stack =
maps.
>>>>>>>=20
>>>>>>> An earlier attempt to directly expose it to user space can be =
found here [0], which
>>>>>>> eventually led to [1] to only expose it via kfunc for BPF =
programs in order to avoid
>>>>>>> extending UAPI.
>>>>>>>=20
>>>>>>> Perhaps instead add a small libbpf helper (e.g. =
bpf_map__current_entries to complement
>>>>>>> bpf_map__max_entries) which does all the work to extract that =
info via [1] underneath?
>>>>>>=20
>>>>>> One small thingy here is that bpf_map_sum_elem_count() is only
>>>>>> available from the map iterator. Which means that to get the
>>>>>> bpf_map_sum_elem_count() for one map only, one have to iterate
>>>>>> through the whole set of maps (and filter out all but one).
>>>>>>=20
>>>>>> I wanted to follow up my series by either adding the result of
>>>>>> calling bpf_map_sum_elem_count() to map_info as u32 or to add
>>>>>> possibility to provide a map_fd/map_id when creating an iterator
>>>>>> (so that it is only called for one map). But so far I haven't
>>>>>> a real use case for getting the number of elements for one map =
only.
>>>>>>=20
>>>>>>> Thanks,
>>>>>>> Daniel
>>>>>>>=20
>>>>>>> [0] =
https://lore.kernel.org/bpf/20230531110511.64612-1-aspsk@isovalent.com/
>>>>>>> [1] =
https://lore.kernel.org/bpf/20230705160139.19967-1-aspsk@isovalent.com/
>>>>>>>     =
https://lore.kernel.org/bpf/20230719092952.41202-1-aspsk@isovalent.com/
>>>>>>>=20
>>>>>>>> Charalampos Stylianopoulos (4):
>>>>>>>>  bpf: Add map_num_entries map op
>>>>>>>>  bpf: Add bpf command to get number of map entries
>>>>>>>>  libbpf: Add support for MAP_GET_NUM_ENTRIES command
>>>>>>>>  selftests/bpf: Add tests for bpf_map_get_num_entries
>>>>>>>>=20
>>>>>>>> include/linux/bpf.h                           |  3 ++
>>>>>>>> include/linux/bpf_local_storage.h             |  1 +
>>>>>>>> include/uapi/linux/bpf.h                      | 17 +++++++++
>>>>>>>> kernel/bpf/devmap.c                           | 14 ++++++++
>>>>>>>> kernel/bpf/hashtab.c                          | 10 ++++++
>>>>>>>> kernel/bpf/lpm_trie.c                         |  8 +++++
>>>>>>>> kernel/bpf/queue_stack_maps.c                 | 11 +++++-
>>>>>>>> kernel/bpf/syscall.c                          | 32 =
+++++++++++++++++
>>>>>>>> tools/include/uapi/linux/bpf.h                | 17 +++++++++
>>>>>>>> tools/lib/bpf/bpf.c                           | 16 +++++++++
>>>>>>>> tools/lib/bpf/bpf.h                           |  2 ++
>>>>>>>> tools/lib/bpf/libbpf.map                      |  1 +
>>>>>>>> .../bpf/map_tests/lpm_trie_map_basic_ops.c    |  5 +++
>>>>>>>> tools/testing/selftests/bpf/test_maps.c       | 35 =
+++++++++++++++++++
>>>>>>>> 14 files changed, 171 insertions(+), 1 deletion(-)



