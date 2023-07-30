Return-Path: <bpf+bounces-6348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7815A768569
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 15:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389A82817E8
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DB020F2;
	Sun, 30 Jul 2023 13:13:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0A0363;
	Sun, 30 Jul 2023 13:13:07 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA70CF;
	Sun, 30 Jul 2023 06:13:04 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76758b855edso207225585a.0;
        Sun, 30 Jul 2023 06:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690722783; x=1691327583;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Xl0Xk/CWkHizqwFzytJhxVEJgtFNDj54nvTxyZ+ajg=;
        b=JtYe5dOmpe4WUrEJ5tTvGAsPY0wjHs4R7IUwRAy/WZ4j5EwEpmd1VW3oUj/QJ3dfZ2
         35KHVcwTEuKeqLiDFWsgN/dKYzjWWLbDYJqO2txtN8SFfZXcliZ9BCPYibY3ZkjX0F95
         qzTA+9/Vmxq5uxLZBhOu0vU1Qg9+pacBNebD3lsSeR/eGRBWK/ca0s8+FgM4CvuTBf81
         AVtD2rYkqx3iovWVFaG7pzhI42HtgU6UDUELM8T5cVLAMVjYcshsONOSGSttCXE96ZoX
         o2xGt/BA+NExR99khfKXfUUeGBEtZBymIBickYGn4MsKDqdQ+4ZjDTkUfre3FsMyNuDA
         TjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690722783; x=1691327583;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Xl0Xk/CWkHizqwFzytJhxVEJgtFNDj54nvTxyZ+ajg=;
        b=S7igjuwAO2SeU7aVlBS+38kTkAZyU1v0VuVixK6qWtKZAh7oYJow01ReZTJZH01ZUw
         iJrMwc9fx345zd+cmVAj2DppagrbGzey0QJgX6bnMgsmK7Cxuda7QujSVxK6LBwnbntv
         DaDcLjHnKR5gUT9ogrMbVJbAdIuC7i8OUF0h/t3pV3zw9z5yI8+XAKASZXArErT4Y3Ca
         Z3Tv8ZaUNM8zSk2SU5l2aH630zOzkJpmbN+BYg8WH1tJijfOByO9BnYc83vJ1pHS0d6B
         qVXHTvjSJ8IoUi03u2YYg8qamUcilL0dwDcoNcklS7m45MUgCiBGrf5Kzd0pSAFf6OSW
         romA==
X-Gm-Message-State: ABy/qLaQs8io1+dwGg2TlUKayxWzT09qCeD4LEsKu0j/Qt7kFht0/l4W
	pVe8UN0tSy8icR4uvkeptRQ=
X-Google-Smtp-Source: APBJJlH6yFKR+iF//Db+L1j+YN21fGPfsHxHmAng3xAT+4+htwFCe0fASXzXHDmHRH9EWcPt0QPBFg==
X-Received: by 2002:a05:620a:46a0:b0:765:734b:1792 with SMTP id bq32-20020a05620a46a000b00765734b1792mr10500470qkb.23.1690722783042;
        Sun, 30 Jul 2023 06:13:03 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id 19-20020a05620a071300b007655a4c5423sm855023qkc.130.2023.07.30.06.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 06:13:02 -0700 (PDT)
Date: Sun, 30 Jul 2023 09:13:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, 
 bpf <bpf@vger.kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yhs@fb.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@google.com>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 David Ahern <dsahern@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Jesper Dangaard Brouer <brouer@redhat.com>, 
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Alexander Lobakin <alexandr.lobakin@intel.com>, 
 Magnus Karlsson <magnus.karlsson@gmail.com>, 
 Maryam Tahhan <mtahhan@redhat.com>, 
 xdp-hints@xdp-project.net, 
 Network Development <netdev@vger.kernel.org>, 
 Simon Horman <simon.horman@corigine.com>
