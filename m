Return-Path: <bpf+bounces-55669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9665A84AFA
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B58A3B6D24
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1382F1F1512;
	Thu, 10 Apr 2025 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4c5j5qY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0050E1E9B29
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306089; cv=none; b=bkyboiZ6hJga5qF2nu1coLh15fBz5K8MufSHKIxrAaVxX+bHPaxfdokpH4bdFC8o3py2gZeUWRUphoQuHTx/0v4I36mLM0qBrHlTGt0CNhTYSGYIPzkJL+rfsUFM2itDECKGX3KdM98jxradxgZndIR7UEblgj/EMr0tbdLXUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306089; c=relaxed/simple;
	bh=jROyQTBEMNW6ZzY0nBU3lJd8n2HnDfraN2pnbnmKSls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTiwqrWCNzFgg91DZ+06IO1VBx3xlyupAO7THTDyfZhnTFXkPHEzDTv/L4f0KTjGReQ93S2jREDHh7D8pPt4ISRtrhNnR1+E5rcoBl2Btq1xy9690RH7cNDugOY2NwwLktMfJ+J9LQXL3jwk3G2kOzrgvK7kdO/JnTvo24Iiq+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4c5j5qY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736b350a22cso959022b3a.1
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 10:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744306087; x=1744910887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o82oV3In8MpcBXFHI+6/k/TDfqufekQ533/T2vQfzqI=;
        b=g4c5j5qYWkiwqMyfGpzueIkvLKkzkDvYxg3oqjuYMHseE2BaHvmd8gScETLUBNE71n
         jf9LCJWsXtn1EoLrAHq+2z78A6E4/Hgida5yxU4qsJNUFIL37YDf7oqvPAmr01nBavfT
         A1a/kYu+Oe8AI3X52y3bAUDzLLgFBAJmstKZQxpJ7JAL+IXXDLiDQqHyZ0Wp9F+5bV65
         Vnxy0CiXnCgoSOY3JxHF9cpRjDxtzxlVBD1f2XmwfVmcn8YtI9SKI0zwYyIYVAkqk0th
         wrKi9/4VEiadmp5rm+CCHJd6RlPnnin32U+RlzurW1C3icJ67dIou0MUjKMypqc7V3pt
         AM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306087; x=1744910887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o82oV3In8MpcBXFHI+6/k/TDfqufekQ533/T2vQfzqI=;
        b=O7srybnJF/rRzUob5noNGe+79SCCdncRvy/y7fVG6EZjU0FrrcKrwiQc7QsoLX8pj/
         cBZ8z9dQyelGS21l/YkpyiZGYzM2gKhPSt7ee7RwXMXxtHrcJaxlzTs2wp0c7hKgEVRn
         db/cELxR0CUCMk6j91pEiiY6evI0bn4z0gwMEzUgg3k64niMI8ZpZcMzL9dbtS6/vG2o
         w/J9frnt93tbiQYEy1tjfSWC3/0lstiG0X5VxSyZH/Sha4d1viVe/G6FmCDN64UVdNYd
         A4ANNuA+HV83paoRE0tGfxtofg/qQIEYG3aSqFAUofxEwxOxxP6zPQhwc6DvsduUiUd0
         qdPA==
X-Gm-Message-State: AOJu0YzIOHaK3jKIrQNpSF2ejU5aKN0GsEzOVa4flazRe0BFLuSEfOMN
	ZWJrEQmgCvDXNsgxZwxgEOYaDk8BeJ0IiHnNMYtxHqHzxtVBYYjhbNWe/YVwbhWWdkp2aMVd6Ih
	ROWaOdN9ZeVWjnJZcFdKff1xSaVU=
X-Gm-Gg: ASbGncvW7W0arigCAIAtw3GgxZqjz60CfaEs5fSiAD5m5nmCpX+ENuszT9ukyRpMqbC
	xMSaVHrUqsBKMxCubFNdM+Th3ggNy24xAnSnUvMSiLHG4e5e/cwfp2V2Lu6vdlrIqcE9e21P7Mh
	pWW6gCpylwLVt9rVlklCacncmnH5nLHR9auEU4g/p/ucYOn+g=
