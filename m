Return-Path: <bpf+bounces-3796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC15743826
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 11:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54254280F10
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 09:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E26E101D4;
	Fri, 30 Jun 2023 09:20:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9AA1FB8
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 09:20:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F7D3A87
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 02:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688116785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnJzIE1AC3q4jVq976fs1R8ctZjv8+tlcsDXW9ZbyDk=;
	b=Np+Vk/UyxU6J1u0lV5Mzxq7XGvyNbICPjgMaQ2RLXIpfSjHG9YADFU5myF10XseRn5OOHe
	0ve+vPvdyJ2m8b6rpYZfmmosB5GPCI+xuyNkCeu3AT5EzzBPjwl4JKhyPdMhm13F8dUNiB
	GHhdHAZ/Owct87/DRiDVD2GDlZIva00=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-eOyx8xBbNFGpC8HKEQJhOg-1; Fri, 30 Jun 2023 05:19:43 -0400
X-MC-Unique: eOyx8xBbNFGpC8HKEQJhOg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-98933d4d4c1so125795366b.0
        for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 02:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688116782; x=1690708782;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnJzIE1AC3q4jVq976fs1R8ctZjv8+tlcsDXW9ZbyDk=;
        b=eBqpTIk3jj6mqj54AkNdye23zj64G/matyQYDFWFTekX39AAcCq2VVgIBf8xN6fYNW
         /fwZg5KuCWNjr2VfbHEvHvvQ2wWMUKI39DAbqfYaOO2qQ67fKd8D2bobYmzRoL2elt83
         jvA2XZE3VT1MWRyhk+lGw+sVHhyQz4j1R3fYd9/zLUJhK7xqkJNX9o9Qwrqy3EGS+UgV
         rrea8EphPKZD1s2nmxNB/drNenKd3TYy+JTRQPRCQ63te4SNEmVhZvd6/vy1NoVmb/Kc
         iZj1m8vYsOmNeA3v5euQcH/E5jh1SyuM+Gt2fI6K/31F5MCy3y4WulHpDph5eJjtKwSf
         rISg==
X-Gm-Message-State: ABy/qLac18bOlB/4kPaBiNiNPFAkSNw8wS09vVoX50eEEV4/Jbdx6rd7
	eU45AYKwKn0Q7s6L4YfoSO9nc50XvzgLeDzndfWKvObklMXa3WzUoal84gsg0WFFgVFo6ct0jKB
	NNdNOAgVCMVO/
X-Received: by 2002:a17:907:2157:b0:991:c566:979 with SMTP id rk23-20020a170907215700b00991c5660979mr1388814ejb.36.1688116782382;
        Fri, 30 Jun 2023 02:19:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEiu9qdB6QGUeX35Ichhu5tRhcOShyMGUgce8+gbAXPir+BD7ANw0AC1LrPhlxF8aSbxLZKaw==
X-Received: by 2002:a17:907:2157:b0:991:c566:979 with SMTP id rk23-20020a170907215700b00991c5660979mr1388779ejb.36.1688116781769;
        Fri, 30 Jun 2023 02:19:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id lr9-20020a170906fb8900b00969f44bbef3sm7949007ejb.11.2023.06.30.02.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 02:19:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 98402BC06D5; Fri, 30 Jun 2023 11:19:40 +0200 (CEST)
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
In-Reply-To: <CAJ8uoz0a5ioP=3n+WsTORpQwqy+rTW85VUHLnswa79i7L+Aadg@mail.gmail.com>
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
 <87r0pufpf2.fsf@toke.dk>
 <CAJ8uoz0a5ioP=3n+WsTORpQwqy+rTW85VUHLnswa79i7L+Aadg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 30 Jun 2023 11:19:40 +0200
Message-ID: <87pm5de28j.fsf@toke.dk>
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

