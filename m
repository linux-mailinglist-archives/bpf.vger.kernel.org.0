Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2A955E314
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2019 13:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfGCLqd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Jul 2019 07:46:33 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44352 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfGCLqd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Jul 2019 07:46:33 -0400
Received: by mail-oi1-f194.google.com with SMTP id e189so1768078oib.11
        for <bpf@vger.kernel.org>; Wed, 03 Jul 2019 04:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mYCFppVyTLYn4jIWsRodglihiRKb1A76Dy+J8v19wzc=;
        b=D/9AaR+4ugUBBoe5/1T1+ZEwBrg3e3P4WhtXCOVCc7lRsXoCa76A7XhNR0j7h1SCJU
         ZhQ8En4MthdgoIQtVTcxsKV/bApkPtLlwcJ7GYSPzh9P2IRq9NzjA7PEu9sC7TNSCddQ
         FVvPmsxBtpYPwOsdA74BIXEpzq0OmWT1vx6C7YBcT8fF7hzaXA0Evginy/jJI1uJ9zbC
         zL14fynQYfCMydKMRLXIb73eCcvdkGE1i8pa7xeIfaAn1Do9Z6Lx7tGQms0O637oz/Ix
         yU+KnN7NhgWUn+dUA/5/VSg5HNp4LXLUkLG4jEQupWEZuDvgWX9pjdSSX8PdvbNW8/Hq
         xwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mYCFppVyTLYn4jIWsRodglihiRKb1A76Dy+J8v19wzc=;
        b=KFIYJbcuevpoKDbFDKt+E85rads1cWf9YlY7M+FRIT+3zOWQDaTHBBgc2WkwxUA0Q3
         xPxB+/JpdHW/PC8w1/+OgJC+IWmSjkF9qc0rahxCHaKSBD9ht0nbKO8wWeL+RQZ9P65C
         H+HUBoEgnJX1yY9WBo9zXeFS6dqLiZhB038qNbfKCsfMxFiT7vdNuj3SelsXN1oI7JR2
         Uzfll+o6/MVnhF8I7MvHxU+50OhyZ/kAv8ffadH4INUZlQLZfE2vTzX5M04196cw7lNC
         Xtd8wJpEBQhSwKXZ2pL1Tu/BC1qW7ba5yOc9VFr8i+D3WBdzUXLiNxWGu71CGWYQgKBA
         uVEA==
X-Gm-Message-State: APjAAAVSkiLxDC/EqHi0gwUlm83bZdtsp/EERfxNLmSKr76GRSaTAF8Z
        56JzEAolAWBBHVAWa6Nkk4Y+aQ==
X-Google-Smtp-Source: APXvYqwX7as5iFvdGwU6iDuxDN356j60jVpv0gxRnDRYGhYLxaoZipVDwgA728jdYwbcktjADrrxZw==
X-Received: by 2002:aca:c715:: with SMTP id x21mr3307037oif.142.1562154392368;
        Wed, 03 Jul 2019 04:46:32 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id 198sm692180oie.13.2019.07.03.04.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 04:46:31 -0700 (PDT)
Date:   Wed, 3 Jul 2019 19:46:25 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] bpf, libbpf: Smatch: Fix potential NULL pointer
 dereference
Message-ID: <20190703114625.GG6852@leoy-ThinkPad-X240s>
References: <20190702102531.23512-1-leo.yan@linaro.org>
 <b834fba1-5b2c-4406-8275-1cf8383655e3@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b834fba1-5b2c-4406-8275-1cf8383655e3@iogearbox.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 03, 2019 at 12:23:05PM +0200, Daniel Borkmann wrote:
> On 07/02/2019 12:25 PM, Leo Yan wrote:
> > Based on the following report from Smatch, fix the potential
> > NULL pointer dereference check.
> > 
> >   tools/lib/bpf/libbpf.c:3493
> >   bpf_prog_load_xattr() warn: variable dereferenced before check 'attr'
> >   (see line 3483)
> > 
> > 3479 int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
> > 3480                         struct bpf_object **pobj, int *prog_fd)
> > 3481 {
> > 3482         struct bpf_object_open_attr open_attr = {
> > 3483                 .file           = attr->file,
> > 3484                 .prog_type      = attr->prog_type,
> >                                        ^^^^^^
> > 3485         };
> > 
> > At the head of function, it directly access 'attr' without checking if
> > it's NULL pointer.  This patch moves the values assignment after
> > validating 'attr' and 'attr->file'.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 197b574406b3..809b633fa3d9 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -3479,10 +3479,7 @@ int bpf_prog_load(const char *file, enum bpf_prog_type type,
> >  int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
> >  			struct bpf_object **pobj, int *prog_fd)
> >  {
> > -	struct bpf_object_open_attr open_attr = {
> > -		.file		= attr->file,
> > -		.prog_type	= attr->prog_type,
> > -	};
> 
> Applied, thanks! Fyi, I retained the zeroing of open_attr as otherwise if we ever
> extend struct bpf_object_open_attr in future, we'll easily miss this and pass in
> garbage to bpf_object__open_xattr().

Thanks for the info, Daniel.

I checked the link [1] and thanks for the improvement when applied this
patch.

Thanks,
Leo Yan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=33bae185f74d49a0d7b1bfaafb8e959efce0f243
