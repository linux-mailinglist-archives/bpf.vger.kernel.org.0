Return-Path: <bpf+bounces-54585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6861A6D092
	for <lists+bpf@lfdr.de>; Sun, 23 Mar 2025 19:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2A118946A7
	for <lists+bpf@lfdr.de>; Sun, 23 Mar 2025 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4753F190052;
	Sun, 23 Mar 2025 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mB0+e1ij"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E230C4C8F;
	Sun, 23 Mar 2025 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742754674; cv=none; b=HafD1UhIa0ZHguYCHRakc9QTTzmfO+H6hoBuiQe2U/lleFkBmuBjo3/ZjEZFIrygwMhkfQYpNc/az6cG71u33YDkgzrDeSY6Czfm6ALPlKH81w61OvmE7oLv+1oRSJniLhNcRKxdJ1S6vDw4X8IWFtpKIPmj+1t1awKxdXLjlLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742754674; c=relaxed/simple;
	bh=Y3cNSXQWrRJ+X42ZFCnRlpb1W8mGKD3GA39bty0UQeU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To; b=gb/mZDDg/f24tFOcIc5CSTf+0c1h++k96F9NdkGzuKOuuQVwIK2YMRa+hTrevrLXfMt/g1HZBo+CnZRUXCv2UbVCdE9aLnalzzl5fH2otem1vJBXgSgqIckKiXrLGRk5TFW1fisGq7xRwAdo3JZASRyAqIsbg/YQAaKg7oz9aYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mB0+e1ij; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NEU3Vi001632;
	Sun, 23 Mar 2025 18:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=LzfccMC1Sv9oyQvyfO7z6eM4YF/kGn
	0pLUo0WrfHexM=; b=mB0+e1ijXvkxuweNl1sCqEGWARfiAib5vG7UEx0qWs/S60
	Q0tiY7x2+8tlvBoYgEVMIySmq2qZabk44+YgGEz6Ozh1YVAkSf4bYzoBlBYBbDmA
	qsRYngaITqlsF2ZLdyeA1q/aMgFjLTilQZWot3J/3xX/oYspvepdwHCl9pYO6wqz
	LhjHCe3/8nKqnlAMGU2G8NyGMgCqrvbH9Z5LmN41k93APwVNiZYlvXCiDm8dWfsY
	bQDmztVuVgwsVUv9CN8fHsBMhEKzfEDJ66ywJPT5ZJRxmPxfFsxwGnUEg2FEVWzA
	WNGOWikz8iysJnWPv+plojAidc/xNyJEi5DD7DcA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45j4dyk459-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 18:31:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52NHj86D012234;
	Sun, 23 Mar 2025 18:31:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91ktrh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 18:31:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52NIV0JK48628216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Mar 2025 18:31:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E13512004D;
	Sun, 23 Mar 2025 18:31:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9598E20040;
	Sun, 23 Mar 2025 18:30:59 +0000 (GMT)
Received: from [9.43.2.178] (unknown [9.43.2.178])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Mar 2025 18:30:59 +0000 (GMT)
Content-Type: multipart/mixed; boundary="------------NswYESWQF00tvx6wuNGErzHZ"
Message-ID: <2a3c9acc-01de-43fd-a946-a3af4b0312a6@linux.ibm.com>
Date: Mon, 24 Mar 2025 00:00:58 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [main-line]warning at arch/powerpc/net/bpf_jit_comp.c:961
From: Hari Bathini <hbathini@linux.ibm.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
References: <6168bfc8-659f-4b5a-a6fb-90a916dde3b3@linux.ibm.com>
 <73047120-e683-4142-b4e4-2422fc41f58d@linux.ibm.com>
 <ef9ce622-db85-4c2c-b59f-e7703dc0d335@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <ef9ce622-db85-4c2c-b59f-e7703dc0d335@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yce8GwNeN_iuMVtqJtOuPYRVkZpE1icE
X-Proofpoint-ORIG-GUID: Yce8GwNeN_iuMVtqJtOuPYRVkZpE1icE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_08,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503230131

