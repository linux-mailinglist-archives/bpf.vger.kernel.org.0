Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0261143390C
	for <lists+bpf@lfdr.de>; Tue, 19 Oct 2021 16:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhJSOuN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Oct 2021 10:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230464AbhJSOuL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 19 Oct 2021 10:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634654878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7QitIDAaB6JPlOQL4BIGgtdEL9A4rgBCBZ9HTFk1cbE=;
        b=aLcF2rS+kYji2FXQtFIhmutE2oFgHrVZuC5ySsyRJgnwksHXX0vFsvmq/X8LqXiQV/+ReN
        XF15I655POmIikAHd6SnhS9I4pfQInYZu1/FMLbJyaR6aOoUNPw5uJWjETNATncNNnmTq1
        a6bdAGwJeDMlwu45t21Khoa0tDABqVc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-_mlNIapnNqy4fbr1YEfsRg-1; Tue, 19 Oct 2021 10:47:56 -0400
X-MC-Unique: _mlNIapnNqy4fbr1YEfsRg-1
Received: by mail-ed1-f71.google.com with SMTP id v2-20020a50f082000000b003db24e28d59so17818312edl.5
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 07:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7QitIDAaB6JPlOQL4BIGgtdEL9A4rgBCBZ9HTFk1cbE=;
        b=HnjXHzTloaQ53aFhFqrIA9d7GxwtwsvGFqqtXkjjPy7mphuCBfVRrTP6AlzPq5mSfP
         7ue7dTLgLQNIIWIqUsXdmtDaM3wC5WEe+kQ1vDaI0IQ3HWUJ747GyTusMTLuY8f5C5wa
         4qZMe5dU75Zbp0T2iu2xfs7C8c4W8yWmKJ4zYAOKgZR7NZsnAwr9lRCxD7ik+qyf0xrW
         xiKP+k8tMv4WRZxEB4p7exef1Kmbyv8G8ln5MBVcDT6moqfL6BqB5K/rxwaDWi8wgKlG
         PgvFkYeNKcgkBDn6TdNDvzrc3rsM/FApJe0OQ3twtK+5UAg0g7BwqEVuUiPvF3q0Nltb
         aSwA==
X-Gm-Message-State: AOAM530kUu/x1LbGGBLfyEs0nuNQlJYXXcd4JruGu2v6v+7lEs2akhVz
        6xw8WWXxBOgq0ocBFKnDZZwP0EVfUnk1VGnCHMij5LPlP4rkULO2LuXiAeQqP/96R4ttByXsvvs
        z1mVjH8zcjGzm
X-Received: by 2002:a17:906:7fd8:: with SMTP id r24mr38039466ejs.80.1634654875571;
        Tue, 19 Oct 2021 07:47:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyx9fxcScXURO3ssPLUJyeNE+stSJqLagoSf0g8cAZHm+YTrdvGHIthlMvdQcsD8fbSeH/b1w==
X-Received: by 2002:a17:906:7fd8:: with SMTP id r24mr38039444ejs.80.1634654875352;
        Tue, 19 Oct 2021 07:47:55 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id m18sm7600493ejn.62.2021.10.19.07.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 07:47:55 -0700 (PDT)
Date:   Tue, 19 Oct 2021 16:47:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 7/8] ftrace: Add multi direct modify interface
Message-ID: <YW7amQa2DviKapl8@krava>
References: <20211014162819.5c85618b@gandalf.local.home>
 <YWluhdDMfkNGwlhz@krava>
 <20211015100509.78d4fb01@gandalf.local.home>
 <YWq6C69rQhUcAGe+@krava>
 <20211018221015.3f145843@gandalf.local.home>
 <YW7F8kTc3Bl8AkVx@krava>
 <YW7HfV9+UiuYxt7N@krava>
 <20211019093216.058ec98b@gandalf.local.home>
 <YW7QFzXrJwoFHkct@krava>
 <20211019104411.18322063@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211019104411.18322063@gandalf.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 19, 2021 at 10:44:11AM -0400, Steven Rostedt wrote:
> On Tue, 19 Oct 2021 16:03:03 +0200
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > > You can make sure the patches in there have your latest version, as you can
> > > review my patch. I'll update the tags if you give me one.  
> > 
> > I'm getting error when compiling:
> > 
> >   CC      kernel/trace/ftrace.o
> > kernel/trace/ftrace.c: In function ‘modify_ftrace_direct_multi’:
> > kernel/trace/ftrace.c:5608:2: error: label ‘out_unlock’ defined but not used [-Werror=unused-label]
> 
> Ah, I don't think I've been hit by the "-Werror" yet ;-)
> 
> 
> >  5608 |  out_unlock:
> >       |  ^~~~~~~~~~
> > 
> > looks like out_unlock is nolonger needed, I removed it
> 
> My tests would have found this, as it has a check for "new warnings".
> 
> Anyway, was this in your latest patch, or did I pull in and older one?
> 
> That is, should I expect a v2 from you?

it's on top of your ftrace/core, in your change:
  e62d91d8206e ftrace/direct: Do not disable when switching direct callers

just removing the label will fix it

also you can add my ack

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

