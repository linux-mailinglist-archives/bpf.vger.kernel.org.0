Return-Path: <bpf+bounces-3748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C027742A88
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 18:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2D51C203B8
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 16:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A46A134C2;
	Thu, 29 Jun 2023 16:22:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229513AC2
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 16:22:09 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BDA10CE
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 09:22:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2632336f75fso610863a91.3
        for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688055727; x=1690647727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03uxCySpR/Y5cMXSXa2E3uCJTSAEXiETQJnc0cLq3no=;
        b=NJV+PSwFjypbisgBSbyw8WUsd8DpDa4X/f58U2O2lsVAClGGg4h3ojYnPwEepSSqbf
         Zs0AhKmhsaFyWZLNulD6JFRgNuGTIVpmj5WnE9jD4dLKV0sIS/o5glU1Tdv3yMvnc5vu
         UF0kZJnOeIcRHhcAXDBKHTlKKHbkn4GYMErEFbgMx2kUsXSbJfJBL39taWDSlJLBgkIx
         jz6saISPgt3Av3vQooTTJb5/YYZd2ItaLGi7N/2McVbQQoKNQOhxYr9Yt10aehmnc4Mk
         KV56OymYuLXy4JG+YRtF3XHk5iInm+nTbDGCYmynXqfOVy5hmQ5nZf2QIQwRqJFZPScz
         RL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688055727; x=1690647727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03uxCySpR/Y5cMXSXa2E3uCJTSAEXiETQJnc0cLq3no=;
        b=GG/LpjkFiscLH/5fasnIIEU/2LxUnj8UEyMXaxj/kDzUDzSwkFEyncrrmPAulvSkWM
         1jrqVLBN8laG3THCm5rsDDmvkgzPqBe1WzkjTCK1PJPYLX/EJ1zZCgrx7NDW9t18mxOE
         sPfV32CD6QKO0dLf+GEJ+BhaiG7X+U3JZGzRpqoSFdHwW5oxzKdBZqawKvKDH/DSpC6N
         NBLVBCSWO3Nhv0iEX8jUniV3GwoPEeX861qay1zU+xMhPAxi1bD23SRNPqfEpGpQPCbL
         b6nViOB5ZmDUYUP5cPl2a+q6WXLIH/AWH2b8R3/zwdnyzqow5ZxhimMrFE+1AQKLOYbb
         Sw+w==
X-Gm-Message-State: ABy/qLbFCPAEdFgB7N6Mombonrq/q30BE4x/h7Y4wPtUAovqmk5iccTr
	fKn6RNWYZoROuiYcdVRJ1bSEMskyJfyi3erId8e2AA==
X-Google-Smtp-Source: APBJJlEUXzaXYyBmrX01Fr01uEoqqlY/DLM0ntlKUzG5XyneOXELJjIj2gc10qc7pZr2lwbiZKGlDDz83phz2TInqlQ=
X-Received: by 2002:a17:90a:341:b0:263:4308:b4eb with SMTP id
 1-20020a17090a034100b002634308b4ebmr7892pjf.1.1688055726844; Thu, 29 Jun 2023
 09:22:06 -0700 (PDT)
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
 <CAKH8qBui6gieETYzDugG0=nmBR-QnhhhyqaF3px0sjG7-BKLhQ@mail.gmail.com>
 <871qhuh5ec.fsf@toke.dk> <CAJ8uoz2Km078-K9e+8KtpiUJwTRN2p6yZrYbMD7bYaEKAfGf4w@mail.gmail.com>
 <87r0pufpf2.fsf@toke.dk>
