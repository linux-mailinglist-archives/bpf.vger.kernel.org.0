Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFC162EA9B
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 01:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbiKRAyh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 19:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbiKRAyf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 19:54:35 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD0C85EED
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 16:54:34 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v17so3221455plo.1
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 16:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XvIoWSd0xrw6RZJQp73B+S5uCJ5LMxazrUmMxPfNjuQ=;
        b=Ywx/QwtKH8VAB4UddTVRkYxOW2k+PyRwVVpR4TEzkhDl4DjNzjqniVbWpNQeGC15uz
         THTgtgOC2tJtLxcn+N6qnN3Uy3FVT4qmUSr3XOZgiLlJCWs0v/93AF1Vt/H6ei2/0on5
         d7zw7FPkZM/4CTydhHhG2fL1TGCDWupJAjNhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvIoWSd0xrw6RZJQp73B+S5uCJ5LMxazrUmMxPfNjuQ=;
        b=3IehGahcdl3hQ9B+WKy/k9fT1Su7htufhzTa811gfOHlKQV7MX4I4IyvX30zpPFy0Y
         U07FuQ8bEywfoml5HmFsqbgjytBEjI5ALbQLlvntsyqsH0OWNe0GYyWKVRf0Qx+lj5kj
         8xALspKTfKAVc6IoRbvfMqXR8eALr0fWPSMAmMrbXFHtN3+f2PDEmkZTqVY7Y7Nz0fZ/
         1RsMMFZZaDK9D3AaaWr6H/YNPs8BH50AL8neX+jtGtFyH4PS76FAmVMJcb3/reeuAGzE
         QSY96VbygHZBrhCOddEpxD7PtADBbuXcqJ3kd+9J1BQClJUlWMm1biYxoT/l/C/7erM8
         ujAw==
X-Gm-Message-State: ANoB5pk5Kk8VJzgkf8hVjvmF8qr38GVtSEMpW51xfZKSl94R+/0LkCZy
        KIiPUIGtVd1iGg7xxuse2X3mcw==
X-Google-Smtp-Source: AA0mqf6l8TeoWF0zZxdx0LT95pkl13FOnju8C6AgmTu9j8vNo494eN13cvZRXCxp+hVgpR5ied3LDw==
X-Received: by 2002:a17:902:c652:b0:186:af8e:7ed4 with SMTP id s18-20020a170902c65200b00186af8e7ed4mr5223346pls.7.1668732874435;
        Thu, 17 Nov 2022 16:54:34 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b00172b87d9770sm2073855plt.81.2022.11.17.16.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 16:54:33 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:54:33 -0800
From:   Kees Cook <keescook@chromium.org>
To:     sdf@google.com
Cc:     wangkailong@jari.cn, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] samples/seccomp: fix array_size.cocci warning
Message-ID: <202211171653.0E3BA8E71B@keescook>
References: <2b3f2420.130.184706d34e6.Coremail.wangkailong@jari.cn>
 <Y3J3t/ieGaOG8Qjl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3J3t/ieGaOG8Qjl@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 14, 2022 at 09:15:35AM -0800, sdf@google.com wrote:
> On 11/13, wangkailong@jari.cn wrote:
> > Fix following coccicheck warning:
> 
> > samples/seccomp/bpf-fancy.c:83:39-40: WARNING: Use ARRAY_SIZE
> > samples/seccomp/bpf-fancy.c:86:44-45: WARNING: Use ARRAY_SIZE
> 
> Not sure this should go via bpf tree. CC'ed Kees
> 
> > Signed-off-by: KaiLong Wang <wangkailong@jari.cn>
> > ---
> >   samples/seccomp/bpf-fancy.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> > diff --git a/samples/seccomp/bpf-fancy.c b/samples/seccomp/bpf-fancy.c
> > index 1ccb435025b6..548f038924d6 100644
> > --- a/samples/seccomp/bpf-fancy.c
> > +++ b/samples/seccomp/bpf-fancy.c
> > @@ -80,10 +80,10 @@ int main(int argc, char **argv)
> >   	};
> >   	struct sock_fprog prog = {
> >   		.filter = filter,
> > -		.len = (unsigned short)(sizeof(filter)/sizeof(filter[0])),
> > +		.len = (unsigned short)(ARRAY_SIZE(filter)),
> >   	};
> >   	ssize_t bytes;
> > -	bpf_resolve_jumps(&l, filter, sizeof(filter)/sizeof(*filter));
> > +	bpf_resolve_jumps(&l, filter, ARRAY_SIZE(filter));

Hm, this is the "samples" tree, so this was intentionally avoiding these
kinds of kernel-isms, but perhaps that doesn't realistically matter?

-Kees

> 
> >   	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
> >   		perror("prctl(NO_NEW_PRIVS)");
> > --
> > 2.25.1

-- 
Kees Cook
