Return-Path: <bpf+bounces-11786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A29C7BF261
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 07:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763281C20DA6
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 05:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B258F74;
	Tue, 10 Oct 2023 05:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpADoLv0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FBF8F65
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 05:45:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE5FA3
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 22:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696916737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+I2EY4NGx452ATYzw4Kz0XF6aTAAXvBTqSjZlE93qM=;
	b=RpADoLv0vfxwvMfGJ7suyhF9X/y1TBDezYf+eiHfzI9wrhlsRs1lX1CcMFLInGMIs14IFC
	r5DvbFrg0QszMoVvrfSSE4mGbITRNFqKROgQLyNS/9/eKQz1wsTTzgLR/tmKi1NFXfgwYn
	CUhSrPisAmj8+Q+Xjf5rGmXM0/KvtYQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-72i6j0SNNv2qCPKHzBD0tg-1; Tue, 10 Oct 2023 01:45:26 -0400
X-MC-Unique: 72i6j0SNNv2qCPKHzBD0tg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5042bc93273so4588484e87.1
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 22:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696916725; x=1697521525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+I2EY4NGx452ATYzw4Kz0XF6aTAAXvBTqSjZlE93qM=;
        b=MQyp3EIVrYhnw51E/PJcqmEhLfwBUpmdeNL53obbEDFdn572bewAUR6QNmMbUCtxij
         krdW//tB8QpfakwTqJK5jIo03xMbBE2P+zKuZwaxP2YK1MmIFrAx3FsgdBkXsmNlGCcp
         E5MRkeZyOYe3NfTrq0yB/2+pY3ett8D6l0/T+Yx4jwBl+YqzVDVa0brpPvTDSXBxzota
         PfrfBtK4t18bsSAQPknV+P5e3JcuhcEmQfYTs6cfTdK5ZWdhqXmgbF9TIqSDPR+je0QN
         4ULuYifovsMbooqOfwKsshAsFR+/dFdL1I8muj/uo0U3wRoCKyA6GEKLKhxFsU3V9FZY
         cQfQ==
X-Gm-Message-State: AOJu0YxHcOqRShh+pcLlBfcwqlp8CVYrJBOpdTiWxaGQTlCV66n43X5u
	/q5+nKFqgXbHYsojZaMUFPVdIMqEAhbk3Db/FTj/sXGAXYZj+hat0Jnd4ggCQUe77tySlnxz1HM
	3Ts89hxWR+oevj/8TjRE6MP81mGM6
X-Received: by 2002:a05:6512:ea9:b0:500:b2f6:592 with SMTP id bi41-20020a0565120ea900b00500b2f60592mr18281191lfb.50.1696916725103;
        Mon, 09 Oct 2023 22:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+pwNtTVbI2Ms4EjKlIUtAy5k+rLiIL3TUr1dcb8YFsqYJmXGlmcetJxkpWxQ3ditYPytVqKZpNg5+JzyWzwk=
X-Received: by 2002:a05:6512:ea9:b0:500:b2f6:592 with SMTP id
 bi41-20020a0565120ea900b00500b2f60592mr18281158lfb.50.1696916724673; Mon, 09
 Oct 2023 22:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231008052101.144422-1-akihiko.odaki@daynix.com>
 <20231008052101.144422-6-akihiko.odaki@daynix.com> <CAF=yD-LdwcXKK66s5gvJNOH8qCWRt3SvEL-GkkVif=kkOaYGhg@mail.gmail.com>
 <8f4ad5bc-b849-4ef4-ac1f-8d5a796205e9@daynix.com> <CAF=yD-+DjDqE9iBu+PvbeBby=C4CCwG=fMFONQONrsErmps3ww@mail.gmail.com>
 <286508a3-3067-456d-8bbf-176b00dcc0c6@daynix.com> <CAF=yD-+syCSJz_wp25rEaHTXMFRHgLh1M-uTdNWPb4fnrKgpFw@mail.gmail.com>
 <8711b549-094d-4be2-b7af-bd93b7516c05@daynix.com> <CAF=yD-+M75o2=yDy5d03fChuNTeeTRkUU7rPRG1i6O9aZGhLmQ@mail.gmail.com>
 <695a0611-2b19-49f9-8d32-cfea3b7df0b2@daynix.com> <CAF=yD-+_PLPt9qfXy1Ljr=Lou0W8hCJLi6HwPcZYCjJy+SKtbA@mail.gmail.com>
 <5baab0cf-7adf-475d-8968-d46ddd179f9a@daynix.com> <CAF=yD-KjvycgFrfKu5CgGGWU-3HbyXt_APQy4tqZgNtJwAUKzg@mail.gmail.com>
 <8f3ed081-134c-45a0-9208-c1cab29cdf37@daynix.com>
