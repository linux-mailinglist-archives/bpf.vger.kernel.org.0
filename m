Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4F233DF8F
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 21:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhCPUvm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 16:51:42 -0400
Received: from www62.your-server.de ([213.133.104.62]:57708 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhCPUvR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 16:51:17 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lMGek-000CJR-NX; Tue, 16 Mar 2021 21:51:10 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lMGek-000UAH-Gk; Tue, 16 Mar 2021 21:51:10 +0100
Subject: Re: [PATCH v2] bpf: Fix memory leak in copy_process()
To:     qiang.zhang@windriver.com, ast@kernel.org, andrii@kernel.org
Cc:     dvyukov@google.com, linux-kernel@vger.kernel.org,
        syzbot+44908bb56d2bfe56b28e@syzkaller.appspotmail.com,
        bpf@vger.kernel.org
References: <20210315085816.21413-1-qiang.zhang@windriver.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b29757e1-c7a2-dee9-bfa2-587407cadf50@iogearbox.net>
Date:   Tue, 16 Mar 2021 21:51:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210315085816.21413-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26110/Tue Mar 16 12:05:23 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/15/21 9:58 AM, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>

nit: I presume it should be s/Zqiang/Qiang Zhang/ as real name for 'From'
instead of abbreviation?

> The syzbot report a memleak follow:
> BUG: memory leak
> unreferenced object 0xffff888101b41d00 (size 120):
>    comm "kworker/u4:0", pid 8, jiffies 4294944270 (age 12.780s)
>    backtrace:
>      [<ffffffff8125dc56>] alloc_pid+0x66/0x560
>      [<ffffffff81226405>] copy_process+0x1465/0x25e0
>      [<ffffffff81227943>] kernel_clone+0xf3/0x670
>      [<ffffffff812281a1>] kernel_thread+0x61/0x80
>      [<ffffffff81253464>] call_usermodehelper_exec_work
>      [<ffffffff81253464>] call_usermodehelper_exec_work+0xc4/0x120
>      [<ffffffff812591c9>] process_one_work+0x2c9/0x600
>      [<ffffffff81259ab9>] worker_thread+0x59/0x5d0
>      [<ffffffff812611c8>] kthread+0x178/0x1b0
>      [<ffffffff8100227f>] ret_from_fork+0x1f/0x30
> 
> unreferenced object 0xffff888110ef5c00 (size 232):
>    comm "kworker/u4:0", pid 8414, jiffies 4294944270 (age 12.780s)
>    backtrace:
>      [<ffffffff8154a0cf>] kmem_cache_zalloc
>      [<ffffffff8154a0cf>] __alloc_file+0x1f/0xf0
>      [<ffffffff8154a809>] alloc_empty_file+0x69/0x120
>      [<ffffffff8154a8f3>] alloc_file+0x33/0x1b0
>      [<ffffffff8154ab22>] alloc_file_pseudo+0xb2/0x140
>      [<ffffffff81559218>] create_pipe_files+0x138/0x2e0
>      [<ffffffff8126c793>] umd_setup+0x33/0x220
>      [<ffffffff81253574>] call_usermodehelper_exec_async+0xb4/0x1b0
>      [<ffffffff8100227f>] ret_from_fork+0x1f/0x30
> 
> after the UMD process exits, the pipe_to_umh/pipe_from_umh and tgid
> need to be release.
> 
> Fixes: d71fa5c9763c ("bpf: Add kernel module with user mode driver that populates bpffs.")
> Reported-by: syzbot+44908bb56d2bfe56b28e@syzkaller.appspotmail.com
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>

nit: Ditto

> ---
>   v1->v2:
>   Judge whether the pointer variable tgid is valid.
> 
>   kernel/bpf/preload/bpf_preload_kern.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
> index 79c5772465f1..5009875f01d3 100644
> --- a/kernel/bpf/preload/bpf_preload_kern.c
> +++ b/kernel/bpf/preload/bpf_preload_kern.c
> @@ -4,6 +4,7 @@
>   #include <linux/module.h>
>   #include <linux/pid.h>
>   #include <linux/fs.h>
> +#include <linux/file.h>
>   #include <linux/sched/signal.h>
>   #include "bpf_preload.h"
>   
> @@ -20,6 +21,14 @@ static struct bpf_preload_ops umd_ops = {
>   	.owner = THIS_MODULE,
>   };
>   
> +static void bpf_preload_umh_cleanup(struct umd_info *info)
> +{
> +	fput(info->pipe_to_umh);
> +	fput(info->pipe_from_umh);
> +	put_pid(info->tgid);
> +	info->tgid = NULL;
> +}

The above is pretty much a reimplementation of ...

static void umd_cleanup(struct subprocess_info *info)
{
         struct umd_info *umd_info = info->data;

         /* cleanup if umh_setup() was successful but exec failed */
         if (info->retval) {
                 fput(umd_info->pipe_to_umh);
                 fput(umd_info->pipe_from_umh);
                 put_pid(umd_info->tgid);
                 umd_info->tgid = NULL;
         }
}

... so if there are ever changes to umd_cleanup() for additional resource
cleanup, we'd be missing those easily in bpf_preload_umh_cleanup(). I'd
suggest to refactor a common helper inside kernel/usermode_driver.c that
is then exported as symbol which the driver here can use.

>   static int preload(struct bpf_preload_info *obj)
>   {
>   	int magic = BPF_PRELOAD_START;
> @@ -61,8 +70,10 @@ static int finish(void)
>   	if (n != sizeof(magic))
>   		return -EPIPE;
>   	tgid = umd_ops.info.tgid;
> -	wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
> -	umd_ops.info.tgid = NULL;
> +	if (tgid) {
> +		wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
> +		bpf_preload_umh_cleanup(&umd_ops.info);
> +	}
>   	return 0;
>   }
>   
> @@ -80,10 +91,15 @@ static int __init load_umd(void)
>   
>   static void __exit fini_umd(void)
>   {
> +	struct pid *tgid;
>   	bpf_preload_ops = NULL;
>   	/* kill UMD in case it's still there due to earlier error */
> -	kill_pid(umd_ops.info.tgid, SIGKILL, 1);
> -	umd_ops.info.tgid = NULL;
> +	tgid = umd_ops.info.tgid;
> +	if (tgid) {
> +		kill_pid(tgid, SIGKILL, 1);
> +		wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
> +		bpf_preload_umh_cleanup(&umd_ops.info);
> +	}
>   	umd_unload_blob(&umd_ops.info);
>   }
>   late_initcall(load_umd);
> 

