Return-Path: <bpf+bounces-17411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA7080CF4E
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 16:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF88B2127F
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 15:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA33B4AF6E;
	Mon, 11 Dec 2023 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="M70GUBE/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696F3E5
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 07:18:38 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5d8ddcc433fso33110297b3.1
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 07:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702307917; x=1702912717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbLUJo4lfex3B3XOFA5W+h85iCITKDu6mevJv5PV6go=;
        b=M70GUBE/34c1GabAiGHefP1Rb+uooagsY9ruMUacSmDFF/rS1yJj5GfbWWOqlYcG+N
         a+AdksGPz5X5Eu5H2frHlbWfjbvBXpfxMTkqMwPXVdIglwrWwAoQR+Rbc0J5xNPG5L/Q
         Ny1ia3YDRMIR/F0i7g+g7ZM43l9zTPeg3breKKjsNVQ6+1sS+MsAEc4of6F5SqMwoHew
         /3Mq0nbm4OxGORsPRs05F5Hm51ajlh7aY0HisLYuiVteUA4u6KfwaXAS1LGaecM9gEpq
         dgFDQCvx8VUAna242+jc8IVDbcpw0CShYn9zRhyVb2TW3SY9qN8D0/HDWGhrrHl2gLHU
         53ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702307917; x=1702912717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbLUJo4lfex3B3XOFA5W+h85iCITKDu6mevJv5PV6go=;
        b=XuDmYUuhLWnGOWdPxaYy4NgwAw9dh5ZkdpH1WE6nOG8Idbm/opDE7ij3WTtYdQJU71
         8kpoWwlsOKUChqCaLqoOcaxJVnjoMcpJD2JLn8WjCeTgss0Qwpa2aWlCHMsSLlZj2xFW
         Nr28w6gYSW1+QQ12UuaoI+l3Wsvadsxg2aD+EtCEXb7uAxdKG3l22pYLOsfS0GcfYqku
         rJqb1e6FRdcgLSmbSjswLy5t12th5zmCUY306gVcz17cZxucX9HxpPmioNzl+gOFnUjx
         /tsfED3vzQfJjeVaC+KcWbl2NXAqHUyFw+LCfYoMjaZrLCJ196rhYzUQTrGJsM/yNopk
         KgZA==
X-Gm-Message-State: AOJu0Yz4rmIHWy0WsfVpbDdDoFDQGm9G1CWFDQmuedu373rCg54PyXau
	7+o9783cokDFJXAsHzF5fot/xCahLayL6S114BF3qg==
X-Google-Smtp-Source: AGHT+IEnl1I6kwL0MAGUCiUqBoT6TGUNf8Ojyp3Uqinov4+UEntR7j1XiEP+3ORmep2CRmY/2fiqHFfqRXxSmaPJtJg=
X-Received: by 2002:a81:a501:0:b0:5d7:1940:8ddb with SMTP id
 u1-20020a81a501000000b005d719408ddbmr1826197ywg.66.1702307916021; Mon, 11 Dec
 2023 07:18:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201182904.532825-1-jhs@mojatatu.com> <20231201182904.532825-15-jhs@mojatatu.com>
 <8faf1308-2f9f-4923-804e-8d9b11ba74e0@linux.dev> <87lea5j8ys.fsf@toke.dk>
 <335fbd65-585d-47b8-a98f-c0898aff7d7f@linux.dev> <87plzc239o.fsf@toke.dk>
In-Reply-To: <87plzc239o.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 11 Dec 2023 10:18:24 -0500
Message-ID: <CAM0EoMnH4kgogD4raKjNeAL6XiNEcVU201_1-W5nNYiX-JMwsQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 14/15] p4tc: add set of P4TC table kfuncs
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, deb.chatterjee@intel.com, 
	anjali.singhai@intel.com, namrata.limaye@intel.com, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, 
	khalidm@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 10:00=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>
