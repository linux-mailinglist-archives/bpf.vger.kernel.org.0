Return-Path: <bpf+bounces-48762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6891EA10598
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 12:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EED6168072
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 11:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E077A20F967;
	Tue, 14 Jan 2025 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWRvqCSW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995BE234D17
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 11:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854752; cv=none; b=njzGZgsw18JBekKaX3WEte1spot58vF59ER/aYbNKQsjdkUc599fk6geFlxdytYLOd2ExEn0dmQbEhxMXmOBlQf4YDHeQI3NzomJ36DbFKmSXwQNl/OuJsOrMT7Vxx7XfWQ4FUv4UXiulm/RXEWrjA8RtM65c/jwbRc7lFpsLcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854752; c=relaxed/simple;
	bh=5NM0kEE/uNfiFjSqXIucxgm8i9WgO+fMB6FQIg8oaZ4=;
	h=From:Content-Type:Mime-Version:Subject:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=P+T6x0AtuHqAZtGEJwVji3KoND2+W/LhLe7I7hKUYDaWevAT7xGfOCu46JFkHng0VVlni8pJvGXvjARfdOFDK5ITJq1YIXNih6xG4eRYjEwdm8tv6AnHz2/Rgs7mNGxiE6P9Rs1XESroNvgWICu/psOhBtfpYyCc1sBH0Wxjb4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWRvqCSW; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aae81f4fdc4so1025191766b.0
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 03:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736854749; x=1737459549; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnU+8PIx6gYPY+/VWTK0OqE91Rt3g6HtxqFIRRco4b0=;
        b=jWRvqCSWsox2i119/A8Pibkd2jZJpeoDTI1J3d/okzysEdSVA7iVS52cP+G7OWc0rz
         BaD+mZVwMISn9Hryua2wxlNtv3a386hWSku5QDvtpg9S63mY/hF7dRKv1p5rA/JoeX18
         YUlqudT7WvIw+ORga4jASZjOV+Sc3RgGTh7zNIKmaqqAqvXRd2buAUENgtY4e5NhSWv2
         PPLzwgEX37sKRAxD6GT3uTKlXxLAdbZ5UdyUTfxQGJRiwVbxWcR4ORnNBTxyxOJazjdP
         vGA98E2H3ZefMoVtSnW3e8fIEgIrPxpNVokwCRFN7KIkFEd4uXBmVqnfV0i7Xn78uHbU
         /OFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736854749; x=1737459549;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnU+8PIx6gYPY+/VWTK0OqE91Rt3g6HtxqFIRRco4b0=;
        b=FWzJtRJJ+swyZRqBgQypaIU+ABl5NHThficCLZAuD3TnG7+5vYgWMgIKnU3j1CYbrV
         P0U5abAV+cEJ3RXeKsXsa+f9CLcU55vQcRAQxaKVycOoeXWW1W9q2BL2by3OWYYVUsy+
         asNHxORyDb0z4GCJCj9fnL3xYu/UQ2LH3adnOJOfXvMUnWAZRv8m3k4UBY6/ZG2nzfgL
         LEqHobbyV227faf/WgoiZ/PxeRU01tr6euVN4r9GJkZpOEAUL8TN8/4ZizmyVQoUGoUz
         fEddAUQn8faPbsE1D7zcVh0NBslbRk3sz/AroM4/TWy3RRetQy1ZbDOul3o4pkIop+tE
         PJVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+mJIlv2hFTM2zpy7mdmhz8l0oSDveoH1pSOXJfeWRRkNbTZSYxrFJ360u6ptZtlqNdzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1PkFaOhSESaA7P93+Fxox8reVkGiBQxD0n303bOM/NhRwgXj
	3hjy92dII2j0i/Vyo9ow4dYerJQYtGL92a0w/nwBJPLhNinqI/xx
