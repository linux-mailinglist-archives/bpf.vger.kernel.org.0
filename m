Return-Path: <bpf+bounces-11790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452107BF2B2
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 08:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A4B1C20D2B
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 06:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE02D9473;
	Tue, 10 Oct 2023 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2CZChx6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA0F9450
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 06:00:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70617B8
	for <bpf@vger.kernel.org>; Mon,  9 Oct 2023 23:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696917644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Gk7tBGT8X8drXI+GYZgxJFy1e/35zrCp1p7LiznPLI=;
	b=E2CZChx6HY9f38eRQGzoc2vVXAE2/zy5ZqdH2yVSSmIcjRKqFPLIh0CpN+e8Cj/2ZO+Ski
	qgmjRR+92YAMnepWIb7ekmV0tMCqpW8lRH6tyzosqns/KMjthxdadTpiwJBpgAERuo/Jud
	cqYu1mJ6PXi2Wq1uMaWB0aldzss1hDg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-jNy3snJePBeffIJuITAbpA-1; Tue, 10 Oct 2023 02:00:37 -0400
X-MC-Unique: jNy3snJePBeffIJuITAbpA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-503317b8d26so4590015e87.1
        for <bpf@vger.kernel.org>; Mon, 09 Oct 2023 23:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696917636; x=1697522436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Gk7tBGT8X8drXI+GYZgxJFy1e/35zrCp1p7LiznPLI=;
        b=Rilc5RxQF1Lfwh8LS+4j+zc+dyHnm4jBQeSR71Tc0rtChr+sT5WBBBjKri4CEbYTZu
         PsGNx/Zz8xmT1VJvwoc1QNVBMa0xPtCukzY1eAkmX+HV9iqlKeLoobppwRerwOD9xdSN
         9t1VY5oql1frDpHmLxonPLfzMQ8Iz+fmAe5qnjbhZGNmj3q4eF1OXr27gqYnxwuMyQTa
         YFqHEKRZIpav2+GUU3EWcc+BW83RlVWnoCmIJBXaCAz1oXT94/4E6iFsTeabxZDwBuaE
         rkMTXJosY6ddgUGhQXo6giRQ5Z9GJXt+vayWvLcNuXpw9mQ+/Uub/bhRn4Evl6zHY70m
         N1uw==
X-Gm-Message-State: AOJu0YxHA3eNDiqk0vsc7OTzLOu1CdAt1B1nCUWerBIk8gQu0ch0fBgK
	9LXIUe2gmCtjVvS8NVGmAzY7k8/nFLQ0Zz3q9Ce/xk9OqGvyeLExwROEyjH7qhtKBb2cstxtJBz
	dQ9Y+k+en9RmPfTMhwIhZaz4AFJ59
X-Received: by 2002:a05:6512:3144:b0:502:d5b0:436e with SMTP id s4-20020a056512314400b00502d5b0436emr12983932lfi.62.1696917636371;
        Mon, 09 Oct 2023 23:00:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEEZZRDdD8H90JRjWbRmrO+8BUOAcxUDaxkN1ma9xdSIGkn8J0hIp7OgmdPKLwyJxgBGzltTqTsEITR8au8JA=
X-Received: by 2002:a05:6512:3144:b0:502:d5b0:436e with SMTP id
 s4-20020a056512314400b00502d5b0436emr12983894lfi.62.1696917635900; Mon, 09
 Oct 2023 23:00:35 -0700 (PDT)
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
 <8f3ed081-134c-45a0-9208-c1cab29cdf37@daynix.com> <CACGkMEv0tpn4YsJhXXnoispYx2-VBimFAtFmf85Uo=5=6taVuw@mail.gmail.com>
 <8a44e14c-03c4-44e2-8c72-9d751c63dffe@daynix.com>
In-Reply-To: <8a44e14c-03c4-44e2-8c72-9d751c63dffe@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Oct 2023 14:00:24 +0800
Message-ID: <CACGkMEu8m4SRvuMKrJv9_A_Wh_a1OzWkAr_9-+5CyC1zqK=R3Q@mail.gmail.com>
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

