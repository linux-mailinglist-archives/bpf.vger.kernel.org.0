Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9FDF1BA5
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2019 17:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732202AbfKFQu2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Nov 2019 11:50:28 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:45530 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732201AbfKFQu2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Nov 2019 11:50:28 -0500
Received: by mail-il1-f195.google.com with SMTP id o18so10222653ils.12
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2019 08:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=5wxp6064vtbUA3e8vt70AU0dvT4fLHGdgzA451ZJs1I=;
        b=LTnoDHJZ7evwG2h7kwFUTx3nEzkmfrrzXZ3fGtkNapUk74YVZYVGV6LrVZiFTLNg55
         wWjXww4dJnrxFHnYcHEfv2Olh5INpqp4FRHD3L6od90ITHohiI0895dm8DhdzazlmfY4
         aGuHgJXQHWaRozGneEAM5aTe2aNE+bUvmgizCUmUGI9BIg3tfI0NXvjrj9nttSIadKcQ
         FlYdQVgQHU/QVuvCpQqtH02BSuekenUpFkyRfqPxOX5Jp/q/qKsIBZ2NDb3JlJETP2/b
         E0nlZESQIdU0KKq6xme0plAYMmmKMuKcGQYQRhDWX4Id3joiIXLHJRAyoKRmgtZ/QqMT
         DsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=5wxp6064vtbUA3e8vt70AU0dvT4fLHGdgzA451ZJs1I=;
        b=QlC6I706dw6rGKSGoxSdaqQtRoPfZmrjmVXPfOQlPAk4VMSaoHdLwYaCWHv5K0YbJE
         qEQg+1PLv4G08sn1ectdMWsaX9uzswotk5qCeWcKxwREFCeA1wHxYBdfZQ12Lcpq1sqK
         eaXg8x+RmPyCtd6hLIE6vBIq4d9EsCLk1SC/+WDaDRDQ1QAZfVh/KDsbengYE7AS6QLN
         +PIe5YKVn2e0mV4cm3+WHcxTiM/Pqkg7QT1IytWXD6Bc0qhcjNurtHjzGin5EOLEc34T
         zvX2N45Umk0bSVBmvsoogeIa55uiFUCHkWoya+DKManvRjdQHs50kP/73HpdqlKDu/o2
         wOUA==
X-Gm-Message-State: APjAAAVc+dMZZ54QiFXxMnfXZzMXXIZktD+5wdsXzX37ndTagdsjScU/
        ++3o7FZlI9QLN+LHLqAU8F0=
X-Google-Smtp-Source: APXvYqwXP8eEsAgg0kHMAZjQbltPzeJzByxGGf1f8Y+4Urh/HH9McCruUDeB8y5hEQtxP9kz0aKbTQ==
X-Received: by 2002:a92:1793:: with SMTP id 19mr3693185ilx.3.1573059027992;
        Wed, 06 Nov 2019 08:50:27 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id a11sm2287213ios.27.2019.11.06.08.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 08:50:27 -0800 (PST)
Date:   Wed, 06 Nov 2019 08:50:19 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Message-ID: <5dc2f9cbb002d_23152aba75b6a5bcfd@john-XPS-13-9370.notmuch>
In-Reply-To: <10A60D54-07EB-4B5D-AD3B-59C6D8D7CF9D@linux.ibm.com>
References: <20191106161204.87261-1-iii@linux.ibm.com>
 <CAADnVQ+jOo61VoOp+CDAW7k+GnacgEB8Kge-4JsDBaF25sVhWA@mail.gmail.com>
 <10A60D54-07EB-4B5D-AD3B-59C6D8D7CF9D@linux.ibm.com>
Subject: Re: [RFC PATCH bpf-next] bpf: allow JIT debugging if
 CONFIG_BPF_JIT_ALWAYS_ON is set
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ilya Leoshkevich wrote:
> > Am 06.11.2019 um 17:15 schrieb Alexei Starovoitov <alexei.starovoitov@gmail.com>:
> > 
> > On Wed, Nov 6, 2019 at 8:12 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >> 
> >> Currently it's not possible to set bpf_jit_enable = 2 when
> >> CONFIG_BPF_JIT_ALWAYS_ON is set, which makes debugging certain problems
> >> harder.
> > 
> > This is obsolete way of debugging.
> > Please use bpftool dump jited instead.
> 
> Is there a way to integrate bpftool nicely with e.g. test_verifier?
> With bpf_jit_enable = 2, I can see JITed code for each test right away,
> without pausing it (via gdb or rebuilding with added sleep()) and
> running bpftool.

On the library side we can set the log_level causing the verifier logic
steps to be printed. I guess adding it to bpftool might be nice. At least
I would find it useful. I'll probably get to it sometime if its not
already there somewhere and/or someone doesn't beat me to it.
