Return-Path: <bpf+bounces-9574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C297992DC
	for <lists+bpf@lfdr.de>; Sat,  9 Sep 2023 01:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6156A1C20C28
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 23:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4DD7476;
	Fri,  8 Sep 2023 23:38:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2BD7466
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 23:38:05 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6E618E
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 16:38:04 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-500cfb168c6so4223741e87.2
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 16:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694216283; x=1694821083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEm7zeautVu6SBvP0lnrQuux1uiA1fV2WmsOvXU/LiU=;
        b=fyv3GrqBvoRrxF22qbyi7I1U7QA/EWpHDadyug3JG84rSTshcPtZ/dr4+g/40DKTNL
         PJXmhZ/mzi+RvWbDCkwnKCDoj7UvSR24E0EnQzfhs0S7993lAcIvATMKOlz6BKObNGxN
         +1O5liXtsWL1LImVpYPn2aM5j7HC5s3NvksGq+7JrTa1zgJXjOBmFuOg957x61PUKNU2
         ih5J9djGSk7vuH2W9tme4kQXudJhocf45Gck6Sg9MqEwzNeZex6bLdzjQsYG4pfPotOA
         Wa+OeXNQRfHlWkovcIg1QWunqftRxVyuKFY3aMCb0bPk7Mhe/hGfKmtO7B4AKtRAn6bu
         i0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694216283; x=1694821083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEm7zeautVu6SBvP0lnrQuux1uiA1fV2WmsOvXU/LiU=;
        b=QpLUDoAPZEBEhIw+HVjZ9if8ggdXRD6w+kvTOvntPjyzALYa/DaI6vNGHi/VgRGXNR
         06Et4WOEHnLHN5B22AqoXhucaGswX+vs4DvHE3kFSVw8yWyrt3zbrHKU2Ddy1oq9yPSX
         9gedss6GDy3fbavWSp/bEVwZQJyG/kyIuRgG9zBI4TAWDskicrsnK+5m/2ZDwWeY6xo9
         XGLED/cFgadfpwCTVu7lXZ6B/TBGrpQk/byqyeieDqTgJMrUw+rTumuyiWehtBrEibZi
         3mM0gYUacHh+1wBNoPuVJJ3Ja5BCkRZDH1E2QtCrOQjggaiGJMEzQzZvzLY1B8y7B8qj
         Tx2g==
X-Gm-Message-State: AOJu0YzIFqVMZcCA5auGZNV6oILC8PnFGasxWj9oLMj2hzoXuNGrSFhI
	z1/oT4y30T0VgBPFTk8zQyfckBJkn8SUuTrcuD8=
X-Google-Smtp-Source: AGHT+IG9sFeFDJDJ3c1xfxwX/4N92AuWVDRm6mQJ36eem2gRpvWodnJhghOjc5m/OlhI9HrCFJeZuaPQJCxoBFZyssc=
X-Received: by 2002:ac2:4d0f:0:b0:4fd:d08c:fa3e with SMTP id
 r15-20020ac24d0f000000b004fdd08cfa3emr2976669lfi.42.1694216282687; Fri, 08
 Sep 2023 16:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eaed0418-1315-44a4-96d3-d6dbd4d999e8@crowdstrike.com>
In-Reply-To: <eaed0418-1315-44a4-96d3-d6dbd4d999e8@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 8 Sep 2023 16:37:50 -0700
Message-ID: <CAEf4BzafNXQFym=CtiitFJ=yVdQ0xEyShDAZLEsHGhvnp36b1Q@mail.gmail.com>
Subject: Re: libbpf ringbuffer callback prototype
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: bpf@vger.kernel.org, Marco Vedovati <marco.vedovati@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 7, 2023 at 1:09=E2=80=AFPM Martin Kelly
<martin.kelly@crowdstrike.com> wrote:
>
> I noticed that the data pointer in the libbpf ringbuffer callback has
> type void *, without const:
>
> typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size);
>
> However, if you actually try to write to this data, you'll get a SIGSEGV.
>
> It seems to me the prototype should ideally be const void * so the
> compiler can throw -Wdiscarded-qualifiers if someone tries to assign it
> to a non-const type. I'm not sure there's anything to be done about it,
> as changing it now would break the API. However, I wanted to mention it
> just in case anyone has thoughts about this.

Yeah, that's an unfortunate omission... Kernel never allowed to mmap
data area as writable, so there is no way to ever write anything back
through this pointer.

But as you said, adding that const in a callback type would cause
compilation error for every single customer. So it seems just not
worth it at this point.


>
> Thanks,
>
> Martin
>
>