On Tue, Oct 10, 2023 at 1:51=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2023/10/10 14:45, Jason Wang wrote:
> > On Tue, Oct 10, 2023 at 9:52=E2=80=AFAM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2023/10/09 19:44, Willem de Bruijn wrote:
> >>> On Mon, Oct 9, 2023 at 3:12=E2=80=AFAM Akihiko Odaki <akihiko.odaki@d=
aynix.com> wrote:
> >>>>
> >>>> On 2023/10/09 19:06, Willem de Bruijn wrote:
> >>>>> On Mon, Oct 9, 2023 at 3:02=E2=80=AFAM Akihiko Odaki <akihiko.odaki=
@daynix.com> wrote:
> >>>>>>
> >>>>>> On 2023/10/09 18:57, Willem de Bruijn wrote:
> >>>>>>> On Mon, Oct 9, 2023 at 3:57=E2=80=AFAM Akihiko Odaki <akihiko.oda=
ki@daynix.com> wrote:
> >>>>>>>>
> >>>>>>>> On 2023/10/09 17:04, Willem de Bruijn wrote:
> >>>>>>>>> On Sun, Oct 8, 2023 at 3:46=E2=80=AFPM Akihiko Odaki <akihiko.o=
daki@daynix.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 2023/10/09 5:08, Willem de Bruijn wrote:
> >>>>>>>>>>> On Sun, Oct 8, 2023 at 10:04=E2=80=AFPM Akihiko Odaki <akihik=
o.odaki@daynix.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 2023/10/09 4:07, Willem de Bruijn wrote:
> >>>>>>>>>>>>> On Sun, Oct 8, 2023 at 7:22=E2=80=AFAM Akihiko Odaki <akihi=
ko.odaki@daynix.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> virtio-net have two usage of hashes: one is RSS and anothe=
r is hash
> >>>>>>>>>>>>>> reporting. Conventionally the hash calculation was done by=
 the VMM.
> >>>>>>>>>>>>>> However, computing the hash after the queue was chosen def=
eats the
> >>>>>>>>>>>>>> purpose of RSS.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Another approach is to use eBPF steering program. This app=
roach has
> >>>>>>>>>>>>>> another downside: it cannot report the calculated hash due=
 to the
> >>>>>>>>>>>>>> restrictive nature of eBPF.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Introduce the code to compute hashes to the kernel in orde=
r to overcome
> >>>>>>>>>>>>>> thse challenges. An alternative solution is to extend the =
eBPF steering
> >>>>>>>>>>>>>> program so that it will be able to report to the userspace=
, but it makes
> >>>>>>>>>>>>>> little sense to allow to implement different hashing algor=
ithms with
> >>>>>>>>>>>>>> eBPF since the hash value reported by virtio-net is strict=
ly defined by
> >>>>>>>>>>>>>> the specification.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> The hash value already stored in sk_buff is not used and c=
omputed
> >>>>>>>>>>>>>> independently since it may have been computed in a way not=
 conformant
> >>>>>>>>>>>>>> with the specification.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>> +static const struct tun_vnet_hash_cap tun_vnet_hash_cap =
=3D {
> >>>>>>>>>>>>>> +       .max_indirection_table_length =3D
> >>>>>>>>>>>>>> +               TUN_VNET_HASH_MAX_INDIRECTION_TABLE_LENGTH=
,
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +       .types =3D VIRTIO_NET_SUPPORTED_HASH_TYPES
> >>>>>>>>>>>>>> +};
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> No need to have explicit capabilities exchange like this? T=
un either
> >>>>>>>>>>>>> supports all or none.
> >>>>>>>>>>>>
> >>>>>>>>>>>> tun does not support VIRTIO_NET_RSS_HASH_TYPE_IP_EX,
> >>>>>>>>>>>> VIRTIO_NET_RSS_HASH_TYPE_TCP_EX, and VIRTIO_NET_RSS_HASH_TYP=
E_UDP_EX.
> >>>>>>>>>>>>
> >>>>>>>>>>>> It is because the flow dissector does not support IPv6 exten=
sions. The
> >>>>>>>>>>>> specification is also vague, and does not tell how many TLVs=
 should be
> >>>>>>>>>>>> consumed at most when interpreting destination option header=
 so I chose
