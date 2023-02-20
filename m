Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED34969D65D
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 23:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjBTWgL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 17:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjBTWgL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 17:36:11 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58A51EFFA
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 14:36:04 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a10so2605754ljq.1
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 14:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gxSxCMQLDg74+qYSOVD5OnVif3VGIj0OD1vSeL1se8w=;
        b=si16HQqcestAhdnFeXrujawBO3Cl6ESPM6/Zp32NifN1Yp2GJVfEsIiMc70yr2YxG0
         mkvKsNuwhMGm77aJM5Ztr9fIr3x/P7WVhyuS+hVQTKJUQthyUmmDJTygZ9tJNjUFrAjt
         dbPMprc0UeuMRumlUHxfvD1Y7LuGgVykfcxIxVrP0Ni+HBCIhHlPzvmeOdAG4hii8QSe
         mrC4gN4/Av+85bkDO4K72YWhfh/B03Vg91nlLNotMPR1Ib26SAbgfl3oW6mrewVPkC3y
         RiNOjxtWYqTFNskEyHzqd3rKoJLyB2njxKIjMYRsXCY79QGDzPoOLZJ/BN6KEsmFsOKZ
         JKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxSxCMQLDg74+qYSOVD5OnVif3VGIj0OD1vSeL1se8w=;
        b=s5X8DPONPOX+476YM5nIPDvb18Tw9VRk+fQOecPh6vWeZeYlTrcIAy5lUSmRdc3Hd1
         wknsnS4wjVO4nsVZQc5mZbffoBuzyTjg6Grk95Lbqfqn58BxOW6o74rh67oeA3WOhR+3
         myyl3XEoLqa9+8zkRO4gDNcKWcJiU7fLd1LM0jQfoXJtdjlFe6lxQ2Pj+vczyx8dhcXr
         hB4sYX5XMvVlyoX5ZlpRM9KjcHBfqu/tb0wAE5g8o6gdHrB7xpLNCWqmpExjGuPTEno0
         pn24b6niTHxrJBa0YJ9jVnigabbcROb0BYrHn6SQY49SsTTrAimX7cfBWB0ouRdW6+VH
         Ouag==
X-Gm-Message-State: AO0yUKUkIae61vz57ZwQz/qwRGS/vwL9Wm9yVC8M9YZ7/S0h0IR4StEy
        3odaI3jyZVKWzbKEXCj7UJC9f4u3HSMYAvIuC4I=
X-Google-Smtp-Source: AK7set+/LIQd479+c7P+tDIUBinbHdlRNi2iZwvba/yV8i57IsdmfmBVNEBp1xvoblx0Uj8cXhcDbg==
X-Received: by 2002:a05:651c:54e:b0:294:6f53:ec14 with SMTP id q14-20020a05651c054e00b002946f53ec14mr1318308ljp.13.1676932562238;
        Mon, 20 Feb 2023 14:36:02 -0800 (PST)
Received: from google.com (38.165.88.34.bc.googleusercontent.com. [34.88.165.38])
        by smtp.gmail.com with ESMTPSA id e13-20020a2e930d000000b002934b6236absm1735653ljh.95.2023.02.20.14.36.01
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:36:01 -0800 (PST)
Date:   Mon, 20 Feb 2023 22:35:55 +0000
From:   Matt Bobrowski <mattbobrowski@google.com>
To:     bpf@vger.kernel.org
Subject: bpf: Question about odd BPF verifier behaviour
Message-ID: <Y/P1yxAuV6Wj3A0K@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-16.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        LOCALPART_IN_SUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello!

Whilst in the midst of testing a v5.19 to v6.1 kernel upgrade, we
happened to notice that one of our sleepable LSM based eBPF programs
was failing to load on the newer v6.1 kernel. Using the below trivial
eBPF program as our reproducer:

#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>

char LICENSE[] SEC("license") = "Dual BSD/GPL";

SEC("lsm.s/bprm_committed_creds")
int BPF_PROG(dbg, struct linux_binprm *bprm)
{
	char buf[64] = {0};
	bpf_ima_file_hash(bprm->file, buf, sizeof(buf));
	return 0;
}

The verifier emits the following error message when attempting to load
the above eBPF program:

-- BEGIN PROG LOAD LOG --
reg type unsupported for arg#0 function dbg#5
0: R1=ctx(off=0,imm=0) R10=fp0
; int BPF_PROG(dbg, struct linux_binprm *bprm)
0: (79) r1 = *(u64 *)(r1 +0)
func 'bpf_lsm_bprm_committed_creds' arg0 has btf_id 137293 type STRUCT 'linux_binprm'
1: R1_w=ptr_linux_binprm(off=0,imm=0)
1: (b7) r2 = 0                        ; R2_w=0
; char buf[64] = {0};
[...]
; bpf_ima_file_hash(bprm->file, buf, 64);
10: (79) r1 = *(u64 *)(r1 +64)        ; R1_w=ptr_file(off=0,imm=0)
11: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
; 
12: (07) r2 += -64                    ; R2_w=fp-64
; bpf_ima_file_hash(bprm->file, buf, 64);
13: (b7) r3 = 64                      ; R3_w=64
14: (85) call bpf_ima_file_hash#193
cannot access ptr member next with moff 0 in struct llist_node with off 0 size 1
R1 is of type file but file is expected
processed 15 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
-- END PROG LOAD LOG --

What particularly strikes out at me is the following 2 lines returned
in the error message:

cannot access ptr member next with moff 0 in struct llist_node with off 0 size 1
R1 is of type file but file is expected

In this particular case, the above message suggested to me that
there's likely multiple struct file definitions that exist within the
kernel's BTF and that the verifier is possibly getting confused about
which one it should be using, or perhaps some of the struct file
definitions included in the kernel's BTF actually differ and hence
when performing the btf_struct_ids_match() check in check_reg_type()
[0] the verifier fails with this error message? Could this potentially
be a problem with the toolchain (Currently, using latest pahole/LLVM
built from source)?

Additionally, I also noticed that when we walk the BTF struct
defintions via btf_struct_walk() from btf_struct_ids_match(), the size
passed to btf_struct_walk() is explicitly set to 1. Yet, msize used
throughout btf_struct_walk() can certainly be > 1 when evaluating a
struct defintions members and hence why we're also tripping over this
condition [1] in btf_struct_walk(). Don't completely understaed this
code yet, so I don't know whether this is actually a problem or not.

Keen to here what your thoughts are on this one.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/bpf/verifier.c#n6278
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/bpf/btf.c#n6237

/M
