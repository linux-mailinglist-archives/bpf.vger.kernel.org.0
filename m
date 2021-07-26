Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374113D53BC
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 09:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhGZGf5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 02:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhGZGf4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Jul 2021 02:35:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D4BC061757
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 00:16:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so18390442pja.5
        for <bpf@vger.kernel.org>; Mon, 26 Jul 2021 00:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=18VgRJLcXMbMeTRcXljqhuDhjPm5NFNSqBV3zVlrLRM=;
        b=CL5XEeo6+1ErA0ObG8mX8QbMEv7j2+EumP1CHn7Zoq8UWyIfZpuQ2UUI1rO2kHT9X3
         UygjECO99dD6FghSAIuqfmXmvr3mBFhhWJW0WmtYS1g0g1aWmWcb1QvV6UKH2vbIT/pM
         Na8SwlNVkEN+keSiONvbqg2Fa/EuURsKj9LrwHNkW0Ux8f0EASaZy2wfvxUHqhWs6hGb
         U4chvhymFh7nHWOcHswAz/Be0CuDrlVI0ULXp8mZRcAZwENPt/tttyGrMsG7Q0wJKMj1
         3nmiAyGCYq6RbXpGCwvZMGHkiUutpBP/pDLWzCLzto86SJKkpl8m3iWU9enG3Q+YU3eI
         HXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=18VgRJLcXMbMeTRcXljqhuDhjPm5NFNSqBV3zVlrLRM=;
        b=BBmNOg5wauvcnmGwLZp1L24klXrwM/C+NNGBcbakEGeWBnYvOvB9IHCTEBQJFsOKrf
         h9ioXEC7V5xRrsl/eSycALpdKCGWexuwBsoA48vqHnllgGpViO2IPhqEgaQ+HXWTT8zg
         fTEkBRvy89nWtYUCqhTbvsnxdLYnnSOZyn/RKSxUY6AYM2UZJTEzTHZtmYyPhBXgoHJm
         flXpcNJ3+0gyjLhAR5KlWiCmwKYim189NkbKYcF2/ZxPiG2mAluLUw232HbQEpig33c6
         uVokgNibcTSpHAh1pum8kh3CYNcT6ZiC8l4WvYQQOAhIXxbv5VRR9JXQBWRfpWHFE53D
         9e2w==
X-Gm-Message-State: AOAM530DJ/aQhUPnWtmHPFJPSsLK1lrWL77Rh0RVgiAOBV3hMnJn4vye
        r7Hgo5YKGRuUbt0vplr5tyI=
X-Google-Smtp-Source: ABdhPJxo4x4P7OF2bEWlbyuALkK56ZLr3c26jQxQ+WLKn2qBCc7F4Cilbp3ouczb6z6Ot4Dp92JSAQ==
X-Received: by 2002:a63:e046:: with SMTP id n6mr16892528pgj.15.1627283785726;
        Mon, 26 Jul 2021 00:16:25 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.119])
        by smtp.gmail.com with ESMTPSA id bk16sm34922017pjb.54.2021.07.26.00.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 00:16:25 -0700 (PDT)
Subject: Re: [PATCH bpf-next 2/2] bpf: expose bpf_d_path helper to vfs_* and
 security_* functions
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        john.fastabend@gmail.com, jolsa@kernel.org, yanivagman@gmail.com
References: <20210725141814.2000828-1-hengqi.chen@gmail.com>
 <20210725141814.2000828-3-hengqi.chen@gmail.com>
 <3bfc8755-bd34-2ff1-698f-57ad046726c2@fb.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <78894c4d-31e3-f200-b3ea-18371fa98cf6@gmail.com>
Date:   Mon, 26 Jul 2021 15:16:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <3bfc8755-bd34-2ff1-698f-57ad046726c2@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/7/26 2:20 PM, Yonghong Song wrote:
> 
> 
> On 7/25/21 7:18 AM, Hengqi Chen wrote:
>> Add vfs_* and security_* to bpf_d_path allowlist, so that we can use
>> bpf_d_path helper to extract full file path from these functions'
>> `struct path *` and `struct file *` arguments. This will help tools
>> like IOVisor's filetop[2]/filelife to get full file path.
> 
> Please use bcc intead of IOVisor.
> What is "[2]" in "filetop[2]"?

OK. Some links are missed in the commit messages 
and version number is not added to subject.

> 
>>
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> 
> LGTM with minor comments below.
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> 
>> ---
>>   kernel/trace/bpf_trace.c | 52 ++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 50 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index c5e0b6a64091..355777b5bf63 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -850,16 +850,64 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
>>   BTF_SET_START(btf_allowlist_d_path)
>>   #ifdef CONFIG_SECURITY
>>   BTF_ID(func, security_file_permission)
>> -BTF_ID(func, security_inode_getattr)
>>   BTF_ID(func, security_file_open)
>> +BTF_ID(func, security_file_ioctl)
>> +BTF_ID(func, security_file_free)
>> +BTF_ID(func, security_file_alloc)
>> +BTF_ID(func, security_file_lock)
>> +BTF_ID(func, security_file_fcntl)
>> +BTF_ID(func, security_file_set_fowner)
>> +BTF_ID(func, security_file_receive)
>> +BTF_ID(func, security_inode_getattr)
>> +BTF_ID(func, security_sb_mount)
>> +BTF_ID(func, security_bprm_check)
> 
> Here and also below "segments" (security_path_* functions, and
> later vfs_*/dentry_open/filp_close functions),
> maybe you can list functions with increasing alphabet order.
> This will make it easy to check whether a particular function
> exists or not and whether we miss anything.
> 
> There are more security_bprm_* functions, e.g.,
> security_bprm_creds_from_file, security_bprm_committing_creds
> and security_bprm_committed_creds.
> These functions all have "struct linux_binprm *bprm"
> parameters. Maybe we can add these few functions as well
> in this round.
> 

Thanks. Will send a v4 for review.

>>   #endif
>>   #ifdef CONFIG_SECURITY_PATH
>>   BTF_ID(func, security_path_truncate)
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
>>   #endif
>>   BTF_ID(func, vfs_truncate)
>>   BTF_ID(func, vfs_fallocate)
>> -BTF_ID(func, dentry_open)
>>   BTF_ID(func, vfs_getattr)
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
> 
> I double checked that for the above three lock
> related functions (vfs_cancel_lock, vfs_test_lock,
> vfs_lock_file), I double checked d_path
> does not use these locks, so we should be fine.
> 
>> +BTF_ID(func, dentry_open)
>>   BTF_ID(func, filp_close)
>>   BTF_SET_END(btf_allowlist_d_path)
>>
>> -- 
>> 2.25.1
>>
