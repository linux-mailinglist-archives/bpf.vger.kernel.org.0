Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7352F639FF7
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 04:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiK1DH7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Nov 2022 22:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiK1DH6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Nov 2022 22:07:58 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2E46304
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 19:07:57 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 4so8932153pli.0
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 19:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9/JLUoAhNH/BkXaA5edxF5ynZw/2ofy+OyqQkQUM5c=;
        b=dqkOP3s0s0wMY9vNKSiz20HPp7863f+9uzO3NsTJCS5DYTOEzrkCWfUeSG2OZ7NEj+
         F1Dxr2oGxw7QNQ0ACilTuwcDwscTg9XFEnOUtFEcwA3xQxFoTDHcflO5fmG3/dQ4SttX
         ct3dpUAXZjpNrSvysJT/3kdQD5/L1i6R/JQcItXbgZcys2SDegLZuRq819PqaOrrMuSI
         V0VmTN3Ei79jEtKLYgwbe8EbrcWLpyekq3Qk/Rj1evkvpm6OVdAUyNyvJsN0qBUB3yfJ
         V5tXedAA66RNz0AlJhZQb0gbTF26/qzuhLM4cLZi3sLAFANYKB/z3p9oS6/W1w/VXmgw
         nNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9/JLUoAhNH/BkXaA5edxF5ynZw/2ofy+OyqQkQUM5c=;
        b=mtJNy4ij8YGKcS6SUbR7rLWCHLB7/F0G1rupXJ0dNsl15sILmVJIEJzhUd4hexcEMS
         MWl4Pebk5dmTy0Jnt8QeKcxFUbslcXOpxQhywuIJbtKMqidfEL0/ZIS0o4PQVk5GYket
         oSNcZ5r7y0hGbcqaFEUatTHsnPzyvjrCP9vophIGWamo3Wb1VgP1gK6+DpDUzfWtackX
         12H5s0RC+URhVApZd2XOfIFMUDgK06kuK3ri3OU3P0pFq9HndhPhfbmCBLWWhyuz55GG
         KQYsrxABMSfdblJ9jFSlenxRZtjRn+vbYroATee2h7QtjpDdAcHN+3oSEvVQ3gYFEDHf
         MEJQ==
X-Gm-Message-State: ANoB5pnb0i340gzIZxnOEQ00r2zDq6JEZLBdqvaaEYRd9rM2TFO+5rz8
        8fofPxjsQQdZpsWoWXePy+4=
X-Google-Smtp-Source: AA0mqf6dzDBBYnTEF4g6wFwMgYHgif0PeRa/TIkiQHU3Om04m4HjrEERcGzzilKUv1pGYzxSscSomA==
X-Received: by 2002:a17:90a:ea8f:b0:219:2e8c:d1d0 with SMTP id h15-20020a17090aea8f00b002192e8cd1d0mr5050834pjz.57.1669604877334;
        Sun, 27 Nov 2022 19:07:57 -0800 (PST)
Received: from [192.168.255.10] ([43.132.98.43])
        by smtp.gmail.com with ESMTPSA id a194-20020a621acb000000b00565b259a52asm6842129pfa.1.2022.11.27.19.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 19:07:57 -0800 (PST)
Message-ID: <f6d20c9c-a411-92aa-798a-27e1bc341b1a@gmail.com>
Date:   Mon, 28 Nov 2022 11:07:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH bpf 1/2] bpf: Check timer_off for map_in_map only when map
 value have timer
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <20221126105351.2578782-1-hengqi.chen@gmail.com>
 <20221126105351.2578782-2-hengqi.chen@gmail.com>
 <CAADnVQJ8B0oDss95P+qfQx7r0Xr8RmY-_9dAincqESzyD+ZG+w@mail.gmail.com>
 <94b5a28c-56dd-74a1-e4f5-5b5c2ffeca2a@gmail.com>
 <CAADnVQJRjW+nWtj5Kd6pHCyjKkRnjLiMSG22vXBPCp41UbASag@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <CAADnVQJRjW+nWtj5Kd6pHCyjKkRnjLiMSG22vXBPCp41UbASag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 2022/11/28 10:49, Alexei Starovoitov wrote:
> On Sun, Nov 27, 2022 at 6:42 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Hi, Alexei:
>>
>> On 2022/11/28 08:44, Alexei Starovoitov wrote:
>>> On Sat, Nov 26, 2022 at 2:54 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>>>
>>>> The timer_off value could be -EINVAL or -ENOENT when map value of
>>>> inner map is struct and contains no bpf_timer. The EINVAL case happens
>>>> when the map is created without BTF key/value info, map->timer_off
>>>> is set to -EINVAL in map_create(). The ENOENT case happens when
>>>> the map is created with BTF key/value info (e.g. from BPF skeleton),
>>>> map->timer_off is set to -ENOENT as what btf_find_timer() returns.
>>>> In bpf_map_meta_equal(), we expect timer_off to be equal even if
>>>> map value does not contains bpf_timer. This rejects map_in_map created
>>>> with BTF key/value info to be updated using inner map without BTF
>>>> key/value info in case inner map value is struct. This commit lifts
>>>> such restriction.
>>>
>>> Sorry, but I prefer to label this issue as 'wont-fix'.
>>> Mixing BTF enabled and non-BTF inner maps is a corner case
>>
>> We do have such usecase. The BPF progs and maps are pinned to bpffs
>> using BPF object file. And the map_in_map is updated by some other
>> process which don't have access to such BTF info.
>>
>>> that is not worth fixing.
>>
>> Is there a way to get this fixed for v5.x series only ?
>>
>>> At some point we will require all programs and maps to contain BTF.
>>> It's necessary for introspection.
>>
>> We don't care much about BTF for introspection. In production, we always
>> have a version field and some reserved fields in the map value for backward
>> compatibility. The interpretation of such map values are left to upper layer.
> 
> That "interpretation of such map values are left to upper layer"...
> is exactly the reason why we will enforce BTF in the future.
> Production engineers and people outside of "upper layer" sw team
> has to be able to debug maps and progs.

Fine.

In libbpf, we have:

  if (is_inner) {
  	pr_warn("map '%s': inner def can't be pinned.\n", map_name);
  	return -EINVAL;
  }


Can we lift this restriction so that we can have an easy way to access BTF info
via pinned map ?
