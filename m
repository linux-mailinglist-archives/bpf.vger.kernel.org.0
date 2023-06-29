Return-Path: <bpf+bounces-3726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8244742538
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 14:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CC11C209F6
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 12:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E44111AA;
	Thu, 29 Jun 2023 12:01:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F7710959
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 12:01:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3562D69
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 05:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688040086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2v0l5lRAbV2Wf694zzIazWXahqcGK+nFJgcSv3W4pq4=;
	b=WynbFADPyouz3LuRHaKJKVzEr+9hqQPpWHlb8eEwdSbH+bdNw2ulTcuy9myBIB6RCC4TyZ
	9r3mCFl/yLZA/f+EWEuxh8+6Tzin33v5ogVPpi1bVjY3XqXaDAnWsaWxz7X0laMyFdvWfx
	vXKI6NTjpkyi0sqVrZprD/pK3kfrkXQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-tSaIc1dLPkK5nUdDVto7Cg-1; Thu, 29 Jun 2023 08:01:24 -0400
X-MC-Unique: tSaIc1dLPkK5nUdDVto7Cg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f814f78af2so2834545e9.0
        for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 05:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688040083; x=1690632083;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2v0l5lRAbV2Wf694zzIazWXahqcGK+nFJgcSv3W4pq4=;
        b=IPp88KWcN0GG4a0KRoo13GGsi1dwvhtAohieve4F8ts09Uy7ZtzemEeY7KZNnEtyIB
         vd4RPSehROCCIpR4f4hq/ItjyETxlmE1PgML3xzt6fIsgu8ig38l4B/Tpttv4ZBAuFkb
         tyEZKUMV9bokBnAU/a5yrialc3mpXvv/70ILaV/A7qfrjMqBeV7C1Y0YGv1tjF2dcvXf
         p5HBqHGBpOamq70/CZBR84eub964lxChOIEXPAETTIn5ykXQe+Xc/44ZmBMLXn8OlMiF
         +UtW86ln2diVU1cqLQF5uRrdPM6ZKHcOcLIn+UonwAvdtieEiQIU7ZSoIW7L6QM08agw
         y82w==
X-Gm-Message-State: AC+VfDwr82OjCVfixnUAlfsfIC4rXnshTWtKLl5mq3gTgR/vChmxzp/R
	Kr5HAxJmxIHjmr06NrZ2S/r3pl15So6jM9qJWtg4MCB6+Cxgo1pJ5IEKK0gQ5t6G3jesM2ZmstF
	kqinEkpmgwjuF
X-Received: by 2002:a05:600c:24e:b0:3fb:af95:1f4d with SMTP id 14-20020a05600c024e00b003fbaf951f4dmr4144509wmj.15.1688040083521;
        Thu, 29 Jun 2023 05:01:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5q2Nuit0XX6S8TqYjSh3Cc+IFOOEc8W/3Q00LAUE2onY6SkmCScAbdv/yOP4uu5r/BlvYQsg==
X-Received: by 2002:a05:600c:24e:b0:3fb:af95:1f4d with SMTP id 14-20020a05600c024e00b003fbaf951f4dmr4144479wmj.15.1688040083044;
        Thu, 29 Jun 2023 05:01:23 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z24-20020a05600c221800b003fa96fe2bd9sm11291727wml.22.2023.06.29.05.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 05:01:22 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6EF17BC0447; Thu, 29 Jun 2023 14:01:21 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, Jesper Dangaard Brouer
 <jbrouer@redhat.com>, brouer@redhat.com, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "Karlsson, Magnus"
 <magnus.karlsson@intel.com>, "xdp-hints@xdp-project.net"
 <xdp-hints@xdp-project.net>
Subject: Re: [xdp-hints] Re: [RFC bpf-next v2 03/11] xsk: Support
 XDP_TX_METADATA_LEN
