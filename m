Return-Path: <bpf+bounces-3707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4247174203D
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 08:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF271C20980
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 06:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BA1538B;
	Thu, 29 Jun 2023 06:15:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC8524E
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 06:15:43 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077CD268F
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:15:40 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f828ee8ecdso341261cf.0
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688019339; x=1690611339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF98RmATkSybp+WDzMMU1/AAusfOsvG9bzZS0NEBRtU=;
        b=YmgWzR6bUWdzrL635E4wV4KePgjoHLPcJUHyR6a8GdPT+EMYyh++UxWuRbXc/fJODW
         tQBlVkK8800ghP6oCT2ZptI7vbDdRQs89ACbj5hylK3FXD6xlospEJI++jxSmbFaJvd8
         qJGzsvtaMHc49ylr588WFn78Lli3Vtc1Dbu1W9Wybe8PdgFHgRUiFtpVzazAE0jNaTYT
         Zioxodf+NDFI3hyekTEetAy4f+ws5PCHvfiojSFyxVZZ1vYJep5OMIkLPFQLjfJLanki
         /0BVZ3CbGIwaoNtM3Je9VO2ibn41GPaEnpwXbFXv2KTLEDSP0fCf7KGxXtEExd3L8Sz3
         F0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688019339; x=1690611339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cF98RmATkSybp+WDzMMU1/AAusfOsvG9bzZS0NEBRtU=;
        b=Ed/MrxzhvmDvI/WTLfDPKVe3gnvqtur6bcFtH92QX0DFOF6eyUjCS1+x7FOol5imOb
         DELkFL+b3af6b0rsfKyEsVNdLEP81QqVBtugBJzQYkVpZnY9UGjIkPSlpcaqwwweqsm7
         q5kyl2dmfQdPeEDGtXKRNSepcUU/HIaBTYNBxi8zPsK/Vu0CwkLIBXGClZhSdc3u5ihF
         yAuiy4xsd6QU6kKa3QPk78/pCMRu/kvayNhj6Z5KNcaxaSv5AL7nxD0Bo79ZfhIyTo1s
         Gp4wny4I0Vq1DHIl46vb5Nq5S8g2YLZioB6VlmCsu3jaMWPib5JZI0fBvqft+YkQOLaZ
         V/MQ==
X-Gm-Message-State: ABy/qLanYwFLSva9YGfbd+lsYRQ85f4FlNXv4p1HdUh8ldg3PT6QR1Ph
	5fcGlNFP89bQ0p81ESvKXYTPQ7oXmugfgj3H1zQ1bYO81WeotQ==
X-Google-Smtp-Source: APBJJlG+RQqfWuFIW4KV8j4hHU5aWiLF7Aua9Ms8mHhQYtgLIXRKgupsNfIameHi31zN/QwKe0pb99ana98WQyCKacI=
X-Received: by 2002:a05:6214:3b89:b0:635:fa38:5216 with SMTP id
 nf9-20020a0562143b8900b00635fa385216mr2054040qvb.0.1688019338846; Wed, 28 Jun
 2023 23:15:38 -0700 (PDT)
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
 <CAJ8uoz0MuXYJE_a58PCtCypscZfevE2tgheC32e=zqEdNPgbnw@mail.gmail.com> <CAKH8qBui6gieETYzDugG0=nmBR-QnhhhyqaF3px0sjG7-BKLhQ@mail.gmail.com>
In-Reply-To: <CAKH8qBui6gieETYzDugG0=nmBR-QnhhhyqaF3px0sjG7-BKLhQ@mail.gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 29 Jun 2023 08:15:28 +0200
Message-ID: <CAJ8uoz0nT1D5mELoeB7Ty7ToRHT8siO0J1G083oMK4KnmpajgA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 03/11] xsk: Support XDP_TX_METADATA_LEN
To: Stanislav Fomichev <sdf@google.com>
Cc: Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
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

