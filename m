Return-Path: <bpf+bounces-10862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 001737AE99A
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 11:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 30BA5281744
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 09:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8808E1A262;
	Tue, 26 Sep 2023 09:54:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7683134D1;
	Tue, 26 Sep 2023 09:54:50 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22340BE;
	Tue, 26 Sep 2023 02:54:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27758c8f62aso2798044a91.0;
        Tue, 26 Sep 2023 02:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695722087; x=1696326887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5dnCUvijMsimGrTWPpfu5Agx/K3HlKGuGAYzpWTEyOs=;
        b=TsfH/6QQE4Ec2oLmj0QfqoAZ1tydrsONkUzIC/NzQX8dtylhKmYZDRHfjYgchx5hBp
         ndhfI3g/hhHmcPCjQH5OWfzcOsQjhYyKErfbUVykLhWL0jPyb5noOk0J0XtEv9Z2A1jc
         FJh49ar4mv54Yxx549dnOdswvCqYcCeLIRzqSxSsgioyjxY+ZltqT3F3w+h1xB0/tLF7
         G1pzChzAXZOveaI4M1D11khcPG/L4rizJ7QkuBjFUNsdw/eHKmbA5Q1GWPbXyhaHV1G1
         P2OBbLgGPaKE2lKOv3/LCCt4uBYOsY6cFpxUVWc+6481kcD9oDewUh4lXikzf/t376Pm
         kP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695722087; x=1696326887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dnCUvijMsimGrTWPpfu5Agx/K3HlKGuGAYzpWTEyOs=;
        b=aW59GIb1GISKY486pxNhO6aTJkpfgmUOXxCZoyBDnR2a1NOZgRk280G54m92AMJ8El
         75ruufjz0MnOo/DIxGPdgjTPPed9a7Balt1lvyY9JM5vKbQzfJknrypBB8GJq0QODRCc
         0xGFuRoinvaOo81s41MNhuDPe77Oc20hwIvTKPlkvZF4FQ4NyvI0rs2Nt3rqPahf9mGL
         ygYSMjFUjy1oJ3IYm2jAW5iq/2R5BaWxlH0kMM5Vypo99UkYEjE0xNtMk5wLV2SJB47L
         uGZaKefVvm55tk8SBL1yeDNvR0SLQexnm0njFWKNDN0I7qiPxvSjvDr/FkuvO5LG5sRb
         tz0A==
X-Gm-Message-State: AOJu0YwRcNCmeegEKwDppnAiXI1e8t/52hnhxQuOhLOp053d2v7w/Zyz
	vzsGfj9iXJE4Qq/MUhgX10k4YfAT4b1zHZL0d9NvXFsmy1u6tA==
X-Google-Smtp-Source: AGHT+IGqgqY7gPaWD8IB1m6kzpOSXZFtxJY0UbbwDIP1TXvWNzPtGlJv5iI6HrxgQw0AQqQSvihy5aN2SIsdyluNFnA=
X-Received: by 2002:a17:90b:3ec5:b0:269:5adb:993 with SMTP id
 rm5-20020a17090b3ec500b002695adb0993mr5938269pjb.22.1695722087455; Tue, 26
 Sep 2023 02:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921120913.566702-5-daan.j.demeyer@gmail.com> <20230925221241.2345534-1-jrife@google.com>
In-Reply-To: <20230925221241.2345534-1-jrife@google.com>
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Date: Tue, 26 Sep 2023 11:54:36 +0200
Message-ID: <CAO8sHc=K1042abA1AVPA8Dn_cEt7-jGQgrUHSWFiUE9KXy5Chg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/9] bpf: Implement cgroup sockaddr hooks for
 unix sockets
To: Jordan Rife <jrife@google.com>
Cc: bpf@vger.kernel.org, kernel-team@meta.com, martin.lau@linux.dev, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > @@ -1919,6 +1936,13 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
> >               goto out;
> >
> >       if (msg->msg_namelen) {
> > +             err = BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk,
> > +                                                         msg->msg_name,
> > +                                                         &msg->msg_namelen,
> > +                                                         NULL);
> > +             if (err)
> > +                     goto out;
> > +
> >               err = unix_validate_addr(sunaddr, msg->msg_namelen);
> >               if (err)
> >                       goto out;
>
>
> Just an FYI, I /think/ this is going to introduce a bug similar to the one I'm
> addressing in my patch here:
>
> - https://lore.kernel.org/netdev/20230921234642.1111903-2-jrife@google.com/
>
> With this change, callers to sock_sendmsg() in kernel space would see their
> value of msg->msg_namelen change if they are using Unix sockets. While it's
> unclear if there are any real systems that would be impacted, it can't hurt to
> insulate callers from these kind of side-effects. I can update my my patch to
> account for possible changes to msg_namelen.

That would be great! I think it makes sense to apply the same concept to unix
sockets so insulating changes to the msg_namelen seems like the way to go.

> Also, with this patch series is it possible for AF_INET BPF hooks (connect4,
> sendmsg4, connect6, etc.) to modify the address length?

This is not yet allowed. We only allow changing the unix sockaddr length at the
moment. Maybe in the future we'd want to allow changing INET6 addr lengths
as well but currently we don't allow this.


On Tue, 26 Sept 2023 at 00:13, Jordan Rife <jrife@google.com> wrote:
>
> > @@ -1919,6 +1936,13 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
> >               goto out;
> >
> >       if (msg->msg_namelen) {
> > +             err = BPF_CGROUP_RUN_PROG_UNIX_SENDMSG_LOCK(sk,
> > +                                                         msg->msg_name,
> > +                                                         &msg->msg_namelen,
> > +                                                         NULL);
> > +             if (err)
> > +                     goto out;
> > +
> >               err = unix_validate_addr(sunaddr, msg->msg_namelen);
> >               if (err)
> >                       goto out;
>
>
> Just an FYI, I /think/ this is going to introduce a bug similar to the one I'm
> addressing in my patch here:
>
> - https://lore.kernel.org/netdev/20230921234642.1111903-2-jrife@google.com/
>
> With this change, callers to sock_sendmsg() in kernel space would see their
> value of msg->msg_namelen change if they are using Unix sockets. While it's
> unclear if there are any real systems that would be impacted, it can't hurt to
> insulate callers from these kind of side-effects. I can update my my patch to
> account for possible changes to msg_namelen.
>
> Also, with this patch series is it possible for AF_INET BPF hooks (connect4,
> sendmsg4, connect6, etc.) to modify the address length?

