Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D242B39EC46
	for <lists+bpf@lfdr.de>; Tue,  8 Jun 2021 04:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFHCnt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Jun 2021 22:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230356AbhFHCnt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Jun 2021 22:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623120116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LS9MPOo2/ojiu7kIP7p+GegYfzW1VZ9cbFAAv95P3PM=;
        b=g1+jgKIhX90pAbgl9Yx9v59NQQa4eBOla/UFpBiqLE5q38sBDIxnKlU48AV5HOJdB2r8u/
        Bdg0mtOt/+/mSvsH2L5I6sF3CHnNebqaCgcTRfBU3jdTwEdGYM6p8ICeqrAnEqVQaiaOJi
        gr6ABCTK4x+j7CqFj2XO7xXUZSeZq+4=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-Kh9A10-9MKC8xzE18tB-4w-1; Mon, 07 Jun 2021 22:41:55 -0400
X-MC-Unique: Kh9A10-9MKC8xzE18tB-4w-1
Received: by mail-oi1-f199.google.com with SMTP id 82-20020aca04550000b02901f40670cf75so2471036oie.19
        for <bpf@vger.kernel.org>; Mon, 07 Jun 2021 19:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LS9MPOo2/ojiu7kIP7p+GegYfzW1VZ9cbFAAv95P3PM=;
        b=mT3n4vD/Wb2UQcU4Xr+VU+7lEVasVaCKvFhLHHplyCdRlGSbmLYu+F+mkVDOEVHnTw
         oVzEUsbnqMVw12SPzJ06JCman/XVm/7ri5x2CaVfmklGTx4bmW1cn38WJMcv4llnoYM/
         VZAenTJTWIRMzmY3PuNknYrd4esWkw/MwQIaOMTkIRPU+p8aJk7X1j1bAxVuCnU2D++v
         IWnfIE7CYAR975RsF7Q2Y3q9Z/9K1xcSL/XQd98vgPpvmb3DlugF0nh5PU6wUAL13ipu
         tUbMwnXpmnsgkZc1ZqKSSZM8Rkz8DGSF1zu991gvD2NIObXd4yPxGzK5szxovi5vWzbu
         5t4Q==
X-Gm-Message-State: AOAM530Hw7iCNhJRlOzSSnsX0Sx0mSd3r85DSv4SpnPLbVgSVmHT5pbD
        /2B8XuzgD3gyJrgLhoj9/dpQYHqSyTvh1v+I1xTw8aJuVvIIzrXdE0qicK3Iii7ZZgpOPnL+/dR
        WVu/ogkfa+qNw
X-Received: by 2002:a9d:2222:: with SMTP id o31mr1805130ota.75.1623120114752;
        Mon, 07 Jun 2021 19:41:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKZ3AbF0qHrhjEiraN2K+mE4Zp7IdUftrcNmGj5zoIwrC01qVvhjDFx5msnrxpqVq0I71EZg==
X-Received: by 2002:a9d:2222:: with SMTP id o31mr1805117ota.75.1623120114505;
        Mon, 07 Jun 2021 19:41:54 -0700 (PDT)
Received: from tstellar.remote.csb (97-120-191-69.ptld.qwest.net. [97.120.191.69])
        by smtp.gmail.com with ESMTPSA id k84sm2616111oia.8.2021.06.07.19.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 19:41:54 -0700 (PDT)
Subject: Re: [PATCH v2 bpf-next 06/11] libbpf: add BPF static linker APIs
From:   Tom Stellard <tstellar@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@fb.com>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>
References: <20210313193537.1548766-7-andrii@kernel.org>
 <20210607231146.1077-1-tstellar@redhat.com>
 <CAEf4Bzad7OQj9JS7GVmBjAXyxKcc-nd77gxPQfFB8_hy_Xo+_g@mail.gmail.com>
 <b1bdf1df-e3a8-1ce8-fc33-4ab40b39fb06@redhat.com>
Message-ID: <84b3cb2c-2dff-4cd8-724c-a1b56316816b@redhat.com>
Date:   Mon, 7 Jun 2021 19:41:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <b1bdf1df-e3a8-1ce8-fc33-4ab40b39fb06@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/7/21 5:25 PM, Andrii Nakryiko wrote:
> On Mon, Jun 7, 2021 at 4:12 PM Tom Stellard <tstellar@redhat.com> wrote:
>>
>>
>> Hi,
>>
>>> +                               } else {
>>> +                                       pr_warn("relocation against STT_SECTION in non-exec section is not supported!\n");
>>> +                                       return -EINVAL;
>>> +                               }
>>
>> Kernel build of commit 324c92e5e0ee are failing for me with this error
>> message:
>>
>> /builddir/build/BUILD/kernel-5.13-rc4-61-g324c92e5e0ee/linux-5.13.0-0.rc4.20210603git324c92e5e0ee.35.fc35.x86_64/tools/bpf/bpftool/bpftool gen object /builddir/build/BUILD/kernel-5.13-rc4-61-g324c92e5e0ee/linux-5.13.0-0.rc4.20210603git324c92e5e0ee.35.fc35.x86_64/tools/testing/selftests/bpf/bind_perm.linked1.o /builddir/build/BUILD/kernel-5.13-rc4-61-g324c92e5e0ee/linux-5.13.0-0.rc4.20210603git324c92e5e0ee.35.fc35.x86_64/tools/testing/selftests/bpf/bind_perm.o
>> libbpf: relocation against STT_SECTION in non-exec section is not supported!
>>
>> What information can I provide to help debug this failure?
>
> Can you please send that bind_perm.o file? Also what's your `clang
> --version` output?
>
  
clang version 12.0.0 (Fedora 12.0.0-2.fc35)
  
>> I suspect this might be due to Clang commit 6a2ea84600ba ("BPF: Add
>> more relocation kinds"), but I get a different error on 324c92e5e0ee.
>> So meanwhile you might try applying 9f0c317f6aa1 ("libbpf: Add support
>> for new llvm bpf relocations") from bpf-next/master and check if that
>> helps. But please do share bind_perm.o, just to double-check what's
>> going on.
>>
  
Here is bind_perm.o: https://fedorapeople.org/~tstellar/bind_perm.o

Thanks,
Tom
  
>>
>>>
>>> Thanks,
>>> Tom
>>>
>>
> 

