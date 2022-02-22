Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969D44BFDF6
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 17:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbiBVQAY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 11:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbiBVQAT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 11:00:19 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBDBD8876
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 07:59:53 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cp23-20020a17090afb9700b001bbfe0fbe94so3103326pjb.3
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 07:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qSk871QKHM1Ie3Z0lSVMx7QpeNYqXYeUnwkrnigCfVQ=;
        b=prkgIL8Pa6JY7kGVgVN9ImP+qcI9xvy+Ru4WZOFHIEIIKxifp+Xz5O75NKOa4jKnhf
         z/aElVJPdB8VKgltKQmQgUKfGXqYmmPh8UhYlkuWt5TBbSRz0r1JfNbvX4NJDynOBUk9
         ZnMSJyqUmAU3IcE1TX2QPehZ1F0YCf89vNDY2bWxprh08Z3jlg5kzeC42Jzr1Hm9syYO
         0Kr53kftpgPqs7POZXi+3mC/Nm3zEEBR5V7FAarw5B7CZ2QxVKFifOsxMBh0vGkItzwX
         3T6xKUMOcRu4tinPUrCGWF3MRZV10uZC5Th+ih2K7d0LkF3zd8iSLt8L54PQpBmjtx05
         L8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qSk871QKHM1Ie3Z0lSVMx7QpeNYqXYeUnwkrnigCfVQ=;
        b=5ybqn10T9TZpN+/XdpOsrco6wN6e3Fc1HkeiM9fdXcjoR8m33don8d518MfNKiEfCT
         Eo6LIrijA12btZMUvd1ECEgjP9fG58F6N9vOvVGfmFATsfgjvsmbLNz1sAZyq3bL/hYB
         5U0WKFSgRH5hzEWh+ozCb8tX/IZCL4QqZDAI1E3OFipcQIV8SxOsq74y75iHfklmlWEw
         geqEk4VNTSOtTqYPLrArQbVEPo4f9xhCs/+TKoBQym3TXF+5IR976SxDhGR1xqUBZSgb
         a7WXoCYY0cq2W1MP0rpULcKCThFcKrEXo/y9kKbxtgnPfV1vpjKJ6YhTVPlrhPVYLXm5
         rILw==
X-Gm-Message-State: AOAM533xU+6oawWQFnNYbZneu0a8jlh4VsCnlGbhsRZFHVpkP3JABIPJ
        nvSn8XZq/sEIil6DZzbewbQ=
X-Google-Smtp-Source: ABdhPJx1sfo193WIVNEqM9BmRY7g9mNMflyrWagvGIpEJaoWKbgxb0zwpL1jvWdHuJIdDEgNn7J17Q==
X-Received: by 2002:a17:902:bd47:b0:14d:a8b7:236 with SMTP id b7-20020a170902bd4700b0014da8b70236mr23817849plx.20.1645545593408;
        Tue, 22 Feb 2022 07:59:53 -0800 (PST)
Received: from [192.168.0.120] ([121.35.100.98])
        by smtp.gmail.com with ESMTPSA id lb18sm3076694pjb.42.2022.02.22.07.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 07:59:53 -0800 (PST)
Message-ID: <8712d13d-2b3a-386c-74ac-1ce9cccd125b@gmail.com>
Date:   Tue, 22 Feb 2022 23:59:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH bpf-next v3 1/1] bpftool: bpf skeletons assert type sizes
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <cover.1644970147.git.delyank@fb.com>
 <b73550a69ea8c02fd93c862f9cfe38f7e1813e7a.1644970147.git.delyank@fb.com>
 <CAEf4BzahTxY+djRkD6cjbGwkv_oevshpN-OpRMdYQ2P0_a1dOA@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <CAEf4BzahTxY+djRkD6cjbGwkv_oevshpN-OpRMdYQ2P0_a1dOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/16/22 09:19, Andrii Nakryiko wrote:
> On Tue, Feb 15, 2022 at 4:12 PM Delyan Kratunov <delyank@fb.com> wrote:
>>
>> When emitting type declarations in skeletons, bpftool will now also emit
>> static assertions on the size of the data/bss/rodata/etc fields. This
>> ensures that in situations where userspace and kernel types have the same
>> name but differ in size we do not silently produce incorrect results but
>> instead break the build.
>>
>> This was reported in [1] and as expected the repro in [2] fails to build
>> on the new size assert after this change.
>>
>>   [1]: Closes: https://github.com/libbpf/libbpf/issues/433
>>   [2]: https://github.com/fuweid/iovisor-bcc-pr-3777
>>
>> Signed-off-by: Delyan Kratunov <delyank@fb.com>
>> ---
> 
> LGTM with a trivial styling nits. But this doesn't apply cleanly to
> bpf-next (see [0]). Can you please rebase and resend. Also for
> single-patch submissions we don't require cover letter, to please just
> put all the description into one patch without cover letter.
> 
>   [0] https://github.com/kernel-patches/bpf/pull/2563#issuecomment-1040929960
> 
>>  tools/bpf/bpftool/gen.c | 134 +++++++++++++++++++++++++++++++++-------
>>  1 file changed, 112 insertions(+), 22 deletions(-)
> 
> [...]
> 
>> +
>> +       bpf_object__for_each_map(map, obj) {
>> +               if (!bpf_map__is_internal(map))
>> +                       continue;
>> +               if (!(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
>> +                       continue;
>> +               if (!get_map_ident(map, map_ident, sizeof(map_ident)))
>> +                       continue;
>> +
>> +               sec = find_type_for_map(obj, map_ident);
>> +
> 
> nit: unnecessary empty line between assignment and "error checking"
> 
>> +               if (!sec) {
>> +                       /* best effort, couldn't find the type for this map */
>> +                       continue;
>> +               }
>> +
>> +               sec_var = btf_var_secinfos(sec);
>> +               vlen =  btf_vlen(sec);
>> +
>> +               for (i = 0; i < vlen; i++, sec_var++) {
>> +                       const struct btf_type *var = btf__type_by_id(btf, sec_var->type);
>> +                       const char *var_name = btf__name_by_offset(btf, var->name_off);
>> +                       __u32 var_type_id = var->type;
>> +                       __s64 var_size = btf__resolve_size(btf, var_type_id);
>> +
>> +                       if (var_size < 0)
>> +                               continue;
>> +
>> +                       /* static variables are not exposed through BPF skeleton */
>> +                       if (btf_var(var)->linkage == BTF_VAR_STATIC)
>> +                               continue;
>> +
>> +                       var_ident[0] = '\0';
>> +                       strncat(var_ident, var_name, sizeof(var_ident) - 1);
>> +                       sanitize_identifier(var_ident);
>> +
>> +                       printf("\t_Static_assert(");
>> +                       printf("sizeof(s->%1$s->%2$s) == %3$lld, ",
>> +                              map_ident, var_ident, var_size);
>> +                       printf("\"unexpected size of '%1$s'\");\n", var_ident);
> 
> nit: I'd keep this as one printf, it makes it a bit easier to follow.
> 
>> +               }
>> +       }
> 
> [...]

Feel free to add:

Acked-by: Hengqi Chen <hengqi.chen@gmail.com>
Tested-by: Hengqi Chen <hengqi.chen@gmail.com>