On Wed, 28 Jun 2023 at 20:49, Stanislav Fomichev <sdf@google.com> wrote:
>
> On Wed, Jun 28, 2023 at 1:09=E2=80=AFAM Magnus Karlsson
> <magnus.karlsson@gmail.com> wrote:
> >
> > On Mon, 26 Jun 2023 at 19:06, Stanislav Fomichev <sdf@google.com> wrote=
:
> > >
> > > On Sat, Jun 24, 2023 at 2:02=E2=80=AFAM Jesper Dangaard Brouer
> > > <jbrouer@redhat.com> wrote:
> > > >
> > > >
> > > >
> > > > On 23/06/2023 19.41, Stanislav Fomichev wrote:
> > > > > On Fri, Jun 23, 2023 at 3:24=E2=80=AFAM Jesper Dangaard Brouer
> > > > > <jbrouer@redhat.com> wrote:
> > > > >>
> > > > >>
> > > > >>
> > > > >> On 22/06/2023 19.55, Stanislav Fomichev wrote:
> > > > >>> On Thu, Jun 22, 2023 at 2:11=E2=80=AFAM Jesper D. Brouer <netde=
v@brouer.com> wrote:
> > > > >>>>
> > > > >>>>
> > > > >>>> This needs to be reviewed by AF_XDP maintainers Magnus and Bj=
=C3=B8rn (Cc)
> > > > >>>>
> > > > >>>> On 21/06/2023 19.02, Stanislav Fomichev wrote:
> > > > >>>>> For zerocopy mode, tx_desc->addr can point to the arbitrary o=
ffset
> > > > >>>>> and carry some TX metadata in the headroom. For copy mode, th=
ere
> > > > >>>>> is no way currently to populate skb metadata.
> > > > >>>>>
> > > > >>>>> Introduce new XDP_TX_METADATA_LEN that indicates how many byt=
es
> > > > >>>>> to treat as metadata. Metadata bytes come prior to tx_desc ad=
dress
> > > > >>>>> (same as in RX case).
> > > > >>>>
> > > > >>>>    From looking at the code, this introduces a socket option f=
or this TX
> > > > >>>> metadata length (tx_metadata_len).
> > > > >>>> This implies the same fixed TX metadata size is used for all p=
ackets.
> > > > >>>> Maybe describe this in patch desc.
> > > > >>>
> > > > >>> I was planning to do a proper documentation page once we settle=
 on all
> > > > >>> the details (similar to the one we have for rx).
> > > > >>>
> > > > >>>> What is the plan for dealing with cases that doesn't populate =
same/full
> > > > >>>> TX metadata size ?
> > > > >>>
> > > > >>> Do we need to support that? I was assuming that the TX layout w=
ould be
> > > > >>> fixed between the userspace and BPF.
> > > > >>
> > > > >> I hope you don't mean fixed layout, as the whole point is adding
> > > > >> flexibility and extensibility.
> > > > >
> > > > > I do mean a fixed layout between the userspace (af_xdp) and devtx=
 program.
> > > > > At least fixed max size of the metadata. The userspace and the bp=
f
> > > > > prog can then use this fixed space to implement some flexibility
> > > > > (btf_ids, versioned structs, bitmasks, tlv, etc).
> > > > > If we were to make the metalen vary per packet, we'd have to sign=
al
> > > > > its size per packet. Probably not worth it?
> > > >
> > > > Existing XDP metadata implementation also expand in a fixed/limited
> > > > sized memory area, but communicate size per packet in this area (al=
so
> > > > for validation purposes).  BUT for AF_XDP we don't have room for an=
other
> > > > pointer or size in the AF_XDP descriptor (see struct xdp_desc).
> > > >
> > > >
> > > > >
> > > > >>> If every packet would have a different metadata length, it seem=
s like
> > > > >>> a nightmare to parse?
> > > > >>>
> > > > >>
> > > > >> No parsing is really needed.  We can simply use BTF IDs and type=
 cast in
> > > > >> BPF-prog. Both BPF-prog and userspace have access to the local B=
TF ids,
> > > > >> see [1] and [2].
> > > > >>
> > > > >> It seems we are talking slightly past each-other(?).  Let me rep=
hrase
> > > > >> and reframe the question, what is your *plan* for dealing with d=
ifferent
> > > > >> *types* of TX metadata.  The different struct *types* will of-ca=
use have
> > > > >> different sizes, but that is okay as long as they fit into the m=
aximum
> > > > >> size set by this new socket option XDP_TX_METADATA_LEN.
> > > > >> Thus, in principle I'm fine with XSK having configured a fixed h=
eadroom
> > > > >> for metadata, but we need a plan for handling more than one type=
 and
