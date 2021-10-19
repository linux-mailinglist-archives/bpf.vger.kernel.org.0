Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742824337F6
	for <lists+bpf@lfdr.de>; Tue, 19 Oct 2021 16:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbhJSOF0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Oct 2021 10:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230487AbhJSOF0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 19 Oct 2021 10:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634652193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxnmlxy+BaLSH+N4pHJPdEHRlGFL6UvTVG5CDeMc9oY=;
        b=GwHhmQrfPLgv3Hf1SjBXdkT3BPo60cO23JQ5NxMU13ma3/zAUQUGPA/yCpaPfL4PvYkNW9
        CEErJzAuy6P979HAVPaBsuzJa6BWEQJp/YFvhktgu8ETyVHdDqHBxmypklz0Rwfi28czdu
        tKe1tW9+nrxyI0NM2/0gOWSN7sh+SDg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-VgbbVhA2PTKExYqyFjsREg-1; Tue, 19 Oct 2021 10:03:09 -0400
X-MC-Unique: VgbbVhA2PTKExYqyFjsREg-1
Received: by mail-ed1-f71.google.com with SMTP id c25-20020a056402143900b003dc19782ea8so14227864edx.3
        for <bpf@vger.kernel.org>; Tue, 19 Oct 2021 07:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dxnmlxy+BaLSH+N4pHJPdEHRlGFL6UvTVG5CDeMc9oY=;
        b=B4lbIgrEdxCSq3Pc5TqGZj0zcJKp5aqY+0MhJF31MKfKlNN01RSaWyNz+UAFJz1JCZ
         X2EQiRbuejKRpCkRAosYbLfuusne4kzAxj75q5xmmN5bcnds7P3iOrFcaW8EBBqpgLXR
         CaPvvFJGlqXfH9x79vPzxygMMnz1AImg2URQkEqHD6jAr6lW+aUL1lnwJX0vgpY+idMY
         ySUsLIem60NdJYpaLfgk03N2qn8y4inWNYgc6h6B6FfoY/M/3jTc2ZWy6q282PhNK4N7
         kthGIK8dW0/8eo1S63W55GLG5pyun2qxrcAVnvqU/QkoCPdfFPhQyh3nGn+jTfrwjRyo
         LlDA==
X-Gm-Message-State: AOAM531s990tR/Kxx4Ofsq2yu2AJ/+zcQt/3yOOAxxTMR8pdFVhlRCUf
        AV2Ja841DrG25DkGqU2cM/zmja+EY526a0O3MGqYgSGvFcHEm4DdJ44luNT7k3G4G4Gc4/BlQbJ
        29e374C8GOBPS
X-Received: by 2002:a05:6402:358d:: with SMTP id y13mr54934688edc.343.1634652186224;
        Tue, 19 Oct 2021 07:03:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXHhs7gQpZDYN3Tc71banDnKgRQcWlAbGHbDXahYmDAeiA61WKUcTYbGx5d9Mv6Hb2H198DA==
X-Received: by 2002:a05:6402:358d:: with SMTP id y13mr54934621edc.343.1634652185654;
        Tue, 19 Oct 2021 07:03:05 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id j1sm604288edk.53.2021.10.19.07.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 07:03:05 -0700 (PDT)
Date:   Tue, 19 Oct 2021 16:03:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 7/8] ftrace: Add multi direct modify interface
Message-ID: <YW7QFzXrJwoFHkct@krava>
References: <20211008091336.33616-1-jolsa@kernel.org>
 <20211008091336.33616-8-jolsa@kernel.org>
 <20211014162819.5c85618b@gandalf.local.home>
 <YWluhdDMfkNGwlhz@krava>
 <20211015100509.78d4fb01@gandalf.local.home>
 <YWq6C69rQhUcAGe+@krava>
 <20211018221015.3f145843@gandalf.local.home>
 <YW7F8kTc3Bl8AkVx@krava>
 <YW7HfV9+UiuYxt7N@krava>
 <20211019093216.058ec98b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211019093216.058ec98b@gandalf.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 19, 2021 at 09:32:16AM -0400, Steven Rostedt wrote:
> On Tue, 19 Oct 2021 15:26:21 +0200
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > > when trying to apply on top of my changes  
> > 
> > I updated my ftrace/direct branch, it actually still had the previous
> > version.. sorry, perhaps this is the cause of fuzz
> 
> I just pushed it (including your patches) here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> 
>   ftrace/core
> 
> 
> This is where I keep my WIP code. It should not be used to base anything
> off of, as I rebase it constantly. But it has the current version I plan on
> testing.
> 
> You can make sure the patches in there have your latest version, as you can
> review my patch. I'll update the tags if you give me one.

I'm getting error when compiling:

  CC      kernel/trace/ftrace.o
kernel/trace/ftrace.c: In function ‘modify_ftrace_direct_multi’:
kernel/trace/ftrace.c:5608:2: error: label ‘out_unlock’ defined but not used [-Werror=unused-label]
 5608 |  out_unlock:
      |  ^~~~~~~~~~

looks like out_unlock is nolonger needed, I removed it

jirka

