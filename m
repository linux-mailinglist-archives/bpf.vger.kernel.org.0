Return-Path: <bpf+bounces-15050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0C37EAD05
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 10:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D9B280D61
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 09:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D6F168B2;
	Tue, 14 Nov 2023 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmCbmY/V"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9983716412
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 09:29:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8C818A
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 01:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699954150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUjxNWdG0lSZUSSraNIWPaaAKKodUffDFLVZx2tK6Lk=;
	b=NmCbmY/V6Ly2I3932hN9ClasEq5Aab0Jj4DpiT2wImxo5SvX6eHf6uD2XrHT0rt37YNUfu
	yS5vZyioprLkq+KPChQU2DsiGW4t4tEqHeOcUjjPfoWOeT4XUZ6Lxo6IuBQeV6iAE4nzms
	QbPvSBMrLl1amTZ9iW5YGxeYnBu+CAg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-MhiqR7NfNNqt0fez2QO9Yg-1; Tue,
 14 Nov 2023 04:29:07 -0500
X-MC-Unique: MhiqR7NfNNqt0fez2QO9Yg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C13429AA3AD;
	Tue, 14 Nov 2023 09:29:06 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.32])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B76A1C060B5;
	Tue, 14 Nov 2023 09:29:04 +0000 (UTC)
Date: Tue, 14 Nov 2023 10:29:03 +0100
From: Artem Savkov <asavkov@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>,
	John Johansen <john.johansen@canonical.com>, audit@vger.kernel.org,
	Andreas Steinmetz <anstein99@googlemail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH v2] audit: don't take task_lock() in audit_exe_compare()
 code path
Message-ID: <20231114092903.GA590929@alecto.usersys.redhat.com>
References: <20231024161432.97029-2-paul@paul-moore.com>
 <a5650045-164f-4bff-b688-ddbc66dc95c4@canonical.com>
 <CAHC9VhR-5uK=D0r3zDDsHegjiEqEuhsBhBqLTZ7Xm2PPup64oA@mail.gmail.com>
 <CAGudoHEAes9Avq4EKqNCFwKd_AQPhQE4v6Z3LYCZasJqQXKtjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEAes9Avq4EKqNCFwKd_AQPhQE4v6Z3LYCZasJqQXKtjA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Tue, Oct 24, 2023 at 07:59:18PM +0200, Mateusz Guzik wrote:
> On 10/24/23, Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Oct 24, 2023 at 12:47 PM John Johansen
> > <john.johansen@canonical.com> wrote:
> >> On 10/24/23 09:14, Paul Moore wrote:
> >> > The get_task_exe_file() function locks the given task with task_lock()
> >> > which when used inside audit_exe_compare() can cause deadlocks on
> >> > systems that generate audit records when the task_lock() is held. We
> >> > resolve this problem with two changes: ignoring those cases where the
> >> > task being audited is not the current task, and changing our approach
> >> > to obtaining the executable file struct to not require task_lock().
> >> >
> >> > With the intent of the audit exe filter being to filter on audit events
> >> > generated by processes started by the specified executable, it makes
> >> > sense that we would only want to use the exe filter on audit records
> >> > associated with the currently executing process, e.g. @current.  If
> >> > we are asked to filter records using a non-@current task_struct we can
> >> > safely ignore the exe filter without negatively impacting the admin's
> >> > expectations for the exe filter.
> >> >
> >> > Knowing that we only have to worry about filtering the currently
> >> > executing task in audit_exe_compare() we can do away with the
> >> > task_lock() and call get_mm_exe_file() with @current->mm directly.
> >> >
> >> > Cc: <stable@vger.kernel.org>
> >> > Fixes: 5efc244346f9 ("audit: fix exe_file access in audit_exe_compare")
> >> > Reported-by: Andreas Steinmetz <anstein99@googlemail.com>
> >> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>
> >> looks good to me
> >> Reviewed-by: John Johansen <john.johanse@canonical.com>
> >>
> >> > ---
> >> > - v2
> >> > * dropped mmget()/mmput()
> >> >
> >> > - v1
> >> > * initial revision
> >> > ---
> >> >   kernel/audit_watch.c | 7 ++++++-
> >> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> >> > index 65075f1e4ac8..99da4ee8e597 100644
> >> > --- a/kernel/audit_watch.c
> >> > +++ b/kernel/audit_watch.c
> >> > @@ -527,11 +527,16 @@ int audit_exe_compare(struct task_struct *tsk,
> >> > struct audit_fsnotify_mark *mark)
> >> >       unsigned long ino;
> >> >       dev_t dev;
> >> >
> >> > -     exe_file = get_task_exe_file(tsk);
> >> > +     /* only do exe filtering if we are recording @current
> >> > events/records */
> >> > +     if (tsk != current)
> >> > +             return 0;
> >> > +
> >> > +     exe_file = get_mm_exe_file(current->mm);
> >
> > Hmmm.  I don't know why I didn't think of this earlier, but we should
> > probably protect against @current->mm being NULL, right?
> >
> 
> For the thread to start executing ->mm has to be set.
> 
> Although I do find it plausible there maybe a corner case during
> kernel bootstrap and it may be that code can land here with that
> state, but I can't be arsed to check.
> 
> Given that stock code has an unintentional property of handling empty
> mm and this is a bugfix, I am definitely not going to protest adding a
> check. But I would WARN_ONCE it though.

