Return-Path: <bpf+bounces-8533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34335787B6D
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 00:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C922816A8
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 22:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF99EAD31;
	Thu, 24 Aug 2023 22:22:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9440CA93E
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 22:22:57 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD5A1BE9
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 15:22:56 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bce552508fso4414361fa.1
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 15:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692915774; x=1693520574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgJfgGTZ6K+pa2pFhRZ0UcsiOUtH2gYNEXlta+XGXOM=;
        b=ah3vPivyY8MkdWSo9E5wdI+tFsBKiZhSesKkvGupMu6WHVvVtBX/oXu6hGxhLZZKN1
         +LSpsF6dI1o0OpYpOmPrjObFOh3YZlpMNF6mjR+zhkFiiWHsI/GBCojqa8rFwgA5+SE6
         2/6QOK/416VQkcB0m94p1RkM4oUm/p+tgbmyUJtSdWKSOVLyJaxdPhFaBg17b+/IMmb0
         63deqPtw14aVAUcemDiui8DHuDzPcsYK2QAWfdTplvvRO1p+RIGy13r7gCr40qhUdYxQ
         /lqiOXKyXhMOdd/xRY/uwACu3DXZUdRXWsKyA6wIT6AT3c33lm7XVtmTwTMv5SMBaolw
         A+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692915774; x=1693520574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgJfgGTZ6K+pa2pFhRZ0UcsiOUtH2gYNEXlta+XGXOM=;
        b=GN73TaplOAJyQlEQrWoxxcntt9l/WwAjnYDR4rs2DhYzR6lldSjK8hmZoxWxUm9TjN
         U+bmcn3Kvx3QCc8zyQJnCDr0mbdrgPuDlpFVSPiaqnlNewGd0mYeWvtqK5Ul6i6HJzAU
         vH6E6RLVtdcTWXTmdb2f+MaMvd6LD6CFb+Re6Q/cttgZY1Im5IxNL806Fc+yjEvSP2zz
         6ziCX4ZpauYb01MEGeo9qecKvGthhGnJkkUgJgBHxcErHdury90RC5gpdNBmRf/ThbDt
         MfOdEToAEtW2V0XIE0FstpNYsxZqFdkrRFDgC0XBtQyK70bYcosrEqNaEOZ8uJ3hJ3WY
         p/zg==
X-Gm-Message-State: AOJu0Yzg1NXwITHL4MIEwFW3WJFR3Kq0vhwQZL3t4hDuc57v84Bs9N0o
	ZnExj968dWwE8lrwz+vdKzLVX6rQC70j5vlxqw0b52m8ebVDTu4K
X-Google-Smtp-Source: AGHT+IEb0FHfPpcdFF+5o7z5tfjzAXxojPzRAoHWHxXgzSOvsJ/9RgTxI5TZG63lTU9Xl5a+fmT7oxlCV+AvylsRz1A=
X-Received: by 2002:a2e:94c3:0:b0:2bc:b46b:686b with SMTP id
 r3-20020a2e94c3000000b002bcb46b686bmr12310054ljh.34.1692915773921; Thu, 24
 Aug 2023 15:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724132404.1280848-1-awerner32@gmail.com> <CAEf4BzZQQ=fz+NqFHhJcqKoVAvh4=XbH7HWaHKjUg5OOzi-PTw@mail.gmail.com>
 <b226284c-ad1f-ffe8-b10e-94bbf7a00bc7@huaweicloud.com> <CAEf4BzZvBP9fPs7cfrvLvnha-v_9=pVM=uN=vuOXzWqKCZGeyw@mail.gmail.com>
 <CA+vRuzMP+Z4hqEK3g1c51wSO7aSfBb9=d54102puFrR_r_FJyg@mail.gmail.com>
 <CAEf4BzbG0UvhYbDK1u8nhBEsgyYQxmoNGHgKyeQSH5Spr6As6A@mail.gmail.com> <20230824210939.GB11642@maniforge>
In-Reply-To: <20230824210939.GB11642@maniforge>
From: Andrew Werner <awerner32@gmail.com>
Date: Thu, 24 Aug 2023 18:22:42 -0400
Message-ID: <CA+vRuzP509duLBphp_DVAW9MipQCDpdb5XHWC-QHMkYt8TOhng@mail.gmail.com>
Subject: Re: [PATCH] libbpf: handle producer position overflow
To: void@manifault.com
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Hou Tao <houtao@huaweicloud.com>, 
	bpf@vger.kernel.org, kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 5:09=E2=80=AFPM David Vernet <void@manifault.com> w=
rote:
>
> On Wed, Aug 23, 2023 at 05:07:42PM -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > > > > BTW, I think kernel code needs fixing as well in
> > > > > > __bpf_user_ringbuf_peek (we should compare consumer/producer po=
sitions
> > > > > > directly, only through subtraction and casting to signed long a=
s
> > > > > > above), would you be able to fix it at the same time with libbp=
f?
> > > > > > Would be good to also double-check the rest of kernel/bpf/ringb=
uf.c to
> > > > > > make sure we don't directly compare positions anywhere else.
> > > > >
> > > > > I missed __bpf_user_ringbuf_peek() when reviewed the patch. I als=
o can
> > > > > help to double-check kernel/bpf/ringbuf.c.
> > > >
> > > > great, thanks!
>
> Good catch, and thanks!
>
> > >
> > > I'll update the code in __bpf_user_ringbuf_peek. One observation is
> > > that the code there differs from the regular (non-user) ringbuf and
> > > the libbpf code in that it uses u64 for the positions whereas
> > > everywhere else (including in the struct definition) the types of
> > > these positions are unsigned long. I get that on 64-bit architectures=
,
> > > practically speaking, these are the same. What I'm less clear on is
> > > whether there's anything that prevents this code from running (perhap=
s
> > > with bugs) on 32-bit machines. I suppose that on little-endian
> > > machines things will just work out until the positions overflow 32
> > > bits.
> > >
> > > Would it make sense for me to make the change to always use unsigned
> > > long for these values in the same change?
> >
> > I'm not sure, but I suspect that u64 usage is not intentional, so we
> > probably do want to use unsigned long consistently.
>
> Yeah, that was an oversight and should be fixed. Thanks for pointing it
> out Andrew. FYI, we'd also need to fix user_ring_buffer__reserve() in
> libbpf.
>
> Andrew -- I'm happy to send a patch that fixes this. If you'd like to
> send it out, please feel free to do so. Just let me know.

I handled it in v3 which I just posted here:
https://lore.kernel.org/bpf/20230824220907.1172808-1-awerner32@gmail.com/T/=
#u

>
> Thanks,
> David

