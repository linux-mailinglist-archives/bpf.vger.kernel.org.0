Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668736154E9
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 23:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiKAWYp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 18:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiKAWYn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 18:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAAD1BEA2
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 15:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667341411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BWYJNjs5+6LYYUemP579X3fkX685gPk4jKAzaeAb8GA=;
        b=GpE8N6nbmweSxvi2F8278vUGks+5EsbhS7r63lPlJlox98LfLnih/wu2stt3gYBj4Gv8OQ
        Uq57ebdhVohi87HJA6jR68nnHD0iknZUBUO2rnEA0zhZQTPhtuUuXkCSNmybfAZRlX9ppG
        Uydb5yiRD8D/lJTnuAvm0XthILoudlM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-NM9ncKEMNJm4GUn3hswZDg-1; Tue, 01 Nov 2022 18:23:30 -0400
X-MC-Unique: NM9ncKEMNJm4GUn3hswZDg-1
Received: by mail-ej1-f72.google.com with SMTP id hp16-20020a1709073e1000b007adf5a83df7so1312347ejc.1
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 15:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWYJNjs5+6LYYUemP579X3fkX685gPk4jKAzaeAb8GA=;
        b=M89rsy9MFssE8DnVwGYxGxMoXTJO6sPHb8lJDN6nPuVaXNag4qLvT+Mct5H7+YkQZV
         TZm+FW9QmqEWCMMibt02fyos1UEP6LdMzoLMnWgQPj1zyK74vIAlYQVlN1oQn8NdmVFT
         l5eIe9zxMetsxUvc9zk6k5VHXtBbBA+PtAo+4L0KMIsTUFQEHRcVMhav/DzzWiBfvBYj
         wneWbJe0ABcuZb3ytJHHIyV6OLXuMbTwmmCeAz8aZhxrxw6H5vTaF6Y52LUoOac000VR
         KuzWqBzrfcL8TfGamcLdDywpKknirw1VY384UgHIEwmX2iH3uNURq+2YAGmfzbK9DI9T
         8Wwg==
X-Gm-Message-State: ACrzQf0LgQ5V3UMspcQ24/0Sr1TgoFhj21gMP2YlupQraIMVOLtojRWa
        SlrvIbF/LqYjiBqSPzwAAN00UQGWaiLb6rFCzNuq1B5U6IulZWEWXf+zCvYed3EXsale1CLF0bC
        qET+30n3PQkdq
X-Received: by 2002:aa7:c54b:0:b0:463:e966:d30c with SMTP id s11-20020aa7c54b000000b00463e966d30cmr1541865edr.222.1667341408940;
        Tue, 01 Nov 2022 15:23:28 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM41pE1VzKILWoSabjbW8St1P0wddk3W1IlmLVT+qCywenwINlLE3zVv29pgwqByFPAA3GTwow==
X-Received: by 2002:aa7:c54b:0:b0:463:e966:d30c with SMTP id s11-20020aa7c54b000000b00463e966d30cmr1541837edr.222.1667341408498;
        Tue, 01 Nov 2022 15:23:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709061db200b007030c97ae62sm4619454ejh.191.2022.11.01.15.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:23:28 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A74E674B0C5; Tue,  1 Nov 2022 23:23:27 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Stanislav Fomichev <sdf@google.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     brouer@redhat.com, Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, John Fastabend <john.fastabend@gmail.com>,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [xdp-hints] Re: [RFC bpf-next 5/5] selftests/bpf: Test
 rx_timestamp metadata in xskxceiver
In-Reply-To: <a5b70078-5223-b4d6-5aba-1dc698de68a7@redhat.com>
References: <20221027200019.4106375-1-sdf@google.com>
 <20221027200019.4106375-6-sdf@google.com>
 <31f3aa18-d368-9738-8bb5-857cd5f2c5bf@linux.dev>
 <1885bc0c-1929-53ba-b6f8-ace2393a14df@redhat.com>
 <CAKH8qBt3hNUO0H_C7wYiwBEObGEFPXJCCLfkA=GuGC1CSpn55A@mail.gmail.com>
 <20221031142032.164247-1-alexandr.lobakin@intel.com>
 <CAKH8qBt1qM1n0X5uwxcBph9gLOv3FXR2q11viUoxxn35Z2_=ag@mail.gmail.com>
 <a5b70078-5223-b4d6-5aba-1dc698de68a7@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Nov 2022 23:23:27 +0100