> On Thu, 29 Jun 2023 at 14:01, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>>
>> Magnus Karlsson <magnus.karlsson@gmail.com> writes:
>>
>> > On Thu, 29 Jun 2023 at 13:30, Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>> >>
>> >> Stanislav Fomichev <sdf@google.com> writes:
>> >>
>> >> > On Wed, Jun 28, 2023 at 1:09=E2=80=AFAM Magnus Karlsson
>> >> > <magnus.karlsson@gmail.com> wrote:
>> >> >>
>> >> >> On Mon, 26 Jun 2023 at 19:06, Stanislav Fomichev <sdf@google.com> =
wrote:
>> >> >> >
>> >> >> > On Sat, Jun 24, 2023 at 2:02=E2=80=AFAM Jesper Dangaard Brouer
>> >> >> > <jbrouer@redhat.com> wrote:
>> >> >> > >
>> >> >> > >
>> >> >> > >
>> >> >> > > On 23/06/2023 19.41, Stanislav Fomichev wrote:
>> >> >> > > > On Fri, Jun 23, 2023 at 3:24=E2=80=AFAM Jesper Dangaard Brou=
er
>> >> >> > > > <jbrouer@redhat.com> wrote:
>> >> >> > > >>
>> >> >> > > >>
>> >> >> > > >>
>> >> >> > > >> On 22/06/2023 19.55, Stanislav Fomichev wrote:
>> >> >> > > >>> On Thu, Jun 22, 2023 at 2:11=E2=80=AFAM Jesper D. Brouer <=
netdev@brouer.com> wrote:
>> >> >> > > >>>>
>> >> >> > > >>>>
>> >> >> > > >>>> This needs to be reviewed by AF_XDP maintainers Magnus an=
d Bj=C3=B8rn (Cc)
>> >> >> > > >>>>
>> >> >> > > >>>> On 21/06/2023 19.02, Stanislav Fomichev wrote:
>> >> >> > > >>>>> For zerocopy mode, tx_desc->addr can point to the arbitr=
ary offset
>> >> >> > > >>>>> and carry some TX metadata in the headroom. For copy mod=
e, there
>> >> >> > > >>>>> is no way currently to populate skb metadata.
>> >> >> > > >>>>>
>> >> >> > > >>>>> Introduce new XDP_TX_METADATA_LEN that indicates how man=
y bytes
>> >> >> > > >>>>> to treat as metadata. Metadata bytes come prior to tx_de=
sc address
>> >> >> > > >>>>> (same as in RX case).
>> >> >> > > >>>>
>> >> >> > > >>>>    From looking at the code, this introduces a socket opt=
ion for this TX
>> >> >> > > >>>> metadata length (tx_metadata_len).
>> >> >> > > >>>> This implies the same fixed TX metadata size is used for =
all packets.
>> >> >> > > >>>> Maybe describe this in patch desc.
>> >> >> > > >>>
>> >> >> > > >>> I was planning to do a proper documentation page once we s=
ettle on all
>> >> >> > > >>> the details (similar to the one we have for rx).
>> >> >> > > >>>
>> >> >> > > >>>> What is the plan for dealing with cases that doesn't popu=
late same/full
>> >> >> > > >>>> TX metadata size ?
>> >> >> > > >>>
>> >> >> > > >>> Do we need to support that? I was assuming that the TX lay=
out would be
>> >> >> > > >>> fixed between the userspace and BPF.
>> >> >> > > >>
>> >> >> > > >> I hope you don't mean fixed layout, as the whole point is a=
dding
>> >> >> > > >> flexibility and extensibility.
>> >> >> > > >
>> >> >> > > > I do mean a fixed layout between the userspace (af_xdp) and =
devtx program.
>> >> >> > > > At least fixed max size of the metadata. The userspace and t=
he bpf
>> >> >> > > > prog can then use this fixed space to implement some flexibi=
lity
>> >> >> > > > (btf_ids, versioned structs, bitmasks, tlv, etc).
>> >> >> > > > If we were to make the metalen vary per packet, we'd have to=
 signal
>> >> >> > > > its size per packet. Probably not worth it?
>> >> >> > >
>> >> >> > > Existing XDP metadata implementation also expand in a fixed/li=
mited
>> >> >> > > sized memory area, but communicate size per packet in this are=
a (also
>> >> >> > > for validation purposes).  BUT for AF_XDP we don't have room f=
or another
>> >> >> > > pointer or size in the AF_XDP descriptor (see struct xdp_desc).
>> >> >> > >
>> >> >> > >
>> >> >> > > >
>> >> >> > > >>> If every packet would have a different metadata length, it=
 seems like
>> >> >> > > >>> a nightmare to parse?
>> >> >> > > >>>
>> >> >> > > >>
>> >> >> > > >> No parsing is really needed.  We can simply use BTF IDs and=
 type cast in
