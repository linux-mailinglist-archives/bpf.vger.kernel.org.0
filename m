Return-Path: <bpf+bounces-3754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2714E742F2A
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 22:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444B61C20B08
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 20:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D53FBF1;
	Thu, 29 Jun 2023 20:59:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E33FBE8
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 20:59:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983B630DD
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 13:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688072342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Oe1FN+eMC9FEZkZV6sA0cDgsNdwew4vWwxmYAbwAHc=;
	b=dYbOipWttResTBzMXqx9lUCBDRJjyoOiqri/S4VCwDzWHdFEPwN5XCvVeJtEfU8827/w/a
	Dh7Hmn8bO+adOz5YEaFWm0h3yAUtEonc5qAgaBo8U0x8mKuDi0ezJgSmuaJ7M2k4YVvItj
	hQBz27Plo9XdQHzA8AX3e44ISBWo7+A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-Mn5e0Jr_N_uQLnV53jwrKA-1; Thu, 29 Jun 2023 16:59:01 -0400
X-MC-Unique: Mn5e0Jr_N_uQLnV53jwrKA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-313f0d98e3dso608403f8f.0
        for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 13:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688072340; x=1690664340;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Oe1FN+eMC9FEZkZV6sA0cDgsNdwew4vWwxmYAbwAHc=;
        b=RLPr6BiGk9B/gPTxlWDXqo7lPiEDPMVsy2DoXzHcXv4ulzj/pAZBTZk8+DX0QweKe8
         5TrAGsdeF5DdpBlIANPnEmC4+/2Az34sS/wN5nYAq4KWOfRUEzv/mMtT++8Jqs2iiqZV
         2nF9RLIIS1DrY/shDjsGd4ceP24F0t9wmvn5Wzrxs6ekQn+5XmwKBilJEUz7XGdEYNrR
         fJRZUqN1j5tz9bO57WePwZK12bm1voKC3pQSfLpBhTsvmWg0erziL0Rq5K+6KAybLHGb
         AnAzOxJ5iIkh8U2FQEr2EdrrMsf0xOh1wE81g+rk6Dyarb+PGDo/n5QL3CQfwq58H1xe
         9PZg==
X-Gm-Message-State: ABy/qLaXOyYxq/poJPngg36MYzLLQI1p0yZbdsrlDAHgknF4ceOx4I/K
	t5N0hq4YcnrwHX3EDoDKITqRxVB6paoL5jS7vxbnHjZZkFuFtE64/ryOiw1rdUz9Y2Z1MJWWkpM
	4FypjGmrYoMcT
X-Received: by 2002:a5d:6445:0:b0:30f:bb83:e6f4 with SMTP id d5-20020a5d6445000000b0030fbb83e6f4mr607308wrw.0.1688072339932;
        Thu, 29 Jun 2023 13:58:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGpVMU5gHXjhw9onEc9EpjbLE9xXI/ptfvmC0ToH/xTc745sn45a7WIjgv82J+qBIW/0jzFtw==
X-Received: by 2002:a5d:6445:0:b0:30f:bb83:e6f4 with SMTP id d5-20020a5d6445000000b0030fbb83e6f4mr607296wrw.0.1688072339317;
        Thu, 29 Jun 2023 13:58:59 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id cw13-20020a056000090d00b003112f836d4esm16608236wrb.85.2023.06.29.13.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 13:58:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 36B0DBC04ED; Thu, 29 Jun 2023 22:58:58 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, Jesper Dangaard Brouer
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
In-Reply-To: <CAKH8qBv01fTSR1nVAr69ERG75D6RMcYF-mnern64Xj+GWTiJVw@mail.gmail.com>
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
 <CAKH8qBv01fTSR1nVAr69ERG75D6RMcYF-mnern64Xj+GWTiJVw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 29 Jun 2023 22:58:58 +0200
Message-ID: <87wmzmdlyl.fsf@toke.dk>
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

Stanislav Fomichev <sdf@google.com> writes:

> On Thu, Jun 29, 2023 at 5:01=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
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
>>
>> > But you are correct in that dedicating a bit in the descriptor will
>> > make sure it is always hot, while the trick above is dependent on the
>> > app wanting to read or write the first cache line worth of packet
>> > data.
>>
>> Exactly; which is why I think it's worth the flag bit :)
>
> Ack. Let me add this to the list of things to follow up on. I'm
> assuming it's fair to start without the flag and add it later as a
> performance optimization?
> We have a fair bit of core things we need to agree on first :-D

Certainly no objection as long as we are doing RFC patches, but I think
we should probably add this before merging something; no reason to
change API more than we have to :)

-Toke


