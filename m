Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACC83D1D35
	for <lists+bpf@lfdr.de>; Thu, 22 Jul 2021 07:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhGVEUr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Jul 2021 00:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhGVEUr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Jul 2021 00:20:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08485C061575
        for <bpf@vger.kernel.org>; Wed, 21 Jul 2021 22:01:22 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bt15so4532889pjb.2
        for <bpf@vger.kernel.org>; Wed, 21 Jul 2021 22:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GNGpXQe8feGHQzjIfViGPOLszslCUwwXehFjg1kfPUE=;
        b=WJnCkqa5rv5jGQFePnvw8InRUSE30ATrVcJthZnfpZcV8DrDotvq1SxAp2w21tKAay
         eKn4hqvYl7Pw/WGi0ntzHCQXvhy4E4BG0Hu2qM+yKyCEpfoZo9GJLn6qMXOsgxdi+2XE
         0U9oeji6/I7xyjje1fRKqQ8Wftz9Poge4lUk+G5J61zwgLrH3MxkcySJHGw67lASqMDM
         mdWenYifRw7x788gnxOcVJE4Y5rqGrfoto7bhr3K7s3hXhwESm28g/sNl7EtXNUWTAr6
         sK22vvi6rxaby4roMmQ2uCarIJuaTTYMVtzY1womhYzbz5M5PZJPlHZeSuy+FIQdGpAx
         SvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GNGpXQe8feGHQzjIfViGPOLszslCUwwXehFjg1kfPUE=;
        b=NWGjO78jpCCDiPSuUwozrlKCTfQJwoIlQQPMNBfe/6LYui5xKBfzu+j9lkK0MykJTz
         YDYF7LBVMzlz6D4nVMatqL3CABDBrBoc0+WHBG+SqrwG3j2X38KjQRW8bPTroh+wKTlq
         nfwm9dMVTHaLBlM2LWvWDn1MKoZq0g81LKK66PFnfxILIkHcqw0Ts9FR6SfeFVwY7GtX
         JlsY3LQVSghVpjn1OllQ723vSvwaqfwunntjK+SCIspgN32VQmTqYbVX0njjbqFrLGO0
         7gNzWuekd+pl2umBPbqo/+CmRnP63U+sJ7WTN4s/OMrpl7ATEtWJohZ3/Z0rWMFqYLFA
         NbkA==
X-Gm-Message-State: AOAM531NhupNHwcKjXrUqiHyPA8H2OaDWUIW2Toyvqe4WohEYwIH7HEM
        +L5ah0dQrKkv6jdEGyeVRoY=
X-Google-Smtp-Source: ABdhPJxxqlHZE5cocjCym62QmKKo9EsTArUXniRRoaRTcSRNzCKS9ZMACxBwnpQiRAu0ogFhaMMwOw==
X-Received: by 2002:a17:902:b113:b029:128:cec4:e01e with SMTP id q19-20020a170902b113b0290128cec4e01emr30609639plr.78.1626930081571;
        Wed, 21 Jul 2021 22:01:21 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id f18sm23532675pfe.25.2021.07.21.22.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 22:01:21 -0700 (PDT)
Subject: Re: [PATCH bpf-next v2] bpf: expose bpf_d_path helper to vfs_* and
 security_* functions
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <20210719151753.399227-1-hengqi.chen@gmail.com>
 <CAEf4BzborEP9oEa9VHkMnWFozXHOdVRf9BbbdNYOT5PEX6cdcQ@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <bf75e892-80f9-da10-599a-c89043a5a9e8@gmail.com>
