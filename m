Return-Path: <bpf+bounces-3638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503B3740AB3
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 10:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BAA12811F3
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 08:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7894A6FA0;
	Wed, 28 Jun 2023 08:09:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4966563DD
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 08:09:32 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE631422B
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 01:09:29 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-635d9f7f09dso8654236d6.0
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 01:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687939769; x=1690531769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4s/Xsj7FArz7SNZTsGYwefoup2dVR7fnDXCWNSZBgd0=;
        b=secXLgcCogtk2TY7Y1kNw/KVTcADVXQwbO4PsWHJRiBGI911CyoC8ouhpkM96LjJ12
         cI2kiE8ES8Mw44ilmBqVd6HvSfvp0JQkdXnHx5e10m6lASu6t+0zPpSfZWL6X1XSiVzO
         czPXBQeYRLWoIKA0WY1jQxPE7lJ1m+R4D5D0lTlHKfN2d9krnkUkdAbyxBH0rXHzMQSe
         qQ0FSnqg/UKwfpe/nTmR3MiRAvwzQvJKajwxGI/I11fJAkd5PH3IKzZ34Q0HCBZ4PZeD
         bhUltYTSK2b4HVDVuacVU/KF8dI3TmyXfoCYqN26samr+wty2cbqB1b8ZIbD8JlK+3P2
         uZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939769; x=1690531769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4s/Xsj7FArz7SNZTsGYwefoup2dVR7fnDXCWNSZBgd0=;
        b=ix5K31HYqBsv9kCrW6YhAMRWNxUZ+Rb9+YaH3+dignrjfhemZZWw8KqN8HTj1pdvon
         JOrXbpXY412GF4ryKRPtcl/As/R+XE4rPKEubwnX+8I9Dt3ptgkZu2tWQ/pgzO8m77ra
         9G31Wtu5A/LyHR0WaHUriAVPsgxmneJD6sxtjV8jQjUExpce2KpO44dyNCqTbZAuwgbe
         21eEHjjIRYXk7SvOlsHzllZKTSzinsG0UhCK61lMnqJZPnaXrMSMAz1e/vNFR5k3A2BQ
         D65Pfvj4y9Rh6oZK9r8RZhDtcOtFmZulVDPuTgvzIjOwfdauAbb73DNs8qwexpmQiRqO
         QkqA==
X-Gm-Message-State: AC+VfDySj2vEPiuNfIjqyWD3HM5/zTdNeMG000Q8df7HXYfz5cq80Uu2
	2NLsr7+GadYVhByrmzBkW1Bxo/5Kk4W/TJzXXjJrScLRHSA1nw==
X-Google-Smtp-Source: ACHHUZ6J3PyWyQe56Cc5W2UiuB2cDUw1X6uelZBAp6Pb/WKGbNFQu3lpuP94Monuk6PVbMs4pQjv20Us2ZoAUJbGiOc=
X-Received: by 2002:a05:6214:501d:b0:621:65de:f60c with SMTP id
 jo29-20020a056214501d00b0062165def60cmr4516600qvb.3.1687939768895; Wed, 28
 Jun 2023 01:09:28 -0700 (PDT)
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
In-Reply-To: <CAKH8qBtdKHCnFWUiz8H_5miPF82nqKhG4Dfx9GbQYgWbYfERjg@mail.gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 28 Jun 2023 10:09:17 +0200
Message-ID: <CAJ8uoz0MuXYJE_a58PCtCypscZfevE2tgheC32e=zqEdNPgbnw@mail.gmail.com>
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

