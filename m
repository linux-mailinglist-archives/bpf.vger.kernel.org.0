Return-Path: <bpf+bounces-48875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBDBA1156D
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B403A21C5
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 23:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E80F2135AA;
	Tue, 14 Jan 2025 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5HL7Ua/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B429215164;
	Tue, 14 Jan 2025 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897425; cv=none; b=urS7liaPraugCJRh+qbdBH8zzWrvrn99FOVwtHNMC9m/RuBeMtYktq/1C7+m3lxZMVDjq2AfN9SXSVstR58D5RggGyxi70fmvCmhJ8sbzru2328BeKOyKan8aYoih4Bwgiv8td3tfnDS3i3z1Zk1m3plhUSOJCNhoctFh4DzX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897425; c=relaxed/simple;
	bh=q2hM4Rki9VlKYuLfZRMlLtU0fusb1pYch0Wd1uy+8Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJqWrPFeQMciclDc+UgjtB9xpSvkVRKdpnLCyYcASNG+h66CZui3FvdArG5tICE262u95MG0FMEvWi9DbisA3lypwzRoromyziQCp/oUCq/AnSYuRy2d3lSFDlAyChMMpRFh6X47ujO4mpjhejY2AnFrYlqqPXXiTyxvxDBjBEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5HL7Ua/; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-84ceaf2667aso340844639f.3;
        Tue, 14 Jan 2025 15:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736897422; x=1737502222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyOl0K1lbPYGsG7AwMIQpKZOeQyXeF5fCYARCfcZYAk=;
        b=P5HL7Ua/ZLUYs0iJYWsuwbobSrNBZxBuuCxyYbuwO0eCRi9QOty1BA8lzoy1T4YmY0
         ESbDgsrTyHFdYDghORDUmx8tx3vD58iELyWEYU3vB3PgVBTOELqBhHze47y8wvL3yaaR
         MdRTx5j3Hnc3X1DUPLaWNqdwvsZB74dRucxjzc8NBcjnjoH7wZQA1giSsx9T9ChAXBQD
         FLDs+GB9NTYOaQL1y5/aLxNJLc+q0jhIHIlga8KCZDF0HkWFWNbeoAHpVmElqP3dptoc
         Ky38i9MnWYQMFjQqgAkYpIXmi/S3RD6kp6L6s31TmU3zT5V3s/WkesgBLdNjjDKJ8Ww1
         06FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736897422; x=1737502222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyOl0K1lbPYGsG7AwMIQpKZOeQyXeF5fCYARCfcZYAk=;
        b=h+PN0otmDkf/5lUpZUd1vHjXs4an9y096K51VjNOlq+vZMeyaYTru0xZRQk7ilX0DC
         qg6b6SkLz+y1+vLCQ+8lhT6mDQwa3O2QqIggdt0HsrVa5tdyGKfegnP0WGWWhQ9O09Ns
         kgXcHSUfcu9to+x8ZWxYCPCYydNCMJHeNbgMz8pdy4EoSlMFmzZj77/dPHdI7q7KH6vc
         yafASRxnK1xKBoc6WHT6IwaGW0HSJS8I0oc5OkJu5byEcAM8YDgdmPaec37md/Q5TWym
         huQZs8C7nB4g8pY0dNMHb7vOwEyS+SN1YP6WFVV69UErhF/00hXFFqPNk+BDujO1/aMd
         JPRw==
X-Forwarded-Encrypted: i=1; AJvYcCWRrIrymoxBEAQKtHB3kIMOTuGGCKxBZOwRR/4lzaTHrPYozDmYgP503bsqBs5rB4dYLshw5Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG2b0ZybK6TFlIpiSmeDKSTJH75VJZe4UmznExF7PPrQM5IyXR
	Ne6D7eK6GrvPsLMYNJiKzrt2PP9l5ehnnoF/vz04VjO5pupRGpwN8h/ARZs+v1X7asIj9UVynjv
	4n5DbuafkkHQa59RkoJdo75k01CU=
X-Gm-Gg: ASbGncvy0Zkx1iYS5bfCAIh/I7TvKs5/oIcDBUjFWxHAJVeIHIzGvG28sgS8we/I07Y
	Gaio7ITizg2Z9DJMnqu4WPJuc4ZJcZ/sLbck8
X-Google-Smtp-Source: AGHT+IEea8ssOu8+WMsAKzDNhEAg6+okq1rLR9AH83a67NE5RxtYKFrjYXEUhU2VNKkSeT5/HUmRY0lpGLGfzgurVqQ=
X-Received: by 2002:a92:c243:0:b0:3a7:e86a:e803 with SMTP id
 e9e14a558f8ab-3ce3a9b579amr241999465ab.8.1736897422396; Tue, 14 Jan 2025
 15:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-2-kerneljasonxing@gmail.com> <6bb42e9b-83ff-497d-8052-27ac609a2af7@linux.dev>
