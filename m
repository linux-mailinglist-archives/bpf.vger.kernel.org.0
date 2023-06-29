Return-Path: <bpf+bounces-3723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6CC7424FA
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 13:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51103280CBC
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 11:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3551095A;
	Thu, 29 Jun 2023 11:30:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BA3107B3
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 11:30:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F6010F0
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 04:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688038256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OrE5tHeZ/IwPEmEhShXe1stXd0nIK9ivrjyEuA87r4Y=;
	b=JmR5PmtcO4+TXQTE7wbzaqqlp5WE5+ahftWZTp2PWUAGW3IBsts7+hrn//F0kWrnzN0hQ6
	Nhh0kC86V3yAWYiQVQ1v0OlnefoRz5V+tjvMdkmDkkrxz0baCbJQnJglV3gw+pCUUq0P7h
	+QNuHQBqrZ8c7YYBugmp4kMVz6lgfIY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-_HwgaxK_OE2drBC6ft4mWQ-1; Thu, 29 Jun 2023 07:30:55 -0400
X-MC-Unique: _HwgaxK_OE2drBC6ft4mWQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-313f5021d9bso281240f8f.2
        for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 04:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688038254; x=1690630254;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrE5tHeZ/IwPEmEhShXe1stXd0nIK9ivrjyEuA87r4Y=;
        b=OblNxL5ZyraD7F513QHKDriiX4okBZ9zpi/yWqAwOm9FsFL8HOkTFWiUJKHX2TdHQh
         YN9PGwy/glVB/DqtILC0ODmHJgWrv7WEmEtv+0/zba1vqzK5Kqs9RIy2D4XS+Ud+GRZO
         7Hil55lBBxxfIL7YtC5APsBqh4z9qgwRzlRe219nkKxrbBBz7bwwB2ArNntnLXKBSric
         HnjyTdBQYeQlhWdgiidFlfJSQo9yq2ElsepFwMo6WkjXEXUS/1cZFKXetJJ6Md55LhMz
         8/71+VxAncjYw+2LqcFBjjmcaM8a4uk8C7/1kCI6MCs9utM1FkSX4Dakv6vsqW1LGwUE
         /Faw==
X-Gm-Message-State: ABy/qLbWLbCuhEL/O25AroM27pDMzZR7xN/7iS4JikquZ4YClzYkymta
	e04Pe+6hFItbFcVtWalcgvhDsGiO/D9mwD+ch8UnQ76LxWufua86vkSFhlPOTjQ3yQ0q+KSjhRN
	egshdazuUZi51
X-Received: by 2002:a5d:6446:0:b0:314:1494:fe28 with SMTP id d6-20020a5d6446000000b003141494fe28mr1623817wrw.53.1688038253850;
        Thu, 29 Jun 2023 04:30:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFSTSdadA1qRPqBePYN2tzRKCLjDLo2mbmC5ERRoo56Vwlr/UTdkcDIWM579dYLFupgrB0vHw==
X-Received: by 2002:a5d:6446:0:b0:314:1494:fe28 with SMTP id d6-20020a5d6446000000b003141494fe28mr1623772wrw.53.1688038253149;
        Thu, 29 Jun 2023 04:30:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a5d6ad2000000b00313e90d1d0dsm13783319wrw.112.2023.06.29.04.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 04:30:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CC683BC043B; Thu, 29 Jun 2023 13:30:51 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Stanislav Fomichev <sdf@google.com>, Magnus Karlsson
 <magnus.karlsson@gmail.com>
Cc: Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com,
 bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "Karlsson, Magnus"
 <magnus.karlsson@intel.com>, "xdp-hints@xdp-project.net"
 <xdp-hints@xdp-project.net>
Subject: Re: [xdp-hints] Re: [RFC bpf-next v2 03/11] xsk: Support
 XDP_TX_METADATA_LEN
In-Reply-To: <CAKH8qBui6gieETYzDugG0=nmBR-QnhhhyqaF3px0sjG7-BKLhQ@mail.gmail.com>
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
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 29 Jun 2023 13:30:51 +0200
Message-ID: <871qhuh5ec.fsf@toke.dk>
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

