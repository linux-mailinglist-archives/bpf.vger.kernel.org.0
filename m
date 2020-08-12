Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80BC242DC2
	for <lists+bpf@lfdr.de>; Wed, 12 Aug 2020 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHLRAh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Aug 2020 13:00:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45296 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgHLRAh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Aug 2020 13:00:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id bh1so1369475plb.12;
        Wed, 12 Aug 2020 10:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lkrVTld7lAt1xz+QrbSi/yFZ8fFXw8HLzCpe21br17Q=;
        b=lSgKEWvkbUw0VNmclapJOEVPssru1EOL0Fx3aGDMTDxieI/6t3lF5ucGvbNP6kOKyu
         xv2pUXmV0M4GiNAPDm7gjTHQIHzm2zxO990NQrMGz50uPv6VwicRrjo9KqAY2sI7u7D3
         UiJiutIm8N4cv8iYtoT98lJQrmXWp3Ym7gkiCYiDvMbpN2ZT66sl6IRH0kvxNi9OGxgM
         HvIfLs7VUYCOJW8WPgYEyRX+DcSvXeJkpgMVQGdbKEti1tnh9fTbpQcfplnG8jjZpNCx
         jHgRGa8NTUXcwKlIMmWX4hRRzk9maIv0xO26UcTIjHVwH3HvN/9sID43jB1hlc7vKox/
         nTyA==
X-Gm-Message-State: AOAM5309DSsSKZt4e1mYZfVV7Z4h76vVkSHAPOTE8XpUVHXXG7FYmup8
        nL78cusJOqumSvLTPh++QYg=
X-Google-Smtp-Source: ABdhPJzGwQJNRsAMdn0ci0SdEREfKON9YbF+yBmie/37gN6UG4336tBAGcXLZ0fj0Ghy3pK7ezU7bA==
X-Received: by 2002:a17:902:a70e:: with SMTP id w14mr320233plq.259.1597251636429;
        Wed, 12 Aug 2020 10:00:36 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id q33sm2500823pgb.2.2020.08.12.10.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 10:00:35 -0700 (PDT)
Subject: Re: [RFC PATCH 4/4] bpf: add BPF_PROG_TYPE_LSM to bpftool name array
To:     Leah Rumancik <leah.rumancik@gmail.com>, bpf@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-5-leah.rumancik@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <2a5827e8-3051-f95f-36ac-08399638b43c@acm.org>
Date:   Wed, 12 Aug 2020 10:00:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812163305.545447-5-leah.rumancik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-08-12 09:33, Leah Rumancik wrote:
> Update prog_type_name[] to include missing entry for BPF_PROG_TYPE_LSM
> 
> Signed-off-by: Kjetil Ørbekk <orbekk@google.com>
> Signed-off-by: Harshad Shirwadkar <harshads@google.com>
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  tools/bpf/bpftool/main.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 0607ae6f6d90..ccc6ac9f82c2 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -86,6 +86,7 @@ static const char * const prog_type_name[] = {
>  	[BPF_PROG_TYPE_TRACING]			= "tracing",
>  	[BPF_PROG_TYPE_STRUCT_OPS]		= "struct_ops",
>  	[BPF_PROG_TYPE_EXT]			= "ext",
> +	[BPF_PROG_TYPE_LSM]			= "lsm",
>  	[BPF_PROG_TYPE_IO_FILTER]		= "io_filter",
>  };

Is this perhaps intended as a bug fix for commit fc611f47f218
("bpf: Introduce BPF_PROG_TYPE_LSM")? If so, please include a Fixes:
tag, Cc the authors of that patch and move this patch to the start
of this patch series.

Thanks,

Bart.
