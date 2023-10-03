Return-Path: <bpf+bounces-11319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BF97B7412
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 00:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 18E1B281507
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 22:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4083E48F;
	Tue,  3 Oct 2023 22:22:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3F3E466;
	Tue,  3 Oct 2023 22:22:21 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC74A7;
	Tue,  3 Oct 2023 15:22:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9b6559cbd74so275390066b.1;
        Tue, 03 Oct 2023 15:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696371738; x=1696976538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJiwXlFYjkYluyTgpH4fzs2CrnhGaQweJZVvwfDZx7U=;
        b=njvaTFCVouGW/SIle5v8aqY0mBS2X1cyBzNSJOhzQ1DmA+AM/Ffcp8XAdqxkzeGUhr
         Dja3tsVO/cnq8eIEVUx1/wI1o7C8H82B2YD0mUest4y129zV+dX3M1MPJshAigIT1GGB
         XV/nfF14nqfwAEWmhziVmmdSzCOL+OXErvU+cutmWzgTDkKp/UaRb50EOz8MLlk8HVeO
         QLdLmBhKmKgNKce9mp0si9l/Zmb/gO5EjbQoaORNQlZwbpUej6lr7tqwiFp6Vh3OIqMK
         GipibiBmQ9g2RcYj3JGuBGslkUUqdTWTIFS4ceivxei7+NJk1ajilQAKHf6nRNi/2OBY
         3R0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696371738; x=1696976538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJiwXlFYjkYluyTgpH4fzs2CrnhGaQweJZVvwfDZx7U=;
        b=hae3VBVb9cVDUMwvMe185tmhU+sUKTAF0T5ekwBz7qDa1kjWFTyOJ7nHjqzYXLwA1F
         RcoFmM1giYZ3qhRiAbEsis9IovjHRH5J/yszoqZzUYV4/YDp5tNGarPpjGpNdTZ3D+DD
         P+phl22Z1Qr7QOhrHmvywOg3/Fvq32x2Rvyhyve+QuVBhVAYXWqRO/3rhTJjf3o6+PGj
         qZ6jVhLq1gDtPZQYfl0C4bYS3z2/rq4kV2biMhraYg74qHdFhc2Iui5T01IPzGzHWqC4
         jZSFF2aeHUb8KG5f+KnWBznDN7YCKWrbii2zbdLGBIDzl8r8pMpL42Oaq5q0xMmdwDMx
         PG0g==
X-Gm-Message-State: AOJu0YwXTANrbrH6fc/+6o4unCX+qBbKXPv9gSWBNTCmt1ZPg59/CGbx
	hfc935b4OzM4p0Tm/BmP1lnoMlmCwlmmqIqfZ64=
X-Google-Smtp-Source: AGHT+IF8scwySXFLgC6juNbuexHN34+HoAiJ81prPIkdSS/17fawF+WRjbFkbnL2BO6n3ff+YJDkHnuRaSH/+I4hGuc=
X-Received: by 2002:a17:906:3051:b0:9a5:7759:19c0 with SMTP id
 d17-20020a170906305100b009a5775919c0mr403596ejd.64.1696371737500; Tue, 03 Oct
 2023 15:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzYMAAhwscTWWTenvyr-PQ7E5tMg_iqXsPj_dyZEMVCrKg@mail.gmail.com>
 <64b4c5891096b_2b67208f@john.notmuch> <CAEf4Bzb2=p3nkaTctDcMAabzL41JjCkTso-aFrfv21z7Y0C48w@mail.gmail.com>
 <64ff278e16f06_2e8f2083a@john.notmuch> <CAEf4Bzb1fMy5beHKxCjvoeCqaYmQFvnjnMi9bgWoML0v27n3SQ@mail.gmail.com>
 <651ba0f13cb51_4fa3f20824@john.notmuch> <651ba39d55792_53e4920861@john.notmuch>
 <20231003054156.52816535@kernel.org>
In-Reply-To: <20231003054156.52816535@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Oct 2023 15:22:05 -0700
Message-ID: <CAEf4BzaaCvMdKMA=N01Gm1uN2XB_5bcYDZF0oXZR=XyoDePfXg@mail.gmail.com>
Subject: Re: Sockmap's parser/verdict programs and epoll notifications
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, "davidhwei@meta.com" <davidhwei@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 5:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon, 02 Oct 2023 22:16:13 -0700 John Fastabend wrote:
> > > This with the other piece we want from our side to allow running
> > > verdict and sk_msg programs on sockets without having them in a
> > > sockmap/sockhash it would seem like a better system to me. The
> > > idea to drop the sockmap/sockhash is because we never remove progs
> > > once they are added and we add them from sockops side. The filter
> > > to socketes is almost always the port + metadata related to the
> > > process or environment. This simplifies having to manage the
> > > sockmap/sockhash and guess what size it should be. Sometimes we
> > > overrun these maps and have to kill connections until we can
> > > get more space.
>
> That's a step in the right direction for sure, but I still think that
> Google's auto-lowat is the best approach. We just need a hook that
> looks at incoming data and sets rcvlowat appropriately. That's it.
> TCP looks at rcvlowat in a number of places to make protocol decisions,
> not just the wake-up. Plus Google will no longer have to carry their
> OOT patch..

David can correct me, but when he tried the SO_RCVLOWAT approach to
solving this problem, he saw no improvements (and it might have
actually been a regression in terms of behavior). I'd say that this
sounds a bit suspicious and we have plans to get back to SO_RCVLOWAT
and try to understand the behavior a bit better.

I'll just say that the simpler the solution - the better. And if this
rcvlowat hook gets us the ability to delay network notification to
user-space until a full logical packet (where packet size is provided
by BPF program without user space involvement) is assembled (up to
some reasonable limits, of course), that would be great.