> On Wed, Jun 28, 2023 at 1:09=E2=80=AFAM Magnus Karlsson
> <magnus.karlsson@gmail.com> wrote:
>>
>> On Mon, 26 Jun 2023 at 19:06, Stanislav Fomichev <sdf@google.com> wrote:
>> >
>> > On Sat, Jun 24, 2023 at 2:02=E2=80=AFAM Jesper Dangaard Brouer
>> > <jbrouer@redhat.com> wrote:
>> > >
>> > >
>> > >
>> > > On 23/06/2023 19.41, Stanislav Fomichev wrote:
>> > > > On Fri, Jun 23, 2023 at 3:24=E2=80=AFAM Jesper Dangaard Brouer
>> > > > <jbrouer@redhat.com> wrote:
>> > > >>
>> > > >>
>> > > >>
>> > > >> On 22/06/2023 19.55, Stanislav Fomichev wrote:
>> > > >>> On Thu, Jun 22, 2023 at 2:11=E2=80=AFAM Jesper D. Brouer <netdev=
@brouer.com> wrote:
>> > > >>>>
>> > > >>>>
>> > > >>>> This needs to be reviewed by AF_XDP maintainers Magnus and Bj=
=C3=B8rn (Cc)
>> > > >>>>
>> > > >>>> On 21/06/2023 19.02, Stanislav Fomichev wrote:
>> > > >>>>> For zerocopy mode, tx_desc->addr can point to the arbitrary of=
fset
>> > > >>>>> and carry some TX metadata in the headroom. For copy mode, the=
re
>> > > >>>>> is no way currently to populate skb metadata.
>> > > >>>>>
>> > > >>>>> Introduce new XDP_TX_METADATA_LEN that indicates how many bytes
>> > > >>>>> to treat as metadata. Metadata bytes come prior to tx_desc add=
ress
>> > > >>>>> (same as in RX case).
>> > > >>>>
>> > > >>>>    From looking at the code, this introduces a socket option fo=
r this TX
>> > > >>>> metadata length (tx_metadata_len).
>> > > >>>> This implies the same fixed TX metadata size is used for all pa=
ckets.
>> > > >>>> Maybe describe this in patch desc.
>> > > >>>
>> > > >>> I was planning to do a proper documentation page once we settle =
on all
>> > > >>> the details (similar to the one we have for rx).
>> > > >>>
>> > > >>>> What is the plan for dealing with cases that doesn't populate s=
ame/full
>> > > >>>> TX metadata size ?
>> > > >>>
>> > > >>> Do we need to support that? I was assuming that the TX layout wo=
uld be
>> > > >>> fixed between the userspace and BPF.
>> > > >>
>> > > >> I hope you don't mean fixed layout, as the whole point is adding
>> > > >> flexibility and extensibility.
>> > > >
>> > > > I do mean a fixed layout between the userspace (af_xdp) and devtx =
program.
>> > > > At least fixed max size of the metadata. The userspace and the bpf
>> > > > prog can then use this fixed space to implement some flexibility
>> > > > (btf_ids, versioned structs, bitmasks, tlv, etc).
>> > > > If we were to make the metalen vary per packet, we'd have to signal
>> > > > its size per packet. Probably not worth it?
>> > >
>> > > Existing XDP metadata implementation also expand in a fixed/limited
>> > > sized memory area, but communicate size per packet in this area (also
>> > > for validation purposes).  BUT for AF_XDP we don't have room for ano=
ther
>> > > pointer or size in the AF_XDP descriptor (see struct xdp_desc).
>> > >
>> > >
>> > > >
>> > > >>> If every packet would have a different metadata length, it seems=
 like
>> > > >>> a nightmare to parse?
>> > > >>>
>> > > >>
>> > > >> No parsing is really needed.  We can simply use BTF IDs and type =
cast in
>> > > >> BPF-prog. Both BPF-prog and userspace have access to the local BT=
F ids,
>> > > >> see [1] and [2].
>> > > >>
>> > > >> It seems we are talking slightly past each-other(?).  Let me reph=
rase
>> > > >> and reframe the question, what is your *plan* for dealing with di=
fferent
>> > > >> *types* of TX metadata.  The different struct *types* will of-cau=
se have
>> > > >> different sizes, but that is okay as long as they fit into the ma=
ximum
>> > > >> size set by this new socket option XDP_TX_METADATA_LEN.
>> > > >> Thus, in principle I'm fine with XSK having configured a fixed he=
adroom
>> > > >> for metadata, but we need a plan for handling more than one type =
and
>> > > >> perhaps a xsk desc indicator/flag for knowing TX metadata isn't r=
andom
>> > > >> data ("leftover" since last time this mem was used).
>> > > >
>> > > > Yeah, I think the above correctly catches my expectation here. Some
>> > > > headroom is reserved via XDP_TX_METADATA_LEN and the flexibility is
>> > > > offloaded to the bpf program via btf_id/tlv/etc.
>> > > >
>> > > > Regarding leftover metadata: can we assume the userspace will take
>> > > > care of setting it up?
>> > > >
>> > > >> With this kfunc approach, then things in-principle, becomes a con=
tract
>> > > >> between the "local" TX-hook BPF-prog and AF_XDP userspace.   Thes=
e two
>> > > >> components can as illustrated here [1]+[2] can coordinate based o=
n local
>> > > >> BPF-prog BTF IDs.  This approach works as-is today, but patchset
>> > > >> selftests examples don't use this and instead have a very static
>> > > >> approach (that people will copy-paste).
>> > > >>
>> > > >> An unsolved problem with TX-hook is that it can also get packets =
from
>> > > >> XDP_REDIRECT and even normal SKBs gets processed (right?).  How d=
oes the
>> > > >> BPF-prog know if metadata is valid and intended to be used for e.=
g.
>> > > >> requesting the timestamp? (imagine metadata size happen to match)
>> > > >
>> > > > My assumption was the bpf program can do ifindex/netns filtering. =
Plus
>> > > > maybe check that the meta_len is the one that's expected.
>> > > > Will that be enough to handle XDP_REDIRECT?
>> > >
>> > > I don't think so, using the meta_len (+ ifindex/netns) to communicate
>> > > activation of TX hardware hints is too weak and not enough.  This is=
 an