> >>>>>>>>>>>> to avoid adding code for these hash types to the flow dissec=
tor. I doubt
> >>>>>>>>>>>> anyone will complain about it since nobody complains for Lin=
ux.
> >>>>>>>>>>>>
> >>>>>>>>>>>> I'm also adding this so that we can extend it later.
> >>>>>>>>>>>> max_indirection_table_length may grow for systems with 128+ =
CPUs, or
> >>>>>>>>>>>> types may have other bits for new protocols in the future.
> >>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>>                case TUNSETSTEERINGEBPF:
> >>>>>>>>>>>>>> -               ret =3D tun_set_ebpf(tun, &tun->steering_p=
rog, argp);
> >>>>>>>>>>>>>> +               bpf_ret =3D tun_set_ebpf(tun, &tun->steeri=
ng_prog, argp);
> >>>>>>>>>>>>>> +               if (IS_ERR(bpf_ret))
> >>>>>>>>>>>>>> +                       ret =3D PTR_ERR(bpf_ret);
> >>>>>>>>>>>>>> +               else if (bpf_ret)
> >>>>>>>>>>>>>> +                       tun->vnet_hash.flags &=3D ~TUN_VNE=
T_HASH_RSS;
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Don't make one feature disable another.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> TUNSETSTEERINGEBPF and TUNSETVNETHASH are mutually exclusiv=
e
> >>>>>>>>>>>>> functions. If one is enabled the other call should fail, wi=
th EBUSY
> >>>>>>>>>>>>> for instance.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>> +       case TUNSETVNETHASH:
> >>>>>>>>>>>>>> +               len =3D sizeof(vnet_hash);
> >>>>>>>>>>>>>> +               if (copy_from_user(&vnet_hash, argp, len))=
 {
> >>>>>>>>>>>>>> +                       ret =3D -EFAULT;
> >>>>>>>>>>>>>> +                       break;
> >>>>>>>>>>>>>> +               }
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +               if (((vnet_hash.flags & TUN_VNET_HASH_REPO=
RT) &&
> >>>>>>>>>>>>>> +                    (tun->vnet_hdr_sz < sizeof(struct vir=
tio_net_hdr_v1_hash) ||
> >>>>>>>>>>>>>> +                     !tun_is_little_endian(tun))) ||
> >>>>>>>>>>>>>> +                    vnet_hash.indirection_table_mask >=3D
> >>>>>>>>>>>>>> +                    TUN_VNET_HASH_MAX_INDIRECTION_TABLE_L=
ENGTH) {
> >>>>>>>>>>>>>> +                       ret =3D -EINVAL;
> >>>>>>>>>>>>>> +                       break;
> >>>>>>>>>>>>>> +               }
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +               argp =3D (u8 __user *)argp + len;
> >>>>>>>>>>>>>> +               len =3D (vnet_hash.indirection_table_mask =
+ 1) * 2;
> >>>>>>>>>>>>>> +               if (copy_from_user(vnet_hash_indirection_t=
able, argp, len)) {
> >>>>>>>>>>>>>> +                       ret =3D -EFAULT;
> >>>>>>>>>>>>>> +                       break;
> >>>>>>>>>>>>>> +               }
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +               argp =3D (u8 __user *)argp + len;
> >>>>>>>>>>>>>> +               len =3D virtio_net_hash_key_length(vnet_ha=
sh.types);
> >>>>>>>>>>>>>> +
> >>>>>>>>>>>>>> +               if (copy_from_user(vnet_hash_key, argp, le=
n)) {
> >>>>>>>>>>>>>> +                       ret =3D -EFAULT;
> >>>>>>>>>>>>>> +                       break;
> >>>>>>>>>>>>>> +               }
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Probably easier and less error-prone to define a fixed size=
 control
> >>>>>>>>>>>>> struct with the max indirection table size.
> >>>>>>>>>>>>
> >>>>>>>>>>>> I made its size variable because the indirection table and k=
ey may grow
> >>>>>>>>>>>> in the future as I wrote above.
> >>>>>>>>>>>>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Btw: please trim the CC: list considerably on future patche=
s.
> >>>>>>>>>>>>
> >>>>>>>>>>>> I'll do so in the next version with the TUNSETSTEERINGEBPF c=
hange you
> >>>>>>>>>>>> proposed.
> >>>>>>>>>>>
> >>>>>>>>>>> To be clear: please don't just resubmit with that one change.
> >>>>>>>>>>>
> >>>>>>>>>>> The skb and cb issues are quite fundamental issues that need =
to be resolved.
> >>>>>>>>>>>
> >>>>>>>>>>> I'd like to understand why adjusting the existing BPF feature=
 for this
