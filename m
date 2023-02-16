Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E4F699BB6
	for <lists+bpf@lfdr.de>; Thu, 16 Feb 2023 18:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjBPR7n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Feb 2023 12:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBPR7m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Feb 2023 12:59:42 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76A310273
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 09:59:40 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w20-20020a17090a8a1400b00233d7314c1cso6638685pjn.5
        for <bpf@vger.kernel.org>; Thu, 16 Feb 2023 09:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vP2SSh+4sG2GVJL8KRK4l33AqWoBjXBtS7qRAUdw3b4=;
        b=g5Z2dx8FpsFMNczKEUar1fpqDip+m6h0anbrQhcfve7g1NehfzJC92BM2uqUNa+l5e
         LTSBqaFjawAx5pJU55Y/QSloavfijst6ga6NPFiP2UOTx41iEHdQ6V7XStXtC8nHh/km
         YERZp+AbI5BenSzaZoVk4UKdmJiA/2bEleA2sX7LywIFEpU8mh6jt4qt+Mytu/7uIuAQ
         F3CLIgEELEY1HvAbA085y5papR88ZYSMmp4s7avvfCuvL6coT2nent0T1SrEfbQ6fcZf
         O7Qt/x6x15xkaMuLrb928Wljuf0ffo+w6JmSsc6j4ypvFIYaYmSh1/T5mESazVmHYa5e
         sNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vP2SSh+4sG2GVJL8KRK4l33AqWoBjXBtS7qRAUdw3b4=;
        b=qC5cN0AS11O3SE2SHnZqQ7ABlqgRjpxMd12DAa6yq8zLIloGTJyUgaOIkMAjkm9xsx
         QH2Nuh59G0I3gogEy+hYaxFs0QElYRMnRATuXIrsXtB3ZIUV5xaAkxDUotEpq1XBwlmX
         ug07z+FwqcfbZw2D7SkunPfA0nWvtYSBRYjRyNxtm+mBIurhAkbptqCNyKxH6OvEYEL6
         jS80T7lwVgk2fTS4K4FUpWLidK3+He3ZPwabxTlYUPJA3bE7eG0i0e5lpO+U3NN+oFAb
         V7Bt4W+ak7CCsD1j+ZsLnWvHWp8t+WW3WaeDSbzDJTbAv6sZeavHniB9uyZeT/AXG0tW
         gKZg==
X-Gm-Message-State: AO0yUKVsik3+rK/6cx56pLKVmgkFtPJF/SAVToj1S9rZydRC10WkmnDD
        +peuH/ZSbo5kfqDB+fhTVnk=
X-Google-Smtp-Source: AK7set9+e5cGxeJ0YRepYsT+QeWUreEgaseDhjLUAZrDu736JKTQ4wcRbKTyJLmazmM1Eoui/HEi7Q==
X-Received: by 2002:a17:902:ebd0:b0:196:5839:b36a with SMTP id p16-20020a170902ebd000b001965839b36amr5817369plg.8.1676570379943;
        Thu, 16 Feb 2023 09:59:39 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21e8::12ef? ([2620:10d:c090:400::5:962a])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b0019aa8149cb3sm1587605pln.219.2023.02.16.09.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 09:59:39 -0800 (PST)
Message-ID: <25d9322f-a581-cc37-5b68-cc6c674b6ce8@gmail.com>
Date:   Thu, 16 Feb 2023 09:59:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH bpf-next 1/7] bpf: Create links for BPF struct_ops maps.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-2-kuifeng@meta.com>
 <ff8faacb-c972-9698-61da-1ecfa077d716@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ff8faacb-c972-9698-61da-1ecfa077d716@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/15/23 14:58, Martin KaFai Lau wrote:
> On 2/14/23 2:17 PM, Kui-Feng Lee wrote:
>> BPF struct_ops maps are employed directly to register TCP Congestion
>> Control algorithms. Unlike other BPF programs that terminate when
>> their links gone, the struct_ops program reduces its refcount solely
>> upon death of its FD. 
> 
> I think the refcount comment probably not needed for this patch.