>> >> >> > > >> BPF-prog. Both BPF-prog and userspace have access to the lo=
cal BTF ids,
>> >> >> > > >> see [1] and [2].
>> >> >> > > >>
>> >> >> > > >> It seems we are talking slightly past each-other(?).  Let m=
e rephrase
>> >> >> > > >> and reframe the question, what is your *plan* for dealing w=
ith different
>> >> >> > > >> *types* of TX metadata.  The different struct *types* will =
of-cause have
>> >> >> > > >> different sizes, but that is okay as long as they fit into =
the maximum
>> >> >> > > >> size set by this new socket option XDP_TX_METADATA_LEN.
>> >> >> > > >> Thus, in principle I'm fine with XSK having configured a fi=
xed headroom
>> >> >> > > >> for metadata, but we need a plan for handling more than one=
 type and
>> >> >> > > >> perhaps a xsk desc indicator/flag for knowing TX metadata i=
sn't random
>> >> >> > > >> data ("leftover" since last time this mem was used).
>> >> >> > > >
>> >> >> > > > Yeah, I think the above correctly catches my expectation her=
e. Some
>> >> >> > > > headroom is reserved via XDP_TX_METADATA_LEN and the flexibi=
lity is
>> >> >> > > > offloaded to the bpf program via btf_id/tlv/etc.
>> >> >> > > >
>> >> >> > > > Regarding leftover metadata: can we assume the userspace wil=
l take
>> >> >> > > > care of setting it up?
>> >> >> > > >
>> >> >> > > >> With this kfunc approach, then things in-principle, becomes=
 a contract
>> >> >> > > >> between the "local" TX-hook BPF-prog and AF_XDP userspace. =
  These two
>> >> >> > > >> components can as illustrated here [1]+[2] can coordinate b=
ased on local
>> >> >> > > >> BPF-prog BTF IDs.  This approach works as-is today, but pat=
chset
>> >> >> > > >> selftests examples don't use this and instead have a very s=
tatic
>> >> >> > > >> approach (that people will copy-paste).
>> >> >> > > >>
>> >> >> > > >> An unsolved problem with TX-hook is that it can also get pa=
ckets from
>> >> >> > > >> XDP_REDIRECT and even normal SKBs gets processed (right?). =
 How does the
>> >> >> > > >> BPF-prog know if metadata is valid and intended to be used =
for e.g.
>> >> >> > > >> requesting the timestamp? (imagine metadata size happen to =
match)
>> >> >> > > >
>> >> >> > > > My assumption was the bpf program can do ifindex/netns filte=
ring. Plus
>> >> >> > > > maybe check that the meta_len is the one that's expected.
>> >> >> > > > Will that be enough to handle XDP_REDIRECT?
>> >> >> > >
>> >> >> > > I don't think so, using the meta_len (+ ifindex/netns) to comm=
unicate
>> >> >> > > activation of TX hardware hints is too weak and not enough.  T=
his is an
>> >> >> > > implicit API for BPF-programmers to understand and can lead to=
 implicit
>> >> >> > > activation.
>> >> >> > >
>> >> >> > > Think about what will happen for your AF_XDP send use-case.  F=
or
>> >> >> > > performance reasons AF_XDP don't zero out frame memory.  Thus,=
 meta_len
>> >> >> > > is fixed even if not used (and can contain garbage), it can by=
 accident
