Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F844D4AD
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 11:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhKKKI6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 05:08:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232318AbhKKKI5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 05:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636625168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jl6i9Vg5MH/D47qfgpp1++mvVXS5mXYZyKefeF00ENM=;
        b=BYT7gpKl0ciEu7JZa8s2Gad2/zns9UCqsAF/DiwrKTa3Gc5aRZNuxMChC1N8AipDeVFmdG
        G3wmCrZ8Raa8rJTuPGsNjmBK9YtIoB2aytkPDV5jm48IWAK8+dUafYoXkaFTyvufdp5EOk
        GzGi1gAyTDozdR6UFTHpmLO15n/54F0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-otNR3CnWMUu86DN8nACWYA-1; Thu, 11 Nov 2021 05:06:07 -0500
X-MC-Unique: otNR3CnWMUu86DN8nACWYA-1
Received: by mail-wr1-f69.google.com with SMTP id w14-20020adfbace000000b001884bf6e902so931209wrg.3
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 02:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=jl6i9Vg5MH/D47qfgpp1++mvVXS5mXYZyKefeF00ENM=;
        b=PKyyCDAW8suXLI4GeFMBaPFvpRk4+r85mqkaXrA3pc80JGHvzHs09htK9icr2Uc3Jd
         lvC+u1BBPtFe5nNXJiTvcOvDIg6sERTriGSH+S/y3gVaU8uTPK7FggbBzAfZtm6Zfwd9
         Ci+tEubLXTHuCL4I2IBltOQZEW3oCfkFoiKG5a57ZUm5uPOWkN4BPCodWVbualtBbPak
         Qlyglfopu3HpI6b96PzIe8wKLvGvA/4PSpvZQSRwQ7kIH/4RM8tbONnancrkIkICLF0A
         HHvnMpHLPprkpa+fx/yShAfGPLNHRkMIvZnu73G2btB2klc37RMTFCT9x75dKsrkHXkY
         uUfw==
X-Gm-Message-State: AOAM530/9MoDP2Sq/oMpMzspgO26ZonBNuVnqI1Muvyc91nJsCs+ed5Q
        E+CUxY9rGPdGgmYu8kBsi4QMdUR4iHfxe7Cu3T6FUzznHsiOsAhzns0VWjGnPKoxb200m4gfy0c
        LwHFUtjpOoauG
X-Received: by 2002:adf:ef52:: with SMTP id c18mr7576525wrp.162.1636625166582;
        Thu, 11 Nov 2021 02:06:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsepfx71+Xyqb2g2FyILt7HhfvGVM2Y27qZ2ME6eL9iigsTPlV6uU5mw6Ulj3j6sBKopzmZQ==
X-Received: by 2002:adf:ef52:: with SMTP id c18mr7576497wrp.162.1636625166404;
        Thu, 11 Nov 2021 02:06:06 -0800 (PST)
Received: from [192.168.3.132] (p4ff23ee8.dip0.t-ipconnect.de. [79.242.62.232])
        by smtp.gmail.com with ESMTPSA id l15sm2324926wme.47.2021.11.11.02.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 02:06:05 -0800 (PST)
Message-ID: <b495d38d-5cdd-8a33-b9d3-de721095ccab@redhat.com>
Date:   Thu, 11 Nov 2021 11:06:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/7] fs/binfmt_elf: use get_task_comm instead of
 open-coded string copy
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        oliver.sang@intel.com, lkp@intel.com,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>
References: <20211108083840.4627-1-laoar.shao@gmail.com>
 <20211108083840.4627-5-laoar.shao@gmail.com>
 <a13c0541-59a3-6561-6d42-b51fef9f7c8b@redhat.com>
Organization: Red Hat
In-Reply-To: <a13c0541-59a3-6561-6d42-b51fef9f7c8b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11.11.21 11:03, David Hildenbrand wrote:
> On 08.11.21 09:38, Yafang Shao wrote:
>> It is better to use get_task_comm() instead of the open coded string
>> copy as we do in other places.
>>
>> struct elf_prpsinfo is used to dump the task information in userspace
>> coredump or kernel vmcore. Below is the verfication of vmcore,
>>
>> crash> ps
>>    PID    PPID  CPU       TASK        ST  %MEM     VSZ    RSS  COMM
>>       0      0   0  ffffffff9d21a940  RU   0.0       0      0  [swapper/0]
>>>     0      0   1  ffffa09e40f85e80  RU   0.0       0      0  [swapper/1]
>>>     0      0   2  ffffa09e40f81f80  RU   0.0       0      0  [swapper/2]
>>>     0      0   3  ffffa09e40f83f00  RU   0.0       0      0  [swapper/3]
>>>     0      0   4  ffffa09e40f80000  RU   0.0       0      0  [swapper/4]
>>>     0      0   5  ffffa09e40f89f80  RU   0.0       0      0  [swapper/5]
>>       0      0   6  ffffa09e40f8bf00  RU   0.0       0      0  [swapper/6]
>>>     0      0   7  ffffa09e40f88000  RU   0.0       0      0  [swapper/7]
>>>     0      0   8  ffffa09e40f8de80  RU   0.0       0      0  [swapper/8]
>>>     0      0   9  ffffa09e40f95e80  RU   0.0       0      0  [swapper/9]
>>>     0      0  10  ffffa09e40f91f80  RU   0.0       0      0  [swapper/10]
>>>     0      0  11  ffffa09e40f93f00  RU   0.0       0      0  [swapper/11]
>>>     0      0  12  ffffa09e40f90000  RU   0.0       0      0  [swapper/12]
>>>     0      0  13  ffffa09e40f9bf00  RU   0.0       0      0  [swapper/13]
>>>     0      0  14  ffffa09e40f98000  RU   0.0       0      0  [swapper/14]
>>>     0      0  15  ffffa09e40f9de80  RU   0.0       0      0  [swapper/15]
>>
>> It works well as expected.
>>
>> Suggested-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>> Cc: Michal Miroslaw <mirq-linux@rere.qmqm.pl>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Petr Mladek <pmladek@suse.com>
>> ---
>>  fs/binfmt_elf.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index a813b70f594e..138956fd4a88 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
>> @@ -1572,7 +1572,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
>>  	SET_UID(psinfo->pr_uid, from_kuid_munged(cred->user_ns, cred->uid));
>>  	SET_GID(psinfo->pr_gid, from_kgid_munged(cred->user_ns, cred->gid));
>>  	rcu_read_unlock();
>> -	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
>> +	get_task_comm(psinfo->pr_fname, p);
>>  
>>  	return 0;
>>  }
>>
> 
> We have a hard-coded "pr_fname[16]" as well, not sure if we want to
> adjust that to use TASK_COMM_LEN?

But if the intention is to chance TASK_COMM_LEN later, we might want to
keep that unchanged.

(replacing the 16 by a define might still be a good idea, similar to how
it's done for ELF_PRARGSZ, but just a thought)


-- 
Thanks,

David / dhildenb

