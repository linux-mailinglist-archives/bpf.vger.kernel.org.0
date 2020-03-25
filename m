Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F40F81933B3
	for <lists+bpf@lfdr.de>; Wed, 25 Mar 2020 23:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCYWXv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 18:23:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35220 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgCYWXv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 18:23:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id d5so5553126wrn.2
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 15:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NozTfbnUXxzy4cXswDJLwemMpoiRvgmEY3+WPMbNZvE=;
        b=de0sfS5UffvfSvmHaQWyKnySVedLtZjG729ppvdNOD8kP0X9SGgN2CRF83mCkHzZM1
         M6CQcZbYUvhFlv8JpFAjLGHO4u/ID1zTVmRP9ifHkxRZlmOvYcWwROpUcl9vqaxkSXt+
         1XFA54LMpDrOcoSuPKWEqu7szMIC1XyF+4JoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NozTfbnUXxzy4cXswDJLwemMpoiRvgmEY3+WPMbNZvE=;
        b=HfGY6hWj0q4u3jVJUWseHO6JJOZQt3YTYq4BWeDutreIT5bd9MQzU+zRGm+0ppujww
         eHqOrB/FKkpcInC1/TjxP1KTbWZJEMwCvV5CjauQq4nlhbVO1PXxH3Hw5aVv6ffQwtmT
         pPx20PMaDtmOg5kYEJZAcWZ2Q6RzcNdqFxoFBnWc8oCa4qttKX8eVMB6wgNLvw4HDOe5
         mRhGEIr76CTiSaQp2R1N+2aApzfQN168KuJd49iGQ9SIzpa1TmW4cLHazkxeCRS0P5hg
         htm//IKgrDuGpVmS/qCYhj3XRocQKu8hgXYXkkoJs0kPXBWO82Ubu+vOcqHfegi8Rz6h
         cEjw==
X-Gm-Message-State: ANhLgQ01PqHBFRsd9AP36E9aGV3zUMQerrUu7/auXjBHQ2XbRBmAblD1
        BgnBuCaacOyM6/6heidNYLGLBQ==
X-Google-Smtp-Source: ADFU+vtGs+j0ZciToPrnJGhvOUtDeWqnPa6GcgdPPZXHgd9aig6BVzv8/8DgGCDnSG9QGupdCeHSyQ==
X-Received: by 2002:a5d:628f:: with SMTP id k15mr5695982wru.404.1585175027780;
        Wed, 25 Mar 2020 15:23:47 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id p3sm485209wrj.91.2020.03.25.15.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:23:47 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 25 Mar 2020 23:23:45 +0100
To:     Matt Cover <werekraken@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Subject: Re: libbpf/BTF loading issue with fentry/fexit selftests
Message-ID: <20200325222345.GA27005@chromium.org>
References: <CAGyo_hqRCs6hp7w6zWEf5RzEZF6zyXj_Bb_AgXVKgab7tg06NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGyo_hqRCs6hp7w6zWEf5RzEZF6zyXj_Bb_AgXVKgab7tg06NQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25-Mär 15:16, Matt Cover wrote:
> I'm looking to explore the bpf trampoline Alexei introduced for
> tracing progs, but am encountering a libbpf/BTF issue with loading
> the selftests. Hoping you guys might have a pointer or two.
> 
> The kernel build used pahole 1.15. All llvm-project components used
> in compiling the selftests were 10.0.0-rc6.
> 
> I believe the following confirms that BTF is indeed present in this kernel.
> 
> 
> [vagrant@localhost bpf]$ uname -r
> 5.5.9-1.btf.el7.x86_64
> [vagrant@localhost bpf]$ grep CONFIG_DEBUG_INFO_BTF /boot/config-`uname -r`

It seems like you might have CONFIG_TEST_BPF disabled.

This is explained in Documentation/filter.txt:

Testing
-------

Next to the BPF toolchain, the kernel also ships a test module that
contains various test cases for classic and internal BPF that can be
executed against the BPF interpreter and JIT compiler. It can be found
in lib/test_bpf.c and enabled via Kconfig:

  CONFIG_TEST_BPF=m

After the module has been built and installed, the test suite can be
executed via insmod or modprobe against 'test_bpf' module. Results of
the test cases including timings in nsec can be found in the kernel
log (dmesg).

- KP

> CONFIG_DEBUG_INFO_BTF=y
> [vagrant@localhost bpf]$ ~/bpftool btf dump file ~/vmlinux-`uname -r`
> | grep -i fexit
>     'BPF_TRAMP_FEXIT' val=1
>     'BPF_TRACE_FEXIT' val=25

[...]

> libbpf: collecting relocating info for: 'fexit/bpf_fentry_test6'
> libbpf: relo for shdr 16, symb 32, value 40, type 1, bind 1, name 34
> ('test6_result'), insn 18
> libbpf: found data map 0 (fexit_te.bss, sec 16, off 0) for insn 18
> libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
> libbpf: fexit/bpf_fentry_test1 is not found in vmlinux BTF
> test_fexit_test:FAIL:prog_load fail err -2 errno 22
> #10 fexit_test:FAIL
> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
> 
> 
> Any hints on the issue?
> 
> -Matt C.
