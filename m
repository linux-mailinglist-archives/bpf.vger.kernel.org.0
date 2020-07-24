Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D20C22C967
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 17:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgGXPoy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 11:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgGXPoy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jul 2020 11:44:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E153DC0619E5
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2020 08:44:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so8719255wrs.11
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2020 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RUZyK2oU0Kd8idZ8Q9ejhsbuyqiNW01xj/ZfwiLfu3Y=;
        b=EMQ5KBE6Jkx1Hq9yV6Usrjv1X6tWqxTG5U4bGAqMz5nnH1eJV7PnEDH1UUbsjhyWtQ
         Ebi+meVf5qoPU4QZk7oL6cGBtNEaoRQ1hiwseEtqXClbDNh0xXkZ8/WBuBYBrEuUuNYa
         tjAAAyqwBFcxnkr/RXqFfirta526U71ZFXceU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RUZyK2oU0Kd8idZ8Q9ejhsbuyqiNW01xj/ZfwiLfu3Y=;
        b=AmSbfKJNAsZ5/QvIUyz+8T8uvBYsjjmrPhr+4rkURBZWuqKPlUN9D+v5CvrfA66//z
         dXxD9wXxloous1DG9THfkecf8HvyEOT0u5QSG+jr6nYzMX/FD8ngV+AC9a78uVIT6C6e
         bD5kQwSh6Zm1ZQbdhT/XXbrAkq+rSHSgcTXe0Nc+ozdSC3Ob3uakcPWIVsLFDi/3YZU+
         WNMcF3Ggov7WZI34fFMLmwgrI3/j+4jlwbmu5DEvN1EfdBT7QAExtoEHeBdjsp73I6Ve
         UX9DU0NifZ2XgFYNGye37GZg/qt0bfUgfwFCQhmiA7d/i8KEUrsGa3+XWCP2KFj9iBZB
         qBNQ==
X-Gm-Message-State: AOAM530aauXGQm83rndeE7nE79q98HWsxYKh9kEWuhHB6FpS1KEgRxaA
        hYneAuxAvtEuaAzQXmznW6LaJg==
X-Google-Smtp-Source: ABdhPJyubYtzFJZJ4vI6f7H318py/PzhqfA5Udew1hMnX9MephVhzKdADMZaKj+rNVL+WACQP/X9hA==
X-Received: by 2002:a5d:4109:: with SMTP id l9mr9312784wrp.398.1595605492515;
        Fri, 24 Jul 2020 08:44:52 -0700 (PDT)
Received: from kpsingh-macbookpro2.roam.corp.google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id c25sm7782316wml.18.2020.07.24.08.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 08:44:52 -0700 (PDT)
Subject: Re: [PATCH bpf-next v6 1/7] bpf: Renames to prepare for generalizing
 sk_storage.
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
References: <20200723115032.460770-1-kpsingh@chromium.org>
 <20200723115032.460770-2-kpsingh@chromium.org>
 <20200724053135.itp5qrqaplbyzxxw@kafai-mbp>
From:   KP Singh <kpsingh@chromium.org>
Message-ID: <9e421c6e-14a2-f0a7-1260-0debfbbf9308@chromium.org>
Date:   Fri, 24 Jul 2020 17:44:51 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724053135.itp5qrqaplbyzxxw@kafai-mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 24.07.20 07:31, Martin KaFai Lau wrote:
> On Thu, Jul 23, 2020 at 01:50:26PM +0200, KP Singh wrote:
>> From: KP Singh <kpsingh@google.com>
>>
>> A purely mechanical change to split the renaming from the actual
>> generalization.
>>
>> Flags/consts:
>>
>>   SK_STORAGE_CREATE_FLAG_MASK	BPF_LOCAL_STORAGE_CREATE_FLAG_MASK
>>   BPF_SK_STORAGE_CACHE_SIZE	BPF_LOCAL_STORAGE_CACHE_SIZE
>>   MAX_VALUE_SIZE		BPF_LOCAL_STORAGE_MAX_VALUE_SIZE
>>
>> Structs:
>>
>>   bucket			bpf_local_storage_map_bucket
>>   bpf_sk_storage_map		bpf_local_storage_map
>>   bpf_sk_storage_data		bpf_local_storage_data
>>   bpf_sk_storage_elem		bpf_local_storage_elem
>>   bpf_sk_storage		bpf_local_storage
>>   selem_linked_to_sk		selem_linked_to_storage
>>   selem_alloc			bpf_selem_alloc
>>
>> The "sk" member in bpf_local_storage is also updated to "owner"
>> in preparation for changing the type to void * in a subsequent patch.
>>
>> Functions:
>>
>>   __selem_unlink_sk			bpf_selem_unlink_storage
>>   __selem_link_sk			bpf_selem_link_storage
>>   selem_unlink_sk			__bpf_selem_unlink_storage
>>   sk_storage_update			bpf_local_storage_update
>>   __sk_storage_lookup			bpf_local_storage_lookup
>>   bpf_sk_storage_map_free		bpf_local_storage_map_free
>>   bpf_sk_storage_map_alloc		bpf_local_storage_map_alloc
>>   bpf_sk_storage_map_alloc_check	bpf_local_storage_map_alloc_check
>>   bpf_sk_storage_map_check_btf		bpf_local_storage_map_check_btf
> Thanks for separating this mechanical name change in a separate patch.
> It is much easier to follow.  This patch looks good.
> 
> A minor thought is, when I look at unlink_map() and unlink_storage(),
> it keeps me looking back for the lock situation.  I think
> the main reason is the bpf_selem_unlink_map() is locked but
> bpf_selem_unlink_storage() is unlocked now.  May be:
> 
> bpf_selem_unlink_map()		=> bpf_selem_unlink_map_locked()
> bpf_selem_link_map()		=> bpf_selem_link_map_locked()
> __bpf_selem_unlink_storage() 	=> bpf_selem_unlink_storage_locked()
> bpf_link_storage() means unlocked
> bpf_unlink_storage() means unlocked.
> 
> I think it could be one follow-up patch later instead of interrupting
> multiple patches in this set for this minor thing.  For now, lets
> continue with this and remember default is nolock for storage.
> 

Makes sense. I can update these in a separate patch if there are no
major changes needed in this one.

> I will continue tomorrow.

Awesome! Thanks :)

- KP

> 
