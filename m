Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119975756CB
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 23:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiGNVRm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 17:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGNVRl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 17:17:41 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FBB6D9C9
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 14:17:39 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26ELEIjU026848;
        Thu, 14 Jul 2022 21:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=3ZwJAjQxDRvNmwKIQwV+WWXocr9iQxWxbdKrg2Wj7m0=;
 b=oFAz2qifDanPfXq5+SOGtvmIQ1OrA2WFHHQp0N2ZVep0YQBDTAUOqyvU73Im0Fc4TYRQ
 wMKU9I79xNRKMG6+CgSfutbUImUeieLgf/aV1U8XcMm+J+QzJvK2TKPh/uUiJj20Zw8d
 /BxT+LH6KP0BbGu8xn6yFxbtmLBoWJNxoQx8OlH7M1VG27JVmQq6uH5C055wUeKG5/Pr
 iZB0G9YXUnq9DXRIMHLQyprhvKqYYwlcYdzS/vNXEPzcmyV0stZuTBdppdyTVwpkzetJ
 qPHB8gtNViSDP8l+uMqG8ci0FUuKPEvcfhMTr912RBUEjgdDif3UEZ+rUDaKLueIkvI0 Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hatvm01wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 21:17:21 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26ELEd6t030477;
        Thu, 14 Jul 2022 21:17:20 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hatvm01w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 21:17:20 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26EL6FAB003215;
        Thu, 14 Jul 2022 21:17:18 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3hama9gcjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 21:17:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26ELHGhf17826166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 21:17:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A065AE04D;
        Thu, 14 Jul 2022 21:17:16 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3061AE045;
        Thu, 14 Jul 2022 21:17:15 +0000 (GMT)
Received: from [9.171.0.102] (unknown [9.171.0.102])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jul 2022 21:17:15 +0000 (GMT)
Message-ID: <282d3d95c70903d96295906e4c794464b733cf9c.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Copy over libbpf configs
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel =?ISO-8859-1?Q?M=FCller?= <deso@posteo.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
Date:   Thu, 14 Jul 2022 23:17:15 +0200
In-Reply-To: <CAEf4BzbENk8szUM-pgdsxtOQaGseehxA5OwEDFAD-dOxFAUgsw@mail.gmail.com>
References: <20220712212124.3180314-1-deso@posteo.net>
         <20220712212124.3180314-2-deso@posteo.net>
         <CAADnVQLLNQHHJuqd-pKzU09Uw3N-kBsztPy0ysYEKVipP=yMqw@mail.gmail.com>
         <20220712215322.rw3z6eoix3yagi2q@muellerd-fedora-MJ0AC3F3>
         <Ys32tgTtkfeECzLc@google.com>
         <20220712230138.mmdw323h5dop5abe@muellerd-fedora-MJ0AC3F3>
         <CAEf4Bzb-=jPqApbHnN6xX5XR0eXs5kGS8pAxzOQuR95b5kXYSg@mail.gmail.com>
         <20220714143608.cuilkiirxo4f6bhz@nuc>
         <CAEf4BzbENk8szUM-pgdsxtOQaGseehxA5OwEDFAD-dOxFAUgsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BB48zmpuYvyqdz-G8zWj0hY-kOYI8Ios
