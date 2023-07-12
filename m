Return-Path: <bpf+bounces-4828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F94074FE89
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 07:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC86281782
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 05:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C273F20E3;
	Wed, 12 Jul 2023 04:59:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817D9644;
	Wed, 12 Jul 2023 04:59:59 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F1E10C7;
	Tue, 11 Jul 2023 21:59:57 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so10385332e87.2;
        Tue, 11 Jul 2023 21:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689137996; x=1691729996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0nFJ9ERKduwN8ULZvzUXn+MtjUmRnV2HCG69mnBhK8=;
        b=mm3xhdJqTh1tV30DlTX99oaqpiDinnqIDaXmEjNFnT0h16+C2saMoI4auqNvqm5H12
         DuuPdWpniks5XNxdmaFdU9ygUf7ESZtMj7zyyEo3sRsGLbD/m1Jc9CQzOTW62LPhNSdx
         UlemSHcuEK+LDFwe/1WMxLGFkm786cxsvvBosfV6KCybBrOK3a+xTgsVZ2SscKpG9N19
         Zdy27ULxJ4wFHp2RZh/njMTYNbDxSdy9O4gC91EZzRBUjd1n5QBWZGOkuJrw+yuMoBjs
         gYYAo8hN6fv5OJg7b+5K5mRkGaITXN6aRrH3sdeQuF9e30eOANbh1d+Lo34AQJNJYbMn
         tYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689137996; x=1691729996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0nFJ9ERKduwN8ULZvzUXn+MtjUmRnV2HCG69mnBhK8=;
        b=BDrZHnSaYDBj1foxBi4Fyo8GRvrUQCGpheIaNF9gzIpX0HLPSWNWxt4IhIRHNTPKGU
         9BGsmPDsDUBG+69Bt2Cb4F+GlTDZ3dmfa8D/3eFk8USBZ80LnUTifTDsRBNZwJme6t+t
         m4JBqRg8CfFYDSBmaSGe4rQIlFS7fmLN7KRdGwbeJQmMMupZjr6iwCikX79pTQaHRfW5
         MmHhyZ5A/tBkW8QlC8zhfvjCg9mo1cfwhyItN9tKAUGtje6dFAYMBoFm+i34GzZQU0kP
         wHMdx4CUEujCsx4MLP7bU3QkbnwQl54YzjtXSzuoPr1Rs25wx//U9OM4Q/dBBzkySHPr
         Cdfw==
X-Gm-Message-State: ABy/qLYBPZ2dJ6CoGHKdEcs6OnTNWGBKXPAcMOvwJMUAM5tCAoPoVAWz
	hoLet0N2Lz0IdPtn0ASIeGJ363bk3pfIDpe0HKI=
X-Google-Smtp-Source: APBJJlFaaf77IGocKXUdXiMyBlI3WZuaxFDPMzG9kVlYpgvOg+4oaPKP+qk5uBD26e9FrfNvlKQvdVYstfGq+B6RmzM=
X-Received: by 2002:a05:6512:15a3:b0:4fb:89f2:594c with SMTP id
 bp35-20020a05651215a300b004fb89f2594cmr17084021lfb.56.1689137995800; Tue, 11
 Jul 2023 21:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com> <20230707193006.1309662-10-sdf@google.com>
 <20230711225657.kuvkil776fajonl5@MacBook-Pro-8.local> <CAKH8qBtawUTjFQ=hhTzXa2zTBwOpxurjhduxZV+eUg8rnJUJVw@mail.gmail.com>
 <CAADnVQKnWCYjOQA-=61pDP4TQ-LKC7S-tOSX9Lm6tB3vJcf4dw@mail.gmail.com>
 <CAKH8qBvnMd2JgobQf1bvc=x7uEn1RPVHcuu3F7gB6vS627g-Xg@mail.gmail.com>
 <CAADnVQLCRrPtQMPBuYiKv44SLDiYwz69KZ=0e0HxJdPQz4x2HQ@mail.gmail.com> <ZK4eFox0DwbpyIJv@google.com>
In-Reply-To: <ZK4eFox0DwbpyIJv@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Jul 2023 21:59:44 -0700
Message-ID: <CAADnVQJnf=KJ17MJWujkj+oSxp7kNNK1k08PvH+Wx617yAtZ8Q@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 09/14] net/mlx5e: Implement devtx kfuncs
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 8:29=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
>
> This will slow things down, but not to the point where it's on par
> with doing sw checksum. At least in theory.
> We can't stay at skb when using AF_XDP. AF_XDP would benefit from having
> the offloads.

To clarify: yes, AF_XDP needs generalized HW offloads.
I just don't see how xdp tx offloads are moving a needle in that direction.

> I hope we can both agree that with an api like
> mlx5_l4_csum_offload(bool encap) we can't be 100% certain that the
> hw is gonna handle any packet layout? So how is that different
> from a generic api that also can't work in all cases?

If it's hw specific then yes.
Will [mlx5|...]_l4_csum_offload apply to other nics? I doubt.

> AF_XDP is a generic layer for low-level access and it provides generic
> descriptor format, so why suddenly we have this requirement where we have
> to do prog rewrite for every new nic?
>
> Current AF_XDP programs are pretty portable (obviously depend on
> a bunch of nic features), it seems like a good idea to try to preserve
> this property? (again, with an asterisk, where we should allow some
> differentiation, etc, etc)

Agree. AF_XDP needs a generic api that will allow user space
request HW to do TSO, csum offload, etc.
xdp tx and af_xdp are too different to pull under the same framework.
xdp progs will interact with the kernel via kfuncs.
af_xdp needs a different api to express packet geometry and offload request=
s.
The user space cannot do it with bpf programs.
In case of AF_XDP the bpf prog in the kernel is a filter only.
For the majority of the cases bpf prog is not necessary and shouldn't be
required to express HW offloads.

