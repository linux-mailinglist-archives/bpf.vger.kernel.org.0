Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9C8C1770DF
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 09:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgCCIMN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 03:12:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23992 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727644AbgCCIMN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 3 Mar 2020 03:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583223132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BRq+Xpy5Ea2+CTWSH3HAl6Ym/30Z9q2zfGm1aeQYGVo=;
        b=IQ1rSBuZUcZvv+MhGn28qhjnungoMCldie4uD/AOrVa0OyUlAyOscGTe17m42abLIaRXdc
        /cZyz8o82Fta2+ZD3sY5ud4ztY7SC5SPjXcjpTjIXrAEs0Hg7r3bDojyHXVwkVpoGe5f35
        IbkGn1cyGvZMJqgrRu+JsJg7osV1L0s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-2dAiO5F-N-aG0SyY3WLgJQ-1; Tue, 03 Mar 2020 03:12:10 -0500
X-MC-Unique: 2dAiO5F-N-aG0SyY3WLgJQ-1
Received: by mail-wm1-f70.google.com with SMTP id r19so760358wmh.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 00:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BRq+Xpy5Ea2+CTWSH3HAl6Ym/30Z9q2zfGm1aeQYGVo=;
        b=BotNI3xaedY4jcXiGnHB/p//OXA8XvANTquK3sMiSKLS6EfweKOlkm/KQI04pA+hSZ
         mCBenpYo+NFEPJkhM+aSgatNqnfG9DZVW39TdqY3PJa/ojkK2F3VRov6wp4UWfAajVij
         5ugKx1qYVDl02mW8Y2z+3KYMuvJwJzlwyTbTYlaAfqBNmfLH29bTlOL+Sh04Tg/k4ZKl
         iDyoyFP4cbhOyqdRuOFnpCwqEGytOjz2ZyidH39jhaC3Ap2eEYZ9jLZmR22Crtw+4GTd
         xkDc/eM592zhG9bWWIIzZBSGMhreabzOJD691CkNRt4eQjNePOkJkh+gDu+fnoaiBK8E
         pJIw==
X-Gm-Message-State: ANhLgQ3eSqyeIb2M855/KkEYbGrMpAD3024ozI/7KDamj0id4hq3QQrB
        RjlMUUlMSyv6d282yLHZNMA6JIoVubY5QHIFGGuKm16JMdiEjw1bEoRMCK+pkdyH4CpCWb9YhYP
        LuV/b02CasOih
X-Received: by 2002:a1c:9816:: with SMTP id a22mr3265096wme.16.1583223129152;
        Tue, 03 Mar 2020 00:12:09 -0800 (PST)
X-Google-Smtp-Source: ADFU+vv0LkO8J0l7GbYNi16fLvskKSOI02fFIeEOrajL9bUPCtZL8p9LwBczYLgYjj+MMpgy/cgGWA==
X-Received: by 2002:a1c:9816:: with SMTP id a22mr3265059wme.16.1583223128908;
        Tue, 03 Mar 2020 00:12:08 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g7sm28284582wrm.72.2020.03.03.00.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 00:12:08 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9EE6E180362; Tue,  3 Mar 2020 09:12:07 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 0/3] Introduce pinnable bpf_link kernel abstraction
In-Reply-To: <CAEf4BzbUpfKfB6raqwvTFPm_13Een7A9WUbQeSjdAtvcEU3nLA@mail.gmail.com>
References: <20200228223948.360936-1-andriin@fb.com> <87mu8zt6a8.fsf@toke.dk> <CAEf4BzZGn9FcUdEOSR_ouqSNvzY2AdJA=8ffMV5mTmJQS-10VA@mail.gmail.com> <87imjms8cm.fsf@toke.dk> <CAEf4BzbUpfKfB6raqwvTFPm_13Een7A9WUbQeSjdAtvcEU3nLA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 03 Mar 2020 09:12:07 +0100
Message-ID: <87a74xsvqg.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> All the XDP chaining specific issues should probably discussed on your
> original thread that includes Andrey as well.

Yeah, sorry for hijacking your thread with my brain dump; I'll move it
over to the other one :)

-Toke

