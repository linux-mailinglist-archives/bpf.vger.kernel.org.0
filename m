Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A2D2976D8
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 20:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754623AbgJWSWU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 14:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460542AbgJWSWT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 14:22:19 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDACC0613CE
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2020 11:22:17 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id f140so1970626ybg.3
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2020 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fPQi9i5zK8AH4wlmYhxzr3eG3+usP8NTD1oGaxNpQs=;
        b=nWPEOTFIuxlY4Uy1puOn2CSHGl6td6bgSql/EBvPVfwxRKMPibX8jEgtQoAX4yGHjZ
         A2fXoCcRs+hXnMXKGfKa8AMCFgcpzm2vCUf6VwwqTIAVsBD/qkHraetXw3gaUXwh7QBp
         rRbtutP8/lhmZ5DuYFVp8485NfseUw9TVJS8D7KzQ5Mj0DPybQk00oHayZpCuFDRqEoc
         bpB2RGpIJevtfg5mG2+xBhkCZlJnBo7axr+mL4tMbeHrQWDmEKgQ+5m/GHsU4Tu79zUV
         ppr6k0P4vMZNoBiEfJlR0/C/VNxS9EjUouVqnbKGPAoOGUDxafJFqz5FjPD0rOx77t/3
         nayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fPQi9i5zK8AH4wlmYhxzr3eG3+usP8NTD1oGaxNpQs=;
        b=akSvwdReqCyddlTR29akLGq7UK5ga/6FuRRWXAge/qnTBf7Ysg9lkbv457KJrQ1ryA
         YwzdmhBDCw2nW0ar9t/uoesnF5p6B4Qt7QcMdYmbKtFBO7bdpDw7kdFGKgwi4FXHmAZo
         +8TmlAfhlMLMXkV4MXIz690ulLl7N6xf3IzFbmW2LqGgZ817pKTyVO/XGbMdAJQpnYkd
         cmBej/bQAPDivYq/lJkfCwjyb0HOBGER3TpGeG0VhWfdchrveTBGfyupekxK8o1Enkxw
         KgqUuE5qmRM2sX81VYWVPTJ/JqUxgD/6qcUKPvhZTgI5y5vBeRdifGi8rC/owPjZVmOk
         a8Lg==
X-Gm-Message-State: AOAM530qIEwcdNLXgMHBPxIKCFFzMfltOfpNuKWvSXEZ6SdeYkPVUGPj
        g68RRwuv9Bn2WjuUuYQKJn2388hs2btxrurOI1mp99Btb68=
X-Google-Smtp-Source: ABdhPJy1UIX9kDMXq0rd2leuPUmWYFHjZ5ghWR/PhKylnlu6cXx2388VEhEIYa3FyS6Wd7dGDzq3k+DzvkFEStLNXG4=
X-Received: by 2002:a25:cb10:: with SMTP id b16mr5299682ybg.459.1603477336735;
 Fri, 23 Oct 2020 11:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <748495289.11017858.1600094916732.JavaMail.zimbra@redhat.com>
 <20200914182513.GK1714160@krava> <CAEf4Bzb7B+_s0Y2oN5TZARTmJby3npTVKDuDKDKfgmbBkAdpPQ@mail.gmail.com>
 <20200915073030.GE1714160@krava> <20200915121743.GA2199675@krava>
 <20200916090624.GD2301783@krava> <20201016213835.GJ1461394@krava>
 <20201021194209.GB2276476@krava> <CAEf4BzaZa2NDz38j=J=g=9szqj=ruStE7EiSs2ueQ5rVHXYRpQ@mail.gmail.com>
 <20201023053651.GE2332608@krava> <20201023065832.GA2435078@krava>
In-Reply-To: <20201023065832.GA2435078@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Oct 2020 11:22:05 -0700
Message-ID: <CAEf4BzbM=FhKUUjaM9msL1k=t_CSrhoWUNYcubzToZvbAJCJ-A@mail.gmail.com>
Subject: Re: Build failures: unresolved symbol vfs_getattr
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        bpf <bpf@vger.kernel.org>, "Frank Ch. Eigler" <fche@redhat.com>,
        Mark Wielaard <mjw@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 22, 2020 at 11:58 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Oct 23, 2020 at 07:36:57AM +0200, Jiri Olsa wrote:
> > On Thu, Oct 22, 2020 at 01:00:19PM -0700, Andrii Nakryiko wrote:
> >
> > SNIP
> >
> > > >
> > > > hi,
> > > > FYI there's still no solution yet, so far the progress is:
> > > >
> > > > the proposed workaround was to use the negation -> we don't have
> > > > DW_AT_declaration tag, so let's find out instead which DW_TAG_subprogram
> > > > tags have attached code and skip them if they don't have any:
> > > >   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97060#c10
> > > >
> > > > the attached patch is doing that, but the resulting BTF is missing
> > > > several functions due to another bug in dwarf:
> > > >   https://bugzilla.redhat.com/show_bug.cgi?id=1890107
> > >
> > > It seems fine if there are only few functions (especially if those are
> > > unlikely to be traced). Do you have an estimate of how many functions
> > > have this second DWARF bug?
> >
> > it wasn't that many, I'll recheck
>
> 127 functions missing if the workaround is applied, list attached
>

some of those seem pretty useful... I guess the quick workaround in
pahole would be to just remember function names that were emitted
already. The problem with that is that we can pick a version without
parameter names, which is not the end of the world, but certainly
annoying.

