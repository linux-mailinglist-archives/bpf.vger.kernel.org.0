Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6866844D496
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 11:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhKKKE0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 05:04:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232705AbhKKKEZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 05:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636624896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNcPNFwkNZzPAAuuM2VldGNI2vkzqJbh7gXLQwgsqaU=;
        b=bFTsg27RyE/7HLS40f8LKVx6Zzs0DWZEwrABN/4SocG0hj+xt06I42uf/8u8JRtOlCkmf9
        HNoDCYt7XTse7LmKxUXEnyIPrH77f9/pxhIzFqWAK2JKmwOuliJ+59TtV7aqzxjn3DvRpY
        G8HjBzBfMiwtbvJoL7jjl8HhCC5/Deo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-MoH0nIbHOweT9MbDcRo9ow-1; Thu, 11 Nov 2021 05:01:35 -0500
X-MC-Unique: MoH0nIbHOweT9MbDcRo9ow-1
Received: by mail-wr1-f70.google.com with SMTP id h13-20020adfa4cd000000b001883fd029e8so925725wrb.11
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 02:01:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=CNcPNFwkNZzPAAuuM2VldGNI2vkzqJbh7gXLQwgsqaU=;
        b=y5IBjq0xpwF5ovdVJ/Up49xRBFIpSeENG57xziTUR2WzBakphHbUgI5LH6M2d6E6jd
         McJLYvaPgUmvFgCfdlT6wtscVprEkKzsreg1wz+Rq6I3moHCnwTzvW3R0zWmB0KY19/b
         XYXYtx0p0nIx3hWY3zjsbdF7XAGooClLPMWAcLla3A4k/LbFt3UQzaYNyMBKRWKQ6ZtT
         05VuRI2HEg5Mnt+5sBpo/C7iHzAgVJvljsjohzlqkc/x+45k1T9z+I5OmADJQ+EPuJ7P
         1r+SorIHydBPHYQHxtkbdt3ILxwxvkKywqGuhDiF0iluHjrviVq0sgM9OcW2JmlAB7dh
         bz9Q==
X-Gm-Message-State: AOAM530crtkhsXv7YUYMIut/rr5Lzek8NwBqPSIXm9TaOkZ+rzH2InSo
        JHnFkBO+y/k+l3ZMqHXp5dfHjuXe1KsK5ufD8OclB+nGWZBn4Y/JBVvRsS1mxA3uW7XtdWaTzTb
        Ti5jRN5yVk3J9
X-Received: by 2002:a1c:f601:: with SMTP id w1mr24132442wmc.112.1636624894481;
        Thu, 11 Nov 2021 02:01:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+YnB30s3H7o5szg4rvm692l/bAna1bgr0sO3KWz/TpfPh1f2WsLYXFlxrtbeUq96NmLkNQw==
X-Received: by 2002:a1c:f601:: with SMTP id w1mr24132395wmc.112.1636624894177;
        Thu, 11 Nov 2021 02:01:34 -0800 (PST)
Received: from [192.168.3.132] (p4ff23ee8.dip0.t-ipconnect.de. [79.242.62.232])
        by smtp.gmail.com with ESMTPSA id a22sm2227713wme.19.2021.11.11.02.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 02:01:33 -0800 (PST)
Message-ID: <794ecf14-a25e-8222-9f9c-7a77796fff6d@redhat.com>
Date:   Thu, 11 Nov 2021 11:01:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/7] drivers/infiniband: use get_task_comm instead of
 open-coded string copy
Content-Language: en-US
To:     Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        oliver.sang@intel.com, lkp@intel.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>
References: <20211108083840.4627-1-laoar.shao@gmail.com>
 <20211108083840.4627-4-laoar.shao@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211108083840.4627-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08.11.21 09:38, Yafang Shao wrote:
> Use get_task_comm() instead of open-coded strlcpy() to make the comm always
> nul terminated. As the comment above the hard-coded 16, we can replace it
> with TASK_COMM_LEN, then it will adopt to the comm size change.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
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

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

