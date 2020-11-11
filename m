Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9202AEF64
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 12:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgKKLRL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 06:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgKKLRK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 06:17:10 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8D8C0613D4
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 03:17:09 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id z21so2598514lfe.12
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 03:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=SmD3+sLYBLHCX5kIQGy8Wg7QbI8g3por4Ij6pZStXAo=;
        b=tuNFJUUa4Or2tzeijfJGe4TGJ8HZv0d2rT6lPqsF7xaicDwNTPXGmWjQ7VtFgQqYcN
         tm1U67y+nY0gI/iQkmPloyM6FEu5ZtHxkCBtIVzlNDxiyYxqoMlKQp3d7hzR7lRKx9YF
         tFyfPiEOeYh289aKQPZ+nptP3Uai5IR/nKbkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=SmD3+sLYBLHCX5kIQGy8Wg7QbI8g3por4Ij6pZStXAo=;
        b=XSoceRWf8mmoB7zL0DUkS5Wvdveyr6NLL3wkZFz03j2+HRMjcMYsCB3OVSFZ/i53Zp
         6L8fbXX6FIaJkLvUDuI4MguqS7XS/XufwZoZJ6nsF4YIFElXPxAV3Rk14YowpwkXGnP4
         EvNVMa9+KqG1D5xmSkep6aggSXRFu7JJA8nK5OMp6H8EU23qWvthInJ3gP7W09kghyQs
         A/8Ov22+yu0cjef1L3T5x1FsXGRaX3n60oTavolDR0pZZwhxMC1Va/Lmo7+/ubhgm3pX
         x3r4AGlDPhT39B87WJErEFarAbZOrWXPLCpTqXeE3t/nYHp9bZmFO7rZU0hSL3taBPgH
         KL0Q==
X-Gm-Message-State: AOAM531bndl9bM0nKOf2GredhkqDc3EQeLu8jtDKPPEm0JMqdqlV2woz
        awxtTCaX59uuGZwmi2tPHmOZ/A==
X-Google-Smtp-Source: ABdhPJznBLeCBVObooLKP6FokZLlhU9L/hti/kOz52w26yVhFZYmSQl+sVV4RdcDtFEL35/OuO0Bdw==
X-Received: by 2002:a19:8497:: with SMTP id g145mr9710785lfd.504.1605093428226;
        Wed, 11 Nov 2020 03:17:08 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id w13sm192029lfq.72.2020.11.11.03.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 03:17:07 -0800 (PST)
References: <X6rJ7c1C95uNZ/xV@santucci.pierpaolo> <CAEf4BzYTvPOtiYKuRiMFeJCKhEzYSYs6nLfhuten-EbWxn02Sg@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Santucci Pierpaolo <santucci@epigenesys.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] selftest/bpf: fix IPV6FR handling in flow dissector
In-reply-to: <CAEf4BzYTvPOtiYKuRiMFeJCKhEzYSYs6nLfhuten-EbWxn02Sg@mail.gmail.com>
Date:   Wed, 11 Nov 2020 12:17:06 +0100
Message-ID: <87imacw3bh.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 11, 2020 at 05:48 AM CET, Andrii Nakryiko wrote:
> On Tue, Nov 10, 2020 at 9:12 AM Santucci Pierpaolo
> <santucci@epigenesys.com> wrote:
>>
>> From second fragment on, IPV6FR program must stop the dissection of IPV6
>> fragmented packet. This is the same approach used for IPV4 fragmentation.
>>
>
> Jakub, can you please take a look as well?

I'm not initimately familiar with this test, but looking at the change
I'd consider that Destinations Options and encapsulation headers can
follow the Fragment Header.

With enough of Dst Opts or levels of encapsulation, transport header
could be pushed to the 2nd fragment. So I'm not sure if the assertion
from the IPv4 dissector that 2nd fragment and following doesn't contain
any parseable header holds.

Taking a step back... what problem are we fixing here?

>
>> Signed-off-by: Santucci Pierpaolo <santucci@epigenesys.com>
>> ---
>>  tools/testing/selftests/bpf/progs/bpf_flow.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/bpf_flow.c b/tools/testing/selftests/bpf/progs/bpf_flow.c
>> index 5a65f6b51377..95a5a0778ed7 100644
>> --- a/tools/testing/selftests/bpf/progs/bpf_flow.c
>> +++ b/tools/testing/selftests/bpf/progs/bpf_flow.c
>> @@ -368,6 +368,8 @@ PROG(IPV6FR)(struct __sk_buff *skb)
>>                  */
>>                 if (!(keys->flags & BPF_FLOW_DISSECTOR_F_PARSE_1ST_FRAG))
>>                         return export_flow_keys(keys, BPF_OK);
>> +       } else {
>> +               return export_flow_keys(keys, BPF_OK);
>>         }
>>
>>         return parse_ipv6_proto(skb, fragh->nexthdr);
>> --
>> 2.29.2
>>