In-Reply-To: <87r0pufpf2.fsf@toke.dk>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 29 Jun 2023 09:21:55 -0700
Message-ID: <CAKH8qBv01fTSR1nVAr69ERG75D6RMcYF-mnern64Xj+GWTiJVw@mail.gmail.com>
Subject: Re: [xdp-hints] Re: [RFC bpf-next v2 03/11] xsk: Support XDP_TX_METADATA_LEN
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 29, 2023 at 5:01=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Magnus Karlsson <magnus.karlsson@gmail.com> writes:
>
> > On Thu, 29 Jun 2023 at 13:30, Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
> >>
> >> Stanislav Fomichev <sdf@google.com> writes:
> >>
> >> > On Wed, Jun 28, 2023 at 1:09=E2=80=AFAM Magnus Karlsson
> >> > <magnus.karlsson@gmail.com> wrote:
> >> >>
> >> >> On Mon, 26 Jun 2023 at 19:06, Stanislav Fomichev <sdf@google.com> w=
rote:
> >> >> >
> >> >> > On Sat, Jun 24, 2023 at 2:02=E2=80=AFAM Jesper Dangaard Brouer
> >> >> > <jbrouer@redhat.com> wrote:
> >> >> > >
> >> >> > >
> >> >> > >
> >> >> > > On 23/06/2023 19.41, Stanislav Fomichev wrote:
> >> >> > > > On Fri, Jun 23, 2023 at 3:24=E2=80=AFAM Jesper Dangaard Broue=
r
> >> >> > > > <jbrouer@redhat.com> wrote:
> >> >> > > >>
> >> >> > > >>
> >> >> > > >>
> >> >> > > >> On 22/06/2023 19.55, Stanislav Fomichev wrote:
> >> >> > > >>> On Thu, Jun 22, 2023 at 2:11=E2=80=AFAM Jesper D. Brouer <n=
etdev@brouer.com> wrote:
> >> >> > > >>>>
> >> >> > > >>>>
> >> >> > > >>>> This needs to be reviewed by AF_XDP maintainers Magnus and=
 Bj=C3=B8rn (Cc)
> >> >> > > >>>>
> >> >> > > >>>> On 21/06/2023 19.02, Stanislav Fomichev wrote:
> >> >> > > >>>>> For zerocopy mode, tx_desc->addr can point to the arbitra=
ry offset
> >> >> > > >>>>> and carry some TX metadata in the headroom. For copy mode=
, there
> >> >> > > >>>>> is no way currently to populate skb metadata.
> >> >> > > >>>>>
> >> >> > > >>>>> Introduce new XDP_TX_METADATA_LEN that indicates how many=
 bytes
> >> >> > > >>>>> to treat as metadata. Metadata bytes come prior to tx_des=
c address
> >> >> > > >>>>> (same as in RX case).
> >> >> > > >>>>
> >> >> > > >>>>    From looking at the code, this introduces a socket opti=
on for this TX
> >> >> > > >>>> metadata length (tx_metadata_len).
> >> >> > > >>>> This implies the same fixed TX metadata size is used for a=
ll packets.
> >> >> > > >>>> Maybe describe this in patch desc.
> >> >> > > >>>
> >> >> > > >>> I was planning to do a proper documentation page once we se=
ttle on all
> >> >> > > >>> the details (similar to the one we have for rx).
> >> >> > > >>>
> >> >> > > >>>> What is the plan for dealing with cases that doesn't popul=
ate same/full
> >> >> > > >>>> TX metadata size ?
> >> >> > > >>>
> >> >> > > >>> Do we need to support that? I was assuming that the TX layo=
ut would be
> >> >> > > >>> fixed between the userspace and BPF.
> >> >> > > >>
> >> >> > > >> I hope you don't mean fixed layout, as the whole point is ad=
ding
> >> >> > > >> flexibility and extensibility.
> >> >> > > >
> >> >> > > > I do mean a fixed layout between the userspace (af_xdp) and d=
evtx program.
> >> >> > > > At least fixed max size of the metadata. The userspace and th=
e bpf
> >> >> > > > prog can then use this fixed space to implement some flexibil=
ity
> >> >> > > > (btf_ids, versioned structs, bitmasks, tlv, etc).
> >> >> > > > If we were to make the metalen vary per packet, we'd have to =
signal
> >> >> > > > its size per packet. Probably not worth it?
> >> >> > >
> >> >> > > Existing XDP metadata implementation also expand in a fixed/lim=
ited
> >> >> > > sized memory area, but communicate size per packet in this area=
 (also
> >> >> > > for validation purposes).  BUT for AF_XDP we don't have room fo=
r another
> >> >> > > pointer or size in the AF_XDP descriptor (see struct xdp_desc).
> >> >> > >
> >> >> > >
> >> >> > > >
> >> >> > > >>> If every packet would have a different metadata length, it =
seems like
> >> >> > > >>> a nightmare to parse?
> >> >> > > >>>
> >> >> > > >>
> >> >> > > >> No parsing is really needed.  We can simply use BTF IDs and =
type cast in
> >> >> > > >> BPF-prog. Both BPF-prog and userspace have access to the loc=
al BTF ids,
> >> >> > > >> see [1] and [2].
> >> >> > > >>
> >> >> > > >> It seems we are talking slightly past each-other(?).  Let me=
 rephrase
