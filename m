Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0126562F8E
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 11:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiGAJKw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 05:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiGAJKv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 05:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD7A33135F
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 02:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656666650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ha22KHyIXSdBBz3QWDSA7oxPGo4QM+O1JeALObg3GJQ=;
        b=FT3f8Z25hV4vcphroEGt53DfxPpXASf4tLEVedRWIAggt8rBNe1k42FFPuZ9Fdi+F1gaiE
        Hh8JAGscld6NzMg1O51okl2NRlEJ6wyjEfhZ+uD1jG6xuRMEVqDEqoWaN2jFIU8nYEfmmB
        OxMQhdupBF6dlgvVxketu3EASGCcPHs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-AeICyG3sMO2RprPp2i3-cg-1; Fri, 01 Jul 2022 05:10:49 -0400
X-MC-Unique: AeICyG3sMO2RprPp2i3-cg-1
Received: by mail-lj1-f199.google.com with SMTP id b40-20020a2ebc28000000b0025c047ea79dso256031ljf.23
        for <bpf@vger.kernel.org>; Fri, 01 Jul 2022 02:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:date:mime-version:user-agent:cc
         :subject:content-language:to:references:in-reply-to
         :content-transfer-encoding;
        bh=Ha22KHyIXSdBBz3QWDSA7oxPGo4QM+O1JeALObg3GJQ=;
        b=2Kz/eER3ZUrXVuXWGgzhVm/QZIDBf+7fVq3Neoflj56lqRHG4UGDX+pQpU7zWZtgtq
         zZubyg2yqHd3njagAivn0yET7EzJUlXl46DE7TB4W8NOmkIKQRY/jL3LfJnRqtiiSar7
         sGuUGmRPVfU5XLYD63MT3aorSRqxdSWsdzyRWZBnrDD6tdY/vhibdXHcbmkwEVNJwIka
         IBNq9AZl/ti0ECC7qq0sO+qIrwazF4pGW4FSGVq9Yb+cJoL038C+0RemSm3quLj+QUcy
         jzKhIpPi2wLSTZwbrhwP6Kk4zMVzauERycY7al9sC4/9wx54z5J88gc5jizX9tb8YjH5
         7cpQ==
X-Gm-Message-State: AJIora/KMO1xfQBYAiaQndOPUfbbifGUDyhIIIejCHjKTTE2c26De9pu
        52RgMPNI8YzCtmofXtQt8NW8vD2kUszaz5zVf2500sfuFs2yIAjX8oWMJ1zGvOVeFv1jp+Woro0
        u4TPnINmBLt9Q
X-Received: by 2002:a2e:941:0:b0:25b:bf7d:2f9d with SMTP id 62-20020a2e0941000000b0025bbf7d2f9dmr8000472ljj.478.1656666647173;
        Fri, 01 Jul 2022 02:10:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ultni/eW5JwUbbBTL0wj0CCUZdPlKl2Ax9jQYxqRmKBTKwBgl8qV8XWvp6AOhj2sa8jVhjEw==
X-Received: by 2002:a2e:941:0:b0:25b:bf7d:2f9d with SMTP id 62-20020a2e0941000000b0025bbf7d2f9dmr8000451ljj.478.1656666646766;
        Fri, 01 Jul 2022 02:10:46 -0700 (PDT)
Received: from [192.168.0.50] (87-59-106-155-cable.dk.customer.tdc.net. [87.59.106.155])
        by smtp.gmail.com with ESMTPSA id cf3-20020a056512280300b0047fa8ffe92csm3530776lfb.233.2022.07.01.02.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 02:10:46 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <6dc1e9f5-784e-1cb0-e091-6c03a869c15b@redhat.com>
Date:   Fri, 1 Jul 2022 11:10:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Cc:     xdp-hints@xdp-project.net,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Alexander Lobakin <alobakin@pm.me>
Subject: Re: [xdp-hints] Re: [PATCH RFC bpf-next 5/9] xdp: controlling
 XDP-hints from BPF-prog via helper
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org
References: <165643378969.449467.13237011812569188299.stgit@firesoul>
 <165643385885.449467.3259561784742405947.stgit@firesoul>
 <87fsjna6v7.fsf@toke.dk>
In-Reply-To: <87fsjna6v7.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 29/06/2022 16.20, Toke Høiland-Jørgensen wrote:
> Jesper Dangaard Brouer <brouer@redhat.com> writes:
> 
>> XDP BPF-prog's need a way to interact with the XDP-hints. This patch
>> introduces a BPF-helper function, that allow XDP BPF-prog's to interact
>> with the XDP-hints.
>>
>> BPF-prog can query if any XDP-hints have been setup and if this is
>> compatible with the xdp_hints_common struct. If XDP-hints are available
>> the BPF "origin" is returned (see enum xdp_hints_btf_origin) as BTF can
>> come from different sources or origins e.g. vmlinux, module or local.
> 
> I'm not sure I quite understand what this origin is supposed to be good
> for? 

Some background info on BTF is needed here: BTF_ID numbers are not
globally unique identifiers, thus we need to know where it originate
from, to make it unique (as we store this BTF_ID in XDP-hints).

