Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F119BF3CE
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2019 15:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfIZNMg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Sep 2019 09:12:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37122 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725836AbfIZNMg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Sep 2019 09:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569503555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSMLfK3pYPL1cVmk6h2CM/KHhT/OAXe1m21X5wqkJSY=;
        b=QjS8aZNutTX6EZTKJgnmKM/GJXR1TbANLmZnOoyJK3P+9xlrAk3GZPgo821nq67r5Cp6Wz
        +bxcprGiWhmR3A9KYxzw116CdVFIe7198am1KgThGCWy3ApUBOgpIyYATvH7HrvryMq8Xd
        49gWTYas62OKe8B6Gt35chccjU47isk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-KtsrOmYPNPi9tc63VLrIvg-1; Thu, 26 Sep 2019 09:12:34 -0400
Received: by mail-ed1-f69.google.com with SMTP id s3so1318393edr.15
        for <bpf@vger.kernel.org>; Thu, 26 Sep 2019 06:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JSMLfK3pYPL1cVmk6h2CM/KHhT/OAXe1m21X5wqkJSY=;
        b=PMwfunHqrUTRTaQUGGEBAaAcScEj7JQpCzDf0l6AsBcQScpOCcn5zqQaTcVsp5KJLu
         Xq0wK6v3VR3MieDkjOleSscjzQY3C/DgByqomW8eqyx/Z0/MArtOp7QtmVnxomGo2l41
         uCxdV0zp71orNuv+S28D8GPaw8HCwIKiLyZBMFnRzs01Wwc5nhQb+NAjI2Q9Uocxxch8
         NFFb8LlkIluKWNWIoMkMdJ63xyHNf9t40jthioq1QkX3GoZKjkeAEbNhLy166mZ3r64Q
         9mEWQTwTq+mYAdQ2RiduVuq1m2UhFAwYW8WOSIcmu9KH8uJu5HSYfV2pxBW5nv8BNxX0
         3vNQ==
X-Gm-Message-State: APjAAAU6Eoi6+eZTGHNxjj1UPkM2kL0RFNdFCUF9TMrcivj0r4hmmv+1
        5t30H9+at8Zxidxun5K6ziSX3b/tt1gJTS1p5kEGWzsPnliODR7ttox9DE55p2PYYa9ug8m07yj
        d12xg0dnhKk/Q
X-Received: by 2002:aa7:dc55:: with SMTP id g21mr3502239edu.210.1569503552722;
        Thu, 26 Sep 2019 06:12:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqysfFqzMbAq1fGirMk9DgRDRLRtTNc1nuTuicrYtY2auNcoAVtqtld52F8WV3y9rTJF1aK0JQ==
X-Received: by 2002:aa7:dc55:: with SMTP id g21mr3502211edu.210.1569503552480;
        Thu, 26 Sep 2019 06:12:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id n1sm231174ejc.16.2019.09.26.06.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 06:12:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CE5CE18063D; Thu, 26 Sep 2019 15:12:30 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: Are BPF tail calls only supposed to work with pinned maps?
In-Reply-To: <20190926125347.GB6563@pc-63.home>
References: <874l0z2tdx.fsf@toke.dk> <20190926125347.GB6563@pc-63.home>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 26 Sep 2019 15:12:30 +0200
Message-ID: <87zhir19s1.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: KtsrOmYPNPi9tc63VLrIvg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> Hi Toke,
>
> On Thu, Sep 26, 2019 at 01:23:38PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
> [...]
>> While working on a prototype of the XDP chain call feature, I ran into
>> some strange behaviour with tail calls: If I create a userspace program
>> that loads two XDP programs, one of which tail calls the other, the tail
>> call map would appear to be empty even though the userspace program
>> populates it as part of the program loading.
>>=20
>> I eventually tracked this down to this commit:
>> c9da161c6517 ("bpf: fix clearing on persistent program array maps")
>
> Correct.
>
>> Which clears PROG_ARRAY maps whenever the last uref to it disappears
>> (which it does when my loader exits after attaching the XDP program).
>>=20
>> This effectively means that tail calls only work if the PROG_ARRAY map
>> is pinned (or the process creating it keeps running). And as far as I
>> can tell, the inner_map reference in bpf_map_fd_get_ptr() doesn't bump
>> the uref either, so presumably if one were to create a map-in-map
>> construct with tail call pointer in the inner map(s), each inner map
>> would also need to be pinned (haven't tested this case)?
>
> There is no map in map support for tail calls today.

Not directly, but can't a program do:

tail_call_map =3D bpf_map_lookup(outer_map, key);
bpf_tail_call(tail_call_map, idx);

>> Is this really how things are supposed to work? From an XDP use case PoV
>> this seems somewhat surprising...
>>=20
>> Or am I missing something obvious here?
>
> The way it was done like this back then was in order to break up cyclic
> dependencies as otherwise the programs and maps involved would never get
> freed as they reference themselves and live on in the kernel forever
> consuming potentially large amount of resources, so orchestration tools
> like Cilium typically just pin the maps in bpf fs (like most other maps
> it uses and accesses from agent side) in order to up/downgrade the agent
> while keeping BPF datapath intact.

Right. I can see how the cyclic reference thing gets thorny otherwise.
However, the behaviour was somewhat surprising to me; is it documented
anywhere?

I think I'll probably end up creating a new map type for chaining
programs anyway, so this is not a huge show-stopper for me; but it had
me scratching my head for a while there... ;)

-Toke

