Return-Path: <bpf+bounces-8671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B73F788EAF
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 20:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E812928188F
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069ED18AE9;
	Fri, 25 Aug 2023 18:28:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D118041
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 18:28:16 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A2ECD2
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:28:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5007c8308c3so1894088e87.0
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692988093; x=1693592893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uk4+BPgJ5j7AHKaSK6B/ikdIypeQ/dfjVBPqmJvvUnI=;
        b=EZWt1gm4lF0l/Z8yyq2IRmsYcbGorpm3ooF5GUkIxhUQVz2hjtwLnBry5IzY6JbhEf
         ukRUub0Veeq8WV+wWRpsmpPXvCkgvkiKQsLTWZy2ivfd2CclDpnLDAUOJH0J37fJz7QL
         gJY4+JcGXz+c8/KjBalEreLa5x8aE4KqC36ss9Qm3nh3HZqMrmRbm/NDvKNBO30xEGRs
         TuVAaLGPrzq7/rrfqplnocR5XrJKs6i7L/B9oc7O1MAqicGQuHSa7TkPpVaiGCGm3pg4
         LOn8oVxMfQqygE4YA1jlEgLUZWFe4xvFMnZo8P1amtgzLkofFUDqIcdaVFfu/2hXnBYW
         FOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692988093; x=1693592893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uk4+BPgJ5j7AHKaSK6B/ikdIypeQ/dfjVBPqmJvvUnI=;
        b=YZ56VJBrcxCm5EpH6FWwrCi9bunQxc2KmpDfEkBOL55sJzGh+0hLSIPzvrliVbOwvc
         xZkbTbG5gokGiE1IewSVdCSzpk3/gayUgsahI6wMN/Nn0Vr16rGbN7Wfd+PvjtMgNruS
         9kQsf3aClaUi8qdLwNJWCeV5c1aBEnbRxiKERe8SaQfETHttPnCirHGR9QTlcPXIKMCT
         2Xf5orfENRS0RaqD+1WnE3RmI2XwM6YLq2OhaU+RX7tm/ab5s6Da3D6VwSZUoTtPMgsh
         4dJHn/6uzaPL42eNTZrIzAVTNf+y5mW1NTfIQtCWD8hHRXunrTenvmieDtEXaS5u4lG+
         5v3A==
X-Gm-Message-State: AOJu0YwT6mO9m+gLPjH6IXqpLxSzDDgfsfd7npupZlNS0QfmnYAP5D86
	5D8v0ArVrjn/9AQMWB5cMsU6ZGtDjxr+WdbelJ8=
X-Google-Smtp-Source: AGHT+IEL7NTUFwB1ny2nF+7amwAj6tnkF2MZ2aTJyLqpQcfdorSuooIQtq3Kd2YK7zTgpwnFP3bRdXGXAXYclFQNNOw=
X-Received: by 2002:a05:6512:ba0:b0:500:882b:e55a with SMTP id
 b32-20020a0565120ba000b00500882be55amr12358686lfv.45.1692988092734; Fri, 25
 Aug 2023 11:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824220907.1172808-1-awerner32@gmail.com> <ce26e0c1-7d05-1572-dfc9-10d251fde86f@iogearbox.net>
 <CA+vRuzPsN=1xgvAaP6PrMaiLb7U+B5g1t2eBSnqZRC-XQ2EkzA@mail.gmail.com> <257a7f97-a587-adf4-dfb8-e32a8f8e44b7@iogearbox.net>
In-Reply-To: <257a7f97-a587-adf4-dfb8-e32a8f8e44b7@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Aug 2023 11:28:01 -0700
Message-ID: <CAEf4BzZW=NRGwRbhbzt_y8_hMXJBMCpEFWf=1XkfK689vVuBqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: handle producer position overflow
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrew Werner <awerner32@gmail.com>, bpf@vger.kernel.org, kernel-team@dataexmachina.dev, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, olsajiri@gmail.com, 
	houtao@huaweicloud.com, void@manifault.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 10:23=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 8/25/23 6:39 PM, Andrew Werner wrote:
> > On Fri, Aug 25, 2023 at 11:28=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> >> On 8/25/23 12:09 AM, Andrew Werner wrote:
> >>> Before this patch, the producer position could overflow `unsigned
> >>> long`, in which case libbpf would forever stop processing new writes =
to
> >>> the ringbuf. Similarly, overflows of the producer position could resu=
lt
> >>> in __bpf_user_ringbuf_peek not discovering available data. This patch
> >>> addresses that bug by computing using the signed delta between the
> >>> consumer and producer position to determine if data is available; the
> >>> delta computation is robust to overflow.
> >>>
> >>> A more defensive check could be to ensure that the delta is within
> >>> the allowed range, but such defensive checks are neither present in
> >>> the kernel side code nor in libbpf. The overflow that this patch
> >>> handles can occur while the producer and consumer follow a correct
> >>> protocol.
> >>>
> >>> Secondarily, the type used to represent the positions in the
> >>> user_ring_buffer functions in both libbpf and the kernel has been
> >>> changed from u64 to unsigned long to match the type used in the
> >>> kernel's representation of the structure. The change occurs in the
> >>
> >> Hm, but won't this mismatch for 64bit kernel and 32bit user space? Why
> >> not fixate both on u64 instead so types are consistent?
> >
> > Sure. It feels like if we do that then we'd break existing 32bit
> > big-endian clients, though I am not sure those exist. Concretely, the
> > request here would be to change the kernel structure and all library
> > usages to use u64, right?
>
> Yes, to align all consistently on u64. From your diff, I read that for
> the kernel its the case already.
>

I don't think we can change it. It was intentionally specified as
`long` for consumer and producer positions, to match native word size
for atomic operations and smp_load_acquire/smp_store_release. Using
u64 was a mistake that slipped through.

Further, using u64 doesn't really help with anything, just makes
32-bit code slower (and maybe/probably would allow teared reads/writes
for position counters). Switching to unsigned long is the right move.

> Thanks,
> Daniel
>

