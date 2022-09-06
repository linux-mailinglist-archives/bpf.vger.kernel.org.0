Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272E15AE3FA
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 11:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiIFJSJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 05:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238694AbiIFJRi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 05:17:38 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF4F30F64
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 02:17:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id az27so14455550wrb.6
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=WoPmaKXY6vfWROfygWgQitCPzi+zIthSpQENz/1/3Cg=;
        b=BgeXAvBjXBgfm9rv9oBnPq7+xVEye+QrBCcaa+SYd+ak5QRGop7vXxilEggf8r1gxB
         SgSR9NKk6L0abyrvMSPBV+e/46O+MKQ7taMcxEDWxhmmdu2MPU8f4e7qBKODs2JtA3xA
         UvLExurcSSGISWVNxz8BY8qs9+lZbhEGv3JbCGlkL5doTHHlw79dCT5e1lk4+jTI3pJf
         faylj9h6so2BayOfH3vr/jHefwkLAxyMrA89LmWHLKQ4dSNJAQWjKT9sXU7sELYXoGTK
         2DXhl7RqdFdexMKfw4ATQuKxm83tATGySCXmb/67mdTvfmcrJXRDE2cwY3f4Q738f5FO
         W29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WoPmaKXY6vfWROfygWgQitCPzi+zIthSpQENz/1/3Cg=;
        b=J3FW0XBQdmI1k/kXnNyahUFvJG/YQo1z+/ERgP5z+K2rkEaWOCQOMsAHG75syvnoYe
         iZyXAbFP3cfUh2zRo99+3YvROM38g31DNctrPxM9GjK846NahK5pkjoV22lQjFKs8F3Q
         ajIymiAgSt6F99c+KjZyPHv3vn2DoLEo7PCF4PXfxlDdXLSjtDIWueDMWsmuK4fTRWzV
         jb8N5uAUMc/H0rHReVFogEjbA4LVbDqfBNGOtbEGpduvNzuoFVwxLWILp8O8mNoey00s
         zcQcDlYnIeQefVTiGpAvLiEzFYv89mT3mUH1d9iu7p7fB95X5LKtpb6EtHfbxtHlSSXw
         2RZA==
X-Gm-Message-State: ACgBeo2UQbO5zjrIjhgMWlKtsqm8TrZz2hqIe0QycgT0L0uOMwzGH5WZ
        7S8UUqvNhceuXkYuWsLvSG4C+A==
X-Google-Smtp-Source: AA6agR4l+qoJ/Xmjz7N9uOSprrhE4QWyFUTByn7FMViYCvfO4rosa0ctf6qv6YKm5zludg0rVyrTXg==
X-Received: by 2002:a05:6000:1f83:b0:223:60ee:6c08 with SMTP id bw3-20020a0560001f8300b0022360ee6c08mr25793119wrb.682.1662455825581;
        Tue, 06 Sep 2022 02:17:05 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003a31fd05e0fsm40263292wms.2.2022.09.06.02.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 02:17:05 -0700 (PDT)
Message-ID: <0fea646d-429a-9c7f-2c1d-b2893b02554a@isovalent.com>
Date:   Tue, 6 Sep 2022 10:17:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH bpf-next v2] bpftool: implement perf attach command
Content-Language: en-GB
To:     "weiyongjun (A)" <weiyongjun1@huawei.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20220824033837.458197-1-weiyongjun1@huawei.com>
 <b942bf8f-204b-6bf1-7847-ec5f11c50ca0@isovalent.com>
 <CAEf4BzafSAZfhkun5PBGODw6v1s10Nh4JeH8azdqZY-62kBCKg@mail.gmail.com>
 <ee620e99-dc04-aa2c-f53b-b875dba79feb@isovalent.com>
 <d17a51a0-954f-7c77-7172-9ef5b3bb84f7@huawei.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <d17a51a0-954f-7c77-7172-9ef5b3bb84f7@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/09/2022 11:23, weiyongjun (A) wrote:
