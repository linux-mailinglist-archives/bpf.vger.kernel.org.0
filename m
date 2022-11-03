Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4F0617341
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 01:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiKCAKl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 20:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKCAKi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 20:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04E06454
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 17:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667434176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KuV0/QKW5Umaj08Kg5BE39XjCO1VUpqxKEoA/u2tBII=;
        b=aRPegDtZQB28Sd5Tev6RZfvjk2+AYM0qcmqUpSZWc3d4X7PKyxMxA3OgGGaioDDBS/Djtr
        cwlp90npYkf+Use580WmNWeXJ9FcEAOEFGOCviuGp1v4OUFyocg1SLxzRq2UTGYNYOEewR
        p7gJYx6Hgs4Zg3k5A5fM3AvPrCsdcEE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-262-DCVa-8a0MzyIEKNTVSHiLQ-1; Wed, 02 Nov 2022 20:09:35 -0400
X-MC-Unique: DCVa-8a0MzyIEKNTVSHiLQ-1
Received: by mail-ed1-f72.google.com with SMTP id v18-20020a056402349200b004622e273bbbso280740edc.14
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 17:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuV0/QKW5Umaj08Kg5BE39XjCO1VUpqxKEoA/u2tBII=;
        b=RPs0iP1AMQQgq87bRszz5vhNhHz1Cj0JCjyX1fWJftA38ih9y2r2uCyv9MiDuy0cny
         n/p/GjWk+6QMPdaZBtMOH+jwn0XOAh/T7cioK1VJ2DJ+hYjsJzeQJz9PTN0PmdWmL2Ma
         S2F2RqDAiabfllD0xb0OQ2m56hk1KOzOw2Z2Cnjo0c01QfddqjabdlBxYkRCkQ6hJmXT
         ChQ1O2tCvcLOuBnHW4Hzl0w8lzOHZnVyKoCfdag/5WMSA65XmSkg4o8ZuFYeQnZnoUZF
         jQkr04RqubKSA92idY8uuWtgXCjKd9hAvmC9C1G7VWSMuXrhxwTWTndu8roK+4Cymsis
         6D+Q==
X-Gm-Message-State: ACrzQf07JRuTnpglMQbC+ymdj8JvaacCSak0QUlph7Uij+S9JHPDvkO4
        djNDZulCZCIBxRBS45BUZPw9qdEchOPLBYAr91WtJDxRvO8M/Us+Jdf/anxEq8mEuOLSv30UUu4
        FxIFeVAafeFml
X-Received: by 2002:a17:906:79d8:b0:7ad:b675:f34d with SMTP id m24-20020a17090679d800b007adb675f34dmr23558054ejo.194.1667434174566;
        Wed, 02 Nov 2022 17:09:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7P5jAtkh5zseSd7FGF0lbegfat7PhY0/kjcAmtagIHVsBGpV7cBHVDWzLbqimXjY8fwOdnfQ==
X-Received: by 2002:a17:906:79d8:b0:7ad:b675:f34d with SMTP id m24-20020a17090679d800b007adb675f34dmr23558028ejo.194.1667434174181;
        Wed, 02 Nov 2022 17:09:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b007aacfce2a91sm5935529ejc.27.2022.11.02.17.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 17:09:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 579DB750720; Thu,  3 Nov 2022 01:09:33 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, brouer@redhat.com,
        "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "alexandr.lobakin@intel.com" <alexandr.lobakin@intel.com>,
        "anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
        "song@kernel.org" <song@kernel.org>,
        "Deric, Nemanja" <nemanja.deric@siemens.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "magnus.karlsson@gmail.com" <magnus.karlsson@gmail.com>,
        "willemb@google.com" <willemb@google.com>,
        "ast@kernel.org" <ast@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "mtahhan@redhat.com" <mtahhan@redhat.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "haoluo@google.com" <haoluo@google.com>
