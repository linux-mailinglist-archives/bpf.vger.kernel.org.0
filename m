Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8662CB9DC
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 10:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388463AbgLBJ5F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 04:57:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388389AbgLBJ5D (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Dec 2020 04:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606902936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GTdHhx4SS0ruAGPviFYgmLqy6rqHBMqdUWgmr00VutI=;
        b=Gi/fsQe/nhb91qDc9WptEYgouSnpZjamxJivxlJfk+ZWJYCACu+E4As4dFkN5tI/35QE2s
        96eNY9QnDt3ntziHRi2Vx7tkrlHM7pIDdi8iMm9yeIvRivxIjuK0PaEciEx4HZl2btwaxT
        wTe8jiMaZsvGWI4CO8RR4ks0O+7oC7E=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-OJiYZEkNNhGMKPoNgnZygw-1; Wed, 02 Dec 2020 04:55:35 -0500
X-MC-Unique: OJiYZEkNNhGMKPoNgnZygw-1
Received: by mail-qt1-f198.google.com with SMTP id y5so957444qtb.13
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 01:55:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=GTdHhx4SS0ruAGPviFYgmLqy6rqHBMqdUWgmr00VutI=;
        b=kqYE7WnyqqxeAGw9cRVzaKslwUEV9sPselN9RztnuuFa7Fm+JpEax+QjAvyviVJc1A
         2ntKvBMwjRbC8oFGDVI7NYoVtKwiepUE1soH9lwd4MR+sSRR47nTLEpOFutkWFQRFypY
         ywKmYspKjT5KnQ+rTheX9lVvTdhegiXQKg0HqkvGTh+b2KnBJ8FieKLU2j+3vy5I+28h
         YBswaVjtqCtKJJZ3XXEpdTUWQb8hsuxwWOo4rLHpuCLUGVYD7ac7OoF99wPrYKm5KYg7
         j8/4e9cxB1MWSCy9jjOJWTNlHOpZaGfz0QFRkdhOjQZ0/dTN+a77a/SeZe5nG0U+lKbT
         Or6g==
X-Gm-Message-State: AOAM530hzemBuTkChYLQ7VMZA1rbcWU2sX854sGAceP6p2/H+AbMBZMW
        q86TqLPA6E5gn3HaUT2IYqQWmDH0KcXhDfN1oCyb9q6Z6+njGUpviYRtQavvVPqk8pT5sNEG9FX
        cMJ7AMTXuSI72
X-Received: by 2002:ad4:4807:: with SMTP id g7mr1755302qvy.26.1606902934582;
        Wed, 02 Dec 2020 01:55:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBHzQR/4Voy0A86XcmxRKjTC+xG2CcogcWu3CTnsGlRmotHDJhNuzNi2RWoJe2cf1bkNlHdw==
X-Received: by 2002:ad4:4807:: with SMTP id g7mr1755291qvy.26.1606902934420;
        Wed, 02 Dec 2020 01:55:34 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o125sm1261383qke.56.2020.12.02.01.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:55:33 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 51F31182EE9; Wed,  2 Dec 2020 10:55:32 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf] libbpf: sanitise map names before pinning
In-Reply-To: <CAEf4BzYKWnNQqLOxgUaj=qOP15wpMY8axYxfRDukvw8Wypbjgw@mail.gmail.com>
References: <20201130161720.8688-1-toke@redhat.com>
 <CAEf4BzYKWnNQqLOxgUaj=qOP15wpMY8axYxfRDukvw8Wypbjgw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 02 Dec 2020 10:55:32 +0100
Message-ID: <87r1o8cz1n.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Nov 30, 2020 at 8:17 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> When we added sanitising of map names before loading programs to libbpf,=
 we
>> still allowed periods in the name. While the kernel will accept these for
>> the map names themselves, they are not allowed in file names when pinning
>
> That sounds like an unnecessary difference in kernel behavior. If the
> kernel allows maps with '.' in the name, why not allow to pin it?
> Should we fix that in the kernel?

Yeah, it is a bit odd. I always assumed the restriction in file names is
to prevent people from creating hidden (.-prefixed) files in bpffs? But
don't actually know for sure. Anyway, if that is the case we could still
allow periods in the middle of names.

I'm certainly not opposed to changing the kernel behaviour and I can
follow up with a patch for this if others agree; but we obviously still
need this for older kernels so I'll send a v2 with the helper method you
suggested below.

-Toke

