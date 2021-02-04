Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE56630F3DB
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 14:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbhBDN10 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 08:27:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236312AbhBDN1P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 08:27:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BA0464E8C;
        Thu,  4 Feb 2021 13:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612445189;
        bh=8ekXvea/j7h7aahxSKPMxgG0lOdqBjOh4FoWdYmKB4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rzWGNWhplPibC6aVz0pGSARqpzssTgzg0Jfqx3UqCXdNCdQVYZmgC3q/bzdkFO6D6
         Bm5D+ePBY9fKoThp5B7QHn0gqs2iknoFBXLbh77RviPUwa3oFrOYwbYmAS0sYaC+6Z
         CPlVAr9uycFWZmefUPj9MoFPeEc2VLcu5szoJqKXYGTD0gQ4HN0bGk5wa35pPkduB1
         lhVbiPmAFWcIqAzikrpdbBJSAR3BI2Zui/0A6VXJNAwjTf+itZCMzbVkRuBlhdLXPE
         sTb3a0V4Cb27wYvlCaB+MvBZcgvhaKQsklA2L90hpNVT8M9EFtNED6QeVQinU++lHn
         nGdZFbfwGNWig==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 19A1F40513; Thu,  4 Feb 2021 10:26:25 -0300 (-03)
Date:   Thu, 4 Feb 2021 10:26:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        dwarves@vger.kernel.org
Subject: Re: 5:11: in-kernel BTF is malformed
Message-ID: <20210204132625.GB910119@kernel.org>
References: <CAJCQCtSQLc0VHqO4BY_-YB2OmCNNmHCS6fNdQKmMWGn2v=Jpdw@mail.gmail.com>
 <CAJCQCtRHOidM7Vps1JQSpZA14u+B5fR860FwZB=eb1wYjTpqDw@mail.gmail.com>
 <CAEf4BzZ4oTB0-JizHe1VaCk2V+Jb9jJoTznkgh6CjE5VxNVqbg@mail.gmail.com>
 <CAJCQCtRw6UWGGvjn0x__godYKYQXXmtyQys4efW2Pb84Q5q8Eg@mail.gmail.com>
 <20210204010038.GA854763@kernel.org>
 <CAJCQCtQfgRp78_WSrSHLNUUYNCyOCH=vo10nVZW_cyMjpZiNJg@mail.gmail.com>
 <CAEf4Bza4XQxpS7VTNWGk6Rz-iUwZemF6+iAVBA_yvrWnV0k8Qg@mail.gmail.com>
 <CAJCQCtRDJ_uiJcanP_p+y6Kz76c4P-EmndMyfHN5f4rtkgYhjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtRDJ_uiJcanP_p+y6Kz76c4P-EmndMyfHN5f4rtkgYhjA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 03, 2021 at 07:10:52PM -0700, Chris Murphy escreveu:
> On Wed, Feb 3, 2021 at 7:05 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > eventually we get to non-bitfield field

> >         'atomic_flags' type_id=1 bits_offset=18304

> > So it's a bitfield offset breakage that should be fixed in pahole 1.20.
> 
> Rawhide is currently still on
> dwarves-1.19-2.fc34.x86_64
> 
> This might also be related:
> https://bugzilla.redhat.com/show_bug.cgi?id=1922707#c9

With about to be released pahole v1.20 it all seems to work, tldr;

[root@seventh ~]# ~acme/git/pahole/btfdiff /lib/modules/`uname -r`/build/vmlinux
[root@seventh ~]#

Same thing. I'll do more tests after some errands, but I've put the pre-release
rpm packages for 1.20 at:

http://vger.kernel.org/~acme/pahole/rpms/1.20-0/RPMS/x86_64/Packages/

Can you please try it with gcc 11?

- Arnaldo

Long set of tests:

[root@seventh ~]# pahole --numeric_version
120
[root@seventh ~]# pahole --version
v1.20
[root@seventh ~]# ls -la /sys/kernel/btf/
total 0
drwxr-xr-x.  2 root root       0 Feb  4 10:16 .
drwxr-xr-x. 16 root root       0 Feb  4 10:13 ..
-r--r--r--.  1 root root    2504 Feb  4 10:16 ac97_bus
-r--r--r--.  1 root root     364 Feb  4 10:16 acpi_pad
-r--r--r--.  1 root root    5813 Feb  4 10:16 asus_wmi
-r--r--r--.  1 root root   50150 Feb  4 10:16 bridge
-r--r--r--.  1 root root   21864 Feb  4 10:16 cec
-r--r--r--.  1 root root    1215 Feb  4 10:16 coretemp
-r--r--r--.  1 root root     423 Feb  4 10:16 crc32c_intel
-r--r--r--.  1 root root     380 Feb  4 10:16 crc32_pclmul
-r--r--r--.  1 root root      61 Feb  4 10:16 crct10dif_pclmul
-r--r--r--.  1 root root    1280 Feb  4 10:16 dca
-r--r--r--.  1 root root  101342 Feb  4 10:16 drm
-r--r--r--.  1 root root   77938 Feb  4 10:16 drm_kms_helper
-r--r--r--.  1 root root   33917 Feb  4 10:16 e1000e
-r--r--r--.  1 root root    2729 Feb  4 10:16 ebtable_broute
-r--r--r--.  1 root root    2791 Feb  4 10:16 ebtable_filter
-r--r--r--.  1 root root    2780 Feb  4 10:16 ebtable_nat
-r--r--r--.  1 root root    5250 Feb  4 10:16 ebtables
-r--r--r--.  1 root root     154 Feb  4 10:16 ee1004
-r--r--r--.  1 root root    1335 Feb  4 10:16 eeepc_wmi
-r--r--r--.  1 root root   10805 Feb  4 10:16 fat
-r--r--r--.  1 root root   26019 Feb  4 10:16 fuse
-r--r--r--.  1 root root     431 Feb  4 10:16 ghash_clmulni_intel
-r--r--r--.  1 root root     655 Feb  4 10:16 i2c_algo_bit
-r--r--r--.  1 root root    1557 Feb  4 10:16 i2c_i801
-r--r--r--.  1 root root     701 Feb  4 10:16 i2c_smbus
-r--r--r--.  1 root root  441993 Feb  4 10:16 i915
-r--r--r--.  1 root root   38563 Feb  4 10:16 ib_cm
-r--r--r--.  1 root root  103605 Feb  4 10:16 ib_core
-r--r--r--.  1 root root   41850 Feb  4 10:16 ib_ipoib
-r--r--r--.  1 root root   38747 Feb  4 10:16 ib_iser
-r--r--r--.  1 root root   56374 Feb  4 10:16 ib_isert
-r--r--r--.  1 root root   54128 Feb  4 10:16 ib_srpt
-r--r--r--.  1 root root   20084 Feb  4 10:16 ib_umad
-r--r--r--.  1 root root   67283 Feb  4 10:16 ib_uverbs
-r--r--r--.  1 root root    1121 Feb  4 10:16 intel_cstate
-r--r--r--.  1 root root     660 Feb  4 10:16 intel_pmc_bxt
-r--r--r--.  1 root root    1207 Feb  4 10:16 intel_powerclamp
-r--r--r--.  1 root root    3983 Feb  4 10:16 intel_rapl_common
-r--r--r--.  1 root root    2195 Feb  4 10:16 intel_rapl_msr
-r--r--r--.  1 root root   17977 Feb  4 10:16 intel_uncore
-r--r--r--.  1 root root     842 Feb  4 10:16 ip6table_filter
-r--r--r--.  1 root root     755 Feb  4 10:16 ip6table_mangle
-r--r--r--.  1 root root     780 Feb  4 10:16 ip6table_nat
-r--r--r--.  1 root root     740 Feb  4 10:16 ip6table_raw
-r--r--r--.  1 root root    3183 Feb  4 10:16 ip6_tables
-r--r--r--.  1 root root     765 Feb  4 10:16 ip6table_security
-r--r--r--.  1 root root   12324 Feb  4 10:16 ip_set
-r--r--r--.  1 root root     819 Feb  4 10:16 iptable_filter
-r--r--r--.  1 root root     734 Feb  4 10:16 iptable_mangle
-r--r--r--.  1 root root     759 Feb  4 10:16 iptable_nat
-r--r--r--.  1 root root     719 Feb  4 10:16 iptable_raw
-r--r--r--.  1 root root    3142 Feb  4 10:16 ip_tables
-r--r--r--.  1 root root     744 Feb  4 10:16 iptable_security
-r--r--r--.  1 root root     881 Feb  4 10:16 ipt_REJECT
-r--r--r--.  1 root root   65141 Feb  4 10:16 iscsi_target_mod
-r--r--r--.  1 root root     234 Feb  4 10:16 iTCO_vendor_support
-r--r--r--.  1 root root    1091 Feb  4 10:16 iTCO_wdt
-r--r--r--.  1 root root   25253 Feb  4 10:16 iw_cm
-r--r--r--.  1 root root   64854 Feb  4 10:16 ixgbe
-r--r--r--.  1 root root    1600 Feb  4 10:16 joydev
-r--r--r--.  1 root root     305 Feb  4 10:16 ledtrig_audio
-r--r--r--.  1 root root   20018 Feb  4 10:16 libiscsi
-r--r--r--.  1 root root    1021 Feb  4 10:16 llc
-r--r--r--.  1 root root     926 Feb  4 10:16 mdio
-r--r--r--.  1 root root   19816 Feb  4 10:16 mei
-r--r--r--.  1 root root   10228 Feb  4 10:16 mei_hdcp
-r--r--r--.  1 root root    6406 Feb  4 10:16 mei_me
-r--r--r--.  1 root root  476381 Feb  4 10:16 mlx5_core
-r--r--r--.  1 root root  215552 Feb  4 10:16 mlx5_ib
-r--r--r--.  1 root root    4844 Feb  4 10:16 mlxfw
-r--r--r--.  1 root root     222 Feb  4 10:16 mxm_wmi
-r--r--r--.  1 root root  315981 Feb  4 10:16 nf_conntrack
-r--r--r--.  1 root root    1281 Feb  4 10:16 nf_conntrack_broadcast
-r--r--r--.  1 root root    1062 Feb  4 10:16 nf_conntrack_netbios_ns
-r--r--r--.  1 root root   80662 Feb  4 10:16 nf_conntrack_tftp
-r--r--r--.  1 root root     484 Feb  4 10:16 nf_defrag_ipv4
-r--r--r--.  1 root root   82072 Feb  4 10:16 nf_defrag_ipv6
-r--r--r--.  1 root root  258065 Feb  4 10:16 nf_nat
-r--r--r--.  1 root root    1298 Feb  4 10:16 nf_nat_tftp
-r--r--r--.  1 root root    2219 Feb  4 10:16 nfnetlink
-r--r--r--.  1 root root     621 Feb  4 10:16 nf_reject_ipv4
-r--r--r--.  1 root root     651 Feb  4 10:16 nf_reject_ipv6
-r--r--r--.  1 root root   48592 Feb  4 10:16 nf_tables
-r--r--r--.  1 root root    1623 Feb  4 10:16 nft_chain_nat
-r--r--r--.  1 root root   89032 Feb  4 10:16 nft_ct
-r--r--r--.  1 root root    4263 Feb  4 10:16 nft_fib
-r--r--r--.  1 root root    3846 Feb  4 10:16 nft_fib_inet
-r--r--r--.  1 root root    3785 Feb  4 10:16 nft_fib_ipv4
-r--r--r--.  1 root root    4372 Feb  4 10:16 nft_fib_ipv6
-r--r--r--.  1 root root    3930 Feb  4 10:16 nft_masq
-r--r--r--.  1 root root    7698 Feb  4 10:16 nft_objref
-r--r--r--.  1 root root    4195 Feb  4 10:16 nft_reject
-r--r--r--.  1 root root    2959 Feb  4 10:16 nft_reject_inet
-r--r--r--.  1 root root     618 Feb  4 10:16 pci_hyperv_intf
-r--r--r--.  1 root root     195 Feb  4 10:16 pcspkr
-r--r--r--.  1 root root    1268 Feb  4 10:16 rapl
-r--r--r--.  1 root root   39437 Feb  4 10:16 rdma_cm
-r--r--r--.  1 root root   25661 Feb  4 10:16 rdma_ucm
-r--r--r--.  1 root root    4105 Feb  4 10:16 rfkill
-r--r--r--.  1 root root   81732 Feb  4 10:16 rpcrdma
-r--r--r--.  1 root root   38417 Feb  4 10:16 scsi_transport_iscsi
-r--r--r--.  1 root root     629 Feb  4 10:16 serio_raw
-r--r--r--.  1 root root   14042 Feb  4 10:16 snd
-r--r--r--.  1 root root    2321 Feb  4 10:16 snd_compress
-r--r--r--.  1 root root   37670 Feb  4 10:16 snd_hda_codec
-r--r--r--.  1 root root   24328 Feb  4 10:16 snd_hda_codec_generic
-r--r--r--.  1 root root   23761 Feb  4 10:16 snd_hda_codec_hdmi
-r--r--r--.  1 root root   40886 Feb  4 10:16 snd_hda_codec_realtek
-r--r--r--.  1 root root   18069 Feb  4 10:16 snd_hda_core
-r--r--r--.  1 root root   14189 Feb  4 10:16 snd_hda_intel
-r--r--r--.  1 root root    3379 Feb  4 10:16 snd_hwdep
-r--r--r--.  1 root root    1825 Feb  4 10:16 snd_intel_dspcfg
-r--r--r--.  1 root root   26553 Feb  4 10:16 snd_pcm
-r--r--r--.  1 root root    1296 Feb  4 10:16 snd_pcm_dmaengine
-r--r--r--.  1 root root   18416 Feb  4 10:16 snd_seq
-r--r--r--.  1 root root    1690 Feb  4 10:16 snd_seq_device
-r--r--r--.  1 root root   37842 Feb  4 10:16 snd_soc_core
-r--r--r--.  1 root root    8337 Feb  4 10:16 snd_timer
-r--r--r--.  1 root root     660 Feb  4 10:16 soundcore
-r--r--r--.  1 root root    2783 Feb  4 10:16 soundwire_cadence
-r--r--r--.  1 root root     494 Feb  4 10:16 soundwire_generic_allocation
-r--r--r--.  1 root root    4162 Feb  4 10:16 soundwire_intel
-r--r--r--.  1 root root     765 Feb  4 10:16 sparse_keymap
-r--r--r--.  1 root root     704 Feb  4 10:16 stp
-r--r--r--.  1 root root   92567 Feb  4 10:16 sunrpc
-r--r--r--.  1 root root   52984 Feb  4 10:16 target_core_mod
-r--r--r--.  1 root root    2804 Feb  4 10:16 vfat
-r--r--r--.  1 root root    4018 Feb  4 10:16 video
-r--r--r--.  1 root root 4560322 Feb  4 10:16 vmlinux
-r--r--r--.  1 root root    2658 Feb  4 10:16 wmi
-r--r--r--.  1 root root     805 Feb  4 10:16 wmi_bmof
-r--r--r--.  1 root root     665 Feb  4 10:16 x86_pkg_temp_thermal
-r--r--r--.  1 root root     638 Feb  4 10:16 xt_CHECKSUM
-r--r--r--.  1 root root    2209 Feb  4 10:16 xt_conntrack
-r--r--r--.  1 root root     557 Feb  4 10:16 xt_MASQUERADE
-r--r--r--.  1 root root    2456 Feb  4 10:16 zram
[root@seventh ~]# uname -a
Linux seventh 5.11.0-rc6+ #1 SMP Wed Feb 3 21:16:41 -03 2021 x86_64 x86_64 x86_64 GNU/Linux
[root@seventh ~]# gcc --version |& head -1
gcc (GCC) 11.0.0 20210123 (Red Hat 11.0.0-0)
[root@seventh ~]# cat /etc/fedora-release 
Fedora release 34 (Rawhide)
[root@seventh ~]#
[root@seventh ~]# pahole list_head
struct list_head {
	struct list_head *         next;                 /*     0     8 */
	struct list_head *         prev;                 /*     8     8 */

