Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F38348C2CC
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 12:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352716AbiALLE6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 06:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbiALLE6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 06:04:58 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0556C06173F
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 03:04:57 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id c36so3908289uae.13
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 03:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rEcATxt621+hOCjh+cNnw4dQgLgiyZ1Zk+5+YrSkGWw=;
        b=e2Adrln83l3qBQThn5mBwig84fFBhw/ntgzM7nBVqDbLqGTHkHqXaIAoRMJdltD7Zy
         S/Ka72hsM/i1hLIYYauqOlA+VHKBIRixFrjsDDJUHlfnNpOpqY21iO0J2qk/ixqkWPWP
         QeNSMljWLAzFFfWifVpYWVabv5IW2vDrXc3JJxlQFnbRXw4bYUJDebLB0iPO3pR6Lbjz
         U7W1MRbX95E8W8dc0ayWTLAwFJhm3G30SZKGOVSp3yADNwU/mRlQWLEjqCCSiMZnguqY
         8sabwGNDmx/+rfstL0VxFrjiRVVZUPaQOOcLx9RsJX3M772RfPhCZttSVMMr/vONzGpD
         uhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rEcATxt621+hOCjh+cNnw4dQgLgiyZ1Zk+5+YrSkGWw=;
        b=MqTLl+7m8pMm74lVvhqRITMcaXYeLUJYB3lIJpB9KnGQ4d9MLktuyn2QmkDeZjpPnx
         Mb9/UrkloaCJA5OeM47O83o0/5lXKJ2UFp07Ud65IYyjiLV3f5xHkOk0z1OZbTX8HMw+
         ATtv4h2oG7xvmMp7Fbu9PVehcCmV1TCJO3uVUKrpYru6Vm6kg0BWTAOGb+bj3UBxo3PQ
         wTC4S7cVbfns2cmF65X0pRsTL/eX20nqON7qhIrOhbpDlJitOR88FrfrnHObquwyob9z
         GSAnrYr4DNrxK41V6ntzJBUZYE8UWn4To1fCgn3YjEnRD+AsWYG+T7kQeP1I6nXRux/0
         5Dzg==
X-Gm-Message-State: AOAM533RgMlqUX4T4wt7TipdZ1ev3/ZtLVqx6TMI9W2y5qu86f/JmpUk
        NpBGMbpYpfnMuFFXiv/OJjXApXqS39BS/w==
X-Google-Smtp-Source: ABdhPJxB36cpuzlLNalvb9OEQCzGtfM5J+WD+2RM/kHcgHJg62gn5+MLT4v3MdgFgFqV/W9oBTaXXA==
X-Received: by 2002:a67:f550:: with SMTP id z16mr3835148vsn.23.1641985496776;
        Wed, 12 Jan 2022 03:04:56 -0800 (PST)
Received: from [192.168.1.8] ([149.86.64.198])
        by smtp.gmail.com with ESMTPSA id g43sm7147237uae.2.2022.01.12.03.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 03:04:56 -0800 (PST)
Message-ID: <bdf4ec41-58fa-d0db-f2d2-f6575c4444b8@isovalent.com>
Date:   Wed, 12 Jan 2022 11:04:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [External] Re: [PATCH v5] bpf/scripts: add an error if the
 correct number of helpers are not generated
Content-Language: en-GB
To:     Usama Arif <usama.arif@bytedance.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, joe@cilium.io,
        fam.zheng@bytedance.com, cong.wang@bytedance.com,
        alexei.starovoitov@gmail.com, song@kernel.org
References: <20220111184418.196442-1-usama.arif@bytedance.com>
 <e5ad3ed1-3d4e-f4cc-6eb9-073c0cca11d4@isovalent.com>
 <e3d4673b-08be-09fd-0a87-b679713146b5@bytedance.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <e3d4673b-08be-09fd-0a87-b679713146b5@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022-01-12 10:19 UTC+0000 ~ Usama Arif <usama.arif@bytedance.com>
