Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67741442F49
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 14:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhKBNsF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 09:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhKBNsF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Nov 2021 09:48:05 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8B1C061714
        for <bpf@vger.kernel.org>; Tue,  2 Nov 2021 06:45:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id m21so20155045pgu.13
        for <bpf@vger.kernel.org>; Tue, 02 Nov 2021 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qJs9hXP+oNJvxWlmugHLdNhqo44d7nTmQo9yhPUmfdg=;
        b=mxYh+Geqo8gg5J5miJZV+McLnlOuwztCIn1UxevAZykmKJH+hqgbpApHFY9ubw+KJ1
         DGVHdZcgxdZXkX6cqNlAGRWxwTRJhWoVtNN4USFjPuqgp/RGlqJQemEvj8be7gxB7+iX
         HbrZuy3QQ8pjUS1o/vt1rQgqKJMXfB4r3D5F6rY7tbApq3PweVt3bdh49V82ooyMMd86
         lvdbqb1Zo8g/cUiFXNkGl4WDR5Idctc0l5QZp7ihOS4JgUlbOD7X43CysoxLgdZ5DPby
         zrYZYxA/EuWhpTmh028uXF7zOzWq7c+ZIbd4T9P1KeWRzxKcYmb/dCK5dI52G9oeldQB
         mEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qJs9hXP+oNJvxWlmugHLdNhqo44d7nTmQo9yhPUmfdg=;
        b=2GLgKvDF7cXdE3mccfLt8nLVKixzWUFAPfGrPMZb6seznQZhOM6fpsnA+lU7/cskWa
         kz0FdL3x1IdDxaSLVcL6rxqUeI7tO+9guFdn/WGUYGUlvTy8oZH3ZbVyKzGoZoRafmYI
         b89UBlFg7ClsNaeu5tuEZZq8Et1+zthxVUqLsh1RBsXSgPQq3t4K3kCeJNQmVUW5uFxA
         n4BJKVoDSxS1tKfF0SyPvRdEOxJ8G60VdPLAa4GfeXiIdBGUO9mtu/a9Rw+rNiSQK0fo
         7ZeXybo/fLq/4hMy8sj1xA72tKItlYfFiwdEgsdx2C6xSZ9mylcbDXpZENMPOcup8out
         0vOQ==
X-Gm-Message-State: AOAM5317SKQftdC6RBMycji4ucJm2yVbe6BqGkJN+95HcHZeajROgXue
        /7wggpeltuoalH9tOYm4UIQ=
X-Google-Smtp-Source: ABdhPJyB0Np5LpYUnx0lODJmDplnJPs+Xs6T7dJiyuig4Nbi97ygFkBtCNMficZ369zML7cm7H58oA==
X-Received: by 2002:a05:6a00:1915:b0:47e:4c36:e9af with SMTP id y21-20020a056a00191500b0047e4c36e9afmr35469731pfi.57.1635860729996;
        Tue, 02 Nov 2021 06:45:29 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.116])
        by smtp.gmail.com with ESMTPSA id p6sm7639613pfo.96.2021.11.02.06.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 06:45:29 -0700 (PDT)
Message-ID: <693d3227-2f34-df20-99aa-bb6a0852d187@gmail.com>
Date:   Tue, 2 Nov 2021 21:45:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next 1/2] bpf: Do not reject when the stack read size
 is different from the tracked scalar size
Content-Language: en-US
To:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Yonghong Song <yhs@fb.com>, Yonghong Song <yhs@gmail.com>
References: <20211102064528.315637-1-kafai@fb.com>
 <20211102064535.316018-1-kafai@fb.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
In-Reply-To: <20211102064535.316018-1-kafai@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Martin.

On 2021/11/2 2:45 PM, Martin KaFai Lau wrote:
> Below is a simplified case from a report in bcc [0]:
> r4 = 20
> *(u32 *)(r10 -4) = r4
> *(u32 *)(r10 -8) = r4  /* r4 state is tracked */
> r4 = *(u64 *)(r10 -8)  /* Read more than the tracked 32bit scalar.
> 			* verifier rejects as 'corrupted spill memory'.
> 			*/
> 
> After commit 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill"),
> the 8-byte aligned 32bit spill is also tracked by the verifier
> and the reg state is stored.
> 
> However, if 8 bytes are read from the stack instead of the tracked
> 4 byte scalar, the verifier currently rejects as "corrupted spill memory".
> 
> This patch fixes this case by allowing it to read but marks the reg as
> unknown.
> 
> Also note that, if the prog is trying to corrupt/leak an
> earlier spilled pointer by spilling another <8 bytes register on top,
> this has already been rejected in the check_stack_write_fixed_off().
> 
> [0]: https://github.com/iovisor/bcc/pull/3683
> 
> Fixes: 354e8f1970f8 ("bpf: Support <8-byte scalar spill and refill")
> Reported-by: Hengqi Chen <hengqi.chen@gmail.com>
> Reported-by: Yonghong Song <yhs@gmail.com>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---

[...]

Thanks for the quick fix. I've tested this patch and now the BCC tools work fine.

Tested-by: Hengqi Chen <hengqi.chen@gmail.com>

Cheers,
--
Hengqi
