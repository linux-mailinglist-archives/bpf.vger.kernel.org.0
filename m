Return-Path: <bpf+bounces-17409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 251BB80CECA
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 16:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71C7281C13
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 15:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23A549F7F;
	Mon, 11 Dec 2023 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvTABRgH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DF0A9
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 07:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702306808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wj2Hb5RgkNgGJGhAYgsKKuf9w/lw3IuQdz5F/3+z1O8=;
	b=CvTABRgH/Ff333mQNuIIbo4yd9tz0OpMej4oTKaE88bifLFNA/rh8ZIZsvNSBohmxV9GlA
	6tZS7hNk8jHTmLWOr5qhv7EATC6wqJ0WbXqbVB3kV695BU3IzvventR9tJIP+/6JxboJ3o
	H/LiMOvi/VR6/we/lgQ6HuvVBuvJwb8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-DSn8rfHpOoGCCZisuqh99g-1; Mon, 11 Dec 2023 10:00:07 -0500
X-MC-Unique: DSn8rfHpOoGCCZisuqh99g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1e88d2d7faso244461266b.1
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 07:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702306805; x=1702911605;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wj2Hb5RgkNgGJGhAYgsKKuf9w/lw3IuQdz5F/3+z1O8=;
        b=M40FaxCh2gnzA/nY38m5p5d+hNoh1bHYk+qG+6l6Yqu++vz0mfcgqPreZwaodeyiU8
         h3UQTEppBUcKx0St6dJsGkZQZeTYtDXTmsij8aTgNdkQvTx/tbcwRqSjx9MRb0UUyMk5
         EJwSbrYTELxC5oZOmqYe+w0JS6CWcDcPkZesF/Ucxeu/xs/t7j1o3hzw6YTkFRV0SSHB
         1SlQQq/g/NxjNNZgd4HjpCIAu2CfS6q+l0/bpc0lEkXuKNSsNUaUBnbloumDt4x8zDbm
         54VBlt7JFjyxI+CRGWuejqZ1TMfSprt6eUE6MhBVRKenepSHpDwVMtRfeQLH7lz/G5jZ
         KZOg==
X-Gm-Message-State: AOJu0YxLCkeO3bCVyzwATJFqRl3vp6HHVmc5zplWjbu9u3KDlpnh9qBx
	H1g9OV8wN9tRL8tLKo/bvIsRaalGu8IcqoS0qmvgM3slCeCzL8fVGoFY3on+qxHU9ZsP9+XfXf2
	quFf6qX9q38yd
X-Received: by 2002:a17:906:491b:b0:9fd:8cd9:7842 with SMTP id b27-20020a170906491b00b009fd8cd97842mr2236335ejq.44.1702306805114;
        Mon, 11 Dec 2023 07:00:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4yiDiIkux5IHFUI4jYHybyJllFVaw16QvCvm8uMobyF2BQE1z4ML85w+lSdSzjbKYNVIR1A==
X-Received: by 2002:a17:906:491b:b0:9fd:8cd9:7842 with SMTP id b27-20020a170906491b00b009fd8cd97842mr2236312ejq.44.1702306804734;
        Mon, 11 Dec 2023 07:00:04 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id cu3-20020a170906ba8300b00a1d818ebcadsm5004652ejd.19.2023.12.11.07.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:00:04 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D2E34FE660C; Mon, 11 Dec 2023 16:00:03 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com,
 namrata.limaye@intel.com, mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
 tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
 khalidm@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH net-next v9 14/15] p4tc: add set of P4TC table kfuncs
In-Reply-To: <335fbd65-585d-47b8-a98f-c0898aff7d7f@linux.dev>
References: <20231201182904.532825-1-jhs@mojatatu.com>
 <20231201182904.532825-15-jhs@mojatatu.com>
 <8faf1308-2f9f-4923-804e-8d9b11ba74e0@linux.dev> <87lea5j8ys.fsf@toke.dk>
 <335fbd65-585d-47b8-a98f-c0898aff7d7f@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 11 Dec 2023 16:00:03 +0100
Message-ID: <87plzc239o.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 12/8/23 2:15 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Martin KaFai Lau <martin.lau@linux.dev> writes:
>>=20
>>> On 12/1/23 10:29 AM, Jamal Hadi Salim wrote:
>>>> We add an initial set of kfuncs to allow interactions from eBPF progra=
ms
>>>> to the P4TC domain.
>>>>
>>>> - bpf_p4tc_tbl_read: Used to lookup a table entry from a BPF
>>>> program installed in TC. To find the table entry we take in an skb, the
>>>> pipeline ID, the table ID, a key and a key size.
>>>> We use the skb to get the network namespace structure where all the
>>>> pipelines are stored. After that we use the pipeline ID and the table
>>>> ID, to find the table. We then use the key to search for the entry.
>>>> We return an entry on success and NULL on failure.
>>>>
>>>> - xdp_p4tc_tbl_read: Used to lookup a table entry from a BPF
>>>> program installed in XDP. To find the table entry we take in an xdp_md,
>>>> the pipeline ID, the table ID, a key and a key size.
>>>> We use struct xdp_md to get the network namespace structure where all
>>>> the pipelines are stored. After that we use the pipeline ID and the ta=
ble
>>>> ID, to find the table. We then use the key to search for the entry.
>>>> We return an entry on success and NULL on failure.
>>>>
>>>> - bpf_p4tc_entry_create: Used to create a table entry from a BPF
>>>> program installed in TC. To create the table entry we take an skb, the
>>>> pipeline ID, the table ID, a key and its size, and an action which will
>>>> be associated with the new entry.
>>>> We return 0 on success and a negative errno on failure
>>>>
>>>> - xdp_p4tc_entry_create: Used to create a table entry from a BPF
>>>> program installed in XDP. To create the table entry we take an xdp_md,=
 the
