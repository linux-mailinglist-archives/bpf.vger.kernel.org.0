Return-Path: <bpf+bounces-9362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 692F179432E
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 20:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A8F1C20B6D
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 18:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAE2111A7;
	Wed,  6 Sep 2023 18:35:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E106AB1
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 18:35:31 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF3226A6
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 11:35:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d745094c496so131490276.1
        for <bpf@vger.kernel.org>; Wed, 06 Sep 2023 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694025281; x=1694630081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hJltTaOgL5jEO4WF+/Vz9Gw2r17/bIVfgXIk3gpklQ0=;
        b=ZBkElbtxY8+7TLIrlgLpWVdSV0K+mkpw6JYmfN41F7Wn3XAvD7IQoOx0RxFQ9erVNR
         3ReSgxlDWPfPbH14qJ+zNpVtJgm7a7lpQ73zeKvFs567ceYu+cdSOjrTwx4lycdzEMky
         ufE0kTwnCdtn8jLEohVW+ULhALXbTAD+PAkuhiec5/ScwsUp7AiBJVDG6mEOQ7sLVvw4
         aNAa1b8XdFyRu87ho7hFb2nVVdKjB8NVrQNZdZkUBTL+aFOiC4bQOlcTJyIocH60pqyD
         jNBtF0Rxt2DYWoCMfKZc4ayXjmJz/cF2nBvxXgAdUAbdyyfpl7Jh/ngPtV9CaqDpt6gi
         XLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694025281; x=1694630081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJltTaOgL5jEO4WF+/Vz9Gw2r17/bIVfgXIk3gpklQ0=;
        b=ZAPrj2ZNvnENTkgUby5hBJlbCHuRQ5T1KQWwGQQX7HWfZ4MyAy7M42VfVLBQYx6217
         iY5pR8rleHZcS19cjd98efrlomKIuzd0z5f3a1vTf4+NyNZILkpCWKuqFkwPYbzobYuK
         wZyX2fDmNN6kjB7Vlgdaezf9quFLCX1VqSl8ziHZBZ13Mv4cggGngGUhCujjlJl+cvXK
         T4mduL53IH5XbavdcxLf/EMJRI+rKz8WTNw5+olDrP4krCLzBHoilzA5tovc1DUVszyK
         M/71dYKbpWM/PwKzcPWwSzdHGezxWCnP4coRrR+cC4ruo8lhYUhFT1EqwZWwdF83e0Tv
         qFvw==
X-Gm-Message-State: AOJu0YwbM8o8ILP2ljWzxuEkylcBcH7NmuFZKwW0r/2MwQoTeP5sqtrx
	4RraaMYhaxKWBgx5dknfAMskRGQ=
X-Google-Smtp-Source: AGHT+IFhuu2m/WV5JV2cBMSFsDFG5jxjHWU+oNXD57WJzhNfO2v6ypwJ2+8P7l5k9Yg1Ux0KHyvAtdw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:e0c7:0:b0:d63:8364:328 with SMTP id
 x190-20020a25e0c7000000b00d6383640328mr424401ybg.5.1694025280934; Wed, 06 Sep
 2023 11:34:40 -0700 (PDT)
Date: Wed, 6 Sep 2023 11:34:38 -0700
In-Reply-To: <c7f9db8879a9342080e74b9270e9925132b02f59.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <000000000000d97f3c060479c4f8@google.com> <ef4b96a75ff8fa87a82a35d4d050338d0bd9cce1.camel@gmail.com>
 <f3eacce9566d14141cb591dc8364123b809841cb.camel@gmail.com>
 <20230906075730.6d61420a@kernel.org> <c7f9db8879a9342080e74b9270e9925132b02f59.camel@gmail.com>
Message-ID: <ZPjGPjbxazLkRkEW@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_prog_offload_verifier_prep
From: Stanislav Fomichev <sdf@google.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	syzbot <syzbot+291100dcb32190ec02a8@syzkaller.appspotmail.com>, andrii@kernel.org, 
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 09/06, Eduard Zingerman wrote:
> On Wed, 2023-09-06 at 07:57 -0700, Jakub Kicinski wrote:
> > On Wed, 06 Sep 2023 16:50:23 +0300 Eduard Zingerman wrote:
> > > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > > index 3e4f2ec1af06..302e38bffffa 100644
> > > --- a/kernel/bpf/offload.c
> > > +++ b/kernel/bpf/offload.c
> > > @@ -199,12 +199,11 @@ static int __bpf_prog_dev_bound_init(struct bpf_prog *prog, struct net_device *n
> > >         offload->netdev = netdev;
> > >  
> > >         ondev = bpf_offload_find_netdev(offload->netdev);
> > > +       if (bpf_prog_is_offloaded(prog->aux) && (!ondev || !ondev->offdev)) {
> > > +               err = -EINVAL;
> > > +               goto err_free;
> > > +       }
> > >         if (!ondev) {
> > > -               if (bpf_prog_is_offloaded(prog->aux)) {
> > > -                       err = -EINVAL;
> > > -                       goto err_free;
> > > -               }
> > > -
> > >                 /* When only binding to the device, explicitly
> > >                  * create an entry in the hashtable.
> > >                  */
> > 
> > LGTM, FWIW.
> 
> Thanks, I'll wrap it up as a proper patch with a test.

LGTM as well, thanks!

