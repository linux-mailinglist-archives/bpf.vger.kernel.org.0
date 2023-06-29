Return-Path: <bpf+bounces-3725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07361742528
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 13:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0840280CB1
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D2F11182;
	Thu, 29 Jun 2023 11:48:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644528479
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 11:48:52 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D5CE4B
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 04:48:50 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-400a897f184so699911cf.1
        for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 04:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688039329; x=1690631329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or4N5DHjkudIPdJTEf2BwIZ/Ns5A6xZnLPeBG37an3s=;
        b=NNH4jipW8Z43J1j/MHixgbDkCT57jHbu3QiHX9z1Xe5l8EE0DBrYx7B4gd73PHvFDM
         7JXO3Zyms0m7zSNjSP9cd8okc8exnKoI9ZcwMSH4/lij1wktW5x0sf61YRltfTxHjTn0
         41PA7xUBdxeVScGKGHKQODB9NjmdNGS7NA/4XQawI7/haf+tK6sKT31NeCm+IPmKMM/K
         SzfFaY5oEtKKegrRn7YIRzQhBeceyVrTSYHNY6AWXknBMfBrDIemmZTsLL265dDAIJq0
         giJQJjg8PqJuHWKeIr7rdxA5zlF0MeJmJwcLiN/IfywqiqsPfFjKY+4H5FB7p4m580Rs
         kmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688039329; x=1690631329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Or4N5DHjkudIPdJTEf2BwIZ/Ns5A6xZnLPeBG37an3s=;
        b=jM+3iWj+aM4T0QlbwEzzMicHFwJYLeKM8Ju02HIOrFwhbZj+vrimrt3KWlzt6+CnIK
         DWAZqBkaeM0MxSiiXZ8MVPfP1vGvYYiwRNg2Qs5A0z9kLom+Mqr1slM1t9OszKkEDfGs
         d69BXXcOT6g9Og7BnOOdJ3QpyEtoja7agjYk5kraF4ZiBjR/8zwewrTQ/TfW7Qgm4grA
         9UybyWIG/3ksHzeo5byKJ9buUiYbaxQiyZTgJs8e4M51qFzPX8eYdpwNIgdA8A2vmVV1
         Ypicwz/E6jyQrVosaikWiSUq2qJ1RSpHw7LHl53VWwSb9iTZYM/uUO0DOg0XWnY4BiXR
         WIiA==
X-Gm-Message-State: ABy/qLY1Jg1RE//C/oBnMa7pFw7T8NzaXBvx0JYXu2qdRzS6bP4aQjVJ
	+ryHCBxqtSBTKBqH8ayVvEWHxJex6ltJQ3RJhx4=
X-Google-Smtp-Source: APBJJlHFVgakzOJ5lgLEMdVDBd0GMdC0/qNBNvggDgCu6B9MhIPBNs2smdBhRgQj0ppkZthpTeQvQXr5YJqCxcmQDi0=
X-Received: by 2002:a05:6214:519d:b0:5ed:c96e:ca4a with SMTP id
 kl29-20020a056214519d00b005edc96eca4amr2654995qvb.1.1688039328949; Thu, 29
 Jun 2023 04:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-4-sdf@google.com>
 <57b9fc14-c02e-f0e5-148d-a549ebab6cf6@brouer.com> <CAKH8qBsk3MDbx2PyU-_+tDV4C0R6J_wzxi9Co6ekHv_tWzp7Tw@mail.gmail.com>
 <c936bd6c-7060-47da-d522-747b49bee8a0@redhat.com> <CAKH8qBsqdE7=4JC8LfkL4gV9eQHEZjMpBSen2a+4q2Y7DpiOow@mail.gmail.com>
 <435d1630-c3f4-97fb-b6fe-9795d1f0bf33@redhat.com> <CAKH8qBtdKHCnFWUiz8H_5miPF82nqKhG4Dfx9GbQYgWbYfERjg@mail.gmail.com>
 <CAJ8uoz0MuXYJE_a58PCtCypscZfevE2tgheC32e=zqEdNPgbnw@mail.gmail.com>
 <CAKH8qBui6gieETYzDugG0=nmBR-QnhhhyqaF3px0sjG7-BKLhQ@mail.gmail.com> <871qhuh5ec.fsf@toke.dk>