>>>> pipeline ID, the table ID, a key and its size, and an action which will
>>>> be associated with the new entry.
>>>> We return 0 on success and a negative errno on failure
>>>>
>>>> - bpf_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
>>>> First does a lookup using the passed key and upon a miss will add the =
entry
>>>> to the table.
>>>> We return 0 on success and a negative errno on failure
>>>>
>>>> - xdp_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
>>>> First does a lookup using the passed key and upon a miss will add the =
entry
>>>> to the table.
>>>> We return 0 on success and a negative errno on failure
>>>>
>>>> - bpf_p4tc_entry_update: Used to update a table entry from a BPF
>>>> program installed in TC. To update the table entry we take an skb, the
>>>> pipeline ID, the table ID, a key and its size, and an action which will
>>>> be associated with the new entry.
>>>> We return 0 on success and a negative errno on failure
>>>>
>>>> - xdp_p4tc_entry_update: Used to update a table entry from a BPF
>>>> program installed in XDP. To update the table entry we take an xdp_md,=
 the
>>>> pipeline ID, the table ID, a key and its size, and an action which will
>>>> be associated with the new entry.
>>>> We return 0 on success and a negative errno on failure
>>>>
>>>> - bpf_p4tc_entry_delete: Used to delete a table entry from a BPF
>>>> program installed in TC. To delete the table entry we take an skb, the
>>>> pipeline ID, the table ID, a key and a key size.
>>>> We return 0 on success and a negative errno on failure
>>>>
>>>> - xdp_p4tc_entry_delete: Used to delete a table entry from a BPF
>>>> program installed in XDP. To delete the table entry we take an xdp_md,=
 the
>>>> pipeline ID, the table ID, a key and a key size.
>>>> We return 0 on success and a negative errno on failure
>>>
>>> [ ... ]
>>>
>>>> +BTF_SET8_START(p4tc_kfunc_check_tbl_set_skb)
>>>> +BTF_ID_FLAGS(func, bpf_p4tc_tbl_read, KF_RET_NULL);
>>>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_create);
>>>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_create_on_miss);
>>>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_update);
>>>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_delete);
>>>> +BTF_SET8_END(p4tc_kfunc_check_tbl_set_skb)
>>>
>>> These create/read/update/delete kfuncs are like defining a new hidden b=
pf map
>>> type in the kernel. bpf prog can now create its own link-list and rbtre=
e.
>>> sched_ext has already been using it. This is the way the bpf prog shoul=
d use
>>> instead of creating a new map type.
>>=20
>> I don't really think this is an accurate assessment, given Jamal's use
>> case. These kfuncs are more akin to the FIB lookup helper, or the
>> netfilter kfuncs: they provide lookup into a kernel-internal data
>> structure, so that BPF can access that data structure while staying in
>> sync with the rest of the kernel.
>>=20
>> If this was a BPF-only implementation you'd be right, but given the
>> constraint of having the P4 objects represented in the kernel[0], I
>> think this is a perfectly reasonable use of kfuncs, even though they
>> happen to look like the map API.
>>=20
>> -Toke
>>=20
>> [0] Whether having those objects represented at all is reasonable is a
>> separate discussion, which I believe John et al are having with Jamal in
>> a separate subthread. I don't personally have any strong objections to
>> doing that.
>
> I might not be clear. It was my question on why it has to be in the kerne=
l=20
> instead of in the bpf map, so the earlier bpf link-list and rbtree exampl=
e just=20
> in case this recent bpf capability has not been considered.

A bit tangential, but it came to mind while thinking about this: how
would one go about updating a bpf rbtree-based data structure from
userspace? Is there a way to get bpf_map_update()-semantics that inserts
things into the rbtree somehow?

> If it is an existing kernel infra-structure, kfunc is a reasonable use.
>
> The P4 objects are newly added to this set with bpf program as its user. =
It can=20
> be represented in the bpf map as well instead of in the kernel.
>
> or is it fair to say that bpf prog is not the primary consumer of the P4=
=20
> objects. Instead kernel is the primary user of the p4 objects such that p=
4tc can=20
> work independently without the bpf piece to begin with and bpf could be=20
> considered as an extension later?

That's a good question, actually. I think that conceptually, if viewed
purely as a control plane, it could be merged separately and the BPF
support added later. But with this series, that would make it a control
plane that doesn't really control anything; so there would need to be a
second consumer (hardware offload?) added for that to make sense, I
suppose.

Or to put it another way, the way this series is designed, there is an
implicit "these are kernel objects that we want to use for other things"
assumption in there; it's just that those "other things" are not part
of this series (because hardware offload doesn't exist yet - I think?
I'll let Jamal answer that). I can see the point of asking for that
second user, though, as that would make it clear why the control plane
needs to be in the kernel.

-Toke