There is a connection between origin "vmlinux" and "module", which is
that vmlinux will start at ID=1 and end at a max ID number.  Modules
refer to ID's in "vmlinux", and for this to work, they will shift their
own numbering to start after ID=max-vmlinux-id.

Origin "local" is for BTF information stored in the BPF-ELF object file.
Their numbering starts at ID=1.  The use-case is that a BPF-prog want to
extend the kernel drivers BTF-layout, and e.g. add a RX-timestamp like
[1].  Then BPF-prog can check if it knows module's BTF_ID and then
extend via bpf_xdp_adjust_meta, and update BTF_ID in XDP-hints and call
the helper (I introduced) marking this as origin "local" for kernel to
know this is no-longer origin "module".

  [1] 
https://github.com/xdp-project/bpf-examples/tree/master/AF_XDP-interaction/

> What is a BPF (or AF_XDP) program supposed to do with the
> information "this XDP hints struct came from a module?" without knowing
> which module that was? 

For AF_XDP my claim is the userspace program will already know that
driver it is are talking to because it need to "bind" to a specific
interface (and attach to XDP-prog to ifindex). See sample code[2] for
get_driver_name from ifindex.
Thus, part of using XDP-hints already involves (resolving and) opening
/sys/kernel/btf/driver_name.  So the origin "module" is enough for the
API end-user to make the BTF_ID unique.

Runtime the BPF-prog and kernel can find out what net_device the origin
"module" refers to via xdp_buff->rxq->dev.  When an end-user/program
attach XDP they also need to know the ifindex, again giving them
knowledge that make origin "module" BTF_ID's unique for them,

Same way the origin "local" have meaning to the BPF-prog and user
loading it.

  [2] 
https://github.com/torvalds/linux/blob/v5.18/samples/bpf/xdp_sample_user.c#L1602


> Ultimately, the origin is useful for a consumer
> to check that the metadata is in the format that it's expecting it to be
> in (so it can just load the data from the appropriate offsets). But to
> answer this, we really need a unique identifier; so I think the approach
> in Alexander's series of encoding the ID of the BTF structure itself
> into the next 32 bits is better? That way we'll have a unique "pointer"
> to the actual struct that's in the metadata area and can act on this.

I would really like an explanation from Alexander, how his approach
creates unique identifier across all kernel modules.  I don't get it
from reading the code.  To me it looks like some extra BTF "type"
information about the BTF_ID.

E.g. how do BTF "local" BPF-ELF object's get a unique identifier, that
doesn't overlap with e.g. kernel modules?

>> RFC/TODO: Improve patch: Can verifier validate provided BTF on "update"
>> and detect if compatible with common struct???
> 
> If we have the unique ID as mentioned above, I think the kernel probably
> could resolve this automatically: whenever a module is loaded, the
> kernel could walk the BTF information from that module an simply inspect
> all the metadata structs and see if they contain the embedded
> xdp_hints_common struct. The IDs of any metadata structs that do contain
> the common struct can then be kept in a central lookup table and the
> consumption code can then simply compare the BTF ID to this table when
> building an SKB?

I'm not against the idea for the kernel to keep track of these structs.
I just don't like the idea of checking this runtime, especially as this
approach for walking all other modules BTF struct's doesn't scale.


> As for the validation on the BPF side:n
> 
>> +	if (flags & HINTS_BTF_UPDATE) {
>> +		is_compat_common = !!(flags & HINTS_BTF_COMPAT_COMMON);
>> +	/* TODO: Can kernel validate if hints are BTF compat with common? */
>> +	/* TODO: Could BPF prog provide BTF as ARG_PTR_TO_BTF_ID to prove compat_common ? */
> 
> If we use the "global ID + lookup table" approach above, we don't really
> need to validate anything here: if the program says it's writing
> metadata with a format given by a specific ID, that implies
> compatibility (or not) as given by the ID. We could sanity-check the
> metadata area size, but the consumption code has to do that anyway, so
> I'm not sure it's worth the runtime overhead to have an additional check
> here?

As you know I hate "runtime checks", and try hard to push checks to
"setup time".  Maybe we could have verifier (or libbpf) do the check at
setup/load time, by identifying the helper call and check if provided
BTF do match COMPAT_COMMON claim.

For this to work, the verifier need to be able to resolve origin
"module", which happens at BPF load-time, so we would need to set the
ifindex (curr used for XDP-hardware-offload) at BPF load-time.


> As for safety of the metadata content itself, I don't really think we
> can do anything to guarantee this: in any case the BPF program can pass
> a valid BTF ID and still write garbage values into the actual fields, so
> the consumption code has to do enough validation that this won't crash
> the kernel anyway. But this is no different from the packet data itself:
> XDP is basically in a position to be a MITM attacker of the network
> stack itself, which is why loading XDP programs is a privileged
> operation...

I agree, that we cannot stop the end-user from screwing up their
BPF-prog to provide garbage in the fields, as long as it doesn't crash
the kernel.  I do think it would improve usability for end-users if we
can detect and report that their BPF-prog have gotten out of sync with
the running kernel and their claim that their BTF layout are
COMPAT_COMMON isn't actually true.  But I guess it is shouldn't block
the code, as it's only an extra usability help.

--Jesper

