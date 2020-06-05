Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB53A1EF5FF
	for <lists+bpf@lfdr.de>; Fri,  5 Jun 2020 13:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgFELBI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Jun 2020 07:01:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49515 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726950AbgFELBH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Jun 2020 07:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591354865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=99VNPYJGoMPl79e21WOZdb+KAZocUbilTfddS29tBis=;
        b=EMrUf8eV50QDlKmjTPF7TXEYpAZTcj2nGGcteieg1bOQG+SMrL2cXnK9/gUyNRjkbp0AC/
        eW/VLrhxyPKbZrRHneuCuqMZpNbQZBiRYua+qQ+q6tmjM1ZQRjz2hBbYt47ncitDZYBccR
        QBXF8ZY5DqcFR4v8AWe9QNoCd0Mnyio=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-Tx9W51jJP5yMGV5XyGSK2Q-1; Fri, 05 Jun 2020 07:01:03 -0400
X-MC-Unique: Tx9W51jJP5yMGV5XyGSK2Q-1
Received: by mail-ej1-f69.google.com with SMTP id bo19so3469319ejb.0
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2020 04:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=99VNPYJGoMPl79e21WOZdb+KAZocUbilTfddS29tBis=;
        b=G25zBSuLjcVHrL0aR5FL0D95Qvd8rn2qq3luj+QTFTRCShHAsB3xs49ZEIk+TEprVJ
         8mKEPRxeTWMAx5B5gukN4M4ghmEvzvETFS8XmNuJFy/4uF1fIH1BqFoUax/qHUMyQTrE
         bmVb9jXf+DMOw7XKNHIAtOot57NrkAlrt57oaq0/7qYLNCR+4dqXS04h2gPzswP7b3Z0
         nn3vchzQYYNXsREho2KRN97g5RxCbFkCf7tITOPAQQ2NXOsYxZEXxxymoLfOz6P0e7M3
         2zTqNKszbKUd0Nc+cw5xKWjA5uNbqnxHiwBPdFjqKfYtZe8Ygp4hHdGguXNKZEUgu1GA
         JWfA==
X-Gm-Message-State: AOAM531vE14sVjMOWNyfSeFWsHaxUivFMXOECpUxdBj11AxPET5ZB5vB
        vY1PVPrrQSN4rae0nsquzu72ohU6mmA8DzJ6g/QKc44FV7GGS8YD9QzzObgZCPuff6HhZ1qtvnI
        J+irwkwTuJXI8
X-Received: by 2002:aa7:d158:: with SMTP id r24mr8533232edo.272.1591354862322;
        Fri, 05 Jun 2020 04:01:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3FkyT1V4vxoO2SrH/qvQCMvKtyEkE41uXCPhuRSVuJBMRq0wXuv5atvbNLgcHzJTRm/uNKA==
X-Received: by 2002:aa7:d158:: with SMTP id r24mr8533193edo.272.1591354861927;
        Fri, 05 Jun 2020 04:01:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h8sm4703487edk.72.2020.06.05.04.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 04:01:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9910818200D; Fri,  5 Jun 2020 13:01:00 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Ahern <dsahern@gmail.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Daniel Borkmann <borkmann@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        David Miller <davem@davemloft.net>, brouer@redhat.com
Subject: Re: [PATCH bpf-next V1] bpf: devmap dynamic map-value area based on BTF
In-Reply-To: <20200605102323.15c2c06c@carbon>
References: <159119908343.1649854.17264745504030734400.stgit@firesoul> <20200603162257.nxgultkidnb7yb6q@ast-mbp.dhcp.thefacebook.com> <20200604174806.29130b81@carbon> <205b3716-e571-b38f-614f-86819d153c4e@gmail.com> <20200604173341.rvfrjmt433knl3uv@ast-mbp.dhcp.thefacebook.com> <20200605102323.15c2c06c@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 05 Jun 2020 13:01:00 +0200
Message-ID: <87y2p1dbf7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Thu, 4 Jun 2020 10:33:41 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
>> On Thu, Jun 04, 2020 at 10:40:06AM -0600, David Ahern wrote:
>> > On 6/4/20 9:48 AM, Jesper Dangaard Brouer wrote:  
>> > > I will NOT send a patch that expose this in uapi/bpf.h.  As I explained
>> > > before, this caused the issues for my userspace application, that
>> > > automatically picked-up struct bpf_devmap_val, and started to fail
>> > > (with no code changes), because it needed minus-1 as input.  I fear
>> > > that this will cause more work for me later, when I have to helpout and
>> > > support end-users on e.g. xdp-newbies list, as it will not be obvious
>> > > to end-users why their programs map-insert start to fail.  I have given
>> > > up, so I will not NACK anyone sending such a patch.  
>> 
>> Jesper,
>> 
>> you gave wrong direction to David during development of the patches and
>> now the devmap uapi is suffering the consequences.
>> 
>> > > 
>> > > Why is it we need to support file-descriptor zero as a valid
>> > > file-descriptor for a bpf-prog?  
>> > 
>> > That was a nice property of using the id instead of fd. And the init to
>> > -1 is not unique to this; adopters of the bpf_set_link_xdp_fd_opts for
>> > example have to do the same.  
>> 
>> I think it's better to adopt "fd==0 -> invalid" approach.
>> It won't be unique here. We're already using it in other places in bpf syscall.
>> I agree with Jesper that requiring -1 init of 2nd field is quite ugly
>> and inconvenient.
>
> Great. If we can remove this requirement of -1 init (and let zero mean
> feature isn't used), then I'm all for exposing expose in uapi/bpf.h.

If we're going to officially deprecate fd 0 as a valid BPF fd, we should
at least make sure users don't end up with such an fd after opening a
BPF object. Not sure how the fd number assignment works, but could we
make sure that the kernel never returns fd 0 for a BPF program/map?

Alternatively, we could add a check in libbpf and either reject the
call, or just call dup() before passing the fd to the kernel.

Right now it's quite trivial to get a BPF program ref with fd0 - all you
have to do is open a BPF program is the first thing you do after closing
stdin (like a daemon might). I'd really rather not have to help anyone
debug that...

-Toke

