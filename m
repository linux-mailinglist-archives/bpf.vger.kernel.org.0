Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF163D6B79
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 03:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhG0AcP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 20:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbhG0AcO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 20:32:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F64C061757
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 18:12:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b1-20020a17090a8001b029017700de3903so1483903pjn.1
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 18:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5qmXa/hcXIxCYe084lwu8jX6+REyVQd0seK1gh4CDsc=;
        b=gXYgBUf2yED4498GlhqXM6R3mbM3uHPwNa0hh9M62c/NonqMa5DK1z/HAAaij1XvEk
         4bjQWQZkGFbcV3bbwBcQtc2t8t5b4DqO1wBSQB8WZhoSUrFiACagGuu5l5LcDHH8cyQJ
         XlKwtY9hSte5Uj1yXvRb45tym1UhudQWV4qvyLAwW6fMJl2GfGj+nX8UsZoTvAYu/G24
         jCTZBXmzEVlrDT+aIMDVzJZhsUREP56dsbLUZN22J+htzk3Nmi3hvJUG2CrDPvHjDZAb
         Qv739VGpSGR9WIn0u6A0gOXnTfQohRzxon//fXWHo8tNm+jq8gYZre9IBky3/UZmQYfj
         ZyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5qmXa/hcXIxCYe084lwu8jX6+REyVQd0seK1gh4CDsc=;
        b=W40cxI7MHS1HENRPfhbB3q9Ts0CCxM51016vE7lP4wq3Dgyab3etxArHHseFkaElBd
         9OM01IqUZOnzmP/iO0rI5VI77WTIUn8UOPwujqjzvpDjVAwcMbiK6I0nJoMcBMchHhui
         wWyHlD76B4wRZ4RqdcxX2dNq9us+s9aMQWajt7zJJeeHBkVDI49NwjksuMzB11eOzakj
         CNPrrDSS43wKcsFvaN0iHsXrpdWnvJ8hWqBNAga2f6zKcsPqghiLDX4d4JmztaFSj7lJ
         TAPiVADOBT2hu94XQzFuXMzBwZ9p98j+IiddxvHA1KBadK5kHYyzPCWOkjxiX8Uu35u1
         yGfw==
X-Gm-Message-State: AOAM533d4qbuQadbJvklF11siHSNy6/nvboblClB0WcIz7OQ/T474wtK
        v+pJgw4E4QLlDfoxcCJtJ9o=
X-Google-Smtp-Source: ABdhPJxs3CKx96v1IO9GW3YkSROPLrSpKODMa5a1kzmTb8sSaaYBNnDdy6RdfWmzCxzgZw+Rr8eOtQ==
X-Received: by 2002:a63:f959:: with SMTP id q25mr21278198pgk.52.1627348361573;
        Mon, 26 Jul 2021 18:12:41 -0700 (PDT)
Received: from [0.0.0.0] ([150.109.126.7])
        by smtp.gmail.com with ESMTPSA id gk5sm698890pjb.51.2021.07.26.18.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 18:12:41 -0700 (PDT)
Subject: Re: [PATCH bpf-next] libbpf: add
 libbpf_load_vmlinux_btf/libbpf_load_module_btf APIs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>
References: <20210724051256.1629110-1-hengqi.chen@gmail.com>
 <CAEf4BzaZEny+3iu6ZGqAaY8QGE27TJoky=pzMcyg934_cJ3QTg@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <db11440c-c9ce-9007-9a03-7395d6facfe7@gmail.com>
Date:   Tue, 27 Jul 2021 09:12:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaZEny+3iu6ZGqAaY8QGE27TJoky=pzMcyg934_cJ3QTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/27/21 6:49 AM, Andrii Nakryiko wrote:
> On Fri, Jul 23, 2021 at 10:13 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Add libbpf_load_vmlinux_btf/libbpf_load_module_btf APIs.
>> This is part of the libbpf v1.0. [1]
>>
>> [1] https://github.com/libbpf/libbpf/issues/280
> 
> Saying it's part of libbpf 1.0 effort and given a link to Github PR is
> not really a sufficient commit message. Please expand on what you are
> doing in the patch and why.
> 

Will do.

>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
>>  tools/lib/bpf/btf.c      | 24 +++++++++++++++++++++++-
>>  tools/lib/bpf/btf.h      |  2 ++
>>  tools/lib/bpf/libbpf.c   |  8 ++++----
>>  tools/lib/bpf/libbpf.map |  2 ++
>>  4 files changed, 31 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index b46760b93bb4..414e1c5635ef 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -4021,7 +4021,7 @@ static void btf_dedup_merge_hypot_map(struct btf_dedup *d)
>>                  */
>>                 if (d->hypot_adjust_canon)
>>                         continue;
>> -
>> +
>>                 if (t_kind == BTF_KIND_FWD && c_kind != BTF_KIND_FWD)
>>                         d->map[t_id] = c_id;
>>
>> @@ -4395,6 +4395,11 @@ static int btf_dedup_remap_types(struct btf_dedup *d)
>>   * data out of it to use for target BTF.
>>   */
>>  struct btf *libbpf_find_kernel_btf(void)
>> +{
>> +       return libbpf_load_vmlinux_btf();
>> +}
>> +
>> +struct btf *libbpf_load_vmlinux_btf(void)
>>  {
>>         struct {
>>                 const char *path_fmt;
>> @@ -4440,6 +4445,23 @@ struct btf *libbpf_find_kernel_btf(void)
>>         return libbpf_err_ptr(-ESRCH);
>>  }
>>
>> +struct btf *libbpf_load_module_btf(const char *mod)
> 
> So we probably need to allow user to pre-load and re-use vmlinux BTF
> for efficiency, especially if they have some use-case to load a lot of
> BTFs.
> 

Should the API change to this ?

struct btf *libbpf_load_module_btf(struct btf *base, const char *mod)

It seems better for the use-case you mentioned.

>> +{
>> +       char path[80];
>> +       struct btf *base;
>> +       int err;
>> +
>> +       base = libbpf_load_vmlinux_btf();
>> +       err = libbpf_get_error(base);
>> +       if (err) {
>> +               pr_warn("Error loading vmlinux BTF: %d\n", err);
>> +               return base;
> 
> libbpf_err_ptr() needs to be used here, pr_warn() could have destroyed
> errno already
> 

OK.

>> +       }
>> +
>> +       snprintf(path, sizeof(path), "/sys/kernel/btf/%s", mod);
>> +       return btf__parse_split(path, base);
> 
> so who's freeing base BTF in this case?
> 

Sorry, missed that.
But if we change the signature, then leave this to user.

>> +}
>> +
>>  int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, void *ctx)
>>  {
>>         int i, n, err;
> 
> [...]
> 