	/* size: 16, cachelines: 1, members: 2 */
	/* last cacheline: 16 bytes */
};

[root@seventh ~]# pahole task_struct
struct task_struct {
	struct thread_info         thread_info;          /*     0    24 */

	/* XXX last struct has 4 bytes of padding */

	volatile long int          state;                /*    24     8 */
	void *                     stack;                /*    32     8 */
	refcount_t                 usage;                /*    40     4 */
	unsigned int               flags;                /*    44     4 */
	unsigned int               ptrace;               /*    48     4 */
	int                        on_cpu;               /*    52     4 */
	struct __call_single_node  wake_entry;           /*    56    16 */
	/* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
	unsigned int               cpu;                  /*    72     4 */
	unsigned int               wakee_flips;          /*    76     4 */
	long unsigned int          wakee_flip_decay_ts;  /*    80     8 */
	struct task_struct *       last_wakee;           /*    88     8 */
	int                        recent_used_cpu;      /*    96     4 */
	int                        wake_cpu;             /*   100     4 */
	int                        on_rq;                /*   104     4 */
	int                        prio;                 /*   108     4 */
	int                        static_prio;          /*   112     4 */
	int                        normal_prio;          /*   116     4 */
	unsigned int               rt_priority;          /*   120     4 */

	/* XXX 4 bytes hole, try to pack */

