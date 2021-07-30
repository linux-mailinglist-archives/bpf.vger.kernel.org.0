Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6344B3DB2C0
	for <lists+bpf@lfdr.de>; Fri, 30 Jul 2021 07:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhG3FXH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Jul 2021 01:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhG3FXH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Jul 2021 01:23:07 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0996EC061765
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 22:23:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so12730493pji.5
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 22:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oLWSV/ZYyYbOfxHVI474Gytzy7BuKYTbQ1F/xZKWAFA=;
        b=iLLUHPD+imc20OkfoPCTqRNXG2FnEPPnDn7WBBG7GWRnzraqZjaFa9Gae4wDydikRC
         cUDmIWqu29y8r+/xFRcsOL33dw9szVjQ3K721Ln2quky/hKkUob6QH2o4Ih4+wHg9ojY
         eHoHVTRwNdQXw2p3g8UdPHaWUB4SJtSilXszjgPHHfBX5SL+pOOlXAd0hK6bzKsefojq
         xsUfoNBSzn+hXGiAaXj+ARieiQYmRewkLIF3zkPs07YKQxTnEIeLJfQSbPHMf+Qcz8T9
         GpP/PYPwdNJPFIi4mv2b5o9XdYiECh5AHe/PzVTl1GARPREZ4m7A/lZvC3CO7ked07mQ
         h9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oLWSV/ZYyYbOfxHVI474Gytzy7BuKYTbQ1F/xZKWAFA=;
        b=QNJzwHj9KvQ1gBBENMWQMf9hkoOscEM69eCClzWyQ7/IJRtD4chymCi08PrewSSSKY
         3/yJjCnw1H/T9ycvReOA25SflNt9rqPonDBsmGFwH4iRav45EZDWUjpeLbix3n1EQAdd
         gWwLgQofwJqZIB57FuePC/AoMFMKtlLK+vsWDv8cCpj4NQ4CD0ZpouIWpjg6tEgTKQnO
         TLgZk0DHcZqUXn35ZtgLX22Z5Tr5MVgUh9LDZXAU6NMo58uxJCGeg3HvLRVHsv8VI71b
         F+EgHDDEvYgrlfQRSiaqTlsqFENJ0jjBVyJsaFCnDG6T6VC90xoAqYyFUk7wf30GMc58
         MeYA==
X-Gm-Message-State: AOAM532LRNJ+Car/wu5crnIl6lZ8Q+roj36e6+KO2tOykzL83bETzIB2
        5n23QtWGTxPzpYpljjzpadw=
X-Google-Smtp-Source: ABdhPJwCTVZ4KgI1I4e1WIRvW2QajbjiM+2Onc7AIkY4Jer6u2Y+NOVWJvFpxwE0Qor0A+deuNWhnA==
X-Received: by 2002:aa7:864c:0:b029:34d:afdd:e70e with SMTP id a12-20020aa7864c0000b029034dafdde70emr1043997pfo.9.1627622582554;
        Thu, 29 Jul 2021 22:23:02 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.114])
        by smtp.gmail.com with ESMTPSA id bg8sm563344pjb.4.2021.07.29.22.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 22:23:02 -0700 (PDT)
Subject: Re: [PATCH bpf-next v2] libbpf: add
 libbpf_load_vmlinux_btf/libbpf_load_module_btf APIs
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Martin Lau <kafai@fb.com>
References: <20210728165525.19104-1-hengqi.chen@gmail.com>
 <CAEf4BzaejZHivWPPrWAEEDAiTM_HUDuB3v10HqsnYUUj+CshFA@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <1987f2c1-9759-229f-6e67-f68948a23079@gmail.com>
