Return-Path: <bpf+bounces-17126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4404880A063
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED99D281769
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B8D14ABB;
	Fri,  8 Dec 2023 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyH5NixL"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3493B1720
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 02:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702030558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MX6evhTqPpwavQwynX3n7pSmcswtMdA0RykzkRNIQhc=;
	b=MyH5NixLYBK1933ZnCxCxZ7PtqiCbWsgUzRXuxvkkMVQQ4IqPPkXFpm2nEAcoTQgpUWHXN
	ggC2t1OdNn8DS9chiBQmyMEltOjQB8NixMK9fFfqj5a+cqWghJ5cLHkxl3duyIJj7LGlVT
	IGFM175B42XcawyIw7ZHO/ATnOQAIS4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-nVoOpnhkMOC-9k8N8hmp6A-1; Fri, 08 Dec 2023 05:15:57 -0500
X-MC-Unique: nVoOpnhkMOC-9k8N8hmp6A-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-54c64c3a702so1088204a12.2
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 02:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030556; x=1702635356;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MX6evhTqPpwavQwynX3n7pSmcswtMdA0RykzkRNIQhc=;
        b=PTnon26PUt5B54YQ7zjs5iC+iaveYpxqBbPhfgAuOHDCfgZOeioQ3BMcMBjKpnL5tw
         sFIsnyETZnDLPZOxSjEAA6C3tb7STSIxJ4+I/C/Sh7Sd6J7wwMShvgfWVX/fjOpnFBY5
         zkDbKgDW6ECZmNKyQTzF06RxGd3+a9hy8viQ7rR+hejky7kBO4YCXQR7RoASETZ43hyk
         SebBtr2NaDP+cwT1Lu6Uq3ntKAKr9qxkyX0/j0Vw6vbUuWRwc6N0CjEJBYquvReAHCb4
         rdIzodGn0kcXqoOp9EHfaetvf0ApGoXGxVfJalHeqSTHpxeLQdSjJUDXv4So+OW6BLJW
         kzqg==
X-Gm-Message-State: AOJu0YwAufcCG0b4f/3FHKpOh9pbgfZ4tq4gfQVIcBl5wMd/sh0BJKNh
	RjRvpPp9d7w/GI4pvleFiE/plWQgPaVERRvDrU1Qbf2ZP7w5fMvVe5VMt57smnLQvJpBhD39Fq4
	q9yF4OTjk2gV6
X-Received: by 2002:a50:cc8e:0:b0:54c:6386:a1a3 with SMTP id q14-20020a50cc8e000000b0054c6386a1a3mr2083711edi.15.1702030556510;
        Fri, 08 Dec 2023 02:15:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHABCxRaD9hK0mI0OvT0IXyPNkLh2JMHZAeWuelR90R+Wkie7Wr6WeoMLFU7DReUQ64cMMuHA==
X-Received: by 2002:a50:cc8e:0:b0:54c:6386:a1a3 with SMTP id q14-20020a50cc8e000000b0054c6386a1a3mr2083690edi.15.1702030556160;
        Fri, 08 Dec 2023 02:15:56 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v21-20020a50d095000000b0054cd6346685sm692755edd.35.2023.12.08.02.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:15:55 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 41AB7FAAB19; Fri,  8 Dec 2023 11:15:55 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com,
 namrata.limaye@intel.com, mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
 tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
 khalidm@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9 14/15] p4tc: add set of P4TC table kfuncs
In-Reply-To: <8faf1308-2f9f-4923-804e-8d9b11ba74e0@linux.dev>
References: <20231201182904.532825-1-jhs@mojatatu.com>
 <20231201182904.532825-15-jhs@mojatatu.com>
 <8faf1308-2f9f-4923-804e-8d9b11ba74e0@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 08 Dec 2023 11:15:55 +0100
