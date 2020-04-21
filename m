Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F621B24AA
	for <lists+bpf@lfdr.de>; Tue, 21 Apr 2020 13:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgDULKH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Apr 2020 07:10:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28021 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726741AbgDULKC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Apr 2020 07:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587467401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T4yWtrzUnXR0xIY1cOT4pJERzrx3FiQjVheebcXr3yM=;
        b=HSYHf2CrRAeXZLVFr+8V/MCE5TSCYZ+Iv4sYh+ASfqLQHfX8kzHKUFK1AVSeFj2SNyqWIP
        BVUpX51ganITHeZD9dGFFGWqS7QuDkdsBFAH5c5xzB93pxs3hprKq9xclo/TAe7mjjKzG7
        qpMs8pNNqK4sFp7jGmQTbLdA/+Ej4h8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-Yw_gW-ErPPSqQ7xcJnkZbQ-1; Tue, 21 Apr 2020 07:09:58 -0400
X-MC-Unique: Yw_gW-ErPPSqQ7xcJnkZbQ-1
Received: by mail-lj1-f197.google.com with SMTP id e19so2005922ljb.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2020 04:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=T4yWtrzUnXR0xIY1cOT4pJERzrx3FiQjVheebcXr3yM=;
        b=U3vOr9TE+OOGiFXktlUFRB89jU4jTEoEqHBb7ErW2HYb9/ORPKBzNPJGNUwr/wXyBp
         beMgT+30LcGlGeowraTXSQxZK5DZHls0/v/tQpbIvsgqOs5gG1UFyllybNjB88QwkbJH
         lxGvlgrfXTjij8G21RMknkKCr71Dra5ifE2++E5t2wE7xSJTFzyrzbUrx9o27y5yLXVh
         QJf3rlFzwZzfOZuF6pPj1EEuOJCA8l9YNVdevlSk/s13VFhL+VlOCmcFOs18HVco5ZHS
         5tYPCKRxLwUGRYotnv0R15j6ab5Wm4xnvqTXUeBGO2nVmauXaQnCcZqM0BuALErzj0Bv
         vD9Q==
X-Gm-Message-State: AGi0PuYNY6f89CrrHV2imFnMvLKozSmDf2Ap7IfqFzx3DDb2VPP23vUH
        GnnRQQAXRwOVfpkvDqaUQLonFilVb5AUYkBsySSfw5H99wv8uyuLjV1uKbscNeD3wR3SvG3GNYL
        bP8RWnUyfyUTg
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr13287748ljk.134.1587467396634;
        Tue, 21 Apr 2020 04:09:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypIsNfjyCPk334Tn3naDfiYofFGQqq/AoLw9CSBsXdPnoduihv9nDZmnut1iiSOtj4ukKyyb8Q==
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr13287736ljk.134.1587467396345;
        Tue, 21 Apr 2020 04:09:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g8sm1813212ljl.45.2020.04.21.04.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 04:09:55 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DF66218157F; Tue, 21 Apr 2020 13:09:53 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Christian Deacon <gamemann@gflclan.com>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Bpfilter Development
In-Reply-To: <ac739c9c-f377-129f-1d4b-6c4c7e15f83d@gflclan.com>
References: <ac739c9c-f377-129f-1d4b-6c4c7e15f83d@gflclan.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 21 Apr 2020 13:09:53 +0200
Message-ID: <871roh9jsu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Christian Deacon <gamemann@gflclan.com> writes:

> Hey everyone,
>
>
> I apologize if this is the incorrect place to address this. I couldn't 
> find any mailing list for Bpfilter specifically. If there is a better 
> place to address this, suggestions are welcomed and appreciated!
>
>
> I was wondering if Bpfilter is still under development or if the project 
> development is at a halt. I am planning out my next major project that 
> will be responsible for forwarding traffic and blocking (D)DoS attacks 
> based off of filtering rules. As of right now, I'm trying to decide 
> whether to use Bpfilter or XDP-native for blocking malicious traffic. 
> With the project's current layout, I feel it would be easier using 
> something like Bpfilter for this. However, I'm not sure when this will 
> be completely developed to the point it'd be usable with my application. 
> If this project is under development, is there any ETA on when it will 
> be officially supported and in a usable state for most applications 
> (specifically for dropping malicious traffic)?

As a general rule I think you will find that there are very few upstream
developers who will commit to any ETA other than "when it's done". As
for bpfilter specifically, I am not aware of anyone actively working on
it at all...

> One last question I had is if there were any estimates on how fast 
> Bpfilter would be compared to XDP-native when dropping malicious 
> packets. I'd assume they would see similar performance, but I'm not 
> entirely sure.

I would expect that XDP would be significantly faster (as long as you
are using hardware with native XDP support in the driver). For DDOS
filtering specifically, I think it would be a no-brainer to just go with
XDP.

Feel free to use xdp-filter as a starting point:

https://github.com/xdp-project/xdp-tools/tree/master/xdp-filter

It's pretty dumb as far as expressing the filtering rules themselves are
concerned, but it does demonstrate how you might structure such a
program, including how to only load the BPF code needed to support the
active filtering rules. Pull requests always welcome to improve it as
well, of course :)

-Toke

