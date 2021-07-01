Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAE83B90F7
	for <lists+bpf@lfdr.de>; Thu,  1 Jul 2021 13:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbhGALJ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Jul 2021 07:09:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236125AbhGALJ2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Jul 2021 07:09:28 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161B4aV7000609;
        Thu, 1 Jul 2021 07:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ypeHRpWEIv8euice3XSkwP5RZgNSI0EuvN7SAjUrwu4=;
 b=s4zBoJAwaTKp59x7VVs713BgslXc/L7E+TzRbvlZgZ/FL0igZ8oqTT9ZtpaWgHYc+CCW
 CO8XF/HHQjp3FVrjoSvcThvelzvz3zC0UrKD5qpZkpm7vfEuRygUgwEGzn4aIo9MpWU9
 4uiLii+dEAKx/nwUUxqjd3LT7H1DPhawGrgaHm51ktFZ/+sBBsJDq9Iw7e4s6m+j83TQ
 7Nu0onP3YXeBixTjnytew13at9jo/r3jEIFMLMF4BsETbBr82Ho9y2L6AGxvfC5Av7RN
 QcXVj/0eoU6EzDoHF022yrI8p2hWyiCEcS3711o4GxoTkAOrLfgIumMa9Ya+iX2Eafe1 zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39hc26gur2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 07:06:44 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 161B4nun001583;
        Thu, 1 Jul 2021 07:06:43 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39hc26guq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 07:06:43 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 161B56UQ013919;
        Thu, 1 Jul 2021 11:06:41 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 39duv8h7r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 11:06:41 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 161B51w720054340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jul 2021 11:05:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15334A4998;
        Thu,  1 Jul 2021 11:06:34 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8CF113CE31;
        Thu,  1 Jul 2021 11:02:04 +0000 (GMT)
Received: from localhost (unknown [9.85.115.110])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Jul 2021 11:02:04 +0000 (GMT)
Date:   Thu, 01 Jul 2021 16:32:03 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [BUG soft lockup] Re: [PATCH bpf-next v3] bpf: Propagate stack
 bounds to registers in atomics w/ BPF_FETCH
To:     Brendan Jackman <jackmanb@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Sandipan Das <sandipan@linux.ibm.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Florent Revest <revest@chromium.org>
References: <20210202135002.4024825-1-jackmanb@google.com>
        <YNiadhIbJBBPeOr6@krava>
        <CA+i-1C0DAr5ecAOV06_fqeCooic4AF=71ur63HJ6ddbj9ceDpQ@mail.gmail.com>
        <YNspwB8ejUeRIVxt@krava> <YNtEcjYvSvk8uknO@krava>
        <CA+i-1C3RDT1Y=A7rAitfbrUUDXxCJeXJLw1oABBCpBubm5De6A@mail.gmail.com>
        <YNtNMSSZh3LTp2we@krava> <YNuL442y2yn5RRdc@krava>
        <CA+i-1C1-7O5EYHZcDtgQaDVrRW+gEQ1WOtiNDZ19NKXUQ_ZLtw@mail.gmail.com>
        <YNxmwZGtnqiXGnF0@krava>
        <CA+i-1C2-MGe0BziQc8t4ry3mj45W0ULVrGsU+uQw9952tFZ1nA@mail.gmail.com>
In-Reply-To: <CA+i-1C2-MGe0BziQc8t4ry3mj45W0ULVrGsU+uQw9952tFZ1nA@mail.gmail.com>
User-Agent: astroid/v0.15-23-gcdc62b30
 (https://github.com/astroidmail/astroid)
Message-Id: <1625133383.8r6ttp782l.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HJigsvniWVLCJNRHkKaI4r1vHARBdVBf
X-Proofpoint-ORIG-GUID: ChTJ1IbFfw96fjiapQmVyscRxFWwMn9X
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_06:2021-06-30,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 adultscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107010073
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Brendan, Hi Jiri,


Brendan Jackman wrote:
> On Wed, 30 Jun 2021 at 14:42, Jiri Olsa <jolsa@redhat.com> wrote:
>>
>> On Wed, Jun 30, 2021 at 12:34:58PM +0200, Brendan Jackman wrote:
>> > On Tue, 29 Jun 2021 at 23:09, Jiri Olsa <jolsa@redhat.com> wrote:
>> > >
>> > > On Tue, Jun 29, 2021 at 06:41:24PM +0200, Jiri Olsa wrote:
>> > > > On Tue, Jun 29, 2021 at 06:25:33PM +0200, Brendan Jackman wrote:
>> > > > > On Tue, 29 Jun 2021 at 18:04, Jiri Olsa <jolsa@redhat.com> wrote:
>> > > > > > On Tue, Jun 29, 2021 at 04:10:12PM +0200, Jiri Olsa wrote:
>> > > > > > > On Mon, Jun 28, 2021 at 11:21:42AM +0200, Brendan Jackman wr=
ote:
>> >
>> > > > > > > > atomics in .imm). Any idea if this test was ever passing o=
n PowerPC?
>> > > > > > > >
>> > > > > > >
>> > > > > > > hum, I guess not.. will check
>> > > > > >
>> > > > > > nope, it locks up the same:
>> > > > >
>> > > > > Do you mean it locks up at commit 91c960b0056 too?
>> >
>> > Sorry I was being stupid here - the test didn't exist at this commit
>> >
>> > > > I tried this one:
>> > > >   37086bfdc737 bpf: Propagate stack bounds to registers in atomics=
 w/ BPF_FETCH
