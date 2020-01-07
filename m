Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87441133323
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2020 22:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgAGVHV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jan 2020 16:07:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44924 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729512AbgAGVHU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Jan 2020 16:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578431239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JNe143lUBlPJvUoAND0z1zJ7yDh+xa2CeGg3UfgsADk=;
        b=GiqZG66rVqDxsGP1CefkAC2CFxIbvII+Lu/Yx4wmzkwB5xXHZk4zpn4eOYFB1ppZAfsL/b
        xp0L5U6UjdzWzoc6gsVUSj++ac35aj67tyKqAh+Kw5sgN0vfaJdVDuo57Uq06/eW7I5Nwi
        ompOU0EY66AucmweWyuOHYZ2WpK4icc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-9tD05UXaM8uNBpi0mCztVw-1; Tue, 07 Jan 2020 16:07:18 -0500
X-MC-Unique: 9tD05UXaM8uNBpi0mCztVw-1
Received: by mail-wr1-f71.google.com with SMTP id c6so481215wrm.18
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2020 13:07:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JNe143lUBlPJvUoAND0z1zJ7yDh+xa2CeGg3UfgsADk=;
        b=SlGm8p5FuA433BGxcVO/c/1X7Lw1A2OC5yl8dxHoI3UTGwiaaH22yJ2bBNtuRXpy3J
         HcJlkzKbZmvHCqMu4mO5pe9iOs0rRJU9dtRHs8dzALoOeQ+TVWa1lI98tMEhUchfz0dV
         9nUF0pDjEEvO4joulRVWxd8SD43f5kC6Z8WtgThOs4Laz2mqBYI6zXuiiZ3ck8jMhIcj
         8ipe4jUqPzicbou6Xko7cspHPpeielTvInBzjgB3L8brUMwk2uFAF/jztrLtOG+reyg6
         wJ3Xhf02p7wPRA0F+ayTNRTgR93L7BXC4RU8XPK6Skq99C7I6BYqOl24UdT7dLTrioiO
         q4kQ==
X-Gm-Message-State: APjAAAUnOotlwMJB5Z+y4JMOZPIiOf4dsw6FpFXJg4sOkq5hixjtI2MP
        69IVJENMEdXEHKQX1WZ+8iwFCuyAlwo9JuMnP12BsnCwUg7rYIce7q2196Vo+ND0Jj8xSWt68Bv
        mtUJnauzhj/4u
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr308257wma.62.1578431237277;
        Tue, 07 Jan 2020 13:07:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzD7oU1k7te+BkQ81Kudl84D0c6mOodyYSpZ74vwm0UYNvCJjrpB7SiMcbEpeXZO705uEF6A==
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr308245wma.62.1578431237101;
        Tue, 07 Jan 2020 13:07:17 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v8sm1423887wrw.2.2020.01.07.13.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 13:07:16 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C7821180960; Tue,  7 Jan 2020 22:07:15 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBl?= =?utf-8?B?bA==?= 
        <bjorn.topel@gmail.com>, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, davem@davemloft.net,
        jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com, magnus.karlsson@intel.com,
        jonathan.lemon@gmail.com
Subject: RE: [PATCH bpf-next v2 7/8] xdp: remove map_to_flush and map swap detection
In-Reply-To: <5e14caaaab6f7_67962afd051fc5c06f@john-XPS-13-9370.notmuch>
References: <20191219061006.21980-1-bjorn.topel@gmail.com> <20191219061006.21980-8-bjorn.topel@gmail.com> <5e14caaaab6f7_67962afd051fc5c06f@john-XPS-13-9370.notmuch>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 07 Jan 2020 22:07:15 +0100
Message-ID: <87imlnht6k.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> writes:

> Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>>=20
>> Now that all XDP maps that can be used with bpf_redirect_map() tracks
>> entries to be flushed in a global fashion, there is not need to track
>> that the map has changed and flush from xdp_do_generic_map()
>> anymore. All entries will be flushed in xdp_do_flush_map().
>>=20
>> This means that the map_to_flush can be removed, and the corresponding
>> checks. Moving the flush logic to one place, xdp_do_flush_map(), give
>> a bulking behavior and performance boost.
>>=20
>> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>> ---
>
> __dev_map_flush() still has rcu_read_lock/unlock() around flush_list by
> this point, assuming I've followed along correctly. Can we drop those
> now seeing its per CPU and all list ops are per-cpu inside napi context?

Hmm, I guess so? :)

> Two reasons to consider, with this patch dev_map_flush() is always
> called even if the list is empty so even in TX case without redirect.
> But probably more important it makes the locking requirements more clear.
> Could probably be done in a follow up patch but wanted to bring it up.

This series was already merged, but I'll follow up with the non-map
redirect change. This requires a bit of refactoring anyway, so I can
incorporate the lock removal into that...

-Toke

