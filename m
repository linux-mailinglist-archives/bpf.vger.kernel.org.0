Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1331064CD8
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2019 21:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfGJTfu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Jul 2019 15:35:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44229 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfGJTfu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Jul 2019 15:35:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id 44so3719970qtg.11
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2019 12:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=7Uvy3l/SCj5opSeoxpQCcd3/N/8+Mo8HLVH78tJW88o=;
        b=R9ETkMALtd5PMJChO5nx+m38QKp54jzAE30LJceCU+2Y20xYEzASKc95Lwu+NPA4EZ
         Ib7PHW6FdBi+eorNYc/dalXmYNbmVRIwd9cUPXYLISWUjXeoQkVMb0QxaM3HjspWaLYb
         p+WS5uGGCsXGKOdiW9faGfK0DOe8zFY3Yxil1lpuHacmjSxduFsCC2/dX/JdGaU/CmeY
         4yBW3iKbxivITMod/kJGpHnCTRWYfRCrbU8l4VBkPcJABMN8Sww1vu9wp1QnnoDCmTRv
         02NNcDGMRsQXWQx/bNaLtTQerMmYQZWZNDtJ6cLr9XeDiI75EGn6cwWscS9k0YU/jhSc
         2HYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=7Uvy3l/SCj5opSeoxpQCcd3/N/8+Mo8HLVH78tJW88o=;
        b=uQen0XruUpC+TibdQlW+vWl/ESRozUo55RrkIV3TNfvyCQ/jTitoSCbLEfAt1PPVHE
         UZXB40bPLE821RxoQg9DlvRVPm/WqxfzMz3eR0FE0XrCbHpdZpFbeZL1/gkjXp54fHa4
         Nnm1PvIm6K1lqwfWwS6206T7bZq4qIXzfz4koR+Ahcbnn5IxxMwVpZVsynzg3QqVJbsN
         8/scSkZFYf6qGNPY3XNDp3QWgqsvrP9wLdyl5bh1JRtcPjgklLGqrxMu32WTx7C8m0QJ
         XEsBP9Y9d6nF0NN5mmY2FYPAK+eDSfPU/jMvEc+ggBZOvbW446m+6ArNhBtHHdBTCNhl
         2J6w==
X-Gm-Message-State: APjAAAVH2c38CJVuaVkLrK7sI0k9B/cEo18Du/mHefA29h25i6rkI+xg
        HOynUyOIPOqZHKwGAjnyLKKqGA==
X-Google-Smtp-Source: APXvYqzhfPrFSOXxtyNDKG6hNCtVirdaghjZfAX/hMCDZnE3oH3YERKRAKV6PCWZV/YcNGhxpRrHNQ==
X-Received: by 2002:ac8:6c59:: with SMTP id z25mr26835619qtu.43.1562787349251;
        Wed, 10 Jul 2019 12:35:49 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id e8sm1557187qkn.95.2019.07.10.12.35.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 12:35:49 -0700 (PDT)
Date:   Wed, 10 Jul 2019 12:35:43 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        edumazet@google.com, bpf@vger.kernel.org
Subject: Re: [bpf PATCH v2 6/6] bpf: sockmap/tls, close can race with map
 free
Message-ID: <20190710123543.04846e00@cakuba.netronome.com>
In-Reply-To: <5d255ca6e5b0d_1b7a2aec940d65b4f6@john-XPS-13-9370.notmuch>
References: <156261310104.31108.4569969631798277807.stgit@ubuntu3-kvm1>
        <156261331866.31108.6405316261950259075.stgit@ubuntu3-kvm1>
        <20190709193846.62f0a2c7@cakuba.netronome.com>
        <5d255ca6e5b0d_1b7a2aec940d65b4f6@john-XPS-13-9370.notmuch>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 09 Jul 2019 20:33:58 -0700, John Fastabend wrote:
> Jakub Kicinski wrote:
> > On Mon, 08 Jul 2019 19:15:18 +0000, John Fastabend wrote:  
> > > @@ -352,15 +354,18 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
> > >  	if (ctx->tx_conf == TLS_BASE && ctx->rx_conf == TLS_BASE)
> > >  		goto skip_tx_cleanup;
> > >  
> > > -	sk->sk_prot = ctx->sk_proto;
> > >  	tls_sk_proto_cleanup(sk, ctx, timeo);
> > >  
> > >  skip_tx_cleanup:
> > > +	write_lock_bh(&sk->sk_callback_lock);
> > > +	icsk->icsk_ulp_data = NULL;  
> > 
> > Is ulp_data pointer now supposed to be updated under the
> > sk_callback_lock?  
> 
> Yes otherwise it can race with tls_update(). I didn't remove the
> ulp pointer null set from tcp_ulp.c though. Could be done in this
> patch or as a follow up.

Do we need to hold the lock in unhash, too, or is unhash called with
sk_callback_lock held?

> > > +	if (sk->sk_prot->close == tls_sk_proto_close)
> > > +		sk->sk_prot = ctx->sk_proto;
> > > +	write_unlock_bh(&sk->sk_callback_lock);
> > >  	release_sock(sk);
> > >  	if (ctx->rx_conf == TLS_SW)
> > >  		tls_sw_release_strp_rx(ctx);
> > > -	sk_proto_close(sk, timeout);
> > > -
> > > +	ctx->sk_proto_close(sk, timeout);
> > >  	if (ctx->tx_conf != TLS_HW && ctx->rx_conf != TLS_HW &&
> > >  	    ctx->tx_conf != TLS_HW_RECORD && ctx->rx_conf != TLS_HW_RECORD)
> > >  		tls_ctx_free(ctx);  

