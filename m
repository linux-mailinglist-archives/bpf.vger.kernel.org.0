Return-Path: <bpf+bounces-13820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E617DE62A
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 19:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB54B20C7D
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 18:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A91718E38;
	Wed,  1 Nov 2023 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSZWB91e"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ADD154A0;
	Wed,  1 Nov 2023 18:52:05 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8209F103;
	Wed,  1 Nov 2023 11:52:04 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4084095722aso945465e9.1;
        Wed, 01 Nov 2023 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698864723; x=1699469523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mru50AUBBs225QOFXV4MkbKxjdRdUmsLDmTlcT7ivms=;
        b=QSZWB91eKkribCusgSRRT7HV6/0AFH2a/y/OOwzikbTIsDcNkAYOI2exqlZjXakyC4
         yLS/xzkTkOGZA+ZVGqyPIoHgs0RHkzcvMUnMlxeqRKJfS3CBagdjSP1EW47VXrPRYWiT
         B1csKoXyZAbwaIVou70WcCOiaij+7Siya0aA/tFc101JMyWJkOXnQ9dTvrtBfM/l4Lkc
         S/86Te/wrfvb5WCez1LQRdhQEN/InBnkiGLrrdx2ZjDQXlDD0FsHbTMZP2QYgv0WJ6gj
         Xr9d2oBCb9iKDXpffIAHec2vYThSReIrMx51SwB7+NOFvLmLyT0gHidp+6J3cQjeUbWk
         ADrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698864723; x=1699469523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mru50AUBBs225QOFXV4MkbKxjdRdUmsLDmTlcT7ivms=;
        b=ixullyl0y2WL9Ok/L87WJ+ghDGlDYX/gGJSMXcWXKqIxCMGJ9MbsmLa24xU4Fw2cys
         YODJ4KwknzaVl2LwaNFarG2hkdPFRhjGYS3km5CacS13Ru70Ieag0VLQ+4wnQPaTGgQz
         SuxjHIyVdCI+rDMiBnRgpsutYfQDoLI99+aRSywFl0adXazI4Eyw/zLjlihvteDUcqzm
         mJeTiBgdU9x++7RbmyDnXj6rd0BvPc4VPfuvjRArQ7LdGKEe5C9h/Dtr0Z3bUhuykoks
         fKzyoJltrm7Nwfr2bWKZMTzdyEXchIMQHZKAI1mdyACvAMqY4c14lRFF4s0QU21co13H
         SXZA==
X-Gm-Message-State: AOJu0YyE6fqhQDlYLdyqYIHtmf5JMMcNXRtf8vg5jHY22sb9kYsaLx6D
	3cbh0b076IJ/B/WQOux/cWYCG6rwgSRyMCMSvKY=
X-Google-Smtp-Source: AGHT+IHFhmT2wH1+n3pjA2B1iXvWkzp3PNIljhXCfwBuXtLGspYwm0lrX6z6AW1LPW75X2DuBapFr+ApeiO8IMRFmm4=
X-Received: by 2002:a05:600c:3c9a:b0:404:2dbb:8943 with SMTP id
 bg26-20020a05600c3c9a00b004042dbb8943mr14744187wmb.2.1698864722716; Wed, 01
 Nov 2023 11:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698431765.git.dxu@dxuuu.xyz> <ee5513e6384696147da9bdccd2e22ea27d690084.1698431765.git.dxu@dxuuu.xyz>
 <CAADnVQ+UUsJvrPp=YhtpwuC6xVWGB=OgwXZwXtHi=2Je6n5a=A@mail.gmail.com>
 <io26znzyhw4t4drmcqkmvgyykyblxzxpizuntgk5fhqasipfyo@r5tpoqo3djkp>
 <CAADnVQJkfAGG9_868tLW9m-9V2husAaRK5afnrLL1HqaxN_3vQ@mail.gmail.com> <fzgysfsfgeqq3tzy2yqrqjibu542qtfi75fcnbxkivsiajaiys@ddd4vftvtwse>
In-Reply-To: <fzgysfsfgeqq3tzy2yqrqjibu542qtfi75fcnbxkivsiajaiys@ddd4vftvtwse>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Nov 2023 11:51:51 -0700
Message-ID: <CAADnVQ+anY6G8Xczc1pNmG7Z6k4OEawfGNq0j6guchdRFzLHHg@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/6] bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Alexei Starovoitov <ast@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	John Fastabend <john.fastabend@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	antony.antony@secunet.com, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 1, 2023 at 10:51=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Yeah, I agree the code in this patchset is not correct. I have the fix
> (a KF_RELEASE wrapper around xfrm_state_put()) ready to send. I think
> Steffen was gonna chat w/ you about this at IETF next week. But I can
> send it now if you'd like.

I say send a new version with all issues addressed now, since
it might help to frame the discussion at IETF.

>
> To answer your question why it doesn't blow up immediately:
>
> * The test system only has ~33 inbound SAs and the test doesn't try to
>   delete any. So leak is not noticed in the test. Oddly enough I recall
>   `ip x s flush` working correctly... Could be misremembering.
>
> * Refcnt overflow will indeed happen, but some rough math shows it'll
>   take about 12 hrs receiving at 100Gbps for that to happen. 100Gbps =3D
>   12.5 GB/s. 12.5GB / (32 CPUs) / (9000B) =3D 43k pps for each pcpu SA.
>   INT_MAX =3D 2 billion. 2B / 4k =3D 46k. 46k seconds to hours is ~12 hrs=
.
>   And I was only running traffic for ~1 hour.
>
> At least I think that math is right.

Makes sense.