	/* --- cacheline 2 boundary (128 bytes) --- */
	const struct sched_class  * sched_class;         /*   128     8 */

	/* XXX 56 bytes hole, try to pack */

	/* --- cacheline 3 boundary (192 bytes) --- */
	struct sched_entity        se;                   /*   192   448 */
	/* --- cacheline 10 boundary (640 bytes) --- */
	struct sched_rt_entity     rt;                   /*   640    48 */
	struct task_group *        sched_task_group;     /*   688     8 */
	struct sched_dl_entity     dl;                   /*   696   224 */
	/* --- cacheline 14 boundary (896 bytes) was 24 bytes ago --- */
	struct hlist_head          preempt_notifiers;    /*   920     8 */
	unsigned int               btrace_seq;           /*   928     4 */
	unsigned int               policy;               /*   932     4 */
	int                        nr_cpus_allowed;      /*   936     4 */

	/* XXX 4 bytes hole, try to pack */

	const cpumask_t  *         cpus_ptr;             /*   944     8 */
	cpumask_t                  cpus_mask;            /*   952  1024 */
	/* --- cacheline 30 boundary (1920 bytes) was 56 bytes ago --- */
	void *                     migration_pending;    /*  1976     8 */
	/* --- cacheline 31 boundary (1984 bytes) --- */
	short unsigned int         migration_disabled;   /*  1984     2 */
	short unsigned int         migration_flags;      /*  1986     2 */

	/* XXX 4 bytes hole, try to pack */

	long unsigned int          rcu_tasks_nvcsw;      /*  1992     8 */
	u8                         rcu_tasks_holdout;    /*  2000     1 */
	u8                         rcu_tasks_idx;        /*  2001     1 */

	/* XXX 2 bytes hole, try to pack */

	int                        rcu_tasks_idle_cpu;   /*  2004     4 */
	struct list_head           rcu_tasks_holdout_list; /*  2008    16 */
	int                        trc_reader_nesting;   /*  2024     4 */
	int                        trc_ipi_to_cpu;       /*  2028     4 */
	union rcu_special          trc_reader_special;   /*  2032     4 */
	bool                       trc_reader_checked;   /*  2036     1 */

	/* XXX 3 bytes hole, try to pack */

	struct list_head           trc_holdout_list;     /*  2040    16 */
	/* --- cacheline 32 boundary (2048 bytes) was 8 bytes ago --- */
	struct sched_info          sched_info;           /*  2056    32 */
	struct list_head           tasks;                /*  2088    16 */
	struct plist_node          pushable_tasks;       /*  2104    40 */
	/* --- cacheline 33 boundary (2112 bytes) was 32 bytes ago --- */
	struct rb_node             pushable_dl_tasks;    /*  2144    24 */
	struct mm_struct *         mm;                   /*  2168     8 */
	/* --- cacheline 34 boundary (2176 bytes) --- */
	struct mm_struct *         active_mm;            /*  2176     8 */
	struct vmacache            vmacache;             /*  2184    40 */
	struct task_rss_stat       rss_stat;             /*  2224    20 */
	/* --- cacheline 35 boundary (2240 bytes) was 4 bytes ago --- */
	int                        exit_state;           /*  2244     4 */
	int                        exit_code;            /*  2248     4 */
	int                        exit_signal;          /*  2252     4 */
	int                        pdeath_signal;        /*  2256     4 */

	/* XXX 4 bytes hole, try to pack */

	long unsigned int          jobctl;               /*  2264     8 */
	unsigned int               personality;          /*  2272     4 */
	unsigned int               sched_reset_on_fork:1; /*  2276: 0  4 */
	unsigned int               sched_contributes_to_load:1; /*  2276: 1  4 */
	unsigned int               sched_migrated:1;     /*  2276: 2  4 */
	unsigned int               sched_psi_wake_requeue:1; /*  2276: 3  4 */

	/* XXX 28 bits hole, try to pack */

	/* Force alignment to the next boundary: */
	unsigned int               :0;

	unsigned int               sched_remote_wakeup:1; /*  2280: 0  4 */
	unsigned int               in_execve:1;          /*  2280: 1  4 */
	unsigned int               in_iowait:1;          /*  2280: 2  4 */
	unsigned int               restore_sigmask:1;    /*  2280: 3  4 */
	unsigned int               in_user_fault:1;      /*  2280: 4  4 */
	unsigned int               no_cgroup_migration:1; /*  2280: 5  4 */
	unsigned int               frozen:1;             /*  2280: 6  4 */
	unsigned int               use_memdelay:1;       /*  2280: 7  4 */
	unsigned int               in_memstall:1;        /*  2280: 8  4 */

	/* XXX 23 bits hole, try to pack */
	/* XXX 4 bytes hole, try to pack */