> Martin KaFai Lau <martin.lau@linux.dev> writes:
>
> > On 12/8/23 2:15 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> Martin KaFai Lau <martin.lau@linux.dev> writes:
> >>
> >>> On 12/1/23 10:29 AM, Jamal Hadi Salim wrote:
> >>>> We add an initial set of kfuncs to allow interactions from eBPF prog=
rams
> >>>> to the P4TC domain.
> >>>>
> >>>> - bpf_p4tc_tbl_read: Used to lookup a table entry from a BPF
> >>>> program installed in TC. To find the table entry we take in an skb, =
the
> >>>> pipeline ID, the table ID, a key and a key size.
> >>>> We use the skb to get the network namespace structure where all the
> >>>> pipelines are stored. After that we use the pipeline ID and the tabl=
e
> >>>> ID, to find the table. We then use the key to search for the entry.
> >>>> We return an entry on success and NULL on failure.
> >>>>
> >>>> - xdp_p4tc_tbl_read: Used to lookup a table entry from a BPF
> >>>> program installed in XDP. To find the table entry we take in an xdp_=
md,
> >>>> the pipeline ID, the table ID, a key and a key size.
> >>>> We use struct xdp_md to get the network namespace structure where al=
l
> >>>> the pipelines are stored. After that we use the pipeline ID and the =
table
> >>>> ID, to find the table. We then use the key to search for the entry.
> >>>> We return an entry on success and NULL on failure.
> >>>>
> >>>> - bpf_p4tc_entry_create: Used to create a table entry from a BPF
> >>>> program installed in TC. To create the table entry we take an skb, t=
he
> >>>> pipeline ID, the table ID, a key and its size, and an action which w=
ill
> >>>> be associated with the new entry.
> >>>> We return 0 on success and a negative errno on failure
> >>>>
> >>>> - xdp_p4tc_entry_create: Used to create a table entry from a BPF
> >>>> program installed in XDP. To create the table entry we take an xdp_m=
d, the
> >>>> pipeline ID, the table ID, a key and its size, and an action which w=
ill
> >>>> be associated with the new entry.
> >>>> We return 0 on success and a negative errno on failure
> >>>>
> >>>> - bpf_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
> >>>> First does a lookup using the passed key and upon a miss will add th=
e entry
> >>>> to the table.
> >>>> We return 0 on success and a negative errno on failure
> >>>>
> >>>> - xdp_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
> >>>> First does a lookup using the passed key and upon a miss will add th=
e entry
> >>>> to the table.
> >>>> We return 0 on success and a negative errno on failure
> >>>>
> >>>> - bpf_p4tc_entry_update: Used to update a table entry from a BPF
> >>>> program installed in TC. To update the table entry we take an skb, t=
he
> >>>> pipeline ID, the table ID, a key and its size, and an action which w=
ill
> >>>> be associated with the new entry.
> >>>> We return 0 on success and a negative errno on failure
> >>>>
> >>>> - xdp_p4tc_entry_update: Used to update a table entry from a BPF
> >>>> program installed in XDP. To update the table entry we take an xdp_m=
d, the
> >>>> pipeline ID, the table ID, a key and its size, and an action which w=
ill
> >>>> be associated with the new entry.
> >>>> We return 0 on success and a negative errno on failure
> >>>>
> >>>> - bpf_p4tc_entry_delete: Used to delete a table entry from a BPF
> >>>> program installed in TC. To delete the table entry we take an skb, t=
he
> >>>> pipeline ID, the table ID, a key and a key size.
> >>>> We return 0 on success and a negative errno on failure
> >>>>
> >>>> - xdp_p4tc_entry_delete: Used to delete a table entry from a BPF
> >>>> program installed in XDP. To delete the table entry we take an xdp_m=
d, the
> >>>> pipeline ID, the table ID, a key and a key size.
> >>>> We return 0 on success and a negative errno on failure
> >>>
> >>> [ ... ]
> >>>
> >>>> +BTF_SET8_START(p4tc_kfunc_check_tbl_set_skb)
> >>>> +BTF_ID_FLAGS(func, bpf_p4tc_tbl_read, KF_RET_NULL);
> >>>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_create);
> >>>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_create_on_miss);
> >>>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_update);
> >>>> +BTF_ID_FLAGS(func, bpf_p4tc_entry_delete);
> >>>> +BTF_SET8_END(p4tc_kfunc_check_tbl_set_skb)
> >>>
> >>> These create/read/update/delete kfuncs are like defining a new hidden=
 bpf map
