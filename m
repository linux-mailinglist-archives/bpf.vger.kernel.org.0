Return-Path: <bpf+bounces-42861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 891839ABBE3
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 04:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8ECF1C22EF6
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 02:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD27652F88;
	Wed, 23 Oct 2024 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LoMxed1C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71417F7
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 02:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651963; cv=none; b=Co6/8dqzJs1ci94RRssMaCZYb4zReFs5lOp1Buf5HcRqYkefTaOhZ0Q/J5FuKVC90Se0qOQs9zHoYk0s2ykRyvJzCAoOfxWjXLDvNDk6PR8WlT0hQjVxl8r+88DYYduoPdFHTN7BSH3piI2QUVwyzQCM8twFVpuJyPliDPVTgXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651963; c=relaxed/simple;
	bh=H7+2GH3wXViuMasJK1NqubZnzRVvQwavuVJ8NjYHukE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A1vClfBC1qbYZ1HZwM32PDojcVOH99fYov8TEVCKA+CaBdv9t4o4orvwoIyImxI034zW5wwBZSHAfBHwcUyBCRICqGi+uZJIXB+BwIauch4V/LejiB+W1cYMaT3F8elJpYNRVYXgnMp1O1DF/sV/+jWRWeojDcyOhSRtdMTF/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LoMxed1C; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-27b7a1480bdso2824328fac.2
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 19:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729651961; x=1730256761; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l3ryjbUZjFzVL7gM7OVWj+6bXBkFo2uBXwzp/AJWeAA=;
        b=LoMxed1CZwVQWDMIzGks+wimKHzjp/VK3cGSmSk0RRUa9TW4lkODBcC5Ki0tqH90Lm
         RwNtRoLI97l0DyXkF/PFZD09Ijg1IsqHBP1ojrbEFjUyC7j9vnYItKPAs8JvswC8H6Rx
         49tePD+DDYITS9jmW/0mN9fLnzv3dIAoReqwu6a6h4wVUonpidEnaoKFGC2dD2BTNSog
         k1eSVzKQeP+cAT9Q8cZzuEqDdLWyC9QdM37OzAiX5AgTDMdEdqHgBS5LzPNhHPwu7oVB
         PJpoCcq2ALPBxdtcUbyYZzvgole6O9frAGyTlMxjrLyO2VDLzC4ael9cx3Mtw+vALVtz
         TEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729651961; x=1730256761;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3ryjbUZjFzVL7gM7OVWj+6bXBkFo2uBXwzp/AJWeAA=;
        b=RDU/TBLc9s1t2GfB1UzthiOwZ4wvnCbOfyz3tzVC83TmIqHbaLIeir7u5P6tOtYblk
         xx8AeCp/rnpXZhIIBap+lwx/G9wqvTa7zGhzaF4yC1N9Ls1NU5yeRewQ5KFUOZcZQL0F
         2/QDoFKH6Gvykrj168dBDYMY9gT5geI87pTlvPopgun6maT86Xmg8SnFqM4f4vgoRTzJ
         UXK1OubN5paFGuMSDgwhBxFsayd4vBktSFskp2guS3jJ+hAY3BgsExurtjs8tp8qGn78
         fBK4oRH/JVey+WRro4BYa2rh1qZxfJhsGl0zxpcjuBY88gEqsd0dsc177OAtFnTgOcVR
         sNoQ==
X-Gm-Message-State: AOJu0Yw8yw8CnuYkAJmEgOMIeFzZSLml6Np2wQfipLB9g0WadizqFjZp
	bPwMzo7hYys+5ek1Oy8bqj02TNa9yIatETUfO67Z2KF7Zk9Z+6W1
X-Google-Smtp-Source: AGHT+IFAQd50S/mOd1fKB3rItZwLE6n918kvK9i6Xn498/1MhxQnhrfX0rJ/JOFKwMhpiCrNyAyhHw==
X-Received: by 2002:a05:6870:330e:b0:287:3cf8:4abe with SMTP id 586e51a60fabf-28ccb486d47mr1345125fac.18.1729651960796;
        Tue, 22 Oct 2024 19:52:40 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312d3dsm5577416b3a.17.2024.10.22.19.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 19:52:40 -0700 (PDT)