	long unsigned int          atomic_flags;         /*  2288     8 */
	struct restart_block       restart_block;        /*  2296    48 */
	/* --- cacheline 36 boundary (2304 bytes) was 40 bytes ago --- */
	pid_t                      pid;                  /*  2344     4 */
	pid_t                      tgid;                 /*  2348     4 */
	long unsigned int          stack_canary;         /*  2352     8 */
	struct task_struct *       real_parent;          /*  2360     8 */
	/* --- cacheline 37 boundary (2368 bytes) --- */
	struct task_struct *       parent;               /*  2368     8 */
	struct list_head           children;             /*  2376    16 */
	struct list_head           sibling;              /*  2392    16 */
	struct task_struct *       group_leader;         /*  2408     8 */
	struct list_head           ptraced;              /*  2416    16 */
	/* --- cacheline 38 boundary (2432 bytes) --- */
	struct list_head           ptrace_entry;         /*  2432    16 */
	struct pid *               thread_pid;           /*  2448     8 */
	struct hlist_node          pid_links[4];         /*  2456    64 */
	/* --- cacheline 39 boundary (2496 bytes) was 24 bytes ago --- */
	struct list_head           thread_group;         /*  2520    16 */
	struct list_head           thread_node;          /*  2536    16 */
	struct completion *        vfork_done;           /*  2552     8 */
	/* --- cacheline 40 boundary (2560 bytes) --- */
	int *                      set_child_tid;        /*  2560     8 */
	int *                      clear_child_tid;      /*  2568     8 */
	u64                        utime;                /*  2576     8 */
	u64                        stime;                /*  2584     8 */
	u64                        gtime;                /*  2592     8 */
	struct prev_cputime        prev_cputime;         /*  2600    88 */
	/* --- cacheline 42 boundary (2688 bytes) --- */
	struct vtime               vtime;                /*  2688    96 */
	/* --- cacheline 43 boundary (2752 bytes) was 32 bytes ago --- */
	atomic_t                   tick_dep_mask;        /*  2784     4 */

	/* XXX 4 bytes hole, try to pack */

	long unsigned int          nvcsw;                /*  2792     8 */
	long unsigned int          nivcsw;               /*  2800     8 */
	u64                        start_time;           /*  2808     8 */
	/* --- cacheline 44 boundary (2816 bytes) --- */
	u64                        start_boottime;       /*  2816     8 */
	long unsigned int          min_flt;              /*  2824     8 */
	long unsigned int          maj_flt;              /*  2832     8 */
	struct posix_cputimers     posix_cputimers;      /*  2840    80 */
	/* --- cacheline 45 boundary (2880 bytes) was 40 bytes ago --- */
	struct posix_cputimers_work posix_cputimers_work; /*  2920    24 */

	/* XXX last struct has 4 bytes of padding */

	/* --- cacheline 46 boundary (2944 bytes) --- */
	const struct cred  *       ptracer_cred;         /*  2944     8 */
	const struct cred  *       real_cred;            /*  2952     8 */
	const struct cred  *       cred;                 /*  2960     8 */
	struct key *               cached_requested_key; /*  2968     8 */
	char                       comm[16];             /*  2976    16 */
	struct nameidata *         nameidata;            /*  2992     8 */
	struct sysv_sem            sysvsem;              /*  3000     8 */
	/* --- cacheline 47 boundary (3008 bytes) --- */
	struct sysv_shm            sysvshm;              /*  3008    16 */
	long unsigned int          last_switch_count;    /*  3024     8 */
	long unsigned int          last_switch_time;     /*  3032     8 */
	struct fs_struct *         fs;                   /*  3040     8 */
	struct files_struct *      files;                /*  3048     8 */
	struct io_uring_task *     io_uring;             /*  3056     8 */
	struct nsproxy *           nsproxy;              /*  3064     8 */
	/* --- cacheline 48 boundary (3072 bytes) --- */
	struct signal_struct *     signal;               /*  3072     8 */
	struct sighand_struct *    sighand;              /*  3080     8 */
	sigset_t                   blocked;              /*  3088     8 */
	sigset_t                   real_blocked;         /*  3096     8 */
	sigset_t                   saved_sigmask;        /*  3104     8 */
	struct sigpending          pending;              /*  3112    24 */
	/* --- cacheline 49 boundary (3136 bytes) --- */
	long unsigned int          sas_ss_sp;            /*  3136     8 */
	size_t                     sas_ss_size;          /*  3144     8 */
	unsigned int               sas_ss_flags;         /*  3152     4 */

	/* XXX 4 bytes hole, try to pack */

	struct callback_head *     task_works;           /*  3160     8 */
	struct audit_context *     audit_context;        /*  3168     8 */
	kuid_t                     loginuid;             /*  3176     4 */
	unsigned int               sessionid;            /*  3180     4 */
	struct seccomp             seccomp;              /*  3184    16 */
	/* --- cacheline 50 boundary (3200 bytes) --- */
	struct syscall_user_dispatch syscall_dispatch;   /*  3200    32 */

	/* XXX last struct has 7 bytes of padding */

	u64                        parent_exec_id;       /*  3232     8 */
	u64                        self_exec_id;         /*  3240     8 */
	spinlock_t                 alloc_lock;           /*  3248    72 */
	/* --- cacheline 51 boundary (3264 bytes) was 56 bytes ago --- */
	raw_spinlock_t             pi_lock;              /*  3320    72 */
	/* --- cacheline 53 boundary (3392 bytes) --- */
	struct wake_q_node         wake_q;               /*  3392     8 */
	struct rb_root_cached      pi_waiters;           /*  3400    16 */
	struct task_struct *       pi_top_task;          /*  3416     8 */
	struct rt_mutex_waiter *   pi_blocked_on;        /*  3424     8 */
	struct mutex_waiter *      blocked_on;           /*  3432     8 */
	int                        non_block_count;      /*  3440     4 */

	/* XXX 4 bytes hole, try to pack */