In-Reply-To: <871qhuh5ec.fsf@toke.dk>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 29 Jun 2023 13:48:37 +0200
Message-ID: <CAJ8uoz2Km078-K9e+8KtpiUJwTRN2p6yZrYbMD7bYaEKAfGf4w@mail.gmail.com>
Subject: Re: [xdp-hints] Re: [RFC bpf-next v2 03/11] xsk: Support XDP_TX_METADATA_LEN
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Stanislav Fomichev <sdf@google.com>, Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 29 Jun 2023 at 13:30, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat=
.com> wrote:
>
> Stanislav Fomichev <sdf@google.com> writes:
>
> > On Wed, Jun 28, 2023 at 1:09=E2=80=AFAM Magnus Karlsson
> > <magnus.karlsson@gmail.com> wrote:
> >>
> >> On Mon, 26 Jun 2023 at 19:06, Stanislav Fomichev <sdf@google.com> wrot=
e:
> >> >
> >> > On Sat, Jun 24, 2023 at 2:02=E2=80=AFAM Jesper Dangaard Brouer
> >> > <jbrouer@redhat.com> wrote:
> >> > >
> >> > >
> >> > >
> >> > > On 23/06/2023 19.41, Stanislav Fomichev wrote:
> >> > > > On Fri, Jun 23, 2023 at 3:24=E2=80=AFAM Jesper Dangaard Brouer
> >> > > > <jbrouer@redhat.com> wrote:
> >> > > >>
> >> > > >>
> >> > > >>
> >> > > >> On 22/06/2023 19.55, Stanislav Fomichev wrote:
> >> > > >>> On Thu, Jun 22, 2023 at 2:11=E2=80=AFAM Jesper D. Brouer <netd=
ev@brouer.com> wrote:
> >> > > >>>>
> >> > > >>>>
> >> > > >>>> This needs to be reviewed by AF_XDP maintainers Magnus and Bj=
=C3=B8rn (Cc)
> >> > > >>>>
> >> > > >>>> On 21/06/2023 19.02, Stanislav Fomichev wrote:
> >> > > >>>>> For zerocopy mode, tx_desc->addr can point to the arbitrary =
offset
> >> > > >>>>> and carry some TX metadata in the headroom. For copy mode, t=
here
> >> > > >>>>> is no way currently to populate skb metadata.
> >> > > >>>>>
> >> > > >>>>> Introduce new XDP_TX_METADATA_LEN that indicates how many by=
tes
> >> > > >>>>> to treat as metadata. Metadata bytes come prior to tx_desc a=
ddress
> >> > > >>>>> (same as in RX case).
> >> > > >>>>
> >> > > >>>>    From looking at the code, this introduces a socket option =
for this TX
> >> > > >>>> metadata length (tx_metadata_len).
> >> > > >>>> This implies the same fixed TX metadata size is used for all =
packets.
> >> > > >>>> Maybe describe this in patch desc.
> >> > > >>>
> >> > > >>> I was planning to do a proper documentation page once we settl=
e on all
> >> > > >>> the details (similar to the one we have for rx).
> >> > > >>>
> >> > > >>>> What is the plan for dealing with cases that doesn't populate=
 same/full
