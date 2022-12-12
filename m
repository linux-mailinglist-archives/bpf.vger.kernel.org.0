Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5052B64A8A2
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 21:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiLLUUF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 15:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbiLLUUE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 15:20:04 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE24FBE36
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 12:20:02 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 65so704502pfx.9
        for <bpf@vger.kernel.org>; Mon, 12 Dec 2022 12:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rWGQ0ewoSOgdHyHpQZxxplSgMhk3BA5Qgh487mnlNvg=;
        b=3UQZGZq0WnojaJgHwxez521zVZCLZ5ZLKORv5N/bw8mjjxIpkALxswmLOlA82ZbbeF
         RQ22O1+zzXjggc08nX0sYen9Rip9BrQVLIw0cbvjPiknPS/djiqNLUELc64QotvXs5W7
         u8JuLbNneJTOU+FOHf4uBcNJfGF5Eb83QGdXK0fcvLDFnbUZegMLGo/WYInP0SIRjuH3
         iqDMFV3GqkIqxFqyHGYoGCxVfIC021XclKmFvwN4JhQKfzOaVOVtjUFBmUYtRE97LbXJ
         Q5FuKkNtRLtuUb0T55jd+XHDNaB7m+KqMk1lIr5XLOLlb9qsFA24Y7SC6UDovcm8VJxc
         /Lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWGQ0ewoSOgdHyHpQZxxplSgMhk3BA5Qgh487mnlNvg=;
        b=6a3x2CWIrvySf5O6/R1zkrsRTbi3G419OqNtKuApttNrEKrVE4n41AL6BUV5FOwJwk
         yL7MeBtFIyqKnhhuRxtZrGpFd+y/gJjitaedv9VrBXbe4OyDcVNCI2WbHnO0Vd/3/Y76
         u+zCGrjf3uKFBi7dcA01GszEs21vq4gyUV0PCeMDIpbSXrUUBbz53jkk6RwizPVfHm0/
         9NH5BQWF8LK4KBj5ANnNJwZe1jqeuuRnqfmZlM2v0Xh8ZKhuMkOvzh2xjKjWJdGcy8Zo
         CQU1C9KsONTQrO8xYjaMYqnjoXvbvBLyxjorWyfAVuXKOJ7O1fxLwVuyBIZ6Dy5m5NEk
         vYFQ==
X-Gm-Message-State: ANoB5pnWzcRu16YTJJt650e+Nr2HilwblC9RTRNuWYvJxDWKOPvt4OCK
        srpdu1J0O/flSN62aslnkybBcHASduvQ9ozZtCm0
X-Google-Smtp-Source: AA0mqf488YlMEQSBbTYcDXP/fTBDwzZdjxp01Lxhjnf8ORmg16WBirt5KHghuxiWWkew+f2xB0LOJACqx8K+pb/5FYc=
X-Received: by 2002:a63:64c5:0:b0:479:2109:506 with SMTP id
 y188-20020a6364c5000000b0047921090506mr633770pgb.92.1670876402114; Mon, 12
 Dec 2022 12:20:02 -0800 (PST)
MIME-Version: 1.0
References: <20221209082936.892416-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhSKeTqR+m5g2Nacp9ZJbvD3=OADGMEfDRX4rsH8HmGO9g@mail.gmail.com> <8b202f4e2e234e6786b1c078129e2c3e6853c404.camel@huaweicloud.com>
In-Reply-To: <8b202f4e2e234e6786b1c078129e2c3e6853c404.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 12 Dec 2022 15:19:50 -0500
Message-ID: <CAHC9VhTvzFdVGCFjFkyCjdXgqZrfvDCVJ3TJ8-0xq8RfFU1Rjw@mail.gmail.com>
Subject: Re: [PATCH 1/2] lsm: Fix description of fs_context_parse_param
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     corbet@lwn.net, casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 12, 2022 at 3:34 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Fri, 2022-12-09 at 12:28 -0500, Paul Moore wrote:
> > On Fri, Dec 9, 2022 at 3:30 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > The fs_context_parse_param hook already has a description, which seems the
> > > right one according to the code.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  include/linux/lsm_hooks.h | 3 ---
> > >  1 file changed, 3 deletions(-)
> >
> > I just merged this into lsm/next with a 'Fixes' tag pointing at the
> > previous comment block commit, thanks Roberto.
>
> Thanks Paul. Didn't include it, as I thought it is part of the stable
> kernel process. I guess it is always fine to include it, and to not CC
> the stable kernel mailing list, when the patch does not meet the
> criteria.

To be clear, the 'Fixes' tag here was for the previous comment fix
patch which only exists in the lsm/next branch and not any released
kernel, adding a stable/CC to this patch wouldn't have done anything
except throw up a number of automatically generated merge conflicts as
the stable folks tried to merge just this patch.  The 'Fixes' tag is
simply a bit of administrative housekeeping to connect this patch back
to the original, problematic patch; it will largely go unnoticed
unless someone decides to cherry pick patches.

When in doubt it's okay to add a Fixes tag, but leave off the
stable/CC.  In fact I prefer if people leave off the stable/CC as I've
found it to often be misused IMO; I'd rather add it when merging the
patch into one of the stable branches.

-- 
paul-moore.com