	struct irqtrace_events     irqtrace;             /*  3448    56 */
	/* --- cacheline 54 boundary (3456 bytes) was 48 bytes ago --- */
	unsigned int               hardirq_threaded;     /*  3504     4 */

	/* XXX 4 bytes hole, try to pack */

	u64                        hardirq_chain_key;    /*  3512     8 */
	/* --- cacheline 55 boundary (3520 bytes) --- */
	int                        softirqs_enabled;     /*  3520     4 */
	int                        softirq_context;      /*  3524     4 */
	int                        irq_config;           /*  3528     4 */

	/* XXX 4 bytes hole, try to pack */

	u64                        curr_chain_key;       /*  3536     8 */
	int                        lockdep_depth;        /*  3544     4 */
	unsigned int               lockdep_recursion;    /*  3548     4 */
	struct held_lock           held_locks[48];       /*  3552  2688 */
	/* --- cacheline 97 boundary (6208 bytes) was 32 bytes ago --- */
	void *                     journal_info;         /*  6240     8 */
	struct bio_list *          bio_list;             /*  6248     8 */
	struct blk_plug *          plug;                 /*  6256     8 */
	struct reclaim_state *     reclaim_state;        /*  6264     8 */
	/* --- cacheline 98 boundary (6272 bytes) --- */
	struct backing_dev_info *  backing_dev_info;     /*  6272     8 */
	struct io_context *        io_context;           /*  6280     8 */
	struct capture_control *   capture_control;      /*  6288     8 */
	long unsigned int          ptrace_message;       /*  6296     8 */
	kernel_siginfo_t *         last_siginfo;         /*  6304     8 */
	struct task_io_accounting  ioac;                 /*  6312    56 */
	/* --- cacheline 99 boundary (6336 bytes) was 32 bytes ago --- */
	unsigned int               psi_flags;            /*  6368     4 */

	/* XXX 4 bytes hole, try to pack */

	u64                        acct_rss_mem1;        /*  6376     8 */
	u64                        acct_vm_mem1;         /*  6384     8 */
	u64                        acct_timexpd;         /*  6392     8 */
	/* --- cacheline 100 boundary (6400 bytes) --- */
	nodemask_t                 mems_allowed;         /*  6400   128 */
	/* --- cacheline 102 boundary (6528 bytes) --- */
	seqcount_spinlock_t        mems_allowed_seq;     /*  6528    64 */
	/* --- cacheline 103 boundary (6592 bytes) --- */
	int                        cpuset_mem_spread_rotor; /*  6592     4 */
	int                        cpuset_slab_spread_rotor; /*  6596     4 */
	struct css_set *           cgroups;              /*  6600     8 */
	struct list_head           cg_list;              /*  6608    16 */
	u32                        closid;               /*  6624     4 */
	u32                        rmid;                 /*  6628     4 */
	struct robust_list_head *  robust_list;          /*  6632     8 */
	struct compat_robust_list_head * compat_robust_list; /*  6640     8 */
	struct list_head           pi_state_list;        /*  6648    16 */
	/* --- cacheline 104 boundary (6656 bytes) was 8 bytes ago --- */
	struct futex_pi_state *    pi_state_cache;       /*  6664     8 */
	struct mutex               futex_exit_mutex;     /*  6672   160 */
	/* --- cacheline 106 boundary (6784 bytes) was 48 bytes ago --- */
	unsigned int               futex_state;          /*  6832     4 */

	/* XXX 4 bytes hole, try to pack */

	struct perf_event_context * perf_event_ctxp[2];  /*  6840    16 */
	/* --- cacheline 107 boundary (6848 bytes) was 8 bytes ago --- */
	struct mutex               perf_event_mutex;     /*  6856   160 */
	/* --- cacheline 109 boundary (6976 bytes) was 40 bytes ago --- */
	struct list_head           perf_event_list;      /*  7016    16 */
	struct mempolicy *         mempolicy;            /*  7032     8 */
	/* --- cacheline 110 boundary (7040 bytes) --- */
	short int                  il_prev;              /*  7040     2 */
	short int                  pref_node_fork;       /*  7042     2 */
	int                        numa_scan_seq;        /*  7044     4 */
	unsigned int               numa_scan_period;     /*  7048     4 */
	unsigned int               numa_scan_period_max; /*  7052     4 */
	int                        numa_preferred_nid;   /*  7056     4 */

	/* XXX 4 bytes hole, try to pack */

	long unsigned int          numa_migrate_retry;   /*  7064     8 */
	u64                        node_stamp;           /*  7072     8 */
	u64                        last_task_numa_placement; /*  7080     8 */
	u64                        last_sum_exec_runtime; /*  7088     8 */
	struct callback_head       numa_work;            /*  7096    16 */
	/* --- cacheline 111 boundary (7104 bytes) was 8 bytes ago --- */
	struct numa_group *        numa_group;           /*  7112     8 */
	long unsigned int *        numa_faults;          /*  7120     8 */
	long unsigned int          total_numa_faults;    /*  7128     8 */
	long unsigned int          numa_faults_locality[3]; /*  7136    24 */
	long unsigned int          numa_pages_migrated;  /*  7160     8 */
	/* --- cacheline 112 boundary (7168 bytes) --- */
	struct rseq *              rseq;                 /*  7168     8 */
	u32                        rseq_sig;             /*  7176     4 */

	/* XXX 4 bytes hole, try to pack */

	long unsigned int          rseq_event_mask;      /*  7184     8 */
	struct tlbflush_unmap_batch tlb_ubc;             /*  7192  1032 */

	/* XXX last struct has 6 bytes of padding */

