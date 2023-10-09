Return-Path: <bpf+bounces-11694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D487BD826
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 12:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6559281882
	for <lists+bpf@lfdr.de>; Mon,  9 Oct 2023 10:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29E91804E;
	Mon,  9 Oct 2023 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCBn5jir"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96105179B2;
	Mon,  9 Oct 2023 10:08:08 +0000 (UTC)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D909F;
	Mon,  9 Oct 2023 03:08:06 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7ab8696d047so1686299241.1;
        Mon, 09 Oct 2023 03:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696846085; x=1697450885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbHOermRMrKRk+X0HGNdbhFKu1xqDfORpCgcvsbzg3U=;
        b=cCBn5jiriDqSzevJshBcOQc8IDRPUcX1eQmDGtDWD6utbaNLS2p+kOUmCBfmOsda9V
         FFU7YCticytSCMEExNC3iTruqgwYbLzWa8x3PeNQAfU0bSFiVIi8OllX8uBEXvX992oB
         JnPDpf6brX95o0WJ2a7kyP9cUdqQ069JKUyROoZt6tzEco7pdexv9xtVYDShlHLplPZL
         ycPJqUG6RGq+XrLhAxy+3Ve9l0sjPeGHDYa0/jTegwMftoxMvZlUqAmQxu9Cs2CpVa0j
         45yLDr1cXlYgLeuHVL59XKfUIirCqq8k3gcQ6TRgyxc73bAVv4UegFDa8YNIeEXvY7uS
         fz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696846085; x=1697450885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbHOermRMrKRk+X0HGNdbhFKu1xqDfORpCgcvsbzg3U=;
        b=t+XF1YUcQ7iH4duBzNtXuzMCRGg9agH99CmjZDgw5G0uIYLAhAGiLmPTjzkMK2EmyM
         lCdVdlxYpSQMJ+ECOAbM54EtkSuDDaxMz9d4vgvAXSlNAEnOmd7MLo+Phzjz2UcK38g+
         twMy8Jiynxm3PjQ9WareubC9oQ6Wd/BXwppTU84a3wIJ/gOU+cmhq1E3CTdPVAmE2sDh
         s+LpMS62RJEZd6+GyXx8G19uSaOaka9uVsNOyMSyFS+Q0SrOszdaYSS788Tf+hhJ72b6
         D39TQqKNKb/H9+cwA0j0t8LeDWBtlN00Te4cRfI1aWEzUJMbwpMJDsYyNBJuiBsl2cDZ
         as0g==
X-Gm-Message-State: AOJu0Yw/grej5DmUdMAZu3J5ySG7DkQNyoje8QIq8SHtXhC7+81IIjrI
	H3evpq+qv4Z9cAOQ4Ezoq7+ooSxaQO2cdOAc7Lw=
X-Google-Smtp-Source: AGHT+IG82LZdEm7dgg1DL81gRs2joX/UTWwc13ELsnkSS/9qkVDl7Yrdteu4VB0eB/VoXi+UEInbHeRPlZZV7wmkSdg=
X-Received: by 2002:a67:f6c1:0:b0:452:635e:2710 with SMTP id
 v1-20020a67f6c1000000b00452635e2710mr13995568vso.0.1696846085188; Mon, 09 Oct
 2023 03:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com> <CAF=yD-K2MQt4nnfwJrx6h6Nii_rho7j1o6nb_jYaSwcWY45pPw@mail.gmail.com>
 <48e20be1-b658-4117-8856-89ff1df6f48f@daynix.com> <CAF=yD-K4bCBpUVtDR_cv=bagRL+vM4Rusez+uHFTb4_kR8XkpA@mail.gmail.com>
 <6a698c99-6f02-4cfb-a709-ba02296a05f7@daynix.com>
