Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DE71DA9C1
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 07:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgETFRI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 01:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgETFRI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 01:17:08 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FB3C061A0E;
        Tue, 19 May 2020 22:17:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w19so840305ply.11;
        Tue, 19 May 2020 22:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pyGMViVhRvxgrfo83H9S9ypsc1mRFHSVYjp6b2UYLkk=;
        b=NdTz297LhVAj/7turAodidhUkCK8g5GL6dWLH5PP2JT3DI+Uk80NPrfC7XFP/Cxo/X
         5CG+731lj9SfV943mHzfiOrX5ZcsBmPaS98ZKPgMlc276sTBp0jsa8AlhPViVdVdA3Gc
         HvydWzGsQOrnRp6qbJQr7QivNMLV09sjfDL2eKrJbxhgy3Q7o+DRQUrGadCnIAZQZYjX
         FEipMg7dej1UmPVt1uuJhPjK2lH4bF+e8VzAInKKbMYo03sKSnUPghr3r95lK26A5hBP
         aZ4AVjWZLyCenGdUeQHqi1+P4O0qe5xEEqhleVQpyZYjtlB3rcH/KHVVgpl4nYORPyVc
         YBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pyGMViVhRvxgrfo83H9S9ypsc1mRFHSVYjp6b2UYLkk=;
        b=SDBMMJvaPz8KCN5VaIwGvyw0/UxI689ND620ZPJbBeaj+0Y5JPSHfaCKnTKoK+6Ii4
         iPFXSUBN3U99HYSCzj1hSc+XakN8fYMs2V50OJbvsXUzC/k8Kza+ZOeoq5794p4WBr9z
         pGr06jDJCwgdgauoZgoCRsYVt+4PwIml4J0didkypfP3+avSp1egBjNSrOATc6K3NW78
         0QeorJc5QMEStHSXy37r8o63eR9RRTdB/+w5omz4qxd2iLkUzLQ56qW5usI/y6TFM4Si
         EJ+hgc6jNJ10FUqtXdLZUrjpSnATisH00e06bAkeXeEp5g7DuSqb8mq8YIe+rpf5TI7I
         noFQ==
X-Gm-Message-State: AOAM5335ikyZxKQuMKLlQ+r/Prtrqg+uwr1EciXiORz7lV7v5C/TDmV9
        ZKu5pMelgDaT8mWfMXKTYFH1NidI
X-Google-Smtp-Source: ABdhPJwMPD/i+8pL/ltjp3VjNsrxS/1xXstzFrYfpjEcx73dCM9WeTKxH88MOZ4J7v+7g/qExSLrxQ==
X-Received: by 2002:a17:90b:30cf:: with SMTP id hi15mr3384890pjb.209.1589951827618;
        Tue, 19 May 2020 22:17:07 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8135])
        by smtp.gmail.com with ESMTPSA id d184sm931965pfc.130.2020.05.19.22.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 22:17:06 -0700 (PDT)
Date:   Tue, 19 May 2020 22:17:03 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Aleksa Sarai <asarai@suse.de>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Chris Palmer <palmer@google.com>, Jann Horn <jannh@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: seccomp feature development
Message-ID: <20200520051703.wh7s2bnpnrqxpk5j@ast-mbp.dhcp.thefacebook.com>
References: <202005181120.971232B7B@keescook>
 <CAG48ez1LrQvR2RHD5-ZCEihL4YT1tVgoAJfGYo+M3QukumX=OQ@mail.gmail.com>
 <20200519024846.b6dr5cjojnuetuyb@yavin.dot.cyphar.com>
 <CAADnVQKRCCHRQrNy=V7ue38skb8nKCczScpph2WFv7U_jsS3KQ@mail.gmail.com>
 <20200520012045.5yqejh6kic3gbkyw@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520012045.5yqejh6kic3gbkyw@yavin.dot.cyphar.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 20, 2020 at 11:20:45AM +1000, Aleksa Sarai wrote:
> 
> No it won't become copy_from_user(), nor will there be a TOCTOU race.
> 
> The idea is that seccomp will proactively copy the struct (and
> recursively any of the struct pointers inside) before the syscall runs
> -- as this is done by seccomp it doesn't require any copy_from_user()
> primitives in cBPF. We then run the cBPF filter on the copied struct,
> just like how cBPF programs currently operate on seccomp_data (how this
> would be exposed to the cBPF program as part of the seccomp ABI is the
> topic of discussion here).
> 
> Then, when the actual syscall code runs, the struct will have already
> been copied and the syscall won't copy it again.

Let's take bpf syscall as an example.
Are you suggesting that all of syscall logic of conditionally parsing
the arguments will be copy-pasted into seccomp-syscall infra, then
it will do copy_from_user() all the data and replace all aligned_u64
in "union bpf_attr" with kernel copied pointers instead of user pointers
and make all of bpf syscall's copy_from_user() actions to be conditional ?
If seccomp is on, use kernel pointers... if seccomp is off, do copy_from_user ?
And the same idea will be replicated for all syscalls?
