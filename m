Return-Path: <bpf+bounces-2990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A882B737E08
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 11:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B435B1C20E25
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39552C8E2;
	Wed, 21 Jun 2023 09:10:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABD2C8C7
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 09:10:07 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD271B4
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 02:10:04 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230621091003euoutp0287b531ab72189cbd2d5a5ca1f4575d6f~qoYUL81ty0778307783euoutp02g
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 09:10:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230621091003euoutp0287b531ab72189cbd2d5a5ca1f4575d6f~qoYUL81ty0778307783euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1687338603;
	bh=dVX38NvYQpq3apgVKZU22xdcef1kpF1RLqHX48qUVYo=;
	h=From:To:CC:Subject:Date:References:From;
	b=dJsCF+4qehoykQ0AW2qScZBciXMzhOrq2KWa+o5cCuHWP6qGLGzMI1EFieVW/mZIV
	 rBtSwe8srG43glwZaVe5S7pgwUYpxfNN4gtxOpHegt+BJ8ySIzPYGPQL1MXUtdzv3h
	 VCWvh4Yxpck2lmkHh/9GnWlf5s0Og2DY62lzbHq4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230621091003eucas1p10086211e1487555b90658b5c9c90e4e2~qoYUFWcjM1958619586eucas1p10;
	Wed, 21 Jun 2023 09:10:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 0F.12.42423.A6EB2946; Wed, 21
	Jun 2023 10:10:02 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230621091002eucas1p28cbe3260b7d4c2a086f0b5ac79a7f038~qoYTqYpNH1816318163eucas1p2j;
	Wed, 21 Jun 2023 09:10:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230621091002eusmtrp2d2042c11b1a39ca581f42aa4e93e6182~qoYTp1HH72182221822eusmtrp2R;
	Wed, 21 Jun 2023 09:10:02 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-02-6492be6a7135
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 53.D1.14344.A6EB2946; Wed, 21
	Jun 2023 10:10:02 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230621091002eusmtip149da010cbd9e27bd73feeba9b62c8347~qoYTYNHcL2784427844eusmtip1B;
	Wed, 21 Jun 2023 09:10:02 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 21 Jun 2023 10:10:01 +0100
