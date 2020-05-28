Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48C11E6720
	for <lists+bpf@lfdr.de>; Thu, 28 May 2020 18:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404852AbgE1QJt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 May 2020 12:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404827AbgE1QJs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 May 2020 12:09:48 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA77BC08C5C6
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 09:09:47 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id y25so503838qtb.6
        for <bpf@vger.kernel.org>; Thu, 28 May 2020 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l7izMIej695jtDHxNmO1NkELxUiXr1gE4xucCDUIPm4=;
        b=vQSPm6UKNcJZfv+Y5nSEzSRQ+ZCC2hrUyqqqGRl6RnGVqdmRRolQ1bbxPfqLsaHCVJ
         CADJhY7EtrpdJ+nsVZUDr6E+pVWGA5aG8SaAVJtxJUYotJGe9+TVZNLnA1bjO0UgMbRI
         iW3tW6Q7DeNvkfG3aw8VIB7NWetu5Gs20EmjX//IWhHU6O2wWPfZylqKXDq49qNOT8NM
         HXqm/zeT91CbqgKKwEWpW1Khy4n6fm5NhDpDvhlS04E8BX69m4K0CQQ31UWdUz0T4Dps
         44/WXKTmjtCcgrly9B6TkypSzT9UVCRQZS9ccFzoCmdO+LLVdfTVAyqMKhVaN56trKf2
         fNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l7izMIej695jtDHxNmO1NkELxUiXr1gE4xucCDUIPm4=;
        b=VUJWNrYfgCALoYmwNi8lOgHoFd+A1r1m4W12MFvoa+8WAy7rsqOnFM4qzXO9zwSFxJ
         923q8NQ3QjPrW+Ftufgwohb/tB5F+rKOFVvsm/r4b6z+QfGrtveeXhEinycqohg5uUAa
         zhQdsMmmrIOeO0ydM22esdmb+rMKC7viE00GmT42GMjEzNB1cOEy51mZXEVark8IYAdJ
         FbE1pli1WdW3QwzyZ0ia9voKc9qemTuvhZtxGP3XiAvPlOgi9JHdPmOXFNL2JN7xqY8T
         WxDeLA/wN3/8UA06sTH7u+o0pmFb1P86BFMe0CvOhKBXKL6OrDQ0RdDB/I4OFdOOJeYb
         vyBA==
X-Gm-Message-State: AOAM531KgoCo8mxe5qW2aFzp5B4BqQ6HBczoSrpXJhMiixGQ4Sy34Owv
        2ZERozXklSBR3KGF21lDwqCvfEI=
X-Google-Smtp-Source: ABdhPJxL4q98bQJFae2QsNI+B0JMMlsleqWKuc5RO8AxECU+QolvkoeIFQJH+VO4UZqDxgTjmYIiqyY=
X-Received: by 2002:a0c:a1e3:: with SMTP id e90mr3945555qva.187.1590682187088;
 Thu, 28 May 2020 09:09:47 -0700 (PDT)
Date:   Thu, 28 May 2020 09:09:45 -0700
In-Reply-To: <87r1v42ue8.fsf@cloudflare.com>
Message-Id: <20200528160945.GD57268@google.com>
Mime-Version: 1.0
References: <20200527170840.1768178-1-jakub@cloudflare.com>
 <20200527170840.1768178-6-jakub@cloudflare.com> <20200527205300.GC57268@google.com>
 <87r1v42ue8.fsf@cloudflare.com>
Subject: Re: [PATCH bpf-next 5/8] bpf: Add link-based BPF program attachment
 to network namespace
From:   sdf@google.com
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/28, Jakub Sitnicki wrote:
> On Wed, May 27, 2020 at 10:53 PM CEST, sdf@google.com wrote:
> > On 05/27, Jakub Sitnicki wrote:
[..]
> > Otherwise, those mutex_lock+rcu_read_lock are a bit confusing.

> Great idea, thanks. This is almost the same as what I was thinking
> about. The only difference being that I want to also get ref to net, so
> it doesn't go away while we continue outside of RCU read-side critical
> section.
That will also work, up to you. Thanks!
