Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79EFA17F9B
	for <lists+bpf@lfdr.de>; Wed,  8 May 2019 20:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfEHSM0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 May 2019 14:12:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40835 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEHSM0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 May 2019 14:12:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id u17so10899247pfn.7
        for <bpf@vger.kernel.org>; Wed, 08 May 2019 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wCJ0uBEbeN5m7OwhfIqTVfKRA9yg3BSywm72gL5tYtc=;
        b=wsBatlo459IDCODbsoAeUZ1w5VSzX/zWMnRZsMC75KoQIXuGe/8T9SpGhTfcL8KnM8
         LLYiegtCGHpRYE/95I9wLz0eyVhirjDa/twU213DB06FjDUxKXHldP5FY9eCtRfpkTvY
         cp01TDDXeWUxWPK5eDoXQcCMw3tXNnprcVyrmBHU69MoWsuVMdzhY7oYA1zqSaJ+qIAC
         1NutanZE/1i+nD6aeBS+SiGx/uYnZVfB2/w4DmpJSHC7kuaFApfa+KU0sv2evSEO8cNv
         d3w8RZh0BRbtp0Wweltdl2S4yU5PnzTDx40Tt8xCdaKmxIlk3v/nsWT5i0isoqWvo0eB
         ZuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wCJ0uBEbeN5m7OwhfIqTVfKRA9yg3BSywm72gL5tYtc=;
        b=B1DrJYFbG25gd7g2E9uVqCwS0etHYclQtNmDCiq/QTILtkRuJZdukp2Mnx+9X0GJEM
         OkbzmAQysqHgunseefSFQLRC/Ll6FeZcleWDqlJKwFGLULpqj+V5YlnarE6oLxy1tj4V
         EpA52gCzuicwBahHIdfp3PWYpBla0eZxdEGxxwc7s6x+jE9N8M8G88DDro7E2GOA9qSg
         W4DMTuCpM0y0HKj9Fv+9BN2z8XgF/1ialXENz5HuYcntb5P7y2sbJbpzNcS9NOqCV6cH
         HcuDBPPtcVgB1p0JUFxQtvUqtPCywongxpt+tBWJlOoFe5QUx5PxpNI1PAuHN1ATUI+6
         HqPg==
X-Gm-Message-State: APjAAAWjPIgES28bFovbtc3Nw+xZPVulXGYzCFqeBT9KsOvmo8j+NDkw
        2xZuZ4NOCedKMQ4QMlsQ/CCdHw==
X-Google-Smtp-Source: APXvYqzmZRY3funcFrq1gslSSOb1zl/07++/0a7qsXOvRXX9wdQbYYnm0S+BqsNJOiVarjCm5blJWg==
X-Received: by 2002:a63:5cb:: with SMTP id 194mr2527408pgf.294.1557339145274;
        Wed, 08 May 2019 11:12:25 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id l129sm9555554pfc.61.2019.05.08.11.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 11:12:24 -0700 (PDT)
Date:   Wed, 8 May 2019 11:12:23 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net
Subject: Re: [PATCH bpf 0/4] bpf: remove __rcu annotations from bpf_prog_array
Message-ID: <20190508181223.GH1247@mini-arch>
References: <20190508171845.201303-1-sdf@google.com>
 <20190508175644.e4k5o6o3cgn6k5lx@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508175644.e4k5o6o3cgn6k5lx@ast-mbp>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/08, Alexei Starovoitov wrote:
> On Wed, May 08, 2019 at 10:18:41AM -0700, Stanislav Fomichev wrote:
> > Right now we are not using rcu api correctly: we pass __rcu pointers
> > to bpf_prog_array_xyz routines but don't use rcu_dereference on them
> > (see bpf_prog_array_delete_safe and bpf_prog_array_copy in particular).
> > Instead of sprinkling rcu_dereferences, let's just get rid of those
> > __rcu annotations and move rcu handling to a higher level.
> > 
> > It looks like all those routines are called from the rcu update
> > side and we can use simple rcu_dereference_protected to get a
> > reference that is valid as long as we hold a mutex (i.e. no other
> > updater can change the pointer, no need for rcu read section and
> > there should not be a use-after-free problem).
> > 
> > To be fair, there is currently no issue with the existing approach
> > since the calls are mutex-protected, pointer values don't change,
> > __rcu annotations are ignored. But it's still nice to use proper api.
> > 
> > The series fixes the following sparse warnings:
> 
> Absolutely not.
> please fix it properly.
> Removing annotations is not a fix.
I'm fixing it properly by removing the annotations and moving lifetime
management to the upper layer. See commits 2-4 where I fix the users, the
first patch is just the "preparation".

The users are supposed to do:

mutex_lock(&x);
p = rcu_dereference_protected(prog_array, lockdep_is_held(&x))
// ...
// call bpf_prog_array helpers while mutex guarantees that
// the object referenced by p is valid (i.e. no need for bpf_prog_array
// helpers to care about rcu lifetime)
// ...
mutex_unlock(&x);

What am I missing here?
