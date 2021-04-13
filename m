Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A6335DA5F
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 10:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhDMIwm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 04:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243794AbhDMIwm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 04:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618303942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kjct/9tMLpfU8qtWm99uGAk1krrViFOKvgxUEhM+mYU=;
        b=eU8riaE4rmUcPipuiSvqlVlSxXB7QCdpTdGg61UGbFqYzn8Vomp1ZuYwFHF2Uug6TWqOBN
        1tT8zz6wFsWScemqi2LMNUcYkNVpnFJCA+7MxonXnOHNaElhfHkFX8REmfjXOOA7PCqcLj
        9p2srJ24AJDmtOd4M9JZ11Dun8LHmrQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-RU-CK-RXOxyAwKaZ7kPdpg-1; Tue, 13 Apr 2021 04:52:21 -0400
X-MC-Unique: RU-CK-RXOxyAwKaZ7kPdpg-1
Received: by mail-ed1-f72.google.com with SMTP id c5-20020aa7d6050000b02903825f4da4f3so909492edr.16
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 01:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=kjct/9tMLpfU8qtWm99uGAk1krrViFOKvgxUEhM+mYU=;
        b=CFi7XeW48c3aHNnOpI+YbKmsbRJDGGbpGIATJvSSiDraZ39fHB64BucTfNQe7x3RTE
         xgcShG2qWtYuXWQQoqvegLaewlDQlnhCnPmbE7VpUOOwY3Q32E7Igkhs6uD0u0Ggo7cG
         ZTY8eDuBcostSaawWMp5/lQolXim6VSWZL8KUiy04UF75vNciD/oIcnmAriLhC2sMz0f
         iRgnkQClZXtVDTNMSBnZpseGCIE4ggCf7RCZ9r+4NhNhktvixYru3Y/k2FaRJVoXpSmp
         6RnTJoMytWuaNkvqCfdN9SZLsH7+myhtePw1wPmEYCL9MMPD/bz1y/gVF9BMSo4Gl0rO
         53Ng==
X-Gm-Message-State: AOAM5316I/9Mt6EA4TLBLEk52zfeVvY8KYGaIitlvDkz5INnxHLc2OQK
        TEu7nyW8ObOSuzapU/BbI8YYF9zG/PnvDO+WzAjE/vTDRUUQZSwZdR5sCDOI4TVRJAr8XCNZ9vM
        kpt7k9WOlh+Qe
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr8254723ejb.542.1618303939614;
        Tue, 13 Apr 2021 01:52:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/nRfoUOop0dClCiv0HnYnUSkEwU82VOMbl/CIBixNp0Ojkad2005fMKtHZAOmjZmQmTasyA==
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr8254691ejb.542.1618303939127;
        Tue, 13 Apr 2021 01:52:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id m14sm8678611edd.63.2021.04.13.01.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 01:52:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9838A1804E8; Tue, 13 Apr 2021 10:52:17 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add tests for target
 information in bpf_link info queries
In-Reply-To: <CAEf4BzaZ8nAAqs8twnqCtSvmxsDvKBDUaYw+s+CcOnZyYo=0Vw@mail.gmail.com>
References: <20210408195740.153029-1-toke@redhat.com>
 <20210408195740.153029-2-toke@redhat.com>
 <CAEf4BzaZ8nAAqs8twnqCtSvmxsDvKBDUaYw+s+CcOnZyYo=0Vw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 13 Apr 2021 10:52:17 +0200
Message-ID: <87eefeo9by.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Apr 8, 2021 at 12:57 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Extend the fexit_bpf2bpf test to check that the info for the bpf_link
>> returned by the kernel matches the expected values.
>>
>> While we're updating the test, change existing uses of CHEC() to use the
>> much easier to read ASSERT_*() macros.
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>
> Just a minor nit below. Looks good, thanks.

Right, will fix those and respin - thanks! :)

-Toke