In-Reply-To: <8f3ed081-134c-45a0-9208-c1cab29cdf37@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Oct 2023 13:45:11 +0800
Message-ID: <CACGkMEv0tpn4YsJhXXnoispYx2-VBimFAtFmf85Uo=5=6taVuw@mail.gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 9:52=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2023/10/09 19:44, Willem de Bruijn wrote:
> > On Mon, Oct 9, 2023 at 3:12=E2=80=AFAM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> On 2023/10/09 19:06, Willem de Bruijn wrote:
> >>> On Mon, Oct 9, 2023 at 3:02=E2=80=AFAM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> On 2023/10/09 18:57, Willem de Bruijn wrote:
> >>>>> On Mon, Oct 9, 2023 at 3:57=E2=80=AFAM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>>>
> >>>>>> On 2023/10/09 17:04, Willem de Bruijn wrote:
> >>>>>>> On Sun, Oct 8, 2023 at 3:46=E2=80=AFPM Akihiko Odaki <akihiko.oda=
ki@daynix.com> wrote:
> >>>>>>>>
> >>>>>>>> On 2023/10/09 5:08, Willem de Bruijn wrote:
> >>>>>>>>> On Sun, Oct 8, 2023 at 10:04=E2=80=AFPM Akihiko Odaki <akihiko.=
odaki@daynix.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 2023/10/09 4:07, Willem de Bruijn wrote:
> >>>>>>>>>>> On Sun, Oct 8, 2023 at 7:22=E2=80=AFAM Akihiko Odaki <akihiko=
.odaki@daynix.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> virtio-net have two usage of hashes: one is RSS and another =
is hash
> >>>>>>>>>>>> reporting. Conventionally the hash calculation was done by t=
he VMM.
> >>>>>>>>>>>> However, computing the hash after the queue was chosen defea=
ts the
> >>>>>>>>>>>> purpose of RSS.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Another approach is to use eBPF steering program. This appro=
ach has
> >>>>>>>>>>>> another downside: it cannot report the calculated hash due t=
o the
> >>>>>>>>>>>> restrictive nature of eBPF.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Introduce the code to compute hashes to the kernel in order =
to overcome
> >>>>>>>>>>>> thse challenges. An alternative solution is to extend the eB=
PF steering
> >>>>>>>>>>>> program so that it will be able to report to the userspace, =
but it makes
> >>>>>>>>>>>> little sense to allow to implement different hashing algorit=
hms with
> >>>>>>>>>>>> eBPF since the hash value reported by virtio-net is strictly=
 defined by
> >>>>>>>>>>>> the specification.
> >>>>>>>>>>>>
> >>>>>>>>>>>> The hash value already stored in sk_buff is not used and com=
puted
> >>>>>>>>>>>> independently since it may have been computed in a way not c=
onformant
> >>>>>>>>>>>> with the specification.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>>>>>>>> ---
> >>>>>>>>>>>
> >>>>>>>>>>>> +static const struct tun_vnet_hash_cap tun_vnet_hash_cap =3D=
 {
> >>>>>>>>>>>> +       .max_indirection_table_length =3D
> >>>>>>>>>>>> +               TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH,
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +       .types =3D VIRTIO_NET_SUPPORTED_HASH_TYPES
> >>>>>>>>>>>> +};
> >>>>>>>>>>>
> >>>>>>>>>>> No need to have explicit capabilities exchange like this? Tun=
 either