In-Reply-To: <6a698c99-6f02-4cfb-a709-ba02296a05f7@daynix.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 9 Oct 2023 03:07:27 -0700
Message-ID: <CAF=yD-+WFy8us0wUWo-0KpZUKHx2Q82cJ8teO0qRkK-_R1e0cA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, 
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	rdunlap@infradead.org, willemb@google.com, gustavoars@kernel.org, 
	herbert@gondor.apana.org.au, steffen.klassert@secunet.com, nogikh@google.com, 
	pablo@netfilter.org, decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com, 
	elver@google.com, pabeni@redhat.com, 
	Yuri Benditovich <yuri.benditovich@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 3:05=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
>
>
> On 2023/10/09 18:54, Willem de Bruijn wrote:
> > On Mon, Oct 9, 2023 at 3:44=E2=80=AFAM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> On 2023/10/09 17:13, Willem de Bruijn wrote:
> >>> On Sun, Oct 8, 2023 at 12:22=E2=80=AFAM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> virtio-net have two usage of hashes: one is RSS and another is hash
> >>>> reporting. Conventionally the hash calculation was done by the VMM.
> >>>> However, computing the hash after the queue was chosen defeats the
> >>>> purpose of RSS.
> >>>>
> >>>> Another approach is to use eBPF steering program. This approach has
> >>>> another downside: it cannot report the calculated hash due to the
> >>>> restrictive nature of eBPF.
> >>>>
> >>>> Introduce the code to compute hashes to the kernel in order to overc=
ome
> >>>> thse challenges. An alternative solution is to extend the eBPF steer=
ing
> >>>> program so that it will be able to report to the userspace, but it m=
akes
> >>>> little sense to allow to implement different hashing algorithms with
> >>>> eBPF since the hash value reported by virtio-net is strictly defined=
 by
> >>>> the specification.
> >>>>
> >>>> The hash value already stored in sk_buff is not used and computed
> >>>> independently since it may have been computed in a way not conforman=
t
> >>>> with the specification.
> >>>>
> >>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>
> >>>> @@ -2116,31 +2172,49 @@ static ssize_t tun_put_user(struct tun_struc=
t *tun,
> >>>>           }
> >>>>
> >>>>           if (vnet_hdr_sz) {
> >>>> -               struct virtio_net_hdr gso;
> >>>> +               union {
> >>>> +                       struct virtio_net_hdr hdr;
> >>>> +                       struct virtio_net_hdr_v1_hash v1_hash_hdr;
> >>>> +               } hdr;
> >>>> +               int ret;
> >>>>
> >>>>                   if (iov_iter_count(iter) < vnet_hdr_sz)
> >>>>                           return -EINVAL;
> >>>>
> >>>> -               if (virtio_net_hdr_from_skb(skb, &gso,
> >>>> -                                           tun_is_little_endian(tun=
), true,
> >>>> -                                           vlan_hlen)) {
> >>>> +               if ((READ_ONCE(tun->vnet_hash.flags) & TUN_VNET_HASH=
_REPORT) &&
> >>>> +                   vnet_hdr_sz >=3D sizeof(hdr.v1_hash_hdr) &&
> >>>> +                   skb->tun_vnet_hash) {
> >>>
> >>> Isn't vnet_hdr_sz guaranteed to be >=3D hdr.v1_hash_hdr, by virtue of
> >>> the set hash ioctl failing otherwise?
> >>>
> >>> Such checks should be limited to control path where possible
> >>
> >> There is a potential race since tun->vnet_hash.flags and vnet_hdr_sz a=
re
> >> not read at once.
> >
> > It should not be possible to downgrade the hdr_sz once v1 is selected.
>
> I see nothing that prevents shrinking the header size.
>
> tun->vnet_hash.flags is read after vnet_hdr_sz so the race can happen
> even for the case the header size grows though this can be fixed by
> reordering the two reads.

One option is to fail any control path that tries to re-negotiate
header size once this hash option is enabled?

There is no practical reason to allow feature re-negotiation at any
arbitrary time.