>> > > implicit API for BPF-programmers to understand and can lead to impli=
cit
>> > > activation.
>> > >
>> > > Think about what will happen for your AF_XDP send use-case.  For
>> > > performance reasons AF_XDP don't zero out frame memory.  Thus, meta_=
len
>> > > is fixed even if not used (and can contain garbage), it can by accid=
ent
>> > > create hard-to-debug situations.  As discussed with Magnus+Maryam
>> > > before, we found it was practical (and faster than mem zero) to exte=
nd
>> > > AF_XDP descriptor (see struct xdp_desc) with some flags to
>> > > indicate/communicate this frame comes with TX metadata hints.
>> >
>> > What is that "if not used" situation? Can the metadata itself have
>> > is_used bit? The userspace has to initialize at least that bit.
>> > We can definitely add that extra "has_metadata" bit to the descriptor,
>> > but I'm trying to understand whether we can do without it.
>>
>> To me, this "has_metadata" bit in the descriptor is just an
>> optimization. If it is 0, then there is no need to go and check the
>> metadata field and you save some performance. Regardless of this bit,
>> you need some way to say "is_used" for each metadata entry (at least
>> when the number of metadata entries is >1). Three options come to mind
>> each with their pros and cons.
>>
>> #1: Let each metadata entry have an invalid state. Not possible for
>> every metadata and requires the user/kernel to go scan through every
>> entry for every packet.
>>
>> #2: Have a field of bits at the start of the metadata section (closest
>> to packet data) that signifies if a metadata entry is valid or not. If
>> there are N metadata entries in the metadata area, then N bits in this
>> field would be used to signify if the corresponding metadata is used
>> or not. Only requires the user/kernel to scan the valid entries plus
>> one access for the "is_used" bits.
>>
>> #3: Have N bits in the AF_XDP descriptor options field instead of the
>> N bits in the metadata area of #2. Faster but would consume many
>> precious bits in the fixed descriptor and cap the number of metadata
>> entries possible at around 8. E.g., 8 for Rx, 8 for Tx, 1 for the
>> multi-buffer work, and 15 for some future use. Depends on how daring
>> we are.
>>
>> The "has_metadata" bit suggestion can be combined with 1 or 2.
>> Approach 3 is just a fine grained extension of the idea itself.
>>
>> IMO, the best approach unfortunately depends on the metadata itself.
>> If it is rarely valid, you want something like the "has_metadata" bit.
>> If it is nearly always valid and used, approach #1 (if possible for
>> the metadata) should be the fastest. The decision also depends on the
>> number of metadata entries you have per packet. Sorry that I do not
>> have a good answer. My feeling is that we need something like #1 or
>> #2, or maybe both, then if needed we can add the "has_metadata" bit or
>> bits (#3) optimization. Can we do this encoding and choice (#1, #2, or
>> a combo) in the eBPF program itself? Would provide us with the
>> flexibility, if possible.
>
> Here is my take on it, lmk if I'm missing something:
>
> af_xdp users call this new setsockopt(XDP_TX_METADATA_LEN) when they
> plan to use metadata on tx.
> This essentially requires allocating a fixed headroom to carry the metada=
ta.
> af_xdp machinery exports this fixed len into the bpf programs somehow
> (devtx_frame.meta_len in this series).
> Then it's up to the userspace and bpf program to agree on the layout.
> If not every packet is expected to carry the metadata, there might be
> some bitmask in the metadata area to indicate that.
>
> Iow, the metadata isn't interpreted by the kernel. It's up to the prog
> to interpret it and call appropriate kfunc to enable some offload.

The reason for the flag on RX is mostly performance: there's a
substantial performance hit from reading the metadata area because it's
not cache-hot; we want to avoid that when no metadata is in use. Putting
the flag inside the metadata area itself doesn't work for this, because
then you incur the cache miss just to read the flag.

This effect is probably most pronounced on RX (because the packet is
coming in off the NIC, so very unlikely that the memory has been touched
before), but I see no reason it could not also occur on TX (it'll mostly
depend on data alignment I guess?). So I think having a separate "TX
metadata" flag in the descriptor is probably worth it for the
performance gains?

> Jesper raises a valid point with "what about redirected packets?". But
> I'm not sure we need to care? Presumably the programs that do
> xdp_redirect will have to conform to the same metadata layout?

I don't think they have to do anything different semantically (agreeing
on the data format in the metadata area will have to be by some out of
band mechanism); but the performance angle is definitely valid here as
well...

-Toke


