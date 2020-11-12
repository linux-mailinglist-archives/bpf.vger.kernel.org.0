Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BC82B0CF4
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 19:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKLSsz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 13:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgKLSsy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 13:48:54 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51239C0613D1;
        Thu, 12 Nov 2020 10:48:54 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 2so6292518ybc.12;
        Thu, 12 Nov 2020 10:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/LSpoK4pF1N1+aP0XtCo5Ki3nIgahuAJyPwcfQ2DDA=;
        b=iWylZhtM3mLGYX+u/virHX72znt6VYnfX/oCsvxHtoOQGJINCcIuCOQ+cCoRP3ltzf
         2cfkZ5tNIBBlLbfzrHv1RXVw6Mz/4D80AB4fTS57XM49A3brQQKVgvXeZRBEm7OczaaR
         xdZ3ZmbgPn4nE2fkt7gXMmzRh2cBG/Hw0LVwumAsX2KxkTmYNQx1pXIbcvk8EJr2OX8S
         us3kd+r5fajUcYuwq3p1189uhj65JlRZgv8mU+yzbUJpEbWIRyW0dncw9FX2n4saJhT4
         9y57c0znVy9+uxBmgjaVy5l6gUsw6wJE55bMp9XCHgU4Ia2A81+0hUq6w81rRkXJ4IFV
         kTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/LSpoK4pF1N1+aP0XtCo5Ki3nIgahuAJyPwcfQ2DDA=;
        b=EQAnJ90k9dsbQ0nhA98o96D3Hzp3EKeni8HOGVxLqycLqSl8nck20BKia+Rxm44YYR
         WiSwIt9Y8cnzxGc63VDYbTJTh8eyA+abvDsGtwtHteFCa7QJj+JRPZwoQYmNwBBEHwq7
         PLD2ZYbbWPMkaKSxp04WwIC5NeNMLg8MSiqCzjj/8ftiMy6XLSrzY2Zlo6tDhsYX5kHJ
         WO70394PmLQJviIV39OKsRB8FgLDMFMEAYzaUUenGXeDvdvx6JJCjeYT5gc5hpvX5jMC
         pfofiFGrlqNRTGOKsCaT/BOiyiBDk/HGrSKEEb5YcBUQFi8nwPD057G0qrUCUviCJDMi
         ZGWQ==
X-Gm-Message-State: AOAM531x4FeK0paDCM4jSZH/AopfjPTetRXU+u8su7aAQb2vBrb5JLhZ
        cgyNz+NIXg1Zgq+zORmnOBYt5sd/rcVbkde+F50=
X-Google-Smtp-Source: ABdhPJy2gsbOngrUjH8vGxp5DtVXTWhELUQDt9v8jenfp68RdrujtAPy98vpBLuCOtIH09mEO0fQrQ+wOy/OS7n1Ssg=
X-Received: by 2002:a25:7717:: with SMTP id s23mr1121427ybc.459.1605206933429;
 Thu, 12 Nov 2020 10:48:53 -0800 (PST)
MIME-Version: 1.0
References: <20201112171907.373433-1-kpsingh@chromium.org>
In-Reply-To: <20201112171907.373433-1-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 Nov 2020 10:48:42 -0800
Message-ID: <CAEf4BzZNg98qBmddzmw_HnzhqKJSJxEvAkfcFjz9hB8STaxvfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Augment the set of sleepable LSM hooks
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 9:20 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Update the set of sleepable hooks with the ones that do not trigger
> a warning with might_fault() when exercised with the correct kernel
> config options enabled, i.e.
>
>         DEBUG_ATOMIC_SLEEP=y
>         LOCKDEP=y
>         PROVE_LOCKING=y
>
> This means that a sleepable LSM eBPF prorgam can be attached to these

typo: program

> LSM hooks. A new helper method bpf_lsm_is_sleepable_hook is added and
> the set is maintained locally in bpf_lsm.c
>
> A comment is added about the list of LSM hooks that have been observed
> to be called from softirqs, atomic contexts, or the ones that can
> trigger pagefaults and thus should not be added to this list.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  include/linux/bpf_lsm.h |   7 +++
>  kernel/bpf/bpf_lsm.c    | 120 ++++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c   |  16 +-----
>  3 files changed, 128 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> index 73226181b744..0d1c33ace398 100644
> --- a/include/linux/bpf_lsm.h
> +++ b/include/linux/bpf_lsm.h
> @@ -27,6 +27,8 @@ extern struct lsm_blob_sizes bpf_lsm_blob_sizes;
>  int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>                         const struct bpf_prog *prog);
>
> +bool bpf_lsm_is_sleepable_hook(u32 btf_id);
> +
>  static inline struct bpf_storage_blob *bpf_inode(
>         const struct inode *inode)
>  {
> @@ -54,6 +56,11 @@ void bpf_task_storage_free(struct task_struct *task);
>
>  #else /* !CONFIG_BPF_LSM */
>
> +static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
> +{
> +       return false;
> +}
> +
>  static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>                                       const struct bpf_prog *prog)
>  {
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index e92c51bebb47..3a6e927485c2 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -13,6 +13,7 @@
>  #include <linux/bpf_verifier.h>
>  #include <net/bpf_sk_storage.h>
>  #include <linux/bpf_local_storage.h>
> +#include <linux/btf_ids.h>
>
>  /* For every LSM hook that allows attachment of BPF programs, declare a nop
>   * function where a BPF program can be attached.
> @@ -72,6 +73,125 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>         }
>  }
>
> +/* The set of hooks which are called without pagefaults disabled and are allowed
> + * to "sleep and thus can be used for sleeable BPF programs.

typo: "sleep" (both quotes) or no quotes at all?

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
> +BTF_SET_START(sleepable_lsm_hooks)BTF_ID(func, bpf_lsm_bpf)

something is off here

> +BTF_ID(func, bpf_lsm_bpf_map)
> +BTF_ID(func, bpf_lsm_bpf_map_alloc_security)
> +BTF_ID(func, bpf_lsm_bpf_map_free_security)
> +BTF_ID(func, bpf_lsm_bpf_prog)

[...]