X-Google-Smtp-Source: AGHT+IFIrhkpzAzQSl67GuYtlWMmi5T6/ghO2woRNDh1kn9v8A/0qPSfijkKfxnQWiqneOlXOJX3mNiJVBS7fLbKbWI=
X-Received: by 2002:a05:6a00:398d:b0:736:b101:aed3 with SMTP id
 d2e1a72fcca58-73bbee3255emr4577066b3a.1.1744306087137; Thu, 10 Apr 2025
 10:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327083455.848708-1-houtao@huaweicloud.com>
 <20250327083455.848708-16-houtao@huaweicloud.com> <CAEf4BzY6Y=40NHs12r3Jb7u_N8CVapwRuF09+dmxBH85J2t88w@mail.gmail.com>
 <34a1d3a2-0b63-7f11-9da2-5966b24e179b@huaweicloud.com> <CAEf4BzZY5OSBs3xEdhgC7hjwjQ9C4j+uyLxjjqAjc-ek_pJRog@mail.gmail.com>
 <07052375-1923-9a3e-2eee-a3bb9eae372d@huaweicloud.com> <CAEf4BzbiTTi=3RYwW6F4+DiPEB0t1K+ToHH0yhF38dR9d0mfJw@mail.gmail.com>
 <515e234f-8c29-065c-11c6-5128106795fa@huaweicloud.com>
In-Reply-To: <515e234f-8c29-065c-11c6-5128106795fa@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Apr 2025 10:27:55 -0700
X-Gm-Features: ATxdqUEEJKujxHb3VXk5JpT3-gbtsUEtaGVm4tmOcn4rgaysuHHiJ2Fg6ezNMek
Message-ID: <CAEf4BzYJ+EPR0F7LTgxFDyZaYj3Xv-wJn8mKG9kHSEQFHM8pmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 15/16] selftests/bpf: Add test cases for hash
 map with dynptr key
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 6:09=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 4/10/2025 7:40 AM, Andrii Nakryiko wrote:
> > On Mon, Apr 7, 2025 at 7:24=E2=80=AFPM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >> Hi,
> >>
> >> On 4/8/2025 12:05 AM, Andrii Nakryiko wrote:
> >>> On Sun, Apr 6, 2025 at 7:47=E2=80=AFPM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> >>>> Hi,
> >>>>
> >>>> On 4/5/2025 1:58 AM, Andrii Nakryiko wrote:
> >>>>> On Thu, Mar 27, 2025 at 1:23=E2=80=AFAM Hou Tao <houtao@huaweicloud=
.com> wrote:
> >>>>>> From: Hou Tao <houtao1@huawei.com>
> >>>>>>
> >>>>>> Add three positive test cases to test the basic operations on the
> >>>>>> dynptr-keyed hash map. The basic operations include lookup, update=
,
> >>>>>> delete and get_next_key. These operations are exercised both throu=
gh
> >>>>>> bpf syscall and bpf program. These three test cases use different =
map
> >>>>>> keys. The first test case uses both bpf_dynptr and a struct with o=
nly
> >>>>>> bpf_dynptr as map key, the second one uses a struct with an intege=
r and
> >>>>>> a bpf_dynptr as map key, and the last one use a struct with two
> >>>>>> bpf_dynptr as map key: one in the struct itself and another is nes=
ted in
> >>>>>> another struct.
> >>>>>>
> >>>>>> Also add multiple negative test cases for dynptr-keyed hash map. T=
hese
> >>>>>> test cases mainly check whether the layout of dynptr and non-dynpt=
r in
> >>>>>> the stack is matched with the definition of map->key_record.
> >>>>>>
> >>>>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >>>>>> ---
> >>>>>>  .../bpf/prog_tests/htab_dynkey_test.c         | 446 +++++++++++++=
+++++
> >>>>>>  .../bpf/progs/htab_dynkey_test_failure.c      | 266 +++++++++++
> >>>>>>  .../bpf/progs/htab_dynkey_test_success.c      | 382 +++++++++++++=
++
> >>>>>>  3 files changed, 1094 insertions(+)
> >>>>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/htab_dy=
nkey_test.c
> >>>>>>  create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_=
test_failure.c
> >>>>>>  create mode 100644 tools/testing/selftests/bpf/progs/htab_dynkey_=
test_success.c
> >>>>>>

[...]