> >> > > >>>> TX metadata size ?
> >> > > >>>
> >> > > >>> Do we need to support that? I was assuming that the TX layout =
would be
> >> > > >>> fixed between the userspace and BPF.
> >> > > >>
> >> > > >> I hope you don't mean fixed layout, as the whole point is addin=
g
> >> > > >> flexibility and extensibility.
> >> > > >
> >> > > > I do mean a fixed layout between the userspace (af_xdp) and devt=
x program.
> >> > > > At least fixed max size of the metadata. The userspace and the b=
pf
> >> > > > prog can then use this fixed space to implement some flexibility
> >> > > > (btf_ids, versioned structs, bitmasks, tlv, etc).
> >> > > > If we were to make the metalen vary per packet, we'd have to sig=
nal
> >> > > > its size per packet. Probably not worth it?
> >> > >
> >> > > Existing XDP metadata implementation also expand in a fixed/limite=
d
> >> > > sized memory area, but communicate size per packet in this area (a=
lso
> >> > > for validation purposes).  BUT for AF_XDP we don't have room for a=
nother
> >> > > pointer or size in the AF_XDP descriptor (see struct xdp_desc).
> >> > >
> >> > >
> >> > > >
> >> > > >>> If every packet would have a different metadata length, it see=
ms like
> >> > > >>> a nightmare to parse?
> >> > > >>>
> >> > > >>
> >> > > >> No parsing is really needed.  We can simply use BTF IDs and typ=
e cast in
> >> > > >> BPF-prog. Both BPF-prog and userspace have access to the local =
BTF ids,
> >> > > >> see [1] and [2].
> >> > > >>
> >> > > >> It seems we are talking slightly past each-other(?).  Let me re=
phrase
> >> > > >> and reframe the question, what is your *plan* for dealing with =
different
> >> > > >> *types* of TX metadata.  The different struct *types* will of-c=
ause have
> >> > > >> different sizes, but that is okay as long as they fit into the =
maximum
> >> > > >> size set by this new socket option XDP_TX_METADATA_LEN.
> >> > > >> Thus, in principle I'm fine with XSK having configured a fixed =
headroom
> >> > > >> for metadata, but we need a plan for handling more than one typ=
e and
> >> > > >> perhaps a xsk desc indicator/flag for knowing TX metadata isn't=
 random
> >> > > >> data ("leftover" since last time this mem was used).
> >> > > >
> >> > > > Yeah, I think the above correctly catches my expectation here. S=
ome
> >> > > > headroom is reserved via XDP_TX_METADATA_LEN and the flexibility=
 is
> >> > > > offloaded to the bpf program via btf_id/tlv/etc.
> >> > > >
> >> > > > Regarding leftover metadata: can we assume the userspace will ta=
ke
> >> > > > care of setting it up?
> >> > > >
> >> > > >> With this kfunc approach, then things in-principle, becomes a c=
ontract
> >> > > >> between the "local" TX-hook BPF-prog and AF_XDP userspace.   Th=
ese two
> >> > > >> components can as illustrated here [1]+[2] can coordinate based=
 on local
> >> > > >> BPF-prog BTF IDs.  This approach works as-is today, but patchse=
t
> >> > > >> selftests examples don't use this and instead have a very stati=
c
> >> > > >> approach (that people will copy-paste).
> >> > > >>
> >> > > >> An unsolved problem with TX-hook is that it can also get packet=
s from
> >> > > >> XDP_REDIRECT and even normal SKBs gets processed (right?).  How=
 does the
