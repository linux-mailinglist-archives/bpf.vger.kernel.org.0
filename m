Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACF956333A
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 14:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbiGAMJu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 08:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbiGAMJc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 08:09:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7623A83F3D
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656677359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lajk1f9JSVPdq9lZelN1PFVh1cADaWy5KcITZV1jPWg=;
        b=CL+kfadyELNe6Bu2JS0NyDH/5FalQ5u0ZF4bavcwA25o8wro+ToNkMR3X8Jpvi5tcdQZ8k
        TENU0ebbtzyGU3CQTjjByutZRvTeg2MiS+uUnUZ91sdpPsYQaEkzp3ns1PyD5dRaIMofs3
        JrXZSvBIDaV51DtZbv1r1zih2S0dgk8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-YFHMac8_PeKKdwc_Q9U0gw-1; Fri, 01 Jul 2022 08:09:18 -0400
X-MC-Unique: YFHMac8_PeKKdwc_Q9U0gw-1
Received: by mail-ed1-f70.google.com with SMTP id z19-20020a05640240d300b00437633081abso1676093edb.0
        for <bpf@vger.kernel.org>; Fri, 01 Jul 2022 05:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Lajk1f9JSVPdq9lZelN1PFVh1cADaWy5KcITZV1jPWg=;
        b=rIQLk2K9WsO/OoNn3d3dZv5REfNEdN7PelwIufwcDwtd17zBdp7Wtdka1dTQdofTwb
         1899t48xI40MtWrGULEleRza4tP1AeJ6S3YP6KYMSb/YviwyQA7BU7qiKfy3sFOD9nCz
         BYITuHBdyRSXDVJIsJD74Nn7tWeVtnwkJedmDE8Y+4Tfum8dqB3/AD0gqwGc98VuvzoM
         SVwltfXT7C3WsfUcIkC0BmKp9mp7Q2ox80M3LW/eoEyezIQUMLhrmxyka9oSnvSTHcjX
         vPTXPmXnxLxTS6JITri8CD3fOGoiSaLA/XbZgkByj1LDjevyGdbpVB91HCG8h/FLJLlY
         O+NA==
X-Gm-Message-State: AJIora/+REwh0l12+k58UtHSQXtucwPskFuchrNImoQts0CEvisgw5cv
        pjIwjqWbUgN/FClPfxHPbK5pVCslV+dy7bUmkcuDy/P29do8UfcXd0Bc2uBsn7uwGakYGumBB4z
        qXrYUN16zWy/q
X-Received: by 2002:aa7:c915:0:b0:437:d467:f0c5 with SMTP id b21-20020aa7c915000000b00437d467f0c5mr18523466edt.231.1656677356664;
        Fri, 01 Jul 2022 05:09:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sX5fyW2reJiwLvnZNiqRAEKkVRCfeFF8jTRefOZKB2gv5b6sMB7v7zGyhkORirzz6MR5p+zw==
X-Received: by 2002:aa7:c915:0:b0:437:d467:f0c5 with SMTP id b21-20020aa7c915000000b00437d467f0c5mr18523419edt.231.1656677356250;
        Fri, 01 Jul 2022 05:09:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 15-20020a170906300f00b0072a47b18f7csm2759286ejz.42.2022.07.01.05.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 05:09:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E1E4C477499; Fri,  1 Jul 2022 14:09:14 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>, bpf@vger.kernel.org
Cc:     xdp-hints@xdp-project.net,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Alexander Lobakin <alobakin@pm.me>
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 5/9] xdp: controlling
 XDP-hints from BPF-prog via helper
In-Reply-To: <6dc1e9f5-784e-1cb0-e091-6c03a869c15b@redhat.com>
References: <165643378969.449467.13237011812569188299.stgit@firesoul>
 <165643385885.449467.3259561784742405947.stgit@firesoul>
 <87fsjna6v7.fsf@toke.dk> <6dc1e9f5-784e-1cb0-e091-6c03a869c15b@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 01 Jul 2022 14:09:14 +0200
Message-ID: <87y1xd826t.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <jbrouer@redhat.com> writes:

> On 29/06/2022 16.20, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jesper Dangaard Brouer <brouer@redhat.com> writes:
>>=20
>>> XDP BPF-prog's need a way to interact with the XDP-hints. This patch
>>> introduces a BPF-helper function, that allow XDP BPF-prog's to interact
>>> with the XDP-hints.
>>>
>>> BPF-prog can query if any XDP-hints have been setup and if this is
>>> compatible with the xdp_hints_common struct. If XDP-hints are available
>>> the BPF "origin" is returned (see enum xdp_hints_btf_origin) as BTF can
>>> come from different sources or origins e.g. vmlinux, module or local.
>>=20
>> I'm not sure I quite understand what this origin is supposed to be good
>> for?=20
>
> Some background info on BTF is needed here: BTF_ID numbers are not
> globally unique identifiers, thus we need to know where it originate
> from, to make it unique (as we store this BTF_ID in XDP-hints).
>
> There is a connection between origin "vmlinux" and "module", which is
> that vmlinux will start at ID=3D1 and end at a max ID number.  Modules
> refer to ID's in "vmlinux", and for this to work, they will shift their
> own numbering to start after ID=3Dmax-vmlinux-id.
>
> Origin "local" is for BTF information stored in the BPF-ELF object file.
> Their numbering starts at ID=3D1.  The use-case is that a BPF-prog want to
> extend the kernel drivers BTF-layout, and e.g. add a RX-timestamp like
> [1].  Then BPF-prog can check if it knows module's BTF_ID and then
> extend via bpf_xdp_adjust_meta, and update BTF_ID in XDP-hints and call
> the helper (I introduced) marking this as origin "local" for kernel to
> know this is no-longer origin "module".

Right, I realise that :)

My point was that just knowing "this is a BTF ID coming from a module"
is not terribly useful; you could already figure that out by just
looking at the ID and seeing if it's larger than the maximum ID in
vmlinux BTF.

Rather, what we need is a way to identify *which* module the BTF ID
comes from; and luckily, the kernel assigns a unique ID to every BTF
*object* as well as to each type ID within that object. These can be
dumped by bpftool:

# bpftool btf
bpftool btf=20=20=20=20=20=20
[sudo] password for alrua:=20
1: name [vmlinux]  size 4800187B
2: name [serio]  size 2588B
3: name [i8042]  size 11786B
4: name [rng_core]  size 8184B
[...]
2062: name <anon>  size 36965B
	pids bpftool(547298)

IDs 2-4 are module BTF objects, and that last one is the ID of a BTF
object loaded along with a BPF program by bpftool itself... So we *do*
in fact have a unique ID, by combining the BTF object ID with the type
ID; this is what Alexander is proposing to put into the xdp-hints struct
as well (combining the two IDs into a single u64).

>> What is a BPF (or AF_XDP) program supposed to do with the
>> information "this XDP hints struct came from a module?" without knowing
>> which module that was?=20
>
> For AF_XDP my claim is the userspace program will already know that
> driver it is are talking to because it need to "bind" to a specific
> interface (and attach to XDP-prog to ifindex). See sample code[2] for
> get_driver_name from ifindex.
> Thus, part of using XDP-hints already involves (resolving and) opening
> /sys/kernel/btf/driver_name.  So the origin "module" is enough for the
> API end-user to make the BTF_ID unique.

This will probably work in the most common cases, but offers no way to
verify that this "offline" resolution of module ID is actually correct.
Explicitly encoding the full unique ID will be more robust.

> Runtime the BPF-prog and kernel can find out what net_device the origin
> "module" refers to via xdp_buff->rxq->dev.  When an end-user/program
> attach XDP they also need to know the ifindex, again giving them
> knowledge that make origin "module" BTF_ID's unique for them,

Right, but then the BPF program needs to keep its own lookup table from
ifindex to BTF ID? If we just encode the full ID in the packet, it's a
simple check, and we can likely create a "magic" CO-RE macro that turns
a struct definition into the right ID check at load time...