> > > > >> perhaps a xsk desc indicator/flag for knowing TX metadata isn't =
random
> > > > >> data ("leftover" since last time this mem was used).
> > > > >
> > > > > Yeah, I think the above correctly catches my expectation here. So=
me
> > > > > headroom is reserved via XDP_TX_METADATA_LEN and the flexibility =
is
> > > > > offloaded to the bpf program via btf_id/tlv/etc.
> > > > >
> > > > > Regarding leftover metadata: can we assume the userspace will tak=
e
> > > > > care of setting it up?
> > > > >
> > > > >> With this kfunc approach, then things in-principle, becomes a co=
ntract
> > > > >> between the "local" TX-hook BPF-prog and AF_XDP userspace.   The=
se two
> > > > >> components can as illustrated here [1]+[2] can coordinate based =
on local
> > > > >> BPF-prog BTF IDs.  This approach works as-is today, but patchset
> > > > >> selftests examples don't use this and instead have a very static
> > > > >> approach (that people will copy-paste).
> > > > >>
> > > > >> An unsolved problem with TX-hook is that it can also get packets=
 from
> > > > >> XDP_REDIRECT and even normal SKBs gets processed (right?).  How =
does the
> > > > >> BPF-prog know if metadata is valid and intended to be used for e=
.g.
> > > > >> requesting the timestamp? (imagine metadata size happen to match=
)
> > > > >
> > > > > My assumption was the bpf program can do ifindex/netns filtering.=
 Plus
> > > > > maybe check that the meta_len is the one that's expected.
> > > > > Will that be enough to handle XDP_REDIRECT?
> > > >
> > > > I don't think so, using the meta_len (+ ifindex/netns) to communica=
te
> > > > activation of TX hardware hints is too weak and not enough.  This i=
s an
> > > > implicit API for BPF-programmers to understand and can lead to impl=
icit
> > > > activation.
> > > >
> > > > Think about what will happen for your AF_XDP send use-case.  For
> > > > performance reasons AF_XDP don't zero out frame memory.  Thus, meta=
_len
> > > > is fixed even if not used (and can contain garbage), it can by acci=
dent
> > > > create hard-to-debug situations.  As discussed with Magnus+Maryam
> > > > before, we found it was practical (and faster than mem zero) to ext=
end
> > > > AF_XDP descriptor (see struct xdp_desc) with some flags to
> > > > indicate/communicate this frame comes with TX metadata hints.
> > >
> > > What is that "if not used" situation? Can the metadata itself have
> > > is_used bit? The userspace has to initialize at least that bit.
> > > We can definitely add that extra "has_metadata" bit to the descriptor=
,
> > > but I'm trying to understand whether we can do without it.
> >
> > To me, this "has_metadata" bit in the descriptor is just an
> > optimization. If it is 0, then there is no need to go and check the
> > metadata field and you save some performance. Regardless of this bit,
> > you need some way to say "is_used" for each metadata entry (at least
> > when the number of metadata entries is >1). Three options come to mind
> > each with their pros and cons.
> >
> > #1: Let each metadata entry have an invalid state. Not possible for
> > every metadata and requires the user/kernel to go scan through every
> > entry for every packet.
> >
> > #2: Have a field of bits at the start of the metadata section (closest
> > to packet data) that signifies if a metadata entry is valid or not. If
> > there are N metadata entries in the metadata area, then N bits in this
> > field would be used to signify if the corresponding metadata is used
> > or not. Only requires the user/kernel to scan the valid entries plus
> > one access for the "is_used" bits.
> >
> > #3: Have N bits in the AF_XDP descriptor options field instead of the
> > N bits in the metadata area of #2. Faster but would consume many
> > precious bits in the fixed descriptor and cap the number of metadata
> > entries possible at around 8. E.g., 8 for Rx, 8 for Tx, 1 for the
> > multi-buffer work, and 15 for some future use. Depends on how daring
> > we are.
> >
> > The "has_metadata" bit suggestion can be combined with 1 or 2.
> > Approach 3 is just a fine grained extension of the idea itself.
> >
> > IMO, the best approach unfortunately depends on the metadata itself.
> > If it is rarely valid, you want something like the "has_metadata" bit.
> > If it is nearly always valid and used, approach #1 (if possible for
> > the metadata) should be the fastest. The decision also depends on the
> > number of metadata entries you have per packet. Sorry that I do not
> > have a good answer. My feeling is that we need something like #1 or
> > #2, or maybe both, then if needed we can add the "has_metadata" bit or
> > bits (#3) optimization. Can we do this encoding and choice (#1, #2, or
> > a combo) in the eBPF program itself? Would provide us with the
> > flexibility, if possible.
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

Sounds good. This flexibility is needed.

> Jesper raises a valid point with "what about redirected packets?". But
> I'm not sure we need to care? Presumably the programs that do
> xdp_redirect will have to conform to the same metadata layout?