On Mon, 26 Jun 2023 at 19:06, Stanislav Fomichev <sdf@google.com> wrote:
>
> On Sat, Jun 24, 2023 at 2:02=E2=80=AFAM Jesper Dangaard Brouer
> <jbrouer@redhat.com> wrote:
> >
> >
> >
> > On 23/06/2023 19.41, Stanislav Fomichev wrote:
> > > On Fri, Jun 23, 2023 at 3:24=E2=80=AFAM Jesper Dangaard Brouer
> > > <jbrouer@redhat.com> wrote:
> > >>
> > >>
> > >>
> > >> On 22/06/2023 19.55, Stanislav Fomichev wrote:
> > >>> On Thu, Jun 22, 2023 at 2:11=E2=80=AFAM Jesper D. Brouer <netdev@br=
ouer.com> wrote:
> > >>>>
> > >>>>
> > >>>> This needs to be reviewed by AF_XDP maintainers Magnus and Bj=C3=
=B8rn (Cc)
> > >>>>
> > >>>> On 21/06/2023 19.02, Stanislav Fomichev wrote:
> > >>>>> For zerocopy mode, tx_desc->addr can point to the arbitrary offse=
t
> > >>>>> and carry some TX metadata in the headroom. For copy mode, there
> > >>>>> is no way currently to populate skb metadata.
> > >>>>>
> > >>>>> Introduce new XDP_TX_METADATA_LEN that indicates how many bytes
> > >>>>> to treat as metadata. Metadata bytes come prior to tx_desc addres=
s
> > >>>>> (same as in RX case).
> > >>>>
> > >>>>    From looking at the code, this introduces a socket option for t=
his TX
> > >>>> metadata length (tx_metadata_len).
> > >>>> This implies the same fixed TX metadata size is used for all packe=
ts.
> > >>>> Maybe describe this in patch desc.
> > >>>
> > >>> I was planning to do a proper documentation page once we settle on =
all
> > >>> the details (similar to the one we have for rx).
> > >>>
> > >>>> What is the plan for dealing with cases that doesn't populate same=
/full
> > >>>> TX metadata size ?
> > >>>
> > >>> Do we need to support that? I was assuming that the TX layout would=
 be
> > >>> fixed between the userspace and BPF.
> > >>
> > >> I hope you don't mean fixed layout, as the whole point is adding
> > >> flexibility and extensibility.
> > >
> > > I do mean a fixed layout between the userspace (af_xdp) and devtx pro=
gram.
> > > At least fixed max size of the metadata. The userspace and the bpf
> > > prog can then use this fixed space to implement some flexibility
> > > (btf_ids, versioned structs, bitmasks, tlv, etc).
> > > If we were to make the metalen vary per packet, we'd have to signal
> > > its size per packet. Probably not worth it?
> >
> > Existing XDP metadata implementation also expand in a fixed/limited
> > sized memory area, but communicate size per packet in this area (also
> > for validation purposes).  BUT for AF_XDP we don't have room for anothe=
r
> > pointer or size in the AF_XDP descriptor (see struct xdp_desc).
> >
> >
> > >
> > >>> If every packet would have a different metadata length, it seems li=
ke
> > >>> a nightmare to parse?
> > >>>
> > >>
> > >> No parsing is really needed.  We can simply use BTF IDs and type cas=
t in
> > >> BPF-prog. Both BPF-prog and userspace have access to the local BTF i=
ds,
> > >> see [1] and [2].
> > >>
> > >> It seems we are talking slightly past each-other(?).  Let me rephras=
e
> > >> and reframe the question, what is your *plan* for dealing with diffe=
rent
> > >> *types* of TX metadata.  The different struct *types* will of-cause =
have
> > >> different sizes, but that is okay as long as they fit into the maxim=
um
> > >> size set by this new socket option XDP_TX_METADATA_LEN.
> > >> Thus, in principle I'm fine with XSK having configured a fixed headr=
oom
> > >> for metadata, but we need a plan for handling more than one type and
> > >> perhaps a xsk desc indicator/flag for knowing TX metadata isn't rand=
om
> > >> data ("leftover" since last time this mem was used).
> > >
> > > Yeah, I think the above correctly catches my expectation here. Some
> > > headroom is reserved via XDP_TX_METADATA_LEN and the flexibility is
> > > offloaded to the bpf program via btf_id/tlv/etc.
> > >
> > > Regarding leftover metadata: can we assume the userspace will take
> > > care of setting it up?
> > >
> > >> With this kfunc approach, then things in-principle, becomes a contra=
ct
> > >> between the "local" TX-hook BPF-prog and AF_XDP userspace.   These t=
wo
> > >> components can as illustrated here [1]+[2] can coordinate based on l=
ocal
> > >> BPF-prog BTF IDs.  This approach works as-is today, but patchset
> > >> selftests examples don't use this and instead have a very static
> > >> approach (that people will copy-paste).
> > >>
> > >> An unsolved problem with TX-hook is that it can also get packets fro=
m
> > >> XDP_REDIRECT and even normal SKBs gets processed (right?).  How does=
 the
