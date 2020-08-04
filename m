Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DB323BEF9
	for <lists+bpf@lfdr.de>; Tue,  4 Aug 2020 19:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgHDRlM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Aug 2020 13:41:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56646 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729060AbgHDRlL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Aug 2020 13:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596562870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=RNF5BNepGIjOfg6AYwliyoS3ksA4DkzRVr4mTbb0ORg=;
        b=AiekIkwlHAfrRdNAD8YWUxCQgG35ogMPnZTV14AmYkRYWU4a9KPb6tj9LECxKUqrly9L0u
        E1Uj7eiDxAkMgvQdCU/1c6SEwSx6IDuhu6+9VUdkJw4OsdVcGOZ9L5ngCvL9hGCsQPGQZh
        aTnGtw+m90lX5bu8esCLIzeJ2KBLeEQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-ZRn6sFEnM42clGVvmVqfPg-1; Tue, 04 Aug 2020 13:41:08 -0400
X-MC-Unique: ZRn6sFEnM42clGVvmVqfPg-1
Received: by mail-wm1-f72.google.com with SMTP id u14so1103599wml.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2020 10:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RNF5BNepGIjOfg6AYwliyoS3ksA4DkzRVr4mTbb0ORg=;
        b=cVvV56tQk2cUEWaB9oOkA3xUfnL59xC/CHCXYz//Z9zr2ZYTGMydEzp8H1HzGDBPx7
         bnAyIgXnPKEf42Pu3VVXcS3HJAtSnue4vo5TbNedjyizOpPAyHi3FTtO+uhbdoBe1Q1A
         Bj95bsNaTzdjJQRmx651bVNU0Nf31SuGOtYz3xHx2zWINIuOzZE4xBGqSR0EC6K6vAn8
         FpCONBm8B/UhkoYCyLZFGrmfFmlgG0eh8x4ybdR5c2T9tRNec/Nick84hhYJPBlniDV1
         7WP/CaktDTHNt6bsZee3QBATQlVe+L6k2IVoQocS0YHPi5AK5I09RqjmaWEFNt/6hDqe
         /j4g==
X-Gm-Message-State: AOAM532v4BBeDsqnPLtuhaJ5Xm0tHVkdEaz6MUUiOUOK6NCjaHmcLbGJ
        6mtpdMGE4oAwKhcdr6cdcK8Wf2cVwxTFfah5NI37IQAvoxsUwmgGb/j3nMpF7mTrnTWhfB+gqbS
        x/y1efu3P1xmsT7Lr3XLCsGYwPOxh
X-Received: by 2002:a5d:6348:: with SMTP id b8mr20179071wrw.362.1596562867091;
        Tue, 04 Aug 2020 10:41:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPy5kvChuBM7T5IcA4vQBB4vTGCGgAeSGsWGnhZCbS5OTqswzkQMEiKa/VfzYfIqBh6tpM08mtkt533qAnvr4=
X-Received: by 2002:a5d:6348:: with SMTP id b8mr20179058wrw.362.1596562866861;
 Tue, 04 Aug 2020 10:41:06 -0700 (PDT)
MIME-Version: 1.0
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
Date:   Tue, 4 Aug 2020 20:40:51 +0300
Message-ID: <CANoWsw=4H1bHNmDP1GDo+wROCyZiZwFr-LPwoeZcWss2tJ-MNQ@mail.gmail.com>
Subject: s390 test_bpf: #284 BPF_MAXINSNS: Maximum possible literals failure
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

I have a failure (crash) of selftests/bpf/test_kmod.sh on s390.

The problem comes with loading with

sysctl -w net.core.bpf_jit_harden=2

In that case the program (lib/test_bpf.c):

static int bpf_fill_maxinsns1(struct bpf_test *self)
{
    unsigned int len = BPF_MAXINSNS;
    struct sock_filter *insn;
    __u32 k = ~0;
    int i;

    insn = kmalloc_array(len, sizeof(*insn), GFP_KERNEL);
    if (!insn)
        return -ENOMEM;

    for (i = 0; i < len; i++, k--)
        insn[i] = __BPF_STMT(BPF_RET | BPF_K, k);

    self->u.ptr.insns = insn;
    self->u.ptr.len = len;

    return 0;
}

after blinding and jiting is 98362 bytes for me and it does not fit
16bit offset for BRC 15,.. command where BPF_EXIT | BPF_JMP is
translated.

What is the easiest way to use BRCL for large offset here?

Thanks!

-- 
WBR, Yauheni