Message-ID: <64c661de227c2_11bfb629493@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAADnVQ+vn0=1UT5_c628ovq+LzfrNFf0MxmZn++NqeUFJ-ykQw@mail.gmail.com>
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
 <20230728173923.1318596-13-larysa.zaremba@intel.com>
 <20230728215340.pf3qcfxh7g4x7s6a@MacBook-Pro-8.local>
 <64c53b1b29a66_e235c2942d@willemb.c.googlers.com.notmuch>
 <CAADnVQ+vn0=1UT5_c628ovq+LzfrNFf0MxmZn++NqeUFJ-ykQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 12/21] xdp: Add checksum hint
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Alexei Starovoitov wrote:
> On Sat, Jul 29, 2023 at 9:15=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Alexei Starovoitov wrote:
> > > On Fri, Jul 28, 2023 at 07:39:14PM +0200, Larysa Zaremba wrote:
> > > >
> > > > +union xdp_csum_info {
> > > > +   /* Checksum referred to by ``csum_start + csum_offset`` is co=
nsidered
> > > > +    * valid, but was never calculated, TX device has to do this,=

> > > > +    * starting from csum_start packet byte.
> > > > +    * Any preceding checksums are also considered valid.
> > > > +    * Available, if ``status =3D=3D XDP_CHECKSUM_PARTIAL``.
> > > > +    */
> > > > +   struct {
> > > > +           u16 csum_start;
> > > > +           u16 csum_offset;
> > > > +   };
> > > > +
> > >
> > > CHECKSUM_PARTIAL makes sense on TX, but this RX. I don't see in the=
 above.
> >
> > It can be observed on RX when packets are looped.
> >
> > This may be observed even in XDP on veth.
> =

> veth and XDP is a broken combination. GSO packets coming out of contain=
ers
> cannot be parsed properly by XDP.
> It was added mainly for testing. Just like "generic XDP".
> bpf progs at skb layer is much better fit for veth.

Ok. Still, seems forward looking and little cost to define the
constant?
 =

> > > > +   /* Checksum, calculated over the whole packet.
> > > > +    * Available, if ``status & XDP_CHECKSUM_COMPLETE``.
> > > > +    */
> > > > +   u32 checksum;
> > >
> > > imo XDP RX should only support XDP_CHECKSUM_COMPLETE with u32 check=
sum
> > > or XDP_CHECKSUM_UNNECESSARY.
> > >
> > > > +};
> > > > +
> > > > +enum xdp_csum_status {
> > > > +   /* HW had parsed several transport headers and validated thei=
r
> > > > +    * checksums, same as ``CHECKSUM_UNNECESSARY`` in ``sk_buff``=
.
> > > > +    * 3 least significant bytes contain number of consecutive ch=
ecksums,
> > > > +    * starting with the outermost, reported by hardware as valid=
.
> > > > +    * ``sk_buff`` checksum level (``csum_level``) notation is pr=
ovided
> > > > +    * for driver developers.
> > > > +    */
> > > > +   XDP_CHECKSUM_VALID_LVL0         =3D 1,    /* 1 outermost chec=
ksum */
> > > > +   XDP_CHECKSUM_VALID_LVL1         =3D 2,    /* 2 outermost chec=
ksums */
> > > > +   XDP_CHECKSUM_VALID_LVL2         =3D 3,    /* 3 outermost chec=
ksums */
> > > > +   XDP_CHECKSUM_VALID_LVL3         =3D 4,    /* 4 outermost chec=
ksums */
> > > > +   XDP_CHECKSUM_VALID_NUM_MASK     =3D GENMASK(2, 0),
> > > > +   XDP_CHECKSUM_VALID              =3D XDP_CHECKSUM_VALID_NUM_MA=
SK,
> > >
> > > I don't see what bpf prog suppose to do with these levels.
> > > The driver should pick between 3:
> > > XDP_CHECKSUM_UNNECESSARY, XDP_CHECKSUM_COMPLETE, XDP_CHECKSUM_NONE.=

> > >
> > > No levels and no anything partial. please.
> >
> > This levels business is an unfortunate side effect of
> > CHECKSUM_UNNECESSARY. For a packet with multiple checksum fields, wha=
t
> > does the boolean actually mean? With these levels, at least that is
> > well defined: the first N checksum fields.
> =

> If I understand this correctly this is intel specific feature that
> other NICs don't have. skb layer also doesn't have such concept.
> The driver should say CHECKSUM_UNNECESSARY when it's sure
> or don't pretend that it checks the checksum and just say NONE.

I did not know how much this was used, but quick grep for non constant
csum_level shows devices from at least six vendors.

