Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14174375BF
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhJVK5H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 06:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232575AbhJVK5H (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 22 Oct 2021 06:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634900089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=okT+nghV6LZUh40pM7SbRBQZZKy9WPEhwzp7K4ZbI3k=;
        b=eKZUP5B4WE5ErtB9nOyPDf4buqMntp5wTNbt9CgAc2WYDpV4YQj4sIx+j6H0w9KjkdSX1K
        8n7qO8bVKP5Gu0cKXUcKUgIkVslCyaDUWqx3ObtBbRW4+mmd6PxEN1JjjVQR3m/UwxoILY
        LUGf3BMvCd0TwyAkkfjul32hexkP0Bc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-F5j2WwnrNV6Efmbv2lBueA-1; Fri, 22 Oct 2021 06:54:48 -0400
X-MC-Unique: F5j2WwnrNV6Efmbv2lBueA-1
Received: by mail-ed1-f71.google.com with SMTP id c30-20020a50f61e000000b003daf3955d5aso2588343edn.4
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 03:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=okT+nghV6LZUh40pM7SbRBQZZKy9WPEhwzp7K4ZbI3k=;
        b=JEubZG6mv+2q+AMHHwFSCq1GxdL0Fh5YiIB9vLXWAoTltBULkbKey5RFtLh4qmHmPQ
         B3tenCKMlbMYo8OH4Zj7f31zpjk8xuh8/D8VGBwP7NVtFvL5MAEA8b0kNQXQJ1VkZK5m
         DzOiCPePHtc1slNOyzO4YAWofwds1tgz6QdiX6tS1jIxbCdpHyMS2ckR3PPUdxZ7kSFs
         1tpfYV8FyFW2yRT1nBbYWNv+QFC5x6MfYVjY/bgGqmZ5VG0r7ue2SMXgKHw2lSbKpt3O
         QKwwWTYpZve48RRHIAa3sjrXQjouGRLSQDR8cprbEYE3VGof+3qynITHiROd+4NdLocn
         Oc7g==
X-Gm-Message-State: AOAM532NWW4bI01Eb9MMUUMGvQ5OYelL/6eODKFb5eNfVtJ0Hwz692f3
        Hbj9CjuHIYk8qWrhs4812KGG0AHlmnr7CVGiUiw5SsuD/43GmOJjmSBQMDcSSzlCRAGx5t/oswJ
        EB1YQRAlhUpSm
X-Received: by 2002:a17:906:2346:: with SMTP id m6mr14311684eja.512.1634900086927;
        Fri, 22 Oct 2021 03:54:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwl0QdgFcH76HS5dJ0OuQUBWbPNyca2xQaZHIy7y9K34vvpDDOWGwI/TgP7QJNAEOPVQ7fnYw==
X-Received: by 2002:a17:906:2346:: with SMTP id m6mr14311650eja.512.1634900086587;
        Fri, 22 Oct 2021 03:54:46 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q9sm3647708ejf.70.2021.10.22.03.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 03:54:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7F2E6180262; Fri, 22 Oct 2021 12:54:45 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: [PATCH bpf] bpf: fix potential race in tail call compatibility
 check
In-Reply-To: <CAADnVQLPBLc0T32nqM7Q_LBEGWiJRp3JvGaY2Lsmf9yqJW+Yfw@mail.gmail.com>
References: <20211021183951.169905-1-toke@redhat.com>
 <CAADnVQLPBLc0T32nqM7Q_LBEGWiJRp3JvGaY2Lsmf9yqJW+Yfw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 22 Oct 2021 12:54:45 +0200
Message-ID: <87mtn1cosq.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Oct 21, 2021 at 11:40 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>> +       map_type =3D READ_ONCE(array->aux->type);
>> +       if (!map_type) {
>> +               /* There's no owner yet where we could check for compati=
bility.
>> +                * Do an atomic swap to prevent racing with another invo=
cation
>> +                * of this branch (via simultaneous map_update syscalls).
>>                  */
>> -               array->aux->type  =3D fp->type;
>> -               array->aux->jited =3D fp->jited;
>> +               if (cmpxchg(&array->aux->type, 0, prog_type))
>> +                       return false;
>
> Other fields might be used in the compatibility check in the future.
> This hack is too fragile.
> Just use a spin_lock.

Well, yeah, we're adding another field for xdp_mb. I was just going to
eat more bits of the 'type' field, but OK, can switch to a spinlock
instead :)

-Toke

