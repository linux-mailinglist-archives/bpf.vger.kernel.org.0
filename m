Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7681643D0F
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 07:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiLFGQs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 01:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiLFGQo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 01:16:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA08A2717A
        for <bpf@vger.kernel.org>; Mon,  5 Dec 2022 22:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670307351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OqyDyiUY/57MQH0Vr9UzZ8IBstQlbSI6OL55RTcT56o=;
        b=HUZSihEYzJZLoJcznsNLNM3VYear2RMyZAUIwHXdN2b4vcWYkEE60UWRnVlY9w9fCuF00U
        7zkWNqRnkMeem/9pSqDEQnH6oQI9PNvhQTy5Dv6upsDyRn4v0TD1OVy3BOp3lmDiUbmd0t
        vFb5DQERu0P+DsnmDwSYEPOT3+sL+Y0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-50-rB_Nsql3MSqaIwNMBSts1A-1; Tue, 06 Dec 2022 01:15:49 -0500
X-MC-Unique: rB_Nsql3MSqaIwNMBSts1A-1
Received: by mail-ej1-f72.google.com with SMTP id qa30-20020a170907869e00b007c106529379so890223ejc.8
        for <bpf@vger.kernel.org>; Mon, 05 Dec 2022 22:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqyDyiUY/57MQH0Vr9UzZ8IBstQlbSI6OL55RTcT56o=;
        b=agaICt4w50bViFUb0o8Uw+muY0ZOyoK6IjplHb/O1np4p7RvsBLi/tFaWnJEg4EyBJ
         e3TXhzE3heoPaiIPC+5KJl47V3b9dH+VgFtGpRBHKcUYCq/b8hwLoaAOC0nEo+bQBcGj
         YR60I+IwOYA3Suv4wpAFDki/7R2wwbYtgzI29T/fkbA08VTPYYrmuyYcXYAzIvmY8UUt
         BbqIboY4Dm2uR2lFHiNH4nFfaJFVkGVsCrdaRFHSfcAXnOCD7cRTR/KwB4NjwdGE6XCV
         Sjh3PgCvddnkj//n2t2msJmG0K0wAXvCMgYLQZsFgZLdD+xHlvC6v4N8Gpwus17lVJZT
         g/HQ==
X-Gm-Message-State: ANoB5pntxblGOR5z8/S2USgxq9rKnles3QCx0Q1yz0BaUDSrnoGmgK/m
        bwasBQ7hFDGX9+UWDs8k8X1Lrn6vIZsaQZnao0c2iOWpx9+RIaDX0F3ewK8rnCeqdYSCIy4UC3Q
        pREGEaUwTd18=
X-Received: by 2002:a50:ff0d:0:b0:461:c6e8:452e with SMTP id a13-20020a50ff0d000000b00461c6e8452emr66153717edu.298.1670307348446;
        Mon, 05 Dec 2022 22:15:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5OfeoJwBR46FUtl+fAKP5FspXvPWJIRsItaaylduyq3uJJoi9GhHtJIFU7UDQRBf/o2eCU5g==
X-Received: by 2002:a50:ff0d:0:b0:461:c6e8:452e with SMTP id a13-20020a50ff0d000000b00461c6e8452emr66153700edu.298.1670307348115;
        Mon, 05 Dec 2022 22:15:48 -0800 (PST)
Received: from [192.168.0.111] (185-219-167-248-static.vivo.cz. [185.219.167.248])
        by smtp.gmail.com with ESMTPSA id gf16-20020a170906e21000b007815ca7ae57sm6954473ejb.212.2022.12.05.22.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 22:15:47 -0800 (PST)
Message-ID: <20260124-ba1b-7bfe-95e6-f3c107b04fc3@redhat.com>
Date:   Tue, 6 Dec 2022 07:15:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v3 3/3] bpf/selftests: Test fentry attachment to
 shadowed functions
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
References: <cover.1670249590.git.vmalik@redhat.com>
 <db2560ea17db7c207a4de31fb84f0ccd5435245f.1670249590.git.vmalik@redhat.com>
 <Y45ZTDBNR/NiWMPn@krava>
From:   Viktor Malik <vmalik@redhat.com>
In-Reply-To: <Y45ZTDBNR/NiWMPn@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/5/22 21:49, Jiri Olsa wrote:
> On Mon, Dec 05, 2022 at 04:26:06PM +0100, Viktor Malik wrote:
>> Adds a new test that tries to attach a program to fentry of two
>> functions of the same name, one located in vmlinux and the other in
>> bpf_testmod.
>>
>> To avoid conflicts with existing tests, a new function
>> "bpf_fentry_shadow_test" was created both in vmlinux and in bpf_testmod.
>>
>> The previous commit fixed a bug which caused this test to fail. The
>> verifier would always use the vmlinux function's address as the target
>> trampoline address, hence trying to attach two programs to the same
>> trampoline.
> 
> hi
> looks good, few nits below
> 
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> ---
>>   net/bpf/test_run.c                            |   5 +
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   7 +
>>   .../bpf/prog_tests/module_attach_shadow.c     | 124 ++++++++++++++++++
>>   3 files changed, 136 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c
>>
>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> index 6094ef7cffcd..71e36a85573b 100644
>> --- a/net/bpf/test_run.c
>> +++ b/net/bpf/test_run.c
>> @@ -536,6 +536,11 @@ int noinline bpf_modify_return_test(int a, int *b)
>>   	return a + *b;
>>   }
>>   
>> +int noinline bpf_fentry_shadow_test(int a)
>> +{
>> +	return a + 1;
>> +}
>> +
>>   u64 noinline bpf_kfunc_call_test1(struct sock *sk, u32 a, u64 b, u32 c, u64 d)
>>   {
>>   	return a + b + c + d;
>> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> index 5085fea3cac5..d23127a5ec68 100644
>> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> @@ -229,6 +229,13 @@ static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
>>   	.set   = &bpf_testmod_check_kfunc_ids,
>>   };
>>   
>> +noinline int bpf_fentry_shadow_test(int a)
>> +{
>> +	return a + 2;
>> +}
>> +EXPORT_SYMBOL_GPL(bpf_fentry_shadow_test);
>> +ALLOW_ERROR_INJECTION(bpf_fentry_shadow_test, ERRNO);
> 
> why marked as ALLOW_ERROR_INJECTION?