>> >> >> > > create hard-to-debug situations.  As discussed with Magnus+Mar=
yam
>> >> >> > > before, we found it was practical (and faster than mem zero) t=
o extend
>> >> >> > > AF_XDP descriptor (see struct xdp_desc) with some flags to
>> >> >> > > indicate/communicate this frame comes with TX metadata hints.
>> >> >> >
>> >> >> > What is that "if not used" situation? Can the metadata itself ha=
ve
>> >> >> > is_used bit? The userspace has to initialize at least that bit.
>> >> >> > We can definitely add that extra "has_metadata" bit to the descr=
iptor,
>> >> >> > but I'm trying to understand whether we can do without it.
>> >> >>
>> >> >> To me, this "has_metadata" bit in the descriptor is just an
>> >> >> optimization. If it is 0, then there is no need to go and check the
>> >> >> metadata field and you save some performance. Regardless of this b=
it,
>> >> >> you need some way to say "is_used" for each metadata entry (at lea=
st
>> >> >> when the number of metadata entries is >1). Three options come to =
mind
>> >> >> each with their pros and cons.
>> >> >>
>> >> >> #1: Let each metadata entry have an invalid state. Not possible for
>> >> >> every metadata and requires the user/kernel to go scan through eve=
ry
>> >> >> entry for every packet.
>> >> >>
>> >> >> #2: Have a field of bits at the start of the metadata section (clo=
sest
>> >> >> to packet data) that signifies if a metadata entry is valid or not=
. If
>> >> >> there are N metadata entries in the metadata area, then N bits in =
this
>> >> >> field would be used to signify if the corresponding metadata is us=
ed
>> >> >> or not. Only requires the user/kernel to scan the valid entries pl=
us
>> >> >> one access for the "is_used" bits.
>> >> >>
>> >> >> #3: Have N bits in the AF_XDP descriptor options field instead of =
the
>> >> >> N bits in the metadata area of #2. Faster but would consume many
>> >> >> precious bits in the fixed descriptor and cap the number of metada=
ta
>> >> >> entries possible at around 8. E.g., 8 for Rx, 8 for Tx, 1 for the
>> >> >> multi-buffer work, and 15 for some future use. Depends on how dari=
ng
>> >> >> we are.
>> >> >>
>> >> >> The "has_metadata" bit suggestion can be combined with 1 or 2.
>> >> >> Approach 3 is just a fine grained extension of the idea itself.
>> >> >>
>> >> >> IMO, the best approach unfortunately depends on the metadata itsel=
f.
>> >> >> If it is rarely valid, you want something like the "has_metadata" =
bit.
>> >> >> If it is nearly always valid and used, approach #1 (if possible for
>> >> >> the metadata) should be the fastest. The decision also depends on =
the
>> >> >> number of metadata entries you have per packet. Sorry that I do not
>> >> >> have a good answer. My feeling is that we need something like #1 or
>> >> >> #2, or maybe both, then if needed we can add the "has_metadata" bi=
t or
>> >> >> bits (#3) optimization. Can we do this encoding and choice (#1, #2=
, or
>> >> >> a combo) in the eBPF program itself? Would provide us with the
>> >> >> flexibility, if possible.
>> >> >
>> >> > Here is my take on it, lmk if I'm missing something:
>> >> >
>> >> > af_xdp users call this new setsockopt(XDP_TX_METADATA_LEN) when they
>> >> > plan to use metadata on tx.
>> >> > This essentially requires allocating a fixed headroom to carry the =
metadata.
>> >> > af_xdp machinery exports this fixed len into the bpf programs someh=
ow
>> >> > (devtx_frame.meta_len in this series).
>> >> > Then it's up to the userspace and bpf program to agree on the layou=
t.
>> >> > If not every packet is expected to carry the metadata, there might =
be
>> >> > some bitmask in the metadata area to indicate that.
>> >> >
>> >> > Iow, the metadata isn't interpreted by the kernel. It's up to the p=
rog
>> >> > to interpret it and call appropriate kfunc to enable some offload.
>> >>
>> >> The reason for the flag on RX is mostly performance: there's a
>> >> substantial performance hit from reading the metadata area because it=
's
>> >> not cache-hot; we want to avoid that when no metadata is in use. Putt=
ing
>> >> the flag inside the metadata area itself doesn't work for this, becau=
se
>> >> then you incur the cache miss just to read the flag.
>> >
>> > Not necessarily. Let us say that the flag is 4 bytes. Increase the
>> > start address of the packet buffer with 4 and the flags field will be
>> > on the same cache line as the first 60 bytes of the packet data
>> > (assuming a 64 byte cache line size and the flags field is closest to
>> > the start of the packet data). As long as you write something in those
>> > first 60 bytes of packet data that cache line will be brought in and
>> > will likely be in the cache when you access the bits in the metadata
>> > field. The trick works similarly for Rx by setting the umem headroom
>> > accordingly.
>>
>> Yeah, a trick like that was what I was alluding to with the "could" in
>> this bit:
>>
>> >> but I see no reason it could not also occur on TX (it'll mostly
>> >> depend on data alignment I guess?).
>>
>> right below the text you quoted ;)
>
> Ouch! Sorry Toke. Was a bit too trigger-happy there.

Haha, no worries, seems like we're basically in agreement anyway :)

-Toke