> >>>>>>>>>>> exact purpose cannot be amended to return the key it produced=
.
> >>>>>>>>>>
> >>>>>>>>>> eBPF steering program is not designed for this particular prob=
lem in my
> >>>>>>>>>> understanding. It was introduced to derive hash values with an
> >>>>>>>>>> understanding of application-specific semantics of packets ins=
tead of
> >>>>>>>>>> generic IP/TCP/UDP semantics.
> >>>>>>>>>>
> >>>>>>>>>> This problem is rather different in terms that the hash deriva=
tion is
> >>>>>>>>>> strictly defined by virtio-net. I don't think it makes sense t=
o
> >>>>>>>>>> introduce the complexity of BPF when you always run the same c=
ode.
> >>>>>>>>>>
> >>>>>>>>>> It can utilize the existing flow dissector and also make it ea=
sier to
> >>>>>>>>>> use for the userspace by implementing this in the kernel.
> >>>>>>>>>
> >>>>>>>>> Ok. There does appear to be overlap in functionality. But it mi=
ght be
> >>>>>>>>> easier to deploy to just have standard Toeplitz available witho=
ut
> >>>>>>>>> having to compile and load an eBPF program.
> >>>>>>>>>
> >>>>>>>>> As for the sk_buff and cb[] changes. The first is really not ne=
eded.
> >>>>>>>>> sk_buff simply would not scale if every edge case needs a few b=
its.
> >>>>>>>>
> >>>>>>>> An alternative is to move the bit to cb[] and clear it for every=
 code
> >>>>>>>> paths that lead to ndo_start_xmit(), but I'm worried that it is =
error-prone.
> >>>>>>>>
> >>>>>>>> I think we can put the bit in sk_buff for now. We can implement =
the
> >>>>>>>> alternative when we are short of bits.
> >>>>>>>
> >>>>>>> I disagree. sk_buff fields add a cost to every code path. They ca=
nnot
> >>>>>>> be added for every edge case.
> >>>>>>
> >>>>>> It only takes an unused bit and does not grow the sk_buff size so =
I
> >>>>>> think it has practically no cost for now.
> >>>>>
> >>>>> The problem is that that thinking leads to death by a thousand cuts=
.
> >>>>>
> >>>>> "for now" forces the cost of having to think hard how to avoid grow=
ing
> >>>>> sk_buff onto the next person. Let's do it right from the start.
> >>>>
> >>>> I see. I described an alternative to move the bit to cb[] and clear =
it
> >>>> in all code paths that leads to ndo_start_xmit() earlier. Does that
> >>>> sound good to you?
> >>>
> >>> If you use the control block to pass information between
> >>> __dev_queue_xmit on the tun device and tun_net_xmit, using gso_skb_cb=
,
> >>> the field can be left undefined in all non-tun paths. tun_select_queu=
e
> >>> can initialize.
> >>
> >> The problem is that tun_select_queue() is not always called.
> >> netdev_core_pick_tx() ensures dev->real_num_tx_queues !=3D 1 before
> >> calling it, but this variable may change later and result in a race
> >> condition. Another case is that XDP with predefined queue.
> >>
> >>>
> >>> I would still use skb->hash to encode the hash. That hash type of tha=
t
> >>> field is not strictly defined. It can be siphash from ___skb_get_hash
> >>> or a device hash, which most likely also uses Toeplitz. Then you also
> >>> don't run into the problem of growing the struct size.
> >>
> >> I'm concerned exactly because it's not strictly defined. Someone may
> >> decide to overwrite it later if we are not cautious enough. qdisc_skb_=
cb
> >> also has sufficient space to contain both of the hash value and type.
> >
> > How about using skb extensions?
>
> I think it will work. I'll try it in the next version.

Btw, I still think using eBPF for hash might be better.

Though the hashing rule is defined in the spec, it may be extended in
the future. For example, several extensions has been proposed:

1) RSS context
2) encapsulated packet hashing

Thanks

>


