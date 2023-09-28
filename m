Return-Path: <bpf+bounces-11046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E727B1B99
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 14:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E6E04282527
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E07038BA6;
	Thu, 28 Sep 2023 12:01:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD9B1A5A7;
	Thu, 28 Sep 2023 12:01:50 +0000 (UTC)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51173121;
	Thu, 28 Sep 2023 05:01:49 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-4526c6579afso8400325137.0;
        Thu, 28 Sep 2023 05:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695902508; x=1696507308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKRsw7BD1NlTrMjbE88Z2QcAwvd4pOeAA2bZ/M6DxX0=;
        b=HQc1QM7bkGSJE0qBEYgyzzXVyTALrKZpUqpRPD5zG47BY17/kuOfZAbTod5I0coqqP
         i+LatEPAM/BVr/DRxCBkhnM1kqZr1gtPGwRqS5+Y9M+dCIIdDdGoJ0gXfKCvXWJPPbF2
         ZBD4avv4nIjzL9p5udI5pJpY6DHCP010LACJvGWY4tXLMbWjuQP+hkXj9rn4hEymf6ic
         ssMMpu/1/7bJ4I0mdGUOM+4Q7byuQerMdhWqDK58u9Uta+Mb0m+MjZ0nTwjbQp+SAOgN
         LZd2E8dpvhrJV/ETL0mDFiE5wu/q4wK9nUZ43izGcc2Zn1eZYh5cMO3UMQaApcIeMo37
         eSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695902508; x=1696507308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKRsw7BD1NlTrMjbE88Z2QcAwvd4pOeAA2bZ/M6DxX0=;
        b=qF4S19+6us9AFQQn0EEhtkI2CBjlkeUxhsO9V8A2Jt3926Dqos7k4Wd8QMgLrs3Gqw
         84dcVchRwfmCZF2JmO03gJ5npwkjC+ixn9sk2eQKaGTmLpDq1Chkg9g5L6CEQSxKOd8s
         MQlabL1IgnHUCjKA4E/sVW1mKtatkWhlOD00yBj2HMZQKxQK9AH6/0CjgXPXifo8vC+v
         eAFIB90C7s4mwjCQqmZFCCW9tYHZ5ZxHVY0JmxXNMLmk2L4jc59f16QQsETigcTuxSTP
         g+WO+KxpZJ09z2m6fv6luH2SNjjwQ7zlFCh31Tn+/x3qzQcQzd/ASQkt42fy3h1qyGVr
         Qn7A==
X-Gm-Message-State: AOJu0YyjogRsUCCu4QWyO41rIxtTQY4c1rG2HypVB87bM0zfs6d0CqeA
	yk5bulEgpSmMhd7+VVFzoT13uUgAOnXIxKzu9is=
X-Google-Smtp-Source: AGHT+IEtIwb7/cyKh4fV7JZCv9u8nhzw3HzhRAYNt7LsPN3hDT3sEAvvD55FqBRqwy+wD2Var9S70CiKipiCBMPC2gw=
X-Received: by 2002:a67:f653:0:b0:452:6ecb:e90 with SMTP id
 u19-20020a67f653000000b004526ecb0e90mr447353vso.3.1695902508274; Thu, 28 Sep
 2023 05:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926055913.9859-1-daniel@iogearbox.net> <20230926055913.9859-2-daniel@iogearbox.net>
 <877coa8xp2.fsf@toke.dk>
In-Reply-To: <877coa8xp2.fsf@toke.dk>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 28 Sep 2023 14:01:11 +0200
Message-ID: <CAF=yD-L2YgVeB=99kK4OzZR7fF=hJM5QBi3Ld=Xdct0q4tDMag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/8] meta, bpf: Add bpf programmable meta device
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	martin.lau@kernel.org, razor@blackwall.org, ast@kernel.org, andrii@kernel.org, 
	john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 28, 2023 at 11:17=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@kernel.org> wrote:
>
> Daniel Borkmann <daniel@iogearbox.net> writes:
>
> > This work adds a new, minimal BPF-programmable device called "meta" we
> > recently presented at LSF/MM/BPF. The latter name derives from the Gree=
k
> > =CE=BC=CE=B5=CF=84=CE=AC, encompassing a wide array of meanings such as=
 "on top of", "beyond".
> > Given business logic is defined by BPF, this device can have many meani=
ngs.
> > The core idea is that BPF programs are executed within the drivers xmit
> > routine and therefore e.g. in case of containers/Pods moving BPF proces=
sing
> > closer to the source.
>
> I like the concept, but I think we should change the name (as I believe
> I also mentioned back when you presented it at LSF/MM/BPF). I know this
> is basically bikeshedding, but I nevertheless think it is important, for
> a couple of reasons:
>
> - As you say, meta has a specific meaning, and this device is not a
>   "meta" device in the common sense of the word: it is not tied to other
>   devices (so it's not 'on top of' anything), and it is not "about"
>   anything (as in metadata). It is just a device type that is programmed
>   by BPF, so let's call it that.
>
> - It's not discoverable; how are people supposed to figure out that they
>   should go look for a 'meta' device? We also already have multiple
>   things called 'metadata', so this is just going to create even more
>   confusion (as we also discussed in relation to 'xdp hints').
>
> - It squats on a pretty widely used term throughout the kernel
>   (CONFIG_META, 'meta' as the module name). This is related to the above
>   point; seeing something named 'meta' in lsmod, the natural assumption
>   wouldn't be that it's a network driver.
>
> I think we should just name the driver 'bpfnet'; it's not pretty, but
> it's obvious and descriptive. Optionally we could teach 'ip' to
> understand just 'bpf' as the device type, so you could go 'ip link add
> type bpf' and get one of these.

+1

> > One of the goals was that in case of Pod egress traffic, this allows to
> > move BPF programs from hostns tcx ingress into the device itself, provi=
ding
> > earlier drop or forward mechanisms, for example, if the BPF program
> > determines that the skb must be sent out of the node, then a redirect t=
o
> > the physical device can take place directly without going through per-C=
PU
> > backlog queue. This helps to shift processing for such traffic from sof=
tirq
> > to process context, leading to better scheduling decisions and better
> > performance.
>
> So my only reservation to having this tied to a BPF-only device like
> this is basically that if this is indeed such a big win, shouldn't we
> try to make the stack operate in this mode by default? I assume you did
> the analysis of what it would take to change veth to operate in this
> mode; so what was the reason you decided to create a new device type
> instead?
>
> (I seem to recall at the presentation that you made a general reference
> to veth being 'too complex', but complexity can be managed, so I'm more
> thinking about whether there's any specific reason why changing veth
> wouldn't work at all?)

If one point is queuing packets on the softnet queue, I think it
should be fine to call netif_receive_skb instead of netif_rx, at least
for single device depth.