Message-ID: <87leou48m8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>>>>> So, this approach first stores hints on some other memory location, and
>>>>> then need to copy over information into data_meta area. That isn't good
>>>>> from a performance perspective.
>>>>>
>>>>> My idea is to store it in the final data_meta destination immediately.
>>>>
>>>> This approach doesn't have to store the hints in the other memory
>>>> location. xdp_buff->priv can point to the real hw descriptor and the
>>>> kfunc can have a bytecode that extracts the data from the hw
>>>> descriptors. For this particular RFC, we can think that 'skb' is that
>>>> hw descriptor for veth driver.
>
> Once you point xdp_buff->priv to the real hw descriptor, then we also
> need to have some additional data/pointers to NIC hardware info + HW
> setup state. You will hit some of the same challenges as John, like
> hardware/firmware revisions and chip models, that Jakub pointed out.
> Because your approach stays with the driver code, I guess it will be a
> bit easier code wise. Maybe we can store data/pointer needed for this in
> xdp_rxq_info (xdp->rxq).
>
> I would need to see some code that juggling this HW NCI state from the
> kfunc expansion to be convinced this is the right approach.

+1 on needing to see this working for the actual metadata we want to
support, but I think the kfunc approach otherwise shows promise; see
below.

[...]

> Sure it is super cool if we can create this BPF layer that programmable
> selects individual fields from the descriptor, and maybe we ALSO need that.
> Could this layer could still be added after my patchset(?), as one could
> disable the XDP-hints (via ethtool) and then use kfuncs/kptr to extract
> only fields need by the specific XDP-prog use-case.
> Could they also co-exist(?), kfuncs/kptr could extend the
> xdp_hints_rx_common struct (in data_meta area) with more advanced
> offload-hints and then update the BTF-ID (yes, BPF can already resolve
> its own BTF-IDs from BPF-prog code).

I actually think the two approaches are more similar than they appear
from a user-facing API perspective. Or at least they should be.

What I mean is, that with the BTF-ID approach, we still expect people to
write code like (from Stanislav's example in the other xdp_hints thread[0]):

If (ctx_hints_btf_id == xdp_hints_ixgbe_timestamp_btf_id /* supposedly
populated at runtime by libbpf? */) {
  // do something with rx_timestamp
  // also, handle xdp_hints_ixgbe and then xdp_hints_common ?
} else if (ctx_hints_btf_id == xdp_hints_ixgbe) {
  // do something else
  // plus explicitly handle xdp_hints_common here?
} else {
  // handle xdp_hints_common
}

whereas with kfuncs (from this thread) this becomes:

if (xdp_metadata_rx_timestamp_exists(ctx))
  timestamp = xdp_metadata_rx_timestamp(ctx);


We can hide the former behind CO-RE macros to make it look like the
latter. But because we're just exposing the BTF IDs, people can in fact
just write code like the example above (directly checking the BTF IDs),
and that will work fine, but has a risk of leading to a proliferation of
device-specific XDP programs. Whereas with kfuncs we keep all this stuff
internal to the kernel (inside the kfuncs), making it much easier to
change it later.

Quoting yourself from the other thread[1]:

> In this patchset I'm trying to balance the different users. And via BTF
> I'm trying hard not to create more UAPI (e.g. more fixed fields avail in
> xdp_md that we cannot get rid of). And trying to add driver flexibility
> on-top of the common struct.  This flexibility seems to be stalling the
> patchset as we haven't found the perfect way to express this (yet) given
> BTF layout is per driver.

With kfuncs we kinda sidestep this issue because the kernel can handle
the per-driver specialisation by the unrolling trick. The drawback being
that programs will be tied to a particular device if they are using
metadata, but I think that's an acceptable trade-off.

-Toke

[0] https://lore.kernel.org/r/CAKH8qBuYVk7QwVOSYrhMNnaKFKGd7M9bopDyNp6-SnN6hSeTDQ@mail.gmail.com
[1] https://lore.kernel.org/r/ad360933-953a-7a99-5057-4d452a9a6005@redhat.com