Message-ID: <a9bd25331dbfdd5a968f9c4320608d2949176fc1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: force checkpoint when jmp history
 is too long
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>
Date: Tue, 22 Oct 2024 19:52:35 -0700
In-Reply-To: <658394292b21edb9b30a5add27a8cd7fa8a778ed.camel@gmail.com>
References: <20241018020307.1766906-1-eddyz87@gmail.com>
	 <CAADnVQKtR96Dricc=JiOi3VR9OeHjgT6xLOto9k_QcpPQNsKJw@mail.gmail.com>
	 <1564924604e5e17af10beac6bd3263481a1723f0.camel@gmail.com>
	 <CAADnVQJa8+tLnxpMWPVXO=moX+4tv3nTomang5=PAeLjVAe+ow@mail.gmail.com>
	 <658394292b21edb9b30a5add27a8cd7fa8a778ed.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-21 at 22:38 -0700, Eduard Zingerman wrote:

[...]

> This takes ~10 minutes to verify on master.
> Surprisingly current patch does not seem to help,
> I'll investigate this tomorrow.
> Full example is in the end of the email.

I messed up the example a little bit.
The example shared previously takes so long to process because of "goto +0;=
".
opt_remove_nops() deletes such jumps and we know that bpf_remove_insns()
is not efficient.

Corrected example uses conditional jump in place of "goto +0;" and
slightly adjusted counters. Full program is here:
https://gist.github.com/eddyz87/cb813387323b78bcd6a7e264fc44c817
Here is it's verification log to get the idea:

    0:  (79) r2 =3D *(u64 *)(r1 +0)
    1:  (b7) r0 =3D 0
    2:  (35) if r2 >=3D 0x1 goto pc+5
    push_stack: at 2, jmp_history_cnt 0
    3:  (35) if r0 >=3D 0x0 goto pc+0
    4:  (35) if r0 >=3D 0x0 goto pc+0
    5:  (35) if r0 >=3D 0x0 goto pc+0
    6:  (35) if r0 >=3D 0x0 goto pc+0
    is_state_visited: new checkpoint at 7, resetting env->jmps_processed
    7:  (95) exit
    8:  (35) if r2 >=3D 0x2 goto pc+7
    push_stack: at 8, jmp_history_cnt 1
    9:  (35) if r0 >=3D 0x0 goto pc+0
    10: (35) if r0 >=3D 0x0 goto pc+0
    11: (35) if r0 >=3D 0x0 goto pc+0
    12: (35) if r0 >=3D 0x0 goto pc+0
    13: (35) if r0 >=3D 0x0 goto pc+0
    14: (35) if r0 >=3D 0x0 goto pc+0
    is_state_visited: new checkpoint at 15, resetting env->jmps_processed
    15: (95) exit
    ...
    320: (35) if r2 >=3D 0x29 goto pc+7
    push_stack: at 320, jmp_history_cnt 40
    320: R2_w=3D40
    321: (35) if r0 >=3D 0x0 goto pc+0
    322: (35) if r0 >=3D 0x0 goto pc+0
    323: (35) if r0 >=3D 0x0 goto pc+0
    324: (35) if r0 >=3D 0x0 goto pc+0
    325: (35) if r0 >=3D 0x0 goto pc+0
    326: (35) if r0 >=3D 0x0 goto pc+0
    is_state_visited: new checkpoint at 327, resetting env->jmps_processed
    327: (95) exit
    ...

A bpf program w/o loops, at each 'if r2 >=3D ...' push_stack() saves a
state with ever increasing jump history.
- right amount of 'if r0 >=3D ...' instructions is maintained before 'exit'
  to force a new checkpoint;
- exit is processed;
- state is popped from the stack and first insn it processes is
  'if r2 >=3D ...', thus a new state is saved by push_stack()
  with jump history longer by 1.

On master this fails with ENOMEM and the following error in the log:

    [  418.083600] test_progs: page allocation failure: order:7, mode:0x140=
cc0(GFP_USER|__GFP_COMP), \
                     nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
                   ...
    [  418.084158] Call Trace:
                    ...
    [  418.084649]  krealloc_noprof+0x53/0xd0
    [  418.084688]  copy_verifier_state+0x78/0x390
                    ...

Same happens if jmp_history_cnt check is moved to 'skip_inf_loop_check':

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18022,7 +18022,7 @@ static int is_state_visited(struct bpf_verifier_env=
 *env, int insn_idx)
                         * at the end of the loop are likely to be useful i=
n pruning.
                         */
 skip_inf_loop_check:
-                       if (!force_new_state &&
+                       if (!force_new_state && cur->jmp_history_cnt < 40 &=
&
                            env->jmps_processed - env->prev_jmps_processed =
< 20 &&
                            env->insn_processed - env->prev_insn_processed =
< 100)


Or if it is in the else branch. Simply because 'skip_inf_loop_check' is
for instructions that have been already seen on the current verification pa=
th.

However, with change suggested in this patch-set such ENOMEM situation
is not possible. Hence I insist that large enough jmp_history_cnt
should force a new state, and point where I put the check covers more
cases then alternatives.


