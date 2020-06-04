Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C87F1EEBCF
	for <lists+bpf@lfdr.de>; Thu,  4 Jun 2020 22:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgFDUWz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Jun 2020 16:22:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40774 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgFDUWy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Jun 2020 16:22:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054KM5QR175999;
        Thu, 4 Jun 2020 20:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GRCfKV7NDkj/Wj/+qrLRbiharoeP5ernLFfveyRCe7w=;
 b=dYsRo9nXb/CxBQzP71SdZBoyyHMqTCZxfaFNN29R40ARV0e/NJC7FqlMbOufz3DwRQGM
 TxYb3pU0Vbj3FHQOdGhZ5A4e0s5ewVog+Ygb7ZCjWVWYoX7MGSTkXBUCA1E64DeCnG9l
 BYiqebI+lAVgncJo/eHJws3V19M+wS08REqCxVtnlfdBNdDoT1jOwk2vLdweJ0LMAHKG
 fGaVGHB9PekCySfNu85r5B4KEpSghHm5JdZiZRfLK9x5QRExHkBqSRXhHUr/LnqgF5Q2
 bMohW8FsyPP7/U7Qc5tyQf1dQyLzV1OrSPCk+X2vwFE9Hs/UbUfooi3hhLEElqyDYMiG ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31evvn3g2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 04 Jun 2020 20:22:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 054KE4dY002344;
        Thu, 4 Jun 2020 20:22:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31c25w7ns7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jun 2020 20:22:33 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 054KMSxm016290;
        Thu, 4 Jun 2020 20:22:28 GMT
