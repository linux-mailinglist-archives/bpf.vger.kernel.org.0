Return-Path: <bpf+bounces-3468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C476673E5EB
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 19:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1271C20980
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4051097D;
	Mon, 26 Jun 2023 17:00:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EF211CAC
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 17:00:20 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A327E6E
	for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 10:00:18 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso3013597a12.1
        for <bpf@vger.kernel.org>; Mon, 26 Jun 2023 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687798818; x=1690390818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0BTBT7E6AaVVXNbcifwyc9C7bHK5aLZp/eqXvlgyto=;
        b=y9qrdV86HObNHfc6NXeTlUXblyJwZLb5qD/T4fWIzAbWfw/98yLH2SohxhTkE6wPoG
         3t55+8zTETSL4j3ewGZTpsBI/H1r6zCeI/KWiT8c/ZJnNJHP9jTtm7Xq+PFo8ABJJ9RD
         AOgSh+RrQnjZyA6pm73gzlc8ZbryLMselpZnRTbTorBKCTt07l412CwBieQEArPROuxX
         suVzE8KMu/0ckudHQeZ7/xBdF2VrmWKzIplO/UdiljKmWVqTPTGTSb9QpdwLlm/vCDAR
         6HjC0vzI0OkxcgFzUf5l4iaSbzyOZoTXMn2xvFvmgukzr33xYlWRpmTsDYRhNHoXGoyr
         tyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687798818; x=1690390818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0BTBT7E6AaVVXNbcifwyc9C7bHK5aLZp/eqXvlgyto=;
        b=UXcHWoosbg4R1YDap5z45I0dIuwLbO1NG4xYallopOlPjlQGh6ih6BcGfTaROd8heg
         RnqX1UGtXT4TFkbDg3W/5ES3s74fc7oEfDHP/JhxzB9BpxwVags2/EEIN2FmpuMmZFhn
         FwoheBz36xwz0cbd4d04cA491UQX11x9Po3BwE3cPDPVczDRjWjZ7UtyvVBkOzg6NEYB
         MNM5OV/ZEXCPC5edaZvrChtdYuagve4mvGpzbRV7Eu2kY596D5eef4NpTQqNi1ulrwAH
         GZFD2yi2Z6k5Qc2JsajXT08I0qXIjx3ZLfpgKjNuDO2D5Zf6X3mFSiQG/syAKxf+3b6n
         En2w==
X-Gm-Message-State: AC+VfDxQQk5Y7yVNBDNK9gDtZ9uKeGKinUxZUHNnNIztYRnVcQVm9t96
	QTrqmn13JiQWh0RwaVfI2RpO5sloVFQ7prM9KhDZ2A==
X-Google-Smtp-Source: ACHHUZ753qel1EEhBEcizxknrTyReQhxpX4uUM1P1RL2JrBOQUSnKSjQ38n1ael6V26xd+7LZDsW1+3oQO5htyT0+20=
X-Received: by 2002:a17:90a:4611:b0:262:f99b:a530 with SMTP id
 w17-20020a17090a461100b00262f99ba530mr2502736pjg.34.1687798817494; Mon, 26
 Jun 2023 10:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-4-sdf@google.com>
 <57b9fc14-c02e-f0e5-148d-a549ebab6cf6@brouer.com> <CAKH8qBsk3MDbx2PyU-_+tDV4C0R6J_wzxi9Co6ekHv_tWzp7Tw@mail.gmail.com>
 <c936bd6c-7060-47da-d522-747b49bee8a0@redhat.com> <CAKH8qBsqdE7=4JC8LfkL4gV9eQHEZjMpBSen2a+4q2Y7DpiOow@mail.gmail.com>
 <435d1630-c3f4-97fb-b6fe-9795d1f0bf33@redhat.com>
In-Reply-To: <435d1630-c3f4-97fb-b6fe-9795d1f0bf33@redhat.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 26 Jun 2023 10:00:05 -0700
Message-ID: <CAKH8qBtdKHCnFWUiz8H_5miPF82nqKhG4Dfx9GbQYgWbYfERjg@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 03/11] xsk: Support XDP_TX_METADATA_LEN
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: brouer@redhat.com, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
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