Date:   Thu, 22 Jul 2021 13:01:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzborEP9oEa9VHkMnWFozXHOdVRf9BbbdNYOT5PEX6cdcQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/7/20 3:02 AM, Andrii Nakryiko wrote:
> On Mon, Jul 19, 2021 at 8:18 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>>
>> Add vfs_* and security_* to bpf_d_path allowlist, so that we can use
>> bpf_d_path helper to extract full file path from these functions'
>> `struct path *` and `struct file *` arguments. This will help tools
>> like IOVisor's filetop[2]/filelife to get full file path.
>>
>> Changes since v1: [1]
>>  - Alexei and Yonghong suggested that bpf_d_path helper could also
>>    apply to vfs_* and security_file_* kernel functions. Added them.
>>
>> [1] https://lore.kernel.org/bpf/20210712162424.2034006-1-hengqi.chen@gmail.com/
>> [2] https://github.com/iovisor/bcc/issues/3527
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
>>  kernel/trace/bpf_trace.c | 50 ++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 48 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 08906007306d..c784f3c7143f 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -850,16 +850,62 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
>>  BTF_SET_START(btf_allowlist_d_path)
>>  #ifdef CONFIG_SECURITY
>>  BTF_ID(func, security_file_permission)
>> -BTF_ID(func, security_inode_getattr)
>>  BTF_ID(func, security_file_open)
>> +BTF_ID(func, security_file_ioctl)
>> +BTF_ID(func, security_file_free)
>> +BTF_ID(func, security_file_alloc)
>> +BTF_ID(func, security_file_lock)
>> +BTF_ID(func, security_file_fcntl)
>> +BTF_ID(func, security_file_set_fowner)
>> +BTF_ID(func, security_file_receive)
>> +BTF_ID(func, security_inode_getattr)
>>  #endif
>>  #ifdef CONFIG_SECURITY_PATH
>>  BTF_ID(func, security_path_truncate)
>> +BTF_ID(func, security_path_notify)
>> +BTF_ID(func, security_path_unlink)
>> +BTF_ID(func, security_path_mkdir)
>> +BTF_ID(func, security_path_rmdir)
>> +BTF_ID(func, security_path_mknod)
>> +BTF_ID(func, security_path_symlink)
>> +BTF_ID(func, security_path_link)
>> +BTF_ID(func, security_path_rename)
>> +BTF_ID(func, security_path_chmod)
>> +BTF_ID(func, security_path_chown)
>> +BTF_ID(func, security_path_chroot)
>>  #endif
>>  BTF_ID(func, vfs_truncate)
>>  BTF_ID(func, vfs_fallocate)
>> -BTF_ID(func, dentry_open)
>>  BTF_ID(func, vfs_getattr)
>> +BTF_ID(func, vfs_fadvise)
>> +BTF_ID(func, vfs_fchmod)
>> +BTF_ID(func, vfs_fchown)
>> +BTF_ID(func, vfs_open)
>> +BTF_ID(func, vfs_setpos)
>> +BTF_ID(func, vfs_llseek)
>> +BTF_ID(func, vfs_read)
>> +BTF_ID(func, vfs_write)
>> +BTF_ID(func, vfs_iocb_iter_read)
>> +BTF_ID(func, vfs_iter_read)
>> +BTF_ID(func, vfs_readv)
>> +BTF_ID(func, vfs_iocb_iter_write)
>> +BTF_ID(func, vfs_iter_write)
>> +BTF_ID(func, vfs_writev)
>> +BTF_ID(func, vfs_copy_file_range)
>> +BTF_ID(func, vfs_getattr_nosec)
>> +BTF_ID(func, vfs_ioctl)
>> +BTF_ID(func, vfs_fsync_range)
>> +BTF_ID(func, vfs_fsync)
>> +BTF_ID(func, vfs_utimes)
>> +BTF_ID(func, vfs_statfs)
>> +BTF_ID(func, vfs_dedupe_file_range_one)
>> +BTF_ID(func, vfs_dedupe_file_range)
>> +BTF_ID(func, vfs_clone_file_range)
>> +BTF_ID(func, vfs_cancel_lock)
>> +BTF_ID(func, vfs_test_lock)
>> +BTF_ID(func, vfs_setlease)
>> +BTF_ID(func, vfs_lock_file)
>> +BTF_ID(func, dentry_open)
>>  BTF_ID(func, filp_close)
>>  BTF_SET_END(btf_allowlist_d_path)
>>
> 
> Before we lend this expanded list of allowed functions, I think we
> should address an issue that comes up from time to time with .BTF_ids.
> Sometimes the referenced function can be changed from global to static
> and get inlined by the compiler, and thus disappears from BTF
> altogether. This will result in kernel build failure causing a lot of
> confusion, because the change might be done by people unfamiliar with
> the BTF_ID() stuff and not even aware of it.
> 

Thanks for the detailed background.
I was able to reproduce this kernel build failure.

> This came up a few times before and it's frustrating for everyone
> involved. Before we proceed with extending the list further, let's
> teach resolve_btfids to warn on such missing function (so that we are
> at least aware) but otherwise ignore it (probably leaving ID as zero,
> but let's also confirm that all the users of BTF_ID() stuff handle
> those zeros correctly).
> 

Do you mean that resolve_btfids should be updated to emit warning messages
instead of aborting the build process ?

>> --
>> 2.25.1
>>
