Return-Path: <bpf+bounces-2581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A1D72F7EE
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 10:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F45280EF7
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 08:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1885215BD;
	Wed, 14 Jun 2023 08:33:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB225369
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 08:33:44 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F611BD4
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 01:33:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f8cc04c287so3224365e9.0
        for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 01:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1686731621; x=1689323621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRpCXoZix0pOWS728xP7zdE75KY3Fmxsvn5IvxdZ5gQ=;
        b=FSiBWwRkjVYFMKCNKi9FE762JYyR8MUIfSIrKN5jU+ikKdC5Uq7nXjwnBiz94w+sSN
         w0G3Gk2/xNMgbyqPUm1vpzYSK0PC9Mi5cJBkszkPRFeEaKtc51S2nSb21x0pbyIPSRnQ
         aO/6fuetP9lb5cVhd83pK7KzHXLEuoOa2/jnWDT1TUrPYbrZVfIyI2bRJjIdgH/6bIoX
         D/7xGNs7p3mSOKKRPLdkDE+kdEPFT6dU34lwh1CaacriDIKYbKuE5u4Dc4nNNPhC1Y+I
         v6ZPyd60ziEV4WgUmI0QG265UpAJZIMZ6c5g2AqrzNhR7YVBzmSQLlr/dRUAJtL6QzhJ
         k72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686731621; x=1689323621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRpCXoZix0pOWS728xP7zdE75KY3Fmxsvn5IvxdZ5gQ=;
        b=aJcqEMlBzN5JqbphlgGvTdNGLO3ERIikfe1cKZLsfylRCmVHP+QdssfWyOAoTnVUoM
         1C+Am7bG9q14qVApznUzUI6GYNaO+KscGvaVfZ+lP1WiNmv+AicfP5EYEmw7FhL0XMNg
         Nl6fYPO8zTzUIjdZdM4BeYdpV0jugxYizp6r5Q89/fiJmDP0SZUdMtFsyTqqdcSD+whI
         5NOnpJdcsRle9+a8gCJoXx7LXG6yFi224/87DcXHv+N8a9QMQUSf+eyX6sWlWNTlHthv
         8nw0Fww8zL1jy1uC8xaDrnjVBo/6kRswFXOaHow1D11wTtetcPHgH8zGUZgqbOGi/aMM
         8kbA==
X-Gm-Message-State: AC+VfDzmovvfNa8p70Za8FlhT9cCMgcffTfgW3YPk4vAKX8wNEX0vOrH
	ILGTXx2HLwllNw460CNaWFgfSg==
X-Google-Smtp-Source: ACHHUZ58N58pxV7jLB0NP5FDfdcY0M4gjTYHerFcwYdZqj1QbF2Tg837vyped0uQPV3DW9HNEl+AiA==
X-Received: by 2002:a7b:cd0d:0:b0:3f7:e497:aa03 with SMTP id f13-20020a7bcd0d000000b003f7e497aa03mr9862064wmj.28.1686731620926;
        Wed, 14 Jun 2023 01:33:40 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:e9c4:e1ca:ed10:31ea? ([2a02:8011:e80c:0:e9c4:e1ca:ed10:31ea])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c204700b003f7a562ff31sm16729579wmg.6.2023.06.14.01.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 01:33:40 -0700 (PDT)
Message-ID: <df9ffd9e-9c0d-c3c8-b96a-c697319be1ac@isovalent.com>
Date: Wed, 14 Jun 2023 09:33:39 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 bpf-next 03/10] bpftool: Show probed function in
 kprobe_multi link info
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <sinquersw@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20230612151608.99661-1-laoar.shao@gmail.com>
 <20230612151608.99661-4-laoar.shao@gmail.com>
 <06f219e8-9ae5-01a1-f955-25f556ad5077@gmail.com>
 <CALOAHbCjmn5_E8W+JG1_KYaprBm6k0PUGDFsydHbfSDzLmFxOQ@mail.gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CALOAHbCjmn5_E8W+JG1_KYaprBm6k0PUGDFsydHbfSDzLmFxOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-06-14 10:42 UTC+0800 ~ Yafang Shao <laoar.shao@gmail.com>
> On Wed, Jun 14, 2023 at 6:36=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.c=
om> wrote:
>>
>>
>>
>> On 6/12/23 08:16, Yafang Shao wrote:
>>> Show the already expose kprobe_multi link info in bpftool. The result=
 as
>>> follows,
>>>
>>> 52: kprobe_multi  prog 381
>>>          retprobe 0  func_cnt 7
>>>          addrs ffffffff9ec44f20  funcs schedule_timeout_interruptible=

