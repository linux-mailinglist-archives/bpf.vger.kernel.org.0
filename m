Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1FD8664DD
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2019 05:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfGLDQi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Jul 2019 23:16:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37151 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfGLDQi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Jul 2019 23:16:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so4059174plr.4
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2019 20:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=L2ZlgrviDZAu+KG18DKdk+AEwyCr1OMiF1fBg7CHNjo=;
        b=aB8qxRhhcE7/K5/38IozESLERV0k8+CAR+CZ5yH+nE45g9y7utpjm2LGJsc0G/GJny
         GgEQt9m6fmeGeBLIdyp3C0dVMKo5BhvuicSktgyBwsLilaC6XRakEsL7CAnXb+8KBPvO
         rZf3qxXowgv2RQQvc06Aamgkf9K/E4N7grMHrF2LDXycXc0DjxMt5ZzngFdbjh0NPtce
         hWPofTOu2VOxJ2z4PW+fZft7TsHxwn0ybnWU+n25yAoAVk9OeoC87qdp4x9T4Yh9gxXX
         D06hbonLKcLwYfLw8aizWTMEWYY82/mIB+vuaFSqC1Cwj4odsppKr2VNvtU58bQr8ldM
         FyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=L2ZlgrviDZAu+KG18DKdk+AEwyCr1OMiF1fBg7CHNjo=;
        b=T5T8x8SKZ9RzSXlBfZZuM9MsRxPwd8I7NRr5EqJfIzI9WMbNtoepOn6vfAD7rSfXfW
         Tfrp4MDewfTXBu8/n0PQbIXPtlFz8Kgw6NssrKno3Lkn5MvQn9DpOa3VMe18KpdzuPG1
         pRoiVs9aXbLXU6m+UkStIcI5zMQ6JLGa7ewZdU1xiXHemLe9XeS4Wi+JUhNWcKW6SLGO
         jWjGojAvuGExKUHpm74UNh0yCkm84PcTW1dri5mVgB+u3FnlrMg7+8GDwA+OX6joM3KQ
         K3deR3GHp0vSUyYPR+lKVaRjrbnHbF+hN/Epq3UbqkZhoXgCikcNSyG3dcFKAoam9CJo
         dePA==
X-Gm-Message-State: APjAAAW7uKwezFdjch1t8f9dECNZCJXFiVpzUC6t9SyXxDZBEeMb7k7Q
        jIhmbI5Owc4EfjKvHzEN5bqYrw==
X-Google-Smtp-Source: APXvYqzUeXIg5BMgJdpJ518ux2Do8xqdnTS13t0+Ilsm/IaZdDiJYgYkRjMlBrqylXVi44kzASPy4Q==
X-Received: by 2002:a17:902:2be6:: with SMTP id l93mr8711188plb.0.1562901397369;
        Thu, 11 Jul 2019 20:16:37 -0700 (PDT)
Received: from cakuba.netronome.com (c-71-204-185-212.hsd1.ca.comcast.net. [71.204.185.212])
        by smtp.gmail.com with ESMTPSA id i14sm12405404pfk.0.2019.07.11.20.16.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 20:16:37 -0700 (PDT)
Date:   Thu, 11 Jul 2019 20:16:33 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        edumazet@google.com, bpf@vger.kernel.org
Subject: Re: [bpf PATCH v2 2/6] bpf: tls fix transition through disconnect
 with close
Message-ID: <20190711201633.552292e6@cakuba.netronome.com>
In-Reply-To: <5d27a9627b092_19762abc80ff85b856@john-XPS-13-9370.notmuch>
References: <156261310104.31108.4569969631798277807.stgit@ubuntu3-kvm1>
        <156261324561.31108.14410711674221391677.stgit@ubuntu3-kvm1>
        <20190709194525.0d4c15a6@cakuba.netronome.com>
        <5d255dececd33_1b7a2aec940d65b45@john-XPS-13-9370.notmuch>
        <20190710123417.2157a459@cakuba.netronome.com>
        <20190710130411.08c54ddd@cakuba.netronome.com>
        <5d276814a76ad_698f2aaeaaf925bc8a@john-XPS-13-9370.notmuch>
        <20190711113218.2f0b8c1f@cakuba.netronome.com>
        <5d27a9627b092_19762abc80ff85b856@john-XPS-13-9370.notmuch>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 11 Jul 2019 14:25:54 -0700, John Fastabend wrote:
> Jakub Kicinski wrote:
> > On Thu, 11 Jul 2019 09:47:16 -0700, John Fastabend wrote: =20
> > > Jakub Kicinski wrote: =20
> > > > On Wed, 10 Jul 2019 12:34:17 -0700, Jakub Kicinski wrote:   =20
> > > > > > > > +		if (sk->sk_prot->unhash)
> > > > > > > > +			sk->sk_prot->unhash(sk);
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	ctx =3D tls_get_ctx(sk);
> > > > > > > > +	if (ctx->tx_conf =3D=3D TLS_SW || ctx->rx_conf =3D=3D TLS=
_SW)
> > > > > > > > +		tls_sk_proto_cleanup(sk, ctx, timeo);   =20
> > > >=20
> > > > Do we still need to hook into unhash? With patch 6 in place perhaps=
 we
> > > > can just do disconnect =F0=9F=A5=BA   =20
> > >=20
> > > ?? "can just do a disconnect", not sure I folow. We still need unhash
> > > in cases where we have a TLS socket transition from ESTABLISHED
> > > to LISTEN state without calling close(). This is independent of if
> > > sockmap is running or not.
> > >=20
> > > Originally, I thought this would be extremely rare but I did see it
> > > in real applications on the sockmap side so presumably it is possible
> > > here as well. =20
> >=20
> > Ugh, sorry, I meant shutdown. Instead of replacing the unhash callback
> > replace the shutdown callback. We probably shouldn't release the socket
> > lock either there, but we can sleep, so I'll be able to run the device
> > connection remove callback (which sleep).
>=20
> ah OK seems doable to me. Do you want to write that on top of this
> series? Or would you like to push it onto your branch and I can pull
> it in push the rest of the patches on top and send it out? I think
> if you can get to it in the next few days then it makes sense to wait.

Mm.. perhaps its easiest if we forget about HW for now and get SW=20
to work? Once you get the SW to 100% I can probably figure out what=20
to do for HW, but I feel like we got too many moving parts ATM.

> I can't test the hardware side so probably makes more sense for
> you to do it if you can.
>
> > > > cleanup is going to kick off TX but also:
> > > >=20
> > > > 	if (unlikely(sk->sk_write_pending) &&
> > > > 	    !wait_on_pending_writer(sk, &timeo))
> > > > 		tls_handle_open_record(sk, 0);
> > > >=20
> > > > Are we guaranteed that sk_write_pending is 0?  Otherwise
> > > > wait_on_pending_writer is hiding yet another release_sock() :(   =20
> > >=20
> > > Not seeing the path to release_sock() at the moment?
> > >=20
> > >    tls_handle_open_record
> > >      push_pending_record
> > >       tls_sw_push_pending_record
> > >         bpf_exec_tx_verdict =20
> >=20
> > wait_on_pending_writer
> >   sk_wait_event
> >     release_sock
> >  =20
>=20
> ah OK. I'll check on sk_write_pending...
