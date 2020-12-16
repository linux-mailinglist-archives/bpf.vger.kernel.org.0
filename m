Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCF32DC075
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 13:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgLPMqs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 07:46:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726077AbgLPMqs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 16 Dec 2020 07:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608122722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ebb5CMBBOFtuJcYfYXNX6XOzZRifgXHpVpP3voMyqP4=;
        b=FKrc5IecE0YFLN9wScqWHQOkPxOLQRlnbElCp9YRBbKlYnq0cP3Ttq7SWrIEeqzy/akR8a
        /Gt8MHZ/mPijgXzZ+dsNU1cfgfjxnbmkehAYTAcgTNY4sh3k11gICiwChXaM5zWxT86R5r
        1WZHMXdbbrDr8iYEqp+EEH54uJVHaIU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-B-KvkkAuMLKR-q2HrBBFMg-1; Wed, 16 Dec 2020 07:45:20 -0500
X-MC-Unique: B-KvkkAuMLKR-q2HrBBFMg-1
Received: by mail-ed1-f71.google.com with SMTP id dc6so11661292edb.14
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 04:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Ebb5CMBBOFtuJcYfYXNX6XOzZRifgXHpVpP3voMyqP4=;
        b=J9GLEgGJK/7SPd8ea7BUV7Lusv9ah6ck0C/iNJrujngjYjPqv2zmeIqKhVfUWrU4Hb
         KaoiDwSgiOQl5ThoX6NDmmEni4yozrO5nwz3+0C6F8eJ4IXNo/qtAG7v5TU7o9vUSKzS
         /GzTtxmVbaWqvN4As1N1tbCNZT7c/cm7/MlXHfQ1gdQoKOL1v3bun/ue+Ja47DrJLrvo
         A+3UafMHaCfEE1fmsL6uIPHgU7miy7gljA3z3xjdiYpQCTtCl/hhhmr5c5ooFNHJLAZU
         AKgFrvR1b433YoX6Ypfzdo+qhYR5nbldS3B0tpNhuQYygFBQGvp6AccUnLKsI12vzF83
         nLPw==
X-Gm-Message-State: AOAM530fs6lcTHy362Hazsw3F+d1Q17A85lOHZFpFXH6ll/1o+49aBtv
        CT3W+M04GaEg1iYCBtvi5gJdNXJzM1ZbBjULAdkfEhAIhoYv7i3/gfqW4iH+GTvBdBt/t5uJ8Gh
        U1+sDDeDq5UCx
X-Received: by 2002:a17:906:7243:: with SMTP id n3mr29852474ejk.246.1608122718573;
        Wed, 16 Dec 2020 04:45:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxC8G+lU1STw+5xVl90HvA8DJZAIdU1CYG7aev740xp3lfWhfORuzaxOcMehcK3mUZRuUmWmg==
X-Received: by 2002:a17:906:7243:: with SMTP id n3mr29852444ejk.246.1608122718051;
        Wed, 16 Dec 2020 04:45:18 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ng1sm1319740ejb.112.2020.12.16.04.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 04:45:17 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 304DF1802A7; Wed, 16 Dec 2020 13:45:17 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "Brian G. Merrell" <brian.g.merrell@gmail.com>
Cc:     xdp-newbies@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Subject: Re: How to orchestrate multiple XDP programs
In-Reply-To: <20201216072920.hh42kxb5voom4aau@snout.localdomain>
References: <20201201091203.ouqtpdmvvl2m2pga@snout.localdomain>
 <878sah3f0n.fsf@toke.dk>
 <20201216072920.hh42kxb5voom4aau@snout.localdomain>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 16 Dec 2020 13:45:17 +0100
Message-ID: <873605din6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Brian G. Merrell" <brian.g.merrell@gmail.com> writes:

> Yes, please, if anyone has additional thoughts please weigh in, but I
> think my team is ready to commit to option #2.
>
> Any concerns about my assessment and request?

Just a quick note - since the holidays are fast approaching I won't have
time to do anything more about it before January anyway. But until then,
thank you for volunteering to do the Go implementation work!

I'll write up the "spec" once I'm back from the holidays, and we can
continue the discussion (and you can start prototyping an
implementation). And if you run away screaming after seeing the gory
details we can of course reconsider ;)

Sounds good?

And if someone else chimes in with opinions before or during that, great!

-Toke

