Return-Path: <bpf+bounces-9352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E549A79429E
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 20:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9471C209D5
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 18:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8EE11197;
	Wed,  6 Sep 2023 18:00:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7201094E;
	Wed,  6 Sep 2023 18:00:43 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E1119AA;
	Wed,  6 Sep 2023 11:00:41 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-501be2d45e0so56765e87.3;
        Wed, 06 Sep 2023 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694023240; x=1694628040; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jBgTcuweOSdxAt78rjk31W7FbaJq9OxXi+LN0LW4j3I=;
        b=Lv5V9z7uwmmlxTfYD4ZbjUpaw+YNtKchGAfdP+y4aQqb8eCVQTA71KUWQjzeqLBBdK
         GUeDEh7kAYjo59ZcYfbDvXRz7pTQ97HnNdrf+9at75ajulwMcvfupD6WidABMXEBBNBN
         oTEmLn9eJBOWZaSsidNxyqAHqvXfuypkP0E8ejQuwUYqEGRhETsXazJamhh/w0XH0E+J
         OWh47+6imN2ytXGHgBKZDVZbBFcIzJ0XIpgk0PeGvLUVR8Hj5qdu4nohkfxUJl3NWAfR
         /pb0wJZpBq+3NDh1NvFCSUmLkVZBbmCmJdwf4lQy0Jse8XhaUaQ/82K3gh2Ld84WYgyb
         i4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694023240; x=1694628040;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBgTcuweOSdxAt78rjk31W7FbaJq9OxXi+LN0LW4j3I=;
        b=jsencCDufSH8Zne3H3/llbllIE5oqemUmpnzS0vDGwtsmSvgdnNz8gY5ujAfsE1bsG
         xz1YbUmTSuOIi7SzL29ey1KpiQfaJ+H6Jn5nurn7eu2uhE0kIUehx0Qt1xQyuDdNkR52
         ZdD4G6HRWjPWp/ejzBREIQMeGYsooqPcCWK7OT4UBCX5PHfk+svjWKCjPs3/TmuFDCvH
         edj1iMk6ZDoXW2nI2D7wK7Mie8sar6zqkNRZuo4ok47gSG5fxDJjKw/KilbysOJFG0xr
         PRNziZbfZNb6fHRTdjkLozo8X99g/KLf4GHufG9teyYLsvzmvG0GjJ1G6pAhOEyjDmt7
         feQw==
X-Gm-Message-State: AOJu0YzSL+5BQF6a1H/c0k7Qe+gbLmUdRYsn3YKIvP5VRJAwUjTj0Ctn
	1/hMsbMIP0/ASX2D37jpP5g=
X-Google-Smtp-Source: AGHT+IFkyU7EgVhPjzf6MonOxLpVL2r9D5B+9nJyXSdu3smQNk5NapaZVQ+wMSlMQgeEvxexfLwn7w==
X-Received: by 2002:a05:6512:324e:b0:500:94c3:8e3b with SMTP id c14-20020a056512324e00b0050094c38e3bmr2610126lfr.57.1694023239455;
        Wed, 06 Sep 2023 11:00:39 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ay9-20020a056402202900b0052a198d8a4dsm8715532edb.52.2023.09.06.11.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:00:38 -0700 (PDT)
Message-ID: <c7f9db8879a9342080e74b9270e9925132b02f59.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] general protection fault in
 bpf_prog_offload_verifier_prep
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot <syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com>, 
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net,  davem@davemloft.net, haoluo@google.com,
 hawk@kernel.org, john.fastabend@gmail.com,  jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org,  martin.lau@linux.dev,
 netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Date: Wed, 06 Sep 2023 21:00:37 +0300
In-Reply-To: <20230906075730.6d61420a@kernel.org>
References: <000000000000d97f3c060479c4f8@google.com>
	 <ef4b96a75ff8fa87a82a35d4d050338d0bd9cce1.camel@gmail.com>
	 <f3eacce9566d14141cb591dc8364123b809841cb.camel@gmail.com>
	 <20230906075730.6d61420a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-09-06 at 07:57 -0700, Jakub Kicinski wrote:
> On Wed, 06 Sep 2023 16:50:23 +0300 Eduard Zingerman wrote:
> > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > index 3e4f2ec1af06..302e38bffffa 100644
> > --- a/kernel/bpf/offload.c
> > +++ b/kernel/bpf/offload.c
> > @@ -199,12 +199,11 @@ static int __bpf_prog_dev_bound_init(struct bpf_p=
rog *prog, struct net_device *n
> >         offload->netdev =3D netdev;
> > =20
> >         ondev =3D bpf_offload_find_netdev(offload->netdev);
> > +       if (bpf_prog_is_offloaded(prog->aux) && (!ondev || !ondev->offd=
ev)) {
> > +               err =3D -EINVAL;
> > +               goto err_free;
> > +       }
> >         if (!ondev) {
> > -               if (bpf_prog_is_offloaded(prog->aux)) {
> > -                       err =3D -EINVAL;
> > -                       goto err_free;
> > -               }
> > -
> >                 /* When only binding to the device, explicitly
> >                  * create an entry in the hashtable.
> >                  */
>=20
> LGTM, FWIW.

Thanks, I'll wrap it up as a proper patch with a test.

>=20
> > With the following reasoning: for offloaded programs offload device
> > should exist and it should not be a fake device create in !ondev branch=
.
> >=20
> > Stanislav, could you please take a look? I think this is related to com=
mit:
> > 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")


