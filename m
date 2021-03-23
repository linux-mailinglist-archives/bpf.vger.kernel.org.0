Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB017345BC2
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 11:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCWKPe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 06:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53093 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229639AbhCWKP2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Mar 2021 06:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616494527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33TioYNXdkIK41LK1fNmqaU/cASsOPpzjkwj2vLLbAI=;
        b=bWsbWUKxxWeT4GfES/Ai65rdGMv8Xa9WJUGtL5g8JG3D7Rqv7Y1VtjttUhYHJZmlZ2eg7O
        w7cwfNqAZ9U0ilI6lYHHA9Tuw7SZZgvbkuf2EYQeE1NlORTtgnGJz9VwQzPghRUdImYG70
        dWBO5d3JTzSyrDRFhEjG9TsyCDr/n5s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-s-A5MFBDPZOrASkMzPVsyA-1; Tue, 23 Mar 2021 06:15:25 -0400
X-MC-Unique: s-A5MFBDPZOrASkMzPVsyA-1
Received: by mail-ej1-f72.google.com with SMTP id sa29so841126ejb.4
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 03:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=33TioYNXdkIK41LK1fNmqaU/cASsOPpzjkwj2vLLbAI=;
        b=XPuCnXYnKCUcNuASB2C+YblDdsrg44ZN+oxFH2oU7WwTYAregehwSDGcmhZWnHjf4W
         AfuHfhlqOQ/zkmN2mSJZur0u86fjL69LIXLQYTzAvXcHhhFL4eGqcmxebJ6yC6vP8yXk
         XBdgBdeZb5yE5pVSTHV3UvVuDijS61E5IfUKZOyjgZwySLWT0CzA/1+Sr1VuNQA2mJFG
         EuXYSw83LWiBILfyrl5NT0sKs6F4qS4of2seDjgZ5w1n/GztegnbhwwYHgeo26EOugFO
         f88jbcvi7bGHrHiCovhLUr+dAzwIalCI9BzBgFUDkimMEOidb4gq831oCJdZbKoUOObN
         UibQ==
X-Gm-Message-State: AOAM5332EFPENnR4KSa23hp29ypDGWotFtxm4eUqhnhZMSfBU0QRVkHN
        fPczxX2T+UKfbY2WHf3l6tvkCiEOzY+JdbBgDi7bybrBq4aEPx5cNBYb/sk1D67MO0fn4nz1eaN
        iWksbrdvN16Vl
X-Received: by 2002:a17:907:f97:: with SMTP id kb23mr4109453ejc.33.1616494524397;
        Tue, 23 Mar 2021 03:15:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0ymyHSvddRqzkPHV01ILJ3coO7Gvl87MnOKtrp41zFNmRBCiHAagyP6FAX/LMp5E2mVhBQg==
X-Received: by 2002:a17:907:f97:: with SMTP id kb23mr4109443ejc.33.1616494524249;
        Tue, 23 Mar 2021 03:15:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id wr20sm6751072ejb.111.2021.03.23.03.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 03:15:23 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0CF0E180281; Tue, 23 Mar 2021 11:15:23 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        bjorn@kernel.org
Subject: Re: [PATCHv2 bpf-next 2/4] xdp: extend xdp_redirect_map with
 broadcast support
In-Reply-To: <20210323024923.GD2900@Leo-laptop-t470s>
References: <20210309101321.2138655-1-liuhangbin@gmail.com>
 <20210309101321.2138655-3-liuhangbin@gmail.com> <87r1kec7ih.fsf@toke.dk>
 <20210318035200.GB2900@Leo-laptop-t470s> <875z1oczng.fsf@toke.dk>
 <20210323024923.GD2900@Leo-laptop-t470s>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 23 Mar 2021 11:15:22 +0100
Message-ID: <87lfae6urp.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <liuhangbin@gmail.com> writes:

> On Thu, Mar 18, 2021 at 03:19:47PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Hangbin Liu <liuhangbin@gmail.com> writes:
>>=20
>> > On Wed, Mar 17, 2021 at 01:03:02PM +0100, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> >> FYI, this no longer applies to bpf-next due to Bj=C3=B6rn's refactor =
in
>> >> commit: ee75aef23afe ("bpf, xdp: Restructure redirect actions")
>> >
>> > Thanks Toke, I need to see how to get the map via map_id, does
>> > bpf_map_get_curr_or_next() works? Should I call bpf_map_put() after
>> > using?
>>=20
>> I would expect that to be terrible for performance; I think it would be
>> better to just add back the map pointer into struct bpf_redirect_info.
>> If you only set the map pointer when the multicast flag is set, you can
>> just check that pointer to disambiguate between when you need to call
>> dev_map_enqueue() and dev_map_enqueue_multi(), in which case you don't
>> need to add back the flags member...
>
> There are 2 flags, BROADCAST and EXCLUDE_INGRESS. There is no way
> to only check the map pointer and ignore flags..

Ah, right, of course, my bad :)

Well, in that case adding both members back is probably the right thing
to do...

-Toke

