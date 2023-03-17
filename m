Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBD36BF31C
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 21:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCQUw3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 16:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjCQUw2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 16:52:28 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A4053736
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 13:52:28 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so6537412pjp.1
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 13:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679086347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=niqv7FCnHV0plgCLOazz6LnM6EOKIk28oxxs0odNkgA=;
        b=png4BY1XOe7io7Esmc02Ob5SB0d6wSUqCESzDvmwj6HRg6uoMyykVAHbS3LUqAHPTq
         4HmLQL2d2bZuMhtwaWc+jfQL78QLUugOqfgC0oC62KPmR/+6jg5XwYHPju7CfZWgdIIV
         9pIfK5HlyeooRJquOSLyOA21CSEIpKUEY4ZDC9z+0k/CIXRT9zpVNWmtgN51DKO6Fw0U
         PNzhLLemuai8H+x2No+1208I8PgGB3ofKVP9HDbu29DddXREmSbQqct1FeLlJznDO8BB
         jszIdV7w+RO2SDdjQuTY/XXKXi+pjwuGMJUlZbqgkaM9JSJvxpKZJwk7KCBgdyC3f776
         elcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niqv7FCnHV0plgCLOazz6LnM6EOKIk28oxxs0odNkgA=;
        b=DKx8S4njUJzGHhJZZ8Kh8VCFLogGuVqqDBRI5kgFInmvrfqifgWKGx7fwm021YqVOo
         LPs8IgBAzmOsoon3tQpcnE7Ofmd/ViSkM694NpOxYrtxiRfQpSr6xIYbXSY5qIEiPIjd
         vu5nMOHjUcfXAgc8pdnOXoN/hhg/767AlD1RwMbN+IX+3I/T5SPXxiOl0l+OSJwgvVA5
         dZZJxeqzuUMew2eXPA2KL1T2BuuyZpX9CXw5VA9VV7uaFsv5WuH7J+a0Pz5AjlTp+nu1
         Iv+H2E8Jt1S3XptpEINRUcB4pdHneYhFVOqps7frIReQ4jkxtMPXILiBmN5pcc5gx1Uu
         327Q==
X-Gm-Message-State: AO0yUKUc4saBpyIIiG5YnmDj/QFXEO9t81h1ZSZ2rNMEDvvWRDEdAp1k
        nCT2oAATbQJo+4thBiMMkmnhVOOPoSA=
X-Google-Smtp-Source: AK7set97pvbIHFs4uKdjjA3wuUKQswsfZqLM4SXGY/3LXA/asetjdTEchbn0k3e83wJF8X292k0NHA==
X-Received: by 2002:a05:6a20:2451:b0:cc:f47b:9a with SMTP id t17-20020a056a20245100b000ccf47b009amr10808785pzc.1.1679086347447;
        Fri, 17 Mar 2023 13:52:27 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::1380? ([2620:10d:c090:400::5:87c3])
        by smtp.gmail.com with ESMTPSA id a24-20020aa78658000000b00597caf6236esm1934201pfo.150.2023.03.17.13.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 13:52:26 -0700 (PDT)
Message-ID: <5a40cd89-2bc1-7a66-b9da-485fc9a6a412@gmail.com>
Date:   Fri, 17 Mar 2023 13:52:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v7 3/8] bpf: Create links for BPF struct_ops
 maps.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230316023641.2092778-1-kuifeng@meta.com>
 <20230316023641.2092778-4-kuifeng@meta.com>
 <9b18b21b-4429-fd87-8c74-0de2900eee42@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <9b18b21b-4429-fd87-8c74-0de2900eee42@linux.dev>
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



On 3/17/23 11:10, Martin KaFai Lau wrote:
> On 3/15/23 7:36 PM, Kui-Feng Lee wrote:
>> +int bpf_struct_ops_link_create(union bpf_attr *attr)
>> +{
>> +    struct bpf_struct_ops_link *link = NULL;
>> +    struct bpf_link_primer link_primer;
>> +    struct bpf_struct_ops_map *st_map;
>> +    struct bpf_map *map;
>> +    int err;
>> +
>> +    map = bpf_map_get(attr->link_create.map_fd);
>> +    if (!map)
>> +        return -EINVAL;
>> +
>> +    st_map = (struct bpf_struct_ops_map *)map;
>> +
>> +    if (!bpf_struct_ops_valid_to_reg(map)) {
>> +        err = -EINVAL;
>> +        goto err_out;
>> +    }
>> +
>> +    link = kzalloc(sizeof(*link), GFP_USER);
>> +    if (!link) {
>> +        err = -ENOMEM;
>> +        goto err_out;
>> +    }
>> +    bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, 
>> &bpf_struct_ops_map_lops, NULL);
>> +    RCU_INIT_POINTER(link->map, map);
> 
> The link->map assignment should be done with the bpf_link_settle(), 
> meaning only assign after everything else has succeeded.
> 
> The link is not exposed to user space until bpf_link_settle(). The 
> link->map assignment can be done after ->reg succeeded and do it just 
> before bpf_link_settle(). Then there is no need to do the 
> RCU_INIT_POINTER(link->map, NULL) dance in the error case.
> 

Sound good! I will move this line.

>> +
>> +    err = bpf_link_prime(&link->link, &link_primer);
>> +    if (err)
>> +        goto err_out;
>> +
>> +    err = st_map->st_ops->reg(st_map->kvalue.data);
>> +    if (err) {
>> +        /* No RCU since no one has a chance to read this pointer yet. */
>> +        RCU_INIT_POINTER(link->map, NULL);
>> +        bpf_link_cleanup(&link_primer);
>> +        link = NULL;
>> +        goto err_out;
>> +    }
>> +
>> +    return bpf_link_settle(&link_primer);
>> +
>> +err_out:
>> +    bpf_map_put(map);
>> +    kfree(link);
>> +    return err;
>> +}
> 