Right, not necessary, will remove.

> 
>> +
>>   extern int bpf_fentry_test1(int a);
>>   
>>   static int bpf_testmod_init(void)
>> diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c b/tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c
>> new file mode 100644
>> index 000000000000..bf511e61ec1f
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/module_attach_shadow.c
>> @@ -0,0 +1,124 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2022 Red Hat */
>> +#include <test_progs.h>
>> +#include <bpf/btf.h>
>> +#include "bpf/libbpf_internal.h"
>> +#include "cgroup_helpers.h"
>> +
>> +static const char *module_name = "bpf_testmod";
>> +static const char *symbol_name = "bpf_fentry_shadow_test";
>> +
>> +int get_bpf_testmod_btf_fd(void)
> 
> should be static?

Yes, I believe.

> 
>> +{
>> +	struct bpf_btf_info info;
>> +	char name[64];
>> +	__u32 id = 0, len;
>> +	int err, fd;
>> +
>> +	while (true) {
>> +		err = bpf_btf_get_next_id(id, &id);
>> +		if (err) {
>> +			log_err("failed to iterate BTF objects");
>> +			return err;
>> +		}
>> +
>> +		fd = bpf_btf_get_fd_by_id(id);
>> +		if (fd < 0) {
> 
> I was checking how's libbpf doing this and found load_module_btfs,
> which seems similar.. and it has one additional check in here:
> 
>                          if (errno == ENOENT)
>                                  continue; /* expected race: BTF was unloaded */
> 
> I guess it's not likely, but it's better to have it

Sure, will add it. You're right, the implementation is mostly taken from
libbpf's load_module_btfs.

> 
> 
> SNIP
> 
>> +	btf_id[0] = btf__find_by_name_kind(vmlinux_btf, symbol_name, BTF_KIND_FUNC);
>> +	if (!ASSERT_GT(btf_id[0], 0, "btf_find_by_name"))
>> +		goto out;
>> +
>> +	btf_id[1] = btf__find_by_name_kind(mod_btf, symbol_name, BTF_KIND_FUNC);
>> +	if (!ASSERT_GT(btf_id[1], 0, "btf_find_by_name"))
>> +		goto out;
>> +
>> +	for (i = 0; i < 2; i++) {
>> +		load_opts.attach_btf_id = btf_id[i];
>> +		load_opts.attach_btf_obj_fd = btf_fd[i];
>> +		prog_fd[i] = bpf_prog_load(BPF_PROG_TYPE_TRACING, NULL, "GPL",
>> +					   trace_program,
>> +					   sizeof(trace_program) / sizeof(struct bpf_insn),
>> +					   &load_opts);
>> +		if (!ASSERT_GE(prog_fd[i], 0, "bpf_prog_load"))
>> +			goto out;
>> +
>> +		link_fd[i] = bpf_link_create(prog_fd[i], 0, BPF_TRACE_FENTRY, NULL);
>> +		if (!ASSERT_GE(link_fd[i], 0, "bpf_link_create"))
>> +			goto out;
> 
> so IIUC the issue is that without the previous fix this will create
> 2 separate trampolines pointing to single address.. and we can have
> just one trampoline for address.. so the 2nd trampoline update will
> fail, because the trampoline location is already changed/taken ?
> 
> could you please put some description like that in the comment or
> changelog?

The description is already in the commit message and in the series
changelog, although it may be a bit inaccurate (stating that two
programs are attached to the same trampoline rather that two trampolines
attached to the same address).

I'll fix it and add it to the comment, it could be useful to have it
there as well.

Thanks!
Viktor

> 
> thanks,
> jirka
> 
>> +	}
>> +
>> +	err = bpf_prog_test_run_opts(prog_fd[0], &test_opts);
>> +	ASSERT_OK(err, "running test");
>> +
>> +out:
>> +	if (vmlinux_btf)
>> +		btf__free(vmlinux_btf);
>> +	if (mod_btf)
>> +		btf__free(mod_btf);
>> +	for (i = 0; i < 2; i++) {
>> +		if (btf_fd[i])
>> +			close(btf_fd[i]);
>> +		if (prog_fd[i])
>> +			close(prog_fd[i]);
>> +		if (link_fd[i])
>> +			close(link_fd[i]);
>> +	}
>> +}
>> -- 
>> 2.38.1
>>
> 

