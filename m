Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98001F5051
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2019 16:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfKHP5V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Nov 2019 10:57:21 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:37425 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfKHP5V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 10:57:21 -0500
Received: by mail-pf1-f181.google.com with SMTP id p24so4872706pfn.4
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2019 07:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=zg20/KfpDQtibg9VE6Kw3JALOb34pK+kKNB57M2ut1M=;
        b=L6blUi/5iEQmfXqMdHF9OxpqVaQx7DifIEWIxPC7fJA914cVFwMinbXgB9KBS2buB3
         8tZ8d8Xvm6xEwdV52gy6XzzJWXXIaUgYzB2qEH8IKgpZfdZqwKmM4auClOzzLh7pcD54
         loAx2xAP2bO0e6uKwW/m8psOm1h9yrh3R4j2iIG7q3EYHz/YY6i0wxdqMpKKHkRuuaXb
         Q/07q3AcFkepx0jfTfsDkjIKnfW1xiwp0IoSCfbLCZeEmmu7V59ZbyEsyb9HxNuqA7bh
         LEuU7tWgY8Yk/ibI5OP2inknSuAcdcthzrAvkEw1A31HTI/VOuyaAe1aXwdbnc5oPOe0
         Bc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=zg20/KfpDQtibg9VE6Kw3JALOb34pK+kKNB57M2ut1M=;
        b=S1tIO1fAMGLuWfCYC9qSo2tto5VlFkheXpbfe/SZybAPLPXsuhNCdjQPeoh2x0+tMf
         dEKq02aA5+eMe9l0UGdqndP1gS7Coa1gPEaF0Oxy1rnXCT6ISI2F0hByiNYa9DXFf0l+
         nLKw6v/v143dlL7av4dljkiSOL/SIiWaG6OWyDIhUSnePOw9PX+/nzn7FxuwQPrXYjMf
         SrlJ/UAh8OoICJlrIJ85P+6SXWb3WVYScVEcoiwd2lJ3ZUTRZh5XIikHX7dFj2MR7OVG
         bXCaPyh4aWp+9z7uqv2Ua7QEb8sPNtnaUDpbSnkrziqO4U/KcdqPXEzQdfGXhJv1QYF5
         MxXw==
X-Gm-Message-State: APjAAAXBJ9rfXbN/7RtvA9VtZx8h33uzZf2xHNbfiAwJzOxwITkUou4Y
        LrwwSPJ24uDh26LWBbFcmm1ZuA==
X-Google-Smtp-Source: APXvYqwN0zTm4gstCiPzgoDJ5hcz7JUChQKzMwcRb6iR/WVPFW6oRR7QtzVlFMab+IOH90kS8ibyEw==
X-Received: by 2002:a63:6f47:: with SMTP id k68mr12347217pgc.92.1573228640615;
        Fri, 08 Nov 2019 07:57:20 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id p3sm8403038pfb.163.2019.11.08.07.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 07:57:20 -0800 (PST)
Date:   Fri, 8 Nov 2019 07:57:11 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org
Subject: Fw: [Bug 205469] New: x86_32: bpf: multiple test_bpf failures using
 eBPF JIT
Message-ID: <20191108075711.115a5f94@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



Begin forwarded message:

Date: Fri, 08 Nov 2019 07:35:59 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 205469] New: x86_32: bpf: multiple test_bpf failures using eBPF JIT


https://bugzilla.kernel.org/show_bug.cgi?id=205469

            Bug ID: 205469
           Summary: x86_32: bpf: multiple test_bpf failures using eBPF JIT
           Product: Networking
           Version: 2.5
    Kernel Version: 4.19.81 LTS
          Hardware: i386
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: itugrok@yahoo.com
                CC: itugrok@yahoo.com
        Regression: No

Created attachment 285829
  --> https://bugzilla.kernel.org/attachment.cgi?id=285829&action=edit  
test_bpf failures: kernel 4.19.81/x86_32 (OpenWrt)

Summary:
========

Running the 4.19.81 LTS kernel on QEMU/x86_32, the standard test_bpf.ko
testsuite generates multiple errors with the eBPF JIT enabled:

  ...
  test_bpf: #32 JSET jited:1 40 ret 0 != 20 46 FAIL
  test_bpf: #321 LD_IND word positive offset jited:1 ret 0 != -291897430 FAIL
  test_bpf: #322 LD_IND word negative offset jited:1 ret 0 != -1437222042 FAIL
  test_bpf: #323 LD_IND word unaligned (addr & 3 == 2) jited:1 ret 0 !=
-1150890889 FAIL
  test_bpf: #326 LD_IND word positive offset, all ff jited:1 ret 0 != -1 FAIL
  ...
  test_bpf: Summary: 373 PASSED, 5 FAILED, [344/366 JIT'ed]

However, with eBPF JIT disabled (net.core.bpf_jit_enable=0) all tests pass.


Steps to Reproduce:
===================

  # sysctl net.core.bpf_jit_enable=1
  # modprobe test_bpf
  <Kernel log with failures and test summary>


Affected Systems Tested:
========================

  OpenWrt master on QEMU/pc-q35(x86_32) [LTS kernel 4.19.81]


Kernel Logs:
============

Boot log with test results is attached.

-- 
You are receiving this mail because:
You are the assignee for the bug.
