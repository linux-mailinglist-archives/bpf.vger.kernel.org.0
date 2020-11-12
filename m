Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4C52B11A1
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 23:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgKLWf4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 17:35:56 -0500
Received: from www62.your-server.de ([213.133.104.62]:38464 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgKLWf4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 17:35:56 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kdLC5-0004Xd-Hw; Thu, 12 Nov 2020 23:35:53 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kdLC5-0008M8-AO; Thu, 12 Nov 2020 23:35:53 +0100
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Augment the set of sleepable LSM
 hooks
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
References: <20201112200346.404864-1-kpsingh@chromium.org>
 <20201112200346.404864-2-kpsingh@chromium.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5d22e146-0dd1-2054-c718-fa76f8dfa7b9@iogearbox.net>
Date:   Thu, 12 Nov 2020 23:35:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20201112200346.404864-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25986/Thu Nov 12 14:18:25 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/12/20 9:03 PM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Update the set of sleepable hooks with the ones that do not trigger
> a warning with might_fault() when exercised with the correct kernel
> config options enabled, i.e.
> 
> 	DEBUG_ATOMIC_SLEEP=y
> 	LOCKDEP=y
> 	PROVE_LOCKING=y
> 
> This means that a sleepable LSM eBPF program can be attached to these
> LSM hooks. A new helper method bpf_lsm_is_sleepable_hook is added and
> the set is maintained locally in bpf_lsm.c
> 
> A comment is added about the list of LSM hooks that have been observed
> to be called from softirqs, atomic contexts, or the ones that can
> trigger pagefaults and thus should not be added to this list.
> 
[...]
>   
> +/* The set of hooks which are called without pagefaults disabled and are allowed
> + * to "sleep" and thus can be used for sleeable BPF programs.
> + *
> + * There are some hooks which have been observed to be called from a
> + * non-sleepable context and should not be added to this set:
> + *
> + *  bpf_lsm_bpf_prog_free_security
> + *  bpf_lsm_capable
> + *  bpf_lsm_cred_free
> + *  bpf_lsm_d_instantiate
> + *  bpf_lsm_file_alloc_security
> + *  bpf_lsm_file_mprotect
> + *  bpf_lsm_file_send_sigiotask
> + *  bpf_lsm_inet_conn_request
> + *  bpf_lsm_inet_csk_clone
> + *  bpf_lsm_inode_alloc_security
> + *  bpf_lsm_inode_follow_link
> + *  bpf_lsm_inode_permission
> + *  bpf_lsm_key_permission
> + *  bpf_lsm_locked_down
> + *  bpf_lsm_mmap_addr
> + *  bpf_lsm_perf_event_read
> + *  bpf_lsm_ptrace_access_check
> + *  bpf_lsm_req_classify_flow
> + *  bpf_lsm_sb_free_security
> + *  bpf_lsm_sk_alloc_security
> + *  bpf_lsm_sk_clone_security
> + *  bpf_lsm_sk_free_security
> + *  bpf_lsm_sk_getsecid
> + *  bpf_lsm_socket_sock_rcv_skb
> + *  bpf_lsm_sock_graft
> + *  bpf_lsm_task_free
> + *  bpf_lsm_task_getioprio
> + *  bpf_lsm_task_getscheduler
> + *  bpf_lsm_task_kill
> + *  bpf_lsm_task_setioprio
> + *  bpf_lsm_task_setnice
> + *  bpf_lsm_task_setpgid
> + *  bpf_lsm_task_setrlimit
> + *  bpf_lsm_unix_may_send
> + *  bpf_lsm_unix_stream_connect
> + *  bpf_lsm_vm_enough_memory
> + */

I think this is very useful info. I was wondering whether it would make sense
to annotate these more closely to the code so there's less chance this info
becomes stale? Maybe something like below, not sure ... issue is if you would
just place a cant_sleep() in there it might be wrong since this should just
document that it can be invoked from non-sleepable context but it might not
have to.

diff --git a/security/security.c b/security/security.c
index a28045dc9e7f..7899bf32cdaa 100644
--- a/security/security.c
+++ b/security/security.c
@@ -94,6 +94,11 @@ static __initdata bool debug;
                         pr_info(__VA_ARGS__);                   \
         } while (0)

+/*
+ * Placeholder for now to document that hook implementation cannot sleep
+ * since it could potentially be called from non-sleepable context, too.
+ */
+#define hook_cant_sleep()              do { } while (0)
+
  static bool __init is_enabled(struct lsm_info *lsm)
  {
         if (!lsm->enabled)
@@ -2522,6 +2527,7 @@ void security_bpf_map_free(struct bpf_map *map)
  }
  void security_bpf_prog_free(struct bpf_prog_aux *aux)
  {
+       hook_cant_sleep();
         call_void_hook(bpf_prog_free_security, aux);
  }
  #endif /* CONFIG_BPF_SYSCALL */
