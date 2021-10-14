Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD69A42DC00
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 16:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhJNOth (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 10:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhJNOtg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 10:49:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53A4C061570
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:47:31 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j21so28546760lfe.0
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iaOXWsPyqvYPWln8KQ8YNDoY2sjqX4fiC/FmTTcSfko=;
        b=FmaGB6FF84TTEt6CngovzQHUndP3lcMlfQl4qPARWIFYbXvr9e9p6I+TtMLwuwUlpa
         HW++jnahtwo44Ug55tWzOpITdAjrQfnTzpsd4ci426NvUb4EN2knwItfoV6egbjqgg0k
         HXdxCqt0MDStRxuZ8g75CdcaGFWdLm8B1S2v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iaOXWsPyqvYPWln8KQ8YNDoY2sjqX4fiC/FmTTcSfko=;
        b=fqzaL+3scQWEhTb/BQHGXvTvg/OqqdZhIwrxAeITCGJv8SaodlLVpJcht4J0DPuB62
         0rz7lLD0AlBf6KnfPY1J81O/2mNMSj08z2KwOr3k/1kFXVBDQ7lXUPKEsnSSSQNiqN5l
         npyTY4tUqr1/bOYMFyy2xE+crFZAwgvz6xoWH5OmFc4Gxh1JMfo61el6qsB4n38nOMKF
         vzEeTk9CRXTvRQiR9Sb4WNyg0S1/Eo8P9NyEZ1bXeoZATZkT4HbphIu8h7TGOFHAWYxN
         NpG8mLvm9r3AokIYIsBpV04ZD9f4TAij1FABSCwjnu2p4s+te+fWX5FR+aF06Et1DJ9S
         nf/A==
X-Gm-Message-State: AOAM530k0O8BKPCr7641zLSdLZxjkYdTlRkGTwTKUAGrGHpBVWWuXdKd
        s7ajq7USABHE3zfv5sbJRa6xt7Lv0R+3xNYkWdrNpg==
X-Google-Smtp-Source: ABdhPJyr9Xdo8couXwETL+a3X4EU4mElXlqtO4DgkENnJPtaPeDnLswk9L86IKAjsKWmSpr2wU+rIWj4QYO+62UF/DU=
X-Received: by 2002:ac2:5b05:: with SMTP id v5mr5462803lfn.39.1634222850173;
 Thu, 14 Oct 2021 07:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211014143436.54470-1-lmb@cloudflare.com> <20211014143436.54470-3-lmb@cloudflare.com>
 <YWhCHbCw17fxQtIN@kroah.com>
In-Reply-To: <YWhCHbCw17fxQtIN@kroah.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 14 Oct 2021 15:47:19 +0100
Message-ID: <CACAyw98ju_BiXXMxzfLu9=8uZMBWyXdb4gQTksHR27WrcwBtAw@mail.gmail.com>
Subject: Re: [RFC 2/9] bpf: various constants
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 14 Oct 2021 at 15:43, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 14, 2021 at 03:34:26PM +0100, Lorenz Bauer wrote:
> > ---
> >  include/uapi/linux/bpf.h | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
>
> I know I don't take matches without any changelog text, maybe other
> maintainers are more lax?

Hi Greg,

The patches aren't ready to go in, I'm looking for feedback. The
rationale in the cover letter for the series, I thought the RFC tag
would be enough, sorry about that. I expect that there will be a lot
of changes (if it lands at all) so I didn't invest the time to write
commit descriptions.

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
