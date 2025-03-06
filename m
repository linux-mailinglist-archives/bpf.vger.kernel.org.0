Return-Path: <bpf+bounces-53465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5B7A5479F
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 11:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061B23ACFA9
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 10:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1961D200100;
	Thu,  6 Mar 2025 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kspa7tyK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505417B50B;
	Thu,  6 Mar 2025 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256586; cv=none; b=aHxSmF9p+ebA4/vBdt//JmJYyHHeYsB2PxP+LJWDR1PjEmo54Jb/CgH0a+CoeeAb0eB1Lk5k2ERm2lW/5aEOpI7CpJB1eyg5O8b6yDZ6jwlolbEWAeX/7XH0WsG+ZgLyLx6A5uFB8vnOf/KnBZhGM7UxAf9Db+0UzQTXBlaTDGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256586; c=relaxed/simple;
	bh=Fk+ptxHPo0zL9VKayPmWGSh7ru2griwlnIjrUJwnVzQ=;
	h=From:Content-Type:Mime-Version:Subject:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f7n6LNgwFblkReleBkwN7Je6soC0m4MGhmTdQCEh1cOyRZc9V36G7tKmWZT+O5bvflidqol2U84E+lJYwfh0WfEzPpYHF0Et1fltuGyFz56cHTBeWmBRv03gw5JHJu6kRdCRMurhxT9GVH0MqVK2lpuLTVrcp/FY2IKmq311m20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kspa7tyK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so1031664a12.0;
        Thu, 06 Mar 2025 02:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741256583; x=1741861383; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSreNIH4adMVMjlthJ/Tlzvq8nw1Qi3pxgZbONEY0EE=;
        b=Kspa7tyKYXS4GgjSfsmfXWAADS6XOrrpDzE2lLqxCtJlQ07wO1ktV7PlVHdB/MbdkR
         +IVCgQg3EOB9KU4yLcxTq8/6hv2FjHYbAWZVjYHdbWFl0BX9+UROxG9MB/tOi84oyAqp
         V1OqCW6LWD0pDv7Qa/dLLpfDAWn1IF4MrJGyovN33nxFx9pb2CXOQRLar7Udp/pvOBo0
         BNUSUQ1uLkXRfZwNQ3Oo0xyJVJ4PbWs20GoQXEsEnqkmfbHNVTOk969M1iomaFC9d49m
         s194JmOzROeCEGEebMIywYzDWwsLJkCGTazlTdENk/QxtWQ7guqPCMsxO3++zxeB1NoE
         aYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741256583; x=1741861383;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:subject:mime-version:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSreNIH4adMVMjlthJ/Tlzvq8nw1Qi3pxgZbONEY0EE=;
        b=TsoqWzdzFH2GS5Bg3jnnKRpOzQobdV3N59yVgqy+jQjIwXSdWaWdOLFFN/ZBivxju1
         R8R9GFXbcSxt6YAxa8Ir3ozlvH7X6YsfFlsDU6msIN4pRhbECgR5f/at1RLIMX4BTy25
         HuAG3vE6lWMECQgpEp30+BPcb0inJwQRxdvExKhPm++85pTyDCj++j01OPmP9jWgExQO
         y74EoLnq4tLZislH3cbipgyzPcVscdsqeniWnfA6wmcMCEieNeZkUqYkbt6BOQFtqBRo
         4yFtNuqh/w1LChRNzmsU3jByp4mKWgA6PCdADGrgvDou73cLwkX6BHCZnnhnIHPBUmNw
         Fj6g==
X-Forwarded-Encrypted: i=1; AJvYcCVj04xPzp1Pu0M/wZ6jHuzTYMgE0+pp2tzijWohs4IymmLdbVDAVrxCQgN1+AGpjD2uQrsk@vger.kernel.org, AJvYcCW3h3ZDOBym01feVNZTp4pKgg8CZOkEbdGXDlTmS0MFq8yfH0dXEceYvcEKNEjp8rtFPGOHX72BVicXG1vg@vger.kernel.org, AJvYcCXkgAmJN5izOcF7cd90GyhStvq7dx970fY0RVH8XU0Zxqi9nPHoWaVnVzJvNWiLT6uXq2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+jB9G5kGLGckkdOWGPVDw3BoPFraYGTUgW1Bt11/1/6ihNvMX
	6nnP5UcmZT6MU5gLfAa/cLhXQVM2364mTTwLnstvk1WVDkE5FUfG
