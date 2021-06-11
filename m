Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21733A4A13
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 22:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhFKUXq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 16:23:46 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:46775 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhFKUXq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Jun 2021 16:23:46 -0400
Received: by mail-pf1-f177.google.com with SMTP id x16so1150254pfa.13
        for <bpf@vger.kernel.org>; Fri, 11 Jun 2021 13:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oPjP2Cm0mq/vdwwlItKn6Wovz2WUvfzaxEDfsrLSiSs=;
        b=GpcfnRtfQEejBtAqDoh6JRPiopaeGsvB65UhtL7u1oqQ5MczhG96m4PMkc7fM/TmvQ
         o1PTCtmGPxlD+4jh06yXcJK1691N2XgHf0MYkwiblCoiwP6o5Rl90QU9rk15zSKiUE3t
         a2yEEZNVmq0d1CW2QAZixLTs6TAOraWXj8ME042ebY7hkT63PqdOLpqii+JD72cGpGGd
         RPfEu1bnC/ECzKzGO5eopR0Z20UPfdN8CwbMEx3fs4hz+k7ndF+ZHDjRHfhX0UqK1ojp
         sAh3CKhi6Nw18GIJNdP/N0At1jLPmvS1YC8IeAlUcPEuj+O4fl7NDH1FM/ExRArdmzh/
         VPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oPjP2Cm0mq/vdwwlItKn6Wovz2WUvfzaxEDfsrLSiSs=;
        b=OSvCNaV9iu9bzzom4Oia3yq/qvDpd0XGkBYGmAOSFvyO9hNJqANiLCQkDdNY6O02lh
         Q/eMYe5D0Fp8hdhsCyT6qd+zzfwZpAjZ1GHv4H+Tc1BhTFFoO6AggGUncZtrhmgeBHi7
         zPPqBaoLrnwk4wZF3+0nbZ0KuDLtW9qrZZdiXrzvHl338bjtRVpklJlPB7/uIaAoX3YI
         pJXXT7nFG1DVOjGcJaIWxXEzxZwD2yadWzD1ucEsT+Bhpor7lxaOXvzIeoBjK2DFwnY5
         V2Pmx0a1LPy1qfTPpl3ZouYP0c6R+0xj784VQBo2pIcNA2eouJ7jQJhgzUx0aZwtWO/0
         Ft5w==
X-Gm-Message-State: AOAM533lWiGZL128Dd+XjHTxzXFW/cs0PgF6zZJp/ON7m6zIbNzYeKJ4
        13/FgWkmsPVGJTFjeqXsv7TlpxtuycJmARF3javI8Yi6yTPfeA==
X-Google-Smtp-Source: ABdhPJxG19tXXFaHJ2Evx4X1DdIigGQBy5BsdsQGSv5w0pOvXqZRaNzcqPmXpjwS7ZLlP7u08gJiOQwZiPTAaXmiZbk=
X-Received: by 2002:a62:90:0:b029:2db:90a5:74dc with SMTP id
 138-20020a6200900000b02902db90a574dcmr9886085pfa.27.1623442839687; Fri, 11
 Jun 2021 13:20:39 -0700 (PDT)
MIME-Version: 1.0
From:   "Geyslan G. Bem" <geyslan@gmail.com>
Date:   Fri, 11 Jun 2021 17:18:49 -0300
Message-ID: <CAGG-pUTpppu-voYuT81LiTMAUA5oAWwnAwYQVAhyPwj3CwnZPA@mail.gmail.com>
Subject: kernel bpf test_progs - vm wrong libc version
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Trying to run vmtest.sh from the bpf-next linux
tools/testing/selftests/bpf on Arch Linux raises this error:

./test_progs
./test_progs: /usr/lib/libc.so.6: version `GLIBC_2.33' not found
(required by ./test_progs)

VM:
https://libbpf-vmtest.s3-us-west-1.amazonaws.com/x86_64/libbpf-vmtest-rootfs-2020.09.27.tar.zst

[root@(none) /]# strings /usr/lib/libc.so.6 | grep '^GLIBC_2.' | tail
GLIBC_2.30
GLIBC_2.5
GLIBC_2.9
GLIBC_2.7
GLIBC_2.6
GLIBC_2.18
GLIBC_2.11
GLIBC_2.16
GLIBC_2.13
GLIBC_2.2.6

It would be nice to have
https://github.com/libbpf/libbpf/blob/master/travis-ci/vmtest/configs/INDEX
updated to refer to a new image with GLIBC_2.33.

Host settings:

$ strings /usr/lib/libc.so.6 | grep GLIBC_2.33
GLIBC_2.33
GLIBC_2.33

$ uname -a
Linux hb 5.12.9-arch1-1 #1 SMP PREEMPT Thu, 03 Jun 2021 11:36:13 +0000
x86_64 GNU/Linux

$ gcc --version
gcc (GCC) 11.1.0

$ clang --version
clang version 13.0.0 (/home/uzu/.cache/yay/llvm-git/llvm-project
ad381e39a52604ba07e1e027e7bdec1c287d9089)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin

P.S.: This issue was started in
https://github.com/libbpf/libbpf/issues/321 and brought to here.

Thank you.

Regards,

Geyslan G. Bem
