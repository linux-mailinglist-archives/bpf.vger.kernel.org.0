Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D492269B6A7
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 01:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBRAWX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 19:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBRAWW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 19:22:22 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C549D627FF
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 16:22:21 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id z26so1254531pfw.1
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 16:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LroIWrNfd5BMBmvoFEFk5RZAtl8CsR1+qZ1ssWNF0wQ=;
        b=K6kb2JamcuRQ+bfGncGbuL/1s1on8gDqfrrKpHDnXMybXulRszVhtsFganUPKvnvWA
         wYRm9SXUm6JKZPfRKpjs3lRr3bhd0yh9yF8uKukKYMwBg6rbnyPspbAjnP5ucVnvB18F
         cipDFuhc4yf75xoWIoQM3UdkDB1Cdi2Y8Xyhhq+AiEjfDJqu3an20r2UiRap8CnEG+zd
         Oq9gMzEG3EH3EvuChmBJnbHG2g8FdB8Ok9tdmCqjEKPShetNuBxWgAtU8WwIGw3rYz98
         P9vC7A0hN4QtUzAXKAZPwb/c8kSVrfSmXQfwe8XQYx7WB3vIX0QGSWDlI5ZOAguwFGna
         UNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LroIWrNfd5BMBmvoFEFk5RZAtl8CsR1+qZ1ssWNF0wQ=;
        b=2lV3Nn8StMSqcMTbh6oSkvi6xxttbMWU8mC/TFpcHX5d7r/YQF7IJu5qt3MCWrycrV
         4Gd2WUH5zF7iNgZq4vY1GF6akUpmUxdsNO+qrwLkcg1mPlVTd+ytio1oIyg39A6JbWBA
         CJ4lxd8kzRXWDNM6X/OVpa6trgKEbPWHPFECVoBJTMuZl+kQVJSmNmIOeycOglbhAb5W
         1WyrjHnGf7cSI/olQP5n6XYdBAaTddswpoLdi9ngJ46vSebHdHPds6T8+FscpQvMjUSu
         bhm3DQFmiyUBEdF8hSvYwigF9RTcFqY7ibDgd9i/hg0hP3yCzIwOWmmdv1cLnsygy817
         YQnQ==
X-Gm-Message-State: AO0yUKU+jndoXUme1PbWtgJbswE9UQzR04AGFRy43nMj89mlgQGFEjFR
        o/TnxvptttC43qD+RHnmePhmYkzu4Jk=
X-Google-Smtp-Source: AK7set+jgmAOO1V9ktb1RHtTk754bX0a1LbgYVfVrD1QUSyx2uKXy4wFZ5lI9EOIhoGK/b/TGnZZPg==
X-Received: by 2002:a62:840a:0:b0:5a9:9744:5757 with SMTP id k10-20020a62840a000000b005a997445757mr6153643pfd.21.1676679741157;
        Fri, 17 Feb 2023 16:22:21 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21cf::1210? ([2620:10d:c090:400::5:2cec])
        by smtp.gmail.com with ESMTPSA id j2-20020aa79282000000b00593cd0f37dcsm3577628pfa.169.2023.02.17.16.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 16:22:20 -0800 (PST)
Message-ID: <e3c8beb3-5ff7-9de2-b4a8-3b23a111198f@gmail.com>
Date:   Fri, 17 Feb 2023 16:22:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH bpf-next 6/7] libbpf: Update a bpf_link with another
 struct_ops.
Content-Language: en-US, en-ZW
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org
References: <20230214221718.503964-1-kuifeng@meta.com>
 <20230214221718.503964-7-kuifeng@meta.com>
 <CAEf4BzaKRd2jif4XeKJ1s8Dfpp-wQyTTbXpF-Not6A5kpOGYqQ@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzaKRd2jif4XeKJ1s8Dfpp-wQyTTbXpF-Not6A5kpOGYqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/16/23 14:48, Andrii Nakryiko wrote:
> On Tue, Feb 14, 2023 at 2:17 PM Kui-Feng Lee <kuifeng@meta.com> wrote:
>>
>> Introduce bpf_link__update_struct_ops(), which will allow you to
>> effortlessly transition the struct_ops map of any given bpf_link into
>> an alternative.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> ---
>>   tools/lib/bpf/libbpf.c   | 35 +++++++++++++++++++++++++++++++++++
>>   tools/lib/bpf/libbpf.h   |  1 +
>>   tools/lib/bpf/libbpf.map |  1 +
>>   3 files changed, 37 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 1eff6a03ddd9..6f7c72e312d4 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -11524,6 +11524,41 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>>          return &link->link;
>>   }
>>
>> +/*
>> + * Swap the back struct_ops of a link with a new struct_ops map.
>> + */
>> +int bpf_link__update_struct_ops(struct bpf_link *link, const struct bpf_map *map)
> 
> we have bpf_link__update_program(), and so the generic counterpart for
> map-based links would be bpf_link__update_map(). Let's call it that.
> And it shouldn't probably assume so much struct_ops specific things.

Sure

> 
>> +{
>> +       struct bpf_link_struct_ops_map *st_ops_link;
>> +       int err, fd;
>> +
>> +       if (!bpf_map__is_struct_ops(map) || map->fd == -1)
>> +               return -EINVAL;
>> +
>> +       /* Ensure the type of a link is correct */
>> +       if (link->detach != bpf_link__detach_struct_ops)
>> +               return -EINVAL;
>> +
>> +       err = bpf_map__update_vdata(map);
> 
> it's a bit weird we do this at attach time, not when bpf_map is
> actually instantiated. Should we move this map contents initialization
> to bpf_object__load() phase? Same for bpf_map__attach_struct_ops().
> What do we lose by doing it after all the BPF programs are loaded in
> load phase?

With the current behavior (w/o links), a struct_ops will be registered 
when updating its value.  If we move bpf_map__update_vdata() to 
bpf_object__load(), a congestion control algorithm will be activated at 
the moment loading it before attaching it.  However, we should activate 
an algorithm at attach time.


> 
>> +       if (err) {
>> +               err = -errno;
>> +               free(link);
>> +               return err;
>> +       }
>> +
>> +       fd = bpf_link_update(link->fd, map->fd, NULL);
>> +       if (fd < 0) {
>> +               err = -errno;
>> +               free(link);
>> +               return err;
>> +       }
>> +
>> +       st_ops_link = container_of(link, struct bpf_link_struct_ops_map, link);
>> +       st_ops_link->map_fd = map->fd;
>> +
>> +       return 0;
>> +}
>> +
>>   typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_event_header *hdr,
>>                                                            void *private_data);
>>
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index 2efd80f6f7b9..dd25cd6759d4 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -695,6 +695,7 @@ bpf_program__attach_freplace(const struct bpf_program *prog,
>>   struct bpf_map;
>>
>>   LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map);
>> +LIBBPF_API int bpf_link__update_struct_ops(struct bpf_link *link, const struct bpf_map *map);
> 
> let's rename to bpf_link__update_map() and put it next to
> bpf_link__update_program() in libbpf.h
> 
>>
>>   struct bpf_iter_attach_opts {
>>          size_t sz; /* size of this struct for forward/backward compatibility */
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 11c36a3c1a9f..ca6993c744b6 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -373,6 +373,7 @@ LIBBPF_1.1.0 {
>>          global:
>>                  bpf_btf_get_fd_by_id_opts;
>>                  bpf_link_get_fd_by_id_opts;
>> +               bpf_link__update_struct_ops;
>>                  bpf_map_get_fd_by_id_opts;
>>                  bpf_prog_get_fd_by_id_opts;
>>                  user_ring_buffer__discard;
> 
> we are in LIBBPF_1.2.0 already, please move
> 
> 
>> --
>> 2.30.2
>>