Date:   Fri, 30 Jul 2021 13:22:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaejZHivWPPrWAEEDAiTM_HUDuB3v10HqsnYUUj+CshFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/7/30 5:35 AM, Andrii Nakryiko wrote:
> On Wed, Jul 28, 2021 at 9:55 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Add two new APIs: libbpf_load_vmlinux_btf/libbpf_load_module_btf.
>> libbpf_load_vmlinux_btf is just an alias to the existing API named
>> libbpf_find_kernel_btf, rename it to be more precisely.
>> libbpf_load_module_btf can be used to load module BTF, add it for
>> completeness. These two APIs are useful for implementing tracing
>> tools and introspection tools.
>> This is part of the efforts towards libbpf 1.0. [1]
>>
>> [1] https://github.com/libbpf/libbpf/issues/280
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
>>  tools/lib/bpf/btf.c      | 15 ++++++++++++++-
>>  tools/lib/bpf/btf.h      |  2 ++
>>  tools/lib/bpf/libbpf.c   |  4 ++--
>>  tools/lib/bpf/libbpf.map |  2 ++
>>  4 files changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index b46760b93bb4..5f801739a1a2 100644
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
>> @@ -4440,6 +4445,14 @@ struct btf *libbpf_find_kernel_btf(void)
>>         return libbpf_err_ptr(-ESRCH);
>>  }
>>
>> +struct btf *libbpf_load_module_btf(const char *module_name, struct btf *vmlinux_btf)
> 
> In the light of Quentin's btf__load_from_kernel_by_id(), I'm now
> wondering if it's better to keep the naming consistent as
> btf__load_vmlinux_btf() and btf__load_module_btf()? And we should put
> them after btf__parse() family of constructors, as just another set of
> (special, but still) constructors. WDYT?
> 
> Sorry for a bit of back and forth...
> 
> Otherwise everything looks good, thanks.
> 

Thanks for the review. Will update as you suggested.
Sometimes naming is the hardest part of programming, I am not good at that. :)

(BTW, Quentin's tweet led me to here)

>> +{
>> +       char path[80];
>> +
>> +       snprintf(path, sizeof(path), "/sys/kernel/btf/%s", module_name);
>> +       return btf__parse_split(path, vmlinux_btf);
>> +}
>> +
>>  int btf_type_visit_type_ids(struct btf_type *t, type_id_visit_fn visit, void *ctx)
>>  {
>>         int i, n, err;
>> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
>> index 374e9f15de2e..1abf94e3bd9e 100644
>> --- a/tools/lib/bpf/btf.h
>> +++ b/tools/lib/bpf/btf.h
>> @@ -90,6 +90,8 @@ LIBBPF_API __u32 btf_ext__func_info_rec_size(const struct btf_ext *btf_ext);
>>  LIBBPF_API __u32 btf_ext__line_info_rec_size(const struct btf_ext *btf_ext);
>>
>>  LIBBPF_API struct btf *libbpf_find_kernel_btf(void);
>> +LIBBPF_API struct btf *libbpf_load_vmlinux_btf(void);
>> +LIBBPF_API struct btf *libbpf_load_module_btf(const char *module_name, struct btf *vmlinux_btf);
> 
> as mentioned above, let's move these right after btf__parse() family,
> so that all BTF constructor APIs are listed first.
> 

Sure, will do.

>>
>>  LIBBPF_API int btf__find_str(struct btf *btf, const char *s);
>>  LIBBPF_API int btf__add_str(struct btf *btf, const char *s);
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index a1ca6fb0c6d8..321d8f4889af 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -2680,7 +2680,7 @@ static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
>>         if (!force && !obj_needs_vmlinux_btf(obj))
>>                 return 0;
>>
>> -       obj->btf_vmlinux = libbpf_find_kernel_btf();
>> +       obj->btf_vmlinux = libbpf_load_vmlinux_btf();
>>         err = libbpf_get_error(obj->btf_vmlinux);
>>         if (err) {
>>                 pr_warn("Error loading vmlinux BTF: %d\n", err);
>> @@ -8297,7 +8297,7 @@ int libbpf_find_vmlinux_btf_id(const char *name,
>>         struct btf *btf;
>>         int err;
>>
>> -       btf = libbpf_find_kernel_btf();
>> +       btf = libbpf_load_vmlinux_btf();
>>         err = libbpf_get_error(btf);
>>         if (err) {
>>                 pr_warn("vmlinux BTF is not found\n");
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index c240d488eb5e..2088bdbc0f50 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -377,4 +377,6 @@ LIBBPF_0.5.0 {
>>                 bpf_object__gen_loader;
>>                 btf_dump__dump_type_data;
>>                 libbpf_set_strict_mode;
>> +               libbpf_load_vmlinux_btf;
>> +               libbpf_load_module_btf;
>>  } LIBBPF_0.4.0;
>> --
>> 2.25.1
>>