X-Proofpoint-ORIG-GUID: aOflJsLwvOBEwjDCNm_QufLCLcbr1agG
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_17,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2022-07-14 at 11:20 -0700, Andrii Nakryiko wrote:
> On Thu, Jul 14, 2022 at 7:36 AM Daniel Müller <deso@posteo.net>
> wrote:
> > 
> > On Wed, Jul 13, 2022 at 09:48:32PM -0700, Andrii Nakryiko wrote:
> > > On Tue, Jul 12, 2022 at 4:01 PM Daniel Müller <deso@posteo.net>
> > > wrote:
> > > > 
> > > > On Tue, Jul 12, 2022 at 03:33:26PM -0700, sdf@google.com wrote:
> > > > > On 07/12, Daniel M�ller wrote:
> > > > > > On Tue, Jul 12, 2022 at 02:27:47PM -0700, Alexei
> > > > > > Starovoitov wrote:
> > > > > > > On Tue, Jul 12, 2022 at 2:21 PM Daniel M�ller
> > > > > > > <deso@posteo.net> wrote:
> > > > > > > > 
> > > > > > > > This change integrates the libbpf maintained
> > > > > > > > configurations and
> > > > > > > > black/white lists [0] into the repository, co-located
> > > > > > > > with the BPF
> > > > > > > > selftests themselves. The only differences from the
> > > > > > > > source is that we
> > > > > > > > replaced the terms blacklist & whitelist with denylist
> > > > > > > > and allowlist,
> > > > > > > > respectively.
> > > > > > > > 
> > > > > > > > [0]
> > > > > > > > https://github.com/libbpf/libbpf/tree/20f03302350a4143825cedcbd210c4d7112c1898/travis-ci/vmtest/configs
> > > > > > > > 
> > > > > > > > Signed-off-by: Daniel M�ller <deso@posteo.net>
> > > > > > > > ---
> > > > > > > >  .../bpf/configs/allowlist/ALLOWLIST-4.9.0     |    8 +
> > > > > > > >  .../bpf/configs/allowlist/ALLOWLIST-5.5.0     |   55 +
> > > > > > > >  .../selftests/bpf/configs/config-latest.s390x | 2711
> > > > > > > > +++++++++++++++
> > > > > > > >  .../bpf/configs/config-latest.x86_64          | 3073
> > > > > > +++++++++++++++++
> > > > > > > 
> > > > > > > Instead of checking in the full config please trim it to
> > > > > > > relevant dependencies like existing selftests/bpf/config.
> > > > > > > Otherwise every update/addition would trigger massive
> > > > > > > patches.
> > > > > 
> > > > > > Thanks for taking a look. Sure. Do we have some kind of
> > > > > > tooling for that
> > > > > > or are
> > > > > > there any suggestions on the best approach to minimize?
> > > > > 
> > > > > I would be interested to know as well if somebody knows some
> > > > > tricks on
> > > > > how to deal with kconfig. I've spent some time yesterday
> > > > > manually
> > > > > crafting various minimal bpf configs (for build tests),
> > > > > running make
> > > > > olddefconfig and then verifying that all my options are still
> > > > > present in
> > > > > the final config file.
> > > > > 
> > > > > It seems like kconfig tool can resolve some of the
> > > > > dependencies,
> > > > > but there is a lot of if/endif that can break in non-obvious
> > > > > ways.
> > > > > For example, putting CONFIG_TRACING=y and doing 'make
> > > > > olddefconfig'
> > > > > won't get you CONFIG_TRACING=y in the final .config
> > > > > 
> > > > > So the only thing, for me, that helped, was to manually go
> > > > > through
> > > > > the kconfig files trying to see what the dependencies are.
> > > > > I've tried scripts/kconfig/merge_config.sh, but it doesn't
> > > > > seem to bring anything new to the table..
> > > > > 
> > > > > So here is what I ended up with, I don't think it will help
> > > > > you that
> > > > > much, but at least can highlight the moving parts (I was
> > > > > thinking that
> > > > > maybe we can eventually put them in the CI as well to make
> > > > > sure all weird
> > > > > configurations are build-tested?):
> > > > 
> > > > [...]
> > > > 
> > > > I *think* that make savedefconfig [0] is the way to go, at
> > > > least for my use
> > > > case. That cuts down the config file to <350 lines. However, it
> > > > does change some
> > > > configurations from 'm' to 'y', which I can't say I quite
> > > > understand or would
> > > > have expected (but perhaps minimal implies no modules or
> > > > similar; I haven't
> > > > investigated).
> > > > I am still verifying that the result is working as expected,
> > > > though.
> > > 
> > > I think ideally we'd do defconfig first, then append whatever is
> > > in
> > > selftests/bpf/config, do olddefconfig to fill in all the
> > > unspecified
> > > options, and then use the result as the config. Yes, that
> > > requires
> > > that selftests/bpf/config has some of the dependent values
> > > specified,
> > > which is an annoying mostly one-time thing, but I think it's
> > > beneficial to all the new BPF users, because it *really* shows
> > > what
> > > needs to be added to kernel config to make everything work. We
> > > can
> > > also split it into BPF-specific and non-BPF (dependencies)
> > > configs, if
> > > that is cleaner.
> > 
> > Agreed, we should do that eventually. But let's not put everything
> > into
> > this patch set, which was never intended to rework everything we
> > have,
> > okay? It contains a few steps towards where we want to head.
> > 
> > If we start diverging massively now, while also moving
> > configurations
> > between multiple repositories, we end up with a mess of a history
> > that
> > will be hard to follow.
> > 
> > So unless there exist very strong arguments forcing us to do that
> > here
> > and now (such as us regressing on one front, which I don't see
> > here),
> > I'd rather we go about it at a later point after other check boxes
> > have
> > been ticked. What do you think?
> > 
> 
> You mean the part about checking in huge Kconfigs for x86 and s390x?
> I
> don't think we should do that as a first step. Yes it's an annoying
> (but also very important) part to figure out the minimal set of added
> configs on top of default config, but I think we should do that from
> the beginning instead of polluting Git history with massive configs.
> It will also keep selftests/bpf/config "honest" instead of putting it
> on new users to figure out other missed or dependent configs by
> themselves.
> 
> With s390x config, at least, I hope that Ilya can ease the pain,
> especially that he was the one who came up with that config in the
> first place (cc'ed Ilya).
> 
> 
> > > Also, I don't think we should move 4.9.0 and 5.5.0 lists here,
> > > let's
> > > keep them in libbpf CI, they are very specific there. Here we
> > > should
> > > only maintain the latest per-arch configs and allow/deny lists
> > > only.
> > 
> > Sounds good, will remove them.
> > 
> > Thanks,
> > Daniel

Hi!

For myself, I maintain this as a defconfig. I published the full config
for the CI, because it was the case for x86 already.

Here is what I currently have:

CONFIG_9P_FS=y
CONFIG_ALTIVEC=y
CONFIG_AUDIT=y
CONFIG_BLK_CGROUP=y
# CONFIG_BLK_DEBUG_FS is not set
# CONFIG_BLK_DEV_BSG is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=y
# CONFIG_BLK_DEV_XPRAM is not set
CONFIG_BONDING=y
CONFIG_BPFILTER_UMH=y
CONFIG_BPFILTER=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT=y
CONFIG_BPF_LIRC_MODE2=y
CONFIG_BPF_LSM=y
CONFIG_BPF_PRELOAD_UMD=y
CONFIG_BPF_PRELOAD=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_SCHED=y
CONFIG_CGROUPS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_CLEANCACHE=y
# CONFIG_COMPAT_BRK is not set
CONFIG_COMPAT=y
# CONFIG_CPU_IDLE is not set
# CONFIG_CPU_ISOLATION is not set
CONFIG_CPU_LITTLE_ENDIAN=y
CONFIG_CPUSETS=y
CONFIG_CRASH_DUMP=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_DEV_VIRTIO is not set
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_RNG=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CTCM is not set
# CONFIG_DASD is not set
# CONFIG_DCSSBLK is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_NOTIFIERS=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_DEBUG_SG=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEVKMEM=y
CONFIG_DEVTMPFS=y
# CONFIG_EADM_SCH is not set
# CONFIG_ETHERNET is not set
CONFIG_EXPERT=y
CONFIG_EXPOLINE=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_FS=y
CONFIG_FANOTIFY=y
CONFIG_FRAME_WARN=1024
CONFIG_FRONTSWAP=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_GDB_SCRIPTS=y
CONFIG_GENEVE=y
CONFIG_HEADERS_INSTALL=y
CONFIG_HIBERNATION=y
CONFIG_HIGH_RES_TIMERS=y
# CONFIG_HMC_DRV is not set
CONFIG_HUGETLBFS=y
CONFIG_HVC_CONSOLE=y
# CONFIG_HVC_IUCV is not set
CONFIG_HW_RANDOM=y
CONFIG_HZ_100=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKCONFIG=y
CONFIG_IKHEADERS=y
CONFIG_IMA=y
CONFIG_INET6_ESP=y
CONFIG_INET_ESP=y
CONFIG_INET=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
CONFIG_IPVLAN=y
# CONFIG_IUCV is not set
CONFIG_JUMP_LABEL=y
CONFIG_KERNEL_UNCOMPRESSED=y
CONFIG_KEYS=y
CONFIG_KPROBES=y
CONFIG_KSM=y
CONFIG_KUNIT=y
CONFIG_LATENCYTOP=y
CONFIG_LIRC=y
CONFIG_LIVEPATCH=y
CONFIG_LOCK_STAT=y
CONFIG_LWTUNNEL=y
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_PARTITION=y
CONFIG_MACVLAN=y
CONFIG_MACVTAP=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTREMOVE=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MONWRITER is not set
CONFIG_MPLS_IPTUNNEL=y
CONFIG_MPLS_ROUTING=y
CONFIG_MPLS=y
# CONFIG_MSDOS_PARTITION is not set
CONFIG_NAMESPACES=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P=y
CONFIG_NET_ACT_BPF=y
CONFIG_NET_ACT_GACT=y
CONFIG_NET_CLS_ACT=y
CONFIG_NET_CLS_BPF=y
CONFIG_NET_CLS_FLOWER=y
CONFIG_NETDEVICES=y
CONFIG_NETDEVSIM=y
CONFIG_NETFILTER_XT_MATCH_BPF=y
CONFIG_NETFILTER_XT_TARGET_MARK=y
CONFIG_NETFILTER=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPIP=y
CONFIG_NET_KEY=y
CONFIG_NET_MPLS_GSO=y
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_FQ=y
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_VRF=y
CONFIG_NET=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_TABLES=y
CONFIG_NO_HZ_IDLE=y
CONFIG_NR_CPUS=256
CONFIG_NUMA=y
CONFIG_OPROFILE=y
CONFIG_PACKET=y
CONFIG_PAGE_EXTENSION=y
CONFIG_PANIC_ON_OOPS=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_PCI_HOST_GENERIC=y
CONFIG_PCI=y
CONFIG_PM_DEBUG=y
CONFIG_POSIX_MQUEUE=y
CONFIG_PPC_4K_PAGES=y
CONFIG_PPC64=y
# CONFIG_PPC_QUEUED_SPINLOCKS is not set
CONFIG_PROC_KCORE=y
CONFIG_PROFILING=y
CONFIG_PROVE_LOCKING=y
CONFIG_PTDUMP_DEBUGFS=y
CONFIG_RC_CORE=y
CONFIG_RC_DEVICES=y
CONFIG_RC_LOOPBACK=y
# CONFIG_RC_MAP is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_GZIP is not set
# CONFIG_RD_LZ4 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_LZO is not set
# CONFIG_RD_XZ is not set
CONFIG_RT_GROUP_SCHED=y
# CONFIG_S390_PRNG is not set
CONFIG_S390_PTDUMP=y
# CONFIG_S390_TAPE is not set
# CONFIG_S390_VMUR is not set
CONFIG_SAMPLE_SECCOMP=y
CONFIG_SAMPLES=y
CONFIG_SCHED_TRACER=y
# CONFIG_SCLP_TTY is not set
# CONFIG_SCSI_PROC_FS is not set
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY=y
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
# CONFIG_SERIAL_8250_LPSS is not set
# CONFIG_SERIAL_8250_MID is not set
# CONFIG_SERIAL_8250_PCI is not set
# CONFIG_SERIAL_8250_PNP is not set
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
CONFIG_SERIAL_AMBA_PL011=y
CONFIG_SMP=y
CONFIG_STACK_TRACER=y
CONFIG_STATIC_KEYS_SELFTEST=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_SYN_COOKIES=y
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_SYSVIPC=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
CONFIG_TASKSTATS=y
CONFIG_TASK_XACCT=y
CONFIG_TCP_CONG_ADVANCED=y
# CONFIG_TCP_CONG_BIC is not set
CONFIG_TCP_CONG_DCTCP=y
# CONFIG_TCP_CONG_HTCP is not set
# CONFIG_TCP_CONG_WESTWOOD is not set
CONFIG_TEST_BPF=m
CONFIG_THREAD_SHIFT=13
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_TLS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS=y
# CONFIG_TN3215 is not set
# CONFIG_TN3270_FS is not set
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TUN=y
CONFIG_UNIX=y
CONFIG_UNUSED_SYMBOLS=y
CONFIG_USELIB=y
CONFIG_USERFAULTFD=y
CONFIG_USER_NS=y
CONFIG_VETH=y
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_BLK=y
CONFIG_VIRTIO_NET=y
CONFIG_VIRTIO_PCI=y
CONFIG_VLAN_8021Q=y
# CONFIG_VMCP is not set
CONFIG_VSX=y
# CONFIG_VT is not set
CONFIG_VXLAN=y
CONFIG_XDP_SOCKETS=y
CONFIG_XFRM_USER=y

It's not a delta to a smaller "default" defconfig, but IMHO it's still
pretty concise. 

Hope that helps.

Best regards,
Ilya
