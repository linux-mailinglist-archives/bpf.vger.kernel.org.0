Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE40F467E56
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 20:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382892AbhLCTk6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 14:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382933AbhLCTk4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 14:40:56 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632EEC061359
        for <bpf@vger.kernel.org>; Fri,  3 Dec 2021 11:37:32 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r138so4022755pgr.13
        for <bpf@vger.kernel.org>; Fri, 03 Dec 2021 11:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LWKe71eoAeBHksA0Q7+Vwnu16+B3Z32gMf+kM6ZvOQ4=;
        b=nD8yc5lBfABo04YgzouuSTSYpFiXY5AXCEKXm98aIJamKZ/bx+whO0RKathBGqpWPa
         Vr4JjT5d+4Yr6DSJiKlhkLCarMfCipVAfazjgIn3IExbUgmrWRkw/9u8so3k1BNiEINl
         4fhpJUG4ukx5itGDbEj5HYbViqZ9ELm3/ePQ+67QqNDlfQdZOUhGrx4OSB8CaEGVQTbQ
         vv62qK2P4DkWqGKIa4V/qGamKp4AQttdKRwrfHp7lcBlVvOOa1uKg2lPc5ZWXSHuJYnI
         dlMZopzr56H2Amo4Qx/1aiHNpjN0VbcsIBTaIpWAjP91SPytsl+jmqZSgq7rO7dzUxDF
         23dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LWKe71eoAeBHksA0Q7+Vwnu16+B3Z32gMf+kM6ZvOQ4=;
        b=Mhxz29GMRwhEGr4ibsewSOD/3ecNmXbufl0zC05FiKliR3qV5KYVGqe1VzxVgYsDnp
         pirAQLAd8TL1wgHv3YdANZw4u41UkoljiljNrcN+l6WNQfNA5oALcwKxP+MvMJLI6rMN
         Pxbl09YWbsXCOCCFCsL8tEpn2A0cJOaxIYrQcLi8C7k96YE0IqfzdhNVIAsg7DqS8W8f
         UusxpBjzeQSR2JP1Suj22u0hJ4Nh8Gp/v9gGSmUUSkJ+vt4iHUlSTwXxsE0/ZLb8sCDS
         /5WNfE2zhFiLf2YvJclDEH5oaFxu0OH/gsgRXyfFFajQ5zFxhmA8OaW6UvB9B0QekO8K
         Mwyg==
X-Gm-Message-State: AOAM531102geUKDhEANQHmG3wrUdmpKvW7SfNmDWhk2PkX3XpxtNF5b8
        IuiGoyHmIctziPx4QeP43G0YxQ==
X-Google-Smtp-Source: ABdhPJyp/28P9Mh6YI90nIBvHPEaeUZhE/OQ5ZC3aFwSxJFfhptKa82wUzQdyyEddkXP5V+Zt6s46A==
X-Received: by 2002:a05:6a00:1348:b0:481:179c:ce9b with SMTP id k8-20020a056a00134800b00481179cce9bmr20825495pfu.27.1638560251726;
        Fri, 03 Dec 2021 11:37:31 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id lp12sm3017627pjb.24.2021.12.03.11.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 11:37:31 -0800 (PST)
Date:   Fri, 3 Dec 2021 19:37:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Bixuan Cui <cuibixuan@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        leon@kernel.org, w@1wt.eu, keescook@chromium.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org,
        netfilter-devel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH -next] mm: delete oversized WARN_ON() in kvmalloc() calls
Message-ID: <Yapx9+fakH6GYpcO@google.com>
References: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
 <20211201192643.ecb0586e0d53bf8454c93669@linux-foundation.org>
 <10cb0382-012b-5012-b664-c29461ce4de8@linux.alibaba.com>
 <20211201202905.b9892171e3f5b9a60f9da251@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211201202905.b9892171e3f5b9a60f9da251@linux-foundation.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

+Paolo, I'm pretty sure he's still not subscribed to the KVM mailing list :-)

On Wed, Dec 01, 2021, Andrew Morton wrote:
> On Thu, 2 Dec 2021 12:05:15 +0800 Bixuan Cui <cuibixuan@linux.alibaba.com> wrote:
> 
> > 
> > 在 2021/12/2 上午11:26, Andrew Morton 写道:
> > >> Delete the WARN_ON() and return NULL directly for oversized parameter
> > >> in kvmalloc() calls.
> > >> Also add unlikely().
> > >>
> > >> Fixes: 7661809d493b ("mm: don't allow oversized kvmalloc() calls")
> > >> Signed-off-by: Bixuan Cui<cuibixuan@linux.alibaba.com>
> > >> ---
> > >> There are a lot of oversize warnings and patches about kvmalloc() calls
> > >> recently. Maybe these warnings are not very necessary.
> > > Or maybe they are.  Please let's take a look at these warnings, one at
> > > a time.  If a large number of them are bogus then sure, let's disable
> > > the runtime test.  But perhaps it's the case that calling code has
> > > genuine issues and should be repaired.
> > Such as：
> 
> Thanks, that's helpful.
> 
> Let's bring all these to the attention of the relevant developers.
> 
> If the consensus is "the code's fine, the warning is bogus" then let's
> consider retiring the warning.
> 
> If the consensus is otherwise then hopefully they will fix their stuff!
> 
> 
> 
> > https://syzkaller.appspot.com/bug?id=24452f89446639c901ac07379ccc702808471e8e
> 
> (cc bpf@vger.kernel.org)
> 
> > https://syzkaller.appspot.com/bug?id=f7c5a86e747f9b7ce333e7295875cd4ede2c7a0d
> 
> (cc netdev@vger.kernel.org, maintainers)
> 
> > https://syzkaller.appspot.com/bug?id=8f306f3db150657a1f6bbe1927467084531602c7
> 
> (cc kvm@vger.kernel.org)

Paolo posted patches to resolve the KVM issues, but I don't think they ever got
applied.

https://lore.kernel.org/all/20211016064302.165220-1-pbonzini@redhat.com/
https://lore.kernel.org/all/20211015165519.135670-1-pbonzini@redhat.com/