> >>>>>>>>>>> supports all or none.
> >>>>>>>>>>
> >>>>>>>>>> tun does not support VIRTIO_NET_RSS_HASH_TYPE_IP_EX,
> >>>>>>>>>> VIRTIO_NET_RSS_HASH_TYPE_TCP_EX, and VIRTIO_NET_RSS_HASH_TYPE_=
UDP_EX.
> >>>>>>>>>>
> >>>>>>>>>> It is because the flow dissector does not support IPv6 extensi=
ons. The
> >>>>>>>>>> specification is also vague, and does not tell how many TLVs s=
hould be
> >>>>>>>>>> consumed at most when interpreting destination option header s=
o I chose
> >>>>>>>>>> to avoid adding code for these hash types to the flow dissecto=
r. I doubt
> >>>>>>>>>> anyone will complain about it since nobody complains for Linux=
.
> >>>>>>>>>>
> >>>>>>>>>> I'm also adding this so that we can extend it later.
> >>>>>>>>>> max_indirection_table_length may grow for systems with 128+ CP=
Us, or
> >>>>>>>>>> types may have other bits for new protocols in the future.
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>>               case TUNSETSTEERINGEBPF:
> >>>>>>>>>>>> -               ret =3D tun_set_ebpf(tun, &tun->steering_pro=
g, argp);
> >>>>>>>>>>>> +               bpf_ret =3D tun_set_ebpf(tun, &tun->steering=
_prog, argp);
> >>>>>>>>>>>> +               if (IS_ERR(bpf_ret))
> >>>>>>>>>>>> +                       ret =3D PTR_ERR(bpf_ret);
> >>>>>>>>>>>> +               else if (bpf_ret)
> >>>>>>>>>>>> +                       tun->vnet_hash.flags &=3D ~TUN_VNET_=
HASH_RSS;
> >>>>>>>>>>>
> >>>>>>>>>>> Don't make one feature disable another.
> >>>>>>>>>>>
> >>>>>>>>>>> TUNSETSTEERINGEBPF and TUNSETVNETHASH are mutually exclusive
> >>>>>>>>>>> functions. If one is enabled the other call should fail, with=
 EBUSY
> >>>>>>>>>>> for instance.
> >>>>>>>>>>>
> >>>>>>>>>>>> +       case TUNSETVNETHASH:
> >>>>>>>>>>>> +               len =3D sizeof(vnet_hash);
> >>>>>>>>>>>> +               if (copy_from_user(&vnet_hash, argp, len)) {
> >>>>>>>>>>>> +                       ret =3D -EFAULT;
> >>>>>>>>>>>> +                       break;
> >>>>>>>>>>>> +               }
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +               if (((vnet_hash.flags & TUN_VNET_HASH_REPORT=
) &&
> >>>>>>>>>>>> +                    (tun->vnet_hdr_sz < sizeof(struct virti=
o_net_hdr_v1_hash) ||
> >>>>>>>>>>>> +                     !tun_is_little_endian(tun))) ||
> >>>>>>>>>>>> +                    vnet_hash.indirection_table_mask >=3D
> >>>>>>>>>>>> +                    TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LEN=
GTH) {
> >>>>>>>>>>>> +                       ret =3D -EINVAL;
> >>>>>>>>>>>> +                       break;
> >>>>>>>>>>>> +               }
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +               argp =3D (u8 __user *)argp + len;
> >>>>>>>>>>>> +               len =3D (vnet_hash.indirection_table_mask + =
1) * 2;
> >>>>>>>>>>>> +               if (copy_from_user(vnet_hash_indirection_tab=
le, argp, len)) {
> >>>>>>>>>>>> +                       ret =3D -EFAULT;
> >>>>>>>>>>>> +                       break;
> >>>>>>>>>>>> +               }
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +               argp =3D (u8 __user *)argp + len;
> >>>>>>>>>>>> +               len =3D virtio_net_hash_key_length(vnet_hash=
.types);
> >>>>>>>>>>>> +
> >>>>>>>>>>>> +               if (copy_from_user(vnet_hash_key, argp, len)=
) {
> >>>>>>>>>>>> +                       ret =3D -EFAULT;
> >>>>>>>>>>>> +                       break;
> >>>>>>>>>>>> +               }
> >>>>>>>>>>>
> >>>>>>>>>>> Probably easier and less error-prone to define a fixed size c=
ontrol
> >>>>>>>>>>> struct with the max indirection table size.
> >>>>>>>>>>
> >>>>>>>>>> I made its size variable because the indirection table and key=
 may grow
