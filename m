Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A095276CF9
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 11:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgIXJYe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 05:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgIXJYe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 05:24:34 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEEDC0613CE
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 02:24:34 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m5so3104823lfp.7
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 02:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=im1OfLn7Sfa8GgxD2YYn3rLPbkWjcQSTQ+yM7JfpOZI=;
        b=Wdd5ClNXe2xZ1ulHov8AB7dY2dTEyc6Kuds6kZouUPJSecPKOZxOmXIgrhGADWqV/H
         IydYvHYdl4/EutI/XztZpbt2hhqXkgOgHT68F209hfYcK481X++dcTyMARj37n9uhsFg
         ORaTgBxMSXnKlcgYx20a/ZP3NTh3yFQUNMK4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=im1OfLn7Sfa8GgxD2YYn3rLPbkWjcQSTQ+yM7JfpOZI=;
        b=rRRyetp8WBrXSsceDfwDw6eGYIC5MAYjk8iWeXvq4xuBkl9JvFEPYAo9rKDXpS1FLj
         RjWtYRDLS2Zo5jHKB+h9MOGQEDIa1r+e/TJh3JtYIAFz4EqI8NEJk+in98bNwZ/EyYvS
         7D/D6KiEr3B1nHodu460LHlgpYp4Flx6wq57xWBnpT8pnLpCTFDX8Gn0SvDSM3r0PzFE
         ePZNHFU8qJd7iW9xJrGSIq3fcnw1S71rUmND/+tBUiOC7aSaf4+r5prsEDKX4838ncOB
         nSZXPddkH7Z+FblHmRc5mLmhcEu6ALNQGWJ5EzwBTQe5ItdSopeud5Y7bV6GOKS+cTpy
         lvew==
X-Gm-Message-State: AOAM5311+0Zv4QTSPNZJ0aKSKXM1fvQFQneUjGGuDT0FD2Pe8acppSd8
        TteRzLn7yHfUCgtNo2dwvacyUDWtT7rESg==
X-Google-Smtp-Source: ABdhPJx+Dw2cslwtk5PAx0VDo04ejis/yaqKMTfRaPdysNB/poKxbo9ZKUW6wV9SpUOpVxkrguYP2A==
X-Received: by 2002:a19:2390:: with SMTP id j138mr1370899lfj.469.1600939472480;
        Thu, 24 Sep 2020 02:24:32 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id h11sm1545582lfd.21.2020.09.24.02.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 02:24:31 -0700 (PDT)
References: <20200909232443.3099637-1-iii@linux.ibm.com> <20200909232443.3099637-3-iii@linux.ibm.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Fix endianness issues in sk_lookup/ctx_narrow_access
In-reply-to: <20200909232443.3099637-3-iii@linux.ibm.com>
Date:   Thu, 24 Sep 2020 11:24:31 +0200
Message-ID: <87h7rnttm8.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 10, 2020 at 01:24 AM CEST, Ilya Leoshkevich wrote:
> This test makes a lot of narrow load checks while assuming little
> endian architecture, and therefore fails on s390.
>
> Fix by introducing LSB and LSW macros and using them to perform narrow
> loads.
>
> Fixes: 0ab5539f8584 ("selftests/bpf: Tests for BPF_SK_LOOKUP attach point")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

Keeping some lines > 80 chars would make it a bit more readable IMO, but
otherwise LGTM. Thank you for fixing it.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

[...]
