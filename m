Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B19830AC79
	for <lists+bpf@lfdr.de>; Mon,  1 Feb 2021 17:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBAQRg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Feb 2021 11:17:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59531 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231350AbhBAQRe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Feb 2021 11:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612196165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wtEImnysmZsCe17oDLIV5BEbIvQnvQ9tAqzmB4zetBU=;
        b=f2V43UvjeV+0JnTy4Rf5YlmuiUjqvWqSosbJkUDB9rxlmAEbiS2Rt27XW3vvs5ZWXRDgfw
        Gckyjq5YdLGzQq5Bi3Qm0//gvKWsb5k6sCOmBYQXmzAxmU/HHrKKBQJSmNGpq002iD4Rmf
        0YgoktYxivapMB9k9ZOWw9O/T8iWiG8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-abGg7KYfMVyWjgWPN5UpAw-1; Mon, 01 Feb 2021 11:16:03 -0500
X-MC-Unique: abGg7KYfMVyWjgWPN5UpAw-1
Received: by mail-ed1-f72.google.com with SMTP id bo11so1662881edb.0
        for <bpf@vger.kernel.org>; Mon, 01 Feb 2021 08:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wtEImnysmZsCe17oDLIV5BEbIvQnvQ9tAqzmB4zetBU=;
        b=RKv1grLGDJvPzO+P+6czlN73oqE/n+//0k94vA2/kxKs6wBCf9EcqJ0QvAoBd3gP/k
         Qs+IPR/NnxsFTR3NWRtBzIjOEAooHLVvN19VVIXN9Ak5Cx19XMafjx0h9CwTAJpTwFJ1
         1map52+uNo0FdWqT7OjDhT3PszzUPKwtKqVBHcKVmfpj7hkwZkjP/jQzgiayz4YS19ET
         oQDewnaCYwIXhP1cqP0TxGRArKsaTvtDrEbPA+B0FQRpmg+6p4Qy1aK8KmJ5B8oGYB9J
         15mEi7sd0+ky6MAiahKNSwyiDIkS9IN/HX5jGeMGxdqEVar2C6xcYcA+mcMHGJtNZMUJ
         QS7A==
X-Gm-Message-State: AOAM530Vb9Q+9iS9GSNbFf5WWgJt2UKUKZBtbS3lXXXVkrlpsJceGbJJ
        ccob5ke5QVdlV0wncmwa2JKupmh0+6mePdEdoocmDCQLehshE3kmdcAd0GKZ2y9rp8h6UxYtTv9
        4geGWbiSrUs+m
X-Received: by 2002:a17:906:3649:: with SMTP id r9mr6892706ejb.202.1612196162686;
        Mon, 01 Feb 2021 08:16:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxN8K42+0Uqlc+66VIRj7dBorpzsYjT+7/oiWk0jHufTw04BuwWt8cBPCXWXYN9Q6jo2plJ7Q==
X-Received: by 2002:a17:906:3649:: with SMTP id r9mr6892675ejb.202.1612196162453;
        Mon, 01 Feb 2021 08:16:02 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z13sm8883644edc.73.2021.02.01.08.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 08:16:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 24062180367; Mon,  1 Feb 2021 17:16:01 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Marek Majtyka <alardam@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Maciej Fijalkowski <maciejromanfijalkowski@gmail.com>
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, hawk@kernel.org,
        bpf <bpf@vger.kernel.org>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        jeffrey.t.kirsher@intel.com
Subject: Re: [PATCH v2 bpf 1/5] net: ethtool: add xdp properties flag set
In-Reply-To: <CAAOQfrHN1-oHmbOksDv-BKWv4gDF2zHZ5dTew6R_QTh6s_1abg@mail.gmail.com>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-2-marekx.majtyka@intel.com>
 <878sad933c.fsf@toke.dk> <20201204124618.GA23696@ranger.igk.intel.com>
 <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
 <20201207135433.41172202@carbon>
 <5fce960682c41_5a96208e4@john-XPS-13-9370.notmuch>
 <20201207230755.GB27205@ranger.igk.intel.com>
 <5fd068c75b92d_50ce20814@john-XPS-13-9370.notmuch>
 <20201209095454.GA36812@ranger.igk.intel.com>
 <20201209125223.49096d50@carbon>
 <e1573338-17c0-48f4-b4cd-28eeb7ce699a@gmail.com>
 <1e5e044c8382a68a8a547a1892b48fb21d53dbb9.camel@kernel.org>
 <cb6b6f50-7cf1-6519-a87a-6b0750c24029@gmail.com>
 <f4eb614ac91ee7623d13ea77ff3c005f678c512b.camel@kernel.org>
 <d5be0627-6a11-9c1f-8507-cc1a1421dade@gmail.com>
 <6f8c23d4ac60525830399754b4891c12943b63ac.camel@kernel.org>
 <CAAOQfrHN1-oHmbOksDv-BKWv4gDF2zHZ5dTew6R_QTh6s_1abg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 01 Feb 2021 17:16:01 +0100
Message-ID: <87h7mvsr0e.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Marek Majtyka <alardam@gmail.com> writes:

> I would like to thank you for your time, comments, nitpicking as well
> as encouraging.
>
> One thing needs clarification I think, that is, that those flags
> describe driver static feature sets - which are read-only. They have
> nothing in common with driver runtime configuration change yet.
> Runtime change of this state can be added but it needs a new variable
> and it can be done later on if someone needs it.
>
> Obviously, it is not possible to make everybody happy, especially with
> XDP_BASE flags set. To be honest, this XDP_BASE definition is a
> syntactic sugar for me and I can live without it. We can either remove
> it completely, from
> which IMO we all and other developers will suffer later on, or maybe
> we can agree on these two helper set of flags: XDP_BASE (TX, ABORTED,
> PASS, DROP) and XDP_LIMITED_BASE(ABORTED,PASS_DROP).
> What do you think?
>
> I am also going to add a new XDP_REDIRECT_TARGET flag and retrieving
> XDP flags over rtnelink interface.
>
> I also think that for completeness, ethtool implementation should be
> kept  together with rtnelink part in order to cover both ip and
> ethtool tools. Do I have your approval or disagreement? Please let me
> know.

Hi Marek

I just realised that it seems no one actually replied to your email. On
my part at least that was because I didn't have any objections, so I'm
hoping you didn't feel the lack of response was discouraging (and that
you're still working on a revision of this series)? :)

-Toke