	/* --- cacheline 128 boundary (8192 bytes) was 32 bytes ago --- */
	union {
		refcount_t         rcu_users;            /*  8224     4 */
		struct callback_head rcu;                /*  8224    16 */
	};                                               /*  8224    16 */
	struct pipe_inode_info *   splice_pipe;          /*  8240     8 */
	struct page_frag           task_frag;            /*  8248    16 */
	/* --- cacheline 129 boundary (8256 bytes) was 8 bytes ago --- */
	struct task_delay_info *   delays;               /*  8264     8 */
	int                        make_it_fail;         /*  8272     4 */
	unsigned int               fail_nth;             /*  8276     4 */
	int                        nr_dirtied;           /*  8280     4 */
	int                        nr_dirtied_pause;     /*  8284     4 */
	long unsigned int          dirty_paused_when;    /*  8288     8 */
	int                        latency_record_count; /*  8296     4 */

	/* XXX 4 bytes hole, try to pack */

	struct latency_record      latency_record[32];   /*  8304  3840 */
	/* --- cacheline 189 boundary (12096 bytes) was 48 bytes ago --- */
	u64                        timer_slack_ns;       /* 12144     8 */
	u64                        default_timer_slack_ns; /* 12152     8 */
	/* --- cacheline 190 boundary (12160 bytes) --- */
	unsigned int               kasan_depth;          /* 12160     4 */
	int                        curr_ret_stack;       /* 12164     4 */
	int                        curr_ret_depth;       /* 12168     4 */

	/* XXX 4 bytes hole, try to pack */

	struct ftrace_ret_stack *  ret_stack;            /* 12176     8 */
	long long unsigned int     ftrace_timestamp;     /* 12184     8 */
	atomic_t                   trace_overrun;        /* 12192     4 */
	atomic_t                   tracing_graph_pause;  /* 12196     4 */
	long unsigned int          trace;                /* 12200     8 */
	long unsigned int          trace_recursion;      /* 12208     8 */
	struct mem_cgroup *        memcg_in_oom;         /* 12216     8 */
	/* --- cacheline 191 boundary (12224 bytes) --- */
	gfp_t                      memcg_oom_gfp_mask;   /* 12224     4 */
	int                        memcg_oom_order;      /* 12228     4 */
	unsigned int               memcg_nr_pages_over_high; /* 12232     4 */

	/* XXX 4 bytes hole, try to pack */

	struct mem_cgroup *        active_memcg;         /* 12240     8 */
	struct request_queue *     throttle_queue;       /* 12248     8 */
	struct uprobe_task *       utask;                /* 12256     8 */
	unsigned int               sequential_io;        /* 12264     4 */
	unsigned int               sequential_io_avg;    /* 12268     4 */
	struct kmap_ctrl           kmap_ctrl;            /* 12272     0 */
	long unsigned int          task_state_change;    /* 12272     8 */
	int                        pagefault_disabled;   /* 12280     4 */

	/* XXX 4 bytes hole, try to pack */

	/* --- cacheline 192 boundary (12288 bytes) --- */
	struct task_struct *       oom_reaper_list;      /* 12288     8 */
	struct vm_struct *         stack_vm_area;        /* 12296     8 */
	refcount_t                 stack_refcount;       /* 12304     4 */
	int                        patch_state;          /* 12308     4 */
	void *                     security;             /* 12312     8 */
	void *                     mce_vaddr;            /* 12320     8 */
	__u64                      mce_kflags;           /* 12328     8 */
	u64                        mce_addr;             /* 12336     8 */
	__u64                      mce_ripv:1;           /* 12344: 0  8 */
	__u64                      mce_whole_page:1;     /* 12344: 1  8 */
	__u64                      __mce_reserved:62;    /* 12344: 2  8 */
	/* --- cacheline 193 boundary (12352 bytes) --- */
	struct callback_head       mce_kill_me;          /* 12352    16 */
	struct llist_head          kretprobe_instances;  /* 12368     8 */

	/* XXX 40 bytes hole, try to pack */

	/* --- cacheline 194 boundary (12416 bytes) --- */
	struct thread_struct       thread;               /* 12416  4352 */

