Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584672BBABD
	for <lists+bpf@lfdr.de>; Sat, 21 Nov 2020 01:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgKUAOR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 19:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbgKUAOR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 19:14:17 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8DBC0613CF
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 16:14:17 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id b17so11816781ljf.12
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 16:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOhlCXLQ7me4aX62QOG9RwxgBAhj7Ibflx4qGQLcgl4=;
        b=ZXn6sV+kmyx7QPspcL9OH8Ac7HBSusOAhV7jGyMTLB/Ng2bK8UvEtybGL/9quDiS5B
         kazkzkKO7lr3zNI3Yu+yMrqkQjVBxUJzcFOWfHwMnTARFBBzXJn8b08522F4e0VARaE1
         yiMyfJlmkJMEE5xjV0mq1dX7Vp48u0EpkChkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOhlCXLQ7me4aX62QOG9RwxgBAhj7Ibflx4qGQLcgl4=;
        b=JvoFiSowWGyXufFD/9aYCGCfoWpeDPLpwXtgmv8hPPC8ICk46wJwY1J50fRBFZzT6l
         GOC17IJ2HfwD1X+0f1asKIi8+GEO9r1L0LgStvRa7lEt11h2g5kFlKlmx/W/c1CgVbMD
         pH2QdraNsmzP85nATC5dWnTf9XlV4VdDCXxdbB76W/rVFr6/XeeScx8bZR2RXyBCED5t
         ktgWdfA2G1lJPiPzodasO5goGqiRYpXxVfy2bK8ZsYZS942+fmjH22AkXc7t2TkKd+So
         m5s9SNGJcj3HO8BxMpJLj5+csJAxTs8wlSmjfAHFexN7H8Hwsx4nxZsA42t9W19Zr2UF
         0QUA==
X-Gm-Message-State: AOAM531XZPKeo60PZKZTtSzkFnxslVI1olgqswNjW5Nebybfk1+Wh2jt
        asvCgQe/Oo5UP8DW1ORx2AOQ92ql8QkFt63b4yyzJg==
X-Google-Smtp-Source: ABdhPJyI5y9/w8jHkxQAIdO6MKmQNNfY/wh+g99sPjgo0T0PGpb9YCvSxqIeWiqNOT7ZTYQ+tHnXuk7VJNy+u/hJtz4=
X-Received: by 2002:a2e:85c6:: with SMTP id h6mr9465290ljj.110.1605917655576;
 Fri, 20 Nov 2020 16:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20201120131708.3237864-1-kpsingh@chromium.org>
 <20201120131708.3237864-2-kpsingh@chromium.org> <a9336dd5-df17-85d9-7c63-d8ab4b74b459@fb.com>
In-Reply-To: <a9336dd5-df17-85d9-7c63-d8ab4b74b459@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Sat, 21 Nov 2020 01:14:04 +0100
Message-ID: <CACYkzJ6bZBybX5tg2DvyJUkBPQ6_qP5FVKvMxdCe+CbA-OmPag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add a BPF helper for getting the IMA
 hash of an inode
To:     Yonghong Song <yhs@fb.com>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[...]

> > + * long bpf_ima_inode_hash(struct inode *inode, void *dst, u32 size)
> > + *   Description
> > + *           Returns the stored IMA hash of the *inode* (if it's avaialable).
> > + *           If the hash is larger than *size*, then only *size*
> > + *           bytes will be copied to *dst*
> > + *   Return > + *            The **hash_algo** of is returned on success,
>
> of => if?

Just changed it to:

"The **hash_algo** is returned on success"

>
> > + *           **-EOPNOTSUP** if IMA is disabled and **-EINVAL** if
>
> and => or

Done. (and the same for tools/)

>

[...]

> > +     .gpl_only       = false,
> > +     .ret_type       = RET_INTEGER,
> > +     .arg1_type      = ARG_PTR_TO_BTF_ID,
> > +     .arg1_btf_id    = &bpf_ima_inode_hash_btf_ids[0],
> > +     .arg2_type      = ARG_PTR_TO_UNINIT_MEM,
> > +     .arg3_type      = ARG_CONST_SIZE_OR_ZERO,
>
> I know ARG_CONST_SIZE_OR_ZERO provides some flexibility and may
> make verifier easier to verify programs. But beyond that did
> you see any real use case user will pass a zero size buf to
> get hash value?
>

I agree, in this case it makes more sense to ARG_CONST_SIZE.

> > +     .allowed        = bpf_ima_inode_hash_allowed,
> > +};

[...]