This is a multi-part message in MIME format.
--------------NswYESWQF00tvx6wuNGErzHZ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Venkat,

On 20/03/25 3:01 am, Hari Bathini wrote:
> 
> 
> On 19/03/25 1:06 pm, Hari Bathini wrote:
>> Hi Venkat,
>>
>> Thanks for reporting this.
>> I am having a hard time reproducing this. Please share the
>> kernel build config..
>>
> 
> Thanks for reporting this and sharing the config file offline.
> Narrowed down the potential root cause. Will post the fix...
> 
> - Hari
> 
>> On 17/03/25 6:21 pm, Venkat Rao Bagalkote wrote:
>>> Greetings!!!
>>>
>>> I am observing below warnings on linux-mainline kernel, while running 
>>> bpf-sefltests.
>>>
>>> These warnings are intermitent, reproduces roughly 6 out of 10 times.
>>>
>>>
>>> Repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>
>>>
>>> Tests:
>>>
>>> ./test_progs
>>>
>>>
>>> Attached is the log file of summary of tests.
>>>
>>>
>>> Traces:
>>>
>>> [  978.200120] ------------[ cut here ]------------
>>> [  978.200133] WARNING: CPU: 11 PID: 45522 at arch/powerpc/net/ 
>>> bpf_jit_comp.c:961 __arch_prepare_bpf_trampoline.isra.0+0xdc8/0xfe0
>>> [  978.200144] Modules linked in: tun(E) bpf_testmod(OE) veth(E) 
>>> bonding(E) tls(E) nft_fib_inet(E) nft_fib_ipv4(E) nft_fib_ipv6(E) 
>>> nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) nf_reject_ipv6(E) 
>>> nft_reject(E) nft_ct(E) rfkill(E) nft_chain_nat(E) sunrpc(E) 
>>> ibmveth(E) pseries_rng(E) vmx_crypto(E) drm(E) dm_multipath(E) 
>>> dm_mod(E) fuse(E) drm_panel_orientation_quirks(E) zram(E) xfs(E) 
>>> sd_mod(E) ibmvscsi(E) scsi_transport_srp(E) [last unloaded: 
>>> bpf_test_modorder_x(OE)]
>>> [  978.200194] CPU: 11 UID: 0 PID: 45522 Comm: test_progs Tainted: 
>>> G           OE      6.14.0-rc7-auto #4
>>> [  978.200202] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>>> [  978.200205] Hardware name: IBM,8375-42A POWER9 (architected) 
>>> 0x4e0202 0xf000005 of:IBM,FW950.A0 (VL950_144) hv:phyp pSeries
>>> [  978.200210] NIP:  c0000000001e3658 LR: c0000000001e34b0 CTR: 
>>> 0000000000000006
>>> [  978.200216] REGS: c00000001c057570 TRAP: 0700   Tainted: G OE 
>>> (6.14.0-rc7-auto)
>>> [  978.200221] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
>>> 44844442  XER: 20040169
>>> [  978.200234] CFAR: c0000000001e34e8 IRQMASK: 0
>>> [  978.200234] GPR00: c0000000001e34b0 c00000001c057810 
>>> c000000001d68100 0000000000000000
>>> [  978.200234] GPR04: c00800000025d640 c00000001c05786c 
>>> 0000000000000160 0000000000000164
>>> [  978.200234] GPR08: c000000157b8c164 c000000157b8c16c 
>>> 000000000000016c 0000000000004000
>>> [  978.200234] GPR12: 0000000000000001 c00000001ec82b00 
>>> 0000000000000078 0000000038210110
>>> [  978.200234] GPR16: 00000000000000a8 00000000eb210098 
>>> 0000000060638000 00000000e86100c0
>>> [  978.200234] GPR20: 00000000eb4100a0 0000000000000004 
>>> 000000002c230000 0000000060000000
>>> [  978.200234] GPR24: fffffffffffff000 c000000005834428 
>>> c00800000025d640 0000000000000001
>>> [  978.200234] GPR28: c000000157b89c00 000000000000026c 
>>> 0000000000000003 c000000157b8c000
>>> [  978.200294] NIP [c0000000001e3658] 
>>> __arch_prepare_bpf_trampoline.isra.0+0xdc8/0xfe0
>>> [  978.200301] LR [c0000000001e34b0] 
>>> __arch_prepare_bpf_trampoline.isra.0+0xc20/0xfe0
>>> [  978.200308] Call Trace:
>>> [  978.200310] [c00000001c057810] [c0000000001e34b0] 
>>> __arch_prepare_bpf_trampoline.isra.0+0xc20/0xfe0 (unreliable)
>>> [  978.200319] [c00000001c057950] [c0000000001e4974] 
>>> arch_prepare_bpf_trampoline+0x94/0x130
>>> [  978.200327] [c00000001c0579b0] [c0000000005001ac] 
>>> bpf_trampoline_update+0x23c/0x660
>>> [  978.200334] [c00000001c057a90] [c0000000005006dc] 
>>> __bpf_trampoline_link_prog+0x10c/0x360
>>> [  978.200341] [c00000001c057ad0] [c000000000500c28] 
>>> bpf_trampoline_link_cgroup_shim+0x268/0x370
>>> [  978.200348] [c00000001c057b80] [c00000000053254c] 
>>> __cgroup_bpf_attach+0x4ec/0x760
>>> [  978.200355] [c00000001c057c60] [c000000000533dd4] 
>>> cgroup_bpf_prog_attach+0xa4/0x310
>>> [  978.200362] [c00000001c057cb0] [c00000000049d1b8] 
>>> bpf_prog_attach+0x2a8/0x2e0
>>> [  978.200370] [c00000001c057d00] [c0000000004a7278] 
>>> __sys_bpf+0x428/0xd20
>>> [  978.200375] [c00000001c057df0] [c0000000004a7b9c] sys_bpf+0x2c/0x40
>>> [  978.200381] [c00000001c057e10] [c000000000033078] 
>>> system_call_exception+0x128/0x310
>>> [  978.200388] [c00000001c057e50] [c00000000000d05c] 
>>> system_call_vectored_common+0x15c/0x2ec
>>> [  978.200396] --- interrupt: 3000 at 0x7fff98ba9f40
>>> [  978.200405] NIP:  00007fff98ba9f40 LR: 00007fff98ba9f40 CTR: 
>>> 0000000000000000
>>> [  978.200410] REGS: c00000001c057e80 TRAP: 3000   Tainted: G OE 
>>> (6.14.0-rc7-auto)
>>> [  978.200415] MSR:  800000000280f033 
>>> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48002848  XER: 00000000
>>> [  978.200431] IRQMASK: 0
>>> [  978.200431] GPR00: 0000000000000169 00007fffde891b10 
>>> 00007fff98cb6d00 0000000000000008
>>> [  978.200431] GPR04: 00007fffde891bf8 0000000000000020 
>>> 0000000000000001 0000000000000008
>>> [  978.200431] GPR08: 0000000000000008 0000000000000000 
>>> 0000000000000000 0000000000000000
>>> [  978.200431] GPR12: 0000000000000000 00007fff995fe9e0 
>>> 0000000000000000 0000000000000000
>>> [  978.200431] GPR16: 0000000000000000 0000000000000000 
>>> 0000000000000000 0000000000000000
>>> [  978.200431] GPR20: 0000000000000000 0000000000000000 
>>> 0000000000000000 00007fff995ef438
>>> [  978.200431] GPR24: 00000000105ed2f4 00007fff995f0000 
>>> 00007fffde892998 0000000000000001
>>> [  978.200431] GPR28: 00007fffde892aa8 00007fffde892988 
>>> 0000000000000001 00007fffde891b40
>>> [  978.200487] NIP [00007fff98ba9f40] 0x7fff98ba9f40
>>> [  978.200491] LR [00007fff98ba9f40] 0x7fff98ba9f40
>>> [  978.200495] --- interrupt: 3000
>>> [  978.200498] Code: 7d5f412e 81210060 39290001 792a1788 3ba90040 
>>> 91210060 7d3f5214 57bd103a e9010030 3908ff00 7c294040 4081fae0 
>>> <0fe00000> 3ba0fff2 4bfffad4 8281003c
>>> [  978.200519] ---[ end trace 0000000000000000 ]---
>>>
>>> If you happen to fix this, please add below tag.
>>>
>>>
>>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