> > >> BPF-prog know if metadata is valid and intended to be used for e.g.
> > >> requesting the timestamp? (imagine metadata size happen to match)
> > >
> > > My assumption was the bpf program can do ifindex/netns filtering. Plu=
s
> > > maybe check that the meta_len is the one that's expected.
> > > Will that be enough to handle XDP_REDIRECT?
> >
> > I don't think so, using the meta_len (+ ifindex/netns) to communicate
> > activation of TX hardware hints is too weak and not enough.  This is an
> > implicit API for BPF-programmers to understand and can lead to implicit
> > activation.
> >
> > Think about what will happen for your AF_XDP send use-case.  For
> > performance reasons AF_XDP don't zero out frame memory.  Thus, meta_len
> > is fixed even if not used (and can contain garbage), it can by accident
> > create hard-to-debug situations.  As discussed with Magnus+Maryam
> > before, we found it was practical (and faster than mem zero) to extend
> > AF_XDP descriptor (see struct xdp_desc) with some flags to
> > indicate/communicate this frame comes with TX metadata hints.
>
> What is that "if not used" situation? Can the metadata itself have
> is_used bit? The userspace has to initialize at least that bit.
> We can definitely add that extra "has_metadata" bit to the descriptor,
> but I'm trying to understand whether we can do without it.

To me, this "has_metadata" bit in the descriptor is just an
optimization. If it is 0, then there is no need to go and check the
metadata field and you save some performance. Regardless of this bit,
you need some way to say "is_used" for each metadata entry (at least
when the number of metadata entries is >1). Three options come to mind
each with their pros and cons.

#1: Let each metadata entry have an invalid state. Not possible for
every metadata and requires the user/kernel to go scan through every
entry for every packet.

#2: Have a field of bits at the start of the metadata section (closest
to packet data) that signifies if a metadata entry is valid or not. If
there are N metadata entries in the metadata area, then N bits in this
field would be used to signify if the corresponding metadata is used
or not. Only requires the user/kernel to scan the valid entries plus
one access for the "is_used" bits.

#3: Have N bits in the AF_XDP descriptor options field instead of the
N bits in the metadata area of #2. Faster but would consume many
precious bits in the fixed descriptor and cap the number of metadata
entries possible at around 8. E.g., 8 for Rx, 8 for Tx, 1 for the
multi-buffer work, and 15 for some future use. Depends on how daring
we are.

The "has_metadata" bit suggestion can be combined with 1 or 2.
Approach 3 is just a fine grained extension of the idea itself.

IMO, the best approach unfortunately depends on the metadata itself.
If it is rarely valid, you want something like the "has_metadata" bit.
If it is nearly always valid and used, approach #1 (if possible for
the metadata) should be the fastest. The decision also depends on the
number of metadata entries you have per packet. Sorry that I do not
have a good answer. My feeling is that we need something like #1 or
#2, or maybe both, then if needed we can add the "has_metadata" bit or
bits (#3) optimization. Can we do this encoding and choice (#1, #2, or
a combo) in the eBPF program itself? Would provide us with the
flexibility, if possible.

>
> > >>
> > >> BPF-prog API bpf_core_type_id_local:
> > >>    - [1]
> > >> https://github.com/xdp-project/bpf-examples/blob/master/AF_XDP-inter=
action/af_xdp_kern.c#L80
> > >>
> > >> Userspace API btf__find_by_name_kind:
> > >>    - [2]
> > >> https://github.com/xdp-project/bpf-examples/blob/master/AF_XDP-inter=
action/lib_xsk_extend.c#L185
> > >>
> > >
> >
>