But otherwise, I don't really have a good feeling what's the perfect
solution here...

> jirka
>
>
> ---
> 'acpi_ev_default_region_setup'
> 'acpi_ev_pci_bar_region_setup'
> 'acpi_ex_pci_bar_space_handler'
> 'acpi_ex_stop_trace_opcode'
> 'acpi_os_notify_command_complete'
> 'arch_cpu_idle_exit'
> 'arch_unregister_hw_breakpoint'
> 'bfqg_stats_set_start_empty_time'
> 'bfqg_stats_set_start_idle_time'
> 'bfqg_stats_update_avg_queue_size'
> 'bfqg_stats_update_idle_time'
> 'bfqg_stats_update_io_merged'
> 'blk_freeze_queue'
> 'cap_task_setnice'
> 'cryptd_aead_queued'
> 'devm_regmap_field_bulk_free'
> 'disable_nmi_nosync'
> 'ext4_ext_release'
> 'fs_param_is_path'
> 'HUF_isError'
> '__ia32_compat_sys_ftruncate'
> '__ia32_compat_sys_getsockopt'
> '__ia32_compat_sys_io_pgetevents_time32'
> '__ia32_compat_sys_preadv64'
> '__ia32_compat_sys_process_vm_readv'
> '__ia32_compat_sys_process_vm_writev'
> '__ia32_compat_sys_pwritev64'
> '__ia32_compat_sys_s390_ipc'
> '__ia32_compat_sys_setsockopt'
> '__ia32_sys_fadvise64'
> '__ia32_sys_getegid16'
> '__ia32_sys_geteuid16'
> '__ia32_sys_getgid16'
> '__ia32_sys_getuid16'
> '__ia32_sys_inotify_init'
> '__ia32_sys_io_pgetevents_time32'
> '__ia32_sys_ipc'
> '__ia32_sys_munlockall'
> '__ia32_sys_old_msgctl'
> '__ia32_sys_old_semctl'
> '__ia32_sys_old_shmctl'
> '__ia32_sys_pciconfig_iobase'
> '__ia32_sys_pciconfig_read'
> '__ia32_sys_pciconfig_write'
> '__ia32_sys_ppoll_time32'
> '__ia32_sys_pselect6_time32'
> '__ia32_sys_rtas'
> '__ia32_sys_s390_ipc'
> '__ia32_sys_s390_pci_mmio_read'
> '__ia32_sys_s390_pci_mmio_write'
> '__ia32_sys_sgetmask'
> '__ia32_sys_spu_create'
> '__ia32_sys_spu_run'
> '__ia32_sys_subpage_prot'
> '__ia32_sys_uselib'
> '__ia32_sys_vm86'
> '__ia32_sys_vm86old'
> 'ima_post_path_mknod'
> 'ima_show_template_buf'
> '__kfifo_skip_r'
> 'kstrtol_from_user'
> 'mdiobus_read_nested'
> 'mdiobus_write_nested'
> 'memcpy'
> 'memmove'
> 'memset'
> 'module_arch_freeing_init'
> 'native_restore_fl'
> 'native_save_fl'
> 'netdev_walk_all_lower_dev_rcu'
> 'notifier_hangup_irq'
> 'nsecs_to_jiffies'
> 'of_set_phy_eee_broken'
> 'param_set_hexint'
> 'param_set_ullong'
> 'pcibios_bus_add_device'
> 'phy_start_machine'
> 'pmdp_collapse_flush'
> '_raw_write_unlock'
> '_raw_write_unlock_bh'
> '_raw_write_unlock_irq'
> '_raw_write_unlock_irqrestore'
> 'rcu_barrier_tasks_trace'
> 'rcu_test_sync_prims'
> 'regmap_field_bulk_free'
> 'regset_xregset_fpregs_active'
> 'seq_hlist_next_rcu'
> 'set_anon_super_fc'
> 'simple_strtoll'
> 'sock_no_getname'
> 'sock_no_sendmsg_locked'
> 'sock_no_shutdown'
> 'synchronize_rcu_tasks'
> 'synchronize_rcu_tasks_rude'
> 'text_poke_kgdb'
> 'tty_driver_kref_put'
> 'watchdog_nmi_start'
> '__x64_sys_fadvise64'
> '__x64_sys_getegid16'
> '__x64_sys_geteuid16'
> '__x64_sys_getgid16'
> '__x64_sys_getuid16'
> '__x64_sys_inotify_init'
> '__x64_sys_io_pgetevents_time32'
> '__x64_sys_ipc'
> '__x64_sys_munlockall'
> '__x64_sys_old_msgctl'
> '__x64_sys_old_semctl'
> '__x64_sys_old_shmctl'
> '__x64_sys_pciconfig_iobase'
> '__x64_sys_pciconfig_read'
> '__x64_sys_pciconfig_write'
> '__x64_sys_ppoll_time32'
> '__x64_sys_pselect6_time32'
> '__x64_sys_rtas'
> '__x64_sys_s390_ipc'
> '__x64_sys_s390_pci_mmio_read'
> '__x64_sys_s390_pci_mmio_write'
> '__x64_sys_sgetmask'
> '__x64_sys_spu_create'
> '__x64_sys_spu_run'
> '__x64_sys_subpage_prot'
> '__x64_sys_uselib'
> '__x64_sys_vm86'
> '__x64_sys_vm86old'
> 'xen_has_pv_nic_devices'
>