From: Joel Granados <j.granados@samsung.com>
To: <mcgrof@kernel.org>
CC: Joel Granados <j.granados@samsung.com>, <bpf@vger.kernel.org>
Subject: [PATCH 00/11] Remove the end element in sysctl table arrays.
Date: Wed, 21 Jun 2023 11:09:49 +0200
Message-ID: <20230621091000.424843-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7djPc7pZ+yalGCxfZGnx+chxNosbE54y
	OjB5bFrVyebxeZNcAFMUl01Kak5mWWqRvl0CV8b05XtYC/Z2MFWsvNrE0sD4o7SLkZNDQsBE
	omHBMpYuRi4OIYEVjBK/J09mh3C+MEqcmfOJGaRKSOAzo8TtA4EwHXv/bmKDiC9nlFjxQxKi
	AahmWncLM4SzlVHi5aXb7CBVbAI6Euff3AGbJCIgLnHi9GZGEJtZwFHi0o+XQDYHh7CAq8TW
	baogYRYBVYmGZXdYQMK8AjYS87ptIPbKS7Rdnw7WySsgKHFy5hMWiCnyEs1bZzND1ChLXN+3
	mA3CrpU4teUWE8g5EgIzOSQ+X1vAApFwkXj35T1UkbDEq+Nb2CFsGYn/O+dDNUxmlNj/7wM7
	hLOaUWJZ41cmiCpriZYrT9hBrmMW0JRYv0sfIuwo8e3fLTaQsIQAn8SNt4IQx/FJTNo2nRki
	zCvR0SYEUa0msfreG5YJjMqzkLwzC8k7sxDmL2BkXsUonlpanJueWmyYl1quV5yYW1yal66X
	nJ+7iRGYGk7/O/5pB+PcVx/1DjEycTAeYpTgYFYS4ZXdNClFiDclsbIqtSg/vqg0J7X4EKM0
	B4uSOK+27clkIYH0xJLU7NTUgtQimCwTB6dUA1OexDkfBU4Rh98bV/1Z6v5ouf6Rh9sygpJ1
	jI4YxxtKZpQLyDi4n/DJeC57ZT338v8zXfzFlRJ+/c0565MQ/dP0TKBxsHCnxSKRzys+HVFi
	2MCzLqf1DNPzCV8sfVVCzezUXu8zfrOTI3zJCuOcpnNX8xzlPWKUTt7MtEiXeWBdqnSpTcH2
	NBtj86qGnqyX9k3Fe3r/C+g/Wv118szGFs2L34XXZDxf9+aWf33DtOvx+3ZJf/qX7mCtEaF/
	rDb90rxpzx4wXdSVMpQ3rQ+0LK2Z6nE+bZKIoAKz5X0NJqO7U88/zOfYFGLqOeHFqsNnyhTb
	fD5/DbQ5G2dduuPPod+LAxXkLFYeKDZRf75lqxJLcUaioRZzUXEiAPc1R/F8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsVy+t/xu7pZ+yalGOz7J23x+chxNosbE54y
	OjB5bFrVyebxeZNcAFOUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1K
	ak5mWWqRvl2CXsb05XtYC/Z2MFWsvNrE0sD4o7SLkZNDQsBEYu/fTWxdjFwcQgJLGSW2zl7M
	BJGQkdj45SorhC0s8edaF1TRR0aJQ5emsEI4Wxkljv49xQ5SxSagI3H+zR1mEFtEQFzixOnN
	jCA2s4CjxKUfL4FsDg5hAVeJrdtUQcIsAqoSDcvusICEeQVsJOZ120Dskpdouz4drJpZQFNi
	/S59kDCvgKDEyZlPWCAGyks0b53NDFGuLHF932I2CLtW4vPfZ4wTGIVmIXTPQtI9C0n3Akbm
	VYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGRsO3Yzy07GFe++qh3iJGJg/EQowQHs5IIr+ym
	SSlCvCmJlVWpRfnxRaU5qcWHGE2BnpnILCWanA+MxbySeEMzA1NDEzNLA1NLM2MlcV7Pgo5E
	IYH0xJLU7NTUgtQimD4mDk6pBib1uSHH+EJMvTuFluiv4i00ZOG+e8hwyRKNOKGzFkJiF9ri
	nfTe+ARtte/p15Gd2570rVnt05Xdh1Zu8XFyaDGsUqhoV5nDOUfm+mSNvQL/7i4UfV1UsvaP
	k7GF4QIGjcX/cpXKfE5sdGsKPdWfPuPI8kTOCaZbVZJvMdw/cjM4ZXM2Y9zcwvwlXndlQ9qN
	6pv9tfOWn05NmXrpy8/Xze0BOk847/T9ZdjG9pEjMGyjnrpSksvzpzd8Em6ukLFK/61k9+tE
	TpXRiphI1hfPHy5tFxfWeyxit/l6O5e2+Y7I2/la1a+Xasos49QSuy7luYhNxW6Cxe2DH/Xm
	9gl3R5gHcx/w4NvfKSdybvJHJZbijERDLeai4kQAETJrjQ0DAAA=
X-CMS-MailID: 20230621091002eucas1p28cbe3260b7d4c2a086f0b5ac79a7f038
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230621091002eucas1p28cbe3260b7d4c2a086f0b5ac79a7f038
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091002eucas1p28cbe3260b7d4c2a086f0b5ac79a7f038
References: <CGME20230621091002eucas1p28cbe3260b7d4c2a086f0b5ac79a7f038@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is part of the effort to remove the empty element from the ctl_table
structures (used to calculate size) and replace it with the ARRAY_SIZE macro.
The "sysctl: Remove the end element in sysctl table arrays" commit is the one that
actually removes the empty element. With a "yesall" configuration the bloat-o-meter
says that 9158 bytes where saved (report at the end of the cover letter).

Main changes:
1. Add the ctl_table size into the ctl_table_header
2. Remove the empty element at the end of all ctl_table arrays

Commit Overview:
1. There are preparation commits that make sure that we have the
   ctl_table_header in all the places that we need to have the array size.
      sysctl: Prefer ctl_table_header in proc_sysct
      sysctl: Use the ctl header in list ctl_table macro
      sysctl: Add ctl_table_size to ctl_table_header

