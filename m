Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3123262B2
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 13:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBZM1y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 07:27:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhBZM1y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 07:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614342387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+HuZK9YuHtlamJ9bRf+S7put/fbfFDgLeI0Ia3hdfE=;
        b=P62NjlhXAyEctsMRx8j1hI/5Ut31gOgHra1G5WOkdYqwu8ItWPeWYcKxcmxg1ZTTDqqVLM
        pZEjrwG6NYgADmwXtf0rbTGyQ3aGwPG5EOoPjyk8/EJSbMP1TT1UCs48PcMKfPegJ7EnHS
        E+TgBkshW8aIElYL7dMC4sBPWKH5iyA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-Lgyy-LAaOlalPhCo929AQQ-1; Fri, 26 Feb 2021 07:26:25 -0500
X-MC-Unique: Lgyy-LAaOlalPhCo929AQQ-1
Received: by mail-ej1-f70.google.com with SMTP id h14so243974ejg.7
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 04:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=S+HuZK9YuHtlamJ9bRf+S7put/fbfFDgLeI0Ia3hdfE=;
        b=Jp5N2NJuHCPpsT/z8YAeRsCsiGRqF/8szP6+o+bx/CGo1S5v8wuugNISWKF8IjXZFT
         wQBaGJFDA2vQILReS4Jy83VbUhUQ4+02wCd4WhnKQaBIyKpcqNvnhAEhIv/FRhajYlD/
         0WgjEQx45CQbdMywqI2fboSYt1CZRoGb4ucaenwqvaZhJ4x7uWeyeVwSi8os8VM7k8iZ
         wUyrtdsIcQqC/6xKY5tjjExaxeGpLY1fYRVYbIn4A/tqm97wMIQcxzi8284Wwm6FjWP6
         60yEfeSu4S8f4J6AEqi+t1b5ZeRReK5Uow4j6qVbFcIVW2s0XvDR2WdguK/jhCCrWIYK
         ns2A==
X-Gm-Message-State: AOAM5309RZ1dYX6fjVEbb8/baQ+G3Cec//AZPANWrqW20XatG+KSTyUt
        ghufqubGn/kPWad4fWPXu1KSBmklnVjbkeuICvzCKX6hxWuR9DZ4nyTk15R31Dd9x06oUo8Q6xS
        vKuPHoQXde8CK
X-Received: by 2002:a17:906:27c7:: with SMTP id k7mr3123811ejc.13.1614342384607;
        Fri, 26 Feb 2021 04:26:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDnyLfpO4T5MsmhrTsPwwhPtU/Xk4tZfLzQHd4PS5Ff9w0zJYOy2fyIw3j6Z/fVgdfMoYfIw==
X-Received: by 2002:a17:906:27c7:: with SMTP id k7mr3123790ejc.13.1614342384251;
        Fri, 26 Feb 2021 04:26:24 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id bz25sm5342641ejc.97.2021.02.26.04.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 04:26:23 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 94B23180094; Fri, 26 Feb 2021 13:26:22 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     maciej.fijalkowski@intel.com, hawk@kernel.org,
        magnus.karlsson@intel.com, john.fastabend@gmail.com,
        kuba@kernel.org, davem@davemloft.net
Subject: Re: [PATCH bpf-next v4 1/2] bpf, xdp: make bpf_redirect_map() a map
 operation
In-Reply-To: <d4910425-82ae-b1ce-68c3-fb5542f598a5@intel.com>
References: <20210226112322.144927-1-bjorn.topel@gmail.com>
 <20210226112322.144927-2-bjorn.topel@gmail.com> <87sg5jys8r.fsf@toke.dk>
 <694101a1-c8e2-538c-fdd5-c23f8e2605bb@intel.com>
 <d4910425-82ae-b1ce-68c3-fb5542f598a5@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 26 Feb 2021 13:26:22 +0100
Message-ID: <87h7lzypzl.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com> writes:

> On 2021-02-26 12:40, Bj=C3=B6rn T=C3=B6pel wrote:
>> On 2021-02-26 12:37, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
> [...]
>
>>>
>>> (That last paragraph above is why I asked if you updated the performance
>>> numbers in the cover letter; removing an additional function call should
>>> affect those, right?)
>>>
>>=20
>> Yeah, it should. Let me spend some more time benchmarking on the DEVMAP
>> scenario.
>>
>
> I did a re-measure using samples/xdp_redirect_map.
>
> The setup is 64B packets blasted to an i40e. As a baseline,
>
>    # xdp_rxq_info --dev ens801f1 --action XDP_DROP
>
> gives 24.8 Mpps.
>
>
> Now, xdp_redirect_map. Same NIC, two ports, receive from port A,
> redirect to port B:
>
> baseline:    14.3 Mpps
> this series: 15.4 Mpps
>
> which is almost 8%!

Or 5 ns difference:

10**9/(14.3*10**6) - 10**9/(15.4*10**6)
4.995004995005004

Nice :)

-Toke