On Sat, Jun 24, 2023 at 2:02=E2=80=AFAM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
>
>
> On 23/06/2023 19.41, Stanislav Fomichev wrote:
> > On Fri, Jun 23, 2023 at 3:24=E2=80=AFAM Jesper Dangaard Brouer
> > <jbrouer@redhat.com> wrote:
> >>
> >>
> >>
> >> On 22/06/2023 19.55, Stanislav Fomichev wrote:
> >>> On Thu, Jun 22, 2023 at 2:11=E2=80=AFAM Jesper D. Brouer <netdev@brou=
er.com> wrote:
> >>>>
> >>>>
> >>>> This needs to be reviewed by AF_XDP maintainers Magnus and Bj=C3=B8r=
n (Cc)
> >>>>
> >>>> On 21/06/2023 19.02, Stanislav Fomichev wrote:
> >>>>> For zerocopy mode, tx_desc->addr can point to the arbitrary offset
> >>>>> and carry some TX metadata in the headroom. For copy mode, there
> >>>>> is no way currently to populate skb metadata.
> >>>>>
> >>>>> Introduce new XDP_TX_METADATA_LEN that indicates how many bytes
> >>>>> to treat as metadata. Metadata bytes come prior to tx_desc address
> >>>>> (same as in RX case).
> >>>>
> >>>>    From looking at the code, this introduces a socket option for thi=
s TX
> >>>> metadata length (tx_metadata_len).
> >>>> This implies the same fixed TX metadata size is used for all packets=
.
> >>>> Maybe describe this in patch desc.
> >>>
> >>> I was planning to do a proper documentation page once we settle on al=
l
> >>> the details (similar to the one we have for rx).
> >>>
> >>>> What is the plan for dealing with cases that doesn't populate same/f=
ull
> >>>> TX metadata size ?
> >>>
> >>> Do we need to support that? I was assuming that the TX layout would b=
e
> >>> fixed between the userspace and BPF.
> >>
> >> I hope you don't mean fixed layout, as the whole point is adding
> >> flexibility and extensibility.
> >
> > I do mean a fixed layout between the userspace (af_xdp) and devtx progr=
am.
> > At least fixed max size of the metadata. The userspace and the bpf
> > prog can then use this fixed space to implement some flexibility
> > (btf_ids, versioned structs, bitmasks, tlv, etc).
> > If we were to make the metalen vary per packet, we'd have to signal
> > its size per packet. Probably not worth it?
>
> Existing XDP metadata implementation also expand in a fixed/limited
> sized memory area, but communicate size per packet in this area (also
> for validation purposes).  BUT for AF_XDP we don't have room for another
> pointer or size in the AF_XDP descriptor (see struct xdp_desc).
>
>
> >
> >>> If every packet would have a different metadata length, it seems like
> >>> a nightmare to parse?
> >>>
> >>
> >> No parsing is really needed.  We can simply use BTF IDs and type cast =
in
> >> BPF-prog. Both BPF-prog and userspace have access to the local BTF ids=
,
> >> see [1] and [2].
> >>
> >> It seems we are talking slightly past each-other(?).  Let me rephrase
> >> and reframe the question, what is your *plan* for dealing with differe=
nt
> >> *types* of TX metadata.  The different struct *types* will of-cause ha=
ve
> >> different sizes, but that is okay as long as they fit into the maximum
> >> size set by this new socket option XDP_TX_METADATA_LEN.
> >> Thus, in principle I'm fine with XSK having configured a fixed headroo=
m
> >> for metadata, but we need a plan for handling more than one type and
> >> perhaps a xsk desc indicator/flag for knowing TX metadata isn't random
> >> data ("leftover" since last time this mem was used).
> >
> > Yeah, I think the above correctly catches my expectation here. Some
> > headroom is reserved via XDP_TX_METADATA_LEN and the flexibility is
> > offloaded to the bpf program via btf_id/tlv/etc.
> >
> > Regarding leftover metadata: can we assume the userspace will take
> > care of setting it up?
> >
> >> With this kfunc approach, then things in-principle, becomes a contract
> >> between the "local" TX-hook BPF-prog and AF_XDP userspace.   These two
> >> components can as illustrated here [1]+[2] can coordinate based on loc=
al
> >> BPF-prog BTF IDs.  This approach works as-is today, but patchset
> >> selftests examples don't use this and instead have a very static
> >> approach (that people will copy-paste).
> >>
> >> An unsolved problem with TX-hook is that it can also get packets from
> >> XDP_REDIRECT and even normal SKBs gets processed (right?).  How does t=
he
> >> BPF-prog know if metadata is valid and intended to be used for e.g.
> >> requesting the timestamp? (imagine metadata size happen to match)
> >
> > My assumption was the bpf program can do ifindex/netns filtering. Plus
> > maybe check that the meta_len is the one that's expected.
> > Will that be enough to handle XDP_REDIRECT?
>
> I don't think so, using the meta_len (+ ifindex/netns) to communicate
> activation of TX hardware hints is too weak and not enough.  This is an
> implicit API for BPF-programmers to understand and can lead to implicit
> activation.
>
> Think about what will happen for your AF_XDP send use-case.  For
> performance reasons AF_XDP don't zero out frame memory.  Thus, meta_len
> is fixed even if not used (and can contain garbage), it can by accident
> create hard-to-debug situations.  As discussed with Magnus+Maryam
> before, we found it was practical (and faster than mem zero) to extend
> AF_XDP descriptor (see struct xdp_desc) with some flags to
> indicate/communicate this frame comes with TX metadata hints.

What is that "if not used" situation? Can the metadata itself have
is_used bit? The userspace has to initialize at least that bit.
We can definitely add that extra "has_metadata" bit to the descriptor,
but I'm trying to understand whether we can do without it.


> >>
> >> BPF-prog API bpf_core_type_id_local:
> >>    - [1]
> >> https://github.com/xdp-project/bpf-examples/blob/master/AF_XDP-interac=
tion/af_xdp_kern.c#L80
> >>
> >> Userspace API btf__find_by_name_kind:
> >>    - [2]
> >> https://github.com/xdp-project/bpf-examples/blob/master/AF_XDP-interac=
tion/lib_xsk_extend.c#L185
> >>
> >
>