> >>>>>>>>>> in the future as I wrote above.
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Btw: please trim the CC: list considerably on future patches.
> >>>>>>>>>>
> >>>>>>>>>> I'll do so in the next version with the TUNSETSTEERINGEBPF cha=
nge you
> >>>>>>>>>> proposed.
> >>>>>>>>>
> >>>>>>>>> To be clear: please don't just resubmit with that one change.
> >>>>>>>>>
> >>>>>>>>> The skb and cb issues are quite fundamental issues that need to=
 be resolved.
> >>>>>>>>>
> >>>>>>>>> I'd like to understand why adjusting the existing BPF feature f=
or this
> >>>>>>>>> exact purpose cannot be amended to return the key it produced.
> >>>>>>>>
> >>>>>>>> eBPF steering program is not designed for this particular proble=
m in my
> >>>>>>>> understanding. It was introduced to derive hash values with an
> >>>>>>>> understanding of application-specific semantics of packets inste=
ad of
> >>>>>>>> generic IP/TCP/UDP semantics.
> >>>>>>>>
> >>>>>>>> This problem is rather different in terms that the hash derivati=
on is
> >>>>>>>> strictly defined by virtio-net. I don't think it makes sense to
> >>>>>>>> introduce the complexity of BPF when you always run the same cod=
e.
> >>>>>>>>
> >>>>>>>> It can utilize the existing flow dissector and also make it easi=
er to
> >>>>>>>> use for the userspace by implementing this in the kernel.
> >>>>>>>
> >>>>>>> Ok. There does appear to be overlap in functionality. But it migh=
t be
> >>>>>>> easier to deploy to just have standard Toeplitz available without
> >>>>>>> having to compile and load an eBPF program.
> >>>>>>>
> >>>>>>> As for the sk_buff and cb[] changes. The first is really not need=
ed.
> >>>>>>> sk_buff simply would not scale if every edge case needs a few bit=
s.
> >>>>>>
> >>>>>> An alternative is to move the bit to cb[] and clear it for every c=
ode
> >>>>>> paths that lead to ndo_start_xmit(), but I'm worried that it is er=
ror-prone.
> >>>>>>
> >>>>>> I think we can put the bit in sk_buff for now. We can implement th=
e
> >>>>>> alternative when we are short of bits.
> >>>>>
> >>>>> I disagree. sk_buff fields add a cost to every code path. They cann=
ot
> >>>>> be added for every edge case.
> >>>>
> >>>> It only takes an unused bit and does not grow the sk_buff size so I
> >>>> think it has practically no cost for now.
> >>>
> >>> The problem is that that thinking leads to death by a thousand cuts.
> >>>
> >>> "for now" forces the cost of having to think hard how to avoid growin=
g
> >>> sk_buff onto the next person. Let's do it right from the start.
> >>
> >> I see. I described an alternative to move the bit to cb[] and clear it
> >> in all code paths that leads to ndo_start_xmit() earlier. Does that
> >> sound good to you?
> >
> > If you use the control block to pass information between
> > __dev_queue_xmit on the tun device and tun_net_xmit, using gso_skb_cb,
> > the field can be left undefined in all non-tun paths. tun_select_queue
> > can initialize.
>
> The problem is that tun_select_queue() is not always called.
> netdev_core_pick_tx() ensures dev->real_num_tx_queues !=3D 1 before
> calling it, but this variable may change later and result in a race
> condition. Another case is that XDP with predefined queue.
>
> >
> > I would still use skb->hash to encode the hash. That hash type of that
> > field is not strictly defined. It can be siphash from ___skb_get_hash
> > or a device hash, which most likely also uses Toeplitz. Then you also
> > don't run into the problem of growing the struct size.
>
> I'm concerned exactly because it's not strictly defined. Someone may
> decide to overwrite it later if we are not cautious enough. qdisc_skb_cb
> also has sufficient space to contain both of the hash value and type.

How about using skb extensions?

Thanks

>