Got it!
> 
>> The link of a BPF struct_ops map provides a
>> uniform experience akin to other types of BPF programs.  A TCP
>> Congestion Control algorithm will be unregistered upon destroying the
>> FD in the following patches.
> 
> 
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 17afd2b35ee5..1e6cdd0f355d 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
> 
> The existing BPF_LINK_TYPE_STRUCT_OPS enum is reused. Please explain why 
> it can be reused in the commit message and also add comments around the 
> existing "bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS...)" in 
> bpf_struct_ops_map_update_elem().

Sure!
> 
>> @@ -1033,6 +1033,7 @@ enum bpf_attach_type {
>>       BPF_PERF_EVENT,
>>       BPF_TRACE_KPROBE_MULTI,
>>       BPF_LSM_CGROUP,
>> +    BPF_STRUCT_OPS_MAP,
> 
> nit. Only BPF_STRUCT_OPS. No need for "_MAP".
> 
>>       __MAX_BPF_ATTACH_TYPE
>>   };
>> @@ -6354,6 +6355,9 @@ struct bpf_link_info {
>>           struct {
>>               __u32 ifindex;
>>           } xdp;
>> +        struct {
>> +            __u32 map_id;
>> +        } struct_ops_map;
> 
> nit. Same here, skip the "_map";

Got!

> 
> This looks good instead of union. In case the user space tool directly 
> uses the prog_id without checking the type.
> 
>>       };
>>   } __attribute__((aligned(8)));
>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>> index ece9870cab68..621c8e24481a 100644
>> --- a/kernel/bpf/bpf_struct_ops.c
>> +++ b/kernel/bpf/bpf_struct_ops.c
>> @@ -698,3 +698,69 @@ void bpf_struct_ops_put(const void *kdata)
>>           call_rcu(&st_map->rcu, bpf_struct_ops_put_rcu);
>>       }
>>   }
>> +
>> +static void bpf_struct_ops_map_link_release(struct bpf_link *link)
>> +{
>> +    if (link->map) {
>> +        bpf_map_put(link->map);
>> +        link->map = NULL;
>> +    }
>> +}
>> +
>> +static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
>> +{
>> +    kfree(link);
>> +}
>> +
>> +static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link 
>> *link,
>> +                        struct seq_file *seq)
>> +{
>> +    seq_printf(seq, "map_id:\t%d\n",
>> +          link->map->id);
>> +}
>> +
>> +static int bpf_struct_ops_map_link_fill_link_info(const struct 
>> bpf_link *link,
>> +                           struct bpf_link_info *info)
>> +{
>> +    info->struct_ops_map.map_id = link->map->id;
>> +    return 0;
>> +}
>> +
>> +static const struct bpf_link_ops bpf_struct_ops_map_lops = {
>> +    .release = bpf_struct_ops_map_link_release,
>> +    .dealloc = bpf_struct_ops_map_link_dealloc,
>> +    .show_fdinfo = bpf_struct_ops_map_link_show_fdinfo,
>> +    .fill_link_info = bpf_struct_ops_map_link_fill_link_info,
>> +};
> 
> Can .detach be supported also?

Sure!

> 
>> +
>> +int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t uattr)
> 
> Does it need uattr?
> 
> nit. Rename to bpf_struct_ops_link_attach(), like how other link type's 
> "attach" functions are named. or may be even just bpf_struct_ops_attach().

Got it!

