Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9A8262538
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 04:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgIICee (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Sep 2020 22:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgIICee (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Sep 2020 22:34:34 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EDDC061573
        for <bpf@vger.kernel.org>; Tue,  8 Sep 2020 19:34:33 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id k25so1461229ljg.9
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2020 19:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vFkfZWpjgRh1NQLNys9wcGlctEWtDdWXhoTm7TOKGhA=;
        b=IfqMRsFcEqAEyQpgkhq3fnSaWmqPqUyP8iGmAVwzMTSxY/NYaWhd0p7GvFrUqAFObB
         bLryPzXhjioucS3cch1erP1WY2cmYgno3V4klDIBbTWN4JUxKPcOWLEzO2KyTknJz4UE
         9Fr78Wa3jUr0VW0b9odSyZHAtF9egdPJ9uloOE1slZkz0GtdJG6BWau1Vvnta5qaNhXm
         Clf+SMQubTlaO5XVoQgrKzvOW6YgpV1ruprAzQE9s4AsQRiSUrKGF9Xi0iXxElELhd3h
         tbUpT1h3KddcdGzZ3p93HEIgayBe5bUshFEsp70SAYa3VnUZD1CheTIGYfoRcqerDfY5
         XdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vFkfZWpjgRh1NQLNys9wcGlctEWtDdWXhoTm7TOKGhA=;
        b=NjoNkVgLN83aIi+/9z/BHjfH+ClQo45QNB1cdd1rO+AKJ5W3sJAs8x71IVC04eGC2o
         xfVla80fFYttUJv6LVUVav67gIZ99zqzpRZc8LIh8IM+omY+kXPM3MATVUqjzDpJ2+nF
         f10HMEcRIGWFPFdecLv/DtrlhAgGvfkoZDVfUmFdC7WsWkNMa5nw02MZ2hNwVqzJ2NX2
         t5yjKJWA34oBfCWwclUUqGKwY3GuSBi1GwkZEADQU4Mk2H9xeYraa3ZUskQmfhm1RaX1
         2OgstEULPQOUKUi62U3TEZrL0bub8ts2JxpG702AV2kYYyRoru4qKG6NkRQA4lazTROS
         j+YA==
X-Gm-Message-State: AOAM531WOvQFu6Y9nAazuLnPKIHFFsxiDE+GuG9B3tAPNbYDn2q98THQ
        0J4ch900fbMeJfVVOj3c9eZk9M3LD2OV8JKRXr1EFMM9MWU=
X-Google-Smtp-Source: ABdhPJw27csrEJmdh53yYMNgcORThxaqGSuryhRx7GMN5H6q/0tigL0P2Hh6/bWhrIL4y9v23WF1m6UZq7TASX0J9eg=
X-Received: by 2002:a2e:9dcb:: with SMTP id x11mr429099ljj.450.1599618871908;
 Tue, 08 Sep 2020 19:34:31 -0700 (PDT)
MIME-Version: 1.0
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 8 Sep 2020 19:34:20 -0700
Message-ID: <CAADnVQK_AiX+S_L_A4CQWT11XyveppBbQSQgH_qWGyzu_E8Yeg@mail.gmail.com>
Subject: slow sync rcu_tasks_trace
To:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Paul,

Looks like sync rcu_tasks_trace got slower or we simply didn't notice
it earlier.

In selftests/bpf try:
time ./test_progs -t trampoline_count
#101 trampoline_count:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

real    1m17.082s
user    0m0.145s
sys    0m1.369s

But with the following hack:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 7dd523a7e32d..c417b817ec5d 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -217,7 +217,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr)
         * programs finish executing.
         * Wait for these two grace periods together.
         */
-       synchronize_rcu_mult(call_rcu_tasks, call_rcu_tasks_trace);
+//     synchronize_rcu_mult(call_rcu_tasks, call_rcu_tasks_trace);

I see:
time ./test_progs -t trampoline_count
#101 trampoline_count:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

real    0m1.588s
user    0m0.131s
sys    0m1.342s

It takes an extra minute to do 40 sync rcu_tasks_trace calls.
It means that every sync takes more than a second.
That feels excessive.

Doing:
-       synchronize_rcu_mult(call_rcu_tasks, call_rcu_tasks_trace);
+       synchronize_rcu();
is also fast:
time ./test_progs -t trampoline_count
#101 trampoline_count:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

real    0m2.089s
user    0m0.139s
sys    0m1.282s

sync rcu_tasks() is fast too:
-       synchronize_rcu_mult(call_rcu_tasks, call_rcu_tasks_trace);
+       synchronize_rcu_tasks();
time ./test_progs -t trampoline_count
#101 trampoline_count:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

real    0m2.209s
user    0m0.117s
sys    0m1.344s

so it's really something going on with sync rcu_tasks_trace.
Could you please take a look?
