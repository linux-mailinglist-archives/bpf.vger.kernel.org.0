Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E367625654
	for <lists+bpf@lfdr.de>; Tue, 21 May 2019 19:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfEURG6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 May 2019 13:06:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50268 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbfEURG6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 May 2019 13:06:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LH4TKu008515;
        Tue, 21 May 2019 17:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=SCIScQ0uw9hvxrZB2jY9cbQFN9r1+sHJc0RTsq9YXfc=;
 b=IoDfUjpEXNvLMsArZmm541AzC2Qp1NlYt0FXMfcQFTHlpxzkUojILYdJZA4ll5xmrLJc
 Ej7qAn9K/rw26NQbsvqi+VvVXk8muFSjiaOB4ZGfuSEiirQ3XP5yMpz8xqjtveuvto8t
 R8N3GMcj9/MGjpQBFqclDAZkqjFWSkRAF8ZikzelFIM3G4scwvyVFTOvJBgABNXGv//g
 AmCabup6dQldNnnJkxF6DhHcdJuxn+QatGVBcjfjwI6q9xZ6rRpd/VyPQ9X3K4meL+in
 D2jEXw85XbzQ+nbAG7fyz4C9GB782ONfr7etexLvm2DNc7DCG8W1P5VB2MkjT0YQbzlr nQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2sj9ftewcx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 17:06:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LH4rPJ162185;
        Tue, 21 May 2019 17:06:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2skudbgmv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 17:06:33 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4LH6TgC016914;
        Tue, 21 May 2019 17:06:30 GMT
Received: from termi.oracle.com (/10.175.32.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 17:06:29 +0000
From:   jose.marchesi@oracle.com (Jose E. Marchesi)
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     binutils@sourceware.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [PATCH 0/9] eBPF support for GNU binutils
References: <1B2BE52B-527E-436E-AE49-29FA9E044FD3@netronome.com>
Date:   Tue, 21 May 2019 19:06:21 +0200
In-Reply-To: <1B2BE52B-527E-436E-AE49-29FA9E044FD3@netronome.com> (Jiong
        Wang's message of "Tue, 21 May 2019 16:41:56 +0100")
Message-ID: <87d0kbrb3m.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=870
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210104
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=961 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210105
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi Jiong.

    > Despite using a different syntax for the assembler (the llvm assembler
    > uses a C-ish expression-based syntax while the GNU assembler opts for
    > a more classic assembly-language syntax) this implementation tries to
    > provide inter-operability with clang/llvm generated objects.
=20=20=20=20
    I also noticed your implementation doesn=E2=80=99t seem to use the same=
 sub-register
    syntax as what LLVM assembler is doing.
=20=20=20=20
      x register for 64-bit, and w register for 32-bit sub-register.
=20=20=20=20
    So:
      add r0, r1, r2 means BPF_ALU64 | BPF_ADD | BFF_X
      add w0, w1, w1 means BPF_ALU | BPF_ADD | BPF_X
=20=20=20=20
    ASAICT, different register prefix for different register width is also =
adopted
    by quite a few other GNU assembler targets like AArch64, X86_64.

Right.  I opted for using different mnemonics for alu and alu64
instructions, as it seemed to be simpler.

What was your rationale for using sub-register notation?  Are you
planning to support instructions (or pseudo-instructions) mixing w and x
registers in the future?

    > In particular, the numbers of the relocations used for instruction
    > fields are the same.  These are R_BPF_INSN_64 and R_BPF_INSN_DISP32.
    > The later is resolved at load-time by bpf_load.c.
=20=20=20=20
    I think you missed the latest JMP32 instructions.
=20=20=20=20
      https://github.com/torvalds/linux/blob/master/Documentation/networkin=
g/filter.txt#L870

Oh thanks for spotting that.
Adding support for it :)