>> > > >
>> > > > I will check also 91c960b0056, but I think it's the new test issue
>> >
>> > So yeah hard to say whether this was broken on PowerPC all along. How
>> > hard is it for me to get set up to reproduce the failure? Is there a
>> > rootfs I can download, and some instructions for running a PowerPC
>> > QEMU VM? If so if you can also share your config and I'll take a look.
>> >
>> > If it's not as simple as that, I'll stare at the code for a while and
>> > see if anything jumps out.
>> >
>>
>> I have latest fedora ppc server and compile/install latest bpf-next tree
>> I think it will be reproduced also on vm, I attached my config
>=20
> OK, getting set up to boot a PowerPC QEMU isn't practical here unless
> someone's got commands I can copy-paste (suspect it will need .config
> hacking too). Looks like you need to build a proper bootloader, and
> boot an installer disk.

There are some notes put up here, though we can do better:
https://github.com/linuxppc/wiki/wiki/Booting-with-Qemu

If you are familiar with ubuntu/fedora cloud images (and cloud-init),=20
you should be able to grab one of the ppc64le images and boot it in=20
qemu:
https://cloud-images.ubuntu.com/releases/hirsute/release/
https://alt.fedoraproject.org/alt/

>=20
> Looked at the code for a bit but nothing jumped out. It seems like the
> verifier is seeing a BPF_ADD | BPF_FETCH, which means it doesn't
> detect an infinite loop, but then we lose the BPF_FETCH flag somewhere
> between do_check in verifier.c and bpf_jit_build_body in
> bpf_jit_comp64.c. That would explain why we don't get the "eBPF filter
> atomic op code %02x (@%d) unsupported", and would also explain the
> lockup because a normal atomic add without fetch would leave BPF R1
> unchanged.
>=20
> We should be able to confirm that theory by disassembling the JITted
> code that gets hexdumped by bpf_jit_dump when bpf_jit_enable is set to
> 2... at least for PowerPC 32-bit... maybe you could paste those lines
> into the 64-bit version too? Here's some notes I made for
> disassembling the hexdump on x86, I guess you'd just need to change
> the objdump flags:
>=20
> --=20
>=20
> - Enable console JIT output:
> ```shell
> echo 2 > /proc/sys/net/core/bpf_jit_enable
> ```
> - Load & run the program of interest.
> - Copy the hex code from the kernel console to `/tmp/jit.txt`. Here's wha=
t a
> short program looks like. This includes a line of context - don't paste t=
he
> `flen=3D` line.
> ```
> [ 79.381020] flen=3D8 proglen=3D54 pass=3D4 image=3D000000001af6f390
> from=3Dtest_verifier pid=3D258
> [ 79.389568] JIT code: 00000000: 0f 1f 44 00 00 66 90 55 48 89 e5 48 81 e=
c 08 00
> [ 79.397411] JIT code: 00000010: 00 00 48 c7 45 f8 64 00 00 00 bf 04 00 0=
0 00 48
> [ 79.405965] JIT code: 00000020: f7 df f0 48 29 7d f8 8b 45 f8 48 83 f8 6=
0 74 02
> [ 79.414719] JIT code: 00000030: c9 c3 31 c0 eb fa
> ```
> - This incantation will split out and decode the hex, then disassemble the
> result:
> ```shell
> cat /tmp/jit.txt | cut -d: -f2- | xxd -r >/tmp/obj && objdump -D -b
> binary -m i386:x86-64 /tmp/obj
> ```
>=20
> --
>=20
> Sandipan, Naveen, do you know of anything in the PowerPC code that
> might be leading us to drop the BPF_FETCH flag from the atomic
> instruction in tools/testing/selftests/bpf/verifier/atomic_bounds.c?

Yes, I think I just found the issue. We aren't looking at the correct=20
BPF instruction when checking the IMM value.


--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -673,7 +673,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,=
 struct codegen_context *
                 * BPF_STX ATOMIC (atomic ops)
                 */
                case BPF_STX | BPF_ATOMIC | BPF_W:
-                       if (insn->imm !=3D BPF_ADD) {
+                       if (insn[i].imm !=3D BPF_ADD) {
                                pr_err_ratelimited(
                                        "eBPF filter atomic op code %02x (@=
%d) unsupported\n",
                                        code, i);
@@ -695,7 +695,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image,=
 struct codegen_context *
                        PPC_BCC_SHORT(COND_NE, tmp_idx);
                        break;
                case BPF_STX | BPF_ATOMIC | BPF_DW:
-                       if (insn->imm !=3D BPF_ADD) {
+                       if (insn[i].imm !=3D BPF_ADD) {
                                pr_err_ratelimited(
                                        "eBPF filter atomic op code %02x (@=
%d) unsupported\n",
                                        code, i);



Thanks,
Naveen

