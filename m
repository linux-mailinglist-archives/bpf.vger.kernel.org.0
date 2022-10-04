Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A385F3B5D
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 04:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJDCWd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 22:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJDCWI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 22:22:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DCC42AFE
        for <bpf@vger.kernel.org>; Mon,  3 Oct 2022 19:19:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f21so3559083plb.13
        for <bpf@vger.kernel.org>; Mon, 03 Oct 2022 19:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=NQVjpE3arV86NIflGggCBNny8dEJ+BQUpvTxw6anHmU=;
        b=S+/LufCBHTgxxTRsh9bAskNWIEaJRi3Fgb3nvQKmKCZBB3PhzXibWvnlC9t30KpRl4
         N1Suoa+gfBgM5q4JeJc1mpRJVO5UTtllmWVg/KdhCNEXa0pbGElTQM9o+5SaYCG3b81L
         FklqmqK3BCafJSUb8VG83UbMG2ZFupr5ETISQYC3IlytYzaTO6wQUcr/LHaCdjLJ06qF
         ECtbPwlOrWScuFfwiY5a9KTHP8kxNG7mtZPAGSvNpheh2KOP2RvIV9SlZRKLYXuAYb4F
         Y+Gns6uGp9fuoz4I+yaEHMRzLJAetNYHfwFsxdsCVJc448nQ3cFmofmnCq+ROafe7Lxq
         K2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=NQVjpE3arV86NIflGggCBNny8dEJ+BQUpvTxw6anHmU=;
        b=ZK8mNzZLa+augzyn61w/PlOfyxsgmbbDU+fMVa9uFWNMk+vi7mAUm1ee1jWL/DECFc
         9AXeFyUuMwIH/2+/+uyR0vuueDyxlngIrXLmNY5ErKPPwDUoXZPsTcNFbXZwbXNXJCK9
         7mTvkyAP7MVWeYs7yVDumeA7cUUqkxh+6c6JmihqjxuYS4fqx8GBguddabJxsvvHjwvo
         wTjE0dfwEC/BxJkaidf/LnrVwVoxCkOMvVdW3lkq7XwDLqlk1v3mBGMZgSIjF3PG0YHO
         p4AzB3eJARISskdjGo/damfXUaEFfy8YqIWrdrcgBkw52ge18JkLyTq/dO/it21BmCWg
         Rxew==
X-Gm-Message-State: ACrzQf0UE43+dlSsIDAdbSnQs/UFkvzSzf4HXOdLStGuegzdLkOqbmNh
        qNrARAJpS7PNdPYBvosJlbwbvU8ELN/CPVgH4sQJ3flDwl0=
X-Google-Smtp-Source: AMsMyM4OJSkokC6Ul9HYWsG6AQjCPrgyc56bf2FQFZQqzeCuTctyi4r4KRJzi5tjGXV4kRmsfH9sVZ4AHUdaQc/9ja8=
X-Received: by 2002:a17:902:ced2:b0:17f:5eb2:cd72 with SMTP id
 d18-20020a170902ced200b0017f5eb2cd72mr7198232plg.162.1664849926797; Mon, 03
 Oct 2022 19:18:46 -0700 (PDT)
MIME-Version: 1.0
From:   Henrique Fingler <henrique.fingler@gmail.com>
Date:   Mon, 3 Oct 2022 21:18:35 -0500
Message-ID: <CACG+mBWpDSrxUR4RehJPpcF_BdF8-7+HHqmdq+ULpWrpE8BGDA@mail.gmail.com>
Subject: Can't reproduce kfunc example in kfuncs documentation, kernel v6.0
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm trying to reproduce the example in `Documentation/bpf/kfuncs.rst`
in kernel 6.0
My end goal is to be able to call a kfunc from a kprobe, so the
documentation seemed like a good start.
I've created a file with almost the same content as the documentation
(below) and put it in
net/bpf and added it to the Makefile, with the added __diag directives
that are in
net/bpf/test_run.c around the kfuncs.

 __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
      "Global functions as their definitions will be in vmlinux BTF");
  u64 bpf_get_task_pid(void) {
    return 1;
  }
   u64 bpf_put_pid(void) {
    return 2;
  }
  __diag_pop();

  BTF_SET8_START(bpf_task_set)
  BTF_ID_FLAGS(func, bpf_get_task_pid)
  BTF_ID_FLAGS(func, bpf_put_pid)
  BTF_SET8_END(bpf_task_set)

  static const struct btf_kfunc_id_set bpf_task_kfunc_set = {
      .owner = THIS_MODULE,
      .set   = &bpf_task_set,
  };

  static int bpftest_init_subsystem(void)
  {
    pr_warn(">>>>>>>>>>>>>>> bpftest_init_subsystem registered");
    //I want BPF_PROG_TYPE_KPROBE, but I'm testing also with
BPF_PROG_TYPE_TRACEPOINT
    return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_task_kfunc_set);
  }
  late_initcall(bpftest_init_subsystem);


I can see that this is being registered, but after that I see many
(16, all the same) messages like the one below.
These messages are gone if I don't compile the file I created above.
Is this file breaking something in bpf?

[    5.845543] failed to validate module [cryptd] BTF: -22
[    5.861117] BPF: [129150] STRUCT
[    5.862980] BPF: size=96 vlen=1
[    5.864710] BPF:
[    5.865941] BPF: Invalid name
[    5.867221] BPF:


Ignoring these errors, I've tried both KPROBE and TRACEPOINT prog
types in `register_btf_kfunc_id_set`.
I can't find what a program with "tracing" is, so I changed it to
BPF_PROG_TYPE_TRACEPOINT and used
an example from the kernel: samples/bpf/syscall_tp_kern.c
As for testing with KPROBE, I'm using the kprobe.bpf.c do_unlinkat
example in libbpf/libbpf-bootstrap.
It seems like the kfunc is not being found in the set, or the set is
not registered correctly,
since running the bpf program with any of the two types prints out:

  libbpf: prog 'trace_enter_open': BPF program load failed: Permission denied
  ...
  calling kernel function bpf_get_task_pid is not allowed

Both the bpf programs are simple, their bodies have:
    __u64 a = bpf_get_task_pid();
The function is getting resolved since I see
libbpf: extern (func ksym) 'bpf_get_task_pid': resolved to kernel

How can I correctly register a set and make the kernel allow me to call a kfunc?
Thank you.