> >> > > >> BPF-prog know if metadata is valid and intended to be used for =
e.g.
> >> > > >> requesting the timestamp? (imagine metadata size happen to matc=
h)
> >> > > >
> >> > > > My assumption was the bpf program can do ifindex/netns filtering=
. Plus
> >> > > > maybe check that the meta_len is the one that's expected.
> >> > > > Will that be enough to handle XDP_REDIRECT?
> >> > >
> >> > > I don't think so, using the meta_len (+ ifindex/netns) to communic=
ate
> >> > > activation of TX hardware hints is too weak and not enough.  This =
is an
> >> > > implicit API for BPF-programmers to understand and can lead to imp=
licit
> >> > > activation.
> >> > >
> >> > > Think about what will happen for your AF_XDP send use-case.  For
> >> > > performance reasons AF_XDP don't zero out frame memory.  Thus, met=
a_len
> >> > > is fixed even if not used (and can contain garbage), it can by acc=
ident
> >> > > create hard-to-debug situations.  As discussed with Magnus+Maryam
> >> > > before, we found it was practical (and faster than mem zero) to ex=
tend
> >> > > AF_XDP descriptor (see struct xdp_desc) with some flags to
> >> > > indicate/communicate this frame comes with TX metadata hints.
> >> >
> >> > What is that "if not used" situation? Can the metadata itself have
> >> > is_used bit? The userspace has to initialize at least that bit.
> >> > We can definitely add that extra "has_metadata" bit to the descripto=
r,
> >> > but I'm trying to understand whether we can do without it.
> >>
> >> To me, this "has_metadata" bit in the descriptor is just an
> >> optimization. If it is 0, then there is no need to go and check the
> >> metadata field and you save some performance. Regardless of this bit,
> >> you need some way to say "is_used" for each metadata entry (at least
> >> when the number of metadata entries is >1). Three options come to mind
> >> each with their pros and cons.
> >>
> >> #1: Let each metadata entry have an invalid state. Not possible for
> >> every metadata and requires the user/kernel to go scan through every
> >> entry for every packet.
> >>
> >> #2: Have a field of bits at the start of the metadata section (closest
> >> to packet data) that signifies if a metadata entry is valid or not. If
> >> there are N metadata entries in the metadata area, then N bits in this
> >> field would be used to signify if the corresponding metadata is used
> >> or not. Only requires the user/kernel to scan the valid entries plus
> >> one access for the "is_used" bits.
> >>
> >> #3: Have N bits in the AF_XDP descriptor options field instead of the
> >> N bits in the metadata area of #2. Faster but would consume many
> >> precious bits in the fixed descriptor and cap the number of metadata
> >> entries possible at around 8. E.g., 8 for Rx, 8 for Tx, 1 for the
> >> multi-buffer work, and 15 for some future use. Depends on how daring
> >> we are.
> >>
> >> The "has_metadata" bit suggestion can be combined with 1 or 2.
> >> Approach 3 is just a fine grained extension of the idea itself.
> >>
> >> IMO, the best approach unfortunately depends on the metadata itself.
> >> If it is rarely valid, you want something like the "has_metadata" bit.
> >> If it is nearly always valid and used, approach #1 (if possible for
> >> the metadata) should be the fastest. The decision also depends on the
> >> number of metadata entries you have per packet. Sorry that I do not
> >> have a good answer. My feeling is that we need something like #1 or
> >> #2, or maybe both, then if needed we can add the "has_metadata" bit or
> >> bits (#3) optimization. Can we do this encoding and choice (#1, #2, or
> >> a combo) in the eBPF program itself? Would provide us with the
> >> flexibility, if possible.
> >
> > Here is my take on it, lmk if I'm missing something:
> >
> > af_xdp users call this new setsockopt(XDP_TX_METADATA_LEN) when they
> > plan to use metadata on tx.
> > This essentially requires allocating a fixed headroom to carry the meta=
data.
> > af_xdp machinery exports this fixed len into the bpf programs somehow
> > (devtx_frame.meta_len in this series).
> > Then it's up to the userspace and bpf program to agree on the layout.
> > If not every packet is expected to carry the metadata, there might be
> > some bitmask in the metadata area to indicate that.
> >
> > Iow, the metadata isn't interpreted by the kernel. It's up to the prog
> > to interpret it and call appropriate kfunc to enable some offload.
>
> The reason for the flag on RX is mostly performance: there's a
> substantial performance hit from reading the metadata area because it's
> not cache-hot; we want to avoid that when no metadata is in use. Putting
> the flag inside the metadata area itself doesn't work for this, because
> then you incur the cache miss just to read the flag.

Not necessarily. Let us say that the flag is 4 bytes. Increase the
start address of the packet buffer with 4 and the flags field will be
on the same cache line as the first 60 bytes of the packet data
(assuming a 64 byte cache line size and the flags field is closest to
the start of the packet data). As long as you write something in those
first 60 bytes of packet data that cache line will be brought in and
will likely be in the cache when you access the bits in the metadata
field. The trick works similarly for Rx by setting the umem headroom
accordingly. But you are correct in that dedicating a bit in the
descriptor will make sure it is always hot, while the trick above is
dependent on the app wanting to read or write the first cache line
worth of packet data.

> This effect is probably most pronounced on RX (because the packet is
> coming in off the NIC, so very unlikely that the memory has been touched
> before), but I see no reason it could not also occur on TX (it'll mostly
> depend on data alignment I guess?). So I think having a separate "TX
> metadata" flag in the descriptor is probably worth it for the
> performance gains?
>
> > Jesper raises a valid point with "what about redirected packets?". But
> > I'm not sure we need to care? Presumably the programs that do
> > xdp_redirect will have to conform to the same metadata layout?
>
> I don't think they have to do anything different semantically (agreeing
> on the data format in the metadata area will have to be by some out of
> band mechanism); but the performance angle is definitely valid here as
> well...
>
> -Toke
>