Subject: Re: [xdp-hints] Re: [RFC bpf-next 0/5] xdp: hints via kfuncs
In-Reply-To: <CAKH8qBt31WBpDWb+SkNpuzE1PuwC1O_v7seF9TMJfc6SvhN7MQ@mail.gmail.com>
References: <20221027200019.4106375-1-sdf@google.com>
 <635bfc1a7c351_256e2082f@john.notmuch>
 <20221028110457.0ba53d8b@kernel.org>
 <CAKH8qBshi5dkhqySXA-Rg66sfX0-eTtVYz1ymHfBxSE=Mt2duA@mail.gmail.com>
 <635c62c12652d_b1ba208d0@john.notmuch>
 <20221028181431.05173968@kernel.org>
 <5aeda7f6bb26b20cb74ef21ae9c28ac91d57fae6.camel@siemens.com>
 <875yg057x1.fsf@toke.dk>
 <CAKH8qBvQbgE=oSZoH4xiLJmqMSXApH-ufd-qEKGKD8=POfhrWQ@mail.gmail.com>
 <77b115a0-bbba-48eb-89bd-3078b5fb7eeb@linux.dev>
 <CAKH8qBsGB1G60cu91Au816gsB2zF8T0P-yDwxbTEOxX0TN3WgA@mail.gmail.com>
 <0c00ba33-f37b-dfe6-7980-45920ffa273b@linux.dev>
 <48ba6e77-1695-50b3-b27f-e82750ee70bb@redhat.com> <87iljx2ey4.fsf@toke.dk>
 <CAKH8qBt31WBpDWb+SkNpuzE1PuwC1O_v7seF9TMJfc6SvhN7MQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 03 Nov 2022 01:09:33 +0100
