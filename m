Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C514F44BCD7
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 09:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhKJIbG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 03:31:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33078 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229781AbhKJIbG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Nov 2021 03:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636532898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U3N/QwJx99Htv9Bvod8btoHFfpBRUV5/sWEz28i4RYo=;
        b=FsESyu9r1b/v48FiWdwordYEPGOp+otgPYa6y7o9y4EvfSmvA2VBK5+rN3C0v1/TOeu1AA
        P2POoRa0I+R+PL9oBuMmDxLhPE53TbqvDSTbAABXAoGO0BEYlMRzRuTg3ovb4mwr336+l+
        IQxjOzkBVddcCUJ+YwBv7Ds3XY/iJkE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-yekMIrm5MLa70w4zDUndeQ-1; Wed, 10 Nov 2021 03:28:17 -0500
X-MC-Unique: yekMIrm5MLa70w4zDUndeQ-1
Received: by mail-wr1-f72.google.com with SMTP id y4-20020adfd084000000b00186b16950f3so230855wrh.14
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 00:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=U3N/QwJx99Htv9Bvod8btoHFfpBRUV5/sWEz28i4RYo=;
        b=kNdys+o1d8K8FKO6uMYPOt44rrlfufywnH1tbEGKzHyr7Kumd2Y+KRJoYxEi0XuOpF
         jmJOisHwzbRm2ET9i1JQgL2NrgjrWbEuLGomlQxxE31hKxrwBRNUXM4YNNrHtoGJeSbT
         4Fpfog24eld027fC5VCZQlj1tMIUvrE2iHm0QaEVFKXJ/XLDVL3E76MIFxy4bFiQSjnU
         QsHKljIS1CRi2yXg671WTrTWoh8EA/hYxFN/UFtDkNCx69buBUyF5qwuHnulAeBYF15c
         lEOLBywgH7cEpC4P5QEDN3c2HIeOMNm9OhF4h5p3bt9QJkQMAjbESd5vBPIBIDcIeg3N
         xw0w==
X-Gm-Message-State: AOAM533WObfohki6Boo5iyZZbDUSpNKsq+5/Ad7ly27MXABk1Z9B8q2k
        RFh9cIIc1RzjhjjHvvrVtDRNHjlr11FlYFPRRqlpWnPzsLABGE74zuLg50uX3sR+8XikxYRuFwz
        PQcL77Kp/zzX9
X-Received: by 2002:adf:ba0d:: with SMTP id o13mr17628079wrg.339.1636532896089;
        Wed, 10 Nov 2021 00:28:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQ/2kqjTXPkYPHvyddhqvtTW4vWEhMZpSvnii4YyiM1CY6/ErutfetxXoUCqfLbvvZpl1HaA==
X-Received: by 2002:adf:ba0d:: with SMTP id o13mr17628047wrg.339.1636532895920;
        Wed, 10 Nov 2021 00:28:15 -0800 (PST)
Received: from [192.168.3.132] (p5b0c604f.dip0.t-ipconnect.de. [91.12.96.79])
        by smtp.gmail.com with ESMTPSA id u23sm15854437wru.21.2021.11.10.00.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 00:28:14 -0800 (PST)
Message-ID: <c3571571-320a-3e25-8409-5653ddca895c@redhat.com>
Date:   Wed, 10 Nov 2021 09:28:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/7] fs/exec: make __set_task_comm always set a nul
 terminated string
Content-Language: en-US
To:     Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        oliver.sang@intel.com, lkp@intel.com,
        Kees Cook <keescook@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>
References: <20211108083840.4627-1-laoar.shao@gmail.com>
 <20211108083840.4627-2-laoar.shao@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211108083840.4627-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08.11.21 09:38, Yafang Shao wrote:
> Make sure the string set to task comm is always nul terminated.
> 

strlcpy: "the result is always a valid NUL-terminated string that fits
in the buffer"

The only difference seems to be that strscpy_pad() pads the remainder
with zeroes.

Is this description correct and I am missing something important?

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Michal Miroslaw <mirq-linux@rere.qmqm.pl> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  fs/exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index a098c133d8d7..404156b5b314 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1224,7 +1224,7 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
>  {
>  	task_lock(tsk);
>  	trace_task_rename(tsk, buf);
> -	strlcpy(tsk->comm, buf, sizeof(tsk->comm));
> +	strscpy_pad(tsk->comm, buf, sizeof(tsk->comm));
>  	task_unlock(tsk);
>  	perf_event_comm(tsk, exec);
>  }
> 


-- 
Thanks,

David / dhildenb

