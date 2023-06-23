Return-Path: <bpf+bounces-3302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0349B73BDF2
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 19:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19BB281CE4
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 17:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007A2101C3;
	Fri, 23 Jun 2023 17:40:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADACED2FF
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 17:40:47 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A532A11C
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:40:45 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5440e98616cso1474145a12.0
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687542045; x=1690134045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCPznyUQlLVG1j2ms7R2mLf8gMGERmZmpYSON8gxMCw=;
        b=EDCOUL3+YDeCYRM+qYsLvL7aRJajJKijFVqrscMPDamDb7SENPwOiIJ2LWNjB//Lif
         UdPrPupGG8sgzJgFKAIHaG84nOZB0vCTDVQVbq1CTn3HcEmoVLLg2GB1O4uQrafxVk5k
         aN63tPbZAzENP0Joi0zz9XTf7KzsA+9fm9qMlNK378uM/SYowBNH5fD5BoYOnETOumYd
         tpqQCyt58wKkHODl/RHJFNf4Mmk4bAXKKnt1sfW9n/1msKkFnPDcBU3hF+0R1OMpW0Tq
         t/B61TPk5AKDRDrqUBTg1YlNK0Fop43PuEoDCuDNHtVF56iF2NNEixb5WPUmXj61IG46
         pxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687542045; x=1690134045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCPznyUQlLVG1j2ms7R2mLf8gMGERmZmpYSON8gxMCw=;
        b=bcNjfuK4oz5vsXRM6o6Glohc0u3v67KUNDNQ+/V13n4c+pFBy0WPp049cFdZzzToVV
         XhFXhOc5YjY3B4t9qOCxuyeuKEjw95DQJ8RaZ4LOK1HmYi4KiLTk+EOw2OZNiuh7PY+2
         89ZbNlTSXuGzWVsqXR/V8sclgpQp601Z3dZORPN9pxMYjzL/7w/JizuZr9kO6OzdRoZg
         B3RkD8LqFv81j6ut41kXFoqDPYfh0wk1Xo37guCQUt3OMslgfpFbBBWHScmlQEJPKLfx
         zqilzeziKjDu1Ue8Q/oosMpj75BaDAwJaJdCBWc7UIcoI/k5NN5rcy/1YbSYAH1hR9ZV
         ZKLQ==
X-Gm-Message-State: AC+VfDyx+OSJ5xyOsjhAiM7jDy2BnQkhds3CFwk8wDLxuviU6gOt7i1O
	DCPM1iDSgURed+F3jrbS5VYmIbszzKJRe21tGqd30w==
X-Google-Smtp-Source: ACHHUZ52puql8/XSBHfteIOJ8jEi9P2aihca43xdPuqAY1YFO5uIFWRbIdzIGXKw/6yCd44AjeMmnDkl4+UGcDyG+1o=
X-Received: by 2002:a17:90a:eb18:b0:25e:c876:26e9 with SMTP id
 j24-20020a17090aeb1800b0025ec87626e9mr27321235pjz.22.1687542044961; Fri, 23
 Jun 2023 10:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-10-sdf@google.com>
 <a50de565-23a7-2ac5-d5cb-e568e3ad77c9@brouer.com>
In-Reply-To: <a50de565-23a7-2ac5-d5cb-e568e3ad77c9@brouer.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 23 Jun 2023 10:40:33 -0700
Message-ID: <CAKH8qBvr5ePwSP2fL4z3YPG4cmCFvTYQc8+6awNX9=LKHySKXg@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 09/11] selftests/bpf: Extend xdp_metadata with
 devtx kfuncs
To: "Jesper D. Brouer" <netdev@brouer.com>
Cc: bpf@vger.kernel.org, brouer@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, netdev@vger.kernel.org, 
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