	/* size: 16768, cachelines: 262, members: 252 */
	/* sum members: 16579, holes: 22, sum holes: 173 */
	/* sum bitfield members: 77 bits, bit holes: 2, sum bit holes: 51 bits */
	/* paddings: 4, sum paddings: 21 */
};
[root@seventh ~]#
[root@seventh ~]# pahole --sizes /sys/kernel/btf/ixgbe | grep ^ixgbe | sort -k3 -nr
ixgbe_adapter	108096	13
ixgbe_ring	320	3
ixgbe_q_vector	1600	2
ixgbe_phy_info	288	2
ixgbe_dcb_config	296	2
ixgbe_reg_info	16	1
ixgbe_nvm_version	20	1
ixgbe_mat_field	24	1
ixgbe_jump_table	288	1
ixgbe_ipsec	8224	1
ixgbe_info	64	1
ixgbe_hw	1760	1
ixgbe_fdir_filter	72	1
ixgbe_fcoe_ddp	48	1
ixgbe_fcoe	98424	1
ixgbe_fc_info	80	1
ixgbe_tx_queue_stats	24	0
ixgbe_tx_buffer	48	0
ixgbe_thermal_sensor_data	12	0
ixgbe_thermal_diode_data	4	0
ixgbe_stats	44	0
ixgbe_rx_queue_stats	56	0
ixgbe_rx_buffer	32	0
ixgbe_ring_feature	64	0
ixgbe_ring_container	32	0
ixgbe_reg_test	12	0
ixgbe_queue_stats	16	0
ixgbe_phy_operations	184	0
ixgbe_nexthdr	32	0
ixgbe_mbx_stats	20	0
ixgbe_mbx_operations	64	0
ixgbe_mbx_info	48	0
ixgbe_mac_operations	544	0
ixgbe_mac_info	1144	0
ixgbe_mac_addr	10	0
ixgbe_link_operations	32	0
ixgbe_link_info	40	0
ixgbe_ipsec_tx_data	8	0
ixgbe_hw_stats	1768	0
ixgbe_hic_write_shadow_ram	16	0
ixgbe_hic_read_shadow_ram	16	0
ixgbe_hic_phy_token_req	8	0
ixgbe_hic_phy_activity_resp	20	0
ixgbe_hic_phy_activity_req	24	0
ixgbe_hic_internal_phy_resp	8	0
ixgbe_hic_internal_phy_req	16	0
ixgbe_hic_hdr	4	0
ixgbe_hic_hdr2_rsp	4	0
ixgbe_hic_hdr2_req	4	0
ixgbe_hic_hdr2	4	0
ixgbe_hic_drv_info2	48	0
ixgbe_hic_drv_info	12	0
ixgbe_hic_disable_rxen	8	0
ixgbe_fwd_adapter	536	0
ixgbe_fcoe_ddp_pool	24	0
ixgbe_eeprom_operations	64	0
ixgbe_eeprom_info	80	0
ixgbe_cb	24	0
ixgbe_bus_info	16	0
ixgbe_atr_input	44	0
ixgbe_atr_hash_dword	4	0
ixgbe_adv_tx_desc	16	0
ixgbe_adv_tx_context_desc	16	0
ixgbe_adv_rx_desc	16	0
ixgbe_addr_filter_info	20	0
[root@seventh ~]# 
[root@seventh ~]# pahole -C ixgbe_ring /sys/kernel/btf/ixgbe
struct ixgbe_ring {
	struct ixgbe_ring *        next;                 /*     0     8 */
	struct ixgbe_q_vector *    q_vector;             /*     8     8 */
	struct net_device *        netdev;               /*    16     8 */
	struct bpf_prog *          xdp_prog;             /*    24     8 */
	struct device *            dev;                  /*    32     8 */
	void *                     desc;                 /*    40     8 */
	union {
		struct ixgbe_tx_buffer * tx_buffer_info; /*    48     8 */
		struct ixgbe_rx_buffer * rx_buffer_info; /*    48     8 */
	};                                               /*    48     8 */
	long unsigned int          state;                /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	u8 *                       tail;                 /*    64     8 */
	dma_addr_t                 dma;                  /*    72     8 */
	unsigned int               size;                 /*    80     4 */
	u16                        count;                /*    84     2 */
	u8                         queue_index;          /*    86     1 */
	u8                         reg_idx;              /*    87     1 */
	u16                        next_to_use;          /*    88     2 */
	u16                        next_to_clean;        /*    90     2 */

	/* XXX 4 bytes hole, try to pack */

	long unsigned int          last_rx_timestamp;    /*    96     8 */
	union {
		u16                next_to_alloc;        /*   104     2 */
		struct {
			u8         atr_sample_rate;      /*   104     1 */
			u8         atr_count;            /*   105     1 */
		};                                       /*   104     2 */
	};                                               /*   104     2 */
	u8                         dcb_tc;               /*   106     1 */

	/* XXX 5 bytes hole, try to pack */

	struct ixgbe_queue_stats   stats;                /*   112    16 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	struct u64_stats_sync      syncp;                /*   128     0 */
	union {
		struct ixgbe_tx_queue_stats tx_stats;    /*   128    24 */
		struct ixgbe_rx_queue_stats rx_stats;    /*   128    56 */
	};                                               /*   128    56 */

	/* XXX 8 bytes hole, try to pack */

	/* --- cacheline 3 boundary (192 bytes) --- */
	struct xdp_rxq_info        xdp_rxq;              /*   192    64 */

	/* XXX last struct has 36 bytes of padding */

	/* --- cacheline 4 boundary (256 bytes) --- */
	struct xsk_buff_pool *     xsk_pool;             /*   256     8 */
	u16                        ring_idx;             /*   264     2 */
	u16                        rx_buf_len;           /*   266     2 */

	/* size: 320, cachelines: 5, members: 26 */
	/* sum members: 251, holes: 3, sum holes: 17 */
	/* padding: 52 */
	/* paddings: 1, sum paddings: 36 */
};
[root@seventh ~]#
[root@seventh ~]# readelf -wi /lib/modules/`uname -r`/build/vmlinux | grep -m2 producer
    <1c>   DW_AT_producer    : (indirect string, offset: 0x51): GNU AS 2.35.1
    <2f>   DW_AT_producer    : (indirect string, offset: 0x124a): GNU C89 11.0.0 20210123 (Red Hat 11.0.0-0) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mrecord-mcount -mfentry -march=x86-64 -g -O2 -std=gnu90 -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -falign-jumps=1 -falign-loops=1 -fno-asynchronous-unwind-tables -fno-jump-tables -fno-delete-null-pointer-checks -fno-allow-store-data-races -fno-strict-overflow -fstack-check=no -fconserve-stack -fcf-protection=none -fno-stack-protector -fno-builtin
[root@seventh ~]#

Using btfdiff to recreate the types from BTF and then from DWARF and then compare the output:

[root@seventh ~]# ~acme/git/pahole/btfdiff /lib/modules/`uname -r`/build/vmlinux
[root@seventh ~]#

Same thing. I'll do more tests after some errands, but I've put the pre-release
rpm packages for 1.20 at:

http://vger.kernel.org/~acme/pahole/rpms/1.20-0/RPMS/x86_64/Packages/

Can you please try it with gcc 11?

- Arnaldo
