Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE2B49419B
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 21:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244605AbiASUQn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 15:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243988AbiASUQm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 15:16:42 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B03C06161C
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 12:16:42 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v11-20020a17090a520b00b001b512482f36so838724pjh.3
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 12:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KzZoPZdDnqJkBrwR7FMFF9P029Lbhn9WcJK/YTX/ZTY=;
        b=Vwkoifm/jYI6DXQ72k67RPGg0TPomgJVLepR9J6ALK6KcrkMW+3Cs5HAZ2hzAt9+FQ
         /gWZmtWWotAhvrm9810b17OkLygfncn0AKiyVc5hQOkSg2NQ8O99u0aenbHlAS4cMM60
         R1nxV1LPP2hppYt5x48Bg5/SJNxhrW3/kQI0xyJVyJq1GWF1r8AQwh2R32Js0gIqZ8zW
         y5ABKh8VVp0D/9dwALHqqiU7CLxi4BhlIU6Z2+2Ld5sFdQXfBacklFBVEDEiFjkshmeV
         WuR49r35eX632pQiRXP99yvXtXpF7WVvWGUKrEHFenUkA5Sj5G4lAM9sqnJKe8ZO6/9J
         iDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KzZoPZdDnqJkBrwR7FMFF9P029Lbhn9WcJK/YTX/ZTY=;
        b=JgXVZbII0s3YCjktMivHpQdJrQ1ZG/4OiwvOXUZQSI0TyuUMftyolyiBOrV8vUo6U6
         44V16gNDQShz8xjfHB4DdeWaFlp/VJb4w/wkYI6ItOlCeCtEqnkQRXC0b9wIaDxQrVVN
         4LkxjkRhpfJEXU4yxWz21zagKm2eF1OL6Lu55oDLvRo2E/kjxFCRVbzcSyq1SdGU8Vm3
         OAUZZOVRLMb+bso/uqKP0Kx7mjCHCAvdaJRwHlqdtzCkoyEBTtveqsgz1LHTAihn5oyG
         rvvhJCT12JXQSxZ94Krr/peyFS0c/o64h4e7dPU7p8XrlyH5gAiY2a1PRRDIxUwYMFA1
         HGqA==
X-Gm-Message-State: AOAM530HRmlJNRGwiQG1kDC3pvvUIYekFNEQXdBaHsU0NReVAhQOanDf
        1k++9S3oapoQQZUGCEUQiTMovGJs4IyQIvZTuSk=
X-Google-Smtp-Source: ABdhPJwsN7sIuQFlEmEIma1yAGVroJoQ/4YPOJrnUZZuQ2lvLRcQtN3S3aK30+fyIyinKk+tRnqxmxbHZg1rlxV/YUE=
X-Received: by 2002:a17:90a:de8e:: with SMTP id n14mr6242729pjv.122.1642623402163;
 Wed, 19 Jan 2022 12:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20220113233158.1582743-1-kennyyu@fb.com> <20220119180254.3174340-1-kennyyu@fb.com>
 <20220119180254.3174340-2-kennyyu@fb.com>
In-Reply-To: <20220119180254.3174340-2-kennyyu@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 19 Jan 2022 12:16:31 -0800
Message-ID: <CAADnVQKDfacNQD8WCp-mmQeyWd6Y09_b41L1=E3b3A6+GCyH+w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Add bpf_access_process_vm() helper
To:     Kenny Yu <kennyyu@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Gabriele <phoenix1987@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 19, 2022 at 10:03 AM Kenny Yu <kennyyu@fb.com> wrote:
>
> +BPF_CALL_5(bpf_access_process_vm, void *, dst, u32, size,
> +          const void __user *, user_ptr, struct task_struct *, tsk,
> +          u32, flags)
> +{
> +       /* flags is not used yet */
> +       return access_process_vm(tsk, (unsigned long)user_ptr, dst, size, 0);
> +}

Though the 'flags' argument is unused the helper has to check
that it's zero and return -EINVAL otherwise.
If we don't do this we won't be able to change the behavior later
due to backward compatibility.