In-Reply-To: <CAJ8uoz2Km078-K9e+8KtpiUJwTRN2p6yZrYbMD7bYaEKAfGf4w@mail.gmail.com>
References: <20230621170244.1283336-1-sdf@google.com>
 <20230621170244.1283336-4-sdf@google.com>
 <57b9fc14-c02e-f0e5-148d-a549ebab6cf6@brouer.com>
 <CAKH8qBsk3MDbx2PyU-_+tDV4C0R6J_wzxi9Co6ekHv_tWzp7Tw@mail.gmail.com>
 <c936bd6c-7060-47da-d522-747b49bee8a0@redhat.com>
 <CAKH8qBsqdE7=4JC8LfkL4gV9eQHEZjMpBSen2a+4q2Y7DpiOow@mail.gmail.com>
 <435d1630-c3f4-97fb-b6fe-9795d1f0bf33@redhat.com>
 <CAKH8qBtdKHCnFWUiz8H_5miPF82nqKhG4Dfx9GbQYgWbYfERjg@mail.gmail.com>
 <CAJ8uoz0MuXYJE_a58PCtCypscZfevE2tgheC32e=zqEdNPgbnw@mail.gmail.com>
 <CAKH8qBui6gieETYzDugG0=nmBR-QnhhhyqaF3px0sjG7-BKLhQ@mail.gmail.com>
 <871qhuh5ec.fsf@toke.dk>
 <CAJ8uoz2Km078-K9e+8KtpiUJwTRN2p6yZrYbMD7bYaEKAfGf4w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 29 Jun 2023 14:01:21 +0200
Message-ID: <87r0pufpf2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> On Thu, 29 Jun 2023 at 13:30, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>>
>> Stanislav Fomichev <sdf@google.com> writes:
>>
>> > On Wed, Jun 28, 2023 at 1:09=E2=80=AFAM Magnus Karlsson
>> > <magnus.karlsson@gmail.com> wrote:
>> >>
>> >> On Mon, 26 Jun 2023 at 19:06, Stanislav Fomichev <sdf@google.com> wro=
te:
>> >> >
>> >> > On Sat, Jun 24, 2023 at 2:02=E2=80=AFAM Jesper Dangaard Brouer
>> >> > <jbrouer@redhat.com> wrote:
>> >> > >
>> >> > >
>> >> > >
>> >> > > On 23/06/2023 19.41, Stanislav Fomichev wrote:
>> >> > > > On Fri, Jun 23, 2023 at 3:24=E2=80=AFAM Jesper Dangaard Brouer
>> >> > > > <jbrouer@redhat.com> wrote:
>> >> > > >>
>> >> > > >>
>> >> > > >>
>> >> > > >> On 22/06/2023 19.55, Stanislav Fomichev wrote:
>> >> > > >>> On Thu, Jun 22, 2023 at 2:11=E2=80=AFAM Jesper D. Brouer <net=
dev@brouer.com> wrote:
>> >> > > >>>>
>> >> > > >>>>
>> >> > > >>>> This needs to be reviewed by AF_XDP maintainers Magnus and B=
j=C3=B8rn (Cc)
>> >> > > >>>>
>> >> > > >>>> On 21/06/2023 19.02, Stanislav Fomichev wrote:
>> >> > > >>>>> For zerocopy mode, tx_desc->addr can point to the arbitrary=
 offset
>> >> > > >>>>> and carry some TX metadata in the headroom. For copy mode, =
there
>> >> > > >>>>> is no way currently to populate skb metadata.
>> >> > > >>>>>
>> >> > > >>>>> Introduce new XDP_TX_METADATA_LEN that indicates how many b=
ytes
>> >> > > >>>>> to treat as metadata. Metadata bytes come prior to tx_desc =
address
>> >> > > >>>>> (same as in RX case).
>> >> > > >>>>
>> >> > > >>>>    From looking at the code, this introduces a socket option=
 for this TX
>> >> > > >>>> metadata length (tx_metadata_len).
>> >> > > >>>> This implies the same fixed TX metadata size is used for all=
 packets.
>> >> > > >>>> Maybe describe this in patch desc.
>> >> > > >>>
>> >> > > >>> I was planning to do a proper documentation page once we sett=
le on all
>> >> > > >>> the details (similar to the one we have for rx).
>> >> > > >>>
>> >> > > >>>> What is the plan for dealing with cases that doesn't populat=
e same/full
>> >> > > >>>> TX metadata size ?
>> >> > > >>>
>> >> > > >>> Do we need to support that? I was assuming that the TX layout=
 would be