In-Reply-To: <6bb42e9b-83ff-497d-8052-27ac609a2af7@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 15 Jan 2025 07:29:46 +0800
X-Gm-Features: AbW1kvY-jMUNz72K6Ay1I4D9pfzlfYRdKnucxTj3LHOVGzoMsoX-N2rLGrr7bsg
Message-ID: <CAL+tcoDLRnsTXF-ChGh4uwM=5t3Gk8jOK_ZCARyCM+8kV9Wrag@mail.gmail.com>
Subject: Re: [PATCH net-next v5 01/15] net-timestamp: add support for bpf_setsockopt()
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	willemdebruijn.kernel@gmail.com, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 7:20=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/12/25 3:37 AM, Jason Xing wrote:
> > Users can write the following code to enable the bpf extension:
> > bpf_setsockopt(skops, SOL_SOCKET, SK_BPF_CB_FLAGS, &flags, sizeof(flags=
));
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   include/net/sock.h             |  7 +++++++
> >   include/uapi/linux/bpf.h       |  8 ++++++++
> >   net/core/filter.c              | 25 +++++++++++++++++++++++++
> >   tools/include/uapi/linux/bpf.h |  1 +
> >   4 files changed, 41 insertions(+)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index ccf86c8a7a8a..f5447b4b78fd 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -303,6 +303,7 @@ struct sk_filter;
> >     * @sk_stamp: time stamp of last packet received
> >     * @sk_stamp_seq: lock for accessing sk_stamp on 32 bit architecture=
s only
> >     * @sk_tsflags: SO_TIMESTAMPING flags
> > +  *  @sk_bpf_cb_flags: used for bpf_setsockopt
> >     * @sk_use_task_frag: allow sk_page_frag() to use current->task_frag=
.
> >     *                    Sockets that can be used under memory reclaim =
should
> >     *                    set this to false.
> > @@ -445,6 +446,12 @@ struct sock {
> >       u32                     sk_reserved_mem;
> >       int                     sk_forward_alloc;
> >       u32                     sk_tsflags;
> > +#ifdef CONFIG_BPF_SYSCALL
>
> The CONFIG_BPF is used instead in the existing "u8 bpf_sock_ops_cb_flags;=
" in
> tcp_sock. afaik, CONFIG_BPF is selected by CONFIG_NET. It is why the test=
 bot
> fails when CONFIG_BPF_SYSCALL is used here but not with the existing
> bpf_sock_ops_cb_flags. Considering CONFIG_BPF is also mostly useless here
> because of CONFIG_NET, I would remove this ifdef usage altogether. If the=
re is
> really a need to distinguish CONFIG_BPF_SYSCALL is enabled or not, this c=
an be
> improved together with the existing bpf_sock_ops_cb_flags.

Thank you, Martin. Then I will remove those ifdef related limitation.

>
> > +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
> > +     u32                     sk_bpf_cb_flags;
> > +#else
> > +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) 0
> > +#endif
> >       __cacheline_group_end(sock_write_rxtx);
> >
> >       __cacheline_group_begin(sock_write_tx);
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 4162afc6b5d0..e629e09b0b31 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6903,6 +6903,13 @@ enum {
> >       BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x7F,
> >   };
> >
> > +/* Definitions for bpf_sk_cb_flags */
> > +enum {
> > +     SK_BPF_CB_TX_TIMESTAMPING       =3D 1<<0,
> > +     SK_BPF_CB_MASK                  =3D (SK_BPF_CB_TX_TIMESTAMPING - =
1) |
> > +                                        SK_BPF_CB_TX_TIMESTAMPING
> > +};
> > +
> >   /* List of known BPF sock_ops operators.
> >    * New entries can only be added at the end
> >    */
> > @@ -7081,6 +7088,7 @@ enum {
> >       TCP_BPF_SYN_IP          =3D 1006, /* Copy the IP[46] and TCP head=
er */
> >       TCP_BPF_SYN_MAC         =3D 1007, /* Copy the MAC, IP[46], and TC=
P header */
> >       TCP_BPF_SOCK_OPS_CB_FLAGS =3D 1008, /* Get or Set TCP sock ops fl=
ags */
> > +     SK_BPF_CB_FLAGS         =3D 1009, /* Used to set socket bpf flags=
 */
> >   };
> >
> >   enum {
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index b957cf57299e..c6dd2d2e44c8 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5222,6 +5222,23 @@ static const struct bpf_func_proto bpf_get_socke=
t_uid_proto =3D {
> >       .arg1_type      =3D ARG_PTR_TO_CTX,
> >   };
> >
> > +static int sk_bpf_set_cb_flags(struct sock *sk, char *optval, bool get=
opt)
> > +{
> > +     u32 sk_bpf_cb_flags;
> > +
> > +     if (getopt)
>
> I may have this in my earlier sample code? This is probably because of my
> laziness for a quick example. getopt should also be supported, similar to=
 the
> existing TCP_BPF_SOCK_OPS_CB_FLAGS.

Right, to be honest, I keep curious about this one, but I have no
clue. I will support getopt which should be easy :)

Thanks,
Jason

