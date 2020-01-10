Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7B137146
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2020 16:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgAJPbA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jan 2020 10:31:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22090 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728336AbgAJPbA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Jan 2020 10:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578670259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mqdhgHKDxkpsagVFs1MAPtfnHMhpz7EhVbv+10PrkT4=;
        b=csOUolbJb4jxFZnMGYYQVMv2YmifkEzVVehazHA35NWIygIit7gfINPYjNeoMzmAMb5WNC
        RIEQaCs2OXnHHq0H8qLbykCcNE1Xwk7apMSXSw/OtYz+19QhLRPSZ+YgSRnXJOGenL41Gh
        mD/7b1ntuzgvRFMuroiWGmZZ2v/nB5M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-paRq4ftNOOaW7kBAeY64og-1; Fri, 10 Jan 2020 10:30:56 -0500
X-MC-Unique: paRq4ftNOOaW7kBAeY64og-1
Received: by mail-wm1-f72.google.com with SMTP id t17so551373wmi.7
        for <bpf@vger.kernel.org>; Fri, 10 Jan 2020 07:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mqdhgHKDxkpsagVFs1MAPtfnHMhpz7EhVbv+10PrkT4=;
        b=pQ/FBI+uWTHK5WQlbyP+HjCh+2117OApSfmOeEaL+ILOhkSKJ/KaPXbnkRgbWlyHxA
         OevMBvdqwEdrLWxIJebmyllHiquSYyBy44oXf+KRVYcHHmrZEU0k3GEhigyamhIG2PHe
         YPmLlW/PLtYHYfVbLmhKktVHNd7mE50GwESYoj7mbQvDJyA/7PNDooL6UY+oOVlBxUiB
         AheV3OuOR3KJfHVeEIMZr3Ssym2kEJEfebll8Pw7guNR1pXjbOaHmXOtNpwXXrNdKwYo
         BtM20a3OtpJAW1eA9LMttBLmlGL7pbvgrtCg7Dwkr7dSAM4Su9TYy8WBsYxQxkn52zd5
         QjTA==
X-Gm-Message-State: APjAAAULCQ1cc2jCPalzDAtxEFmqnTF5WMKvu29gqa2NzJlWmo9OA+X4
        /BDrAu53j+39NIBtkvzyKADcFYcWJ19FkgGi40KvQ5TuGEh7nkM9tYWbHjhZtS1nkayMlfn9c+r
        fvtquR0wGAh7o
X-Received: by 2002:a5d:5345:: with SMTP id t5mr4384735wrv.0.1578670255109;
        Fri, 10 Jan 2020 07:30:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqy9DPLK89p2Vnj67k7onQHiuU/vOE5G+SNIsSOj9jehTu+ESKDQCEEVTq3AEu6RpqjJdC7PAw==
X-Received: by 2002:a5d:5345:: with SMTP id t5mr4384717wrv.0.1578670254873;
        Fri, 10 Jan 2020 07:30:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l18sm2561105wme.30.2020.01.10.07.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 07:30:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9347818009F; Fri, 10 Jan 2020 16:30:53 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] xdp: Use bulking for non-map XDP_REDIRECT
In-Reply-To: <CAJ+HfNhM8SQK6dem9vhvAh68AqaxouSDhhWjXiidB3=LBRmsUA@mail.gmail.com>
References: <157866612174.432695.5077671447287539053.stgit@toke.dk> <157866612392.432695.249078779633883278.stgit@toke.dk> <CAJ+HfNhM8SQK6dem9vhvAh68AqaxouSDhhWjXiidB3=LBRmsUA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 10 Jan 2020 16:30:53 +0100
Message-ID: <87d0brxr9u.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> On Fri, 10 Jan 2020 at 15:22, Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> Since the bulk queue used by XDP_REDIRECT now lives in struct net_device,
>> we can re-use the bulking for the non-map version of the bpf_redirect()
>> helper. This is a simple matter of having xdp_do_redirect_slow() queue t=
he
>> frame on the bulk queue instead of sending it out with __bpf_tx_xdp().
>>
>> Unfortunately we can't make the bpf_redirect() helper return an error if
>> the ifindex doesn't exit (as bpf_redirect_map() does), because we don't
>> have a reference to the network namespace of the ingress device at the t=
ime
>> the helper is called. So we have to leave it as-is and keep the device
>> lookup in xdp_do_redirect_slow().
>>
>> With this change, the performance of the xdp_redirect sample program goes
>> from 5Mpps to 8.4Mpps (a 68% increase).
>>
>
> After these changes, does the noinline (commit 47b123ed9e99 ("xdp:
> split code for map vs non-map redirect")) still make sense?

Hmm, good question. The two code paths are certainly close to one
another; and I guess they could be consolidated further.

The best case would be if we had a way to lookup the ifindex directly in
the helper. Do you know if there's a way to get the current net
namespace from the helper? Can we use current->nsproxy->net_ns in that
context?

If we can, and if we don't mind merging the two different tracepoints,
the xdp_do_redirect() function could be made quite a bit leaner...

-Toke

