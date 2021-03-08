Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3098E3311AB
	for <lists+bpf@lfdr.de>; Mon,  8 Mar 2021 16:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCHPIP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 10:08:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231512AbhCHPIA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Mar 2021 10:08:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EFF865226
        for <bpf@vger.kernel.org>; Mon,  8 Mar 2021 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615216080;
        bh=B2SN6dS0d3ZxUpftniIQxNdiS6RVkIDFFBhIgVMgdn8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sPM2gYQZ83cv8nxhGfiWEPqD2qqUrTf7q3Eawl7QeJhDce99ndrq4Ld9b3SBb2x1k
         qy8rx7HlbVyD5miXRBwabHpuC1mqXbSSNrwBcHI1ZBB5eUCBZG26H7iJZnXCP2FqM0
         a9LTlZ1Ph3eb2n7LK9lkc4Xr75pyYnj7Fc3lwDV4LjtlSfvuXXabaYF+8d9ZR3lauX
         Q8+XVDjIGn8jv+5SMtLCxNaMo5Ij6Qh00Kwv8Y/pMLtgvQWecX63YMHtjDIqTS2VJz
         IY5K9DZLndEOhra9logzM1mtvIZHmv922du/AG9H3/K0ogOvQCNF0ewoAbjOCZoabi
         lbZPN+/BRqGfw==
Received: by mail-lj1-f169.google.com with SMTP id 2so16504414ljr.5
        for <bpf@vger.kernel.org>; Mon, 08 Mar 2021 07:07:59 -0800 (PST)
X-Gm-Message-State: AOAM530TxM7FxPgQzQbj6jdn4foZWdv6+KDGSSPxqkvoCcg6nRB8dtkd
        5DZvccRhzVd56BfLeqMvcEK54X8bMhQXUy9Zp28apA==
X-Google-Smtp-Source: ABdhPJzjl1YoA9XJrc8L4I1XKpwzXfdjhFB5QjpC+E3GbcP5ra+7h5x8dvRbdmxai4qikV5NrEOBTT04a+UOb/pTDvA=
X-Received: by 2002:a05:651c:387:: with SMTP id e7mr14334269ljp.425.1615216078427;
 Mon, 08 Mar 2021 07:07:58 -0800 (PST)
MIME-Version: 1.0
References: <20210307120948.61414-1-tallossos@gmail.com> <e812c654-a5d2-847d-c378-2271e0bdef22@fb.com>
In-Reply-To: <e812c654-a5d2-847d-c378-2271e0bdef22@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 8 Mar 2021 16:07:47 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7XGn6h5HtVazDHOWUZQH9kbz7T4M5PFOwsi9zeCZ3nzQ@mail.gmail.com>
Message-ID: <CACYkzJ7XGn6h5HtVazDHOWUZQH9kbz7T4M5PFOwsi9zeCZ3nzQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Change inode_storage's lookup_elem
 return value from NULL to -EBADF.
To:     Yonghong Song <yhs@fb.com>
Cc:     Tal Lossos <tallossos@gmail.com>, bpf <bpf@vger.kernel.org>,
        Gilad Reti <gilad.reti@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 7, 2021 at 7:18 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/7/21 4:09 AM, Tal Lossos wrote:
> > bpf_fd_inode_storage_lookup_elem returned NULL when getting a bad FD,
> > which caused -ENOENT in bpf_map_copy_value.
> > EBADF is better than ENOENT for a bad FD behaviour.
> >
> > The patch was partially contributed by CyberArk Software, Inc.
> >
> > Signed-off-by: Tal Lossos <tallossos@gmail.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>

Thanks this makes sense and is consistent with sk_storage (which
uses sockfd_lookup) and task_storage (which uses pidfd_get_pid)
which return an -EBADF as well.

Acked-by: KP Singh <kpsingh@kernel.org>
