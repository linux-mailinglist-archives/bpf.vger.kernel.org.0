Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8D01E563
	for <lists+bpf@lfdr.de>; Wed, 15 May 2019 00:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfENW7U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 May 2019 18:59:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41384 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfENW7U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 May 2019 18:59:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id y22so1089119qtn.8
        for <bpf@vger.kernel.org>; Tue, 14 May 2019 15:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Bc7lvpFisi0OXzRHovIwXA/eM8d2KyxU+1AYelcAN+I=;
        b=gi7DgFJMBIMNTnE8RGzTT/uljF5l3fDlRLlmSd6EXLjsmUcBEDuU2LmMA8u2f0FSrR
         HZ6e5ZBy17wW6LMI2k2WmHrJjTqf+6NSxBv0Fc6Ski3V9ZkaoieCTj00kR0iY+ydGpV2
         toVdU6yNgKdcjiuHKIHcTNLa8NqrhDaM/Bgz6yQaj33K4jYWIS8eQuqBywFZD6BMCX+K
         41HgWOZmpwg8QVyOAPHGc/oG5Qd90pJTfEcqcoUz2TuALIhmsbQnLKuyvR7N7vYibGXD
         G/GU7+bHd+JSasjvGqxYqkRmMlA8qmXe7q6/bJ9r4lnChymf52vx0+ZUpb/KILakZ6SC
         kS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Bc7lvpFisi0OXzRHovIwXA/eM8d2KyxU+1AYelcAN+I=;
        b=P9+ncTqnihNuXoKZAThggXbawhlEXtdElPT33Mo7937p9Dw6kz0N/5BSWBGepOmBtx
         xROoHBSvsQjv0KqT8qM57M1FSDs6BlgUImcf39D/67N4+4GkplpgBZcXusJ9OXcMW6RW
         EQJe5WddigArg94ESX92aaDqmkpDZtqOibrCDm/4m0QQGbVdx4NDqz5JqQYiWKkEMDoS
         woAQtdGc8siJIcPjedTrWGMasQcFb4+jkFKj5RpuCdkLjNHo+gW0hJ2QIEYy0rlfEi5K
         fa9O5h5khHLwDVGUE1JRGTv/I6zauS8WMSX2DtEWsyAfGoo4MXYAI4yMOKaAJv76seGJ
         DlgQ==
X-Gm-Message-State: APjAAAU2sn8T2oC+Szvo7zHMLpiEOZq9z9N5xDYcx0CpeNj38fkCC3vV
        xZWVW9UOSF32jEoN32IbyMHU0Yzz8rU=
X-Google-Smtp-Source: APXvYqyPJokLC3L/MSNFion6vvIwhlZLXTmenAS51vCGn70Z4HV4bTH7S6MqKs2BCVBG2d0JU1SRYA==
X-Received: by 2002:a0c:d1d0:: with SMTP id k16mr30853976qvh.59.1557874759152;
        Tue, 14 May 2019 15:59:19 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 22sm122698qkl.4.2019.05.14.15.59.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 15:59:18 -0700 (PDT)
Date:   Tue, 14 May 2019 15:58:57 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Subject: Re: [bpf PATCH v4 1/4] bpf: tls, implement unhash to avoid
 transition out of ESTABLISHED
Message-ID: <20190514155857.1f10ef78@cakuba.netronome.com>
In-Reply-To: <5cdb428fe9f53_3e672b0357f765b85c@john-XPS-13-9360.notmuch>
References: <155746412544.20677.8888193135689886027.stgit@john-XPS-13-9360>
        <155746426913.20677.2783358822817593806.stgit@john-XPS-13-9360>
        <20190510100054.29f7235c@cakuba.netronome.com>
        <5cd603329f753_af72ae355cbe5b8e8@john-XPS-13-9360.notmuch>
        <5cdb428fe9f53_3e672b0357f765b85c@john-XPS-13-9360.notmuch>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 14 May 2019 15:34:55 -0700, John Fastabend wrote:
> John Fastabend wrote:
> > Jakub Kicinski wrote:  
> > > On Thu, 09 May 2019 21:57:49 -0700, John Fastabend wrote:  
> > > > @@ -2042,12 +2060,14 @@ void tls_sw_free_resources_tx(struct sock *sk)
> > > >  	if (atomic_read(&ctx->encrypt_pending))
> > > >  		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
> > > >  
> > > > -	release_sock(sk);
> > > > +	if (locked)
> > > > +		release_sock(sk);
> > > >  	cancel_delayed_work_sync(&ctx->tx_work.work);  
> > > 
> > > So in the splat I got (on a slightly hacked up kernel) it seemed like
> > > unhash may be called in atomic context:
> > > 
> > > [  783.232150]  tls_sk_proto_unhash+0x72/0x110 [tls]
> > > [  783.237497]  tcp_set_state+0x484/0x640
> > > [  783.241776]  ? __sk_mem_reduce_allocated+0x72/0x4a0
> > > [  783.247317]  ? tcp_recv_timestamp+0x5c0/0x5c0
> > > [  783.252265]  ? tcp_write_queue_purge+0xa6a/0x1180
> > > [  783.257614]  tcp_done+0xac/0x260
> > > [  783.261309]  tcp_reset+0xbe/0x350
> > > [  783.265101]  tcp_validate_incoming+0xd9d/0x1530
> > > 
> > > I may have been unclear off-list, I only tested the patch no longer
> > > crashes the offload :(
> > >   
> > 
> > Yep, I misread and thought it was resolved here as well. OK I'll dig into
> > it. I'm not seeing it from selftests but I guess that means we are missing
> > a testcase. :( yet another version I guess.
> >   
> 
> Seems we need to call release_sock in the unhash case as well. Will
> send a new patch shortly.

My reading of the stack trace was that unhash gets called from
tcp_reset(), IOW from soft IRQ, so we can't cancel_delayed_work_sync()
in tls_sw_free_resources_tx(), no?
