Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7053BC0003
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2019 09:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfI0H1z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Sep 2019 03:27:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58198 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725820AbfI0H1y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Sep 2019 03:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569569273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCiWg7UjUdulJm0B8U7YHZnt9sksxapjetLgy8pdzo8=;
        b=H2qSqfnk7VGJbGEIQEaagqlvmeEfpaBToTvdxbHuSbgCzPIdbezwYP2sJ+fKoJcepSJtT4
        WugqTQh4vJttr9/zyxhvtsqys03FXf0V4akBPrHmqnUz5BrXOgxBtlZPJ3jzpR77URUeIy
        SUhkqA1xa8Bm2KSHuxTYE6JoYW+NBmU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-6WjDmQVKNYix6gzCV6oe-Q-1; Fri, 27 Sep 2019 03:27:52 -0400
Received: by mail-lf1-f72.google.com with SMTP id f3so1191443lfa.16
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2019 00:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Y0+F3dpgEor0cGD/eDnJjGwWJI9IkOz05Hreggijlh8=;
        b=TOuKjVmm3GbOAF6Rgdw0G0tQMet4S/64W6P3xKnIJ6A4Xb59auup0NnfPwtdUuzNs8
         qYxZ8Sy8JZDOe781I/EoirBJaWKatVurMvV4KvfnVgwvOnOJiConMwB6mWVTx54f7fbA
         GnTa1HlNfvXLXnPhWdAe48KwoBI+MAvNpErunVaDk4ZwkMZtkgpH2zW5Eu2s4gpGGgFG
         27vD++AudrwfkvuZZW4aARmpO4jumjMY+XBSZhuLCnxeDahC5CxhNNBWs7iDwba541ks
         E3VDMIQM87Wd3cbycj8JwvdeiVw21nKgHYbBsPgEZ0FWJPr70dHQ2HMW0/miWnII7C7u
         df8g==
X-Gm-Message-State: APjAAAU4PUQSdWmfQCJWAtiz+kWmnnkzdYcPQr51HwNTQErwAbu+MSwT
        e6bSvRIHtjzt59wSSeaRQBk/Dz9JwIu+Zz2vR98oj1eSLZ9eLD0sjtKn0P/jzFrjJ8Md0zZJUE9
        EgAaZHCNYWn95
X-Received: by 2002:a2e:9a50:: with SMTP id k16mr1764878ljj.221.1569569270266;
        Fri, 27 Sep 2019 00:27:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwlVfRi8pgIgvNKWrXZvygEFVc0ZijPED3IkW6kpgEt7nt34YcMWk9wvluDWTSKtyzrj8ui6w==
X-Received: by 2002:a2e:9a50:: with SMTP id k16mr1764872ljj.221.1569569270073;
        Fri, 27 Sep 2019 00:27:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id b25sm338437ljj.36.2019.09.27.00.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 00:27:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 756DC18063D; Fri, 27 Sep 2019 09:27:48 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: Are BPF tail calls only supposed to work with pinned maps?
In-Reply-To: <20190926181457.GA6818@pc-63.home>
References: <874l0z2tdx.fsf@toke.dk> <20190926125347.GB6563@pc-63.home> <87zhir19s1.fsf@toke.dk> <20190926181457.GA6818@pc-63.home>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 27 Sep 2019 09:27:48 +0200
Message-ID: <87blv619mz.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 6WjDmQVKNYix6gzCV6oe-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On Thu, Sep 26, 2019 at 03:12:30PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Daniel Borkmann <daniel@iogearbox.net> writes:
>> > On Thu, Sep 26, 2019 at 01:23:38PM +0200, Toke H=C3=B8iland-J=C3=B8rge=
nsen wrote:
>> > [...]
>> >> While working on a prototype of the XDP chain call feature, I ran int=
o
>> >> some strange behaviour with tail calls: If I create a userspace progr=
am
>> >> that loads two XDP programs, one of which tail calls the other, the t=
ail
>> >> call map would appear to be empty even though the userspace program
>> >> populates it as part of the program loading.
>> >>=20
>> >> I eventually tracked this down to this commit:
>> >> c9da161c6517 ("bpf: fix clearing on persistent program array maps")
>> >
>> > Correct.
>> >
>> >> Which clears PROG_ARRAY maps whenever the last uref to it disappears
>> >> (which it does when my loader exits after attaching the XDP program).
>> >>=20
>> >> This effectively means that tail calls only work if the PROG_ARRAY ma=
p
>> >> is pinned (or the process creating it keeps running). And as far as I
>> >> can tell, the inner_map reference in bpf_map_fd_get_ptr() doesn't bum=
p
>> >> the uref either, so presumably if one were to create a map-in-map
>> >> construct with tail call pointer in the inner map(s), each inner map
>> >> would also need to be pinned (haven't tested this case)?
>> >
>> > There is no map in map support for tail calls today.
>>=20
>> Not directly, but can't a program do:
>>=20
>> tail_call_map =3D bpf_map_lookup(outer_map, key);
>> bpf_tail_call(tail_call_map, idx);
>
> Nope, that is what I meant, bpf_map_meta_alloc() will bail out in that
> case.

Oohhh, right. Seems I reversed that if statement in my head. Silly me,
thanks for clarifying!

>> >> Is this really how things are supposed to work? From an XDP use case =
PoV
>> >> this seems somewhat surprising...
>> >>=20
>> >> Or am I missing something obvious here?
>> >
>> > The way it was done like this back then was in order to break up cycli=
c
>> > dependencies as otherwise the programs and maps involved would never g=
et
>> > freed as they reference themselves and live on in the kernel forever
>> > consuming potentially large amount of resources, so orchestration tool=
s
>> > like Cilium typically just pin the maps in bpf fs (like most other map=
s
>> > it uses and accesses from agent side) in order to up/downgrade the age=
nt
>> > while keeping BPF datapath intact.
>>=20
>> Right. I can see how the cyclic reference thing gets thorny otherwise.
>> However, the behaviour was somewhat surprising to me; is it documented
>> anywhere?
>
> Haven't updated the BPF guide in a while [0], I don't think I
> documented this detail back then, so right now only in the git log.
> Improvements to the reference guide definitely welcome.

Gotcha. I guess we should add something about tail calls (and chain
calls once we get them) to the XDP tutorial as well...

-Toke

