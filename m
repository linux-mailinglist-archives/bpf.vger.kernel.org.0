Return-Path: <bpf+bounces-12709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FA17CFFA6
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 18:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8FF6B21382
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C2232C73;
	Thu, 19 Oct 2023 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhoeaIqq"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1733F32C6B
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 16:31:36 +0000 (UTC)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7639F114
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 09:31:34 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9ace5370a0so8220546276.0
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697733093; x=1698337893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NAGGUYA00TKIzGfUt3Gic2u3lExgV8cOvRnns9v1abc=;
        b=YhoeaIqqUuRxgl0PbTOkMOc6tujbyTzxMhXq17J5YDJ95A9iof/0U0IwrdOYay3v/h
         mcse1BxP7CBKBJGf/4usSn+v/ohuZX7Yh7WBngUylr23IIQmdr/dUDHqhYi55MRdM//+
         BSjmkpAMLKobkKZB3qE84IfmDknZWUGaIyGGS8qhv5V0TQwSkoFhgTlumlpN9uaGOPmX
         CKfdX5kM3G15xouxNnKabiBCowUOEmyh21820LsYZPu1nMnWARxGKvF0OMfHkbmv7KQu
         AGWgeOmoZ3s+HzPsTg5wrEefHltZFx5fu8XF4/fTrcd3BoVgRKRqdvYqjQm9+G/XD3ZP
         eGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697733093; x=1698337893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NAGGUYA00TKIzGfUt3Gic2u3lExgV8cOvRnns9v1abc=;
        b=TwFrfW8o//7hAI0WVRZ1foL0OFsZU5IOJDQ3gkTR+Ls8e9x10xfzVHfGgj6TMPJUOK
         I4UsHuVsypN6pTYkSEPYtd0aald6kpWZSfMHAwSnUGwKrkUgiLJwj1pXsLyX5hy0KZzN
         43z1jvTuyxd71K0jO5zD0eajDVHIaoKeHireWd2RQwpNvU/I27rDhyIcwnnf6FLDAgBj
         m/+ih9cjy0daYeCPN2kKqDTuohdGD8oQqOzyBDH5VGZPK6wqZB2bsglzoEhhWz6JJt7u
         ycrZcKAznv4lHCuZHyfI5hhvQgBhJnk5Oih6iNu9qzik3fK9bYzFQh3Y9e97Thwhqj5d
         FLhw==
X-Gm-Message-State: AOJu0YwV0+85bY2pu0QVSVk2INd7ZPSHKKBWvUZIpxtiAWqBCo9o36um
	u0s9SZrMdcn6a++D6Attnug=
X-Google-Smtp-Source: AGHT+IErjxSQ7wB7jWOwCaGYYrccSSk6bY2CdNP3r1dc1T+PTPgcqFiNXavJu8L6W5EqVEE8oM8NDg==
X-Received: by 2002:a25:9387:0:b0:d9a:3a83:98e0 with SMTP id a7-20020a259387000000b00d9a3a8398e0mr2769503ybm.52.1697733093642;
        Thu, 19 Oct 2023 09:31:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:6ce6:ec83:39e7:c47c? ([2600:1700:6cf8:1240:6ce6:ec83:39e7:c47c])
        by smtp.gmail.com with ESMTPSA id x17-20020a5b0f11000000b00d9abce6acf2sm2110433ybr.59.2023.10.19.09.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 09:31:33 -0700 (PDT)
Message-ID: <dbae9006-563d-4d1d-8957-aa098bbb122b@gmail.com>
Date: Thu, 19 Oct 2023 09:31:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 7/9] libbpf: Find correct module BTFs for
 struct_ops maps and progs.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231017162306.176586-1-thinker.li@gmail.com>
 <20231017162306.176586-8-thinker.li@gmail.com>
 <74e172ec-6884-0de9-d8b9-3aa443bb5922@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <74e172ec-6884-0de9-d8b9-3aa443bb5922@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/18/23 19:43, Martin KaFai Lau wrote:
