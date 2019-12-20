Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C23127959
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2019 11:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLTKaK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 05:30:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28103 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726210AbfLTKaH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 20 Dec 2019 05:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576837806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bLxRxHGGdK9fwJ8AQcIOollF4v5MCCwpG8KKa6zir/c=;
        b=R33cYBJF0qduAo9bzv61Fe4+iIwCZzr26q8NZpeMmniGff+uOww8uLhH+mY/XTwuuunulo
        jq3heo03kFtl1AAd99Xe61Q/j1k4nJeUg0G8HnO8fTK4HAfjVmbSj8SHWZ/5lE229R57nP
        0gWHSlq7ZUzZK+KOAEuuxvQQSYTt65o=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-yEif2ZmyOYeickp5oarPxQ-1; Fri, 20 Dec 2019 05:30:02 -0500
X-MC-Unique: yEif2ZmyOYeickp5oarPxQ-1
Received: by mail-lf1-f70.google.com with SMTP id f22so1051805lfh.4
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 02:30:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=bLxRxHGGdK9fwJ8AQcIOollF4v5MCCwpG8KKa6zir/c=;
        b=KYkpXKQY00d8K3yCMv/++CsPoSWubzTIm6ZrFnmh1VMycabq39Tp/OZUcT+XFC3GPS
         pSLWqUCSI44CIBODu8hJ1ELSVhtZ7gBnyBo+3YvzpCQ0HYkkhx4b+FWs4wQ3aCXskm1f
         Q2DxFU2gLafdQ7QzDJMUuldlGEtR0OgNMfaduEY2ILloyvrKSrC4zRMURg8dv58binUy
         lpgJaCk0E6UaR5Xq/Vziib0D1zHrhaGSp+hkaUUnfozitIzDOTpJI2y5st8MQHZz7mwP
         YP4H/L6gGjlbc+1C3f32iKET9TkIPOLAUFFtIopc+NKVp4wjgbdeYk5ysoP1O1+b/lPQ
         nmSw==
X-Gm-Message-State: APjAAAV45TZsmd9s+KBfyy6mSWsLfH1OXQI4xAYrkVUIA2NfAxWAQH5K
        +nawi3Pl0dQkoOYR5G+l+ZMKNnWxpheMXy8ScBBWQ9wqim1MoFv/XmLqiI1YDuxas2hIzD2giq1
        k9XghlDVXJncx
X-Received: by 2002:a2e:96c4:: with SMTP id d4mr289062ljj.225.1576837800986;
        Fri, 20 Dec 2019 02:30:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqkv9n7zq5sZW/toeG72RiasxsxgD85KG+ni8gYTocULVjC6qb+mO1RPZTO5BeAC5siMBpoA==
X-Received: by 2002:a2e:96c4:: with SMTP id d4mr289043ljj.225.1576837800802;
        Fri, 20 Dec 2019 02:30:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l28sm3762553lfk.21.2019.12.20.02.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 02:30:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 37485180969; Fri, 20 Dec 2019 11:29:59 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Karlsson\, Magnus" <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>, brouer@redhat.com
Subject: Re: [PATCH bpf-next v2 0/8] Simplify xdp_do_redirect_map()/xdp_do_flush_map() and XDP maps
In-Reply-To: <20191220102615.45fe022d@carbon>
References: <20191219061006.21980-1-bjorn.topel@gmail.com> <CAADnVQL1x8AJmCOjesA_6Z3XprFVEdWgbREfpn3CC-XO8k4PDA@mail.gmail.com> <20191220084651.6dacb941@carbon> <20191220102615.45fe022d@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 20 Dec 2019 11:29:59 +0100
Message-ID: <87mubn2st4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Fri, 20 Dec 2019 08:46:51 +0100
> Jesper Dangaard Brouer <brouer@redhat.com> wrote:
>
>> On Thu, 19 Dec 2019 21:21:39 -0800
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>> 
>> > > v1->v2 [1]:
>> > >   * Removed 'unused-variable' compiler warning (Jakub)
>> > >
>> > > [1] https://lore.kernel.org/bpf/20191218105400.2895-1-bjorn.topel@gmail.com/    
>> > 
>> > My understanding that outstanding discussions are not objecting to the
>> > core ideas of the patch set, hence applied. Thanks  
>> 
>> I had hoped to have time to review it in details today.  But as I don't
>> have any objecting to the core ideas, then I don't mind it getting
>> applied. We can just fix things in followups.
>
> I have now went over the entire patchset, and everything look perfect,
> I will go as far as saying it is brilliant.  We previously had the
> issue, that using different redirect maps in a BPF-prog would cause the
> bulking effect to be reduced, as map_to_flush cause previous map to get
> flushed. This is now solved :-)

Another thing that occurred to me while thinking about this: Now that we
have a single flush list, is there any reason we couldn't move the
devmap xdp_bulk_queue into struct net_device? That way it could also be
used for the non-map variant of bpf_redirect()?

-Toke

