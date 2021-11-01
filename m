Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8AC441B96
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 14:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhKANUU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 09:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhKANUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 09:20:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1347C061714;
        Mon,  1 Nov 2021 06:17:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g11so4941286pfv.7;
        Mon, 01 Nov 2021 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ElXLGUufMIfi7saztQ05KyMJtRkBVmLZk3K8RMUcE/g=;
        b=pbWrcOS/E/Gkv13GNp//Zd/onyhqaNcNq2Rdu9GxPxMXEDnfiBU933SbOH0wbi0FJC
         obvfAJ/lnAXDu938R6NR9nSq2GaJpxSmgiSW48lj5dE/iknMmNjPY7afACSmTivHY6NS
         y03ZdwmxJmriBiBTtPYs9SVLnMg1Ho7E4e5DESub/+DGM8HwLFFo9tff2ENNEKE+ae+G
         0zU4uHj/N4RTMuV7Fg5ejyKTvLwtcBIarPnAHOTH5CGgCJL/O8KtCf/3baCwl6E/H3wQ
         wbxN1xEHKnirwvrIiL94fxx/ULwhEJwO/fGj2u4aPwtmVpoSSg4piz4zOTfHbIEiwv/4
         6Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ElXLGUufMIfi7saztQ05KyMJtRkBVmLZk3K8RMUcE/g=;
        b=cx6kKTjNk/ihbNjt8w/uk/n16/EpvLFRbcJToKfPjoG/jaj3lVmglYlfApSJIVxNF5
         KAqtLij9B3R5OZ24Ec1PEUsGiJc8w91d6unUInjenov+0K8cXc2dk5DZYFXJ0gHKtOIl
         4sx0gb0Um4TBQOz5YAoDRVQpd8pIWVi5ECWRDRM8aN+R0bRKRzJsJszO6kLBjH5nk3nm
         MI/OpEHJEJbqbP5vnMuNF2SfKXr7uBS1g1/L2fUd6obgl+M9N/jo5h+ujNKD5qyEzp4p
         rvEKyaqRw1r6GyIUqA/cStQuz4F+K4NrS20RHR6qWVcQzLi4daKWyy+TvfKKN5oOXHtV
         8V5Q==
X-Gm-Message-State: AOAM530359Hn1uL8hA4ucQwcaVx4u2asOn0jWgWiTYkVyg1AKZ//vTBC
        dlOyYXUnNLWLZXMZIlWcW8A=
X-Google-Smtp-Source: ABdhPJxZtOo8xG7N0PRsh2O8ZZhFc5wI/xd3rxFZqqMP3xc3A++hez5iW7ovtZl1hKAhrmG1ZwjX5A==
X-Received: by 2002:aa7:90d0:0:b0:44d:b8a:8837 with SMTP id k16-20020aa790d0000000b0044d0b8a8837mr28905418pfk.47.1635772666050;
        Mon, 01 Nov 2021 06:17:46 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.115])
        by smtp.gmail.com with ESMTPSA id q18sm16897419pfj.46.2021.11.01.06.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 06:17:45 -0700 (PDT)
Message-ID: <204584e8-7817-f445-1e73-b23552f54c2f@gmail.com>
Date:   Mon, 1 Nov 2021 21:17:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_d_path in perf_event_mmap
Content-Language: en-US
To:     Florent Revest <revest@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org
References: <20211028164357.1439102-1-revest@chromium.org>
 <20211028224653.qhuwkp75fridkzpw@kafai-mbp.dhcp.thefacebook.com>
 <CABRcYmLWAp6kYJBA2g+DvNQcg-5NaAz7u51ucBMPfW0dGykZAg@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <CABRcYmLWAp6kYJBA2g+DvNQcg-5NaAz7u51ucBMPfW0dGykZAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,


On 2021/10/30 1:02 AM, Florent Revest wrote:
> On Fri, Oct 29, 2021 at 12:47 AM Martin KaFai Lau <kafai@fb.com> wrote:
>>
>> On Thu, Oct 28, 2021 at 06:43:57PM +0200, Florent Revest wrote:
>>> Allow the helper to be called from the perf_event_mmap hook. This is
>>> convenient to lookup vma->vm_file and implement a similar logic as
>>> perf_event_mmap_event in BPF.
>> From struct vm_area_struct:
>>         struct file * vm_file;          /* File we map to (can be NULL). */
>>
>> Under perf_event_mmap, vm_file won't be NULL or bpf_d_path can handle it?
> 
> Thanks Martin, this is a very good point. :) Yes, vm_file can be NULL
> in perf_event_mmap.
> I wonder what would happen (and what we could do about it? :|).
> bpf_d_path is called on &vma->vm_file->f_path So without NULL checks
> (of vm_file) in BPF, the helper wouldn't be called with a NULL pointer
> but rather with an address that is offsetof(struct file, f_path).
> 

I tested this patch with the following BCC script:

    bpf_text = '''
    #include <linux/mm_types.h>

    KFUNC_PROBE(perf_event_mmap, struct vm_area_struct *vma)
    {
        char path[256] = {};

        bpf_d_path(&vma->vm_file->f_path, path, sizeof(path));
        bpf_trace_printk("perf_event_mmap %s", path);
        return 0;
    }
    '''

    b = BPF(text=bpf_text)
    print("BPF program loaded")
    b.trace_print()

This change causes kernel panic. I think it's because of this NULL pointer.
