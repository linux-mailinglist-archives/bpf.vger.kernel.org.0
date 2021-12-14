Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB28474223
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 13:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhLNMK5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 07:10:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229565AbhLNMK5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Dec 2021 07:10:57 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BEA7NtL000485
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 12:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=BxO/KUrw8LSuUpKd54bbz2LCGq1a/lpKTy4i1oCB9TM=;
 b=RTCQUDy9NnpgwbIcy2FzZnf55+ESsRuXiDwmfnIXlTCkmkkzyeFUj/udoSMohV2eTd3l
 +4RP97d6+8d1CANOFtfjnot4ydQ55C9obF9R9XiVzZgyCtgvXLBEJV9k67J4lDhqoH5C
 y66kbMFwv1Hxwki1RHDZBNEuxeBb1Vx6O9fcsur77/VPkAXjBHicvn7njH9yx9nz0p7+
 pivXAETUGCpk5o/DgdZLbUHdS+e6vG1p2SivPjzoIRmsL5KzS8HiJCfUL9HleFbarI0t
 y9R7/eKC7NFILgF+vFR41jQZ6of07HSq15c0Mfx+xWAMyliQh32wZdvckgYKyerDr4ob 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cx9r8as0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 12:10:56 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BEBo9sv018626
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 12:10:55 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cx9r8as0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 12:10:55 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BEC8GPC022119;
        Tue, 14 Dec 2021 12:10:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3cvkm956x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Dec 2021 12:10:53 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BECAp4238666554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Dec 2021 12:10:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E3FD42042;
        Tue, 14 Dec 2021 12:10:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1593C4203F;
        Tue, 14 Dec 2021 12:10:51 +0000 (GMT)
Received: from localhost (unknown [9.43.8.159])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Dec 2021 12:10:50 +0000 (GMT)
Date:   Tue, 14 Dec 2021 17:39:25 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: PPC jit and pseudo_btf_id
To:     bpf@vger.kernel.org, Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>
References: <xunylf0o872l.fsf@redhat.com>
In-Reply-To: <xunylf0o872l.fsf@redhat.com>
MIME-Version: 1.0
User-Agent: astroid/v0.16-1-g4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1639483040.nhfgn2cmvh.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DCBRY284lRgoqdKTGxWap3zFj6iJHRWR
X-Proofpoint-GUID: -3RrgR9OgA65N08uowLw4flh61H0wKjb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_06,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1011 phishscore=0 bulkscore=0 mlxlogscore=892
 lowpriorityscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140070
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yauheni,


