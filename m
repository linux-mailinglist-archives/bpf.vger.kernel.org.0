Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78AE9198564
	for <lists+bpf@lfdr.de>; Mon, 30 Mar 2020 22:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgC3Ucc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Mar 2020 16:32:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41827 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgC3Ucb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Mar 2020 16:32:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id n17so19619235lji.8;
        Mon, 30 Mar 2020 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HIsaCCDIEW9SmQsiBvg7E1N2IqSmk3N6+OhmYGlRiSo=;
        b=R/+F+pyLp04OS/1vR4VrVxJkboIyi9bN3FNQweyDfAAMRGRgdlnmtZLmYh73kKy3qF
         zCzNnHHlDGJzK3SzOndSoAM9bWhkxGKVkVb+Dygl9pOY8vloOZI/g1lM0adQaPg934/4
         k90o1zA3aBMXB7qxCqHtUpMf5Hr+Q58HPiMsALvccqlkLAWDQGuaeTtHNIpaQ7OWGoyS
         xOcP+2ZyDb3cBF6NmB9+rA9cEj/hNNXl/ZAl/WMQtkXmT3k9aBkQ5TbCnQq36nX4z76Q
         DeY9WimafkFTng+qOyo51xAydq6Q72+dCmASBl0yg70duDstyPUhzptFkFBNOKyOVCMl
         FN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HIsaCCDIEW9SmQsiBvg7E1N2IqSmk3N6+OhmYGlRiSo=;
        b=RaPfF0gUGPSjfph/pwokmqCY7SjNpWxSnqZR8K30bPE1QzF4P6mSZ7+TSVwq7c5qfQ
         npmHXyrE4v0Zb9i/+Z4Ki/XFiqtacr42496uiPn8PtWG6vdO58AEcqKY4qrrFw7AbXaJ
         8Gqvot9E8UgVFLdzpQzazpGBaybXtvk+8lfbMwUinyfkVpMlR6gzOy6rzWlmC3rVdF1T
         4tLxAkrGmscwWbC8l39MX9l2mZYaddzEHHqaq9rXOfQoax9/av4yxm8xUAO7dG9X/jWC
         dbpevx4JVlZAXLKnF7S8a8e0Sb/QVnF6miAqswkFhWV33HsqLYbv9qNOGFSJJuxRj3XN
         bFZA==
X-Gm-Message-State: AGi0PuaUocoSpzXWkAr7QvCAKLEpCC5nxwzFx1F3YOaugjDnHW2ErJVj
        lPgsWDWc5BGG/6P/Y09kpL01ETE0fRZb5Gk/4S0=
X-Google-Smtp-Source: APiQypLmrt5zNnHEcRdVznJCZ4Snr8l39IAksnSm4vOK/JzHf8Hs6mSZ0Hg6svTLRXQuVX4kN1J0nzAX/Ey/5JDTza0=
X-Received: by 2002:a2e:7805:: with SMTP id t5mr8447085ljc.144.1585600347641;
 Mon, 30 Mar 2020 13:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200330144246.338-1-kpsingh@chromium.org>
In-Reply-To: <20200330144246.338-1-kpsingh@chromium.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 30 Mar 2020 13:32:16 -0700
Message-ID: <CAADnVQLr7osE-fbvCS3Gizt1vC5x21F2iBK=n_O1v9YrKZae9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: btf: Fix arg verification in btf_ctx_access()
To:     KP Singh <kpsingh@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 30, 2020 at 7:43 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> The bounds checking for the arguments accessed in the BPF program breaks
> when the expected_attach_type is not BPF_TRACE_FEXIT, BPF_LSM_MAC or
> BPF_MODIFY_RETURN resulting in no check being done for the default case
> (the programs which do not receive the return value of the attached
> function in its arguments) when the index of the argument being accessed
> is equal to the number of arguments (nr_args).
>
> This was a result of a misplaced "else if" block  introduced by the
> Commit 6ba43b761c41 ("bpf: Attachment verification for
> BPF_MODIFY_RETURN")
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Fixes: 6ba43b761c41 ("bpf: Attachment verification for BPF_MODIFY_RETURN")
> Reported-by: Jann Horn <jannh@google.com>

Applied. Thanks