> 
>> +{
>> +    struct bpf_link_primer link_primer;
>> +    struct bpf_map *map;
>> +    struct bpf_link *link = NULL;
>> +    int err;
>> +
>> +    map = bpf_map_get(attr->link_create.prog_fd);
> 
> This one looks weird. passing prog_fd to bpf_map_get(). I think in this 
> case it makes sense to union map_fd with prog_fd in attr->link_create ?
> 
>> +    if (map->map_type != BPF_MAP_TYPE_STRUCT_OPS)
> 
> map is leaked.

Yes, I will fix it.
> 
>> +        return -EINVAL;
>> +
>> +    link = kzalloc(sizeof(*link), GFP_USER);
>> +    if (!link) {
>> +        err = -ENOMEM;
>> +        goto err_out;
>> +    }
>> +    bpf_link_init(link, BPF_LINK_TYPE_STRUCT_OPS, 
>> &bpf_struct_ops_map_lops, NULL);
>> +    link->map = map;
>> +
>> +    err = bpf_link_prime(link, &link_primer);
>> +    if (err)
>> +        goto err_out;
>> +
>> +    return bpf_link_settle(&link_primer);
>> +
>> +err_out:
>> +    bpf_map_put(map);
>> +    kfree(link);
>> +    return err;
>> +}
>> +
> 
> [ ... ]
> 
>> +extern int link_create_struct_ops_map(union bpf_attr *attr, bpfptr_t 
>> uattr);
> 
> Move it to bpf.h.
> 
>> +
>>   #define BPF_LINK_CREATE_LAST_FIELD link_create.kprobe_multi.cookies
>>   static int link_create(union bpf_attr *attr, bpfptr_t uattr)
>>   {
>> @@ -4541,6 +4549,9 @@ static int link_create(union bpf_attr *attr, 
>> bpfptr_t uattr)
>>       if (CHECK_ATTR(BPF_LINK_CREATE))
>>           return -EINVAL;
>> +    if (attr->link_create.attach_type == BPF_STRUCT_OPS_MAP)
>> +        return link_create_struct_ops_map(attr, uattr);
>> +
>>       prog = bpf_prog_get(attr->link_create.prog_fd);
>>       if (IS_ERR(prog))
>>           return PTR_ERR(prog);
>> diff --git a/tools/include/uapi/linux/bpf.h 
>> b/tools/include/uapi/linux/bpf.h
>> index 17afd2b35ee5..1e6cdd0f355d 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -1033,6 +1033,7 @@ enum bpf_attach_type {
>>       BPF_PERF_EVENT,
>>       BPF_TRACE_KPROBE_MULTI,
>>       BPF_LSM_CGROUP,
>> +    BPF_STRUCT_OPS_MAP,
>>       __MAX_BPF_ATTACH_TYPE
>>   };
>> @@ -6354,6 +6355,9 @@ struct bpf_link_info {
>>           struct {
>>               __u32 ifindex;
>>           } xdp;
>> +        struct {
>> +            __u32 map_id;
>> +        } struct_ops_map;
>>       };
>>   } __attribute__((aligned(8)));
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index 9aff98f42a3d..e44d49f17c86 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
> 
> Not necessary in this set and could be a follow up. Have you thought 
> about how to generate a skel including the struct_ops link?

The user must now call bpf_map__set_map_flags() between XXXX__open() and 
XXX__load(). To simplify the process, skel should invoke 
bpf_map__set_map_flags() in the function of XXX__open_and _load(). 
Therefore, a method to indicate which struct_ops need a link is 
necessary. For instance,

SEC(".struct_ops")
struct tcp_congestion_ops xxx_map = {
  ...
  .flags = BPF_F_LINK,
  ...
};

We probably can do it without any change to the code generator.

> 
>> @@ -731,6 +731,8 @@ int bpf_link_create(int prog_fd, int target_fd,
>>           if (!OPTS_ZEROED(opts, tracing))
>>               return libbpf_err(-EINVAL);
>>           break;
>> +    case BPF_STRUCT_OPS_MAP:
>> +        break;
>>       default:
>>           if (!OPTS_ZEROED(opts, flags))
>>               return libbpf_err(-EINVAL);
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 35a698eb825d..75ed95b7e455 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -115,6 +115,7 @@ static const char * const attach_type_name[] = {
>>       [BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]    = 
>> "sk_reuseport_select_or_migrate",
>>       [BPF_PERF_EVENT]        = "perf_event",
>>       [BPF_TRACE_KPROBE_MULTI]    = "trace_kprobe_multi",
>> +    [BPF_STRUCT_OPS_MAP]        = "struct_ops_map",
>>   };
>>   static const char * const link_type_name[] = {
> 
