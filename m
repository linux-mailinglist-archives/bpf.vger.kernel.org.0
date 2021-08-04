Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A263E0A75
	for <lists+bpf@lfdr.de>; Thu,  5 Aug 2021 00:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhHDWfQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Aug 2021 18:35:16 -0400
Received: from www62.your-server.de ([213.133.104.62]:45242 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhHDWfQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Aug 2021 18:35:16 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mBPTZ-000Flc-LQ; Thu, 05 Aug 2021 00:35:01 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mBPTZ-000LaK-Dc; Thu, 05 Aug 2021 00:35:01 +0200
Subject: Re: [PATCH bpf-next v5 2/2] bpf: expose bpf_d_path helper to vfs_*
 and security_* functions
To:     Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, jolsa@kernel.org, yanivagman@gmail.com,
        kpsingh@kernel.org
References: <20210727132532.2473636-1-hengqi.chen@gmail.com>
 <20210727132532.2473636-3-hengqi.chen@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ff963256-ea65-b8ba-05d0-fba3b03843d0@iogearbox.net>
Date:   Thu, 5 Aug 2021 00:35:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210727132532.2473636-3-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26253/Wed Aug  4 10:20:49 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/27/21 3:25 PM, Hengqi Chen wrote:
> Add vfs_* and security_* to bpf_d_path allowlist, so that we can use
> bpf_d_path helper to extract full file path from these functions' arguments.
> This will help tools like BCC's filetop[1]/filelife to get full file path.
> 
> [1] https://github.com/iovisor/bcc/issues/3527
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>   kernel/trace/bpf_trace.c | 60 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 56 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index c5e0b6a64091..e7b24abcf3bf 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -849,18 +849,70 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
>   
>   BTF_SET_START(btf_allowlist_d_path)
>   #ifdef CONFIG_SECURITY
> +BTF_ID(func, security_bprm_check)
> +BTF_ID(func, security_bprm_committed_creds)
> +BTF_ID(func, security_bprm_committing_creds)
> +BTF_ID(func, security_bprm_creds_for_exec)
> +BTF_ID(func, security_bprm_creds_from_file)
> +BTF_ID(func, security_file_alloc)

Did you actually try these out, e.g. attaching BPF progs invoking bpf_d_path() to all
these, then generate some workload like kernel build for testing?

I presume not, since something like security_file_alloc() would crash the kernel. Right
before it's called in __alloc_file() we fetch a struct file from kmemcache, and only
populate f->f_cred there. Most LSMs, for example, only populate their secblob through the
callback. If you call bpf_d_path(&file->f_path, ...) with it, you'll crash in d_path()
when path->dentry->d_op is checked.. given f->f_path is all zeroed structure at that
point.

Please do your due diligence and invest each of them manually, maybe the best way is
to hack up small selftests for each enabled function that our CI can test run? Bit of a
one-time effort, but at least it ensures that those additions are sane & checked.

> +BTF_ID(func, security_file_fcntl)
> +BTF_ID(func, security_file_free)
> +BTF_ID(func, security_file_ioctl)
> +BTF_ID(func, security_file_lock)
> +BTF_ID(func, security_file_open)
>   BTF_ID(func, security_file_permission)
> +BTF_ID(func, security_file_receive)
> +BTF_ID(func, security_file_set_fowner)
>   BTF_ID(func, security_inode_getattr)
> -BTF_ID(func, security_file_open)
> +BTF_ID(func, security_sb_mount)
>   #endif
>   #ifdef CONFIG_SECURITY_PATH
> +BTF_ID(func, security_path_chmod)
> +BTF_ID(func, security_path_chown)
> +BTF_ID(func, security_path_chroot)
> +BTF_ID(func, security_path_link)
> +BTF_ID(func, security_path_mkdir)
> +BTF_ID(func, security_path_mknod)
> +BTF_ID(func, security_path_notify)
> +BTF_ID(func, security_path_rename)
> +BTF_ID(func, security_path_rmdir)
> +BTF_ID(func, security_path_symlink)
>   BTF_ID(func, security_path_truncate)
> +BTF_ID(func, security_path_unlink)
>   #endif
> -BTF_ID(func, vfs_truncate)
> -BTF_ID(func, vfs_fallocate)
>   BTF_ID(func, dentry_open)
> -BTF_ID(func, vfs_getattr)
>   BTF_ID(func, filp_close)
> +BTF_ID(func, vfs_cancel_lock)
> +BTF_ID(func, vfs_clone_file_range)
> +BTF_ID(func, vfs_copy_file_range)
> +BTF_ID(func, vfs_dedupe_file_range)
> +BTF_ID(func, vfs_dedupe_file_range_one)
> +BTF_ID(func, vfs_fadvise)
> +BTF_ID(func, vfs_fallocate)
> +BTF_ID(func, vfs_fchmod)
> +BTF_ID(func, vfs_fchown)
> +BTF_ID(func, vfs_fsync)
> +BTF_ID(func, vfs_fsync_range)
> +BTF_ID(func, vfs_getattr)
> +BTF_ID(func, vfs_getattr_nosec)
> +BTF_ID(func, vfs_iocb_iter_read)
> +BTF_ID(func, vfs_iocb_iter_write)
> +BTF_ID(func, vfs_ioctl)
> +BTF_ID(func, vfs_iter_read)
> +BTF_ID(func, vfs_iter_write)
> +BTF_ID(func, vfs_llseek)
> +BTF_ID(func, vfs_lock_file)
> +BTF_ID(func, vfs_open)
> +BTF_ID(func, vfs_read)
> +BTF_ID(func, vfs_readv)
> +BTF_ID(func, vfs_setlease)
> +BTF_ID(func, vfs_setpos)
> +BTF_ID(func, vfs_statfs)
> +BTF_ID(func, vfs_test_lock)
> +BTF_ID(func, vfs_truncate)
> +BTF_ID(func, vfs_utimes)
> +BTF_ID(func, vfs_write)
> +BTF_ID(func, vfs_writev)
>   BTF_SET_END(btf_allowlist_d_path)
>   
>   static bool bpf_d_path_allowed(const struct bpf_prog *prog)
> 