>> Ultimately, the origin is useful for a consumer
>> to check that the metadata is in the format that it's expecting it to be
>> in (so it can just load the data from the appropriate offsets). But to
>> answer this, we really need a unique identifier; so I think the approach
>> in Alexander's series of encoding the ID of the BTF structure itself
>> into the next 32 bits is better? That way we'll have a unique "pointer"
>> to the actual struct that's in the metadata area and can act on this.
>
> I would really like an explanation from Alexander, how his approach
> creates unique identifier across all kernel modules.  I don't get it
> from reading the code.  To me it looks like some extra BTF "type"
> information about the BTF_ID.
>
> E.g. how do BTF "local" BPF-ELF object's get a unique identifier, that
> doesn't overlap with e.g. kernel modules?

See above: the kernel generates a unique (until the next reboot) ID for
every BTF object when it's loaded into the kernel.

>>> RFC/TODO: Improve patch: Can verifier validate provided BTF on "update"
>>> and detect if compatible with common struct???
>>=20
>> If we have the unique ID as mentioned above, I think the kernel probably
>> could resolve this automatically: whenever a module is loaded, the
>> kernel could walk the BTF information from that module an simply inspect
>> all the metadata structs and see if they contain the embedded
>> xdp_hints_common struct. The IDs of any metadata structs that do contain
>> the common struct can then be kept in a central lookup table and the
>> consumption code can then simply compare the BTF ID to this table when
>> building an SKB?
>
> I'm not against the idea for the kernel to keep track of these structs.
> I just don't like the idea of checking this runtime, especially as this
> approach for walking all other modules BTF struct's doesn't scale.

Yeah, we should optimise this. See below...

>> As for the validation on the BPF side:n
>>=20
>>> +	if (flags & HINTS_BTF_UPDATE) {
>>> +		is_compat_common =3D !!(flags & HINTS_BTF_COMPAT_COMMON);
>>> +	/* TODO: Can kernel validate if hints are BTF compat with common? */
>>> +	/* TODO: Could BPF prog provide BTF as ARG_PTR_TO_BTF_ID to prove com=
pat_common ? */
>>=20
>> If we use the "global ID + lookup table" approach above, we don't really
>> need to validate anything here: if the program says it's writing
>> metadata with a format given by a specific ID, that implies
>> compatibility (or not) as given by the ID. We could sanity-check the
>> metadata area size, but the consumption code has to do that anyway, so
>> I'm not sure it's worth the runtime overhead to have an additional check
>> here?
>
> As you know I hate "runtime checks", and try hard to push checks to
> "setup time".  Maybe we could have verifier (or libbpf) do the check at
> setup/load time, by identifying the helper call and check if provided
> BTF do match COMPAT_COMMON claim.
>
> For this to work, the verifier need to be able to resolve origin
> "module", which happens at BPF load-time, so we would need to set the
> ifindex (curr used for XDP-hardware-offload) at BPF load-time.

If we make the UAPI on the BPF side just accept a full BTF object+type
ID, and also require that the value being passed to the helper is a
compile-time constant (so it is visible to the verifier at verification
time), it is straight-forward for the verifier to just lookup the BTF
type, check if it contains the "hints_common" struct and if it does,
rewrite the helper call to set the right value of the "compat_common"
flag without exposing the flag itself as UAPI.

The driver code would probably still have to set this flag "manually",
but that's internal kernel API, so that's probably fine...

>> As for safety of the metadata content itself, I don't really think we
>> can do anything to guarantee this: in any case the BPF program can pass
>> a valid BTF ID and still write garbage values into the actual fields, so
>> the consumption code has to do enough validation that this won't crash
>> the kernel anyway. But this is no different from the packet data itself:
>> XDP is basically in a position to be a MITM attacker of the network
>> stack itself, which is why loading XDP programs is a privileged
>> operation...
>
> I agree, that we cannot stop the end-user from screwing up their
> BPF-prog to provide garbage in the fields, as long as it doesn't crash
> the kernel.  I do think it would improve usability for end-users if we
> can detect and report that their BPF-prog have gotten out of sync with
> the running kernel and their claim that their BTF layout are
> COMPAT_COMMON isn't actually true.  But I guess it is shouldn't block
> the code, as it's only an extra usability help.

Yeah, I agree this could be error prone; which is why I think not
exposing the flag itself as UAPI is a better solution ;)

-Toke

