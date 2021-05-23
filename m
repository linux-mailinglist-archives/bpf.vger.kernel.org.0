Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C20438DB14
	for <lists+bpf@lfdr.de>; Sun, 23 May 2021 13:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhEWLuJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 May 2021 07:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231728AbhEWLuI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 23 May 2021 07:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621770522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FaFe9uffRdwTnS7acJYPwsy2NoFG/av6QEuiajyWo2M=;
        b=f65iVNkECTDymMichUQC+L3Bs7FCNeyuQFqbYvUn45m/ADUTM9z8gGMHsPjM5K4mEF7bI7
        3Cga1Y6UMsV5xcKAuyXNJcZX6uIY4lSTdvGOoaNoKB9JQ5DXl1Xfy1R4AT1VRsZg2UPYMv
        GO139CKcwSSmGX7m7Y41l83YBrzugts=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-CrFMa2wwMXuAfE9CbFIpHw-1; Sun, 23 May 2021 07:48:38 -0400
X-MC-Unique: CrFMa2wwMXuAfE9CbFIpHw-1
Received: by mail-ed1-f70.google.com with SMTP id d8-20020a0564020008b0290387d38e3ce0so14004671edu.1
        for <bpf@vger.kernel.org>; Sun, 23 May 2021 04:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FaFe9uffRdwTnS7acJYPwsy2NoFG/av6QEuiajyWo2M=;
        b=kXIMU54hn00Bhdv1m7VruHzDrh6awSHfjTdyg8c7KWTYHR2H/lqnEmiRBjPyguFKYI
         TZFUpX5w/xBGRrDK+UUCZqY4Bqh3sdm966XYWEA981zEcWPIbzuOrQy0apU4jjMJ0a2c
         eAW+3+rAdpG6CSQLvsKRlNx0pD1uF9PGgMbStW+648iTYZ0VLG4XNOhwwQcpl6cmCn+9
         +9WTZUChSvBi6IqqjmvsgxA/BB6NIOKu1uvoG9dpsSdRLkhtAh3X81lBr1NYEPQ6KUoR
         /mswZTfCfctGI1z9MAqrEq/5PYebCMuWkFCFAny9ceJufkBqlKaNJbmxdoDdO/e/xtZJ
         4RPQ==
X-Gm-Message-State: AOAM5328jpSNVxJJN0eaqnoDsu0E1UN2ymufihjGHnDAT83P8nHAN/v0
        wniAJNFyakepn9i1MBDF5BxDIZX2StgRqRHVppr307PllihEvf5gGjz7nh0tUNq23ObFiKVXvnc
        t4D5AV/ATxm6O
X-Received: by 2002:a17:906:f84:: with SMTP id q4mr18838560ejj.442.1621770516846;
        Sun, 23 May 2021 04:48:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1/dLWixp+pH0CUbLqCyt87/WqriedDInYAMUQ+9CeFHoh5eVGl0EyhfWEXWUo9Z/n2E0skA==
X-Received: by 2002:a17:906:f84:: with SMTP id q4mr18838541ejj.442.1621770516434;
        Sun, 23 May 2021 04:48:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id p8sm2792130eds.95.2021.05.23.04.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 04:48:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 76EB51801D6; Sun, 23 May 2021 13:48:34 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        lmb@cloudflare.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH bpf-next] bpf: Introduce bpf_timer
In-Reply-To: <20210520185550.13688-1-alexei.starovoitov@gmail.com>
References: <20210520185550.13688-1-alexei.starovoitov@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 23 May 2021 13:48:34 +0200
Message-ID: <87o8d1zn59.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Still wrapping my head around this, but one thing immediately sprang to
mind:

> + * long bpf_timer_mod(struct bpf_timer *timer, u64 msecs)
> + *	Description
> + *		Set the timer expiration N msecs from the current time.
> + *	Return
> + *		zero

Could we make this use nanoseconds (and wire it up to hrtimers) instead?
I would like to eventually be able to use this for pacing out network
packets, and msec precision is way too coarse for that...

-Toke

