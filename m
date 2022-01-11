Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B3048B4BF
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 18:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345042AbiAKR4h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 12:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbiAKR4d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jan 2022 12:56:33 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D98C061759
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 09:56:26 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c3so18385490pls.5
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 09:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTUAjWLiQz0DN+OfMSSCgL6ymIMr4NUd4ibX0nci4yg=;
        b=MC8yq1kv4dZAJdK3PyewQYsig/4b8/Dk/ApO+qzKCxYNIL7jz1ATetGmE63ZffZDTj
         yW91OydpFlJ4rPqzz/NiQtfML2B2BPBgZIt6VrxEFGjYjajoszemFHiTgxklMbk7lTYC
         6wjhnofGN3h2+DkxXr4tISi9sd9DH5kVI24GUOsv1bXTcMpuFfpvGHmYalKpCrOJerlI
         gmW2zh4hMP+Tog7Zyg10a/aYkXJ9yJZgG4g2DyPegNjnLoCncGEKDguNct1IeNBcwsAf
         dsm1s5TJZByzqaWjGc+RWuovKeJ3LrWvoXHYavmTNAD5WVZG+h3ktfkiwC32cV6NfrxU
         l42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTUAjWLiQz0DN+OfMSSCgL6ymIMr4NUd4ibX0nci4yg=;
        b=WGk3QaQHKHX8uSs8VXZQCjv1717nrF0NkxEw4UAjWa4zYWvpioRvhzGZyrTb+fGjZ0
         f848bzbT4xQQlBVA13T0/ty+gx8yXPQIMYWACKuwef/hbaYKHt87oL+k7ALD9Z26E1b8
         J1b7SG6de6SuEe5LJu6mHu3X3x3PRE6iJQPOQK9CXE9r3AQWQ2Ga/hIV9IG7d7tAsJD8
         GYdbeMSGJySEGo+6MVX+X0Qxn4PRD9+S2y8Kiv4BFtQOIkSWI+o5JToGI0FYDfYD0hUu
         e8z5C21PVcSZsYwa3rYGuSFcU6ikqtjrO7Z+HgZKMW+RJlKkuTLHOHlf3jD0iFX/1XJw
         +JiQ==
X-Gm-Message-State: AOAM532fxa4slbn9SRNW6Y7euQgM3k6/NrcvScmpThjpyIK8wKgO8qA5
        6ryGfQlD49nWz9gWEj+8rduOZKX7IGmMMr8PlwERe7uG
X-Google-Smtp-Source: ABdhPJyXB/iU2RhlEyTJMuFT2RDvdj0UGIxGc0mGp0zgMQ9ItaUEISL+d1TIwsat6ZK8PHjdC/xo9bXKFUr7OXhQaSY=
X-Received: by 2002:a63:7c50:: with SMTP id l16mr5013006pgn.95.1641923785518;
 Tue, 11 Jan 2022 09:56:25 -0800 (PST)
MIME-Version: 1.0
References: <202201060848.nagWejwv-lkp@intel.com> <20220108005854.658596-1-christylee@fb.com>
 <CAPhsuW5FQTLfs4P4GqMKxsakP82KuPGOrEcqX+zvAH1+VLf7aQ@mail.gmail.com>
 <CAPqJDZqf8-4DCe9J1jr7KekxqfBac3JBc+hx7a6qW4hoF6xPUQ@mail.gmail.com> <20220111094835.GJ1978@kadam>
In-Reply-To: <20220111094835.GJ1978@kadam>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 11 Jan 2022 09:56:14 -0800
Message-ID: <CAADnVQLqQr8MxGEwXbSYtbb__GYjXLvnW134fySCtHX495ZW_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Fix incorrect integer literal used for marking
 scratched registers in verifier logs
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Christy Lee <christyc.y.lee@gmail.com>, Song Liu <song@kernel.org>,
        Christy Lee <christylee@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, kbuild-all@lists.01.org,
        kbuild@lists.01.org, Linux-MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 11, 2022 at 1:49 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Mon, Jan 10, 2022 at 02:12:58PM -0800, Christy Lee wrote:
> > On Mon, Jan 10, 2022 at 1:52 PM Song Liu <song@kernel.org> wrote:
> > >
> > > On Fri, Jan 7, 2022 at 4:59 PM Christy Lee <christylee@fb.com> wrote:
> > > >
> > > > env->scratched_stack_slots is a 64-bit value, we should use ULL
> > > > instead of UL literal values.
> > > >
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Signed-off-by: Christy Lee <christylee@fb.com>
> > >
> > > The fix looks good to me. Thus:
> > >
> > > Acked-by: Song Liu <songliubraving@fb.com>
> > >
> > > However, the patch looks corrupted. Also, the subject is probably too
> > > long (./scripts/checkpatch.pl should complain about it).
> > >
> >
> > I just checked that even with an absurdly long subject (more than 200
> > characters), ./scripts/checkpatch.pl doesn't complain. It only complains
> > when the commit message body has longer than 75 characters but not the
> > subject line.  What's the maximum subject line length?
> >
>
> People say 50 characters but that just seems more aspirational than
> realistic.  This patch needs a subsystem prefix as well.

I fixed patch subj and applied to bpf tree.
Thanks everyone.