There is a case when this happens. Below is the trace I get when
unloading a bpf program of type BPF_PROG_TYPE_SOCKET_FILTER while there
is an audit exe filter in place. So maybe the WARN shouldn't be there
after all?

[  722.833206] ------------[ cut here ]------------
[  722.833902] WARNING: CPU: 1 PID: 0 at kernel/audit_watch.c:534 audit_exe_compare+0x14d/0x1a0
[  722.834010] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace fscache netfs rfkill intel_rapl_msr intel_rapl_common sunrpc isst_if_common skx_edac nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm ipmi_ssif irqbypass mgag200 iTCO_wdt acpi_ipmi rapl iTCO_vendor_support drm_kms_helper ipmi_si mei_me ipmi_devintf dell_smbios intel_cstate intel_uncore drm_shmem_helper dcdbas ipmi_msghandler dell_wmi_descriptor pcspkr wmi_bmof mei i2c_i801 intel_pch_thermal wmi lpc_ich i2c_smbus acpi_power_meter drm fuse xfs libcrc32c sd_mod t10_pi sg crct10dif_pclmul crc32_pclmul crc32c_intel ahci libahci i40e ghash_clmulni_intel igb libata megaraid_sas i2c_algo_bit dca dm_mirror dm_region_hash dm_log dm_mod
[  722.834952] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.6.0+ #5
[  722.835025] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS 2.10.2 02/24/2021
[  722.835124] RIP: 0010:audit_exe_compare+0x14d/0x1a0
[  722.835187] Code: 84 c0 74 04 3c 03 7e 33 44 8b 73 10 48 89 ef e8 b9 8d 67 00 4c 89 ee 5b 4c 89 e7 5d 44 89 f2 41 5c 41 5d 41 5e e9 13 05 00 00 <0f> 0b 5b 31 c0 5d 41 5c 41 5d 41 5e c3 cc cc cc cc e8 6d b7 58 00
[  722.835385] RSP: 0018:ffffc900000fac70 EFLAGS: 00010246
[  722.835451] RAX: dffffc0000000000 RBX: ffff889847880000 RCX: ffff889847880d78
[  722.835533] RDX: 1ffff11308f10124 RSI: ffff889897c04b00 RDI: ffff889847880920
[  722.835614] RBP: ffffed137e575e28 R08: 0000000000000000 R09: fffffbfff6e89b90
[  722.835695] R10: ffffffffb744dc87 R11: 0000000000000000 R12: ffff889897c04b00
[  722.835776] R13: ffff889bf2baf000 R14: ffff889862451d00 R15: 0000000000000000
[  722.835857] FS:  0000000000000000(0000) GS:ffff88afd7e00000(0000) knlGS:0000000000000000
[  722.835948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  722.836015] CR2: 0000000000420234 CR3: 0000000343e6a002 CR4: 00000000007706f0
[  722.836109] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  722.836189] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  722.836270] PKRU: 55555554
[  722.836308] Call Trace:
[  722.836343]  <IRQ>
[  722.836375]  ? __warn+0xc9/0x350
[  722.836426]  ? audit_exe_compare+0x14d/0x1a0
[  722.836485]  ? report_bug+0x326/0x3c0
[  722.836547]  ? handle_bug+0x3c/0x70
[  722.836596]  ? exc_invalid_op+0x14/0x50
[  722.836649]  ? asm_exc_invalid_op+0x16/0x20
[  722.836721]  ? audit_exe_compare+0x14d/0x1a0
[  722.838368]  audit_filter+0x4ab/0xa70
[  722.839965]  ? perf_event_bpf_event+0xf1/0x490
[  722.841562]  ? __pfx_audit_filter+0x10/0x10
[  722.843157]  ? __pfx_perf_event_bpf_event+0x10/0x10
[  722.844757]  ? rcu_do_batch+0x3d7/0xf50
[  722.846330]  audit_log_start+0x28/0x60
[  722.847870]  bpf_audit_prog.part.0+0x3c/0x150
[  722.849398]  bpf_prog_put_deferred+0x8b/0x210
[  722.850919]  sk_filter_release_rcu+0xd7/0x110
[  722.852439]  rcu_do_batch+0x3d9/0xf50
[  722.853961]  ? __pfx_rcu_do_batch+0x10/0x10
[  722.855488]  ? _raw_spin_unlock_irqrestore+0x59/0x70
[  722.857026]  ? lockdep_hardirqs_on+0x79/0x100
[  722.858547]  ? _raw_spin_unlock_irqrestore+0x42/0x70
[  722.860068]  rcu_core+0x3de/0x5a0
[  722.861554]  __do_softirq+0x1ff/0x8f4
[  722.863006]  __irq_exit_rcu+0xbc/0x210
[  722.864398]  irq_exit_rcu+0xa/0x30
[  722.865741]  sysvec_apic_timer_interrupt+0x93/0xc0
[  722.867058]  </IRQ>
[  722.868303]  <TASK>
[  722.869499]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[  722.870692] RIP: 0010:cpuidle_enter_state+0xd2/0x330
[  722.871871] Code: bf ff ff ff ff 49 89 c6 e8 bb b1 5d ff 31 ff e8 14 74 d4 fd 45 84 ff 0f 85 d3 01 00 00 e8 d6 a6 5d ff 84 c0 0f 84 bb 01 00 00 <45> 85 e4 0f 88 31 01 00 00 4d 63 fc 4c 89 f7 4b 8d 04 7f 49 8d 04
[  722.874338] RSP: 0018:ffffc900007d7d78 EFLAGS: 00000202
[  722.875525] RAX: 0000000000079a43 RBX: ffffe8fff7e01af0 RCX: 1ffffffff6a6e911
[  722.876711] RDX: 0000000000000000 RSI: ffffffffb34e46c0 RDI: ffffffffb37782c0
[  722.877891] RBP: ffffffffb4f6ade0 R08: 0000000000000001 R09: fffffbfff6a6f454
[  722.879073] R10: ffffffffb537a2a7 R11: 0000000000000000 R12: 0000000000000002
[  722.880245] R13: 0000000000000002 R14: 000000a84c3592c6 R15: 0000000000000000
[  722.881445]  ? cpuidle_enter_state+0x292/0x330
[  722.882612]  cpuidle_enter+0x4a/0xa0
[  722.883753]  cpuidle_idle_call+0x1bb/0x280
[  722.884871]  ? __pfx_cpuidle_idle_call+0x10/0x10
[  722.885985]  ? tsc_verify_tsc_adjust+0x8f/0x2e0
[  722.887098]  ? rcu_is_watching+0x11/0xb0
[  722.888207]  do_idle+0x13f/0x220
[  722.889294]  cpu_startup_entry+0x51/0x60
[  722.890389]  start_secondary+0x20c/0x290
[  722.891491]  ? __pfx_start_secondary+0x10/0x10
[  722.892608]  ? soft_restart_cpu+0x15/0x15
[  722.893726]  secondary_startup_64_no_verify+0x17d/0x18b
[  722.894879]  </TASK>
[  722.895987] irq event stamp: 499388
[  722.897111] hardirqs last  enabled at (499398): [<ffffffffb0e05e2f>] console_unlock+0x21f/0x250
[  722.898316] hardirqs last disabled at (499407): [<ffffffffb0e05e14>] console_unlock+0x204/0x250
[  722.899514] softirqs last  enabled at (498220): [<ffffffffb305ed27>] __do_softirq+0x5d7/0x8f4
[  722.900718] softirqs last disabled at (498245): [<ffffffffb0c3fe0c>] __irq_exit_rcu+0xbc/0x210
[  722.901929] ---[ end trace 0000000000000000 ]---

> >> >       if (!exe_file)
> >> >               return 0;
> >> >       ino = file_inode(exe_file)->i_ino;
> >> >       dev = file_inode(exe_file)->i_sb->s_dev;
> >> >       fput(exe_file);
> >> > +
> >> >       return audit_mark_compare(mark, ino, dev);
> >> >   }
> >
> > --
> > paul-moore.com
> >
> 
> 
> -- 
> Mateusz Guzik <mjguzik gmail.com>

-- 
 Artem


