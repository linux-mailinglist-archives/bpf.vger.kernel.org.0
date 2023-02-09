Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D14B690EAE
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 17:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBIQ4O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 11:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBIQ4N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 11:56:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1909D658C6
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 08:56:09 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d2so2644451pjd.5
        for <bpf@vger.kernel.org>; Thu, 09 Feb 2023 08:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vSUYbG4jVWl2xCjF0Serf/tGjpIWSuQjwXGgOB7JPGo=;
        b=TV5RB2VKmFDl+6XbBT8eTObx5P3NMEvQomv4ix5vmhKRTnzrbZTySY/yAY2CTDm+sR
         rwFn5jkRlY5NRbtR1LFayd19uUKCTYc7eWimgxPYt7dJZBJQOgeL9jMs/Vm43wXHtfqi
         R4F3BBvW+x6raRBgTo1E9MF0Myx4tb575us78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSUYbG4jVWl2xCjF0Serf/tGjpIWSuQjwXGgOB7JPGo=;
        b=XQGXH2+m7e8B+TwgNR9EJCbeIOUSTbXFvYYYdnClrBTjB39v6Xbalh3cDb3OIWhkAZ
         /XTuhU56IwqPyZWtQ/M8HDmXrxZK/f+iy4rB23gsrxtPqVEXtvvpFCjNHhNvt8NSQOn5
         PSDSmd8xZQBfZ5VSBHa42xRPKxhFfmsqgST4MvfdEkDF4BRzeP1LlxwkfHbOmW863Iyo
         dJXWqBrU3VVnVnhl4Wy3HDYbu5uaH58EqXWloKTJwn0bZZNPIUhyXVyK6GGnXwwlVwLx
         UgrzCcgEa2TM1Va6xd96SewpY4oAPIeZZcigl+5ODNSZdLEP/i0ikmosmFoQZrJBl5Sw
         jC1w==
X-Gm-Message-State: AO0yUKVNptyHm3h5nOSlCzIE/MX7M0Qg3IwXqxJ/Ssm9wW1ZwzC521EU
        S/c2m41VcSQBmi8M4whye5qOLg==
X-Google-Smtp-Source: AK7set/RO3/yjk0+J1lmhGuWIWTHW4dZ7JYqlfByG3YjDWTpvo/LX4f46cRkksH1IqHV8A79s/KRYQ==
X-Received: by 2002:a17:902:f243:b0:198:f1e2:25f6 with SMTP id j3-20020a170902f24300b00198f1e225f6mr4567126plc.5.1675961768567;
        Thu, 09 Feb 2023 08:56:08 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902710400b00194c90ca320sm1720648pll.204.2023.02.09.08.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:56:08 -0800 (PST)
Message-ID: <63e525a8.170a0220.e8217.2fdb@mx.google.com>
X-Google-Original-Message-ID: <202302090853.@keescook>
Date:   Thu, 9 Feb 2023 08:56:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, jackmanb@google.com,
        renauld@google.com, casey@schaufler-ca.com, song@kernel.org,
        revest@chromium.org
Subject: Re: [PATCH bpf-next 0/4] Reduce overhead of LSMs with static calls
References: <20230119231033.1307221-1-kpsingh@kernel.org>
 <CAHC9VhRpsXME9Wht_RuSACuU97k359dihye4hW15nWwSQpxtng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRpsXME9Wht_RuSACuU97k359dihye4hW15nWwSQpxtng@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 27, 2023 at 03:16:38PM -0500, Paul Moore wrote:
> On Thu, Jan 19, 2023 at 6:10 PM KP Singh <kpsingh@kernel.org> wrote:
> >
> > # Background
> >
> > LSM hooks (callbacks) are currently invoked as indirect function calls. These
> > callbacks are registered into a linked list at boot time as the order of the
> > LSMs can be configured on the kernel command line with the "lsm=" command line
> > parameter.
> 
> Thanks for sending this KP.  I had hoped to make a proper pass through
> this patchset this week but I ended up getting stuck trying to wrap my
> head around some network segmentation offload issues and didn't quite
> make it here.  Rest assured it is still in my review queue.
> 
> However, I did manage to take a quick look at the patches and one of
> the first things that jumped out at me is it *looks* like this
> patchset is attempting two things: fix a problem where one LSM could
> trample another (especially problematic with the BPF LSM due to its
> nature), and reduce the overhead of making LSM calls.  I realize that
> in this patchset the fix and the optimization are heavily
> intermingled, but I wonder what it would take to develop a standalone
> fix using the existing indirect call approach?  I'm guessing that is
> going to potentially be a pretty significant patch, but if we could
> add a little standardization to the LSM hooks without adding too much
> in the way of code complexity or execution overhead I think that might
> be a win independent of any changes to how we call the hooks.
> 
> Of course this could be crazy too, but I'm the guy who has to ask
> these questions :)

Hm, I am expecting this patch series to _not_ change any semantics of
the LSM "stack". I would agree: nothing should change in this series, as
it should be strictly a mechanical change from "iterate a list of
indirect calls" to "make a series of direct calls". Perhaps I missed
a logical change?

-- 
Kees Cook