On Fri, Jun 23, 2023 at 4:12=E2=80=AFAM Jesper D. Brouer <netdev@brouer.com=
> wrote:
>
>
>
> On 21/06/2023 19.02, Stanislav Fomichev wrote:
> > Attach kfuncs that request and report TX timestamp via ringbuf.
> > Confirm on the userspace side that the program has triggered
> > and the timestamp is non-zero.
> >
> > Also make sure devtx_frame has a sensible pointers and data.
> >
> [...]
>
>
> > diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/t=
esting/selftests/bpf/progs/xdp_metadata.c
> > index d151d406a123..fc025183d45a 100644
> > --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> > +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> [...]
> > @@ -19,10 +24,25 @@ struct {
> >       __type(value, __u32);
> >   } prog_arr SEC(".maps");
> >
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_RINGBUF);
> > +     __uint(max_entries, 10);
> > +} tx_compl_buf SEC(".maps");
> > +
> > +__u64 pkts_fail_tx =3D 0;
> > +
> > +int ifindex =3D -1;
> > +__u64 net_cookie =3D -1;
> > +
> >   extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
> >                                        __u64 *timestamp) __ksym;
> >   extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *=
hash,
> >                                   enum xdp_rss_hash_type *rss_type) __k=
sym;
> > +extern int bpf_devtx_sb_request_timestamp(const struct devtx_frame *ct=
x) __ksym;
> > +extern int bpf_devtx_cp_timestamp(const struct devtx_frame *ctx, __u64=
 *timestamp) __ksym;