> >>> type in the kernel. bpf prog can now create its own link-list and rbt=
ree.
> >>> sched_ext has already been using it. This is the way the bpf prog sho=
uld use
> >>> instead of creating a new map type.
> >>
> >> I don't really think this is an accurate assessment, given Jamal's use
> >> case. These kfuncs are more akin to the FIB lookup helper, or the
> >> netfilter kfuncs: they provide lookup into a kernel-internal data
> >> structure, so that BPF can access that data structure while staying in
> >> sync with the rest of the kernel.
> >>
> >> If this was a BPF-only implementation you'd be right, but given the
> >> constraint of having the P4 objects represented in the kernel[0], I
> >> think this is a perfectly reasonable use of kfuncs, even though they
> >> happen to look like the map API.
> >>
> >> -Toke
> >>
> >> [0] Whether having those objects represented at all is reasonable is a
> >> separate discussion, which I believe John et al are having with Jamal =
in
> >> a separate subthread. I don't personally have any strong objections to
> >> doing that.
> >
> > I might not be clear. It was my question on why it has to be in the ker=
nel
> > instead of in the bpf map, so the earlier bpf link-list and rbtree exam=
ple just
> > in case this recent bpf capability has not been considered.
>
> A bit tangential, but it came to mind while thinking about this: how
> would one go about updating a bpf rbtree-based data structure from
> userspace? Is there a way to get bpf_map_update()-semantics that inserts
> things into the rbtree somehow?
>
> > If it is an existing kernel infra-structure, kfunc is a reasonable use.
> >
> > The P4 objects are newly added to this set with bpf program as its user=
. It can
> > be represented in the bpf map as well instead of in the kernel.
> >
> > or is it fair to say that bpf prog is not the primary consumer of the P=
4
> > objects. Instead kernel is the primary user of the p4 objects such that=
 p4tc can
> > work independently without the bpf piece to begin with and bpf could be
> > considered as an extension later?
>
> That's a good question, actually. I think that conceptually, if viewed
> purely as a control plane, it could be merged separately and the BPF
> support added later. But with this series, that would make it a control
> plane that doesn't really control anything; so there would need to be a
> second consumer (hardware offload?) added for that to make sense, I
> suppose.
>
> Or to put it another way, the way this series is designed, there is an
> implicit "these are kernel objects that we want to use for other things"
> assumption in there; it's just that those "other things" are not part
> of this series (because hardware offload doesn't exist yet - I think?
> I'll let Jamal answer that). I can see the point of asking for that
> second user, though, as that would make it clear why the control plane
> needs to be in the kernel.

Yes, HW is also a consumer via TC but these patches are for the s/w only pi=
ece.

Martin, to get some understanding, see the last slide on
https://netdevconf.info/0x17/sessions/talk/integrating-ebpf-into-the-p4tc-d=
atapath.html
If you want to see the history of what changed from V1 for the s/w
side, see slide #14. And if you have the patience, look at the whole
slide set, and read the abstract. If clarity is still lacking then the
cover letter. And if you have even more patience then the relevant
commit messages but more importantly we need help to review if we are
making any amateur mistakes for the kfunc piece. TC (which is used for
such offloads, see u32, flower, etc) has its own model for
config/control driven via netlink. There are more objects than just
tables (eg pipelines, actions, externs etc) that all are _attached to
netns_ where they were instantiated - so we have a few more kfuncs for
those objects which are not part of this patchset (since the rules say
15 patches is the max).

Hope that helps.

cheers,
jamal
> -Toke
>