X-Gm-Gg: ASbGncuF2BwSw/AlFPtW+GepcH1AQUYhMNkUR2SJK8tSYzdd6Vx2SHc0OZ/NF9Gz100
	Eidw669iOQ6kFt7qd71pkO4GRqiMTMe9iOVkLs3VHqtZvBxYkYzGXMHktdwnYSQXlz7qTh0zzIk
	lp/LG3wu6lDxph8beTbahsYeN6DyjuohDbzdNYyc1tB0w0jJFPbvvtIEvCvedMTgGriHR7Z7fJR
	xzxameKBO7gQHIrkG/3syme3Ccu8CtPprJPIhvJQIE3tilSVjtkEF4bL/7q9kYed5HOSA==
X-Google-Smtp-Source: AGHT+IEikSFYmzJcWezaK9uP/nOEmyhZZSRMSMRVR3FAjh13gS68ZT9eo8kJ4378A9vwobGHRoy/hg==
X-Received: by 2002:a17:907:3687:b0:aa6:8814:1545 with SMTP id a640c23a62f3a-ab2abcabac8mr2767453666b.41.1736854748924;
        Tue, 14 Jan 2025 03:39:08 -0800 (PST)
Received: from smtpclient.apple ([209.38.224.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c964924bsm628158966b.179.2025.01.14.03.39.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2025 03:39:08 -0800 (PST)
From: Nick Zavaritsky <mejedi@gmail.com>
X-Google-Original-From: Nick Zavaritsky <MeJedi@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: [PATCH bpf-next 0/4] expose number of map entries to userspace
In-Reply-To: <Z4AJY8orP8JMzvhW@eis>
Date: Tue, 14 Jan 2025 12:38:56 +0100
Cc: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 aspsk2@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <68891842-975E-48B0-AED5-875F3ABC5F49@gmail.com>
References: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
 <28acb589-6632-4250-a8ca-00eacda03305@iogearbox.net> <Z3zcTB+SjPK5QOt9@eis>
 <CAAvdH+yNG=GefEd5CcP_52gPzzZexWMMxFAxnM3isX04iErMfQ@mail.gmail.com>
 <CAAvdH+wHjWEvO3e0_=o4imJZq1082pzp-qszbQvj_Ev50eQCrw@mail.gmail.com>
 <Z4AJY8orP8JMzvhW@eis>
To: Anton Protopopov <aspsk@isovalent.com>
X-Mailer: Apple Mail (2.3826.300.87.4.3)


> On 9. Jan 2025, at 18:37, Anton Protopopov <aspsk@isovalent.com> =
wrote:
>=20
> On 25/01/07 12:10PM, Charalampos Stylianopoulos wrote:
>> (sorry for double posting, this time in plain text)
>> Thanks a lot for the feedback!
>>=20
>> So, to double check, the suggestion is to only extend the libbpf API
>> with a new helper that does pretty much what get_cur_elements() does
>> in tools/testing/selftests/bpf/map_tests/map_percpu_stats.c ?
>=20
> What is your use case for getting the number of elements in a
> particular map? Will it work for you to just use a variant of
> get_cur_elements() from selftests vs. adding new API to libbpf?

(On behalf of Charalampos Stylianopoulos) we would like to get the
number of elements in some maps for monitoring purposes. The end goal is
to get someone paged when a fixed-capacity map is about to start
rejecting inserts.

We aim to operate a large number of apps in containers (custom packet
processing services, telekom). We find it most convenient for an app
itself to expose metrics concerning the maps it has created.

We currently use a map iterator and a bunch of bpf_probe_read_kernel. We
foresee the number of maps in our systems getting significantly higher
in the near future. Therefore enumerating every map in the system to get
a number of elements in a particular map doesn't look sustainable.

How do you feel about introducing bpf_map_sum_elem_count_by_fd kfunc,
available in syscall programs?


>=20
> [Also, please try not to top-post, see =
https://www.idallen.com/topposting.html]
>=20
>>> On Tue, 7 Jan 2025 at 08:44, Anton Protopopov <aspsk@isovalent.com> =
wrote:
>>>>=20
>>>> On 25/01/06 05:19PM, Daniel Borkmann wrote:
>>>>> On 1/6/25 3:53 PM, Charalampos Stylianopoulos wrote:
>>>>>> This patch series provides an easy way for userspace applications =
to
>>>>>> query the number of entries currently present in a map.
>>>>>>=20
>>>>>> Currently, the number of entries in a map is accessible only from =
kernel space
>>>>>> and eBPF programs. A userspace program that wants to track map =
utilization has to
>>>>>> create and attach an eBPF program solely for that purpose.
>>>>>>=20
>>>>>> This series makes the number of entries in a map easily =
accessible, by extending the
>>>>>> main bpf syscall with a new command. The command supports only =
maps that already
>>>>>> track utilization, namely hash maps, LPM maps and queue/stack =
maps.
>>>>>=20
>>>>> An earlier attempt to directly expose it to user space can be =
found here [0], which
>>>>> eventually led to [1] to only expose it via kfunc for BPF programs =
in order to avoid
>>>>> extending UAPI.
>>>>>=20
>>>>> Perhaps instead add a small libbpf helper (e.g. =
bpf_map__current_entries to complement
>>>>> bpf_map__max_entries) which does all the work to extract that info =
via [1] underneath?
>>>>=20
>>>> One small thingy here is that bpf_map_sum_elem_count() is only
>>>> available from the map iterator. Which means that to get the
>>>> bpf_map_sum_elem_count() for one map only, one have to iterate
>>>> through the whole set of maps (and filter out all but one).
>>>>=20
>>>> I wanted to follow up my series by either adding the result of
>>>> calling bpf_map_sum_elem_count() to map_info as u32 or to add
>>>> possibility to provide a map_fd/map_id when creating an iterator
>>>> (so that it is only called for one map). But so far I haven't
>>>> a real use case for getting the number of elements for one map =
only.
>>>>=20
>>>>> Thanks,
>>>>> Daniel
>>>>>=20
>>>>>  [0] =
https://lore.kernel.org/bpf/20230531110511.64612-1-aspsk@isovalent.com/
>>>>>  [1] =
https://lore.kernel.org/bpf/20230705160139.19967-1-aspsk@isovalent.com/
>>>>>      =
https://lore.kernel.org/bpf/20230719092952.41202-1-aspsk@isovalent.com/
>>>>>=20
>>>>>> Charalampos Stylianopoulos (4):
>>>>>>   bpf: Add map_num_entries map op
>>>>>>   bpf: Add bpf command to get number of map entries
>>>>>>   libbpf: Add support for MAP_GET_NUM_ENTRIES command
>>>>>>   selftests/bpf: Add tests for bpf_map_get_num_entries
>>>>>>=20
>>>>>>  include/linux/bpf.h                           |  3 ++
>>>>>>  include/linux/bpf_local_storage.h             |  1 +
>>>>>>  include/uapi/linux/bpf.h                      | 17 +++++++++
>>>>>>  kernel/bpf/devmap.c                           | 14 ++++++++
>>>>>>  kernel/bpf/hashtab.c                          | 10 ++++++
>>>>>>  kernel/bpf/lpm_trie.c                         |  8 +++++
>>>>>>  kernel/bpf/queue_stack_maps.c                 | 11 +++++-
>>>>>>  kernel/bpf/syscall.c                          | 32 =
+++++++++++++++++
>>>>>>  tools/include/uapi/linux/bpf.h                | 17 +++++++++
>>>>>>  tools/lib/bpf/bpf.c                           | 16 +++++++++
>>>>>>  tools/lib/bpf/bpf.h                           |  2 ++
>>>>>>  tools/lib/bpf/libbpf.map                      |  1 +
>>>>>>  .../bpf/map_tests/lpm_trie_map_basic_ops.c    |  5 +++
>>>>>>  tools/testing/selftests/bpf/test_maps.c       | 35 =
+++++++++++++++++++
>>>>>>  14 files changed, 171 insertions(+), 1 deletion(-)
>>>>>>=20
>>>>>=20