> > +
> > +extern int bpf_devtx_sb_attach(int ifindex, int prog_fd) __ksym;
> > +extern int bpf_devtx_cp_attach(int ifindex, int prog_fd) __ksym;
> >
> >   SEC("xdp")
> >   int rx(struct xdp_md *ctx)
> > @@ -61,4 +81,102 @@ int rx(struct xdp_md *ctx)
> >       return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
> >   }
> >
> > +static inline int verify_frame(const struct devtx_frame *frame)
> > +{
> > +     struct ethhdr eth =3D {};
> > +
> > +     /* all the pointers are set up correctly */
> > +     if (!frame->data)
> > +             return -1;
> > +     if (!frame->sinfo)
> > +             return -1;
> > +
> > +     /* can get to the frags */
> > +     if (frame->sinfo->nr_frags !=3D 0)
> > +             return -1;
> > +     if (frame->sinfo->frags[0].bv_page !=3D 0)
> > +             return -1;
> > +     if (frame->sinfo->frags[0].bv_len !=3D 0)
> > +             return -1;
> > +     if (frame->sinfo->frags[0].bv_offset !=3D 0)
> > +             return -1;
> > +
> > +     /* the data has something that looks like ethernet */
> > +     if (frame->len !=3D 46)
> > +             return -1;
> > +     bpf_probe_read_kernel(&eth, sizeof(eth), frame->data);
> > +
> > +     if (eth.h_proto !=3D bpf_htons(ETH_P_IP))
> > +             return -1;
> > +
> > +     return 0;
> > +}
> > +
> > +SEC("fentry/veth_devtx_submit")
> > +int BPF_PROG(tx_submit, const struct devtx_frame *frame)
> > +{
> > +     struct xdp_tx_meta meta =3D {};
> > +     int ret;
> > +
> > +     if (frame->netdev->ifindex !=3D ifindex)
> > +             return 0;
> > +     if (frame->netdev->nd_net.net->net_cookie !=3D net_cookie)
> > +             return 0;
> > +     if (frame->meta_len !=3D TX_META_LEN)
> > +             return 0;
> > +
> > +     bpf_probe_read_kernel(&meta, sizeof(meta), frame->data - TX_META_=
LEN);
> > +     if (!meta.request_timestamp)
> > +             return 0;
> > +
> > +     ret =3D verify_frame(frame);
> > +     if (ret < 0) {
> > +             __sync_add_and_fetch(&pkts_fail_tx, 1);
> > +             return 0;
> > +     }
> > +
> > +     ret =3D bpf_devtx_sb_request_timestamp(frame);
>
> My original design thoughts were that BPF-progs would write into
> metadata area, with the intend that at TX-complete we can access this
> metadata area again.
>
> In this case with request_timestamp it would make sense to me, to store
> a sequence number (+ the TX-queue number), such that program code can
> correlate on complete event.

Yeah, we can probably follow up on that. I'm trying to start with a
read-only path for now.
Can we expose metadata mutating operations via some new kfunc helpers?
Something that returns a ptr/dynptr to the metadata portion?

> Like xdp_hw_metadata example, I would likely also to add a software
> timestamp, what I could check at TX complete hook.
>
> > +     if (ret < 0) {
> > +             __sync_add_and_fetch(&pkts_fail_tx, 1);
> > +             return 0;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +SEC("fentry/veth_devtx_complete")
> > +int BPF_PROG(tx_complete, const struct devtx_frame *frame)
> > +{
> > +     struct xdp_tx_meta meta =3D {};
> > +     struct devtx_sample *sample;
> > +     int ret;
> > +
> > +     if (frame->netdev->ifindex !=3D ifindex)
> > +             return 0;
> > +     if (frame->netdev->nd_net.net->net_cookie !=3D net_cookie)
> > +             return 0;
> > +     if (frame->meta_len !=3D TX_META_LEN)
> > +             return 0;
> > +
> > +     bpf_probe_read_kernel(&meta, sizeof(meta), frame->data - TX_META_=
LEN);
> > +     if (!meta.request_timestamp)
> > +             return 0;
> > +
> > +     ret =3D verify_frame(frame);
> > +     if (ret < 0) {
> > +             __sync_add_and_fetch(&pkts_fail_tx, 1);
> > +             return 0;
> > +     }
> > +
> > +     sample =3D bpf_ringbuf_reserve(&tx_compl_buf, sizeof(*sample), 0)=
;
> > +     if (!sample)
> > +             return 0;
>
> Sending this via a ringbuffer to userspace, will make it hard to
> correlate. (For AF_XDP it would help a little to add the TX-queue
> number, as this hook isn't queue bound but AF_XDP is).

Agreed. I was looking into putting the metadata back into the ring initiall=
y.
It's somewhat doable for zero-copy, but needs some special care for copy mo=
de.
So I've decided not to over-complicate the series and land the
read-only hooks at least.
Does it sound fair? We can allow mutating metadata separately.

> > +
> > +     sample->timestamp_retval =3D bpf_devtx_cp_timestamp(frame, &sampl=
e->timestamp);
> > +
>
> I were expecting to see, information being written into the metadata
> area of the frame, such that AF_XDP completion-queue handling can
> extract this obtained timestamp.

SG, will add!

> > +     bpf_ringbuf_submit(sample, 0);
> > +
> > +     return 0;
> > +}
> > +
> >   char _license[] SEC("license") =3D "GPL";
> > diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing=
/selftests/bpf/xdp_metadata.h
> > index 938a729bd307..e410f2b95e64 100644
> > --- a/tools/testing/selftests/bpf/xdp_metadata.h
> > +++ b/tools/testing/selftests/bpf/xdp_metadata.h
> > @@ -18,3 +18,17 @@ struct xdp_meta {
> >               __s32 rx_hash_err;
> >       };
> >   };
> > +
> > +struct devtx_sample {
> > +     int timestamp_retval;
> > +     __u64 timestamp;
> > +};
> > +
> > +#define TX_META_LEN  8
>
> Very static design.
>
> > +
> > +struct xdp_tx_meta {
> > +     __u8 request_timestamp;
> > +     __u8 padding0;
> > +     __u16 padding1;
> > +     __u32 padding2;
> > +};
>
> padding2 could be a btf_id for creating a more flexible design.

Right, up to the programs on how to make it more flexible (same as
rx), will add more on that in your other reply.

