Return-Path: <bpf+bounces-5259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4680758F12
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 09:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119771C20E0F
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 07:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1831CD2E0;
	Wed, 19 Jul 2023 07:32:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA34C8F0
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 07:32:29 +0000 (UTC)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A0BE43
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 00:32:28 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso5190202276.0
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 00:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689751947; x=1692343947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raLezrD2gTJw8jeNEXq80U7RLsICE2TtKQ/7F2JB9js=;
        b=hUBIj5uE1KF49dvCBsbBFRT+hQdJ5Bvo3IhkaqqhPsWx6a7oDGI4qnD9x7yeXN9cOG
         H9Kb2yiv43ErewaCHYrOQ41A31lPvji3rVr22FaHOqMhkuK3zqhW9S1yemEzwB3JX2pO
         mAQmXinaeVg9upgV0+OnLrkM52XJDKcJkf5v9YxI5l19WHZHzjmP0luzTyMPUXzfMP/U
         OGDkbhIg6PZhF/z6WDka1y5wvJ8igU11sXjcE2ZD/PqlJ+gxmwNs1yUMRZIl6dsATy8W
         7zfHE/dLkztCETBErcM9u8iENfv7z+yGPYYKdN3j7NpmRfsAWs6+j+L3iqL+94kzMi74
         B1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689751947; x=1692343947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raLezrD2gTJw8jeNEXq80U7RLsICE2TtKQ/7F2JB9js=;
        b=E9q4uvodgwpJPCNf+WD0wf0t9tV/oJ+pt39rrTLTJm1zfDAJzX/4yvSyoW6mvoAR7f
         7LxMm+KGN9UdEkEycbLapvZRHAiaZm37ssvYe3KX4iWQXj7JjNvLbVLCmy2zqVhpWLcc
         7BiDkVA5tnpf9OIXH1Ytqxocn/Cgyq2NONNJbAZjXYqf2wXebHAf+5RIbXvru064alxV
         LPwEnViJsrr7ZcdKmSgtxbIF1Qm8445oCIXldXeR0P5dx3NkPmOQHSoGdrRWz8B8lY/f
         0YbcmEUECOdcJpM+S6dN7cfPpSjTumJKqnqZUEh57rMx/e4BVGqY7V33Ce+gIzOEbSAe
         N1YA==
X-Gm-Message-State: ABy/qLYhPfpbE8MkGpY7Mec6pelwKiUSD0fXiBTHJGZBH7DcGdd2fYn9
	kowSTfk8U2FLY/FbBS33+52VvMNaBa9MXSkAsAyDNzRTfJBg3OtxdAs=
X-Google-Smtp-Source: APBJJlEwcxaUe2SkzpNT8qOTm6Amr5lqPXfs+mgTHhvKl9GUnAiEiM/IQsBTejmYtz9WcIMywDd2hIBvejwX7k3LMT4=
X-Received: by 2002:a25:cc07:0:b0:c4e:48eb:b8cb with SMTP id
 l7-20020a25cc07000000b00c4e48ebb8cbmr2082225ybf.40.1689751947566; Wed, 19 Jul
 2023 00:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZJx8sBW/QPOBswNF@google.com> <CAADnVQJ4_wg9BqO2+VK_GfynjF7HEeer96=NRGsz5XyhbJDfsQ@mail.gmail.com>
 <CALOAHbC-MgeaO8k+QUvYZr-+nqxK1iXa2jAg1ePOnNnLR1CZ7g@mail.gmail.com>
In-Reply-To: <CALOAHbC-MgeaO8k+QUvYZr-+nqxK1iXa2jAg1ePOnNnLR1CZ7g@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 19 Jul 2023 15:32:16 +0800
Message-ID: <CADxym3Yd4vDrPhq8dxBOqC-kE62u4fXiV8kL0A4K2qcSaBJTZw@mail.gmail.com>
Subject: Re: [ANN] bpf development stats for 6.5
To: Yafang Shao <laoar.shao@gmail.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 10:29=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> On Wed, Jul 19, 2023 at 8:18=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Jun 28, 2023 at 11:32=E2=80=AFAM Stanislav Fomichev <sdf@google=
.com> wrote:
> > >
......
> >
> >
> > Thank you Stanislav for running the stats. Much appreciate it.
> >
> > The folks with negative scores please work on improving them.
> > Negative score =3D=3D takers, not givers.
> > The community is healthy when people give and take.
> > For every patch sent please take time to review somebody else's patch.
> >
> > https://nesslabs.com/taker-giver-matcher
>
> I thought it is the reviewer's responsibility to review :)
> Now I understand it, I will take time to help review.
> Thanks for your reminder.

Me too! I thought that I wasn't qualified to review and
only the official reviewers can. I've always been curious
if I could review other people's code. I'll try to be a
reviewer too.

Thanks!
Menglong Dong

