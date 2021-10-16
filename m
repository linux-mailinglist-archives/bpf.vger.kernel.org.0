Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6BF430276
	for <lists+bpf@lfdr.de>; Sat, 16 Oct 2021 13:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhJPLmI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 16 Oct 2021 07:42:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38376 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232168AbhJPLmI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 16 Oct 2021 07:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634384399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tjS9YFlVGwtcWTbzJnOhWSoY+8PFA5sGYT0gTfsGBcw=;
        b=ZdpTbFNszwAvkmv6ltNfNQwPTWMqkUcWZccM5V0hNdxRg27w9//7ZtlyAjxYoVKbyb+BTw
        wdkq4b4yxgC4YjSz+CfM5a30kMhDaWWify95INUiVLcCfn66MDKPPB3xzLj7MUWQR8rpnd
        V3OzoeAXfKGqpYOged4IURGDSL06H1A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-MOXF02PpMdiV4T7TFVp-bA-1; Sat, 16 Oct 2021 07:39:58 -0400
X-MC-Unique: MOXF02PpMdiV4T7TFVp-bA-1
Received: by mail-wm1-f72.google.com with SMTP id o196-20020a1ca5cd000000b0030dc197412aso1608587wme.0
        for <bpf@vger.kernel.org>; Sat, 16 Oct 2021 04:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tjS9YFlVGwtcWTbzJnOhWSoY+8PFA5sGYT0gTfsGBcw=;
        b=MIPBE0R0HHj+HRPXeX6zhpNUOA1T0h/AVAvbzm6IYyuJbWtjEa7gsZ9z0JszmeMGrv
         E+G+Q1oSjK92IFf9IuX9gwGntRRACdxLzyOye/drpXQAoytBCB+XYvIN1tbkvcW5KOzl
         VlXllo05BB5tqVMEalTfnU+h4iRJ7qZDK159xlviy2g2NALND3DhsiFfjdj4UNWo9oC9
         6bwHnSE4PA778E24cHfM+zmpgGjebkiqAEzKN94YV+5fwKiQo9zUMQLw3K/9NmkFOjxC
         5uXVkhbYVX7ic6cExSHgSiH+lRCtruEScYEi10u58I9d6qDyenwQuKHR4UuF0B5Engs3
         m1ew==
X-Gm-Message-State: AOAM533wJ53U9D6OMerlP4xh+CFPlWrI3LB4vwTadrX7zWMUnveC7sCh
        vws/979ejuao1Bv5t0URODwWTg4XFn6oBuw9BTBmvGkCzJVa/9PlY/Rd2WgOW1UKSpf2LdP7UVw
        n/PeBIlMpB3dL
X-Received: by 2002:a5d:47ac:: with SMTP id 12mr20371852wrb.352.1634384397260;
        Sat, 16 Oct 2021 04:39:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMbnFqzfoci5oeFVy4BTnkfciAlNCmyxciKO8osAJkH83DA6kseDTUUvad29VpBWcw3rw/Vw==
X-Received: by 2002:a5d:47ac:: with SMTP id 12mr20371836wrb.352.1634384397087;
        Sat, 16 Oct 2021 04:39:57 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id d24sm6867737wmb.35.2021.10.16.04.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 04:39:56 -0700 (PDT)
Date:   Sat, 16 Oct 2021 13:39:55 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 7/8] ftrace: Add multi direct modify interface
Message-ID: <YWq6C69rQhUcAGe+@krava>
References: <20211008091336.33616-1-jolsa@kernel.org>
 <20211008091336.33616-8-jolsa@kernel.org>
 <20211014162819.5c85618b@gandalf.local.home>
 <YWluhdDMfkNGwlhz@krava>
 <20211015100509.78d4fb01@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015100509.78d4fb01@gandalf.local.home>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 15, 2021 at 10:05:09AM -0400, Steven Rostedt wrote:
> On Fri, 15 Oct 2021 14:05:25 +0200
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > ATM I'm bit stuck on the bpf side of this whole change, I'll test
> > it with my other changes when I unstuck myself ;-)
> 
> If you want, I'll apply this as a separate change on top of your patch set.
> As I don't see anything wrong with your current code.
> 
> And when you are satisfied with this, just give me a "tested-by" and I'll
> push it too.

sounds great, thanks
jirka

