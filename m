Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD0A1160246
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2020 07:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgBPGtv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Feb 2020 01:49:51 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:42563 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgBPGtu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 16 Feb 2020 01:49:50 -0500
Received: by mail-pg1-f180.google.com with SMTP id w21so7347549pgl.9
        for <bpf@vger.kernel.org>; Sat, 15 Feb 2020 22:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=PeuWRGGRFbWAxxPhZLV3xbXSShIswdqCCl2EzM6girE=;
        b=n9CI3YNI7ZE2XYAO+/9KkKE70E74XdS9LlCRVAY99qwckE0kj4L1O4qZTzPuXm2tWt
         Egu8UtzhoYuumFHEjDruTWoKnMG9kVCqgB0iOyjrXXUcVKDHCeSVYLB7Lvd9R6hVFW7v
         d0PIMDChsgTLrFbUWsHLZFkLRM431jqVpdpJaQPR8QmAhbVBeBQmUtQbZFpLQhTVFaBn
         yWE/ednjxaV6/i1hI9vKhV+jTfVf9dSs/It8keQJ3Hcuk9e6fAstRQfJyCaRdj4i44kZ
         n/pP7BIo6Q5O8Fdh6Wpv0TZLv4ROIvTJOh+FwhTVOU+aZGe8ErKltGay5FM3pBpteqL+
         JzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=PeuWRGGRFbWAxxPhZLV3xbXSShIswdqCCl2EzM6girE=;
        b=f7BeJ76hAun/WcFUMZR5azG8fFJ63Ti0IkVfisxfYeROuFzFqJ0U4aN+wRtlJ3lhZd
         AsV+55t7DgNQSXDDKvjVrO8ZYyrV6WbqKR5igimk6y1i1w6cTD02Ymip0tuu22PtjfuW
         SKE6YmYacdjnR1ixKJxvMgJMFUoInn18cyczL4SIyCVJTgJaEueB/ZkZPZrj5aeq4DTI
         Z5uF73qahD5GyQf85HAtx7axn0TLnzlZDxox6Z8eUOBEBnJbeLUW9q7mKEg8ifUtU5Jg
         shkwdM4XU4LDRp2/3kXy9cVGOfotR34uSI5xAXQVPAM5d4ptHWeOA28ZPRxA257KbH/L
         xyZA==
X-Gm-Message-State: APjAAAVciZaCNbOjFfbwInQNKn/s30AHp3scsDP0AOSbfYnaflsSurOg
        P4Au1JflzNi7K+YjNwAZi28w+z5r
X-Google-Smtp-Source: APXvYqzRSXwzgohWaRwW5X6fZ45H5j5q1Yw4GQe2kDNOizRz2G6lVap507EG/vaLGo6ddWjN7iItSw==
X-Received: by 2002:a63:8941:: with SMTP id v62mr11889788pgd.326.1581835788727;
        Sat, 15 Feb 2020 22:49:48 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id 84sm13093400pgg.90.2020.02.15.22.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 22:49:48 -0800 (PST)
Date:   Sat, 15 Feb 2020 22:49:40 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     bpf@vger.kernel.org
Cc:     john.fastabend@gmail.com, lsf-pc@lists.linux-foundation.org
Message-ID: <5e48e6042f786_65152b04e06625b4af@john-XPS-13-9370.notmuch>
Subject: [LSF/MM/BPF TOPIC] BPF: Verifier limits, malloc and encryption
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I would be interested to participate in the BPF track. The following topics
would be especially interesting to cover,

- Having spent the last several months writing increasingly complex BPF
code we have managed to stumble into a handful of instances where the
verifier, compiler and user appear to be fighting each other to generate
code that is both enjoyable C to the user, able to be compiled and
optimized by LLVM without throwing errors and warnings, and finally is
verifiable from the kernel side. At times the only workaround we have
found so far is to create hand written asm blocks of code. Fortunately,
LLVM supports asm goto now!

Some of the work to improve this is already in flight and should be in
BPF trees by the workshop but some items we suspect will still be open
by April. I think it would be an interesting session to collect a set
of use cases (C code samples) that can not be compiled and loaded
to understand where the pain points in LLVM and kernel verifier are today
so we can improve them going forward. Of course, we could compile a list
of just our examples but ideally (assuming others find the topic
interesting) we could try to collect a bigger set of examples from the
community.

- A related item is lack of alloc/realloc in BPF keeps causing rather
odd hacks in our use cases. For example, one common item that continues
to pop up is we over allocate map entries to account for worst case
scenarios. Even when smaller entries would work the majority of the time.
Or when doing probe_read_str() parsing we have no way to realloc buffers
if the string is longer than expected. Here we would like to propose
a scheme for supporting malloc/realloc/free APIs from BPF programs.

- Finally, changing topics a bit Cilium has implemented an encryption
layer using the stacks IPsec layer. However, this results in passing
packets into the stack and out of the stack complicating both the datapath
and control plane. Additionally, wireguard has recently been added. A
native solution for encryption in BPF for both IPsec and wireguard would
greatly simplify integrating encryption with BPF including at the XDP
layer.

Also it looks like a session on sockmap and related socket based BPF
hooks would be useful based on other proposals. I would like to attend
to provide input here as well.

Thanks,
John