> >> >> > > >> and reframe the question, what is your *plan* for dealing wi=
th different
> >> >> > > >> *types* of TX metadata.  The different struct *types* will o=
f-cause have
> >> >> > > >> different sizes, but that is okay as long as they fit into t=
he maximum
> >> >> > > >> size set by this new socket option XDP_TX_METADATA_LEN.
> >> >> > > >> Thus, in principle I'm fine with XSK having configured a fix=
ed headroom
> >> >> > > >> for metadata, but we need a plan for handling more than one =
type and
> >> >> > > >> perhaps a xsk desc indicator/flag for knowing TX metadata is=
n't random
> >> >> > > >> data ("leftover" since last time this mem was used).
> >> >> > > >
> >> >> > > > Yeah, I think the above correctly catches my expectation here=
. Some
> >> >> > > > headroom is reserved via XDP_TX_METADATA_LEN and the flexibil=
ity is
> >> >> > > > offloaded to the bpf program via btf_id/tlv/etc.
> >> >> > > >
> >> >> > > > Regarding leftover metadata: can we assume the userspace will=
 take
> >> >> > > > care of setting it up?
> >> >> > > >
> >> >> > > >> With this kfunc approach, then things in-principle, becomes =
a contract
> >> >> > > >> between the "local" TX-hook BPF-prog and AF_XDP userspace.  =
 These two
> >> >> > > >> components can as illustrated here [1]+[2] can coordinate ba=
sed on local
> >> >> > > >> BPF-prog BTF IDs.  This approach works as-is today, but patc=
hset
> >> >> > > >> selftests examples don't use this and instead have a very st=
atic
> >> >> > > >> approach (that people will copy-paste).
> >> >> > > >>
> >> >> > > >> An unsolved problem with TX-hook is that it can also get pac=
kets from
> >> >> > > >> XDP_REDIRECT and even normal SKBs gets processed (right?).  =
How does the
> >> >> > > >> BPF-prog know if metadata is valid and intended to be used f=
or e.g.
> >> >> > > >> requesting the timestamp? (imagine metadata size happen to m=
atch)
> >> >> > > >
> >> >> > > > My assumption was the bpf program can do ifindex/netns filter=
ing. Plus
> >> >> > > > maybe check that the meta_len is the one that's expected.
> >> >> > > > Will that be enough to handle XDP_REDIRECT?
> >> >> > >
> >> >> > > I don't think so, using the meta_len (+ ifindex/netns) to commu=
nicate
> >> >> > > activation of TX hardware hints is too weak and not enough.  Th=
is is an
> >> >> > > implicit API for BPF-programmers to understand and can lead to =
implicit
> >> >> > > activation.
> >> >> > >
> >> >> > > Think about what will happen for your AF_XDP send use-case.  Fo=
r
> >> >> > > performance reasons AF_XDP don't zero out frame memory.  Thus, =
meta_len
> >> >> > > is fixed even if not used (and can contain garbage), it can by =
accident
> >> >> > > create hard-to-debug situations.  As discussed with Magnus+Mary=
am
> >> >> > > before, we found it was practical (and faster than mem zero) to=
 extend
> >> >> > > AF_XDP descriptor (see struct xdp_desc) with some flags to
> >> >> > > indicate/communicate this frame comes with TX metadata hints.
> >> >> >
> >> >> > What is that "if not used" situation? Can the metadata itself hav=
e
> >> >> > is_used bit? The userspace has to initialize at least that bit.
> >> >> > We can definitely add that extra "has_metadata" bit to the descri=
ptor,
> >> >> > but I'm trying to understand whether we can do without it.
> >> >>
> >> >> To me, this "has_metadata" bit in the descriptor is just an
> >> >> optimization. If it is 0, then there is no need to go and check the
> >> >> metadata field and you save some performance. Regardless of this bi=
t,
> >> >> you need some way to say "is_used" for each metadata entry (at leas=
t
> >> >> when the number of metadata entries is >1). Three options come to m=
ind
> >> >> each with their pros and cons.
> >> >>
> >> >> #1: Let each metadata entry have an invalid state. Not possible for
> >> >> every metadata and requires the user/kernel to go scan through ever=
y
> >> >> entry for every packet.
> >> >>
> >> >> #2: Have a field of bits at the start of the metadata section (clos=
est
> >> >> to packet data) that signifies if a metadata entry is valid or not.=
 If
