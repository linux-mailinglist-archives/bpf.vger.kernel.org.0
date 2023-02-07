Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321D968D562
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 12:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjBGL0Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 06:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBGL0X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 06:26:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57FC558D
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 03:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675769136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rFD8uUn7xT9t24brMVYKlnZ7XiE7LCwG9gAcZEMagec=;
        b=LWtdysgCs/VJdXC6xKQA3aHWKHtf8IEzRVl7UYN5DfEMCo3eE5EDSW1axY+Q//46qRQZzJ
        +FjXP1yd7YFCd5wXanxAmDTWupdnXqF8K/8S9wvXlzCuo0npEETpSYY1K4qy27kh7KRqRR
        mW6g7UBBs7TzzKy8Nvv+wKiVgyUKaH8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-341-vDGZzGkSPKe7Kcy2chBEpA-1; Tue, 07 Feb 2023 06:25:27 -0500
X-MC-Unique: vDGZzGkSPKe7Kcy2chBEpA-1
Received: by mail-qt1-f197.google.com with SMTP id f2-20020ac80682000000b003b6364059d2so8236127qth.9
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 03:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFD8uUn7xT9t24brMVYKlnZ7XiE7LCwG9gAcZEMagec=;
        b=2eiNb79g4z8byX2dI53y2U3DJoQ9aUJlbcMVhVlOJ50iUIKblSae21IhtjlnpyNfkb
         7pH/zizz5P1uaT1aBKR1cnF26XPzICmrVCl04E/othJjHKQp6tGbiU04bstM2xGpTocD
         SIlJ+pDQLMIWI0YMf+0Q2HfTQo/gdKjRkHaLCMoo+N+bh+ECZu/fsQ8kD6OBZ7SAr/Ud
         rGot+SJO5OmUTBt+hWipOIxAY+69WuKADnPKZvqq0ttHotFqbi6ZjuxU1Lv8DoXv3oKy
         V+v8JDtxDsab8sBUR1hJO/txixIg78ziS18uxlPAkjvGMQc9dXlkGscmi0H9T2CCfx8a
         Qauw==
X-Gm-Message-State: AO0yUKXzrkMg63sJH0AzMkuX2jruf+1OtiGFZh2VKA0Xom99ebICiXD3
        72jQSX4O1mBohDG67BNy5vH/1qDYg93dLZQMsI/NXDEt8/ll5CwVtTtA1m256AQ9Vcao+WKcbHu
        NLJcBdp9F272T
X-Received: by 2002:a05:622a:54a:b0:3b9:b36e:50f0 with SMTP id m10-20020a05622a054a00b003b9b36e50f0mr4043822qtx.36.1675769126943;
        Tue, 07 Feb 2023 03:25:26 -0800 (PST)
X-Google-Smtp-Source: AK7set9U+dwuQouhtw9W7zXa1vUhb3PDw+QXHDyr3+554reuBlVM5ug4gIPcOHHW1Yy8j1L/OEcCNA==
X-Received: by 2002:a05:622a:54a:b0:3b9:b36e:50f0 with SMTP id m10-20020a05622a054a00b003b9b36e50f0mr4043796qtx.36.1675769126688;
        Tue, 07 Feb 2023 03:25:26 -0800 (PST)
Received: from ?IPV6:2001:9e8:bb5d:c00:da0c:81b4:a387:8ed1? ([2001:9e8:bb5d:c00:da0c:81b4:a387:8ed1])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85616000000b003b630456b8fsm9135839qtr.89.2023.02.07.03.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 03:25:26 -0800 (PST)
Message-ID: <92d425d4-e366-adb4-c7ed-97d74a7b9f16@redhat.com>
Date:   Tue, 7 Feb 2023 12:25:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next] selftests: bpf: Use BTF map in sk_assign
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
References: <4ebd4e68dec83863c51a9114e6507524c8feafb7.1675698070.git.fmaurer@redhat.com>
 <CAEf4BzZ565hQLAhHixb9pDWtS9CD72u5-rswxN-vwj-BPXKQ-Q@mail.gmail.com>
From:   Felix Maurer <fmaurer@redhat.com>
In-Reply-To: <CAEf4BzZ565hQLAhHixb9pDWtS9CD72u5-rswxN-vwj-BPXKQ-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06.02.23 23:58, Andrii Nakryiko wrote:
> On Mon, Feb 6, 2023 at 8:07 AM Felix Maurer <fmaurer@redhat.com> wrote:
>>
>> The sk_assign selftest uses tc to load the BPF object file for the test. If
>> tc is linked against libbpf 1.0+, this test failed, because the BPF file
>> used the legacy maps section. This approach is considered legacy by libbpf
>> and tc (see examples/bpf/README in the iproute2 repo).
>>
>> Therefore, switch to the approach recommended by iproute2 and use a BTF
>> defined map. This is also well supported by libbpf.
>>
>> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
>> ---
> 
> This test was updated (see [0]) to support iproute2 version with and
> without libbpf support. Please check the latest bpf-next/master.
> 
>   [0] 7ce878ca81bc ("selftests/bpf: Fix sk_assign on s390x")

Sorry for the noise, I missed that commit. Forget about my patch then.

   Felix

