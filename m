Return-Path: <bpf+bounces-11856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7937C485E
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 05:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF241C20E90
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 03:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9116879E5;
	Wed, 11 Oct 2023 03:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVjOqYcC"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC0463B5
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 03:18:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85129A4
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 20:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696994323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xijA8OQKKxwJQ4dCZ6kmx4etcCusbkgY4bBpmAh8Dog=;
	b=aVjOqYcCNJyRnHFHw/DE/aEq4/K+u1Yg9jB3dQ/nQZFs3aw3Z99iCM/Hby2LF1Fus3qRVb
	jKYeaoeM9FtFK/3rKdKWSTuQcB6zQq4SGzgvnC5oashjExdTbjci3bs2GUFCWaqG8ZWHoP
	rWqjV9QzoUShN9sBUOJLt384wiejpZc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-UNZLY28JNy2N0bOZgB5FUg-1; Tue, 10 Oct 2023 23:18:39 -0400
X-MC-Unique: UNZLY28JNy2N0bOZgB5FUg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5056eada207so5931303e87.1
        for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 20:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696994318; x=1697599118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xijA8OQKKxwJQ4dCZ6kmx4etcCusbkgY4bBpmAh8Dog=;
        b=QsxS/M+fbKevR2l4fnfU7KJ4bTbQan6UquoaoAbCmNx+Rt5HYIwcQbXKSlCWZLpO8d
         tMaNqluhJjyoNaAvuWfqhWPn7zX5qDlcUxHQt1d6vMiR5Gndj0w0r/+awl363GXnOqOb
         uveIcgpVleF8OIrsSaZpfK4IHYGPQaEegH3ADzwoB+0Qhgj2X4tocTluMIqjFhNUv9Gh
         79YbyikRHiuNea0xd9VBR6TIj6kTKRLfpdVgyb0K2ap5S7RMxdt4ONNkhtHj898YeXgm
         Eu/mDx6NoHrP9J5j84rkJamqGuJdBZd/en8jzYMtXDVosW8AP1LJIzflSYttK0CBWaCW
         rHOA==
X-Gm-Message-State: AOJu0YxcDlT4icQZfKpr7sP5aVzFPx82ZhdbBnVaU6Rx/BlcqI3cqTDj
	futarA2pP0BGtXJ7+Pq/i82WQnfWYL7TPkNIFbSsIj2sHKBB9ydVvAcEbuODJtvScc8lhq1iRpl
	LUIh9Z4kP+OIEsu1P7FL5st2iof7f
X-Received: by 2002:a05:6512:3e28:b0:500:7f51:d129 with SMTP id i40-20020a0565123e2800b005007f51d129mr22781649lfv.34.1696994318335;
        Tue, 10 Oct 2023 20:18:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvQG0xak6vXbg2OUneajKAYVOTW2UCAtu6Ci4P/1I2WvNiHfiN5uWCXLmSnOhKn18mKUv2p74JegLwDXPCI6U=
X-Received: by 2002:a05:6512:3e28:b0:500:7f51:d129 with SMTP id
 i40-20020a0565123e2800b005007f51d129mr22781636lfv.34.1696994317964; Tue, 10
 Oct 2023 20:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
 <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com> <CAF=yD-+DjDqE9iBu+PvbeBby=C4CCwG=fMFONQONrsErmps3ww@mail.gmail.com>
 <286508a3-3067-456d-8bbf-176b00dcc0c6@daynix.com> <CAF=yD-+syCSJz_wp25rEaHTXMFRHgLh1M-uTdNWPb4fnrKgpFw@mail.gmail.com>
 <8711b549-094d-4be2-b7af-bd93b7516c05@daynix.com> <CAF=yD-+M75o2=yDy5d03fChuNTeeTRkUU7rPRG1i6O9aZGhLmQ@mail.gmail.com>
 <695a0611-2b19-49f9-8d32-cfea3b7df0b2@daynix.com> <CAF=yD-+_PLPt9qfXy1Ljr=Lou0W8hCJLi6HwPcZYCjJy+SKtbA@mail.gmail.com>
 <5baab0cf-7adf-475d-8968-d46ddd179f9a@daynix.com> <CAF=yD-KjvycgFrfKu5CgGGWU-3HbyXt_APQy4tqZgNtJwAUKzg@mail.gmail.com>
 <8f3ed081-134c-45a0-9208-c1cab29cdf37@daynix.com> <CACGkMEv0tpn4YsJhXXnoispYx2-VBimFAtFmf85Uo=5=6taVuw@mail.gmail.com>
 <8a44e14c-03c4-44e2-8c72-9d751c63dffe@daynix.com> <CACGkMEu8m4SRvuMKrJv9_A_Wh_a1OzWkAr_9-+5CyC1zqK=R3Q@mail.gmail.com>
 <0d491319-8ce9-4922-89c9-a48c4c5c03bc@daynix.com>
