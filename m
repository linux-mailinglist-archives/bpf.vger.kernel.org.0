Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32365328333
	for <lists+bpf@lfdr.de>; Mon,  1 Mar 2021 17:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbhCAQOU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Mar 2021 11:14:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35962 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237513AbhCAQMF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Mar 2021 11:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614615032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8c36pkCtyN4CLfbJiUbjXLv8s76s8DQupsd9r9qB1M=;
        b=gXE/PoOznbDaHlvnmHsz+f/yO+30Aqb6+faNzCXgZg4a3WQoYppCIPnQmReBF8mIqAoTut
        JA13UFW8QFf68tlBKNfmMBTLerL0hcfjZ/l7bK+3QlTCzpxEO2PdfGdY3WR9oZF3QHmdPd
        IYFBnG0b2O4pUSlexgyeNhtEFVa57Zk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-jj-SgU-POaWdHpRywmxSBA-1; Mon, 01 Mar 2021 11:10:31 -0500
X-MC-Unique: jj-SgU-POaWdHpRywmxSBA-1
Received: by mail-ej1-f72.google.com with SMTP id rl7so1527010ejb.16
        for <bpf@vger.kernel.org>; Mon, 01 Mar 2021 08:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=I8c36pkCtyN4CLfbJiUbjXLv8s76s8DQupsd9r9qB1M=;
        b=FUuZzE1PAc00mSgveWIN1vJ098SF01igIcyZP329Pm7m8/QKuBTJxDBhF1hDwvvGzN
         zAmseHhMlUHCw1qeboPTeVrrHblIsvJv3qgvCA0kN49L4HY3qDl1fF7XQIsStgz2XxY9
         EpBC5P3/z5wQOqPguYuxHEHytgyl3BIJFQVUnFY/6KExxOQuqQbc0b9Kme5PzUeO/jhY
         SLLaMHUj68ghoAw2Cyh+v0TMvR5q6IlzhX9pFTv7YA5bm08ojoZMXE7es8BAUgcVjcZs
         Nw2X+EwqfHilQ6VEGj63+rmYKfexSCV/MHxPDn3VyjifxK9Q+05vSI3Sw0QqUX22HTHt
         RCnw==
X-Gm-Message-State: AOAM530R4DlWWmvwOWwNUABfhmGlqADsLNYrgFfZ7Jkh1NkV1GEongWg
        ulMjU/tXdGq/3/9+xzx4VJwCsRhFK5lLEVu9UlilFPjBjLH5Qlh2Ciory19wGMyf4Ov6b5OXYlq
        9+v0corGutF51
X-Received: by 2002:a17:906:4d18:: with SMTP id r24mr13286021eju.493.1614615030180;
        Mon, 01 Mar 2021 08:10:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwg0VI0o+9gqz8X/y2IF8Ux4tSftLQrrJu2j8l6qUsTwkeFP33V3tzX4SUGPpcbw2CJOtYR/A==
X-Received: by 2002:a17:906:4d18:: with SMTP id r24mr13285999eju.493.1614615030016;
        Mon, 01 Mar 2021 08:10:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v11sm15125001eds.14.2021.03.01.08.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 08:10:29 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1571C1800F1; Mon,  1 Mar 2021 17:10:29 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, jonathan.lemon@gmail.com,
        maximmi@nvidia.com, andrii@kernel.org
Subject: Re: [PATCH bpf-next 2/2] libbpf, xsk: add libbpf_smp_store_release
 libbpf_smp_load_acquire
In-Reply-To: <20210301104318.263262-3-bjorn.topel@gmail.com>
References: <20210301104318.263262-1-bjorn.topel@gmail.com>
 <20210301104318.263262-3-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 01 Mar 2021 17:10:29 +0100
Message-ID: <87k0qqx3be.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> Now that the AF_XDP rings have load-acquire/store-release semantics,
> move libbpf to that as well.
>
> The library-internal libbpf_smp_{load_acquire,store_release} are only
> valid for 32-bit words on ARM64.
>
> Also, remove the barriers that are no longer in use.

So what happens if an updated libbpf is paired with an older kernel (or
vice versa)?

-Toke

