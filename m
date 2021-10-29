Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36E643FF4D
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 17:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhJ2PUO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 11:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJ2PUO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Oct 2021 11:20:14 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3FEC061570;
        Fri, 29 Oct 2021 08:17:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id v193so9533078pfc.4;
        Fri, 29 Oct 2021 08:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vegS3sUKUhI4LTqdf1vmY5PuKsxIFyPk9X+XdyTTR30=;
        b=NiCS6JfInlfspOZjmAZC7As+qpH/lP4Hi6xKlazp7dwuEXxrrvnvyKjUHxDnxd4URR
         g90vl2XwlwpRA6DiLzWFX9jvDiK9yMjgjPjjkabut9nIeoM7z6kY82AO5X5fhW2skFRs
         q04EdyGJEDkaIt4PcrIiSELCAZccQ+wqFsLagtHv4qXA/ka8wMO0gWrp2eAa5x5abd2B
         jyG2shwRdbsM7NseIxk7zamEIL5RHw09zphMCQUb3Q5LqQBJWSFO8xJXU4KnSnSH2oaO
         7IfOZD5nt39p5v4hTunmUe7h3aw891j6Mq2r/BKLL0V8U7JepJm4k58WQ2N5VKCo4J8W
         VXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vegS3sUKUhI4LTqdf1vmY5PuKsxIFyPk9X+XdyTTR30=;
        b=AK0rnlQfVHiYdhUQvogu7c1ZkvLEN2i1XQBVsRSBc8PmQAQg6SN2LcAETjVu8KlYVK
         G2BLpuzoFYXVsp3/qxl3AOQz21bFCsR+tN+HZ2SfcWBfUrM3vUDGfeMG6ZdCq/n1qwsZ
         LhqT8hPYNIVGIoIwG1wpa2xKv23xHg4QJFmf/Hx3gZelhBBV3OuQexCmayj9W2tcykLb
         edbkTxiYC+cC2sCzD6hIAQ9e2cG3PUj7yr1nsAviIi20WGdiLxDkf60HxBSZ6+bvTToH
         p1t0sv1HqTSgrmzbioX1AElbP4RzfjDL5aQVdhAIjRBvv+uq8zIuoeb3/iOD/BM6y40l
         NyIA==
X-Gm-Message-State: AOAM532Kv2H9NQijZGm1rUZX7mlsIjLrz47Wo5pvDKqJFN1b9mtTBnAP
        swNs3jf2R9enY57MueDfVmV+Bsz7FStPUQ==
X-Google-Smtp-Source: ABdhPJxaTQNUfcpkGprFQcnMx+1zSK5EZ9g3G5DdqUXmLcZNS9s9Md1Wq8AmC1xdfvo3pZ+NhDlekg==
X-Received: by 2002:a05:6a00:14cb:b0:47f:bf22:329e with SMTP id w11-20020a056a0014cb00b0047fbf22329emr530241pfu.58.1635520665085;
        Fri, 29 Oct 2021 08:17:45 -0700 (PDT)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id m7sm6013660pgn.32.2021.10.29.08.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 08:17:44 -0700 (PDT)
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_d_path in perf_event_mmap
To:     Martin KaFai Lau <kafai@fb.com>,
        Florent Revest <revest@chromium.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org
References: <20211028164357.1439102-1-revest@chromium.org>
 <20211028224653.qhuwkp75fridkzpw@kafai-mbp.dhcp.thefacebook.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <10a745cc-5942-70ff-483f-a5c77a9776a2@gmail.com>
Date:   Fri, 29 Oct 2021 23:17:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028224653.qhuwkp75fridkzpw@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/29/21 6:46 AM, Martin KaFai Lau wrote:
> On Thu, Oct 28, 2021 at 06:43:57PM +0200, Florent Revest wrote:
>> Allow the helper to be called from the perf_event_mmap hook. This is
>> convenient to lookup vma->vm_file and implement a similar logic as
>> perf_event_mmap_event in BPF.
> From struct vm_area_struct:
> 	struct file * vm_file;          /* File we map to (can be NULL). */
> 
> Under perf_event_mmap, vm_file won't be NULL or bpf_d_path can handle it?
> 

Hmm, is perf_event_mmap a proper tracing target ?
It does not appear in /sys/kernel/debug/tracing/available_filter_functions.

I tried using kprobe/fentry to attach to it, both failed.

>>
>> Signed-off-by: Florent Revest <revest@chromium.org>
>> ---
>>  kernel/trace/bpf_trace.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index cbcd0d6fca7c..f6e301c775a5 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -922,6 +922,9 @@ BTF_ID(func, vfs_fallocate)
>>  BTF_ID(func, dentry_open)
>>  BTF_ID(func, vfs_getattr)
>>  BTF_ID(func, filp_close)
>> +#ifdef CONFIG_PERF_EVENTS
>> +BTF_ID(func, perf_event_mmap)
>> +#endif
>>  BTF_SET_END(btf_allowlist_d_path)
>>  
>>  static bool bpf_d_path_allowed(const struct bpf_prog *prog)
>> -- 
>> 2.33.0.1079.g6e70778dc9-goog
>>

--Hengqi
