Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248A76E8EE3
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 12:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjDTKFh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 06:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjDTKF2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 06:05:28 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7974C31
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 03:05:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id z6so5106196ejc.5
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 03:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1681985109; x=1684577109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=agHckanpJDD7KAjWNvheb7t6bEqVdV1x737yZKOWzJE=;
        b=HZIL/ncLDaoykRaDDbIr0py93KMFu9gfqXxWheJ57n58VBKusij35olKwzNry2blHQ
         M64yvr9uN2vPz+JHnS5Ghhgmd10c+xFsaqT/3Tvxw0AGdnOw+HO2C5dKf2gJnAyzYvAR
         zvCJnHNX202lJPrXckM8InvGAkMeOZGUcqUcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681985109; x=1684577109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agHckanpJDD7KAjWNvheb7t6bEqVdV1x737yZKOWzJE=;
        b=arz2qe4VwoDZ0lC4lXH9s62f6zkHq2PCFvEG3EHR/mpHl+3rjV9eyr5LQLw0x2SSdN
         WLAFPqMNOXoF2Q8qoMt4xsPYy+UuV3J+UbnKc6RxA7gBxHSL9U9V4RWyz3YE/Qoxf3Wl
         kciOF/4Wnr6NHTmDW1y/p0jbL9WXqS4KmI+lnOj2KDx68fi9IvYGb4b+L5m0TzcqPgwA
         5485PnAHazsXPAdMGdGA1LnDhsY1r0gNj1mPN3GwxOZR76NQ+2uX0Wo3lqwkcNQTdyaa
         HyDfbn9npaHCJLWrRQ/f4v46hIxW52/+l0OKsdQpl/3nze996Zk/53Ri6B1JKqVIyw0L
         yqDQ==
X-Gm-Message-State: AAQBX9ePr5j2fLvi43ILBObBn8iBclkq9O2xOXWPoLiD4dtHcEKONrhY
        A8k9Ui4jE2RmLWTCmoxm49wd/Z4ycssYWOvD1e+/Gg==
X-Google-Smtp-Source: AKy350buy0UUIHG3mG6NwefaD7Nyj+HBKl3H4/cEuoCGoJKe1RzomC8K5njIaRsiDP0WxbPsZB5oZupNRBWLCnxQOIE=
X-Received: by 2002:a17:906:2001:b0:953:37c5:daef with SMTP id
 1-20020a170906200100b0095337c5daefmr399563ejo.0.1681985109291; Thu, 20 Apr
 2023 03:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230418143617.27762-1-magnus.karlsson@gmail.com>
 <CAHApi-=_=ia8Pa23QRchxdx-ekPTgT5nYj=ktYGO4gRwP0cvCA@mail.gmail.com> <CAJ8uoz3qM04VQF7FRmnVp_AZjGaPw25GJNn0ah-Jd0=eRCRsjg@mail.gmail.com>
In-Reply-To: <CAJ8uoz3qM04VQF7FRmnVp_AZjGaPw25GJNn0ah-Jd0=eRCRsjg@mail.gmail.com>
From:   Kal Cutter Conley <kal.conley@dectris.com>
Date:   Thu, 20 Apr 2023 12:09:56 +0200
Message-ID: <CAHApi-=NkvNvbDJTwLcPfo_ZkRg9vfVNmQN50_LzA3K8t7Q4JQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/xsk: fix munmap for hugepage allocated umem
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        maciej.fijalkowski@intel.com, tirthendu.sarkar@intel.com,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> It was a conscious decision to require a hugepage size of 2M. I want
> it to fail if you do not have it since the rest of the code will not
> work if you are using some other size. Yes, it is possible to discover
> what hugepage sizes exist and act on that, but I want to keep the code
> simple.

Yes. I understood that and I think the solution is reasonable. Sadly,
it's not trivial to query the default hugepage size from userspace
AFAIK. Is parsing /proc/meminfo the only way?

What I meant was: "the tests may still fail _with the old mode of
failure (out of memory)_ if the default hugepage size is > 2MB".
