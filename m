Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B42331CA3
	for <lists+bpf@lfdr.de>; Tue,  9 Mar 2021 02:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhCIB5V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 20:57:21 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37196 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229793AbhCIB4z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Mar 2021 20:56:55 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1291rEg0030166
        for <bpf@vger.kernel.org>; Mon, 8 Mar 2021 17:56:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=a0EAI5NhjvAvksfas9J7OEmKgoE0p49p3KBAOfmDLbY=;
 b=O32DFlpTf2Ptkw8tzW3+NwS84oyzzLvnbQOrafW5ejAfiic1vP21tXgKBTCxPlqgIy4H
 EMqPNC2llzmxb+xK6MBgsgM8VvtrYwFBTIFJZ6a2EtlTNi3tF7uwc6WatWJ/ZBXou0AE
 tYBVoJczveXNfZM7mSXIRBKwlERwvdPpsoY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 374tamr94v-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 08 Mar 2021 17:56:55 -0800
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 8 Mar 2021 17:56:54 -0800
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 8AF511E5BD4; Mon,  8 Mar 2021 17:56:47 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>
Subject: [PATCH bpf-next] bpf: x86: use kvmalloc_array instead kmalloc_array in bpf_jit_comp
Date:   Mon, 8 Mar 2021 17:56:47 -0800
Message-ID: <20210309015647.3657852-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_22:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=935 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103090006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

x86 bpf_jit_comp.c used kmalloc_array to store jited addresses
for each bpf insn. With a large bpf program, we have see the
following allocation failures in our production server:
    page allocation failure: order:5, mode:0x40cc0(GFP_KERNEL|__GFP_COMP)=
,
                             nodemask=3D(null),cpuset=3D/,mems_allowed=3D=
0"
    Call Trace:
    dump_stack+0x50/0x70
    warn_alloc.cold.120+0x72/0xd2
    ? __alloc_pages_direct_compact+0x157/0x160
    __alloc_pages_slowpath+0xcdb/0xd00
    ? get_page_from_freelist+0xe44/0x1600
    ? vunmap_page_range+0x1ba/0x340
    __alloc_pages_nodemask+0x2c9/0x320
    kmalloc_order+0x18/0x80
    kmalloc_order_trace+0x1d/0xa0
    bpf_int_jit_compile+0x1e2/0x484
    ? kmalloc_order_trace+0x1d/0xa0
    bpf_prog_select_runtime+0xc3/0x150
    bpf_prog_load+0x480/0x720
    ? __mod_memcg_lruvec_state+0x21/0x100
    __do_sys_bpf+0xc31/0x2040
    ? close_pdeo+0x86/0xe0
    do_syscall_64+0x42/0x110
    entry_SYSCALL_64_after_hwframe+0x44/0xa9
    RIP: 0033:0x7f2f300f7fa9
    Code: Bad RIP value.

Dumped assembly:
    ffffffff810b6d70 <bpf_int_jit_compile>:
    ; {
    ffffffff810b6d70: e8 eb a5 b4 00        callq   0xffffffff81c01360 <_=
_fentry__>
    ffffffff810b6d75: 41 57                 pushq   %r15
    ...
    ffffffff810b6f39: e9 72 fe ff ff        jmp     0xffffffff810b6db0 <b=
pf_int_jit_compile+0x40>
    ;       addrs =3D kmalloc_array(prog->len + 1, sizeof(*addrs), GFP_KE=
RNEL);
    ffffffff810b6f3e: 8b 45 0c              movl    12(%rbp), %eax
    ;       return __kmalloc(bytes, flags);
    ffffffff810b6f41: be c0 0c 00 00        movl    $3264, %esi
    ;       addrs =3D kmalloc_array(prog->len + 1, sizeof(*addrs), GFP_KE=
RNEL);
    ffffffff810b6f46: 8d 78 01              leal    1(%rax), %edi
    ;       if (unlikely(check_mul_overflow(n, size, &bytes)))
    ffffffff810b6f49: 48 c1 e7 02           shlq    $2, %rdi
    ;       return __kmalloc(bytes, flags);
    ffffffff810b6f4d: e8 8e 0c 1d 00        callq   0xffffffff81287be0 <_=
_kmalloc>
    ;       if (!addrs) {
    ffffffff810b6f52: 48 85 c0              testq   %rax, %rax

Change kmalloc_array() to kvmalloc_array() to avoid potential
allocation error for big bpf programs.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Note: I labelled this patch as bpf-next as I cannot find a proper
      fix tag. The previous commit which touched the same code is
        7c2e988f400e ("bpf: fix x64 JIT code generation for jmp to 1st in=
sn")
      which is not this patch intending to fix.

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 79e7a0ec1da5..487de2d5fdd9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2221,7 +2221,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *prog)
 		padding =3D true;
 		goto skip_init_addrs;
 	}
-	addrs =3D kmalloc_array(prog->len + 1, sizeof(*addrs), GFP_KERNEL);
+	addrs =3D kvmalloc_array(prog->len + 1, sizeof(*addrs), GFP_KERNEL);
 	if (!addrs) {
 		prog =3D orig_prog;
 		goto out_addrs;
@@ -2313,7 +2313,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *prog)
 		if (image)
 			bpf_prog_fill_jited_linfo(prog, addrs + 1);
 out_addrs:
-		kfree(addrs);
+		kvfree(addrs);
 		kfree(jit_data);
 		prog->aux->jit_data =3D NULL;
 	}
--=20
2.24.1

