Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9140B64786C
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 23:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiLHWAA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 17:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiLHV7c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 16:59:32 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A710A65AE
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 13:59:20 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id n3so2335564pfq.10
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 13:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g16i19egww1EdjGD+zRuacsquJsxBwloaiWcEoNVR9E=;
        b=WxKa1V6jeJxxo14AlfMldjz0WsyEw+FaBx/HybeIBV0TJkD0adijMV0A/4JxP8WNh6
         wHL3+5H/cR6dMO4/U9Bj3kTySQO2hGaOxN84MY1dnDEtJeVVTLEN/+Ghq1f81y/Y8VQ8
         +jpGyBj0+H2zglyjpVNDov9dNqUix8S8TplAu0AWIuiG2IDr2AppxGmc8rRKnOyKk/t9
         9O8I7AGruiBpdU4TohuFxxMEAqqqELsBBENYFcXgWxxAiKqj55M7Z/h3/R8Aor/2poW8
         hXR1KKEOQh1uXoRGRkxLyUJpy2O5tXGGzOE9gmf/vYvRXTe+/shARE+/Fhum5MsqgQPF
         bjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g16i19egww1EdjGD+zRuacsquJsxBwloaiWcEoNVR9E=;
        b=WrI0IbypS+GxHiSlQ1LZQ/lsc+gcKRqrDXblkG35PFArZL50Qz00Y81yibShWUzDqO
         l7E1DhrCT3zjvxIBrAwV5MRYBXkhmOqVqgjY2uw7yPr/WTc2jMPU3mKpzdDrInHUe0Ia
         RTkQRNcY1Z6Bj6siCEZDmfnrMLI+hezjTq6K1WymvfkaVLZvyPsBC6bzgpB/klexjWLC
         vntW0ZgMLK9dvmZXgMrdxSNKUG0e8BmCYj0r7DgxhFtRFx06c6dQ/zYZToKkAJBYl86J
         Rzl/F9bhtZ3IBtkmqiqllCN08ug0xh5Z8LNnqr2PupryAooQE1bi8KgrykRlU40c7oYe
         y3rg==
X-Gm-Message-State: ANoB5pmiOaqv5qoFst9dkUqnMICuB01TUeM6wkP6nVfqkClTQkM+0E6W
        U6E9bXYoOUYPEduVRnd1y4N/vETrnNrWnCdEdPJs
X-Google-Smtp-Source: AA0mqf7suwg0r3ZmbbOjxSTcWJhzHqQ3v2uKPwyphLovzYmK2k21JaK9XAWCHM3WCrDS5+FcFG7JaZTAt+3m6BG89iw=
X-Received: by 2002:a63:1f63:0:b0:460:ec46:3645 with SMTP id
 q35-20020a631f63000000b00460ec463645mr88685381pgm.92.1670536759965; Thu, 08
 Dec 2022 13:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20221128144240.210110-1-roberto.sassu@huaweicloud.com>
 <20221128144240.210110-3-roberto.sassu@huaweicloud.com> <CAHC9VhRx=pCcAHMAX+51rpFT+efW7HH=X37YOwUG1tTLxyg=SA@mail.gmail.com>
 <7225e76c09c7ff68937e37ee041fefdd6ccac1c8.camel@huaweicloud.com>
 <0682348d9601ca3847ce9ba035e4ab1b586cf712.camel@huaweicloud.com>
 <CAHC9VhQZ3VKWsNarUGPcHZuoRLgb8owKgbdLymwR759qVyQ+2Q@mail.gmail.com> <b989b278a16c48e104b32ba7243e4298491a6056.camel@huaweicloud.com>
In-Reply-To: <b989b278a16c48e104b32ba7243e4298491a6056.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 8 Dec 2022 16:59:08 -0500
Message-ID: <CAHC9VhSdcyOd01VYtqhJGrgKyG3oZmE_1d0RQymxKv1=ErhduQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] lsm: Add/fix return values in lsm_hooks.h and fix formatting
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     David Howells <dhowells@redhat.com>, casey@schaufler-ca.com,
        omosnace@redhat.com, john.johansen@canonical.com,
        kpsingh@kernel.org, bpf@vger.kernel.org,
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

On Thu, Dec 8, 2022 at 4:29 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Wed, 2022-12-07 at 14:34 -0500, Paul Moore wrote:
> > On Wed, Dec 7, 2022 at 4:18 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > For this patch, I saw it is already in lsm/next. Paul, should I do an
> > > incremental patch or change the one in the repo and you force push it?
> > > I would just remove the three lines after the parameters description.
> >
> > Just send a patch against the current lsm/next branch to remove those
> > lines, and please do it ASAP as the merge window opens this
> > weekend/Monday.
>
> Ok, was about to send but I would need a clarification first.
>
> In mount_api.rst, there is for security_fs_context_parse_param():
>
>      The value pointed to by param may be modified (if a string) or stolen
>      (provided the value pointer is NULL'd out).  If it is stolen, 0 must be
>      returned to prevent it being passed to the filesystem.
>
> Looking at security.c:
>
>         hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
>                              list) {
>                 trc = hp->hook.fs_context_parse_param(fc, param);
>                 if (trc == 0)
>                         rc = 0;
>                 else if (trc != -ENOPARAM)
>                         return trc;
>         }
>
> If, as mount_api.rst says, the value is modified by an LSM or stolen,
> should it be passed to other LSMs too?

All of the LSMs should be using fs_parse() in their
fs_context_parse_param() hook to identify the mount options that they
own, skipping those they do not (fs_parse() would return -ENOPARAM in
those cases).  I don't believe we currently have any mount options
that are shared across the different LSMs, so I believe this is a
non-issue.

In the future if we ever find the need to share mount options across
different LSMs we will need some additional work to ensure it is
handled properly, but I don't think we need to worry too much about
that now.

-- 
paul-moore.com