>> >> > > >>> fixed between the userspace and BPF.
>> >> > > >>
>> >> > > >> I hope you don't mean fixed layout, as the whole point is addi=
ng
>> >> > > >> flexibility and extensibility.
>> >> > > >
>> >> > > > I do mean a fixed layout between the userspace (af_xdp) and dev=
tx program.
>> >> > > > At least fixed max size of the metadata. The userspace and the =
bpf
>> >> > > > prog can then use this fixed space to implement some flexibility
>> >> > > > (btf_ids, versioned structs, bitmasks, tlv, etc).
>> >> > > > If we were to make the metalen vary per packet, we'd have to si=
gnal
>> >> > > > its size per packet. Probably not worth it?
>> >> > >
>> >> > > Existing XDP metadata implementation also expand in a fixed/limit=
ed
>> >> > > sized memory area, but communicate size per packet in this area (=
also
>> >> > > for validation purposes).  BUT for AF_XDP we don't have room for =
another
>> >> > > pointer or size in the AF_XDP descriptor (see struct xdp_desc).
>> >> > >
>> >> > >
>> >> > > >
>> >> > > >>> If every packet would have a different metadata length, it se=
ems like
>> >> > > >>> a nightmare to parse?
>> >> > > >>>
>> >> > > >>
>> >> > > >> No parsing is really needed.  We can simply use BTF IDs and ty=
pe cast in
>> >> > > >> BPF-prog. Both BPF-prog and userspace have access to the local=
 BTF ids,
>> >> > > >> see [1] and [2].
>> >> > > >>
>> >> > > >> It seems we are talking slightly past each-other(?).  Let me r=
ephrase
>> >> > > >> and reframe the question, what is your *plan* for dealing with=
 different
>> >> > > >> *types* of TX metadata.  The different struct *types* will of-=
cause have
>> >> > > >> different sizes, but that is okay as long as they fit into the=
 maximum
>> >> > > >> size set by this new socket option XDP_TX_METADATA_LEN.
>> >> > > >> Thus, in principle I'm fine with XSK having configured a fixed=
 headroom
>> >> > > >> for metadata, but we need a plan for handling more than one ty=
pe and
>> >> > > >> perhaps a xsk desc indicator/flag for knowing TX metadata isn'=
t random
>> >> > > >> data ("leftover" since last time this mem was used).
>> >> > > >
>> >> > > > Yeah, I think the above correctly catches my expectation here. =
Some
>> >> > > > headroom is reserved via XDP_TX_METADATA_LEN and the flexibilit=
y is
>> >> > > > offloaded to the bpf program via btf_id/tlv/etc.
>> >> > > >
>> >> > > > Regarding leftover metadata: can we assume the userspace will t=
ake
>> >> > > > care of setting it up?
>> >> > > >
>> >> > > >> With this kfunc approach, then things in-principle, becomes a =
contract
>> >> > > >> between the "local" TX-hook BPF-prog and AF_XDP userspace.   T=
hese two
>> >> > > >> components can as illustrated here [1]+[2] can coordinate base=
d on local
>> >> > > >> BPF-prog BTF IDs.  This approach works as-is today, but patchs=
et
>> >> > > >> selftests examples don't use this and instead have a very stat=
ic
>> >> > > >> approach (that people will copy-paste).
>> >> > > >>
>> >> > > >> An unsolved problem with TX-hook is that it can also get packe=
ts from
>> >> > > >> XDP_REDIRECT and even normal SKBs gets processed (right?).  Ho=
w does the
>> >> > > >> BPF-prog know if metadata is valid and intended to be used for=
 e.g.
>> >> > > >> requesting the timestamp? (imagine metadata size happen to mat=
ch)
>> >> > > >
>> >> > > > My assumption was the bpf program can do ifindex/netns filterin=
g. Plus
>> >> > > > maybe check that the meta_len is the one that's expected.
>> >> > > > Will that be enough to handle XDP_REDIRECT?
>> >> > >
>> >> > > I don't think so, using the meta_len (+ ifindex/netns) to communi=
cate
>> >> > > activation of TX hardware hints is too weak and not enough.  This=
 is an
