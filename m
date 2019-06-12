Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD56B42A3C
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2019 17:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439911AbfFLPFE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jun 2019 11:05:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36398 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437202AbfFLPFE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jun 2019 11:05:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so17343909wrs.3
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2019 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=/8xGsHTP+iy8Gt814Xxy96+5BPKtVpOqeBb/34Fcdsc=;
        b=g1wuq8ZC3FrlxZnzk/tg2ghabRbnhlqq1svD63JFaD8bNT6kXTBtJkliGf76EJBEoG
         HQjwS8sX/ZZL/lIzjOlBLpTbLxmEvEdKGDxyOhaJI41Necw2mglhxCckY8RL0vsf1RAH
         D+mkhZf8/oboa/9BTrxltIkV8DB3MZkFr+HkY+Yp/qRL/YONUD2rn1ADkpoqqCmfebJI
         pfQDZDA9r9mZtRtRx3OhJvAY6R3rwZ3/HV6NbKKI7X7kIOy5XRUtuvTUec+91B6/q7hD
         b/9xC8jWOp6OLvkNYCsVVbmZiwsBu1XQ1mLsEPTiUArNxgN7REnPfY8zS6ny2DeYkHo0
         IJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=/8xGsHTP+iy8Gt814Xxy96+5BPKtVpOqeBb/34Fcdsc=;
        b=ebN9zFjDfRW+NpYj4sXYnlrY3SJFI0o8CqCuq2O2eAGFGcSc0cT9pOrkhBz4a7EMxY
         C4k59z7V/jCyKZTV2iTMWPtxfxoO9ivJcm4wM/geQJ7O3ZvcBrPlfw+WZUNnqJFsFK7n
         VKTKmY8DWNfG6TPa9ZZj4fJrB6UrW79mMM9RofR90IJHYcRefuLMfyhJvsdMNCJUL5W+
         PeHWZT6dU/Zji6qjgYpN6J5KxcCShLNusKkrXlXYy2gnnZNNKdgMXigxFGXm60Xlip4L
         4ubNpHNlPRe2NhWQJhjzQM7sL0Rc8NG8rA3E+E2WddH5/mO38vJjOpT5609OQ7bfXusT
         /R2w==
X-Gm-Message-State: APjAAAUI3r3R6obn1W+FS9/cX7kXfN5iWtR8R1Lg3HHGYRZX4sLOTxlr
        dW5/QSs2GHon2nZclHh9msi1AQ==
X-Google-Smtp-Source: APXvYqwynzIh/Ayl7mDoHmJk3NzZTAW6WJr9XTtGtd1QClAaZnhA09cDDPHnPROIn7I/bJWYQqy8WA==
X-Received: by 2002:adf:fc85:: with SMTP id g5mr55231190wrr.324.1560351899790;
        Wed, 12 Jun 2019 08:04:59 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 11sm307964wmd.23.2019.06.12.08.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 08:04:58 -0700 (PDT)
References: <20190612113208.21865-1-naveen.n.rao@linux.vnet.ibm.com> <CAADnVQLp+N8pYTgmgEGfoubqKrWrnuTBJ9z2qc1rB6+04WfgHA@mail.gmail.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jiong Wang <jiong.wang@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH] bpf: optimize constant blinding
In-reply-to: <CAADnVQLp+N8pYTgmgEGfoubqKrWrnuTBJ9z2qc1rB6+04WfgHA@mail.gmail.com>
Date:   Wed, 12 Jun 2019 16:04:56 +0100
Message-ID: <87sgse26av.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Alexei Starovoitov writes:

> On Wed, Jun 12, 2019 at 4:32 AM Naveen N. Rao
> <naveen.n.rao@linux.vnet.ibm.com> wrote:
>>
>> Currently, for constant blinding, we re-allocate the bpf program to
>> account for its new size and adjust all branches to accommodate the
>> same, for each BPF instruction that needs constant blinding. This is
>> inefficient and can lead to soft lockup with sufficiently large
>> programs, such as the new verifier scalability test (ld_dw: xor
>> semi-random 64 bit imms, test 5 -- with net.core.bpf_jit_harden=2)
>
> Slowdown you see is due to patch_insn right?
> In such case I prefer to fix the scaling issue of patch_insn instead.
> This specific fix for blinding only is not addressing the core of the problem.
> Jiong,
> how is the progress on fixing patch_insn?

I actually was about to reply this email as we have discussed exactly the
same issue on jit blinding here:

  https://www.spinics.net/lists/bpf/msg01836.html

And sorry for the slow progress on fixing patch_insn, please give me one
more week, I will try to send out a RFC for it.

Regards,
Jiong
