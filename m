Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18522A70D7
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 23:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgKDWyW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 17:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgKDWyW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 17:54:22 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F4DC0613CF
        for <bpf@vger.kernel.org>; Wed,  4 Nov 2020 14:54:22 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id 23so191280ljv.7
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 14:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+JfSC8vfkextKI0CTxdreiJW8D06AVfpIQrednxXpok=;
        b=OY98b6mIcEkijtWQ3mppvCqE+6cW+WWP+NPcK56NFRgXflP8MdM9tH/VMR8CSHnlw7
         ZfUbR/6L6toEG0xoduVm4SnsF55sExHnpQp9r40JSzsP/AwR3oJrxMxjwytOADuq1qM9
         hqccqfLtSS895CkgKBr5+iHFM1Vx8gPUdMN1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+JfSC8vfkextKI0CTxdreiJW8D06AVfpIQrednxXpok=;
        b=JYQmYB3M7tys7dqE8WV2HRJakc73Ay1o54wy0QR5oF8KYrLPKi5HdspNkNkI4hf4IB
         lBJc1oAAzQkto1ESm4c/7OKOZuASiz6s+mDRbJ6oV1rnYpDqod+cGIlCGoZW2bSZ084Q
         qdq6K6WvXAzW7Gzp5YjTZPukWa4ki4L2SQNnoJ2jccgHEZ/o5UzgQqE7uZtWIc/OLdi2
         /Lbo2KwCxHLHaxObZ3hkRvyhKtui+oe1bnOvp+3jmSzGNyAH1VN2Xk9nISukmPsxb4GB
         lf3M1uLIpG6pNPfuHJdvzEKx/E3rcp1jg/OyhGFcb6wbkteTFjZ4nbC5xdylAwTWipon
         ZyWA==
X-Gm-Message-State: AOAM531EkHsg1sHlx4WiTEU+UAf+D8pZmDguntdoZTAS/PiwGZ/L7G7r
        TBScOQLe+F1+pR9xASRtidCWpysilF34fQ+uOgHe+g==
X-Google-Smtp-Source: ABdhPJzM25O+m3zcGcPdBWCey9N4TZDrHf083uNAky6PYnYnVMOWY1awerwvELTCyOIRPfZfZyZMHbTO3u0JEPish9o=
X-Received: by 2002:a2e:97ce:: with SMTP id m14mr75379ljj.49.1604530460480;
 Wed, 04 Nov 2020 14:54:20 -0800 (PST)
MIME-Version: 1.0
References: <20201104164453.74390-1-kpsingh@chromium.org> <20201104164453.74390-2-kpsingh@chromium.org>
 <20201104221526.dv6qfpfp5lk2t7zw@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20201104221526.dv6qfpfp5lk2t7zw@kafai-mbp.dhcp.thefacebook.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 4 Nov 2020 23:54:09 +0100
Message-ID: <CACYkzJ6t12AORyTzAP_P3bZG-_K_01h7DVaUmYTWCd-8U-8-bQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Implement task local storage
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> > +     WARN_ON_ONCE(!rcu_read_lock_held());
> > +     task = pid_task(pid, PIDTYPE_PID);
> > +     if (!task) {
> > +             err = -ENOENT;
> > +             goto out;
> > +     }
> > +
> > +     sdata = bpf_local_storage_update(
> > +             task, (struct bpf_local_storage_map *)map, value, map_flags);
> It seems the task is protected by rcu here and the task may be going away.
> Is it ok?
>
> or the following comment in the later "BPF_CALL_4(bpf_task_storage_get, ...)"
> is no longer valid?
>         /* This helper must only called from where the task is guaranteed
>          * to have a refcount and cannot be freed.
>          */

I reworded this (and the other similar comment) as:

/* This helper must only be called from places where the lifetime of the task
* is guaranteed. Either by being refcounted or by being protected
* by an RCU read-side critical section.
*/