Message-ID: <87lea5j8ys.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 12/1/23 10:29 AM, Jamal Hadi Salim wrote:
>> We add an initial set of kfuncs to allow interactions from eBPF programs
>> to the P4TC domain.
>> 
>> - bpf_p4tc_tbl_read: Used to lookup a table entry from a BPF
>> program installed in TC. To find the table entry we take in an skb, the
>> pipeline ID, the table ID, a key and a key size.
>> We use the skb to get the network namespace structure where all the
>> pipelines are stored. After that we use the pipeline ID and the table
>> ID, to find the table. We then use the key to search for the entry.
>> We return an entry on success and NULL on failure.
>> 
>> - xdp_p4tc_tbl_read: Used to lookup a table entry from a BPF
>> program installed in XDP. To find the table entry we take in an xdp_md,
>> the pipeline ID, the table ID, a key and a key size.
>> We use struct xdp_md to get the network namespace structure where all
>> the pipelines are stored. After that we use the pipeline ID and the table
>> ID, to find the table. We then use the key to search for the entry.
>> We return an entry on success and NULL on failure.
>> 
>> - bpf_p4tc_entry_create: Used to create a table entry from a BPF
>> program installed in TC. To create the table entry we take an skb, the
>> pipeline ID, the table ID, a key and its size, and an action which will
>> be associated with the new entry.
>> We return 0 on success and a negative errno on failure
>> 
>> - xdp_p4tc_entry_create: Used to create a table entry from a BPF
>> program installed in XDP. To create the table entry we take an xdp_md, the
>> pipeline ID, the table ID, a key and its size, and an action which will
>> be associated with the new entry.
>> We return 0 on success and a negative errno on failure
>> 
>> - bpf_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
>> First does a lookup using the passed key and upon a miss will add the entry
>> to the table.
>> We return 0 on success and a negative errno on failure
>> 
>> - xdp_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
>> First does a lookup using the passed key and upon a miss will add the entry
>> to the table.
>> We return 0 on success and a negative errno on failure
>> 
>> - bpf_p4tc_entry_update: Used to update a table entry from a BPF
>> program installed in TC. To update the table entry we take an skb, the
>> pipeline ID, the table ID, a key and its size, and an action which will
>> be associated with the new entry.
>> We return 0 on success and a negative errno on failure
>> 
>> - xdp_p4tc_entry_update: Used to update a table entry from a BPF
>> program installed in XDP. To update the table entry we take an xdp_md, the
>> pipeline ID, the table ID, a key and its size, and an action which will
>> be associated with the new entry.
>> We return 0 on success and a negative errno on failure
>> 
>> - bpf_p4tc_entry_delete: Used to delete a table entry from a BPF
>> program installed in TC. To delete the table entry we take an skb, the
>> pipeline ID, the table ID, a key and a key size.
>> We return 0 on success and a negative errno on failure
>> 
>> - xdp_p4tc_entry_delete: Used to delete a table entry from a BPF
>> program installed in XDP. To delete the table entry we take an xdp_md, the
>> pipeline ID, the table ID, a key and a key size.
>> We return 0 on success and a negative errno on failure
>
> [ ... ]
>
>> +BTF_SET8_START(p4tc_kfunc_check_tbl_set_skb)
>> +BTF_ID_FLAGS(func, bpf_p4tc_tbl_read, KF_RET_NULL);
>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_create);
>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_create_on_miss);
>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_update);
>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_delete);
>> +BTF_SET8_END(p4tc_kfunc_check_tbl_set_skb)
>
> These create/read/update/delete kfuncs are like defining a new hidden bpf map 
> type in the kernel. bpf prog can now create its own link-list and rbtree. 
> sched_ext has already been using it. This is the way the bpf prog should use 
> instead of creating a new map type.

I don't really think this is an accurate assessment, given Jamal's use
case. These kfuncs are more akin to the FIB lookup helper, or the
netfilter kfuncs: they provide lookup into a kernel-internal data
structure, so that BPF can access that data structure while staying in
sync with the rest of the kernel.

If this was a BPF-only implementation you'd be right, but given the
constraint of having the P4 objects represented in the kernel[0], I
think this is a perfectly reasonable use of kfuncs, even though they
happen to look like the map API.

-Toke

[0] Whether having those objects represented at all is reasonable is a
separate discussion, which I believe John et al are having with Jamal in
a separate subthread. I don't personally have any strong objections to
doing that.


