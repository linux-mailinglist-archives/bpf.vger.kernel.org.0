Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A51B404537
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 07:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348026AbhIIFyB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 01:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350648AbhIIFyA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 01:54:00 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE6FC061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 22:52:51 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id c6so1597717ybm.10
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 22:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mwxEGvX1mnM1IRK7Tkdz6ojwSCRKc+SuNK70QdfD5qQ=;
        b=TRjyOCw8MbyD3MBRpqEWvq7V5HrV0P/wlA9NGJ3pEozeiRNobiL25bXiF85nispPbv
         qBGhgMxKE4yvCXhie2qF2oFNRCkTbL1LTfnt/saWyk99o+hkfMagK4DlcoYam6n+aauf
         zQSXTjuLBYLgg/1DS8Kl9hwgBTO3iWsS0R3BXLZIIeKNS6k14gRFvmRvWmubyK85zh8k
         UWhjhGDBkCu0JFtOcw7QXHGBsiCcTzAEp5EfE1+gIV/0BYVD7fnX0H67B7gBDAUnvD9M
         yEUgWwY6yvk97XareHfo38Ozw/E4etjQUApfv+2eSgOtpR9GszkUfSFoZxs1/34kKKvT
         Votg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mwxEGvX1mnM1IRK7Tkdz6ojwSCRKc+SuNK70QdfD5qQ=;
        b=0DCg8nr2Ml4EWgOV9WPYSjiQHxaNEvOQXIsSNkxUXRhaeJ6DKU1c5sCuwZpyoxaRMM
         Oa7nFYBzwNV7dDamdpdID9IJvle7UVsuqRry/jstO4yU/PW2ReiXlX4f8Cu3cwhaJ7po
         rAYIJN2o5pIKBeBktXalWBRZJL4bnjsmPXbPkXFa5tU/jePi3pdl4qN53SeRJWArt38a
         p/X9Lh/3b/G6GOYRu5tHl6WBq7hyvnKTadAI7aO2lt9Cvc1QYJXU4rT3oTz7UPf2AZ0i
         HQhLyCU8G/86KlYp2vFyw6nvhVlPU/wJ5/9HZSClOyc2TSW0race1n/ZmDzEDkH5rZBL
         cnxg==
X-Gm-Message-State: AOAM530SDqABrhAi3hcf/L8npVFLDQeB4WtCZee4xlN4F/nTFikDKCmH
        ofyJwRORyuQEkNlMKMY3ETFlZNWYLXRJkjh0mCY=
X-Google-Smtp-Source: ABdhPJxIkbGKQXRKhrIniKlhn6NYhVs7JFM/oYuzTwnooN/J3PH4IsE7bPFp3okHo3fn08kYRCE4DP7z6ViEni8KibE=
X-Received: by 2002:a25:8c4:: with SMTP id 187mr1604449ybi.369.1631166770857;
 Wed, 08 Sep 2021 22:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210909001421.4002107-1-jmeng@fb.com>
In-Reply-To: <20210909001421.4002107-1-jmeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 22:52:39 -0700
Message-ID: <CAEf4BzZpBVOdFPEv4M2KfOLB+h8Q9BDrFXm+Es8+mj5EOYF9WQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf,x64 Emit IMUL instead of MUL for x86-64
To:     Jie Meng <jmeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 8, 2021 at 5:14 PM Jie Meng <jmeng@fb.com> wrote:
>
> IMUL allows for multiple operands and saving and storing rax/rdx is no
> longer needed. Signedness of the operands doesn't matter here because
> the we only keep the lower 32/64 bit of the product for 32/64 bit
> multiplications.
>
> Signed-off-by: Jie Meng <jmeng@fb.com>
> ---

This change breaks selftests ([0]), please fix.

  [0] https://github.com/kernel-patches/bpf/pull/1746/checks?check_run_id=3550847581

>  arch/x86/net/bpf_jit_comp.c                | 53 ++++++++++------------
>  tools/testing/selftests/bpf/verifier/jit.c | 16 +++++++
>  2 files changed, 39 insertions(+), 30 deletions(-)
>

[...]
