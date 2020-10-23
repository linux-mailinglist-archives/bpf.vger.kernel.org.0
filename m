Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7B6296A00
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 08:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373632AbgJWG6o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 02:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2508393AbgJWG6o (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 23 Oct 2020 02:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603436322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gI7paGjLqKj+hGqho0MSGnhOoZ/WwegS4ZmrEl2Ld4Y=;
        b=Lm+7FD9x+5+B5eqf/8izOpycpklJEkiXevHDbCFY5BfCRzdmHAkwpPzHwdIdZHk6A0anmU
        PrYZOp9o1QLAWWhm5hfRQlZLxZFXns/uswX2OaWyNmjQxLmT9U7cvxhGjMCmPVAIZDapyf
        WV6cRbyN4XjAfwunWnhK3I+nTiLqAA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-v9sU5G_RMI-i_RGwC1DtLA-1; Fri, 23 Oct 2020 02:58:39 -0400
X-MC-Unique: v9sU5G_RMI-i_RGwC1DtLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDFE9186DD3F;
        Fri, 23 Oct 2020 06:58:37 +0000 (UTC)
Received: from krava (unknown [10.40.192.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id 43F7A60BFA;
        Fri, 23 Oct 2020 06:58:33 +0000 (UTC)
Date:   Fri, 23 Oct 2020 08:58:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>, "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Subject: Re: Build failures: unresolved symbol vfs_getattr
Message-ID: <20201023065832.GA2435078@krava>
References: <748495289.11017858.1600094916732.JavaMail.zimbra@redhat.com>
 <20200914182513.GK1714160@krava>
 <CAEf4Bzb7B+_s0Y2oN5TZARTmJby3npTVKDuDKDKfgmbBkAdpPQ@mail.gmail.com>
 <20200915073030.GE1714160@krava>
 <20200915121743.GA2199675@krava>
 <20200916090624.GD2301783@krava>
 <20201016213835.GJ1461394@krava>
 <20201021194209.GB2276476@krava>
 <CAEf4BzaZa2NDz38j=J=g=9szqj=ruStE7EiSs2ueQ5rVHXYRpQ@mail.gmail.com>
 <20201023053651.GE2332608@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023053651.GE2332608@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 23, 2020 at 07:36:57AM +0200, Jiri Olsa wrote:
> On Thu, Oct 22, 2020 at 01:00:19PM -0700, Andrii Nakryiko wrote:
> 
> SNIP
> 
> > >
> > > hi,
> > > FYI there's still no solution yet, so far the progress is:
> > >
> > > the proposed workaround was to use the negation -> we don't have
> > > DW_AT_declaration tag, so let's find out instead which DW_TAG_subprogram
> > > tags have attached code and skip them if they don't have any:
> > >   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060#c10
> > >
> > > the attached patch is doing that, but the resulting BTF is missing
> > > several functions due to another bug in dwarf:
> > >   https://bugzilla.redhat.com/show_bug.cgi?id=1890107
> > 
> > It seems fine if there are only few functions (especially if those are
> > unlikely to be traced). Do you have an estimate of how many functions
> > have this second DWARF bug?
> 
> it wasn't that many, I'll recheck

127 functions missing if the workaround is applied, list attached

jirka


---
'acpi_ev_default_region_setup'
'acpi_ev_pci_bar_region_setup'
'acpi_ex_pci_bar_space_handler'
'acpi_ex_stop_trace_opcode'
'acpi_os_notify_command_complete'
'arch_cpu_idle_exit'
'arch_unregister_hw_breakpoint'
'bfqg_stats_set_start_empty_time'
'bfqg_stats_set_start_idle_time'
'bfqg_stats_update_avg_queue_size'
'bfqg_stats_update_idle_time'
'bfqg_stats_update_io_merged'
'blk_freeze_queue'
'cap_task_setnice'
'cryptd_aead_queued'
'devm_regmap_field_bulk_free'
'disable_nmi_nosync'
'ext4_ext_release'
'fs_param_is_path'
'HUF_isError'
'__ia32_compat_sys_ftruncate'
'__ia32_compat_sys_getsockopt'
'__ia32_compat_sys_io_pgetevents_time32'
'__ia32_compat_sys_preadv64'
'__ia32_compat_sys_process_vm_readv'
'__ia32_compat_sys_process_vm_writev'
'__ia32_compat_sys_pwritev64'
'__ia32_compat_sys_s390_ipc'
'__ia32_compat_sys_setsockopt'
'__ia32_sys_fadvise64'
'__ia32_sys_getegid16'
'__ia32_sys_geteuid16'
'__ia32_sys_getgid16'
'__ia32_sys_getuid16'
'__ia32_sys_inotify_init'
'__ia32_sys_io_pgetevents_time32'
'__ia32_sys_ipc'
'__ia32_sys_munlockall'
'__ia32_sys_old_msgctl'
'__ia32_sys_old_semctl'
'__ia32_sys_old_shmctl'
'__ia32_sys_pciconfig_iobase'
'__ia32_sys_pciconfig_read'
'__ia32_sys_pciconfig_write'
'__ia32_sys_ppoll_time32'
'__ia32_sys_pselect6_time32'
'__ia32_sys_rtas'
'__ia32_sys_s390_ipc'
'__ia32_sys_s390_pci_mmio_read'
'__ia32_sys_s390_pci_mmio_write'
'__ia32_sys_sgetmask'
'__ia32_sys_spu_create'
'__ia32_sys_spu_run'
'__ia32_sys_subpage_prot'
'__ia32_sys_uselib'
'__ia32_sys_vm86'
'__ia32_sys_vm86old'
'ima_post_path_mknod'
'ima_show_template_buf'
'__kfifo_skip_r'
'kstrtol_from_user'
'mdiobus_read_nested'
'mdiobus_write_nested'
'memcpy'
'memmove'
'memset'
'module_arch_freeing_init'
'native_restore_fl'
'native_save_fl'
'netdev_walk_all_lower_dev_rcu'
'notifier_hangup_irq'
'nsecs_to_jiffies'
'of_set_phy_eee_broken'
'param_set_hexint'
'param_set_ullong'
'pcibios_bus_add_device'
'phy_start_machine'
'pmdp_collapse_flush'
'_raw_write_unlock'
'_raw_write_unlock_bh'
'_raw_write_unlock_irq'
'_raw_write_unlock_irqrestore'
'rcu_barrier_tasks_trace'
'rcu_test_sync_prims'
'regmap_field_bulk_free'
'regset_xregset_fpregs_active'
'seq_hlist_next_rcu'
'set_anon_super_fc'
'simple_strtoll'
'sock_no_getname'
'sock_no_sendmsg_locked'
'sock_no_shutdown'
'synchronize_rcu_tasks'
'synchronize_rcu_tasks_rude'
'text_poke_kgdb'
'tty_driver_kref_put'
'watchdog_nmi_start'
'__x64_sys_fadvise64'
'__x64_sys_getegid16'
'__x64_sys_geteuid16'
'__x64_sys_getgid16'
'__x64_sys_getuid16'
'__x64_sys_inotify_init'
'__x64_sys_io_pgetevents_time32'
'__x64_sys_ipc'
'__x64_sys_munlockall'
'__x64_sys_old_msgctl'
'__x64_sys_old_semctl'
'__x64_sys_old_shmctl'
'__x64_sys_pciconfig_iobase'
'__x64_sys_pciconfig_read'
'__x64_sys_pciconfig_write'
'__x64_sys_ppoll_time32'
'__x64_sys_pselect6_time32'
'__x64_sys_rtas'
'__x64_sys_s390_ipc'
'__x64_sys_s390_pci_mmio_read'
'__x64_sys_s390_pci_mmio_write'
'__x64_sys_sgetmask'
'__x64_sys_spu_create'
'__x64_sys_spu_run'
'__x64_sys_subpage_prot'
'__x64_sys_uselib'
'__x64_sys_vm86'
'__x64_sys_vm86old'
'xen_has_pv_nic_devices'

