Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB23E65F78
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2019 20:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfGKScY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Jul 2019 14:32:24 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36834 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbfGKScX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Jul 2019 14:32:23 -0400
Received: by mail-qk1-f195.google.com with SMTP id g18so4426024qkl.3
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2019 11:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=brXnLlJzUa8KE6aZJSHo3ySoGB6IM5nDo/myyMy+zoc=;
        b=CWkT3OyyoCKtzXiT6jqNKwmJp0C4SpO906/1bxPEGUVcYmZxAlJXF1zUnzK4BYvoPR
         HR3WFUmojhAIIytkm4kSLygD9T5q1IdlHOqbaMqffO5w1jDzc6ZacruLNmmBgHPw4ylT
         8+NNfdxs5h/3aYNkkZT8FQ6wXGMEksnONrEP7/jVkOtcz/fvlX9tCjQnMPkmdypcuLhR
         DnBE1+46vLz/0iL32aS26lrxkdBKG1CqqZBsSKDpS9BRgyn+puUXVr2tG1A3Gauf0Cob
         /Dm/oEjfRReg9yAbTvQLuTqk88Qiz47yt6cMjvTrdhv+tT4f2HmI4gSMvVYk/ctjxfmp
         m2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=brXnLlJzUa8KE6aZJSHo3ySoGB6IM5nDo/myyMy+zoc=;
        b=VJxohvEcXrY09Bdxw1aYFkcyjHquWsD//9YIbgBKEkS4ne60lOLJeuNxlA0P4OlGz8
         vjilvhNpSxktOP0zyYvZC4BGhvjs2fycs0mIDq7Ow8dosshlJX4HNvsXwk0KbFeJHVKB
         L2W2N3jQMhb+5FhIq/GGsa54biZGRiCRxwigCUqTwqu9mZaguyUXl/Vjj5gVVrPu2unv
         gL4a84ou0bzGEEaS6NpphshKQv5RzKpdxxrDuXtxqxZgXSUdPfKwx1tLesc2Z78TgqsK
         JPX66H4PLk67PElwyPfo2aHeLj6VysR49Qxkr9XFaBI5pYkEv3fmQFbtgAcYvuSORcuK
         xnxg==
X-Gm-Message-State: APjAAAX2Fjn7FVdKfNNsDBWnoEDce9Kpke5ZtcRf2sDj32SDUeKsnj8m
        9l3rDG8OpOY+cEzF9t67uH/ffw==
X-Google-Smtp-Source: APXvYqz93+kwEiH1MWilqXEE5vsbkKIjnJK3n105gpVd4Ovu2MgFRwCkRibC2kKO6TbLVUBHuozn/w==
X-Received: by 2002:a05:620a:4c8:: with SMTP id 8mr2884844qks.366.1562869942821;
        Thu, 11 Jul 2019 11:32:22 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y42sm3595725qtc.66.2019.07.11.11.32.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 11:32:22 -0700 (PDT)
Date:   Thu, 11 Jul 2019 11:32:18 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        edumazet@google.com, bpf@vger.kernel.org
Subject: Re: [bpf PATCH v2 2/6] bpf: tls fix transition through disconnect
 with close
Message-ID: <20190711113218.2f0b8c1f@cakuba.netronome.com>
In-Reply-To: <5d276814a76ad_698f2aaeaaf925bc8a@john-XPS-13-9370.notmuch>
References: <156261310104.31108.4569969631798277807.stgit@ubuntu3-kvm1>
        <156261324561.31108.14410711674221391677.stgit@ubuntu3-kvm1>
        <20190709194525.0d4c15a6@cakuba.netronome.com>
        <5d255dececd33_1b7a2aec940d65b45@john-XPS-13-9370.notmuch>
        <20190710123417.2157a459@cakuba.netronome.com>
        <20190710130411.08c54ddd@cakuba.netronome.com>
        <5d276814a76ad_698f2aaeaaf925bc8a@john-XPS-13-9370.notmuch>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 11 Jul 2019 09:47:16 -0700, John Fastabend wrote:
> Jakub Kicinski wrote:
> > On Wed, 10 Jul 2019 12:34:17 -0700, Jakub Kicinski wrote: =20
> > > > > > +		if (sk->sk_prot->unhash)
> > > > > > +			sk->sk_prot->unhash(sk);
> > > > > > +	}
> > > > > > +
> > > > > > +	ctx =3D tls_get_ctx(sk);
> > > > > > +	if (ctx->tx_conf =3D=3D TLS_SW || ctx->rx_conf =3D=3D TLS_SW)
> > > > > > +		tls_sk_proto_cleanup(sk, ctx, timeo); =20
> >=20
> > Do we still need to hook into unhash? With patch 6 in place perhaps we
> > can just do disconnect =F0=9F=A5=BA =20
>=20
> ?? "can just do a disconnect", not sure I folow. We still need unhash
> in cases where we have a TLS socket transition from ESTABLISHED
> to LISTEN state without calling close(). This is independent of if
> sockmap is running or not.
>=20
> Originally, I thought this would be extremely rare but I did see it
> in real applications on the sockmap side so presumably it is possible
> here as well.

Ugh, sorry, I meant shutdown. Instead of replacing the unhash callback
replace the shutdown callback. We probably shouldn't release the socket
lock either there, but we can sleep, so I'll be able to run the device
connection remove callback (which sleep).

> > cleanup is going to kick off TX but also:
> >=20
> > 	if (unlikely(sk->sk_write_pending) &&
> > 	    !wait_on_pending_writer(sk, &timeo))
> > 		tls_handle_open_record(sk, 0);
> >=20
> > Are we guaranteed that sk_write_pending is 0?  Otherwise
> > wait_on_pending_writer is hiding yet another release_sock() :( =20
>=20
> Not seeing the path to release_sock() at the moment?
>=20
>    tls_handle_open_record
>      push_pending_record
>       tls_sw_push_pending_record
>         bpf_exec_tx_verdict

wait_on_pending_writer
  sk_wait_event
    release_sock

> If bpf_exec_tx_verdict does a redirect we could hit a relase but that
> is another fix I have to get queued up shortly. I think we can fix
> that in another series.

Ugh.