In-Reply-To: <0d491319-8ce9-4922-89c9-a48c4c5c03bc@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Oct 2023 11:18:27 +0800
Message-ID: <CACGkMEuBbGKssxNv5AfpaPpWQfk2BHR83rM5AHXN-YVMf2NvpQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, 
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	rdunlap@infradead.org, willemb@google.com, gustavoars@kernel.org, 
	herbert@gondor.apana.org.au, steffen.klassert@secunet.com, nogikh@google.com, 
	pablo@netfilter.org, decui@microsoft.com, jakub@cloudflare.com, 
	elver@google.com, pabeni@redhat.com, 
	Yuri Benditovich <yuri.benditovich@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 2:19=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2023/10/10 15:00, Jason Wang wrote:
> > On Tue, Oct 10, 2023 at 1:51=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2023/10/10 14:45, Jason Wang wrote:
> >>> On Tue, Oct 10, 2023 at 9:52=E2=80=AFAM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> On 2023/10/09 19:44, Willem de Bruijn wrote:
> >>>>> On Mon, Oct 9, 2023 at 3:12=E2=80=AFAM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>>>
> >>>>>> On 2023/10/09 19:06, Willem de Bruijn wrote:
> >>>>>>> On Mon, Oct 9, 2023 at 3:02=E2=80=AFAM Akihiko Odaki <akihiko.oda=
ki@daynix.com> wrote:
> >>>>>>>>
> >>>>>>>> On 2023/10/09 18:57, Willem de Bruijn wrote:
> >>>>>>>>> On Mon, Oct 9, 2023 at 3:57=E2=80=AFAM Akihiko Odaki <akihiko.o=
daki@daynix.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 2023/10/09 17:04, Willem de Bruijn wrote:
> >>>>>>>>>>> On Sun, Oct 8, 2023 at 3:46=E2=80=AFPM Akihiko Odaki <akihiko=
.odaki@daynix.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 2023/10/09 5:08, Willem de Bruijn wrote:
> >>>>>>>>>>>>> On Sun, Oct 8, 2023 at 10:04=E2=80=AFPM Akihiko Odaki <akih=
iko.odaki@daynix.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On 2023/10/09 4:07, Willem de Bruijn wrote:
> >>>>>>>>>>>>>>> On Sun, Oct 8, 2023 at 7:22=E2=80=AFAM Akihiko Odaki <aki=
hiko.odaki@daynix.com> wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> virtio-net have two usage of hashes: one is RSS and anot=
her is hash
> >>>>>>>>>>>>>>>> reporting. Conventionally the hash calculation was done =
by the VMM.
> >>>>>>>>>>>>>>>> However, computing the hash after the queue was chosen d=
efeats the
> >>>>>>>>>>>>>>>> purpose of RSS.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Another approach is to use eBPF steering program. This a=
pproach has
> >>>>>>>>>>>>>>>> another downside: it cannot report the calculated hash d=
ue to the
> >>>>>>>>>>>>>>>> restrictive nature of eBPF.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Introduce the code to compute hashes to the kernel in or=
der to overcome
> >>>>>>>>>>>>>>>> thse challenges. An alternative solution is to extend th=
e eBPF steering
> >>>>>>>>>>>>>>>> program so that it will be able to report to the userspa=
ce, but it makes
> >>>>>>>>>>>>>>>> little sense to allow to implement different hashing alg=
orithms with
> >>>>>>>>>>>>>>>> eBPF since the hash value reported by virtio-net is stri=
ctly defined by
> >>>>>>>>>>>>>>>> the specification.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> The hash value already stored in sk_buff is not used and=
 computed
> >>>>>>>>>>>>>>>> independently since it may have been computed in a way n=
ot conformant
> >>>>>>>>>>>>>>>> with the specification.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> +static const struct tun_vnet_hash_cap tun_vnet_hash_cap=
 =3D {
> >>>>>>>>>>>>>>>> +       .max_indirection_table_length =3D
> >>>>>>>>>>>>>>>> +               TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENG=
TH,
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +       .types =3D VIRTIO_NET_SUPPORTED_HASH_TYPES
> >>>>>>>>>>>>>>>> +};
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> No need to have explicit capabilities exchange like this?=
 Tun either