Yauheni Kaliuta wrote:
> Hi!
>=20
> I get kernel oops on my setup due to unresolved pseudo_btf_id for
> ld_imm64 (see 4976b718c355 ("bpf: Introduce pseudo_btf_id")) for
> example for `test_progs -t for_each/hash_map` where callback
> address is passed to a bpf helper:
>=20
>=20
> [  425.853991] kernel tried to execute user page (100000014) - exploit at=
tempt? (uid: 0)
> [  425.854173] BUG: Unable to handle kernel instruction fetch
> [  425.854255] Faulting instruction address: 0x100000014
> [  425.854339] Oops: Kernel access of bad area, sig: 11 [#1]
> [  425.854423] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSer=
ies
> [  425.854529] Modules linked in: tun bpf_testmod(OE) nft_fib_inet nft_fi=
b_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 n=
ft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag=
_ipv4 rfkill ip_set nf_tables libcrc32c nfnetlink nvram virtio_balloon vmx_=
crypto ext4 mbcache jbd2 sr_mod cdrom sg bochs_drm drm_vram_helper drm_kms_=
helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm=
 drm virtio_net net_failover virtio_blk drm_panel_orientation_quirks failov=
er virtio_scsi
> [  425.855276] CPU: 31 PID: 8935 Comm: test_progs Tainted: G           OE=
    --------- ---  5.14.0+ #7
> [  425.855419] NIP:  0000000100000014 LR: c000000000385554 CTR: 000000010=
0000016
> [  425.855539] REGS: c000000022e8b740 TRAP: 0400   Tainted: G           O=
E    --------- ---   (5.14.0+)
> [  425.855681] MSR:  8000000040009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 2448284=
4  XER: 20000000
> [  425.855816] CFAR: c000000000385550 IRQMASK: 0=20
> [  425.855816] GPR00: c000000000381b20 c000000022e8b9e0 c000000002a45f00 =
c0000000248fa800=20
> [  425.855816] GPR04: c00000007cead8b0 c00000007cead8b8 c000000022e8ba80 =
0000000000000000=20
> [  425.855816] GPR08: 0000000000000000 0000000000000000 c00000002269acc0 =
0000000000000000=20
> [  425.855816] GPR12: 0000000100000016 c00000003ffca300 0000000000000000 =
0000000000000000=20
> [  425.855816] GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000001=20
> [  425.855816] GPR20: 0000000000000000 0000000000000000 0000000000000000 =
c000000022e8bbb0=20
> [  425.855816] GPR24: c000000022e8bbb4 0000000000000000 0000000000000008 =
c000000022e8ba80=20
> [  425.855816] GPR28: c0000000248fa800 0000000100000016 c00000007cead880 =
0000000000000001=20
> [  425.856853] NIP [0000000100000014] 0x100000014
> [  425.856937] LR [c000000000385554] bpf_for_each_hash_elem+0x134/0x220
> [  425.857047] Call Trace:
> [  425.857089] [c000000022e8b9e0] [8000000000000106] 0x8000000000000106 (=
unreliable)
> [  425.857215] [c000000022e8ba40] [c000000000381b20] bpf_for_each_map_ele=
m+0x30/0x50
> [  425.857340] [c000000022e8ba60] [c008000001cddb8c] bpf_prog_458e9855eab=
74599_F+0x68/0x24dc
> [  425.857464] [c000000022e8bad0] [c000000000c46a9c] bpf_test_run+0x2bc/0=
x440
> [  425.857573] [c000000022e8bb90] [c000000000c47cbc] bpf_prog_test_run_sk=
b+0x3fc/0x790
> [  425.857698] [c000000022e8bc30] [c000000000363178] __sys_bpf+0xfd8/0x26=
90
> [  425.857805] [c000000022e8bd90] [c0000000003648dc] sys_bpf+0x2c/0x40
> [  425.857910] [c000000022e8bdb0] [c000000000030c9c] system_call_exceptio=
n+0x15c/0x300
> [  425.858034] [c000000022e8be10] [c00000000000c6cc] system_call_common+0=
xec/0x250
> [  425.858160] --- interrupt: c00 at 0x7fff7e751ea4

Thanks for the problem report. I noticed this recently and have prepared=20
a fix as part of a larger patchset.

>=20
> The simple patch fixes it for me:
>=20
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 90ce75f0f1e2..554c26480387 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -201,8 +201,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog =
*fp)
>  		 */
>  		bpf_jit_fixup_subprog_calls(fp, code_base, &cgctx, addrs);
>=20
> -		/* There is no need to perform the usual passes. */
> -		goto skip_codegen_passes;
> +		/* Due to pseudo_btf_id resolving, regenerate */
>  	}
>=20
>  	/* Code generation passes 1-2 */
> @@ -222,7 +221,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog =
*fp)
>  				proglen - (cgctx.idx * 4), cgctx.seen);
>  	}
>=20
> -skip_codegen_passes:
>  	if (bpf_jit_enable > 1)
>  		/*
>  		 * Note that we output the base address of the code_base
>=20
>=20
>=20
> Do I miss something?

The problem with the above approach is that we generate variable number=20
of instructions for certain BPF instructions and so, unless we reserve=20
space for maximum number of powerpc instructions beforehand, we risk=20
writing past the end of the allocated buffer.

Can you please check if the below patch fixes the issue for you?


Thanks,
Naveen


---
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_com=
p.c
index 463f99ecaa459e..e16d421ce22a65 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -66,7 +66,15 @@ static int bpf_jit_fixup_subprog_calls(struct bpf_prog *=
fp, u32 *image,
 			 * of the JITed sequence remains unchanged.
 			 */
 			ctx->idx =3D tmp_idx;
+		} else if (insn[i].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW)) {
+			func_addr =3D ((u64)(u32) insn[i].imm) | (((u64)(u32) insn[i+1].imm) <<=
 32);
+			tmp_idx =3D ctx->idx;
+			ctx->idx =3D addrs[i] / 4;
+			PPC_LI64(b2p[insn[i].dst_reg], func_addr);
+			ctx->idx =3D tmp_idx;
+			i++;
 		}
+
 	}
=20
 	return 0;
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_c=
omp64.c
index 74b465cc7a84d0..4d3973cd78b46f 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -324,6 +324,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,=
 struct codegen_context *
 		u64 imm64;
 		u32 true_cond;
 		u32 tmp_idx;
+		int j;
=20
 		/*
 		 * addrs[] maps a BPF bytecode address into a real offset from
@@ -858,7 +859,11 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image=
, struct codegen_context *
 				    (((u64)(u32) insn[i+1].imm) << 32);
 			/* Adjust for two bpf instructions */
 			addrs[++i] =3D ctx->idx * 4;
+			tmp_idx =3D ctx->idx;
 			PPC_LI64(dst_reg, imm64);
+			/* padding to allow full 5 instructions for later patching */
+			for (j =3D ctx->idx - tmp_idx; j < 5; j++)
+				EMIT(PPC_RAW_NOP());
 			break;
=20
 		/*

