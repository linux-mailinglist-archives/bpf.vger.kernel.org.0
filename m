Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0843E0C6E
	for <lists+bpf@lfdr.de>; Thu,  5 Aug 2021 04:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhHEC1k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Aug 2021 22:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhHEC1j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Aug 2021 22:27:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC86C061765
        for <bpf@vger.kernel.org>; Wed,  4 Aug 2021 19:27:25 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso6441515pjo.1
        for <bpf@vger.kernel.org>; Wed, 04 Aug 2021 19:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DC2empD7P4R7Ai+ENTyraVYBRpvRcAsyAbnuoopt9LQ=;
        b=fdwbb6EfdL9EgF7bX+qQWtCC7rSLNx1jth0aTf+F0A6kUgLXc49+M9k0o3l4VrYTkQ
         ipqPLL4Q6iOk71ryoVNMtiHz8gWT79GaGAfz46gPgWnnDzkj8Pre9aGQZuaCKNXw8JUF
         E8CBriVAjiN5TrlBNxFuqQtDbC8uHGE9Z2Deou/EqNnCbK4LwK2Y77fZNZjxpucBVZkc
         wETO1eoaNtXkInVtQxiSinIh3JIEqbX6TpMlbI1OgdXB4cbxnoS1s44ArXyuDJlAlrSr
         AtHMyX70x7KTBfs0UKm6rqKycTk47x9v8ntjUidSHOohe35ADk9Re7gHRY0QCR3dpc02
         038A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DC2empD7P4R7Ai+ENTyraVYBRpvRcAsyAbnuoopt9LQ=;
        b=BHOgV7hnw8vBMSnnhH544Or/6iKOrb+nxelSlcJWUgHPQ/H6svUIyjb4wc6xpYyGnp
         LWZqLAzeHviOSuJyMlEMzS9vkJqm6uD/c1ZNSbCaifRryXZD7ZU17QkcQciPG68lqDyE
         /SQ2g+0hwPcvjWPdMuFjhqFoedBrALMoqTzxPzrwDm0zIjb0BOw8r7UK0sI5+lylM4qY
         oh0X+/Hj53N77RhgknMSYberVFGDtLzIOluQxAuQFvfOLKv2CL+tWlNPt2KqV6oiYS5K
         DnmYAduRIwANDnRgw+csQ+jIs/90emtdNV4K1YxqOpu7V7FWlY2lczWReXsK1FJQVXXJ
         6d7g==
X-Gm-Message-State: AOAM530CC5k0xQ7TlRRVshiZG08k0L8fwdIQ5/Y6mwJqrv3NpdYtYP1f
        lvRIRXwQQBchDd0FNlVHUMA=
X-Google-Smtp-Source: ABdhPJx6wbFJB+ONG1Hz7RbCcImCyf5UWw4GsdVB+9yOTKfJHfQGsVSnUFg+pyQ6yUiFDfTmM0+qKw==
X-Received: by 2002:a17:90a:b009:: with SMTP id x9mr2172288pjq.55.1628130445218;
        Wed, 04 Aug 2021 19:27:25 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.117])
        by smtp.gmail.com with ESMTPSA id f4sm5189577pgi.68.2021.08.04.19.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 19:27:24 -0700 (PDT)
Subject: Re: [PATCH bpf-next v5 2/2] bpf: expose bpf_d_path helper to vfs_*
 and security_* functions
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Yaniv Agman <yanivagman@gmail.com>,
        KP Singh <kpsingh@kernel.org>
References: <20210727132532.2473636-1-hengqi.chen@gmail.com>
 <20210727132532.2473636-3-hengqi.chen@gmail.com>
 <ff963256-ea65-b8ba-05d0-fba3b03843d0@iogearbox.net>
 <CAEf4BzZqvVVTRjoe2h9LyrYKwH=JwbEnzOWzBqnNCVLJfbeuYA@mail.gmail.com>
