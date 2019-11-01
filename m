Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C98A8EC734
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2019 18:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfKAREN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Nov 2019 13:04:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41021 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729187AbfKAREN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Nov 2019 13:04:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id m9so10905200ljh.8
        for <bpf@vger.kernel.org>; Fri, 01 Nov 2019 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Fam+z25B/04SOccZYxR2B2sfzA41JoO78DCFCd98Ab8=;
        b=Fa6HF3bjVm/9MrAjB4qmpT/aJFsDBLWse5nZNiD4VcBF0O7zSNqEV5cFQVYScBw2s/
         XtKvVbWZue5jCxr4aWQ2E2Ci+fDZLFAORnwOdj0ZpbcK6PNA55YAz3PjWpL4STHvAQbZ
         NzXyJ8r0NRNQApd5uVnAqHz3pPOqaay2x0SoKCaMNfzONkoVayhVEbQuXkUDvaTQ5gzE
         eeeQZZh8XFEJhNR6F6SKvmXTPglBRq6KRe+a/IiWElip60Hhie+jVsY+ipsKn+LTYkCm
         G60IGPValqPm5jCzPJWQbpgMEUTSUY0+KoM8uejp6eXYTw7uVEScxqQbjGt7L/QV6irD
         eeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Fam+z25B/04SOccZYxR2B2sfzA41JoO78DCFCd98Ab8=;
        b=sSB/wdBLjxcFGdUcgGsQoL1Tdq+dig4DX9aaT5KlZw+NGX8HiuSwexvAcEcyamn+k2
         GYHNOP+HCC6H8UZzUXOPV75qLrwYEdIuoEwNZnlUTYQmxEj5SKq+2mv8VgYBddU7n+SM
         uG2kVWS0qDAFDoQPqlQ+YgYd5eDKukPY1pncPOocohjfbUWqndFNUJ/4DRd+1tMWKIfI
         2KIl/R0CY14ojfRMChu6rK+wDgQeZPHX00oNn0RF2wT8RzRYDxcHQ5pTE2U59GJgi+pN
         5Bb11kkBwpFlCy0uEzUIv6+N+kTaQEodU/d0MRSFcr0A8bdKTQ/hx70E9ub9RJdGiggO
         bEGg==
X-Gm-Message-State: APjAAAWDGg9lxYZ7E0ix0zp8syhhiwqjRP8IGI/8zUBpfhITTWNSqsta
        4fbl2OgAn8Fevi4JMOQ4nx6atQ==
X-Google-Smtp-Source: APXvYqzqNoveNQ1Ty4Z9wrD7FdRt2Yd4zvIAMlS1Vip9p7XiC5QRF/ERu01kzPaa0vzrinUlfKs2ng==
X-Received: by 2002:a2e:998a:: with SMTP id w10mr8744964lji.152.1572627851131;
        Fri, 01 Nov 2019 10:04:11 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y20sm5754321ljd.99.2019.11.01.10.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 10:04:10 -0700 (PDT)
Date:   Fri, 1 Nov 2019 10:03:59 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     davem@davemloft.net, alexei.starovoitov@gmail.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH net 0/3] fix BPF offload related bugs
Message-ID: <20191101100359.712d663a@cakuba.netronome.com>
In-Reply-To: <fe57af03-c42d-0f87-b712-30c5048764ad@iogearbox.net>
References: <20191101030700.13080-1-jakub.kicinski@netronome.com>
        <fe57af03-c42d-0f87-b712-30c5048764ad@iogearbox.net>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 1 Nov 2019 13:10:13 +0100, Daniel Borkmann wrote:
> On 11/1/19 4:06 AM, Jakub Kicinski wrote:
> > Hi!
> > 
> > test_offload.py catches some recently added bugs.
> > 
> > First of a bug in test_offload.py itself after recent changes
> > to netdevsim is fixed.
> > 
> > Second patch fixes a bug in cls_bpf, and last one addresses
> > a problem with the recently added XDP installation optimization.
> > 
> > Jakub Kicinski (3):
> >    selftests: bpf: Skip write only files in debugfs
> >    net: cls_bpf: fix NULL deref on offload filter removal
> >    net: fix installing orphaned programs
> > 
> >   net/core/dev.c                              | 3 ++-
> >   net/sched/cls_bpf.c                         | 8 ++++++--
> >   tools/testing/selftests/bpf/test_offload.py | 5 +++++
> >   3 files changed, 13 insertions(+), 3 deletions(-)  
> 
> Should this go via -bpf or -net? Either way is fine, but asking
> given it's BPF related fixes; planning to do a PR in the evening,
> set looks good to me in any case.

FWIW I'm fine either way, too. I made it net after Alexei wondered if 
we should apply the revert to net-next, but since you took the revert 
to bpf-next perhaps bpf makes sense.

To state the obvious the only thing that matters is for the revert to
be in net-next when these are merged into net-next (IOW bpf-next PR is
what matters most at this point ;)).
