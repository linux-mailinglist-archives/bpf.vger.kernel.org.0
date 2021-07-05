Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7BD3BBB48
	for <lists+bpf@lfdr.de>; Mon,  5 Jul 2021 12:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhGEKfx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Jul 2021 06:35:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231128AbhGEKfu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 5 Jul 2021 06:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625481193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9kAkedCnhjEK0sIJXrBd38PA3bwhHRpR3SisBIAqIAs=;
        b=Be7NJz43FJY4lKsjHCmIOguoeMvJXDS9eQLjo31MN3ruC4wcg6EAj3OzHHmUZchd+PWZDZ
        lmQXQAvHBh62UJZUrlBnQSjma2s7oXmFWgOo73Q1723ZBRDnvOXl8HVJitiRXQEInSX9JH
        w/5qK8or52G4PeX1K4cyQweP45KfRVE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-TNh1ypDKPTaCtOYwVbB0CA-1; Mon, 05 Jul 2021 06:33:12 -0400
X-MC-Unique: TNh1ypDKPTaCtOYwVbB0CA-1
Received: by mail-ed1-f72.google.com with SMTP id cn11-20020a0564020cabb0290396d773d4c7so4065840edb.18
        for <bpf@vger.kernel.org>; Mon, 05 Jul 2021 03:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9kAkedCnhjEK0sIJXrBd38PA3bwhHRpR3SisBIAqIAs=;
        b=FkM/NaMUSYqiP1Hav1VPPBWUSaFbiM/2Ap1WFQdEcZuoEx7PdCSifWMHYMxIS1b+vp
         7bCxh7EciXgN2V/F3WFvSOWtEDOpofMi6PsHfOdYGbYXl+MHw+szCBN75CB3pUKUeBZm
         wbG6kTGQ8+DOibplzAJFD1xktfJAf4wDERKBd+pZJAXzLvpvIb3sblF18Qew6R7UNJIm
         RceYnWdBUlRod1COEuzt2dPIVm0h4LBMSRiykPyYi2xLTwicKwsxENidRET89l3Q41In
         GQiEMZyrJzKn39NVBVBeBS41hhgr9I/IXYOEeUhTwf11X8+6eS7G1TxnMwBvaJyf8Zc1
         jXYw==
X-Gm-Message-State: AOAM531ywcjhv6Tc9ydASrvQfxTVMd5dtv2mrtk40sg6fgVbEMW/IuPd
        bwsQ1pvDDyjTgDvOtUHDq1fNAatNRWPxKZVASM2HrFCSPi7zFNr55K6q9jYsnVivnPJh/ity1Y1
        PUBvHa+ag7VEJ
X-Received: by 2002:a05:6402:1d25:: with SMTP id dh5mr15616011edb.355.1625481190563;
        Mon, 05 Jul 2021 03:33:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw477+XlnSb8fOKkMYmWXPMweRQkIMjIXsFTPyNgKj7RYTdDaNExdGmvb358k+9Eo+BIngwdQ==
X-Received: by 2002:a05:6402:1d25:: with SMTP id dh5mr15615999edb.355.1625481190426;
        Mon, 05 Jul 2021 03:33:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id zn21sm4183686ejb.78.2021.07.05.03.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 03:33:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4394118072E; Mon,  5 Jul 2021 12:33:09 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next] libbpf: ignore .eh_frame sections when parsing
 elf files
In-Reply-To: <ac14ef3c-ccd5-5f74-dda5-1d9366883813@iogearbox.net>
References: <20210629110923.580029-1-toke@redhat.com>
 <ac14ef3c-ccd5-5f74-dda5-1d9366883813@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 05 Jul 2021 12:33:09 +0200
Message-ID: <87czrxyrru.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 6/29/21 1:09 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> The .eh_frame and .rel.eh_frame sections will be present in BPF object
>> files when compiled using a multi-stage compile pipe like in samples/bpf.
>> This produces errors when loading such a file with libbpf. While the err=
ors
>> are technically harmless, they look odd and confuse users. So add .eh_fr=
ame
>> sections to is_sec_name_dwarf() so they will also be ignored by libbpf
>> processing. This gets rid of output like this from samples/bpf:
>>=20
>> libbpf: elf: skipping unrecognized data section(32) .eh_frame
>> libbpf: elf: skipping relo section(33) .rel.eh_frame for section(32) .eh=
_frame
>>=20
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>
> For the samples/bpf case, could we instead just add a -fno-asynchronous-u=
nwind-tables
> to clang as cflags to avoid .eh_frame generation in the first place?

Ah, great suggestion! Was trying, but failed, to figure out how to do
that. Just tested it, and yeah, that does fix samples; will send a
separate patch to add that.

I still think filtering this section name in libbpf is worthwhile,
though, as the error message is really just noise... WDYT?

-Toke