From:   Hengqi Chen <hengqi.chen@gmail.com>
Message-ID: <3d5ff184-da35-2d1a-df1d-f4b274655c5f@gmail.com>
Date:   Thu, 5 Aug 2021 10:27:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZqvVVTRjoe2h9LyrYKwH=JwbEnzOWzBqnNCVLJfbeuYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/8/5 6:44 AM, Andrii Nakryiko wrote:
> On Wed, Aug 4, 2021 at 3:35 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 7/27/21 3:25 PM, Hengqi Chen wrote:
>>> Add vfs_* and security_* to bpf_d_path allowlist, so that we can use
>>> bpf_d_path helper to extract full file path from these functions' arguments.
>>> This will help tools like BCC's filetop[1]/filelife to get full file path.
>>>
>>> [1] https://github.com/iovisor/bcc/issues/3527
>>>
>>> Acked-by: Yonghong Song <yhs@fb.com>
>>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>>> ---
>>>   kernel/trace/bpf_trace.c | 60 +++++++++++++++++++++++++++++++++++++---
>>>   1 file changed, 56 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>> index c5e0b6a64091..e7b24abcf3bf 100644
>>> --- a/kernel/trace/bpf_trace.c
>>> +++ b/kernel/trace/bpf_trace.c
>>> @@ -849,18 +849,70 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
>>>
>>>   BTF_SET_START(btf_allowlist_d_path)
>>>   #ifdef CONFIG_SECURITY
>>> +BTF_ID(func, security_bprm_check)
>>> +BTF_ID(func, security_bprm_committed_creds)
>>> +BTF_ID(func, security_bprm_committing_creds)
>>> +BTF_ID(func, security_bprm_creds_for_exec)
>>> +BTF_ID(func, security_bprm_creds_from_file)
>>> +BTF_ID(func, security_file_alloc)
>>
>> Did you actually try these out, e.g. attaching BPF progs invoking bpf_d_path() to all
>> these, then generate some workload like kernel build for testing?
>>
>> I presume not, since something like security_file_alloc() would crash the kernel. Right
>> before it's called in __alloc_file() we fetch a struct file from kmemcache, and only
>> populate f->f_cred there. Most LSMs, for example, only populate their secblob through the
>> callback. If you call bpf_d_path(&file->f_path, ...) with it, you'll crash in d_path()
>> when path->dentry->d_op is checked.. given f->f_path is all zeroed structure at that
>> point.
>>
>> Please do your due diligence and invest each of them manually, maybe the best way is
>> to hack up small selftests for each enabled function that our CI can test run? Bit of a
>> one-time effort, but at least it ensures that those additions are sane & checked.
> 
> I think it's actually a pretty fun exercise and a good selftest to
> have. We can have a selftest which will attach a simple BPF program
> just to grab a contents of btf_allowlist_d_path (with typeless ksyms,
> for instance). Then for each BTF ID in there, as a subtest, attach
> another BPF object with fentry BPF program doing something with
> d_path.
> 
> Hengqi, you'd need to have few variants for each possible position of
> file or path struct (e.g., file as first arg; as second arg; etc, same
> for hooks working with path directly), but I don't think that's going
> to be a lot of them.
> 
> So as Daniel said, a bit of a work, but we'll have a much better
> confidence that we are not accidentally opening a big kernel crashing
> loophole.
> 

Thanks for the review and suggestions.

Will test them locally and add selftest for these changes.

>>
>>> +BTF_ID(func, security_file_fcntl)
>>> +BTF_ID(func, security_file_free)
>>> +BTF_ID(func, security_file_ioctl)
>>> +BTF_ID(func, security_file_lock)
>>> +BTF_ID(func, security_file_open)
>>>   BTF_ID(func, security_file_permission)
>>> +BTF_ID(func, security_file_receive)
>>> +BTF_ID(func, security_file_set_fowner)
>>>   BTF_ID(func, security_inode_getattr)
>>> -BTF_ID(func, security_file_open)
>>> +BTF_ID(func, security_sb_mount)
>>>   #endif
>>>   #ifdef CONFIG_SECURITY_PATH
>>> +BTF_ID(func, security_path_chmod)
>>> +BTF_ID(func, security_path_chown)
>>> +BTF_ID(func, security_path_chroot)
>>> +BTF_ID(func, security_path_link)
>>> +BTF_ID(func, security_path_mkdir)
>>> +BTF_ID(func, security_path_mknod)
>>> +BTF_ID(func, security_path_notify)
>>> +BTF_ID(func, security_path_rename)
>>> +BTF_ID(func, security_path_rmdir)
>>> +BTF_ID(func, security_path_symlink)
>>>   BTF_ID(func, security_path_truncate)
>>> +BTF_ID(func, security_path_unlink)
>>>   #endif
>>> -BTF_ID(func, vfs_truncate)
>>> -BTF_ID(func, vfs_fallocate)
>>>   BTF_ID(func, dentry_open)
>>> -BTF_ID(func, vfs_getattr)
>>>   BTF_ID(func, filp_close)
>>> +BTF_ID(func, vfs_cancel_lock)
>>> +BTF_ID(func, vfs_clone_file_range)
>>> +BTF_ID(func, vfs_copy_file_range)
>>> +BTF_ID(func, vfs_dedupe_file_range)
>>> +BTF_ID(func, vfs_dedupe_file_range_one)
>>> +BTF_ID(func, vfs_fadvise)
>>> +BTF_ID(func, vfs_fallocate)
>>> +BTF_ID(func, vfs_fchmod)
>>> +BTF_ID(func, vfs_fchown)
>>> +BTF_ID(func, vfs_fsync)
>>> +BTF_ID(func, vfs_fsync_range)
>>> +BTF_ID(func, vfs_getattr)
>>> +BTF_ID(func, vfs_getattr_nosec)
>>> +BTF_ID(func, vfs_iocb_iter_read)
>>> +BTF_ID(func, vfs_iocb_iter_write)
>>> +BTF_ID(func, vfs_ioctl)
>>> +BTF_ID(func, vfs_iter_read)
>>> +BTF_ID(func, vfs_iter_write)
>>> +BTF_ID(func, vfs_llseek)
>>> +BTF_ID(func, vfs_lock_file)
>>> +BTF_ID(func, vfs_open)
>>> +BTF_ID(func, vfs_read)
>>> +BTF_ID(func, vfs_readv)
>>> +BTF_ID(func, vfs_setlease)
>>> +BTF_ID(func, vfs_setpos)
>>> +BTF_ID(func, vfs_statfs)
>>> +BTF_ID(func, vfs_test_lock)
>>> +BTF_ID(func, vfs_truncate)
>>> +BTF_ID(func, vfs_utimes)
>>> +BTF_ID(func, vfs_write)
>>> +BTF_ID(func, vfs_writev)
>>>   BTF_SET_END(btf_allowlist_d_path)
>>>
>>>   static bool bpf_d_path_allowed(const struct bpf_prog *prog)
>>>
>>
