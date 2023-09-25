Return-Path: <bpf+bounces-10822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AF17AE298
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 01:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AFD6B2815A9
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD25266B7;
	Mon, 25 Sep 2023 23:50:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB79266A5
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 23:50:47 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7CCCE6
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:50:35 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d862533ea85so6972499276.0
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695685834; x=1696290634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TxxoiHK9G3bZ7zOLU6VDpT9auTkUDkCmBNLLQkr8iHw=;
        b=beEFQTkMmCCgm1n/P3FVRrDAi5IRxnJVYBjoXSXp4HHbyDWr0HdEiImJAGNT/yzmuC
         7Ox8P7P3RMsMVEhDZrVJujouZCzhEWaKa1WVG09R7cIzy8VtD5n3FsE0Q5+x29JO4mWZ
         HSbaqkbBHI+somTNojmqGtchc3LtUKwWIF7oOB1nLsDU25r9aYKQQ1yCgwZV6oAdbQrX
         wXFyBTlmhpsC3kdkpUwukchfnGvANVWSh9+tWd+eHyFzvo0vXNnk0/q4H3SyX7DPkVRK
         HqmJEfO9Z976rgQpyQ/1NYif9NJnyUjhGFcIjjLqpMhuAMAVvywuQ+s2Gr+NZ6jfLOb3
         ybyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695685834; x=1696290634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxxoiHK9G3bZ7zOLU6VDpT9auTkUDkCmBNLLQkr8iHw=;
        b=tq9EQRJ+l/9M69X785uqg32dhPcuwhKc/Z4ulXUZos6my5f+MbbBIm4c4gXGbRAhsD
         LjxX8W4ZWJH3t37VmlrYSW8ccbYirJv9taZIo7Iz0RCONhaFFaxfms5FgHYx8721cr9y
         MYbWFoFc6awhb7l4Go2xTrEQ9t2MwQnhG10yDlOlGf8FqA971ViDbulaHdwPSAx0pnEI
         SerCqc2cIT/2HE/WRuLGi0OIqbXMNT9mRPodaryQvHK+n3KHb2cc33EgkOKR6FLIbT+H
         14c0C7HzdgrKzJSmYQ+biQ1DqyTArcNdhSu+WWk5qATrFUh5hxCFPKzieYYXUMJQptgy
         +CTw==
X-Gm-Message-State: AOJu0YxS2/dAFV4nZYMLkiKyffV/YsCkY35usUHuTsuqMpePza6hFKId
	LJTvqwmgSxr+6dX7+/x16i8=
X-Google-Smtp-Source: AGHT+IH1fgAGog8MSxl0Ch/z9h5Wgluy7f3EK3rGajof/WNGZVk49R0afY+PZG/N84P3mPATbAMVyA==
X-Received: by 2002:a25:d0d8:0:b0:d1c:bb1d:238a with SMTP id h207-20020a25d0d8000000b00d1cbb1d238amr6777430ybg.52.1695685834050;
        Mon, 25 Sep 2023 16:50:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:f7cd:fd6d:2b89:f093? ([2600:1700:6cf8:1240:f7cd:fd6d:2b89:f093])
        by smtp.gmail.com with ESMTPSA id j134-20020a25238c000000b00c64533e4e20sm2472174ybj.33.2023.09.25.16.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 16:50:33 -0700 (PDT)
Message-ID: <3accffd0-25d3-1ade-1df0-e8aaddd997e6@gmail.com>
Date: Mon, 25 Sep 2023 16:50:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC bpf-next v3 08/11] bpf: pass attached BTF to find correct
 type info of struct_ops progs.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20230920155923.151136-1-thinker.li@gmail.com>
 <20230920155923.151136-9-thinker.li@gmail.com>
 <CAEf4BzbZgR9yEGn41NeCk=sgTAUQ4N241SZBEF0359TFPnm8ag@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzbZgR9yEGn41NeCk=sgTAUQ4N241SZBEF0359TFPnm8ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/25/23 15:58, Andrii Nakryiko wrote:
> On Wed, Sep 20, 2023 at 9:00 AM <thinker.li@gmail.com> wrote:
>>
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> The type info of a struct_ops type may be in a module.  So, we need to know
>> which module BTF to look for type information.  The later patches will make
>> libbpf to attach module BTFs to programs. This patch passes attached BTF
>> from syscall to bpf_struct_ops subsystem to make sure attached BTF is
>> available when the bpf_struct_ops subsystem is ready to use it.
>>
>> bpf_prog has attach_btf in aux from attach_btf_obj_fd, that is pass along
>> with the bpf_attr loading the program. attach_btf is used to find the btf
>> type of attach_btf_id. attach_btf_id is used to identify the traced
>> function for a trace program.  For struct_ops programs, it is used to
>> identify the struct_ops type of the struct_ops object a program attached
>> to.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/uapi/linux/bpf.h       |  4 ++++
>>   kernel/bpf/bpf_struct_ops.c    | 12 +++++++++++-
>>   kernel/bpf/syscall.c           |  2 +-
>>   kernel/bpf/verifier.c          |  4 +++-
>>   tools/include/uapi/linux/bpf.h |  4 ++++
>>   5 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 73b155e52204..178d6fa45fa0 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -1390,6 +1390,10 @@ union bpf_attr {
>>                   * to using 5 hash functions).
>>                   */
>>                  __u64   map_extra;
>> +
>> +               __u32   mod_btf_fd;     /* fd pointing to a BTF type data
>> +                                        * for btf_vmlinux_value_type_id.
>> +                                        */
> 
> we have attach_btf_obj_fd for BPF_PROG_LOAD command, so I guess
> consistent naming would be "<something>_btf_obj_fd" where <something>
> would make it more-or-less clear that this is BTF for
> btf_vmlinux_value_type_id?

Got it! I will rename it to value_type_btf_obj_fd.

> 
>>          };
>>
>>          struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index 8b5c859377e9..d5600d9ad302 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -765,9 +765,19 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>>          struct bpf_struct_ops_map *st_map;
>>          const struct btf_type *t, *vt;
>>          struct bpf_map *map;
>> +       struct btf *btf;
>>          int ret;
>>
>> -       st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id, btf_vmlinux);
>> +       /* XXX: We need a module name or ID to find a BTF type. */
>> +       /* XXX: should use btf from attr->btf_fd */
> 
> Do we need these XXX: comments? I think you had some more in previous patches

Will be removed.

> 
>> +       if (attr->mod_btf_fd) {
>> +               btf = btf_get_by_fd(attr->mod_btf_fd);
>> +               if (IS_ERR(btf))
>> +                       return ERR_PTR(PTR_ERR(btf));
>> +       } else {
>> +               btf = btf_vmlinux;
>> +       }
>> +       st_ops = bpf_struct_ops_find_value(attr->btf_vmlinux_value_type_id, btf);
>>          if (!st_ops)
>>                  return ERR_PTR(-ENOTSUPP);
> 
> should we make sure that module's BTF is put properly on error?

Yes, this issue has been addressed locally.

> 
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 85c1d908f70f..fed3870fec7a 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -1097,7 +1097,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>>          return ret;
>>   }
>>
>> -#define BPF_MAP_CREATE_LAST_FIELD map_extra
>> +#define BPF_MAP_CREATE_LAST_FIELD mod_btf_fd
>>   /* called via syscall */
>>   static int map_create(union bpf_attr *attr)
>>   {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 99b45501951c..11f85dbc911b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -19623,6 +19623,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>>          const struct btf_member *member;
>>          struct bpf_prog *prog = env->prog;
>>          u32 btf_id, member_idx;
>> +       struct btf *btf;
>>          const char *mname;
>>
>>          if (!prog->gpl_compatible) {
>> @@ -19630,8 +19631,9 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
>>                  return -EINVAL;
>>          }
>>
>> +       btf = prog->aux->attach_btf;
>>          btf_id = prog->aux->attach_btf_id;
>> -       st_ops = bpf_struct_ops_find(btf_id, btf_vmlinux);
>> +       st_ops = bpf_struct_ops_find(btf_id, btf);
>>          if (!st_ops) {
>>                  verbose(env, "attach_btf_id %u is not a supported struct\n",
>>                          btf_id);
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>> index 73b155e52204..178d6fa45fa0 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -1390,6 +1390,10 @@ union bpf_attr {
>>                   * to using 5 hash functions).
>>                   */
>>                  __u64   map_extra;
>> +
>> +               __u32   mod_btf_fd;     /* fd pointing to a BTF type data
>> +                                        * for btf_vmlinux_value_type_id.
>> +                                        */
>>          };
>>
>>          struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
>> --
>> 2.34.1
>>