> Hi Quentin,
> 
> On 2022/8/26 18:45, Quentin Monnet wrote:
>> Hi Andrii,
>>
>> On 25/08/2022 19:37, Andrii Nakryiko wrote:
>>> On Thu, Aug 25, 2022 at 8:28 AM Quentin Monnet
>>> <quentin@isovalent.com> wrote:
>>>>
>>>> Hi Wei,
>>>>
>>>> Apologies for failing to answer to your previous email and for the
>>>> delay
>>>> on this one, I just found out GMail had classified them as spam :(.
>>>>
>>>> So as for your last message, yes: your understanding of my previous
>>>> answer was correct. Thanks for the patch below! Some comments inline.
>>>>
>>>
>>> Do we really want to add such a specific command to bpftool that would
>>> attach BPF object files with programs of only RAW_TRACEPOINT and
>>> RAW_TRACEPOINT_WRITABLE type?
>>>
>>> I could understand if we added something that would be equivalent of
>>> BPF skeleton's auto-attach method. That would make sense in some
>>> contexts, especially for some quick testing and validation, to avoid
>>> writing (a rather simple) user-space loading code.
>>
>> Do you mean loading and attaching in a single step, or keeping the
>> possibility to load first as in the current proposal?
>>
>>>
>>> But "perf attach" for raw_tp programs only? Seem way too limited and
>>> specific, just adding bloat to bpftool, IMO.
>>
>> We already support attaching some kinds of program types through
>> "prog|cgroup|net attach". Here I thought we could add support for other
>> types as a follow-up, but thinking again, you're probably right, it
>> would be best if all the types were supported from the start. Wei, have
>> you looked into how much work it would be to add support for
>> tracepoints, k(ret)probes, u(ret)probes as well? The code should be
>> mostly identical?
>>
> 
> 
> When I try to add others support, I found that we need to dup many code
> with libbpf has already done, since we lost the section name info.

What amount of code does this represent? Do you have a version of the
patch accessible somewhere? I trust you, I'm just curious about the
steps we're missing without having processed the section name info, but
I can go and look at the details myself otherwise.

> I have tried to add auto-attach, it seems more easier then perf
> attach command.
> 
> What's about your opinion?

Yes I'm good with that approach, too.

> Maybe we only need a little of changes like this:
> 
> $ bpftool prog load test.o /sys/fs/bpf/test auto-attach

"auto_attach", other keywords use underscores rather than dashes.

> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index c81362a001ba..87fab89eaa07 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1464,6 +1464,7 @@ static int load_with_options(int argc, char


> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3ad139285fad..915ec0a97583 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7773,15 +7773,32 @@ int bpf_program__pin(struct bpf_program *prog,
> const char *path)
>      if (err)
>          return libbpf_err(err);
> 
> -    if (bpf_obj_pin(prog->fd, path)) {
> -        err = -errno;
> -        cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
> -        pr_warn("prog '%s': failed to pin at '%s': %s\n", prog->name,
> path, cp);
> -        return libbpf_err(err);
> +    if (prog->autoattach) {
> +        struct bpf_link *link;
> +
> +        link = bpf_program__attach(prog);
> +        err = libbpf_get_error(link);
> +        if (err)
> +            goto err_out;
> +
> +        err = bpf_link__pin(link, path);
> +        if (err) {
> +            bpf_link__destroy(link);
> +            goto err_out;
> +        }
> +    } else {
> +        if (bpf_obj_pin(prog->fd, path)) {
> +            err = -errno;
> +            goto err_out;
> +        }
>      }
> 
>      pr_debug("prog '%s': pinned at '%s'\n", prog->name, path);
>      return 0;
> +err_out:
> +    cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
> +    pr_warn("prog '%s': failed to pin at '%s': %s\n", prog->name, path,
> cp);
> +    return libbpf_err(err);
>  }
> 
>  int bpf_program__unpin(struct bpf_program *prog, const char *path)

I don't think it is correct to modify libbpf's bpf_program__pin()
though, because it shouldn't be its role to attach and also because I
think it might lead to a second attempt to attach if the user tries to
pin in addition to running the auto-attach from a skeleton. Let's just
call bpf_program__attach() from bpftool instead?
