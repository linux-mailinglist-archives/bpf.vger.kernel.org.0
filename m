Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E746C3E3F
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 00:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjCUXEc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 19:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjCUXEb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 19:04:31 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FB8E04D
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 16:04:26 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u5so17641895plq.7
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 16:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679439866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myXvX6xrspcE4SRik75wVolzUhA+jTfMs1Qrtc7pbok=;
        b=gESlQGiCJN+EC++vVVRy5D9T+FRZXAkE8lxTs2F1asmtQ/ARDyfsOvPD/ebsYiHl1p
         Eul9q1+LDhCzy8ke8tgZnGto3zfzOg2AF4oMR3v8OWphBJ7Ov1+sEkPYfzG7cqxOLJMU
         9TZB9OI/U7s+UD3KEcRKSuYdsqRHHd5PYUmwZPMp0ZxtKdEHxRjKABnIEnxsNGdQKlr/
         ScU8WkqBnZ56pAnLTXjMHuBG2z7PLAqlW7RNv8oyEqPF1SqMKn9vDllKyaQXam937jnD
         TvQQXD6lE2v/5zLDGHy3dc42FIml/qMFe3OYZY9krD3qAnBwuTpnU9srN/4iiuyQZbY6
         ZZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679439866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myXvX6xrspcE4SRik75wVolzUhA+jTfMs1Qrtc7pbok=;
        b=VdtK3NCJI1pIMsyVdHN1cXeQLC0X+BVRzOgLPumm1uWn4XSm03n0czWUSLfFTmpvLN
         h3AvFor1ON+lX193ab8+AXs0Etm1zvFXbAGQwuyyQpcVIomadGxeD0TCc1xWdXbSNarz
         /ieuCBOAM2+M9arJuM5AnwA6i/zobMcidZuAUkuXMkrrCOkAg1sOjuS8Z3rOU8vHtz1z
         /+OT0Qq9qRXmojfYMYsogopY/55hjJneRQwXDE2DxL7t8LdJcrQ4kIxK5j5mDaNeXGLu
         K5FY3NYU4LqZYYyw2629IdAauKA5pxV+GG4LybMRAEhM+NaD5usmgtcCpqsQRQjVv4CQ
         x5bQ==
X-Gm-Message-State: AO0yUKVgL/oMjY1skLnVDzyd4fReh5L8c1C9ViQZ5BQUExbnsYjoXwDu
        QPfjmiCAEql7re82rsiAGGZqX3GSIho=
X-Google-Smtp-Source: AK7set9O2GpYPDLT40yz2SB2SaEiZpzObCbQ9+tFBfgjlWfrWPVTmR9CFwKzFVQWnY0zuICmRa3hOw==
X-Received: by 2002:a17:903:1111:b0:19f:67b1:67e with SMTP id n17-20020a170903111100b0019f67b1067emr841629plh.49.1679439865749;
        Tue, 21 Mar 2023 16:04:25 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:7b5b:78a7:738b:7b20? ([2620:10d:c090:500::7:e86])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902a9c400b0019f3da8c2a4sm9229302plr.69.2023.03.21.16.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 16:04:25 -0700 (PDT)
Message-ID: <aa8b4ae3-9ea7-43cd-db57-4bd84f89ca96@gmail.com>
Date:   Tue, 21 Mar 2023 16:04:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next v9 5/8] bpf: Update the struct_ops of a bpf_link.
Content-Language: en-US, en-ZW
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
References: <20230320195644.1953096-1-kuifeng@meta.com>
 <20230320195644.1953096-6-kuifeng@meta.com>
 <9d370e0b-f57b-0a3e-9b1b-58930b0dfee1@linux.dev>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <9d370e0b-f57b-0a3e-9b1b-58930b0dfee1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/21/23 11:18, Martin KaFai Lau wrote:
> On 3/20/23 12:56 PM, Kui-Feng Lee wrote:
>> +static int bpf_struct_ops_map_link_update(struct bpf_link *link, 
>> struct bpf_map *new_map,
>> +                      struct bpf_map *expected_old_map)
>> +{
>> +    struct bpf_struct_ops_map *st_map, *old_st_map;
>> +    struct bpf_map *old_map;
>> +    struct bpf_struct_ops_link *st_link;
>> +    int err = 0;
>> +
>> +    st_link = container_of(link, struct bpf_struct_ops_link, link);
>> +    st_map = container_of(new_map, struct bpf_struct_ops_map, map);
>> +
>> +    if (!bpf_struct_ops_valid_to_reg(new_map))
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&update_mutex);
>> +
>> +    old_map = rcu_dereference_protected(st_link->map, 
>> lockdep_is_held(&update_mutex));
>> +    if (expected_old_map && old_map != expected_old_map) {
>> +        err = -EINVAL;
>> +        goto err_out;
>> +    }
>> +
>> +    old_st_map = container_of(old_map, struct bpf_struct_ops_map, map);
>> +    /* The new and old struct_ops must be the same type. */
>> +    if (st_map->st_ops != old_st_map->st_ops) {
>> +        err = -EINVAL;
> 
> Other ".update_prog" implementation returns -EPERM. eg. take a look at 
> cgroup_bpf_replace().

Discussed offline.  For consistency, it will return -EPERM.

> 
>> +        goto err_out;
>> +    }
>> +
>> +    err = st_map->st_ops->update(st_map->kvalue.data, 
>> old_st_map->kvalue.data);
>> +    if (err)
>> +        goto err_out;
>> +
>> +    bpf_map_inc(new_map);
>> +    rcu_assign_pointer(st_link->map, new_map);
>> +    bpf_map_put(old_map);
>> +
>> +err_out:
>> +    mutex_unlock(&update_mutex);
>> +
>> +    return err;
>> +}
>> +
> 
> 
