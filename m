Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C87469E8B8
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 21:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjBUUAN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 15:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjBUUAN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 15:00:13 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B09F27492
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:00:12 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x24so7340237lfr.1
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 12:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T2FsRXSdDKfM/ld7p4dTLRVlY7331MQbTB+ewdD0Viw=;
        b=aRc20QzOyTqIFgNe1KkZu2wcDE3AQAEmj+ecYLEkdatIP65jgTYi9yosinZKDqxuYS
         ZT1/F8YWu0lUaXaOK4laIk2yIM1/r/nZiB5wvkG/3mqEpgUhbDk33w+7t6ToEkf8xSiI
         JNiqNJ4Y5bxv5qV+s8gyLBu8vLl795LD8F2E0xrFTn4G/FuHbXuLPJFwJNM+FHg4VFGZ
         OjBk3mAFS/1vZMnLiYRdzZFD7u0mQ+we/cmjkLCWt6LQjf4HJY1KSecl1G73A1UJhDi/
         TgAZfpYuQ1g1ahpA1e/imKDWEazSS/FfA7WxukS578sdGu49ukq76VTX2GWe0CAu1LYA
         L3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2FsRXSdDKfM/ld7p4dTLRVlY7331MQbTB+ewdD0Viw=;
        b=kjgdMxOPFDxvJn2CvyoFYxPL3nv7rtNtQsIVfrGdSA3Rk/qaGGZw8BtEpYfEbuZRpf
         366GJeMIf33V2VMyWf75kNaMLkfVmrHgwk2oSu8Kv+5BbuVG/idbwubrGNXIH1uSUwE/
         shPKFfNKf6M6lnhl1crA7lgCVD66BBX3b6pPiwoOkOu/WepmGmZZ+0r/pjwAL0H/cGJY
         FCxiLQIcNEkDWVNMQwBDMPMyTbf9Qdt6ok+RTCkAjvygVYqUsyU3jed889dVJq77YwDM
         N8slAcHTKK0kiyeSLE8ges7mG3RGpYRw4W1vyg2GNohL6pkWM/lq6te17HxgMbBYAR90
         fmBw==
X-Gm-Message-State: AO0yUKUdXmLBw74bv2bPjOWopvwL6H64I+Kzj1WhPh4Xn+6+nOB7+frp
        4DtM4eeTD5iax6Xk5Vs8DgDXE8/cYZaxVPnJyLY=
X-Google-Smtp-Source: AK7set/0GygmhtK1OWByHJ+7Ek5sWXZ553sZDwIE8ybQHI8EyugDvMn9yfqp/MI3oXJuQac7wADarg==
X-Received: by 2002:a05:6512:205:b0:4d5:94a8:f8fc with SMTP id a5-20020a056512020500b004d594a8f8fcmr1659732lfo.26.1677009609591;
        Tue, 21 Feb 2023 12:00:09 -0800 (PST)
Received: from google.com (38.165.88.34.bc.googleusercontent.com. [34.88.165.38])
        by smtp.gmail.com with ESMTPSA id d23-20020ac25457000000b004d863fa8681sm589002lfn.173.2023.02.21.12.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:00:08 -0800 (PST)
Date:   Tue, 21 Feb 2023 20:00:03 +0000
From:   Matt Bobrowski <mattbobrowski@google.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, acme@redhat.com
Subject: Re: bpf: Question about odd BPF verifier behaviour
Message-ID: <Y/Uiw3AmVcPGai4d@google.com>
References: <Y/P1yxAuV6Wj3A0K@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/P1yxAuV6Wj3A0K@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 20, 2023 at 10:35:55PM +0000, Matt Bobrowski wrote:
> Hello!
> 
> Whilst in the midst of testing a v5.19 to v6.1 kernel upgrade, we
> happened to notice that one of our sleepable LSM based eBPF programs
> was failing to load on the newer v6.1 kernel. Using the below trivial
> eBPF program as our reproducer:
> 
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
> 
> char LICENSE[] SEC("license") = "Dual BSD/GPL";
> 
> SEC("lsm.s/bprm_committed_creds")
> int BPF_PROG(dbg, struct linux_binprm *bprm)
> {
> 	char buf[64] = {0};
> 	bpf_ima_file_hash(bprm->file, buf, sizeof(buf));
> 	return 0;
> }
> 
> The verifier emits the following error message when attempting to load
> the above eBPF program:
> 
> -- BEGIN PROG LOAD LOG --
> reg type unsupported for arg#0 function dbg#5
> 0: R1=ctx(off=0,imm=0) R10=fp0
> ; int BPF_PROG(dbg, struct linux_binprm *bprm)
> 0: (79) r1 = *(u64 *)(r1 +0)
> func 'bpf_lsm_bprm_committed_creds' arg0 has btf_id 137293 type STRUCT 'linux_binprm'
> 1: R1_w=ptr_linux_binprm(off=0,imm=0)
> 1: (b7) r2 = 0                        ; R2_w=0
> ; char buf[64] = {0};
> [...]
> ; bpf_ima_file_hash(bprm->file, buf, 64);
> 10: (79) r1 = *(u64 *)(r1 +64)        ; R1_w=ptr_file(off=0,imm=0)
> 11: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
> ; 
> 12: (07) r2 += -64                    ; R2_w=fp-64
> ; bpf_ima_file_hash(bprm->file, buf, 64);
> 13: (b7) r3 = 64                      ; R3_w=64
> 14: (85) call bpf_ima_file_hash#193
> cannot access ptr member next with moff 0 in struct llist_node with off 0 size 1
> R1 is of type file but file is expected
> processed 15 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> 
> What particularly strikes out at me is the following 2 lines returned
> in the error message:
> 
> cannot access ptr member next with moff 0 in struct llist_node with off 0 size 1
> R1 is of type file but file is expected
> 
> In this particular case, the above message suggested to me that
> there's likely multiple struct file definitions that exist within the
> kernel's BTF and that the verifier is possibly getting confused about
> which one it should be using, or perhaps some of the struct file
> definitions included in the kernel's BTF actually differ and hence
> when performing the btf_struct_ids_match() check in check_reg_type()
> [0] the verifier fails with this error message? Could this potentially
> be a problem with the toolchain (Currently, using latest pahole/LLVM
> built from source)?
> 
> Additionally, I also noticed that when we walk the BTF struct
> defintions via btf_struct_walk() from btf_struct_ids_match(), the size
> passed to btf_struct_walk() is explicitly set to 1. Yet, msize used
> throughout btf_struct_walk() can certainly be > 1 when evaluating a
> struct defintions members and hence why we're also tripping over this
> condition [1] in btf_struct_walk(). Don't completely understaed this
> code yet, so I don't know whether this is actually a problem or not.
> 
> Keen to here what your thoughts are on this one.

Note that I'm using the latest pahole [0] and LLVM [1] when building
things here.

Andrii/Arnaldo, do you happen to have any pointers on debugging this
BTF ID redundancy, which I suspect is what's going on here?

[0] https://git.kernel.org/pub/scm/devel/pahole/pahole.git
[1] https://github.com/llvm/llvm-project.git

/M