Message-ID: <87cza43nlu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> On Wed, Nov 2, 2022 at 3:02 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Jesper Dangaard Brouer <jbrouer@redhat.com> writes:
>>
>> > On 01/11/2022 18.05, Martin KaFai Lau wrote:
>> >> On 10/31/22 6:59 PM, Stanislav Fomichev wrote:
>> >>> On Mon, Oct 31, 2022 at 3:57 PM Martin KaFai Lau
>> >>> <martin.lau@linux.dev> wrote:
>> >>>>
>> >>>> On 10/31/22 10:00 AM, Stanislav Fomichev wrote:
>> >>>>>> 2. AF_XDP programs won't be able to access the metadata without
>> >>>>>> using a
>> >>>>>> custom XDP program that calls the kfuncs and puts the data into t=
he
>> >>>>>> metadata area. We could solve this with some code in libxdp,
>> >>>>>> though; if
>> >>>>>> this code can be made generic enough (so it just dumps the availa=
ble
>> >>>>>> metadata functions from the running kernel at load time), it may =
be
>> >>>>>> possible to make it generic enough that it will be forward-compat=
ible
>> >>>>>> with new versions of the kernel that add new fields, which should
>> >>>>>> alleviate Florian's concern about keeping things in sync.
>> >>>>>
>> >>>>> Good point. I had to convert to a custom program to use the kfuncs=
 :-(
>> >>>>> But your suggestion sounds good; maybe libxdp can accept some extra
>> >>>>> info about at which offset the user would like to place the metada=
ta
>> >>>>> and the library can generate the required bytecode?
>> >>>>>
>> >>>>>> 3. It will make it harder to consume the metadata when building
>> >>>>>> SKBs. I
>> >>>>>> think the CPUMAP and veth use cases are also quite important, and=
 that
>> >>>>>> we want metadata to be available for building SKBs in this path. =
Maybe
>> >>>>>> this can be resolved by having a convenient kfunc for this that c=
an be
>> >>>>>> used for programs doing such redirects. E.g., you could just call
>> >>>>>> xdp_copy_metadata_for_skb() before doing the bpf_redirect, and th=
at
>> >>>>>> would recursively expand into all the kfunc calls needed to extra=
ct
>> >>>>>> the
>> >>>>>> metadata supported by the SKB path?
>> >>>>>
>> >>>>> So this xdp_copy_metadata_for_skb will create a metadata layout th=
at
>> >>>>
>> >>>> Can the xdp_copy_metadata_for_skb be written as a bpf prog itself?
>> >>>> Not sure where is the best point to specify this prog though.
>> >>>> Somehow during
>> >>>> bpf_xdp_redirect_map?
>> >>>> or this prog belongs to the target cpumap and the xdp prog
>> >>>> redirecting to this
>> >>>> cpumap has to write the meta layout in a way that the cpumap is
>> >>>> expecting?
>> >>>
>> >>> We're probably interested in triggering it from the places where xdp
>> >>> frames can eventually be converted into skbs?
>> >>> So for plain 'return XDP_PASS' and things like bpf_redirect/etc? (IO=
W,
>> >>> anything that's not XDP_DROP / AF_XDP redirect).
>> >>> We can probably make it magically work, and can generate
>> >>> kernel-digestible metadata whenever data =3D=3D data_meta, but the
>> >>> question - should we?
>> >>> (need to make sure we won't regress any existing cases that are not
>> >>> relying on the metadata)
>> >>
>> >> Instead of having some kernel-digestible meta data, how about calling
>> >> another bpf prog to initialize the skb fields from the meta area after
>> >> __xdp_build_skb_from_frame() in the cpumap, so
>> >> run_xdp_set_skb_fileds_from_metadata() may be a better name.
>> >>
>> >
>> > I very much like this idea of calling another bpf prog to initialize t=
he
>> > SKB fields from the meta area. (As a reminder, data need to come from
>> > meta area, because at this point the hardware RX-desc is out-of-scope).
>> > I'm onboard with xdp_copy_metadata_for_skb() populating the meta area.
>> >
>> > We could invoke this BPF-prog inside __xdp_build_skb_from_frame().
>> >
>> > We might need a new BPF_PROG_TYPE_XDP2SKB as this new BPF-prog
>> > run_xdp_set_skb_fields_from_metadata() would need both xdp_buff + SKB =
as
>> > context inputs. Right?  (Not sure, if this is acceptable with the BPF
>> > maintainers new rules)
>> >
>> >> The xdp_prog@rx sets the meta data and then redirect.  If the
>> >> xdp_prog@rx can also specify a xdp prog to initialize the skb fields
>> >> from the meta area, then there is no need to have a kfunc to enforce a
>> >> kernel-digestible layout.  Not sure what is a good way to specify this
>> >> xdp_prog though...
>> >
>> > The challenge of running this (BPF_PROG_TYPE_XDP2SKB) BPF-prog inside
>> > __xdp_build_skb_from_frame() is that it need to know howto decode the
>> > meta area for every device driver or XDP-prog populating this (as veth
>> > and cpumap can get redirected packets from multiple device drivers).
>>
>> If we have the helper to copy the data "out of" the drivers, why do we
>> need a second BPF program to copy data to the SKB?
>>
>> I.e., the XDP program calls xdp_copy_metadata_for_skb(); this invokes
>> each of the kfuncs needed for the metadata used by SKBs, all of which
>> get unrolled. The helper takes the output of these metadata-extracting
>> kfuncs and stores it "somewhere". This "somewhere" could well be the
>> metadata area; but in any case, since it's hidden away inside a helper
>> (or kfunc) from the calling XDP program's PoV, the helper can just stash
>> all the data in a fixed format, which __xdp_build_skb_from_frame() can
>> then just read statically. We could even make this format match the
>> field layout of struct sk_buff, so all we have to do is memcpy a
>> contiguous chunk of memory when building the SKB.
>
> +1
>
> I'm currently doing exactly what you're suggesting (minus matching skb la=
yout):
>
> struct xdp_to_skb_metadata {
>   u32 magic; // randomized at boot
>   ... skb-consumable-metadata in fixed format
> } __randomize_layout;
>
> bpf_xdp_copy_metadata_for_skb() does bpf_xdp_adjust_meta(ctx,
> -sizeof(struct xdp_to_skb_metadata)) and then calls a bunch of kfuncs
> to fill in the actual data.
>
> Then, at __xdp_build_skb_from_frame time, I'm having a regular kernel
> C code that parses that 'struct xdp_to_skb_metadata'.
> (To be precise, I'm trying to parse the metadata from
> skb_metadata_set; it's called from __xdp_build_skb_from_frame, but not
> 100% sure that's the right place).
> (I also randomize the layout and magic to make sure userspace doesn't
> depend on it because nothing stops this packet to be routed into xsk
> socket..)

Ah, nice trick with __randomize_layout - I agree we need to do something
to prevent userspace from inadvertently starting to rely on this, and
this seems like a great solution!

Look forward to seeing what the whole thing looks like in a more
complete form :)

-Toke

