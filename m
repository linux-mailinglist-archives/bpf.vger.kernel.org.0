Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDEF226FCE
	for <lists+bpf@lfdr.de>; Mon, 20 Jul 2020 22:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgGTUlz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 16:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgGTUlz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 16:41:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709E0C061794
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 13:41:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k71so465823pje.0
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 13:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wbGgRncSj6HHhJYW2c/QEhsKIi1BLv9QdKZvSMHudu0=;
        b=HgwjzrmA+mOwwU5EJh3eQMkYHWXGkinUFNfVbWiML7a8B69pPZGaNtLVIZLQQo+9WM
         ZFmahe0/5uxjEWxTr0A3qd8/su07tD9nRjBug4u2MZORO18oAcyhqXfLgIul3NiK+HB7
         8tVvxR3mhimFYoPNzQrFU1Ssg3lGEnqCRLSI3Z+/Gw0ds3uONDPQ2PbdeH6wVLtCPgFd
         qOp1qiGpEMbsICYH86Tko4x6IAb5QJTqkbZVkxuqzBy+Z5eZ+pFn1LOUO0KPqsRSEMKn
         Ss71dDEWrwe6b6biZo/H1dXOljiFm4PnO175Zi6Af9LIs/cHjdZTksPD3lNw7jtjTtso
         ra0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wbGgRncSj6HHhJYW2c/QEhsKIi1BLv9QdKZvSMHudu0=;
        b=ia6OLZI6UAppIcS4F1Ui6qdElWoGk1fWcz4beUvpE9epsY9k39eKchCMM212xfjn46
         GsFUnYXcdk/Eo5DsOVQDv00R45XCc97G1NmwZpJZ7Pllcar5BQiYz6o3DIDQMUrd7Ygf
         Bg4STnhj6570waZv30t0g2PaOAz1gkxYV6Jk5e/pLv+YiRhwtoOJ8qBs09zKBh5I141j
         DN/MJnBtYnpDEkEUt+O4z3Mj6pOqEkTLtDMnSYkSRnNbB7wtb5MsbYJd0l7uBtzQdIZI
         QupJ9sMblp8vnGvguXSQeDScpeP40dknwlOU/Gigac5HEM66dDX8wfBQd3W9pjUrDpHH
         XvmA==
X-Gm-Message-State: AOAM532HY4aJPQfmQD2+osfsisBW2l/MYKZ8HtZKAZ8y8+qeqNkwV3DU
        3S23RstyidTnj8HjqdRb91Y=
X-Google-Smtp-Source: ABdhPJyELo2RwNCaSN5m8WxH30lOK1FPcTKFveTzTgPil+nzzBMQqoGNiMguZ5OhaGFaQvMqgAJSaw==
X-Received: by 2002:a17:90a:987:: with SMTP id 7mr1084469pjo.186.1595277714977;
        Mon, 20 Jul 2020 13:41:54 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:e3b])
        by smtp.gmail.com with ESMTPSA id u188sm18074945pfu.26.2020.07.20.13.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 13:41:54 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:41:52 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: BPF selftests build failures
Message-ID: <20200720204152.w7h3zmwtbjsuwgie@ast-mbp.dhcp.thefacebook.com>
References: <20200720080943.GA12596@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720080943.GA12596@lst.de>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 20, 2020 at 10:09:43AM +0200, Christoph Hellwig wrote:
> Hi BPF and selftest maintainers.  I get a very strange failure
> when trying to build the bpf selftests on current net-next master:
> 
> hch@brick:~/work/linux/tools/testing/selftests/bpf$ make
>   GEN      vmlinux.h
> Error: failed to load BTF from /home/hch/work/linux/vmlinux: No such file or directory

That's bpftool complaining that BTF is not present in vmlinux.
You need CONFIG_DEBUG_INFO_BTF=y and pahole >= v1.16
You also need llvm 10 to build bpf progs.
