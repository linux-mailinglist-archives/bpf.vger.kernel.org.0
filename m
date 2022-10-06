Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CE75F61B3
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 09:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiJFHfG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 03:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiJFHfE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 03:35:04 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD417896
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 00:35:03 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i3so1299320pfk.9
        for <bpf@vger.kernel.org>; Thu, 06 Oct 2022 00:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QWhVLm63AQX3TiSyWpFvLOcYaPw3NgLH2OxQmrV11Sg=;
        b=Axg8+BLjgrUFwJyUji1N+qAUmhOcEMNIhKqQfPK2akI5IK94boRVTmf4DwQtZQmNf/
         N0NZjHeGYw+lKJPDwvdjj33S0D0zuDMQ0ll4zG/uIzGZ2Mk/g0q/FcQx98pGQA0VQj+e
         tDVagBBBksUEA784at/ZqHmVTzjSl+5hVDHObmI7L6DaKscPd8tKxt2j5bW03XON6Qbu
         t5E62ZeFphsxpR8ybtrzqEznurO7nagLp+a1zO2B7jybHJG0/H780PLGYQosf7yqCNIp
         dsNRHvkp8NuAS10Gz1JwQNs7oNUYwHWjHMZiRrS++1fS3FwrqVt1FijzvtS5AOylzcZR
         hSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWhVLm63AQX3TiSyWpFvLOcYaPw3NgLH2OxQmrV11Sg=;
        b=m/OOnItMlk4HteyXS6Ah0ujmXK0MJtw3qjk0StPiAvAdMiKnmHcrcCkUwgj5yehDPD
         MkPFfzVzEaSLgkfGl/EWLtIQ8VDb78uEvQ50dvs+clp7BU3CEP/2p011/sGAotw4Lg4s
         2OUcVJUYd3FwTy5z8safolkOlyqND1/P2RnwsA9llg1tLziTocY2ybjUMHloq3URAkL4
         Corvl/R+e619ppBznMEytkeh2os8SBKhfnq8em+N/sQCwS22Yo0p4Geh3o+egCrXunNG
         fBC3CfrpQ4SuqNcXj8iV7J9++jAp0useRc1GcPbdzihNLKPjT8OYbLAhl2NNHCaUYcE4
         DMqA==
X-Gm-Message-State: ACrzQf3Id7mbvaV6HXMMWB4LQb0M8dfEHeemSQ79zSbVr502759kDlpc
        REYw6XBElHXkWjDFQ5G/eHLuPxjHpajDEkcZ1+dfSristcZoiQ==
X-Google-Smtp-Source: AMsMyM7AAFkuT/YCqF9H3oCAYR4z8q5TC1IiVzyV5NBsP9x1I5f6hAJ/kNsWjVz73oNUHrS3feMXKSDphmwL1zUvZXE=
X-Received: by 2002:a63:698a:0:b0:41c:8dfa:e622 with SMTP id
 e132-20020a63698a000000b0041c8dfae622mr3237612pgc.465.1665041702100; Thu, 06
 Oct 2022 00:35:02 -0700 (PDT)
MIME-Version: 1.0
From:   Akihiro HARAI <jharai0815@gmail.com>
Date:   Thu, 6 Oct 2022 16:34:46 +0900
Message-ID: <CAFo4XKvHU8gn9PoYwrFA0OyBDGY7=bBvwMDNuWGxR6gkLgudOg@mail.gmail.com>
Subject: Inconsistent BTF entries for `struct pt_regs *regs` parameter
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Depending on distribution/kernel/syscall combination, BTF entry for
`struct pt_regs *regs` parameter differs.

For example, Amazon Linux 2 with kernel-5.15 package enabled has a FWD
entry for `__x64_sys_recvmsg` function:

```
$ uname -a
Linux ip-10-1-1-66.ap-northeast-1.compute.internal
5.15.43-20.123.amzn2.x86_64 #1 SMP Fri May 27 00:28:44 UTC 2022 x86_64
x86_64 x86_64 GNU/Linux

$ bpftool btf dump file /sys/kernel/btf/vmlinux format raw
...
[15439] FWD 'pt_regs' fwd_kind=struct
[15440] CONST '(anon)' type_id=15439
[15441] PTR '(anon)' type_id=15440
[15442] FUNC_PROTO '(anon)' ret_type_id=34 vlen=1
        '__unused' type_id=15441
...
[15694] FUNC '__x64_sys_recvmsg' type_id=15442 linkage=static
...
```

while Ubuntu 20.04 LTS with newer kernel has a STRUCT entry for the
same function:

```
$ uname -a
Linux xxx-XPS-13-9300 5.13.0-51-generic #58~20.04.1-Ubuntu SMP Tue Jun
14 11:29:12 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux

$ bpftool btf dump file /sys/kernel/btf/vmlinux format raw
[1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
...
[226] STRUCT 'pt_regs' size=168 vlen=21
        'r15' type_id=1 bits_offset=0
        'r14' type_id=1 bits_offset=64
        'r13' type_id=1 bits_offset=128
        'r12' type_id=1 bits_offset=192
        'bp' type_id=1 bits_offset=256
        'bx' type_id=1 bits_offset=320
        'r11' type_id=1 bits_offset=384
        'r10' type_id=1 bits_offset=448
        'r9' type_id=1 bits_offset=512
        'r8' type_id=1 bits_offset=576
        'ax' type_id=1 bits_offset=640
        'cx' type_id=1 bits_offset=704
        'dx' type_id=1 bits_offset=768
        'si' type_id=1 bits_offset=832
        'di' type_id=1 bits_offset=896
        'orig_ax' type_id=1 bits_offset=960
        'ip' type_id=1 bits_offset=1024
        'cs' type_id=1 bits_offset=1088
        'flags' type_id=1 bits_offset=1152
        'sp' type_id=1 bits_offset=1216
        'ss' type_id=1 bits_offset=1280
...
[5183] CONST '(anon)' type_id=226
...
[5189] PTR '(anon)' type_id=5183
...
[5321] FUNC_PROTO '(anon)' ret_type_id=42 vlen=1
        '__unused' type_id=5189
...
[17648] FUNC '__x64_sys_recvmsg' type_id=5321 linkage=static
...
```

Yet another distribution/kernel/syscall combination has multiple `FUNC
'__x64_sys_[SYSCALL]'` entries, one for FWD and the other for STRUCT:

```
$ uname -a
Linux ip-10-5-0-115.ap-northeast-1.compute.internal
5.10.112-108.499.amzn2.x86_64 #1 SMP Wed Apr 27 23:39:40 UTC 2022
x86_64 x86_64 x86_64 GNU/Linux

```
$ bpftool btf dump file /sys/kernel/btf/vmlinux format raw | grep
__x64_sys_mprotect
...
[175] STRUCT 'pt_regs' size=168 vlen=21
        'r15' type_id=2 bits_offset=0
        'r14' type_id=2 bits_offset=64
        'r13' type_id=2 bits_offset=128
        'r12' type_id=2 bits_offset=192
        'bp' type_id=2 bits_offset=256
...
[4215] CONST '(anon)' type_id=175
...
[4220] PTR '(anon)' type_id=4215
...
[6062] FUNC_PROTO '(anon)' ret_type_id=36 vlen=1
        'regs' type_id=4220
...
[11461] FWD 'pt_regs' fwd_kind=struct
[11462] CONST '(anon)' type_id=11461
[11463] PTR '(anon)' type_id=11462
[11464] FUNC_PROTO '(anon)' ret_type_id=36 vlen=1
        '__unused' type_id=11463
...
[11698] FUNC '__x64_sys_mprotect' type_id=11464 linkage=static
...
[23528] FUNC '__x64_sys_mprotect' type_id=6062 linkage=static
...
```

Trying to read `regs` parameter with FWD entry results in "invalid
bpf_context access" error:

```
SEC("fentry/__x64_sys_recvfrom")
int BPF_PROG(fentry_syscall, struct pt_regs *regs) {
  struct event t;

  bpf_get_current_comm(t.comm, TASK_COMM_LEN);

  u64 id = bpf_get_current_pid_tgid();
  t.pid = id >> 32;

  // This causes an error on some environments.
  t.fd = PT_REGS_PARM1_CORE(regs);

  bpf_printk("comm: %s, pid: %d, fd: %d", t.comm, t.pid, t.fd);

  return 0;
```

```
$ sudo ./output
2022/07/01 03:33:01 loading objects: field FentrySyscall: program
fentry_syscall: load program: permission denied:
        arg#0 type is not a struct
        Unrecognized arg#0 type PTR
        ; int BPF_PROG(fentry_syscall, struct pt_regs *regs) {
        0: (79) r6 = *(u64 *)(r1 +0)
        func '__x64_sys_recvfrom' arg0 type FWD is not a struct
        invalid bpf_context access off=0 size=8
        processed 1 insns (limit 1000000) max_states_per_insn 0
total_states 0 peak_states 0 mark_read 0
```

Is this a bug related to toolchain?

I've asked this question to AWS support (owner of Amazon Linux 2) but
they couldn't answer. I've also asked on StackOverflow but no
responses as of now. A cilium/ebpf developer told me to ask here.

* https://stackoverflow.com/questions/72824924/invalid-bpf-context-access-when-trying-to-read-regs-parameter
* https://github.com/cilium/ebpf/issues/723#issuecomment-1190050109
* https://github.com/harai/invalidbpfcontext