X-Gm-Gg: ASbGncuveLWfu8TB7fUU43UH6yDxxMPA+6A3hpiX9aV0zrnyfmQ2pH0C+TvyDoeqRWi
	E9s+CI7Gh46YjNvujNv7LH6nmkH61NKpwObS/XBFPP98fRa0p8la7UOknjqVpsXMKA1BB4O2l7Z
	0n2k4gYFQ2bidcAPQ3yLT+ClV9fBCVuIJZ4RX2bXl215u222XxSud+mk95dkVJJ+c9KZq2hNd8y
	tEuneWoa7hK6VwFFmprMczg6k7iJfafFLDDHBjOlCZ2x1akTW/oCiCnW0rn61xjSq/jT6DQ8YIs
	oLxb9mxlokjPUMQKS/1Lfv7cLe8mQ9RR0GtmFd3tRTxXbkmk//zt640f6A==
X-Google-Smtp-Source: AGHT+IFMBMMD1hiit+xZF2Scen4nqwH8NOgCkmQvow1VZWtTjkkHspCV+WaQcKHmLYtLT7YOayoUUw==
X-Received: by 2002:a05:6402:3581:b0:5e0:8a34:3b5c with SMTP id 4fb4d7f45d1cf-5e5c1a7786emr2354367a12.0.1741256582607;
        Thu, 06 Mar 2025 02:23:02 -0800 (PST)