2. Add size to relevant register calls. Calculate the ctl_table array size
   where register_sysctl is called. Add a table_size argument to the relevant
   sysctl register functions (init_header, __register_sysctl_table,
   register_net_sysctl, register_sysctl and register_sysctl_init). Important to
   note that these commits do NOT change the way we calculate size; they plumb
   things in preparation for the empty element removal commit. Care is taken to
   leave the tree in a state where it can be compiled which is the reason to
   not separate the "big" commits (like "sysctl: Add size to the
   register_net_sysctl function"). If you have an alternative way of dealing
   with such a big commit while leaving it in a compilable state, please let me
   know.
      sysctl: Add size argument to init_header
      sysctl: Add a size arg to __register_sysctl_table
      sysctl: Add size to the register_net_sysctl function
      sysctl: Add size to register_sysctl
      sysctl: Add size to register_sysctl_init

3. Do the final empty element remove. This commit both removes the empty final
   element from the ctl_table array and switches to managing array size with
   the ctl_table_header size. This is also a "big" commit; please get back to
   me if you have an alternate way of handling it.
      sysctl: Remove the end element in sysctl table arrays

4. Clean things up by removing things that no longer make sense logically.
      sysctl: Remove nr_entries from new_links
      sysctl: rm "child" from __register_sysctl_table doc

Additional Comments:
1. Still waiting on 0-day to tell me what I missed. Will address any issues in
   a V2 if necessary.

2. @mcgrof: let me know if you have any way of making the big commits a bit
   more digestible. You have done some of these big patches before and maybe
   you have a trick that make reviewing easier.

Comments/feedback greatly appreciated

Best
Joel

add/remove: 6/1 grow/shrink: 155/160 up/down: 3391/-12549 (-9158)
Function                                     old     new   delta
nf_conntrack_standalone_init_sysctl.constprop       -    1438   +1438
new_links                                    926    1083    +157
get_links                                    505     659    +154
drop_sysctl_table                            797     869     +72
put_links                                   1079    1149     +70
__pfx_nf_conntrack_standalone_init_sysctl.constprop       -      64     +64
__pfx_ipv6_route_sysctl_table_size             -      64     +64
__pfx_ipv6_icmp_sysctl_table_size              -      64     +64
sysctl_check_table                          1039    1090     +51
insert_header                               1068    1119     +51
ipv6_route_sysctl_table_size                   -      40     +40
ipv6_icmp_sysctl_table_size                    -      40     +40
ipv6_sysctl_net_init                         509     536     +27
test_sysctl_init                             767     786     +19
setup_sysctl_set                             212     228     +16
__register_sysctl_init                       153     169     +16
nf_log_net_init                              856     871     +15
smc_sysctl_net_init                          485     498     +13
unix_sysctl_register                         262     274     +12
sysctl_init_bases                             93     105     +12
sysctl_core_net_init                         363     375     +12
register_sysctl                               74      86     +12
register_net_sysctl                          114     126     +12
mptcp_net_init                               640     652     +12
ipv4_sysctl_init_net                         537     549     +12
ipmi_poweroff_init                           288     300     +12
__ip_vs_lblcr_init                           523     535     +12
__ip_vs_lblc_init                            523     535     +12
init_nlm                                     205     216     +11
xpc_init                                    1060    1070     +10
xfrm6_net_init                               393     403     +10
xfrm4_net_init                               393     403     +10
sysctl_route_net_init                        469     479     +10
pid_namespaces_init                          146     156     +10
parport_proc_register                        804     814     +10
ip_vs_control_net_init_sysctl               2387    2397     +10
ucma_init                                    378     387      +9
sched_set_itmt_support                       156     165      +9
rpc_register_sysctl                          137     146      +9
reboot_ksysfs_init                           205     214      +9
parport_default_proc_register                176     185      +9
page_writeback_init                          192     201      +9
nf_conntrack_standalone_init                 293     302      +9
lowpan_net_frag_init                         479     488      +9
llc_sysctl_init                              294     303      +9
iw_cm_init                                   305     314      +9
ipv6_sysctl_register                         194     203      +9
ipv6_frag_init                               550     559      +9
init_devpts_fs                               120     129      +9
hpet_init                                    244     253      +9
coda_sysctl_init                             137     146      +9
xprt_rdma_init                               208     215      +7
xfs_sysctl_register                           97     104      +7
xfrm_sysctl_init                             391     398      +7
x25_register_sysctl                          106     113      +7
utsname_sysctl_init                           58      65      +7
tipc_register_sysctl                         106     113      +7
timer_sysctl_init                             58      65      +7
sysctl_ipv4_init                             137     144      +7
sysctl_core_init                              84      91      +7
sld_mitigate_sysctl_init                      67      74      +7
setup_userns_sysctls                         332     339      +7
setup_ipc_sysctls                            721     728      +7
seccomp_sysctl_init                           67      74      +7
sctp_sysctl_register                          92      99      +7
scsi_init_sysctl                              97     104      +7
sched_rt_sysctl_init                          48      55      +7
sched_fair_sysctl_init                        48      55      +7
sched_energy_aware_sysctl_init                48      55      +7
sched_dl_sysctl_init                          48      55      +7
sched_core_sysctl_init                        48      55      +7
rxrpc_sysctl_init                            106     113      +7
rose_register_sysctl                          92      99      +7
register_firmware_config_sysctl               97     104      +7
rds_sysctl_init                              152     159      +7
rds_ib_sysctl_init                           106     113      +7
random_sysctls_init                           67      74      +7
printk_sysctl_init                            65      72      +7
phonet_sysctl_init                           106     113      +7
ntfs_sysctl                                  193     200      +7
nr_register_sysctl                           106     113      +7
nfs_register_sysctl                           97     104      +7
nfs4_register_sysctl                          97     104      +7
nf_ct_net_init                               624     631      +7
mpls_net_init                                360     367      +7
memory_failure_sysctl_init                    67      74      +7
mac_hid_init                                  97     104      +7
lowpan_frags_init_net                        594     601      +7
lockup_detector_init                         293     300      +7
kexec_core_sysctl_init                        67      74      +7
kernel_panic_sysctls_init                     67      74      +7
kernel_lockdep_sysctls_init                   43      50      +7
kernel_exit_sysctls_init                      67      74      +7
kernel_do_mounts_initrd_sysctls_init          67      74      +7
kernel_delayacct_sysctls_init                 67      74      +7
kernel_acct_sysctls_init                      67      74      +7
ipv6_frags_init_net                          543     550      +7
ipv4_frags_init_net                          612     619      +7
ipfrag_init                                  415     422      +7
ip_static_sysctl_init                         67      74      +7
init_umh_sysctls                              67      74      +7
init_socket_xprt                             165     172      +7
init_signal_sysctls                           67      74      +7
init_security_keys_sysctls                    67      74      +7
init_pipe_fs                                 191     198      +7
init_kprobes                                 968     975      +7
init_fs_sysctls                               67      74      +7
init_fs_stat_sysctls                          87      94      +7
init_fs_namespace_sysctls                     67      74      +7
init_fs_namei_sysctls                         67      74      +7
init_fs_locks_sysctls                         67      74      +7
init_fs_inode_sysctls                         67      74      +7
init_fs_exec_sysctls                          67      74      +7
init_fs_dcache_sysctls                        67      74      +7
init_fs_coredump_sysctls                      67      74      +7
ia32_binfmt_init                              39      46      +7
i915_perf_sysctl_register                     83      90      +7
ftrace_sysctl_init                            64      71      +7
dccp_sysctl_init                             106     113      +7
cachefiles_register_error_injection           97     104      +7
bpf_syscall_sysctl_init                       67      74      +7
atalk_register_sysctl                        106     113      +7
net_sysctl_init                              210     216      +6
yama_init                                    123     128      +5
vrf_netns_init                               334     339      +5
userfaultfd_init                             167     172      +5
tty_init                                     490     495      +5
trace_events_user_init                      1031    1036      +5
svc_rdma_init                                774     779      +5
rds_tcp_init_net                             657     662      +5
parport_device_proc_register                 519     524      +5
oom_init                                     143     148      +5
ocfs2_stack_glue_init                        354     359      +5
md_init                                      608     613      +5
loadpin_init                                 584     589      +5
kcompactd_init                               285     290      +5
inotify_user_setup                           488     493      +5
init_sg                                      873     878      +5
init_lstats_procfs                            95     100      +5
hv_common_init                               897     902      +5
hung_task_init                               193     198      +5
hugetlb_vmemmap_init                         379     384      +5
hugetlb_init                                3630    3635      +5
fsverity_init_signature                      309     314      +5
fanotify_user_setup                          609     614      +5
eventpoll_init                               491     496      +5
dquot_init                                   554     559      +5
dnotify_init                                 264     269      +5
devinet_init_net                            1129    1134      +5
cdrom_sysctl_register                        627     632      +5
brnf_init_net                                502     507      +5
balloon_init                                1092    1097      +5
ax25_register_dev_sysctl                     370     375      +5
autogroup_init                               105     110      +5
apparmor_init                               1075    1080      +5
aio_setup                                    263     268      +5
__devinet_sysctl_register                    439     444      +5
setup_mq_sysctls                             495     499      +4
register_sysctl_mount_point                   73      77      +4
user_namespace_sysctl_init                   394     396      +2
nf_conntrack_pernet_init.cold                 25      26      +1
__register_sysctl_table                      700     682     -18
__addrconf_sysctl_register                   673     650     -23
new_dir                                      506     480     -26
sctp_sysctl_net_register                     385     351     -34
neigh_sysctl_register                        846     807     -39
mpls_dev_sysctl_register                     460     408     -52
yama_sysctl_table                            128      64     -64
xs_tunables_table                            448     384     -64
xr_tunables_table                            448     384     -64
xpc_sys_xpc_hb                               192     128     -64
xpc_sys_xpc                                  128      64     -64
xfs_table                                   1024     960     -64
xfrm_table                                   320     256     -64
xfrm6_policy_table                           128      64     -64
xfrm4_policy_table                           128      64     -64
x25_table                                    448     384     -64
watchdog_sysctls                             640     576     -64
vs_vars                                     1984    1920     -64
vrf_table                                    128      64     -64
vm_userfaultfd_table                         128      64     -64
vm_table                                    1856    1792     -64
vm_page_writeback_sysctls                    512     448     -64
vm_oom_kill_table                            256     192     -64
vm_compaction                                320     256     -64
uts_kern_table                               448     384     -64
usermodehelper_table                         192     128     -64
user_table                                   832     768     -64
user_event_sysctls                           128      64     -64
unix_table                                   128      64     -64
ucma_ctl_table                               128      64     -64
tty_table                                    192     128     -64
tipc_table                                   448     384     -64
timer_sysctl                                 128      64     -64
test_table_unregister                        128      64     -64
test_table                                   576     512     -64
svcrdma_parm_table                           832     768     -64
smc_table                                    384     320     -64
sld_sysctls                                  128      64     -64
signal_debug_table                           128      64     -64
sg_sysctls                                   128      64     -64
seccomp_sysctl_table                         192     128     -64
sctp_table                                   256     192     -64
sctp_net_table                              2304    2240     -64
scsi_table                                   128      64     -64
sched_rt_sysctls                             256     192     -64
sched_fair_sysctls                           256     192     -64
sched_energy_aware_sysctls                   128      64     -64
sched_dl_sysctls                             192     128     -64
sched_core_sysctls                           384     320     -64
sched_autogroup_sysctls                      128      64     -64
rxrpc_sysctl_table                           704     640     -64
rose_table                                   704     640     -64
root_table                                   128      64     -64
rds_tcp_sysctl_table                         192     128     -64
rds_sysctl_rds_table                         384     320     -64
rds_ib_sysctl_table                          384     320     -64
random_table                                 448     384     -64
raid_table                                   192     128     -64
pty_table                                    256     192     -64
printk_sysctls                               512     448     -64
pid_ns_ctl_table_vm                          128      64     -64
pid_ns_ctl_table                             128      64     -64
phonet_table                                 128      64     -64
ocfs2_nm_table                               128      64     -64
oa_table                                     192     128     -64
ntfs_sysctls                                 128      64     -64
nr_table                                     832     768     -64
nlm_sysctls                                  448     384     -64
nfs_cb_sysctls                               192     128     -64
nfs4_cb_sysctls                              192     128     -64
nf_log_sysctl_table                          768     704     -64
nf_log_sysctl_ftable                         128      64     -64
nf_ct_sysctl_table                          3200    3136     -64
nf_ct_netfilter_table                        128      64     -64
nf_ct_frag6_sysctl_table                     256     192     -64
netns_core_table                             256     192     -64
net_core_table                              2240    2176     -64
neigh_sysctl_template                       1416    1352     -64
namei_sysctls                                320     256     -64
mq_sysctls                                   384     320     -64
mptcp_sysctl_table                           448     384     -64
mpls_table                                   256     192     -64
mpls_dev_table                               128      64     -64
memory_failure_table                         192     128     -64
mac_hid_files                                256     192     -64
lowpan_frags_ns_ctl_table                    256     192     -64
lowpan_frags_ctl_table                       128      64     -64
locks_sysctls                                192     128     -64
loadpin_sysctl_table                         128      64     -64
llc_station_table                             64       -     -64
llc2_timeout_table                           320     256     -64
latencytop_sysctl                            128      64     -64
kprobe_sysctls                               128      64     -64
key_sysctls                                  448     384     -64
kexec_core_sysctls                           256     192     -64
kern_table                                  2560    2496     -64
kern_reboot_table                            192     128     -64
kern_panic_table                             192     128     -64
kern_lockdep_table                           192     128     -64
kern_exit_table                              128      64     -64
kern_do_mounts_initrd_table                  128      64     -64
kern_delayacct_table                         128      64     -64
kern_acct_table                              128      64     -64
iwcm_ctl_table                               128      64     -64
itmt_kern_table                              128      64     -64
ipv6_table_template                         1344    1280     -64
ipv6_route_table_template                    768     704     -64
ipv6_rotable                                 320     256     -64
ipv6_icmp_table_template                     448     384     -64
ipv4_table                                  1024     960     -64
ipv4_route_table                             832     768     -64
ipv4_route_netns_table                       320     256     -64
ipv4_net_table                              7296    7232     -64
ipmi_table                                   128      64     -64
ipc_sysctls                                  832     768     -64
ip6_frags_ns_ctl_table                       256     192     -64
ip6_frags_ctl_table                          128      64     -64
ip4_frags_ns_ctl_table                       320     256     -64
ip4_frags_ctl_table                          128      64     -64
inotify_table                                256     192     -64
inodes_sysctls                               192     128     -64
hv_ctl_table                                 128      64     -64
hung_task_sysctls                            448     384     -64
hugetlb_vmemmap_sysctls                      128      64     -64
hugetlb_table                                320     256     -64
hpet_table                                   128      64     -64
ftrace_sysctls                               128      64     -64
fsverity_sysctl_table                        128      64     -64
fs_stat_sysctls                              256     192     -64
fs_shared_sysctls                            192     128     -64
fs_pipe_sysctls                              256     192     -64
fs_namespace_sysctls                         128      64     -64
fs_exec_sysctls                              128      64     -64
fs_dqstats_table                             576     512     -64
fs_dcache_sysctls                            128      64     -64
firmware_config_table                        192     128     -64
fanotify_table                               256     192     -64
epoll_table                                  128      64     -64
dnotify_sysctls                              128      64     -64
devinet_sysctl                              2184    2120     -64
debug_table                                  384     320     -64
dccp_default_table                           576     512     -64
ctl_forward_entry                            128      64     -64
coredump_sysctls                             256     192     -64
coda_table                                   256     192     -64
cdrom_table                                  448     384     -64
cachefiles_sysctls                           128      64     -64
brnf_table                                   448     384     -64
bpf_syscall_table                            192     128     -64
balloon_table                                128      64     -64
ax25_param_table                             960     896     -64
atalk_table                                  320     256     -64
apparmor_sysctl_table                        192     128     -64
aio_sysctls                                  192     128     -64
addrconf_sysctl                             3776    3712     -64
abi_table2                                   128      64     -64
vs_vars_table                                256     128    -128
parport_sysctl_template                      912     720    -192
parport_default_sysctl_table                 584     136    -448
parport_device_sysctl_template               776     136    -640
nf_conntrack_pernet_init                    2073     724   -1349
Total: Before=430062205, After=430053047, chg -0.00%

Joel Granados (11):
  sysctl: Prefer ctl_table_header in proc_sysctl
  sysctl: Use the ctl header in list ctl_table macro
  sysctl: Add ctl_table_size to ctl_table_header
  sysctl: Add size argument to init_header
  sysctl: Add a size arg to __register_sysctl_table
  sysctl: Add size to register_net_sysctl function
  sysctl: Add size to register_sysctl
  sysctl: Add size to register_sysctl_init
  sysctl: Remove the end element in sysctl table arrays
  sysctl: Remove nr_entries from new_links
  sysctl: rm "child" from __register_sysctl_table doc

 arch/arm/kernel/isa.c                         |   6 +-
 arch/arm64/kernel/armv8_deprecated.c          |  10 +-
 arch/arm64/kernel/fpsimd.c                    |  12 +-
 arch/arm64/kernel/process.c                   |   6 +-
 arch/ia64/kernel/crash.c                      |   6 +-
 arch/powerpc/kernel/idle.c                    |   6 +-
 arch/powerpc/platforms/pseries/mobility.c     |   6 +-
 arch/s390/appldata/appldata_base.c            |  11 +-
 arch/s390/kernel/debug.c                      |   6 +-
 arch/s390/kernel/topology.c                   |   6 +-
 arch/s390/mm/cmm.c                            |   6 +-
 arch/s390/mm/pgalloc.c                        |   6 +-
 arch/x86/entry/vdso/vdso32-setup.c            |   5 +-
 arch/x86/kernel/cpu/intel.c                   |   5 +-
 arch/x86/kernel/itmt.c                        |   6 +-
 crypto/fips.c                                 |   6 +-
 drivers/base/firmware_loader/fallback_table.c |   9 +-
 drivers/cdrom/cdrom.c                         |   6 +-
 drivers/char/hpet.c                           |  16 +--
 drivers/char/ipmi/ipmi_poweroff.c             |   6 +-
 drivers/char/random.c                         |   6 +-
 drivers/gpu/drm/i915/i915_perf.c              |  36 ++---
 drivers/hv/hv_common.c                        |   6 +-
 drivers/infiniband/core/iwcm.c                |   6 +-
 drivers/infiniband/core/ucma.c                |   7 +-
 drivers/macintosh/mac_hid.c                   |   6 +-
 drivers/md/md.c                               |   6 +-
 drivers/misc/sgi-xp/xpc_main.c                |  12 +-
 drivers/net/vrf.c                             |   6 +-
 drivers/parport/procfs.c                      |  53 ++++----
 drivers/perf/arm_pmuv3.c                      |   6 +-
 drivers/scsi/scsi_sysctl.c                    |   6 +-
 drivers/scsi/sg.c                             |   6 +-
 drivers/tty/tty_io.c                          |   5 +-
 drivers/xen/balloon.c                         |   6 +-
 fs/aio.c                                      |   5 +-
 fs/cachefiles/error_inject.c                  |   6 +-
 fs/coda/sysctl.c                              |   6 +-
 fs/coredump.c                                 |   6 +-
 fs/dcache.c                                   |   6 +-
 fs/devpts/inode.c                             |   6 +-
 fs/eventpoll.c                                |   5 +-
 fs/exec.c                                     |   6 +-
 fs/file_table.c                               |   6 +-
 fs/inode.c                                    |   5 +-
 fs/lockd/svc.c                                |   6 +-
 fs/locks.c                                    |   5 +-
 fs/namei.c                                    |   5 +-
 fs/namespace.c                                |   6 +-
 fs/nfs/nfs4sysctl.c                           |   6 +-
 fs/nfs/sysctl.c                               |   6 +-
 fs/notify/dnotify/dnotify.c                   |   6 +-
 fs/notify/fanotify/fanotify_user.c            |   6 +-
 fs/notify/inotify/inotify_user.c              |   6 +-
 fs/ntfs/sysctl.c                              |   6 +-
 fs/ocfs2/stackglue.c                          |   6 +-
 fs/pipe.c                                     |   6 +-
 fs/proc/proc_sysctl.c                         | 126 ++++++++----------
 fs/quota/dquot.c                              |   6 +-
 fs/sysctls.c                                  |   6 +-
 fs/userfaultfd.c                              |   6 +-
 fs/verity/signature.c                         |   7 +-
 fs/xfs/xfs_sysctl.c                           |   7 +-
 include/linux/sysctl.h                        |  30 +++--
 include/net/ipv6.h                            |   2 +
 include/net/net_namespace.h                   |   4 +-
 init/do_mounts_initrd.c                       |   6 +-
 ipc/ipc_sysctl.c                              |   7 +-
 ipc/mq_sysctl.c                               |   7 +-
 kernel/acct.c                                 |   6 +-
 kernel/bpf/syscall.c                          |   6 +-
 kernel/delayacct.c                            |   6 +-
 kernel/exit.c                                 |   6 +-
 kernel/hung_task.c                            |   6 +-
 kernel/kexec_core.c                           |   6 +-
 kernel/kprobes.c                              |   6 +-
 kernel/latencytop.c                           |   6 +-
 kernel/locking/lockdep.c                      |   6 +-
 kernel/panic.c                                |   6 +-
 kernel/pid_namespace.c                        |   6 +-
 kernel/pid_sysctl.h                           |   5 +-
 kernel/printk/sysctl.c                        |   6 +-
 kernel/reboot.c                               |   6 +-
 kernel/sched/autogroup.c                      |   6 +-
 kernel/sched/core.c                           |   6 +-
 kernel/sched/deadline.c                       |   6 +-
 kernel/sched/fair.c                           |   6 +-
 kernel/sched/rt.c                             |   6 +-
 kernel/sched/topology.c                       |   6 +-
 kernel/seccomp.c                              |   6 +-
 kernel/signal.c                               |   6 +-
 kernel/stackleak.c                            |   6 +-
 kernel/sysctl.c                               |  10 +-
 kernel/time/timer.c                           |   5 +-
 kernel/trace/ftrace.c                         |   6 +-
 kernel/trace/trace_events_user.c              |   6 +-
 kernel/ucount.c                               |  12 +-
 kernel/umh.c                                  |   6 +-
 kernel/utsname_sysctl.c                       |   5 +-
 kernel/watchdog.c                             |   6 +-
 lib/test_sysctl.c                             |  15 ++-
 mm/compaction.c                               |   5 +-
 mm/hugetlb.c                                  |   5 +-
 mm/hugetlb_vmemmap.c                          |   6 +-
 mm/memory-failure.c                           |   6 +-
 mm/oom_kill.c                                 |   6 +-
 mm/page-writeback.c                           |   6 +-
 net/appletalk/sysctl_net_atalk.c              |   7 +-
 net/ax25/sysctl_net_ax25.c                    |   8 +-
 net/bridge/br_netfilter_hooks.c               |   5 +-
 net/core/neighbour.c                          |  15 ++-
 net/core/sysctl_net_core.c                    |  11 +-
 net/dccp/sysctl.c                             |   7 +-
 net/ieee802154/6lowpan/reassembly.c           |  12 +-
 net/ipv4/devinet.c                            |  11 +-
 net/ipv4/ip_fragment.c                        |  12 +-
 net/ipv4/route.c                              |  12 +-
 net/ipv4/sysctl_net_ipv4.c                    |  12 +-
 net/ipv4/xfrm4_policy.c                       |   6 +-
 net/ipv6/addrconf.c                           |   8 +-
 net/ipv6/icmp.c                               |   8 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c       |   6 +-
 net/ipv6/reassembly.c                         |  12 +-
 net/ipv6/route.c                              |   8 +-
 net/ipv6/sysctl_net_ipv6.c                    |  19 +--
 net/ipv6/xfrm6_policy.c                       |   6 +-
 net/llc/sysctl_net_llc.c                      |  13 +-
 net/mpls/af_mpls.c                            |  75 ++++++-----
 net/mptcp/ctrl.c                              |   6 +-
 net/netfilter/ipvs/ip_vs_ctl.c                |   6 +-
 net/netfilter/ipvs/ip_vs_lblc.c               |   8 +-
 net/netfilter/ipvs/ip_vs_lblcr.c              |   8 +-
 net/netfilter/nf_conntrack_standalone.c       |  18 ++-
 net/netfilter/nf_log.c                        |  10 +-
 net/netrom/sysctl_net_netrom.c                |   6 +-
 net/phonet/sysctl.c                           |   7 +-
 net/rds/ib_sysctl.c                           |   7 +-
 net/rds/sysctl.c                              |   8 +-
 net/rds/tcp.c                                 |   6 +-
 net/rose/sysctl_net_rose.c                    |   7 +-
 net/rxrpc/sysctl.c                            |   6 +-
 net/sctp/sysctl.c                             |  17 ++-
 net/smc/smc_sysctl.c                          |   6 +-
 net/sunrpc/sysctl.c                           |   6 +-
 net/sunrpc/xprtrdma/svc_rdma.c                |   6 +-
 net/sunrpc/xprtrdma/transport.c               |   7 +-
 net/sunrpc/xprtsock.c                         |   7 +-
 net/sysctl_net.c                              |   6 +-
 net/tipc/sysctl.c                             |   6 +-
 net/unix/sysctl_net_unix.c                    |   6 +-
 net/x25/sysctl_net_x25.c                      |   7 +-
 net/xfrm/xfrm_sysctl.c                        |   6 +-
 security/apparmor/lsm.c                       |   7 +-
 security/keys/sysctl.c                        |   9 +-
 security/loadpin/loadpin.c                    |   6 +-
 security/yama/yama_lsm.c                      |   6 +-
 156 files changed, 696 insertions(+), 690 deletions(-)

-- 
2.30.2


