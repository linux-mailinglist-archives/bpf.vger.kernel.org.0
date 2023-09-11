Return-Path: <bpf+bounces-9692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A42379AC18
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 01:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACFC2815EF
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 23:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC43F8F6D;
	Mon, 11 Sep 2023 23:06:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DAC8488
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 23:06:29 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FB2CBD75
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 16:03:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fbbb953cfso1473316b3a.2
        for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 16:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694473371; x=1695078171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx0gR2ESc4lJCkHeNwni0JEpr6/GKNTWX/V+qZxf4Do=;
        b=yOo/fUz8DPGGqaxGWRsJvhhxCXY7VzWzCwL+tdAg3ysYlnn0plLAlnZPQTxxW5BNEs
         wvKJ9i0JaYkLACBHaXRQOuj2tIRsYbUgBeKOs7Lzv6GKflv9OXogvJIHmqgJQBK31stE
         Mqqc9kLrucrUWCwlegpqBvo03o08VtTdMC0fvEnq739guRD6XLmjfWkMPqDa7YcoHJmF
         D4nl0iAy0Qss9gqCrpwB1GaYxhbsH0DqMTDt+evu13uD/Zr2exkkSBCDXQKtw1dp+s+7
         8fmZ1fimzykgO+5tuozshixSYGXq6NI8YpcOOvOtvjvF0yIbapSpY87ht8ODLbmOn4+t
         yz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694473371; x=1695078171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fx0gR2ESc4lJCkHeNwni0JEpr6/GKNTWX/V+qZxf4Do=;
        b=LZXGLK8cVSmsnWxJbZ2wJsvKVfsWSg8nTNwgKKo9txKT8T88LO2Quyr9gixkBGSJqX
         7majgdHDbK7Aa9Xp5mVzFLwiiV6NaqmmoixkcEMrhh4J0rxukU8cb5Gc5e1x9fsM5eKW
         aIx9W5oGAEyb8ya/ED3cawc9OL7wefbqeQ/VF3eDamQGlE5Pr13jaXI8BueZrZ/KUg37
         h+lx0BYwe/xCJY/P0ZShuzYW0C3B7TboPyldA2oBYTQ3bMnsPL4/TnuzRvO5MGQxrrCk
         I1vUdPS7XuVE1Lj/xJlnuyfQRF7kAQAyhR5RlFnsZV2RXjswt1YJS0shUHYnV6g23sZn
         Yi7w==
X-Gm-Message-State: AOJu0Yza10gKMzWOSgTRy1cqqGdVOsjVvUvqEGH5jbnB6DEJjR1PQEkk
	o53jWt5QcJOE31U+Q5E6lCGSreaUeFZkNWmmkeYVcYL8CdkjQOpIiHg=
X-Google-Smtp-Source: AGHT+IHHfIWUIjIzBE6AKQx2HgmCouux51fozxiALlTAf6+prejD6RO4cCCYO4UujkzNTsNXYdatZHi0Ok3aRyWfiC4=
X-Received: by 2002:a05:6a00:c95:b0:68a:51dc:50c0 with SMTP id
 a21-20020a056a000c9500b0068a51dc50c0mr13544622pfv.32.1694472502737; Mon, 11
 Sep 2023 15:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230908225807.1780455-1-sdf@google.com> <20230908225807.1780455-3-sdf@google.com>
 <6c275fdc-4468-7573-a33c-35fc442c61c5@linux.dev>
In-Reply-To: <6c275fdc-4468-7573-a33c-35fc442c61c5@linux.dev>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 11 Sep 2023 15:48:10 -0700
Message-ID: <CAKH8qBv78jTrktfThFK=Ze12tjgAsgYXyNaRy-3m8QE8J-xwuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: expose information about supported xdp
 metadata kfunc
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 11, 2023 at 3:11=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/8/23 3:58 PM, Stanislav Fomichev wrote:
> > @@ -12,15 +13,24 @@ static int
> >   netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
> >                  const struct genl_info *info)
> >   {
> > +     u64 xdp_rx_meta =3D 0;
> >       void *hdr;
> >
> >       hdr =3D genlmsg_iput(rsp, info);
> >       if (!hdr)
> >               return -EMSGSIZE;
> >
> > +#define XDP_METADATA_KFUNC(_, flag, __, xmo) \
> > +     if (netdev->xdp_metadata_ops->xmo) \
>
> A NULL check is needed for netdev->xdp_metadata_ops.

Oh, sure, will add, thanks!

> > +             xdp_rx_meta |=3D flag;
> > +XDP_METADATA_KFUNC_xxx
> > +#undef XDP_METADATA_KFUNC
> > +
>

