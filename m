Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30193DDCCD
	for <lists+bpf@lfdr.de>; Mon,  2 Aug 2021 17:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhHBPua (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Aug 2021 11:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbhHBPu3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Aug 2021 11:50:29 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA00C06175F
        for <bpf@vger.kernel.org>; Mon,  2 Aug 2021 08:50:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id j3so5001224plx.4
        for <bpf@vger.kernel.org>; Mon, 02 Aug 2021 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2KR/9TdkIbxEEp135SpgCy9FcqhKGQ0M+wYMlsah2HI=;
        b=sw1m+Ocf76QYlJklIWjcPmpxohvodM81hj3h0iYZTAYHlaG+anInveFEQ5Nw3QvRKN
         ysoq9AoQ725J+HpD2dakWhv7CO6ib+1QebKOLdkb6k9EBOX0SWK94bKQ7KfibzXVkCse
         M029BrS0lx88iVp8uS+PSr2RP9LWd9Za1iRekoa8WitrazO9FUj8qBtC9QQzflVwaebo
         KlMHuQ6VGdqEwYv63s+LrDOntqKfRLZsAedSRjpHwFxAzpl1M/HDlPpM57+LzibwNCKz
         PIGyish105/oGk6YPj/P4PLpZo/yjlJcaiCZpreCwjN27bupzAHaxdTlpNWjTxN45q3S
         0oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2KR/9TdkIbxEEp135SpgCy9FcqhKGQ0M+wYMlsah2HI=;
        b=TzmEnVr1UyMWymEGrjk2q90DaKWRXu5TaxyHiFckjCioaZdlvIwiS5v8pUh/zvKSdG
         0CHxMdb4uSmS0JF8w5xIc9o0Gb3R5slkebzcbZxvZJzNOwpb9MHPVQ+DciccYSYxkNIA
         wmdaphA+hL/7wJjOvGIJ8K6LsFJOWw1bP91/NOAenZep2/XUg4Vez8K/GWLvDuE8eIl9
         Q5gU/H/fIlEtqyAg6QlPco3dkL76Nwnoj5vH4i92c4ykGBMTM7l0iHjfjKyiA3jeACPf
         5LOzcLkNdw8VQ+iItn3BJxWvr3bsMmBOnbvBA04s/pn4w8xS3TrYji8COCzjADrmKNKQ
         evoA==
X-Gm-Message-State: AOAM5333zlXBOh3rMdUgRnUxe2pFRlveP1kF1oDJn4zuNcoiwxcesxqs
        P0zcrTuEsy5ibTjjWaZGzJk=
X-Google-Smtp-Source: ABdhPJx2fIVOyG91V3+rwfbj7axrbyYc8mhtY39m60l9/4nkoYBzrgQLkw8ZtSqQjbFxN00uppl6Qw==
X-Received: by 2002:a63:fc02:: with SMTP id j2mr592459pgi.235.1627919419164;
        Mon, 02 Aug 2021 08:50:19 -0700 (PDT)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id s36sm12252926pfw.131.2021.08.02.08.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 08:50:18 -0700 (PDT)
Subject: Re: [PATCH] selftests/bpf: Test
 btf__load_vmlinux_btf/btf__load_module_btf APIs
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        john.fastabend@gmail.com
References: <20210731143244.784959-1-hengqi.chen@gmail.com>
 <ac1139ff-0680-0aae-550d-3222fb4c4710@fb.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <416b5b95-3407-8aaa-8a94-839aefb2f65e@gmail.com>
Date:   Mon, 2 Aug 2021 23:50:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ac1139ff-0680-0aae-550d-3222fb4c4710@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/2/21 10:44 AM, Yonghong Song wrote:
> 
> 
> On 7/31/21 7:32 AM, Hengqi Chen wrote:
>> Add test for btf__load_vmlinux_btf/btf__load_module_btf APIs. It first
>> checks that if btrfs module BTF exists, if yes, load module BTF and
>> check symbol existence.
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
>>   .../selftests/bpf/prog_tests/btf_module.c     | 31 +++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module.c b/tools/testing/selftests/bpf/prog_tests/btf_module.c
>> new file mode 100644
>> index 000000000000..cad1314e3356
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module.c
>> @@ -0,0 +1,31 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2021 Hengqi Chen */
>> +
>> +#include <test_progs.h>
>> +#include <bpf/btf.h>
>> +
>> +static const char *module_path = "/sys/kernel/btf/btrfs";
>> +static const char *module_name = "btrfs";
>> +
>> +void test_btf_module()
>> +{
>> +    struct btf *vmlinux_btf, *module_btf;
>> +    __s32 type_id;
>> +
>> +    if (access(module_path, F_OK))
>> +        return;
>> +
>> +    vmlinux_btf = btf__load_vmlinux_btf();
>> +    if (!ASSERT_OK_PTR(vmlinux_btf, "could not load vmlinux BTF"))
>> +        return;
>> +
>> +    module_btf = btf__load_module_btf(module_name, vmlinux_btf);
>> +    if (!ASSERT_OK_PTR(module_btf, "could not load module BTF"))
>> +        return;
> 
> Should we do `btf__free(vmlinux_btf)` before `return`?
> From implementation perspective, maybe use "goto" so we have one
> place to do `btf__free(vmlinux_btf)`.
> 

Didn't notice that ASSERT macro does not abort the execution.
Will add cleanup code.

>> +
>> +    type_id = btf__find_by_name(module_btf, "btrfs_file_open");
>> +    ASSERT_GT(type_id, 0, "func btrfs_file_open not found");
>> +
>> +    btf__free(module_btf);
>> +    btf__free(vmlinux_btf);
>> +}
>>