>>>                ffffffff9ec44f60        schedule_timeout_killable
>>>                ffffffff9ec44fa0        schedule_timeout_uninterruptib=
le
>>>                ffffffff9ec44fe0        schedule_timeout_idle
>>>                ffffffffc09468d0        xfs_trans_get_efd [xfs]
>>>                ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
>>>                ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
>>>          pids kprobe_multi(559862)
>>> 53: kprobe_multi  prog 381
>>>          retprobe 1  func_cnt 7
>>>          addrs ffffffff9ec44f20  funcs schedule_timeout_interruptible=

>>>                ffffffff9ec44f60        schedule_timeout_killable
>>>                ffffffff9ec44fa0        schedule_timeout_uninterruptib=
le
>>>                ffffffff9ec44fe0        schedule_timeout_idle
>>>                ffffffffc09468d0        xfs_trans_get_efd [xfs]
>>>                ffffffffc0953a10        xfs_trans_get_buf_map [xfs]
>>>                ffffffffc0957320        xfs_trans_get_dqtrx [xfs]
>>>          pids kprobe_multi(559862)
>>>
>>> $ tools/bpf/bpftool/bpftool link show -j
>>> [{"id":52,"type":"kprobe_multi","prog_id":381,"retprobe":0,"func_cnt"=
:7,"funcs":[{"addr":18446744072078249760,"func":"schedule_timeout_interru=
ptible","module":""},{"addr":18446744072078249824,"func":"schedule_timeou=
t_killable","module":""},{"addr":18446744072078249888,"func":"schedule_ti=
meout_uninterruptible","module":""},{"addr":18446744072078249952,"func":"=
schedule_timeout_idle","module":""},{"addr":18446744072645535952,"func":"=
xfs_trans_get_efd","module":"[xfs]"},{"addr":18446744072645589520,"func":=
"xfs_trans_get_buf_map","module":"[xfs]"},{"addr":18446744072645604128,"f=
unc":"xfs_trans_get_dqtrx","module":"[xfs]"}],"pids":[{"pid":559862,"comm=
":"kprobe_multi"}]},{"id":53,"type":"kprobe_multi","prog_id":381,"retprob=
e":1,"func_cnt":7,"funcs":[{"addr":18446744072078249760,"func":"schedule_=
timeout_interruptible","module":""},{"addr":18446744072078249824,"func":"=
schedule_timeout_killable","module":""},{"addr":18446744072078249888,"fun=
c":"schedule_timeout_uninterruptible","module":""},{"addr":18446744072078=
249952,"func":"schedule_timeout_idle","module":""},{"addr":18446744072645=
535952,"func":"xfs_trans_get_efd","module":"[xfs]"},{"addr":1844674407264=
5589520,"func":"xfs_trans_get_buf_map","module":"[xfs]"},{"addr":18446744=
072645604128,"func":"xfs_trans_get_dqtrx","module":"[xfs]"}],"pids":[{"pi=
d":559862,"comm":"kprobe_multi"}]}]
>>>
>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>> ---
>>>   tools/bpf/bpftool/link.c | 109 ++++++++++++++++++++++++++++++++++++=
++++++++++-
>>>   1 file changed, 108 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
>>> index 2d78607..0015582 100644
>>> --- a/tools/bpf/bpftool/link.c
>>> +++ b/tools/bpf/bpftool/link.c
>>> @@ -14,8 +14,10 @@
>>>
>>>   #include "json_writer.h"
>>>   #include "main.h"
>>> +#include "xlated_dumper.h"
>>>
>>>   static struct hashmap *link_table;
>>> +static struct dump_data dd =3D {};
>>>
>>>   static int link_parse_fd(int *argc, char ***argv)
>>>   {
>>> @@ -166,6 +168,45 @@ static int get_prog_info(int prog_id, struct bpf=
_prog_info *info)
>>>       return err;
>>>   }
>>>
>>> +static int cmp_u64(const void *A, const void *B)
>>> +{
>>> +     const __u64 *a =3D A, *b =3D B;
>>> +
>>> +     return *a - *b;
>>> +}
>>> +
>>> +static void
>>> +show_kprobe_multi_json(struct bpf_link_info *info, json_writer_t *wt=
r)
>>> +{
>>> +     __u32 i, j =3D 0;
>>> +     __u64 *addrs;
>>> +
>>> +     jsonw_uint_field(json_wtr, "retprobe",
>>> +                      info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_=
RETURN);
>>> +     jsonw_uint_field(json_wtr, "func_cnt", info->kprobe_multi.count=
);
>>> +     jsonw_name(json_wtr, "funcs");
>>> +     jsonw_start_array(json_wtr);
>>> +     addrs =3D (__u64 *)u64_to_ptr(info->kprobe_multi.addrs);
>>> +     qsort((void *)addrs, info->kprobe_multi.count, sizeof(__u64), c=
mp_u64);
>>> +
>>> +     /* Load it once for all. */
>>> +     if (!dd.sym_count)
>>> +             kernel_syms_load(&dd);
>>> +     for (i =3D 0; i < dd.sym_count; i++) {
>>> +             if (dd.sym_mapping[i].address !=3D addrs[j])
>>> +                     continue;
>>> +             jsonw_start_object(json_wtr);
>>> +             jsonw_uint_field(json_wtr, "addr", dd.sym_mapping[i].ad=
dress);
>>> +             jsonw_string_field(json_wtr, "func", dd.sym_mapping[i].=
name);
>>> +             /* Print none if it is vmlinux */
>>> +             jsonw_string_field(json_wtr, "module", dd.sym_mapping[i=
].module);
>>> +             jsonw_end_object(json_wtr);
>>> +             if (j++ =3D=3D info->kprobe_multi.count)
>>> +                     break;
>>> +     }
>>> +     jsonw_end_array(json_wtr);
>>> +}
>>> +
>>>   static int show_link_close_json(int fd, struct bpf_link_info *info)=

>>>   {
>>>       struct bpf_prog_info prog_info;
>>> @@ -218,6 +259,9 @@ static int show_link_close_json(int fd, struct bp=
f_link_info *info)
>>>               jsonw_uint_field(json_wtr, "map_id",
>>>                                info->struct_ops.map_id);
>>>               break;
>>> +     case BPF_LINK_TYPE_KPROBE_MULTI:
>>> +             show_kprobe_multi_json(info, json_wtr);
>>> +             break;
>>>       default:
>>>               break;
>>>       }
>>> @@ -351,6 +395,44 @@ void netfilter_dump_plain(const struct bpf_link_=
info *info)
>>>               printf(" flags 0x%x", info->netfilter.flags);
>>>   }
>>>
>>> +static void show_kprobe_multi_plain(struct bpf_link_info *info)
>>> +{
>>> +     __u32 i, j =3D 0;
>>> +     __u64 *addrs;
>>> +
>>> +     if (!info->kprobe_multi.count)
>>> +             return;
>>> +
>>> +     printf("\n\tretprobe %d  func_cnt %u  ",
>>> +            info->kprobe_multi.flags & BPF_F_KPROBE_MULTI_RETURN,
>>> +            info->kprobe_multi.count);
>>> +     addrs =3D (__u64 *)u64_to_ptr(info->kprobe_multi.addrs);
>>> +     qsort((void *)addrs, info->kprobe_multi.count, sizeof(__u64), c=
mp_u64);
>>> +
>>> +     /* Load it once for all. */
>>> +     if (!dd.sym_count)
>>> +             kernel_syms_load(&dd);
>>> +     for (i =3D 0; i < dd.sym_count; i++) {
>>> +             if (dd.sym_mapping[i].address !=3D addrs[j])
>>> +                     continue;
>>> +             if (!j)
>>> +                     printf("\n\taddrs %016lx  funcs %s",
>>> +                            dd.sym_mapping[i].address,
>>> +                            dd.sym_mapping[i].name);
>>> +             else
>>> +                     printf("\n\t      %016lx        %s",
>>> +                            dd.sym_mapping[i].address,
>>> +                            dd.sym_mapping[i].name);
>>> +             if (dd.sym_mapping[i].module[0] !=3D '\0')
>>> +                     printf(" %s  ", dd.sym_mapping[i].module);
>>> +             else
>>> +                     printf("  ");
>>
>> Could you explain what these extra spaces after module names are for?
>=20
> There are two spaces. We use two spaces to seperate different items
> printed in bpftool. For example,
>   "4: kprobe_multi  prog 16"
> There are two spaces between the "type" and the "prog".
>=20
> We always print these two spaces after one item is printed:
>   printf("type %u  ", info->type);
>   printf("prog %u  ", info->prog_id);
> That way, we can add new item easily and consistently.
>=20

I'm not sure we _always_ do it at the end of lines, but it seems to be
rather consistent in link.c at least. For my part I don't know if this
printf("  ") is really necessary - I'd rather avoid spaces at the end of
lines, but then there would be several other locations to update. So I
don't have any objection, either.

Quentin

