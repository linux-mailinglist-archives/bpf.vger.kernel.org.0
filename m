Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863506BF6A1
	for <lists+bpf@lfdr.de>; Sat, 18 Mar 2023 00:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCQXtB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 19:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCQXtA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 19:49:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A58337F36
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 16:48:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id k2so6951594pll.8
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 16:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679096939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/q3wz3Q+5JY5+/70JULlQiA+vc6mEz5xzAaU07WwZj8=;
        b=FUYz+isAtBRPdVFaflWOYigh3pkJwA2+JuqrFYCi1iY+ofTdT6cLAEulXq92ndgsXf
         6uQJykYR0rQeWE10ZL0qLuED/4ZyMh8V8ehJSWzZUTIqf6H880zKimQzzwXBQctcLeHj
         lQ1YjDn/YBCqQ2ROCb2DWqELHJzy2FU0LRggu5rx5F5Sr1s5YeACIhdVEgUo4DX96/j+
         /c7b2869DCTLDNN8uPy/tloq3r2VZxpaN9bDHG1BRVE4XKL1vQ56F3HId3YMzKzjimq0
         7BpvSdToTwm9st211+XISr9XLqEv0WzKWN4ZTm122m0nN1eZ6mtgDRo881Pur/G/fNrf
         7Adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679096939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/q3wz3Q+5JY5+/70JULlQiA+vc6mEz5xzAaU07WwZj8=;
        b=Y/i0sU4ydXnpH5BjBkLDP7H0D9iFW+ahDytW9tWC6J76S4bgkx7k2z7NU7UNSn8WwN
         EfOmvUYaoY2jla+waVboCEcNQ6AhECBMFvRPGvphtN+U3ZWk3g3DrlF4qqhINmTP6Z+L
         WGrdUNaxWEEjaoybm3tumEbeRY+xmq9SKk9R0Pg1rQzR2C9t/aU7GAqXDGnZGIlVDmZP
         HhmLGGhlfJFdkDc3tfxVGxfCB+OUhwtGO07E6DoX1yIghJDgD65cVGzlA0jM8da/xF2s
         pGB1xVH5dvJ6Mo46fQsJl7Mzp2HiqdS3JE3tVnmF52ae9tMNUuv9SNvWqFJZ6GBz69M8
         G7OQ==
X-Gm-Message-State: AO0yUKU+pIEzzI8bQVdHGyqLmLKGKI0Btt072lppYSejNMA4XauQZZgB
        76Ebp2qmuZd3EMlbdYv2OF0=
X-Google-Smtp-Source: AK7set82TOazVDKLw1h1hUFnxLakoRHGCtwcSYXXibkQUEfsZbJKS2rwct/ksCSuhhXrqBgShYa5Og==
X-Received: by 2002:a17:902:fa04:b0:1a0:5349:7779 with SMTP id la4-20020a170902fa0400b001a053497779mr8010661plb.5.1679096939052;
        Fri, 17 Mar 2023 16:48:59 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::1380? ([2620:10d:c090:400::5:87c3])
        by smtp.gmail.com with ESMTPSA id v23-20020a17090331d700b0019a74841c9bsm2061127ple.192.2023.03.17.16.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 16:48:58 -0700 (PDT)
Message-ID: <d39b2168-a79d-ad84-ba34-17ca4eb6ead2@gmail.com>
Date:   Fri, 17 Mar 2023 16:48:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v7 4/8] libbpf: Create a bpf_link in
 bpf_map__attach_struct_ops().
Content-Language: en-US, en-ZW
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
References: <20230316023641.2092778-1-kuifeng@meta.com>
 <20230316023641.2092778-5-kuifeng@meta.com>
 <CAEf4BzZjEm_cKNnZZrDHci0i-vOvCOvCdWd3KBOeiBC0=FoM7Q@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzZjEm_cKNnZZrDHci0i-vOvCOvCdWd3KBOeiBC0=FoM7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/17/23 15:23, Andrii Nakryiko wrote:
> On Wed, Mar 15, 2023 at 7:37 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>>
>> bpf_map__attach_struct_ops() was creating a dummy bpf_link as a
>> placeholder, but now it is constructing an authentic one by calling
>> bpf_link_create() if the map has the BPF_F_LINK flag.
>>
>> You can flag a struct_ops map with BPF_F_LINK by calling
>> bpf_map__set_map_flags().
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 90 +++++++++++++++++++++++++++++++-----------
>>   1 file changed, 66 insertions(+), 24 deletions(-)
>>
> 
> [...]
> 
>> -               if (!prog)
>> -                       continue;
>> +       link->link.detach = bpf_link__detach_struct_ops;
>>
>> -               prog_fd = bpf_program__fd(prog);
>> -               kern_data = st_ops->kern_vdata + st_ops->kern_func_off[i];
>> -               *(unsigned long *)kern_data = prog_fd;
>> +       if (!(map->def.map_flags & BPF_F_LINK)) {
>> +               /* w/o a real link */
>> +               link->link.fd = map->fd;
>> +               link->map_fd = -1;
>> +               return &link->link;
>>          }
>>
>> -       err = bpf_map_update_elem(map->fd, &zero, st_ops->kern_vdata, 0);
>> -       if (err) {
>> -               err = -errno;
>> +       fd = bpf_link_create(map->fd, -1, BPF_STRUCT_OPS, NULL);
> 
> pass 0, not -1. BPF APIs have a convention that fd=0 means "no fd was
> provided". And actually kernel should have rejected this -1, so please
> check why that didn't happen in your testing, we might be missing some
> kernel validation.

Oh! probe_perf_link() also pass -1 as well.
I will fix it.

> 
> 
>> +       if (fd < 0) {
>>                  free(link);
>> -               return libbpf_err_ptr(err);
>> +               return libbpf_err_ptr(fd);
>>          }
>>
>> -       link->detach = bpf_link__detach_struct_ops;
>> -       link->fd = map->fd;
>> +       link->link.fd = fd;
>> +       link->map_fd = map->fd;
>>
>> -       return link;
>> +       return &link->link;
>>   }
>>
>>   typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_event_header *hdr,
>> --
>> 2.34.1
>>