>> >> > > implicit API for BPF-programmers to understand and can lead to im=
plicit
>> >> > > activation.
>> >> > >
>> >> > > Think about what will happen for your AF_XDP send use-case.  For
>> >> > > performance reasons AF_XDP don't zero out frame memory.  Thus, me=
ta_len
>> >> > > is fixed even if not used (and can contain garbage), it can by ac=
cident
>> >> > > create hard-to-debug situations.  As discussed with Magnus+Maryam
>> >> > > before, we found it was practical (and faster than mem zero) to e=
xtend
>> >> > > AF_XDP descriptor (see struct xdp_desc) with some flags to
>> >> > > indicate/communicate this frame comes with TX metadata hints.
>> >> >
>> >> > What is that "if not used" situation? Can the metadata itself have
>> >> > is_used bit? The userspace has to initialize at least that bit.
>> >> > We can definitely add that extra "has_metadata" bit to the descript=
or,
>> >> > but I'm trying to understand whether we can do without it.
>> >>
>> >> To me, this "has_metadata" bit in the descriptor is just an
>> >> optimization. If it is 0, then there is no need to go and check the
>> >> metadata field and you save some performance. Regardless of this bit,
>> >> you need some way to say "is_used" for each metadata entry (at least
>> >> when the number of metadata entries is >1). Three options come to mind
>> >> each with their pros and cons.
>> >>
>> >> #1: Let each metadata entry have an invalid state. Not possible for
>> >> every metadata and requires the user/kernel to go scan through every
>> >> entry for every packet.
>> >>
>> >> #2: Have a field of bits at the start of the metadata section (closest
>> >> to packet data) that signifies if a metadata entry is valid or not. If
>> >> there are N metadata entries in the metadata area, then N bits in this
>> >> field would be used to signify if the corresponding metadata is used
>> >> or not. Only requires the user/kernel to scan the valid entries plus
>> >> one access for the "is_used" bits.
>> >>
>> >> #3: Have N bits in the AF_XDP descriptor options field instead of the
>> >> N bits in the metadata area of #2. Faster but would consume many
>> >> precious bits in the fixed descriptor and cap the number of metadata
>> >> entries possible at around 8. E.g., 8 for Rx, 8 for Tx, 1 for the
>> >> multi-buffer work, and 15 for some future use. Depends on how daring
>> >> we are.
>> >>
>> >> The "has_metadata" bit suggestion can be combined with 1 or 2.
>> >> Approach 3 is just a fine grained extension of the idea itself.
>> >>
>> >> IMO, the best approach unfortunately depends on the metadata itself.
>> >> If it is rarely valid, you want something like the "has_metadata" bit.
>> >> If it is nearly always valid and used, approach #1 (if possible for
>> >> the metadata) should be the fastest. The decision also depends on the
>> >> number of metadata entries you have per packet. Sorry that I do not
>> >> have a good answer. My feeling is that we need something like #1 or
>> >> #2, or maybe both, then if needed we can add the "has_metadata" bit or
>> >> bits (#3) optimization. Can we do this encoding and choice (#1, #2, or
>> >> a combo) in the eBPF program itself? Would provide us with the
>> >> flexibility, if possible.
>> >
>> > Here is my take on it, lmk if I'm missing something:
>> >
>> > af_xdp users call this new setsockopt(XDP_TX_METADATA_LEN) when they
>> > plan to use metadata on tx.
>> > This essentially requires allocating a fixed headroom to carry the met=
adata.
>> > af_xdp machinery exports this fixed len into the bpf programs somehow
>> > (devtx_frame.meta_len in this series).
>> > Then it's up to the userspace and bpf program to agree on the layout.
>> > If not every packet is expected to carry the metadata, there might be
>> > some bitmask in the metadata area to indicate that.
>> >
>> > Iow, the metadata isn't interpreted by the kernel. It's up to the prog
>> > to interpret it and call appropriate kfunc to enable some offload.
>>
>> The reason for the flag on RX is mostly performance: there's a
>> substantial performance hit from reading the metadata area because it's
>> not cache-hot; we want to avoid that when no metadata is in use. Putting
>> the flag inside the metadata area itself doesn't work for this, because
>> then you incur the cache miss just to read the flag.
>
> Not necessarily. Let us say that the flag is 4 bytes. Increase the
> start address of the packet buffer with 4 and the flags field will be
> on the same cache line as the first 60 bytes of the packet data
> (assuming a 64 byte cache line size and the flags field is closest to
> the start of the packet data). As long as you write something in those
> first 60 bytes of packet data that cache line will be brought in and
> will likely be in the cache when you access the bits in the metadata
> field. The trick works similarly for Rx by setting the umem headroom
> accordingly.

Yeah, a trick like that was what I was alluding to with the "could" in
this bit:

>> but I see no reason it could not also occur on TX (it'll mostly
>> depend on data alignment I guess?).

right below the text you quoted ;)

> But you are correct in that dedicating a bit in the descriptor will
> make sure it is always hot, while the trick above is dependent on the
> app wanting to read or write the first cache line worth of packet
> data.

Exactly; which is why I think it's worth the flag bit :)

-Toke