> >> >> there are N metadata entries in the metadata area, then N bits in t=
his
> >> >> field would be used to signify if the corresponding metadata is use=
d
> >> >> or not. Only requires the user/kernel to scan the valid entries plu=
s
> >> >> one access for the "is_used" bits.
> >> >>
> >> >> #3: Have N bits in the AF_XDP descriptor options field instead of t=
he
> >> >> N bits in the metadata area of #2. Faster but would consume many
> >> >> precious bits in the fixed descriptor and cap the number of metadat=
a
> >> >> entries possible at around 8. E.g., 8 for Rx, 8 for Tx, 1 for the
> >> >> multi-buffer work, and 15 for some future use. Depends on how darin=
g
> >> >> we are.
> >> >>
> >> >> The "has_metadata" bit suggestion can be combined with 1 or 2.
> >> >> Approach 3 is just a fine grained extension of the idea itself.
> >> >>
> >> >> IMO, the best approach unfortunately depends on the metadata itself=
.
> >> >> If it is rarely valid, you want something like the "has_metadata" b=
it.
> >> >> If it is nearly always valid and used, approach #1 (if possible for
> >> >> the metadata) should be the fastest. The decision also depends on t=
he
> >> >> number of metadata entries you have per packet. Sorry that I do not
> >> >> have a good answer. My feeling is that we need something like #1 or
> >> >> #2, or maybe both, then if needed we can add the "has_metadata" bit=
 or
> >> >> bits (#3) optimization. Can we do this encoding and choice (#1, #2,=
 or
> >> >> a combo) in the eBPF program itself? Would provide us with the
> >> >> flexibility, if possible.
> >> >
> >> > Here is my take on it, lmk if I'm missing something:
> >> >
> >> > af_xdp users call this new setsockopt(XDP_TX_METADATA_LEN) when they
> >> > plan to use metadata on tx.
> >> > This essentially requires allocating a fixed headroom to carry the m=
etadata.
> >> > af_xdp machinery exports this fixed len into the bpf programs someho=
w
> >> > (devtx_frame.meta_len in this series).
> >> > Then it's up to the userspace and bpf program to agree on the layout=
.
> >> > If not every packet is expected to carry the metadata, there might b=
e
> >> > some bitmask in the metadata area to indicate that.
> >> >
> >> > Iow, the metadata isn't interpreted by the kernel. It's up to the pr=
og
> >> > to interpret it and call appropriate kfunc to enable some offload.
> >>
> >> The reason for the flag on RX is mostly performance: there's a
> >> substantial performance hit from reading the metadata area because it'=
s
> >> not cache-hot; we want to avoid that when no metadata is in use. Putti=
ng
> >> the flag inside the metadata area itself doesn't work for this, becaus=
e
> >> then you incur the cache miss just to read the flag.
> >
> > Not necessarily. Let us say that the flag is 4 bytes. Increase the
> > start address of the packet buffer with 4 and the flags field will be
> > on the same cache line as the first 60 bytes of the packet data
> > (assuming a 64 byte cache line size and the flags field is closest to
> > the start of the packet data). As long as you write something in those
> > first 60 bytes of packet data that cache line will be brought in and
> > will likely be in the cache when you access the bits in the metadata
> > field. The trick works similarly for Rx by setting the umem headroom
> > accordingly.
>
> Yeah, a trick like that was what I was alluding to with the "could" in
> this bit:
>
> >> but I see no reason it could not also occur on TX (it'll mostly
> >> depend on data alignment I guess?).
>
> right below the text you quoted ;)
>
> > But you are correct in that dedicating a bit in the descriptor will
> > make sure it is always hot, while the trick above is dependent on the
> > app wanting to read or write the first cache line worth of packet
> > data.
>
> Exactly; which is why I think it's worth the flag bit :)

Ack. Let me add this to the list of things to follow up on. I'm
assuming it's fair to start without the flag and add it later as a
performance optimization?
We have a fair bit of core things we need to agree on first :-D

> -Toke
>

