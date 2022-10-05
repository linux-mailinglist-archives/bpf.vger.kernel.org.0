Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5863C5F5058
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 09:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJEHc3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 03:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJEHc2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 03:32:28 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6F36B8E5;
        Wed,  5 Oct 2022 00:32:27 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 78so14611579pgb.13;
        Wed, 05 Oct 2022 00:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JnszcKdOga13/q2jZFkeyfMgifTRmBiKtc/gRSpJzQ=;
        b=RS1Uqa6bV6uv+yDBnRGj+8JTbDPFupcc1acfK6VcMQzMTmcaA1oNbDMgCAG1FGg3gk
         XX7lh1+TRlIL50EJZ2qVRrBLOYwBw3x+/oPrGkOCVCfYLUYijCUlzVDDLrq9YqIOHa8F
         4nlWb2VTNTY8vCZsR87vSlbjJC257iZ3mYf4rulXc9vEuzBMac+RiAhXAAO1zh5Ckplc
         GjHopdLcEsENsSqParPqEyUkvbwfxOv421QFCPldoTlelxkcA+774+kcMz7urono9z7g
         hfFWvwh+aXbT/qlATEcOZH0I81hzhYqC4RJT2Gsc/exP4FibP8hWNVRVvWZg4VYNltwK
         zUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JnszcKdOga13/q2jZFkeyfMgifTRmBiKtc/gRSpJzQ=;
        b=Xz6xnD9lgV4JqFO2bLmweK50PjUiLk8dm+BOnTCai+SyI4C3k+AjRU08C+Uhch3HjV
         lpI6htTfMalghphkoKPmKB/+RUAqm7B39OACLvbMuE572RdRQQDh5kdHDtymzGU9NiSG
         X2HZR2WcKzSrGIDTJcwYuT8XkIG2s65dWQ/rMjxxQZzcmM0tjBbx+IiS6eCi78ia6alt
         n1+a0/JTI2CQqBdPmxqU/zSh3EAw3VKUjpozJOTHMFFsfoZRJaSgqi7DTiyxRmowvJak
         z12A9fKgskP79xATrmJqRTUG2+41Hp98lt/h5LxOAh3iaSi1sElm8uXt2xKzteqC5u90
         sRXQ==
X-Gm-Message-State: ACrzQf3n6kmhM250akCVcabJzAvW/5wXX/aDBukWIGfpBB+mVEIpyJdR
        Wlzxg1WBIyNHBvHvh58LSZQGzAcd2zkQGw==
X-Google-Smtp-Source: AMsMyM4TcaslKsU4xMMOHEM0yzqI6lu/CwdmXOAQl9hKQ/Q+ga+9u8kZnbHNVses7WhL39UrujU48A==
X-Received: by 2002:a65:498b:0:b0:412:8e4:2842 with SMTP id r11-20020a65498b000000b0041208e42842mr26507368pgs.71.1664955147294;
        Wed, 05 Oct 2022 00:32:27 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-30.three.co.id. [180.214.233.30])
        by smtp.gmail.com with ESMTPSA id 200-20020a6214d1000000b0055abc22a1absm7761769pfu.209.2022.10.05.00.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 00:32:26 -0700 (PDT)
Message-ID: <acc73050-f0a4-099d-37c1-5fca6b20136c@gmail.com>
Date:   Wed, 5 Oct 2022 14:32:24 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH bpf-next v5 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
Content-Language: en-US
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     dave@dtucker.co.uk
References: <20221004161929.52609-1-donald.hunter@gmail.com>
 <20221004161929.52609-2-donald.hunter@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221004161929.52609-2-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/4/22 23:19, Donald Hunter wrote:
> +Examples
> +========
> +
> +Please see the ``tools/testing/selftests/bpf`` directory for functional
> +examples. The sample code below demonstrates API usage.
> +

Since you have many code snippets, better say "The code samples below".

> +Kernel
> +------
> +
> +This snippet shows how to declare an array in a BPF program.
> +
> +.. code-block:: c
> +
> +    struct {
> +            __uint(type, BPF_MAP_TYPE_ARRAY);
> +            __type(key, u32);
> +            __type(value, long);
> +            __uint(max_entries, 256);
> +    } my_map SEC(".maps");
> +
> +
> +This example shows how to access an array element.
> +
> +.. code-block:: c
> +
> +    int bpf_prog(struct __sk_buff *skb)
> +    {
> +            int index = load_byte(skb,
> +                                  ETH_HLEN + offsetof(struct iphdr, protocol));
> +            long *value;
> +
> +            if (skb->pkt_type != PACKET_OUTGOING)
> +                    return 0;
> +
> +            value = bpf_map_lookup_elem(&my_map, &index);
> +            if (value)
> +                    __sync_fetch_and_add(value, skb->len);
> +
> +            return 0;
> +    }
> +
> +Userspace
> +---------
> +
> +BPF_MAP_TYPE_ARRAY
> +~~~~~~~~~~~~~~~~~~
> +
> +This example shows array creation, initialisation and lookup from userspace.
> +

"Initialize the array, set elements, and perform lookup".

> +.. code-block:: c
> +
> +    #include <assert.h>
> +    #include <bpf/libbpf.h>
> +    #include <bpf/bpf.h>
> +
> +    int main(int argc, char **argv)
> +    {
> +	    int fd;
> +	    int ret = 0;
> +	    long value;
> +	    __u32 index = 42;
> +	    __u32 i;
> +
> +	    fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "example_array",
> +				sizeof(__u32), sizeof(long),
> +				256, 0);
> +	    if (fd < 0)
> +		    return fd;
> +
> +	    /* fill the map with values from 0-255 */
> +	    for (i = 0; i < 256 ; i++) {
> +		    value = i;
> +		    ret = bpf_map_update_elem(fd, &i, &value, BPF_ANY);
> +		    if (ret < 0)
> +			    return ret;
> +	    }
> +
> +	    ret = bpf_map_lookup_elem(fd, &index, &value);
> +	    if (ret < 0)
> +		    return ret;
> +
> +	    assert(value == 42);
> +
> +	    return ret;
> +    }
> +
> +BPF_MAP_TYPE_PERCPU_ARRAY
> +~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +This example shows per CPU array usage.
> +
> +.. code-block:: c
> +
> +    #include <assert.h>
> +    #include <bpf/libbpf.h>
> +    #include <bpf/bpf.h>
> +
> +    int main(int argc, char **argv)
> +    {
> +	    int ncpus = libbpf_num_possible_cpus();
> +	    if (ncpus < 0)
> +		    return ncpus;
> +
> +	    int fd;
> +	    int ret = 0;
> +	    __u32 i, j;
> +	    __u32 index = 42;
> +	    long v[ncpus], value[ncpus];
> +
> +	    fd = bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "example_percpu",
> +				sizeof(__u32), sizeof(long), 256, 0);
> +	    if (fd < 0)
> +		    return -1;
> +
> +	    /* fill the map with values from 0-255 for each cpu */
> +	    for (i = 0; i < 256 ; i++) {
> +		    for (j = 0; j < ncpus; j++)
> +			    v[j] = i;
> +		    ret = bpf_map_update_elem(fd, &i, &v, BPF_ANY);
> +		    if (ret < 0)
> +			    return ret;
> +	    }
> +
> +	    ret = bpf_map_lookup_elem(fd, &index, &value);
> +	    if (ret < 0)
> +		    return ret;
> +
> +	    for (j = 0; j < ncpus; j++)
> +		    assert(value[j] == 42);
> +
> +	    return ret;
> +    }
> +

What is the purpose of above snippet? Give more detailed explanation.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
