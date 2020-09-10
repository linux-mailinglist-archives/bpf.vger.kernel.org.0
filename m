Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B06F264A2E
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 18:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgIJQrJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 12:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgIJQpH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 12:45:07 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22970C061573
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 09:45:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so7456421wrn.10
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rMsuXJsUc4cGA0FPkoCGST3cwGAjmHArqg7rRkzq8X4=;
        b=OIIUZC/w0V0Ifqpkhp8Ax+SgHv0qdYZlcr90F+Wkemj2KiInjBPhm6LkcErtlrCIiS
         3SCuWRbJMTp4K714sHsOf3KT32vqKT6YYPpmGmBhNOQOZAkiOU5tePjtGQDjpOPGAben
         o7NF/M3YS2+CmefaqgX5zXEjGzDaTfD51L9W3Ckmwds4aoofXQ8cRCCNr06Yc4LhhPYI
         sn55e9o2pZjgIycayLpasOka7qpzmBQKVFBIrkyRVzIrk7zhGstyGLHuF9ihdzDxEKtD
         2s/1oqecwZosuHMH++uDbEvSvErMN4jJStqAl9mZ+Ru0k5ZQ4gxs9tKmK+x9htPr5ygn
         lBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rMsuXJsUc4cGA0FPkoCGST3cwGAjmHArqg7rRkzq8X4=;
        b=nhIQ9ov0IeJXnShLwYPyYhp7ogXWMNIwXLleHfPGGK9D4YqhGTrYvtf6fYysqILpK0
         VvA3jgJjluMjUSuJc6OpcvzGUPqmHw+AY+pkt4WBumJfH+KGRBnaHlduzQOXWlBsb5q6
         wdepupEfMn+XuXTXfc6uFWZ9w/d43hnYN8qEZCIvET+2DgG5dF6Bh0GSVPsPwalTWksK
         pM8rwyQAYCNilQvIyGNxcMZVEivPzHg6/CZLp8fBv0Xgxj1pWEaUK9SbsJ0brvY8v4uM
         vJY5oGwGPEOiN47X/bsJ/ZbwyAAwoZlN3ncJr+RkAE6L9qLgGrEquYx3FlCcj5/pYa0N
         SOCQ==
X-Gm-Message-State: AOAM532ThjVefBamINJyY2APllcFH55nsvWjD/H8EO3Kd6Ko5OgD/OZJ
        cvtaUwzpPdwFhKaTATR4ZuWd0Q==
X-Google-Smtp-Source: ABdhPJwbLGYJUgOAjoIXsuxsslLzKmPve9bLIuucvg6Uo8YqkysfW1QkC24ndQG7JXqbz0NxBDF5zA==
X-Received: by 2002:adf:fb87:: with SMTP id a7mr10760311wrr.390.1599756305783;
        Thu, 10 Sep 2020 09:45:05 -0700 (PDT)
Received: from [192.168.1.12] ([194.35.119.222])
        by smtp.gmail.com with ESMTPSA id z11sm9565108wru.88.2020.09.10.09.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 09:45:05 -0700 (PDT)
Subject: Re: [PATCH bpf-next v3 2/3] tools: bpftool: keep errors for
 map-of-map dumps if distinct from ENOENT
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
References: <20200910102652.10509-1-quentin@isovalent.com>
 <20200910102652.10509-3-quentin@isovalent.com>
 <CAEf4BzZpp7Rfg5N-1G570NQ1FqKjthpeiuWkNUn-uXQv9Gx8Vg@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <9bfeb3a4-36a0-a260-f3b4-19a0ca9e1fc5@isovalent.com>
Date:   Thu, 10 Sep 2020 17:45:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZpp7Rfg5N-1G570NQ1FqKjthpeiuWkNUn-uXQv9Gx8Vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/09/2020 17:42, Andrii Nakryiko wrote:
> On Thu, Sep 10, 2020 at 3:27 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> When dumping outer maps or prog_array maps, and on lookup failure,
>> bpftool simply skips the entry with no error message. This is because
>> the kernel returns non-zero when no value is found for the provided key,
>> which frequently happen for those maps if they have not been filled.
>>
>> When such a case occurs, errno is set to ENOENT. It seems unlikely we
>> could receive other error codes at this stage (we successfully retrieved
>> map info just before), but to be on the safe side, let's skip the entry
>> only if errno was ENOENT, and not for the other errors.
>>
>> v3: New patch
>>
>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
>> ---
>>  tools/bpf/bpftool/map.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
>> index c8159cb4fb1e..d8581d5e98a1 100644
>> --- a/tools/bpf/bpftool/map.c
>> +++ b/tools/bpf/bpftool/map.c
>> @@ -240,8 +240,8 @@ print_entry_error(struct bpf_map_info *map_info, void *key, int lookup_errno)
>>          * means there is no entry for that key. Do not print an error message
>>          * in that case.
>>          */
>> -       if (map_is_map_of_maps(map_info->type) ||
>> -           map_is_map_of_progs(map_info->type))
>> +       if ((map_is_map_of_maps(map_info->type) ||
>> +            map_is_map_of_progs(map_info->type)) && lookup_errno == ENOENT)
>>                 return;
> 
> 
> Ah, ok, you decided to split it out into a separate patch. Ok.

Yes, I chose to keep the first one with no functional change to keep the
logs cleaner.

> Acked-by: Andrii Nakryiko <andriin@fb.com>

Thanks!
Quentin