The attached fix is not complete but will be sufficient for this
test scenario. While I come up with the complete fix for all scenarios,
can you share your observations applying the change...

- Hari
--------------NswYESWQF00tvx6wuNGErzHZ
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-powerpc-bpf-trampoline-fix.patch"
Content-Disposition: attachment;
 filename="0001-powerpc-bpf-trampoline-fix.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9uZXQvYnBmX2ppdF9jb21wLmMgYi9hcmNoL3Bv
d2VycGMvbmV0L2JwZl9qaXRfY29tcC5jCmluZGV4IDI5OTFiYjE3MWE5Yi4uZDg2N2FkYTMx
YmQ1IDEwMDY0NAotLS0gYS9hcmNoL3Bvd2VycGMvbmV0L2JwZl9qaXRfY29tcC5jCisrKyBi
L2FyY2gvcG93ZXJwYy9uZXQvYnBmX2ppdF9jb21wLmMKQEAgLTgzMyw3ICs4MzMsOCBAQCBz
dGF0aWMgaW50IF9fYXJjaF9wcmVwYXJlX2JwZl90cmFtcG9saW5lKHN0cnVjdCBicGZfdHJh
bXBfaW1hZ2UgKmltLCB2b2lkICpyd19pbQogCUVNSVQoUFBDX1JBV19TVEwoX1IyNiwgX1Ix
LCBudnJfb2ZmICsgU1pMKSk7CiAKIAlpZiAoZmxhZ3MgJiBCUEZfVFJBTVBfRl9DQUxMX09S
SUcpIHsKLQkJUFBDX0xJX0FERFIoX1IzLCAodW5zaWduZWQgbG9uZylpbSk7CisJCVBQQ19M
SV9BRERSKF9SMywgaW0gPyAodW5zaWduZWQgbG9uZylpbSA6CisJCQkJKHVuc2lnbmVkIGxv
bmcpKH4oMVVMIDw8IChCSVRTX1BFUl9MT05HIC0gMSkpKSk7CiAJCXJldCA9IGJwZl9qaXRf
ZW1pdF9mdW5jX2NhbGxfcmVsKGltYWdlLCByb19pbWFnZSwgY3R4LAogCQkJCQkJICh1bnNp
Z25lZCBsb25nKV9fYnBmX3RyYW1wX2VudGVyKTsKIAkJaWYgKHJldCkKQEAgLTg4OSw3ICs4
OTAsOCBAQCBzdGF0aWMgaW50IF9fYXJjaF9wcmVwYXJlX2JwZl90cmFtcG9saW5lKHN0cnVj
dCBicGZfdHJhbXBfaW1hZ2UgKmltLCB2b2lkICpyd19pbQogCQkJYnBmX3RyYW1wb2xpbmVf
cmVzdG9yZV90YWlsX2NhbGxfY250KGltYWdlLCBjdHgsIGZ1bmNfZnJhbWVfb2Zmc2V0LCBy
NF9vZmYpOwogCiAJCS8qIFJlc2VydmUgc3BhY2UgdG8gcGF0Y2ggYnJhbmNoIGluc3RydWN0
aW9uIHRvIHNraXAgZmV4aXQgcHJvZ3MgKi8KLQkJaW0tPmlwX2FmdGVyX2NhbGwgPSAmKCh1
MzIgKilyb19pbWFnZSlbY3R4LT5pZHhdOworCQlpZiAoaW0pCisJCQlpbS0+aXBfYWZ0ZXJf
Y2FsbCA9ICYoKHUzMiAqKXJvX2ltYWdlKVtjdHgtPmlkeF07CiAJCUVNSVQoUFBDX1JBV19O
T1AoKSk7CiAJfQogCkBAIC05MTIsOCArOTE0LDEwIEBAIHN0YXRpYyBpbnQgX19hcmNoX3By
ZXBhcmVfYnBmX3RyYW1wb2xpbmUoc3RydWN0IGJwZl90cmFtcF9pbWFnZSAqaW0sIHZvaWQg
KnJ3X2ltCiAJCX0KIAogCWlmIChmbGFncyAmIEJQRl9UUkFNUF9GX0NBTExfT1JJRykgewot
CQlpbS0+aXBfZXBpbG9ndWUgPSAmKCh1MzIgKilyb19pbWFnZSlbY3R4LT5pZHhdOwotCQlQ
UENfTElfQUREUihfUjMsIGltKTsKKwkJaWYgKGltKQorCQkJaW0tPmlwX2VwaWxvZ3VlID0g
JigodTMyICopcm9faW1hZ2UpW2N0eC0+aWR4XTsKKwkJUFBDX0xJX0FERFIoX1IzLCBpbSA/
ICh1bnNpZ25lZCBsb25nKWltIDoKKwkJCQkodW5zaWduZWQgbG9uZykofigxVUwgPDwgKEJJ
VFNfUEVSX0xPTkcgLSAxKSkpKTsKIAkJcmV0ID0gYnBmX2ppdF9lbWl0X2Z1bmNfY2FsbF9y
ZWwoaW1hZ2UsIHJvX2ltYWdlLCBjdHgsCiAJCQkJCQkgKHVuc2lnbmVkIGxvbmcpX19icGZf
dHJhbXBfZXhpdCk7CiAJCWlmIChyZXQpCkBAIC05NzIsNyArOTc2LDYgQEAgc3RhdGljIGlu
dCBfX2FyY2hfcHJlcGFyZV9icGZfdHJhbXBvbGluZShzdHJ1Y3QgYnBmX3RyYW1wX2ltYWdl
ICppbSwgdm9pZCAqcndfaW0KIGludCBhcmNoX2JwZl90cmFtcG9saW5lX3NpemUoY29uc3Qg
c3RydWN0IGJ0Zl9mdW5jX21vZGVsICptLCB1MzIgZmxhZ3MsCiAJCQkgICAgIHN0cnVjdCBi
cGZfdHJhbXBfbGlua3MgKnRsaW5rcywgdm9pZCAqZnVuY19hZGRyKQogewotCXN0cnVjdCBi
cGZfdHJhbXBfaW1hZ2UgaW07CiAJdm9pZCAqaW1hZ2U7CiAJaW50IHJldDsKIApAQCAtOTg4
LDcgKzk5MSw3IEBAIGludCBhcmNoX2JwZl90cmFtcG9saW5lX3NpemUoY29uc3Qgc3RydWN0
IGJ0Zl9mdW5jX21vZGVsICptLCB1MzIgZmxhZ3MsCiAJaWYgKCFpbWFnZSkKIAkJcmV0dXJu
IC1FTk9NRU07CiAKLQlyZXQgPSBfX2FyY2hfcHJlcGFyZV9icGZfdHJhbXBvbGluZSgmaW0s
IGltYWdlLCBpbWFnZSArIFBBR0VfU0laRSwgaW1hZ2UsCisJcmV0ID0gX19hcmNoX3ByZXBh
cmVfYnBmX3RyYW1wb2xpbmUoTlVMTCwgaW1hZ2UsIGltYWdlICsgUEFHRV9TSVpFLCBpbWFn
ZSwKIAkJCQkJICAgIG0sIGZsYWdzLCB0bGlua3MsIGZ1bmNfYWRkcik7CiAJYnBmX2ppdF9m
cmVlX2V4ZWMoaW1hZ2UpOwogCg==

--------------NswYESWQF00tvx6wuNGErzHZ--


