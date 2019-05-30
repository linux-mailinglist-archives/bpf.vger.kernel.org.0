Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B422F7FB
	for <lists+bpf@lfdr.de>; Thu, 30 May 2019 09:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfE3HjG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 May 2019 03:39:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40952 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfE3HjG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 May 2019 03:39:06 -0400
Received: by mail-pl1-f194.google.com with SMTP id g69so2202358plb.7;
        Thu, 30 May 2019 00:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IlTH5PC8QN6s5pDyLnED54IkhUjHpmYD5UVsaa4DGbU=;
        b=l5lRqi8IRqBEozyKydowBAnxb3nZ+aLL11OIGap9RmyXaiKO8mPrHoxtgzRRUJTIKL
         XMHQjyWq8ZAJ5AWas3g9VUglxljujDOrVgUmMXtAXxDDKmrlOymmHUVGLNj6rxzEB4RP
         jYPy5lTIDjUSJRcBJFj0DIdgqrwhUxOwTbI+nYH/fM91fkbffDZdGMQprdIiAchyrjtz
         op7fHDXhLysvEQU3eXT0yXsGQ6A7j54ABleP4oAbluOqmVxNUemmsdgXTHre/EY6kwJs
         JdkfuiGoFbqFdx/w2xOod0AOQIGt+ZlW+2cS5bRer793aGgWMXfxspC2u+dPJcKBQFjM
         0dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IlTH5PC8QN6s5pDyLnED54IkhUjHpmYD5UVsaa4DGbU=;
        b=IO1MjfkgJQqseYDaw/3k/ayXbTXxeH4Wl0wf+9HR2n0mKvz4xf2pqr7c0LAHcPZ91O
         iq/Wl689IXxArEpNucTbVBfNJlvFthxfn0QgJk27vUIyzzIqIA07j8RXdPXRBLgyoq8x
         7wYTihHAuw6e6F5O77dhz+ohcc8+vCJgkYDxFb1NgYfS1i2AYZgjd3dfrZn5bkSacUwl
         +swbe7Pfd6nM0YlSCX9+D/LQM+TiVkY2J4gK5IxnwfQzScJcQ5Zs97qa7EBh02wT8XKi
         l2xvlkcCBOEF0ffbzzhG+pJ7KQp+KLcqn/eTNYWNhKW/uh7xacQZHsjNNxadrxiJj9jt
         dGDA==
X-Gm-Message-State: APjAAAX0Q+DdBE7e4iYdA9594MqhKe6/GmNvQX3dtNev+7asIVvl4NM/
        L7hFKy4ZcwJYyoBnKnU+I/s=
X-Google-Smtp-Source: APXvYqxpjuyuftqs3w21evTb/aGMHh2P2kfcGNYgwXiDoswXKZSH/rHrzVejrYoPdlMHOgCYrCQ9oA==
X-Received: by 2002:a17:902:b590:: with SMTP id a16mr2502085pls.168.1559201945505;
        Thu, 30 May 2019 00:39:05 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id 8sm1866863pfj.93.2019.05.30.00.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 00:39:04 -0700 (PDT)
Date:   Thu, 30 May 2019 15:38:34 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, tony.luck@intel.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] hooks: fix a missing-check bug in
 selinux_sb_eat_lsm_opts()
Message-ID: <20190530073834.GB2382@zhanggen-UX430UQ>
References: <20190530035310.GA9127@zhanggen-UX430UQ>
 <CAFftDdrX_=7KXfbvMDdCamj84nzYB+QCGXWArD3=zEkPZsQ1eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFftDdrX_=7KXfbvMDdCamj84nzYB+QCGXWArD3=zEkPZsQ1eQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 29, 2019 at 09:39:50PM -0700, William Roberts wrote:
> On Wed, May 29, 2019 at 8:55 PM Gen Zhang <blackgod016574@gmail.com> wrote:
> >
> > In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> > returns NULL when fails. So 'arg' should be checked.
> >
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > ---
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 3ec702c..5a9e959 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2635,6 +2635,8 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
> >                                                 *q++ = c;
> >                                 }
> >                                 arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
> > +                               if (!arg)
> > +                                       return 0;
> 
> The routine seems to return 0 on success, why would it return 0 on ENOMEM?
> 
Thanks for your reply, William. I re-examined the source code and didn't
figure out what the return value should be in this situation. Could it 
be a -ENOMEM? Do you have any idea?

Thanks
Gen
> >                         }
> >                         rc = selinux_add_opt(token, arg, mnt_opts);
> >                         if (unlikely(rc)) {