> >>>>>> +       /* Lookup it again */
> >>>>>> +       value =3D bpf_map_lookup_elem(htab, &key);
> >>>>>> +       bpf_ringbuf_discard_dynptr(&key.f_3.name, 0);
> >>>>>> +       if (value) {
> >>>>>> +               err =3D 12;
> >>>>>> +               goto out;
> >>>>>> +       }
> >>>>>> +out:
> >>>>>> +       return err;
> >>>>>> +}
> >>>>> So, I'm not a big fan of this approach of literally embedding struc=
t
> >>>>> bpf_dynptr into map key type and actually initializing and working
> >>>>> with it directly, like you do here with
> >>>>> bpf_ringbuf_reserve_dynptr(..., &key.f_3.name).
> >>>>>
> >>>>> Here's why. This approach only works for *map keys* (not map values=
)
> >>>>> and only when **the copy of the key** is on the stack (i.e., for ma=
p
> >>>>> lookups/updates/deletes). This approach won't work for having dynpt=
rs
> >>>>> inside map value (for variable sized map values), nor does it reall=
y
> >>>>> work when you get a direct pointer to map key in
> >>>>> bpf_for_each_map_elem().
> >>>> Yes. The reason why the key should be on the stack is due to the
> >>>> limitation (or the design) of bpf_dynptr. However I didn't understan=
d
> >>>> why it doesn't work for map value just like other special field in t=
he
> >>>> map value (e.g., bpf_timer) ?
> >>> bpf_timer and other special things that go into map_value have to
> >>> painfully and carefully handle simultaneous access and modification o=
f
> >>> map value. So they either do locking (and thus are not compatible or
> >>> reliable under NMI), or would need to be implemented locklessly.
> >>>
> >>> Dynptr is by design assumed to not be dealing with concurrent
> >>> modifications, so bpf_dynptr_adjust(), for instance, can just update
> >>> offset in place without any locking. Reliably and quickly.
> >> Thanks for the explanation here and below. I got it now: multiple bpf
> >> program could get the same map value through lookup and modify it
> >> concurrently through helpers or kfuncs. A bit of slow for me to figure
> >> out by myself. However, I think there is a big difference between
> >> bpf_dynptr and bpf_timer or other special fields. For bpf_timer, we
> >> could not update it through bpf_map_update_elem, so extra helpers or
> >> kfuncs are needed. However, for bpf_dynptr in map key/value, it could =
be
> >> updated through bpf_map_{update|delete}_elem(). Therefore, for dynptr =
in
> >> map key or map value, does it really need to allow update through
> >> non-map-update helpers and kfuncs ? Will it be enough to make the dynp=
tr
> >> in map key/value be read-only ? If the dynptr in map key could be
> >> modified by bpf_dyptr_adjust(),  the lookup procedure may fail to find
> >> the target map element.
> > So you are saying that we would allow to update dynptr using
> > bpf_map_update_elem() (from BPF side), but allow to use bpf_dynptr
> > read-only APIs directly on dynptr inside the map_value, is that right?
>
> Yes. In your original stashed dynptr proposal, updating the dynptr part
> in the map key is done through bpf_map_update_elem(). For map value, do
> you think it is OK that we disable the update of dynptr in map value
> through bpf_map_update_elem() and only allow the update through extra
> kfuncs just like the existing special field in map value ? It will make
> a difference between the update of map key and map value. Will try to
> check whether is feasible to support the update of dynptr in map value
> through both bpf_map_update_elem() and extra kfunc.

I don't really see a problem supporting both. Under the cover it will
be the same logic, shared internal helper function, probably.

But if for whatever reason that's impossible, we can restrict setting
a new bpf_dynptr through bpf_map_update_elem(), yes.

[...]

> >
> >> 2) need to support concurrent update through non-bpf_map_update_elem h=
elpers
> >> However, if the dynptr in map key and value is read-only, there will b=
e
> >> no concurrent update. The update could be done through
> >> bpf_map_update_elem helper.
> >>
> >> 3) need to support in-place update through bpf_map_update_elem helper
> >> (e.g., for per-CPU map)
> >> However, if we need to support dynptr in map value, maybe we should
> >> change the in-place update to out-of-place update.
> >>
> >> Hope I didn't miss any point.
> > So, basically, if we unnecessarily restrict usability of dynptr, we
> > might carve out some way to work with dynptrs inside map key (but not
> > really map value, as I explained).
> >
> > On the other hand, we can have "stashed dynptr" and make it work the
> > same way in all situations.
> >
> > Tough choice, isn't it? ;)
>
> I see. Thanks for all these explanations. Will switch to the "stashed
> dynptr" in v4.

great, let's give it a try and see if we missed any gotchas, thanks!

> >
> >>>>> struct id_dname_key {
> >>>>>        int id;
> >>>>>        struct bpf_stashed_dynptr name;
> >>>>> };
> >>>>>
> >>> [...]
> >>>

[...]