> >>>>>>>>>>>>>>> supports all or none.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> tun does not support VIRTIO_NET_RSS_HASH_TYPE_IP_EX,
> >>>>>>>>>>>>>> VIRTIO_NET_RSS_HASH_TYPE_TCP_EX, and VIRTIO_NET_RSS_HASH_T=
YPE_UDP_EX.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> It is because the flow dissector does not support IPv6 ext=
ensions. The
> >>>>>>>>>>>>>> specification is also vague, and does not tell how many TL=
Vs should be
> >>>>>>>>>>>>>> consumed at most when interpreting destination option head=
er so I chose
> >>>>>>>>>>>>>> to avoid adding code for these hash types to the flow diss=
ector. I doubt
> >>>>>>>>>>>>>> anyone will complain about it since nobody complains for L=
inux.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> I'm also adding this so that we can extend it later.
> >>>>>>>>>>>>>> max_indirection_table_length may grow for systems with 128=
+ CPUs, or
> >>>>>>>>>>>>>> types may have other bits for new protocols in the future.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>                 case TUNSETSTEERINGEBPF:
> >>>>>>>>>>>>>>>> -               ret =3D tun_set_ebpf(tun, &tun->steering=
_prog, argp);
> >>>>>>>>>>>>>>>> +               bpf_ret =3D tun_set_ebpf(tun, &tun->stee=
ring_prog, argp);
> >>>>>>>>>>>>>>>> +               if (IS_ERR(bpf_ret))
> >>>>>>>>>>>>>>>> +                       ret =3D PTR_ERR(bpf_ret);
> >>>>>>>>>>>>>>>> +               else if (bpf_ret)
> >>>>>>>>>>>>>>>> +                       tun->vnet_hash.flags &=3D ~TUN_V=
NET_HASH_RSS;
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Don't make one feature disable another.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> TUNSETSTEERINGEBPF and TUNSETVNETHASH are mutually exclus=
ive
> >>>>>>>>>>>>>>> functions. If one is enabled the other call should fail, =
with EBUSY
> >>>>>>>>>>>>>>> for instance.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> +       case TUNSETVNETHASH:
> >>>>>>>>>>>>>>>> +               len =3D sizeof(vnet_hash);
> >>>>>>>>>>>>>>>> +               if (copy_from_user(&vnet_hash, argp, len=
)) {
> >>>>>>>>>>>>>>>> +                       ret =3D -EFAULT;
> >>>>>>>>>>>>>>>> +                       break;
> >>>>>>>>>>>>>>>> +               }
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +               if (((vnet_hash.flags & TUN_VNET_HASH_RE=
PORT) &&
> >>>>>>>>>>>>>>>> +                    (tun->vnet_hdr_sz < sizeof(struct v=
irtio_net_hdr_v1_hash) ||
> >>>>>>>>>>>>>>>> +                     !tun_is_little_endian(tun))) ||
> >>>>>>>>>>>>>>>> +                    vnet_hash.indirection_table_mask >=
=3D
> >>>>>>>>>>>>>>>> +                    TUN_VNET_HASH_MAX_INDIRECTION_TABLE=
_LENGTH) {
> >>>>>>>>>>>>>>>> +                       ret =3D -EINVAL;
> >>>>>>>>>>>>>>>> +                       break;
> >>>>>>>>>>>>>>>> +               }
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +               argp =3D (u8 __user *)argp + len;
> >>>>>>>>>>>>>>>> +               len =3D (vnet_hash.indirection_table_mas=
k + 1) * 2;
> >>>>>>>>>>>>>>>> +               if (copy_from_user(vnet_hash_indirection=
_table, argp, len)) {
> >>>>>>>>>>>>>>>> +                       ret =3D -EFAULT;
> >>>>>>>>>>>>>>>> +                       break;
> >>>>>>>>>>>>>>>> +               }
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +               argp =3D (u8 __user *)argp + len;
> >>>>>>>>>>>>>>>> +               len =3D virtio_net_hash_key_length(vnet_=
hash.types);
> >>>>>>>>>>>>>>>> +
> >>>>>>>>>>>>>>>> +               if (copy_from_user(vnet_hash_key, argp, =
len)) {
> >>>>>>>>>>>>>>>> +                       ret =3D -EFAULT;
> >>>>>>>>>>>>>>>> +                       break;
> >>>>>>>>>>>>>>>> +               }
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Probably easier and less error-prone to define a fixed si=
ze control
> >>>>>>>>>>>>>>> struct with the max indirection table size.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> I made its size variable because the indirection table and=
 key may grow
> >>>>>>>>>>>>>> in the future as I wrote above.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Btw: please trim the CC: list considerably on future patc=
hes.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> I'll do so in the next version with the TUNSETSTEERINGEBPF=
 change you
> >>>>>>>>>>>>>> proposed.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> To be clear: please don't just resubmit with that one chang=
e.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The skb and cb issues are quite fundamental issues that nee=
d to be resolved.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I'd like to understand why adjusting the existing BPF featu=
re for this
> >>>>>>>>>>>>> exact purpose cannot be amended to return the key it produc=
ed.
> >>>>>>>>>>>>
> >>>>>>>>>>>> eBPF steering program is not designed for this particular pr=
oblem in my
> >>>>>>>>>>>> understanding. It was introduced to derive hash values with =
an
> >>>>>>>>>>>> understanding of application-specific semantics of packets i=
nstead of
> >>>>>>>>>>>> generic IP/TCP/UDP semantics.
> >>>>>>>>>>>>
> >>>>>>>>>>>> This problem is rather different in terms that the hash deri=
vation is
> >>>>>>>>>>>> strictly defined by virtio-net. I don't think it makes sense=
 to
