Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E937364CD7
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2019 21:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfGJTeZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Jul 2019 15:34:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43471 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfGJTeZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Jul 2019 15:34:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id w17so3731650qto.10
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2019 12:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=wlhbsNW/banVUKhHZoIKeUuXO6clzHQUjaWmMYc/4+A=;
        b=JlHjCh9aIpjI6KP1Kq4TFCc4F77E5PO1ixjdqLR3OAmH6RRat6Rzt/gXJN1VzGklOK
         Xrr8KZ3wgRH5PR/zpqoHGnVsEHXi5masJfqIdkKQpU0LtxcsxNiso8QDG5aY2lPLG2Sh
         /MuHU6j8+lzMP/nOqjdE5NWKk0fkg6U9d1plX6yhI8id0uwrqJmUL+snXS2t5gaV4est
         q+PLc66YuspjRsl8Qzr0dioxWxpIJ6Mh52YcizrSEG7uey4WpB92cGY5ao7czDKomaur
         eFLAzhaFK7HcPqe64/Ac8qdqf/iPe55o9308B9ATKptS5AKZZkk5qKYDACe9vv8Z+pGH
         0/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=wlhbsNW/banVUKhHZoIKeUuXO6clzHQUjaWmMYc/4+A=;
        b=ISdwYKNEWh0HfTFQ8pE1k6LZisk900la5MNzk1LRxWPDulQcgZ+d9+flxN7WuajWxu
         NvIW2oArZgSoDlgzfShYWBw8wQKnTCoKnSB97nNYN5Oh7Im6uRToqEYsdDjdzG3lYCRL
         Aq/EgF86YT26ygO3hPwMPAna4+OtrzCR5FP/yDuqRqlntg0jtRn1oWbBzNuLa1kYeAjb
         V0uO1tJEYJnQW02KJeDhv2x6P2QTvC0oc4HRQ+oNIfLXdaaURNhcuAoN4D+OTkOgSIoJ
         STCE8m/Y602TaUK5rfasVMPWLsamG+GGxQbnQczqqdvWy7m++ME9ni5Gwi2XYlDLbjOO
         KkGA==
X-Gm-Message-State: APjAAAVQJtFjuV6DQw4DyRDPX+OtH5aUhl4xLG8w3aiJlPWi1aI6OZP+
        Ger4a0GEGs9BA/Xl+D3uLnuGLA==
X-Google-Smtp-Source: APXvYqy+Vgzt+tf4L9hycTHbi3PG+NO5EfuSIrGV7Ub8m7gcYUyCXklGxMBjpvCVUfDDRB1h1CNaHw==
X-Received: by 2002:a0c:ffc5:: with SMTP id h5mr26469990qvv.43.1562787264348;
        Wed, 10 Jul 2019 12:34:24 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id a6sm1387253qth.76.2019.07.10.12.34.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 12:34:24 -0700 (PDT)
Date:   Wed, 10 Jul 2019 12:34:17 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        edumazet@google.com, bpf@vger.kernel.org
Subject: Re: [bpf PATCH v2 2/6] bpf: tls fix transition through disconnect
 with close
Message-ID: <20190710123417.2157a459@cakuba.netronome.com>
In-Reply-To: <5d255dececd33_1b7a2aec940d65b45@john-XPS-13-9370.notmuch>
References: <156261310104.31108.4569969631798277807.stgit@ubuntu3-kvm1>
        <156261324561.31108.14410711674221391677.stgit@ubuntu3-kvm1>
        <20190709194525.0d4c15a6@cakuba.netronome.com>
        <5d255dececd33_1b7a2aec940d65b45@john-XPS-13-9370.notmuch>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 09 Jul 2019 20:39:24 -0700, John Fastabend wrote:
> Jakub Kicinski wrote:
> > On Mon, 08 Jul 2019 19:14:05 +0000, John Fastabend wrote:  
> > > @@ -287,6 +313,27 @@ static void tls_sk_proto_cleanup(struct sock *sk,
> > >  #endif
> > >  }
> > >  
> > > +static void tls_sk_proto_unhash(struct sock *sk)
> > > +{
> > > +	struct inet_connection_sock *icsk = inet_csk(sk);
> > > +	long timeo = sock_sndtimeo(sk, 0);
> > > +	struct tls_context *ctx;
> > > +
> > > +	if (unlikely(!icsk->icsk_ulp_data)) {  
> > 
> > Is this for when sockmap is stacked on top of TLS and TLS got removed
> > without letting sockmap know?  
> 
> Right its a pattern I used on the sockmap side and put here. But
> I dropped the patch to let sockmap stack on top of TLS because
> it was more than a fix IMO. We could probably drop this check on
> the other hand its harmless.

I feel like this code is pretty complex I struggle to follow all the
paths, so perhaps it'd be better to drop stuff that's not necessary 
to have a clearer picture.

> > > +		if (sk->sk_prot->unhash)
> > > +			sk->sk_prot->unhash(sk);
> > > +	}
> > > +
> > > +	ctx = tls_get_ctx(sk);
> > > +	if (ctx->tx_conf == TLS_SW || ctx->rx_conf == TLS_SW)
> > > +		tls_sk_proto_cleanup(sk, ctx, timeo);
> > > +	icsk->icsk_ulp_data = NULL;  
> > 
> > I think close only starts checking if ctx is NULL in patch 6.
> > Looks like some chunks of ctx checking/clearing got spread to
> > patch 1 and some to patch 6.  
> 
> Yeah, I thought the patches were easier to read this way but
> maybe not. Could add something in the commit log.

Ack! Let me try to get a full grip of patches 2 and 6 and come back 
to this.

> > > +	tls_ctx_free_wq(ctx);
> > > +
> > > +	if (ctx->unhash)
> > > +		ctx->unhash(sk);
> > > +}
> > > +
> > >  static void tls_sk_proto_close(struct sock *sk, long timeout)
> > >  {
> > >  	struct tls_context *ctx = tls_get_ctx(sk);  
