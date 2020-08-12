Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED90242DCF
	for <lists+bpf@lfdr.de>; Wed, 12 Aug 2020 19:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgHLREM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Aug 2020 13:04:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45729 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHLREM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Aug 2020 13:04:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id x6so1348070pgx.12;
        Wed, 12 Aug 2020 10:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bxoMyZwkVbe7qooPeDulAjD2EBf7cdbYhhYN/t8OC5Q=;
        b=dh84uXweMyQUHYhg9VSyw0VtQLgScqCVWbv1UExVKsAFQKLSQqRM2tlN3Y9kFqVnIs
         TbrrEbtLznVf8PKaKGFYEtAq8aaAO3J7aft4mXJFlAmi/Codq/SFJG6exRPcJ7EljzMm
         mIHVA9PjL7lIou/3khu5Q+1jyXPYh5X4W8jKCzT94kzpsJI1MVa1MzC+kzLfnfiisH7m
         BQMAETctFONn1n2E0w9YQY7CCnWVLgS5rQsuFH+C2YgKcMGwcVxGAYC2eaE+lKXs8bUu
         JNxopIcTP2FUde2LOCinCuCe/zVdQmzyZ1CEMtTeymmd/ebJZY5jhPcTG0pxDd7tbZhh
         rzYQ==
X-Gm-Message-State: AOAM532IK0kd6yt5BYOZTz4O1HBQEj4zRohXPMk0DWlaJEw39ahMAIvd
        XfnsvPyFlt098/CeiQZb262QqZYl
X-Google-Smtp-Source: ABdhPJzTuFn5m++HNUK/3rdYaSamyNHjdP3nBCWjDGDwl/uMdVW67varEr3rqyw5JbviA09vnkWO8w==
X-Received: by 2002:aa7:9585:: with SMTP id z5mr446469pfj.11.1597251851095;
        Wed, 12 Aug 2020 10:04:11 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id t13sm2769871pgm.32.2020.08.12.10.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 10:04:10 -0700 (PDT)
Subject: Re: [RFC PATCH 3/4] bpf: add eBPF IO filter documentation
To:     Leah Rumancik <leah.rumancik@gmail.com>, bpf@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-4-leah.rumancik@gmail.com>
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
Message-ID: <b6da2093-a555-d977-1711-c787e3e36ca1@acm.org>
Date:   Wed, 12 Aug 2020 10:04:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812163305.545447-4-leah.rumancik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-08-12 09:33, Leah Rumancik wrote:
> +======================
> +IO Filtering with eBPF
> +======================
> +
> +Bio requests can be filtered with the eBPF IO filter program type (BPF_PROG_TYPE_IO_FILTER). To use this program type, the kernel must be compiled with CONFIG_BPF_IO_FILTER.

Please add information in this paragraph about why one should or should
not install a BPF I/O filter. What are the use cases for BPF I/O filters?
I think the following information from the Kconfig file is useful:
"Enables instrumentation of the hooks in block subsystem with eBPF programs
for observing and filtering io."

Thanks,

Bart.