> >>>>>>>>>>>> introduce the complexity of BPF when you always run the same=
 code.
> >>>>>>>>>>>>
> >>>>>>>>>>>> It can utilize the existing flow dissector and also make it =
easier to
> >>>>>>>>>>>> use for the userspace by implementing this in the kernel.
> >>>>>>>>>>>
> >>>>>>>>>>> Ok. There does appear to be overlap in functionality. But it =
might be
> >>>>>>>>>>> easier to deploy to just have standard Toeplitz available wit=
hout
> >>>>>>>>>>> having to compile and load an eBPF program.
> >>>>>>>>>>>
> >>>>>>>>>>> As for the sk_buff and cb[] changes. The first is really not =
needed.
> >>>>>>>>>>> sk_buff simply would not scale if every edge case needs a few=
 bits.
> >>>>>>>>>>
> >>>>>>>>>> An alternative is to move the bit to cb[] and clear it for eve=
ry code
> >>>>>>>>>> paths that lead to ndo_start_xmit(), but I'm worried that it i=
s error-prone.
> >>>>>>>>>>
> >>>>>>>>>> I think we can put the bit in sk_buff for now. We can implemen=
t the
> >>>>>>>>>> alternative when we are short of bits.
> >>>>>>>>>
> >>>>>>>>> I disagree. sk_buff fields add a cost to every code path. They =
cannot
> >>>>>>>>> be added for every edge case.
> >>>>>>>>
> >>>>>>>> It only takes an unused bit and does not grow the sk_buff size s=
o I
> >>>>>>>> think it has practically no cost for now.
> >>>>>>>
> >>>>>>> The problem is that that thinking leads to death by a thousand cu=
ts.
> >>>>>>>
> >>>>>>> "for now" forces the cost of having to think hard how to avoid gr=
owing
> >>>>>>> sk_buff onto the next person. Let's do it right from the start.
> >>>>>>
> >>>>>> I see. I described an alternative to move the bit to cb[] and clea=
r it
> >>>>>> in all code paths that leads to ndo_start_xmit() earlier. Does tha=
t
> >>>>>> sound good to you?
> >>>>>
> >>>>> If you use the control block to pass information between
> >>>>> __dev_queue_xmit on the tun device and tun_net_xmit, using gso_skb_=
cb,
> >>>>> the field can be left undefined in all non-tun paths. tun_select_qu=
eue
> >>>>> can initialize.
> >>>>
> >>>> The problem is that tun_select_queue() is not always called.
> >>>> netdev_core_pick_tx() ensures dev->real_num_tx_queues !=3D 1 before
> >>>> calling it, but this variable may change later and result in a race
> >>>> condition. Another case is that XDP with predefined queue.
> >>>>
> >>>>>
> >>>>> I would still use skb->hash to encode the hash. That hash type of t=
hat
> >>>>> field is not strictly defined. It can be siphash from ___skb_get_ha=
sh
> >>>>> or a device hash, which most likely also uses Toeplitz. Then you al=
so
> >>>>> don't run into the problem of growing the struct size.
> >>>>
> >>>> I'm concerned exactly because it's not strictly defined. Someone may
> >>>> decide to overwrite it later if we are not cautious enough. qdisc_sk=
b_cb
> >>>> also has sufficient space to contain both of the hash value and type=
.
> >>>
> >>> How about using skb extensions?
> >>
> >> I think it will work. I'll try it in the next version.
> >
> > Btw, I still think using eBPF for hash might be better.
> >
> > Though the hashing rule is defined in the spec, it may be extended in
> > the future. For example, several extensions has been proposed:
> >
> > 1) RSS context
> > 2) encapsulated packet hashing
>
> Looking at the proposals, I'm now more inclined to extend the BPF
> steering program.

Just to make sure we are at the same page.

If the eBPF program needs to access skb extensions, it would not be a
steering program anymore (not a filter).

Or do you mean it is a dedicated eBPF program that calculates the hash?

>
> Yuri, who wrote the RFC patches to extend the BPF steering program, also
> raised an concern that it may become hard to implement virtio-net
> extensions in the future. It is much easier to deploy a new BPF program
> to support extensions since it will be included in QEMU and can be
> deployed at once without concerning other kernel stuff.
>
> I was still not sure how likely such an extension will emerge especially
> when the hardware RSS capability is not evolving for a decade or so. But
> those proposals show that there are more demands of new features for
> virtio-net.

It's not only the RSS, if you track virtio development, flow directors
are also being proposed.

Thanks

>