> 
> 
> On 12/01/2022 10:01, Quentin Monnet wrote:
>> 2022-01-11 18:44 UTC+0000 ~ Usama Arif <usama.arif@bytedance.com>
>>> Currently bpf_helper_defs.h and the bpf helpers man page are
>>> auto-generated
>>> using function documentation present in bpf.h. If the documentation
>>> for the
>>> helper is missing or doesn't follow a specific format for e.g. if a
>>> function
>>> is documented as:
>>>   * long bpf_kallsyms_lookup_name( const char *name, int name_sz, int
>>> flags, u64 *res )
>>> instead of
>>>   * long bpf_kallsyms_lookup_name(const char *name, int name_sz, int
>>> flags, u64 *res)
>>> (notice the extra space at the start and end of function arguments)
>>> then that helper is not dumped in the auto-generated header and
>>> results in
>>> an invalid call during eBPF runtime, even if all the code specific to
>>> the
>>> helper is correct.
>>>
>>> This patch checks the number of functions documented within the
>>> header file
>>> with those present as part of #define __BPF_FUNC_MAPPER and generates an
>>> error in the header file and the man page if they don't match. It is not
>>> needed with the currently documented upstream functions, but can help in
>>> debugging when developing new helpers when there might be missing or
>>> misformatted documentation.
>>>
>>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>>>
>>> ---
>>> v4->v5:
>>> - Converted warning to error incase of missing/misformatted helper doc
>>>    (suggested by Song Liu)
>>
>> I don't think it was converted to an error in the sense that Song meant
>> it? Unless I'm missing something you simply changed the message so that
>> it prints "error" instead of "warning", but the script still goes on
>> without returning any error code, and a failure won't be detected by the
>> CI for example.
>>
>> Could you make the script break out on errors, and print a message to
>> stderr so that it's visible even if the generated output is redirected
>> to a file, please?
>>
> 
> It does now print an error to stdout while building an eBPF application.
> For e.g. if you introduce a space in the doc as in the commit message like:
> 
> diff --git a/tools/include/uapi/linux/bpf.h
> b/tools/include/uapi/linux/bpf.h
> index ba5af15e25f5..5bf80dbb820b 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -4908,7 +4908,7 @@ union bpf_attr {
>   *
>   *             **-ENOENT** if architecture does not support branch
> records.
>   *
> - * long bpf_trace_vprintk(const char *fmt, u32 fmt_size, const void
> *data, u32 data_len)
> + * long bpf_trace_vprintk( const char *fmt, u32 fmt_size, const void
> *data, u32 data_len)
>   *     Description
>   *             Behaves like **bpf_trace_printk**\ () helper, but takes
> an array of u64
>   *             to format and can handle more format args as a result.
> @@ -4938,6 +4938,12 @@ union bpf_attr {
>   *             **-ENOENT** if symbol is not found.
>   *
>   *             **-EPERM** if caller does not have permission to obtain
> kernel address.
> 
> and build samples/bpf:
> 
> make  LLVM_STRIP=llvm-strip-13 M=samples/bpf > /tmp/samplesbuild.out
> 
> you get the following at stderr returning an error code
> 
> make[2]: *** [Makefile:186:
> /data/usaari01/ebpf/linux/samples/bpf/bpftool/pid_iter.bpf.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> In file included from skeleton/profiler.bpf.c:4:
> In file included from
> /data/usaari01/ebpf/linux/samples/bpf/bpftool//bootstrap/libbpf//include/bpf/bpf_helpers.h:11:
> 
> /data/usaari01/ebpf/linux/samples/bpf/bpftool//bootstrap/libbpf//include/bpf/bpf_helper_defs.h:5:2:
> error: The number of unique helpers in description (176) don't match the
> number of unique helpers defined in __BPF_FUNC_MAPPER (180)
> #error The number of unique helpers in description (176) don't match the
> number of unique helpers defined in __BPF_FUNC_MAPPER (180)
>  ^
> /data/usaari01/ebpf/linux/samples/bpf/bpftool//bootstrap/libbpf//include/bpf/bpf_helper_defs.h:7:2:
> error: The description for FN(trace_vprintk) is not present or formatted
> correctly.
> #error The description for FN(trace_vprintk) is not present or formatted
> correctly.
>  ^

Right, my bad, I tried your patch to generate the header but didn't go
so far as to include it and try to compile a program.

> But i am guessing that you want an error while the script is run as well?
> If we do this:
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index adf08fa963a4..4ce982ce58f2 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -397,6 +397,7 @@ HELPERS
>      The description for %s is not present or formatted correctly.
>  ''' % (self.define_unique_helpers[nr_desc_unique_helpers])
>              print(header_error)
> +            print(header_error, file = sys.stderr)
> 
>          print(header_description)
> 
> @@ -693,6 +694,7 @@ class PrinterHelpers(Printer):
>  #error The description for %s is not present or formatted correctly.
>  ''' % (self.define_unique_helpers[nr_desc_unique_helpers])
>              print(header_error)
> +            print(header_error, file = sys.stderr)
> 
>          for fwd in self.type_fwds:
>              print('%s;' % fwd)
> 
> then an error will be printed while the script is run and also later
> while the eBPF application is compiled. I can send this in next version
> if thats the preference?

Yes, this is what I meant. From my point of view it would be best if we
had this message, and also if we could make bpf_doc.py raise an
Exception on such errors. Given that we can tell at this step already
that compiling will fail, we should as well break the workflow here,
there's not much point in carrying on and calling the compiler.

Thanks,
Quentin