Received: from smtpclient.apple ([209.38.224.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c76913bbsm709630a12.78.2025.03.06.02.23.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:23:01 -0800 (PST)
From: Nick Zavaritsky <mejedi@gmail.com>
X-Google-Original-From: Nick Zavaritsky <MeJedi@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [RESEND] [PATCH bpf-next 2/3] bpf: Overwrite the element in hash
 map atomically
In-Reply-To: <CAADnVQLev2V-ARjPc9EPYaSssCev_87Lc0NWkLvL-5tuy=3Veg@mail.gmail.com>
Date: Thu, 6 Mar 2025 11:22:48 +0100
Cc: Hou Tao <houtao@huaweicloud.com>,
 Zvi Effron <zeffron@riotgames.com>,
 =?utf-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
 bpf <bpf@vger.kernel.org>,
 rcu@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Cody Haas <chaas@riotgames.com>,
 Hou Tao <hotforest@gmail.com>,
 Charalampos Stylianopoulos <charalampos.stylianopoulos@emnify.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4243FBB4-693E-4740-BECE-FDB32322BD97@gmail.com>
References: <20250204082848.13471-1-hotforest@gmail.com>
 <20250204082848.13471-3-hotforest@gmail.com>
 <cca6daf2-48f4-57b9-59a9-75578bb755b9@huaweicloud.com>
 <8734gr3yht.fsf@toke.dk>
 <d191084a-4ab4-8269-640f-1ecf269418a6@huaweicloud.com>
 <CAADnVQKD94q-G4N=w9PJU+k6gPhM8GmUYcyfj=33B_mKX6Qbjw@mail.gmail.com>
 <6a84a878-0728-0a19-73d2-b5871e10e120@huaweicloud.com>
 <CAADnVQLrJBOSXP41iO+-FtH+XC9AmuOne7xHzvgXop3DUC5KjQ@mail.gmail.com>
 <CAC1LvL0ntdrWh_1y0EcVR6C1_WyqOQ15EhihfQRs=ai7pcE-Sw@mail.gmail.com>
 <7e614d80-b45b-e2f9-5a39-39086c2392dc@huaweicloud.com>
 <CAADnVQJU9OWAWFk89P6i1RK6vXkuee5s76suHjF+uP+V4iepqQ@mail.gmail.com>
 <e1b65f13-a426-d707-0319-f57e8b15575a@huaweicloud.com>
 <CAADnVQLev2V-ARjPc9EPYaSssCev_87Lc0NWkLvL-5tuy=3Veg@mail.gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)


> On 27. Feb 2025, at 04:17, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
>=20
> On Wed, Feb 26, 2025 at 6:43=E2=80=AFPM Hou Tao =
<houtao@huaweicloud.com> wrote:
>>=20
>>>>=20
>>>> lookup procedure A
>>>> A: find the old element (instead of the new old)
>>>>=20
>>>>              update procedure B
>>>>              B: delete the old element
>>>>              update procedure C on the same CPU:
>>>>              C: reuse the old element (overwrite its key and insert =
in
>>>> the same bucket)
>>>>=20
>>>> A: the key is mismatched and return -ENOENT.
>>> This is fine. It's just normal reuse.
>>> Orthogonal to 'update as insert+delete' issue.
>>=20
>> OK. However, it will break the lookup procedure because it expects it
>> will return an valid result instead of -ENOENT.
>=20
> What do you mean 'breaks the lookup' ?
> lookup_elem_raw() matches hash, and then it memcmp(key),
> if the element is reused anything can happen.
> Either it succeeds in memcmp() and returns an elem,
> or miscompares in memcmp().
> Both are expected, because elems are reused in place.
>=20
> And this behavior is expected and not-broken,
> because bpf prog that does lookup on one cpu and deletes
> the same element on the other cpu is asking for trouble.
> bpf infra guarantees the safety of the kernel.
> It doesn't guarantee that bpf progs are sane.
>=20
>>> It's been a long time since I looked into rcu_nulls details.
>>> Pls help me understand that this new replace_rcu_nulls()
>>> is correct from nulls pov,
>>> If it is then this patch set may be the right answer to non-atomic =
update.
>>=20
>> If I understand correctly, only the manipulations of ->first pointer =
and
>> ->next pointer need to take care of nulls pointer.
>=20
> hmm. I feel we're still talking past each other.
> See if (get_nulls_value() =3D=3D ...) in lookup_nulls_elem_raw().
> It's there because of reuse. The lookup can start in one bucket
> and finish in another.
>=20
>>>=20
>>> And for the future, please please focus on "why" part in
>>> the cover letter and commit logs instead of "what".
>>>=20
>>> Since the only thing I got from the log was:
>>> "Currently, the update is not atomic
>>> because the overwrite of existing element happens in a two-steps =
way,
>>> but the support of atomic update is feasible".
>>>=20
>>> "is feasible" doesn't explain "why".
>>>=20
>>> Link to xdp-newbie question is nice for additional context,
>>> but reviewers should not need to go and read some thread somewhere
>>> to understand "why" part.
>>> All of it should be in the commit log.
>>=20
>> OK. My original thought is that is a reported problem, so an extra =
link
>> will be enough. Will try to add more context next time.
>>>=20
>>>> map may still be incorrect (as shown long time ago [1]), so I think
>>>> maybe for other types of map, the atomic update doesn't matter too =
much.
>>>>=20
>>>> [1]:
>>>> =
https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.co=
m/
>>> A thread from 3 years ago ?! Sorry, it's not helpful to ask
>>> people to page-in such an old context with lots of follow ups
>>> that may or may not be relevant today.
>> Let me reuse part of the diagram above to explain how does the lookup
>> procedure may return a incorrect value:
>>=20
>> lookup procedure A
>> A: find the old element (instead of the new element)
>>=20
>>=20
>>              update procedure B
>>              B: delete the old element
>>              update procedure C on the same CPU:
>>=20
>>=20
>> A: the key is matched and return the value in the element
>>=20
>>              C: reuse the old element (overwrite its key and value)
>>=20
>> A: read the value (it is incorrect, because it has been reused and
>> overwritten)
>=20
> ... and it's fine. It's by design. It's an element reuse behavior.
>=20
> Long ago hashmap had two modes: prealloc (default) and
> NO_PREALLOC (call_rcu + kfree)
>=20
> The call_rcu part was there to make things safe.
> The memory cannot be kfree-ed to the kernel until RCU GP.
> With bpf_mem_alloc hashmap elements are freed back to bpf_ma
> right away. Hashmap is doing bpf_mem_cache_free()

We (emnify.com) missed this change and kept writing code with an
assumption that NO_PREALLOC implies rcu.

Is there something we can do as of today to reduce the likelihood of an
item getting reused immediately? We are concerned with lookups yielding
bogus results when racing with updates. Worse, a program could corrupt
an unrelated item when writing via a pointer obtained from lookup.

You wrote that "lookup on one cpu and deletes the same element on the
other cpu is asking for trouble.=E2=80=9D It puzzles me since user space
updating a map while (say) TC program is consulting the map to make a
routing decision look like a supported and widespread use case.

For us, implications vary in severity, e.g.:
 - 1-in-1e? packet mis-delivered (bogus lookup: LOW)
 - a tenant getting billed for a packet of another tenant delivered via
   satellite and costing USD 0.10 (writing into unrelated item: LOW)
 - a network flow state corrupted (writing into unrelated item: MEDIUM)

We need to audit our code to ensure that e.g. a flow state getting
corrupted self-corrects and the damage doesn=E2=80=99t spread.

It would be nice if we as eBPF users could decide whether we wish to
live dangerously or prefer to trade speed for safety, on a case-by-case
basis.

> (instead of bpf_mem_cache_free_rcu()) because users need speed.
> So since 2022 both prealloc and no_prealloc reuse elements.
> We can consider a new flag for the hash map like F_REUSE_AFTER_RCU_GP
> that will use _rcu() flavor of freeing into bpf_ma,
> but it has to have a strong reason.
> And soon as we add it the default with prealloc would need
> to use call_rcu() too, right?
> and that becomes nightmare, since bpf prog can easily DoS the system.
> Even if we use bpf_mem_cache_free_rcu() only, the DoS is a concern.
> Unlike new things like bpf_obj_new/obj_drop the hashmap
> is unpriv, so concerns are drastically different.

Would it be an option to gate F_REUSE_AFTER_RCU under CAP_BPF?

It looks like sleepable programs would need to bpf_rcu_read_lock
explicitly to reap the benefits, but why not.=