Received: from [10.175.55.64] (/10.175.55.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Jun 2020 13:22:27 -0700
Subject: WARNING: CPU: 1 PID: 52 at mm/page_alloc.c:4826
 __alloc_pages_nodemask (Re: [PATCH 5/5] sysctl: pass kernel pointers to
 ->proc_handler)
To:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        bpf@vger.kernel.org, Andrey Ignatov <rdna@fb.com>
References: <20200424064338.538313-1-hch@lst.de>
 <20200424064338.538313-6-hch@lst.de>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <1fc7ce08-26a7-59ff-e580-4e6c22554752@oracle.com>
Date:   Thu, 4 Jun 2020 22:22:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424064338.538313-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=2 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006040143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 suspectscore=2
 phishscore=0 clxscore=1011 malwarescore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040144
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


(Trimmed original Ccs due to outgoing email policy.)

Hi,

On 2020-04-24 08:43, Christoph Hellwig wrote:
> Instead of having all the sysctl handlers deal with user pointers, which
> is rather hairy in terms of the BPF interaction, copy the input to and
> from  userspace in common code.  This also means that the strings are
> always NUL-terminated by the common code, making the API a little bit
> safer.
> 
> As most handler just pass through the data to one of the common handlers
> a lot of the changes are mechnical.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Andrey Ignatov <rdna@fb.com>

[snip]
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index b6f5d459b087d..df2143e05c571 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -539,13 +539,13 @@ static struct dentry *proc_sys_lookup(struct inode *dir, struct dentry *dentry,
>   	return err;
>   }
>   
> -static ssize_t proc_sys_call_handler(struct file *filp, void __user *buf,
> +static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
>   		size_t count, loff_t *ppos, int write)
>   {
>   	struct inode *inode = file_inode(filp);
>   	struct ctl_table_header *head = grab_header(inode);
>   	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
> -	void *new_buf = NULL;
> +	void *kbuf;
>   	ssize_t error;
>   
>   	if (IS_ERR(head))
> @@ -564,27 +564,38 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *buf,
>   	if (!table->proc_handler)
>   		goto out;
>   
> -	error = BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write, buf, &count,
> -					   ppos, &new_buf);
> +	if (write) {
> +		kbuf = memdup_user_nul(ubuf, count);
> +		if (IS_ERR(kbuf)) {
> +			error = PTR_ERR(kbuf);
> +			goto out;
> +		}
> +	} else {
> +		error = -ENOMEM;
> +		kbuf = kzalloc(count, GFP_KERNEL);
> +		if (!kbuf)
> +			goto out;
> +	}
> +
> +	error = BPF_CGROUP_RUN_PROG_SYSCTL(head, table, write, &kbuf, &count,
> +					   ppos);
>   	if (error)
> -		goto out;
> +		goto out_free_buf;
>   
>   	/* careful: calling conventions are nasty here */
> -	if (new_buf) {
> -		mm_segment_t old_fs;
> -
> -		old_fs = get_fs();
> -		set_fs(KERNEL_DS);
> -		error = table->proc_handler(table, write, (void __user *)new_buf,
> -					    &count, ppos);
> -		set_fs(old_fs);
> -		kfree(new_buf);
> -	} else {
> -		error = table->proc_handler(table, write, buf, &count, ppos);
> +	error = table->proc_handler(table, write, kbuf, &count, ppos);
> +	if (error)
> +		goto out_free_buf;
> +
> +	if (!write) {
> +		error = -EFAULT;
> +		if (copy_to_user(ubuf, kbuf, count))
> +			goto out_free_buf;
>   	}
>   
> -	if (!error)
> -		error = count;
> +	error = count;
> +out_free_buf:
> +	kfree(kbuf);
>   out:
>   	sysctl_head_finish(head);
>   

This commit in recent linus/master
(32927393dc1ccd60fb2bdc05b9e8e88753761469) causes a regression for me:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 52 at mm/page_alloc.c:4826 
__alloc_pages_nodemask+0x1cd/0x2a0
CPU: 1 PID: 52 Comm: init Not tainted 5.7.0+ #218
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
Ubuntu-1.8.2-1ubuntu1 04/01/2014
RIP: 0010:__alloc_pages_nodemask+0x1cd/0x2a0
Code: 0f 85 26 ff ff ff 65 48 8b 04 25 00 7d 01 00 48 05 88 07 00 00 41 
bd 01 00 00 00 48 89 44 24 08 e9 07 ff ff ff 80 e7 20 75 02 <0f> 0b 45 
31 ed eb 98 44 8b 64 24 18 65 8b 05 d0 25 e9 7e 89 c0 48
RSP: 0018:ffffc900000e7de0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00000000000400c0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000013 RDI: 0000000000040dc0
RBP: 000000007ffff000 R08: ffffffff820276c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc900000e7f08
R13: 0000000000000013 R14: 0000000000000013 R15: ffffffff81c34ce0
FS:  00000000006cf880(0000) GS:ffff88803ed00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004a1dab CR3: 000000003e012002 CR4: 00000000003606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  kmalloc_order+0x16/0x70
  kmalloc_order_trace+0x18/0xa0
  proc_sys_call_handler+0xf7/0x170
  vfs_read+0x98/0x120
  ksys_read+0x5a/0xd0
  do_syscall_64+0x43/0x140
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x43f910
Code: 01 f0 ff ff 0f 83 e0 57 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 
1f 44 00 00 83 3d 19 f2 28 00 00 75 14 b8 00 00 00 00 0f 05 <48> 3d 01 
f0 ff ff 0f 83 b4 57 00 00 c3 48 83 ec 08 e8 4a 39 00 00
RSP: 002b:00007fffffffeaa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043f910
RDX: 0000008000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fffffffed10 R08: 0000000000000000 R09: 00000000006cf880
R10: 00000000006cfb50 R11: 0000000000000246 R12: 0000000000401870
R13: 0000000000401900 R14: 0000000000000000 R15: 0000000000000000
---[ end trace 20146069c1ec4970 ]---

It's easy to reproduce by just doing

     read(open("/proc/sys/vm/swappiness", O_RDONLY), 0, 512UL * 1024 * 
1024 * 1024);

or so. Reverting the commit fixes the issue for me.


Vegard