> On 10/17/23 9:23 AM, thinker.li@gmail.com wrote:
>> -static int find_ksym_btf_id(struct bpf_object *obj, const char 
>> *ksym_name,
>> -                __u16 kind, struct btf **res_btf,
>> -                struct module_btf **res_mod_btf)
>> +static int find_module_btf_id(struct bpf_object *obj, const char 
>> *kern_name,
>> +                  __u16 kind, struct btf **res_btf,
>> +                  struct module_btf **res_mod_btf)
>>   {
>>       struct module_btf *mod_btf;
>>       struct btf *btf;
>> @@ -7710,7 +7728,7 @@ static int find_ksym_btf_id(struct bpf_object 
>> *obj, const char *ksym_name,
>>       btf = obj->btf_vmlinux;
>>       mod_btf = NULL;
>> -    id = btf__find_by_name_kind(btf, ksym_name, kind);
>> +    id = btf__find_by_name_kind(btf, kern_name, kind);
>>       if (id == -ENOENT) {
>>           err = load_module_btfs(obj);
>> @@ -7721,7 +7739,7 @@ static int find_ksym_btf_id(struct bpf_object 
>> *obj, const char *ksym_name,
>>               /* we assume module_btf's BTF FD is always >0 */
>>               mod_btf = &obj->btf_modules[i];
>>               btf = mod_btf->btf;
>> -            id = btf__find_by_name_kind_own(btf, ksym_name, kind);
>> +            id = btf__find_by_name_kind_own(btf, kern_name, kind);
>>               if (id != -ENOENT)
>>                   break;
>>           }
>> @@ -7744,7 +7762,7 @@ static int 
>> bpf_object__resolve_ksym_var_btf_id(struct bpf_object *obj,
>>       struct btf *btf = NULL;
>>       int id, err;
>> -    id = find_ksym_btf_id(obj, ext->name, BTF_KIND_VAR, &btf, &mod_btf);
>> +    id = find_module_btf_id(obj, ext->name, BTF_KIND_VAR, &btf, 
>> &mod_btf);
>>       if (id < 0) {
>>           if (id == -ESRCH && ext->is_weak)
>>               return 0;
>> @@ -7798,8 +7816,8 @@ static int 
>> bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
>>       local_func_proto_id = ext->ksym.type_id;
>> -    kfunc_id = find_ksym_btf_id(obj, ext->essent_name ?: ext->name, 
>> BTF_KIND_FUNC, &kern_btf,
>> -                    &mod_btf);
>> +    kfunc_id = find_module_btf_id(obj, ext->essent_name ?: ext->name, 
>> BTF_KIND_FUNC, &kern_btf,
>> +                      &mod_btf);
>>       if (kfunc_id < 0) {
>>           if (kfunc_id == -ESRCH && ext->is_weak)
>>               return 0;
>> @@ -9464,9 +9482,9 @@ static int libbpf_find_prog_btf_id(const char 
>> *name, __u32 attach_prog_fd)
>>       return err;
>>   }
>> -static int find_kernel_btf_id(struct bpf_object *obj, const char 
>> *attach_name,
>> -                  enum bpf_attach_type attach_type,
>> -                  int *btf_obj_fd, int *btf_type_id)
>> +static int find_kernel_attach_btf_id(struct bpf_object *obj, const 
>> char *attach_name,
>> +                     enum bpf_attach_type attach_type,
>> +                     int *btf_obj_fd, int *btf_type_id)
>>   {
>>       int ret, i;
>> @@ -9531,7 +9549,9 @@ static int libbpf_find_attach_btf_id(struct 
>> bpf_program *prog, const char *attac
>>           *btf_obj_fd = 0;
>>           *btf_type_id = 1;
>>       } else {
>> -        err = find_kernel_btf_id(prog->obj, attach_name, attach_type, 
>> btf_obj_fd, btf_type_id);
>> +        err = find_kernel_attach_btf_id(prog->obj, attach_name,
>> +                        attach_type, btf_obj_fd,
>> +                        btf_type_id);
>>       }
>>       if (err) {
>>           pr_warn("prog '%s': failed to find kernel BTF type ID of 
>> '%s': %d\n",
>> @@ -12945,9 +12965,9 @@ int bpf_program__set_attach_target(struct 
>> bpf_program *prog,
>>           err = bpf_object__load_vmlinux_btf(prog->obj, true);
>>           if (err)
>>               return libbpf_err(err);
>> -        err = find_kernel_btf_id(prog->obj, attach_func_name,
>> -                     prog->expected_attach_type,
>> -                     &btf_obj_fd, &btf_id);
>> +        err = find_kernel_attach_btf_id(prog->obj, attach_func_name,
>> +                        prog->expected_attach_type,
>> +                        &btf_obj_fd, &btf_id);
> 
> Please avoid mixing this level of name changes with the main changes. It 
> is quite confusing for the reviewer and it is not mentioned in the 
> commit message either.

Got it! Sorry confusing.


