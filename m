Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06CF6BDD8F
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 01:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCQAZC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Mar 2023 20:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCQAZB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Mar 2023 20:25:01 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B90D733A4
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 17:24:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j13so3356834pjd.1
        for <bpf@vger.kernel.org>; Thu, 16 Mar 2023 17:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679012696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a0s1NHee6pdWQ7oGx/0NJLxIlOLgtuGw4Tp1rl+MDXs=;
        b=cFvDnqUI3yGQ3oRHfu9lv4mIVhFhlpf7MtpG+ms6kkEBR/QhtuOParHS9Wsb6zRTGF
         a/zI2zJ1l+KYBTrxKGEY43gCUhnGUjwyD6r6ilk5kxinoKTag51PGoIzYB7nt2Clr0n+
         kHjcDOHDxmlpWHVgiFPF6tDW/ppTAJamsE8eGP8QLoAKODmxoUiBMaVBiiQMFT2xdJHj
         88PBmNIycHf7nmgIVF0wfCDMXNXqdOCvz8usHu8tETmrZmudnRS7dCpyZOXmVD14jxs5
         Whznn/mpytkunh6N+/N6rDnRfywoi8yHOCqCw8m+SWru5T9PLJ5kLyJoVro3AK7FVxKP
         LD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679012696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0s1NHee6pdWQ7oGx/0NJLxIlOLgtuGw4Tp1rl+MDXs=;
        b=5rP5WJ04PWCbpqJx6PTPmBH5lFMYS27wbFpn12kDa8rXdXZ3SxoRBqJFsfT8wRs3eT
         aIV0n3gaEdQFhrOD2DwI4fW1HD8GWd4ariaaRO/SvPg/5BaKW4LlaLX6ulfMz0blGw9k
         uQ1MS1NNbK7tQFfmQWPoJKCqmilbJ+fqsNZHommI9QV54KJ8RrdTeXJWB0IxNv3hVm5I
         4LzG8NjauSwXWAfsLwCvfR33/TwJd66SXrBLxWMkd0AhChpupTApv4SYKPfS87NSQuK0
         uSnk34StSp5ymKpQ/JCTjkzyL6QYw7rH9iY+2RumSH9CayM5KAplxHMb9cGsb/FLLjXv
         Msxw==
X-Gm-Message-State: AO0yUKUqu+15WEt/US3SVZ9onUiy8JD7IAIUU0I0Ihe2WipvdjVFX77i
        iRKme7USKEWquYj0o2gMLy2PRx+gW9Nptg==
X-Google-Smtp-Source: AK7set9/Z0WeGDQBMNAhYKbgWotgOP6TtzGhBp//YWSpQEEM3shobaXnBphJmAEoIinNOdheyYPS5g==
X-Received: by 2002:a17:902:c94f:b0:19e:675b:a40f with SMTP id i15-20020a170902c94f00b0019e675ba40fmr6400649pla.8.1679012695624;
        Thu, 16 Mar 2023 17:24:55 -0700 (PDT)
Received: from worktop ([2620:10d:c090:400::5:1c5f])
        by smtp.gmail.com with ESMTPSA id v9-20020a1709028d8900b001964c8164aasm271944plo.129.2023.03.16.17.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 17:24:55 -0700 (PDT)
Date:   Thu, 16 Mar 2023 17:24:52 -0700
From:   Manu Bretelle <chantr4@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, yhs@fb.com
Subject: Re: [PATCH bpf-next] selftests/bpf: add --json-summary option to
 test_progs
Message-ID: <ZBOzVGn7nPbVoNsi@worktop>
References: <20230316063901.3619730-1-chantr4@gmail.com>
 <665c32ae4ef880c1811b8a8e3b35a7ad0bcfb054.camel@gmail.com>
 <ZBNGBAAki3VUU0bQ@worktop>
 <97845fbdc4178dd3d7bea836b245af2c82347b94.camel@gmail.com>
 <CAEf4BzZj6FP+=UYVXEq8bsqk0Os2zLKB2B60vyVO9+FL5jnttw@mail.gmail.com>
 <88930a425a50f6c1f5a420bf2adbec3b285b96e4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88930a425a50f6c1f5a420bf2adbec3b285b96e4.camel@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 17, 2023 at 01:33:56AM +0200, Eduard Zingerman wrote:
> On Thu, 2023-03-16 at 16:23 -0700, Andrii Nakryiko wrote:
> > > [...]
> > > 
> > > > In term of logical structure and maybe extensibility, this is more appropriate,
> > > > in term of pragmatism maybe less.
> > > > 
> > > > I don't have strong opinions and can see benefit for both.
> > > 
> > > idk, I don't have a strong opinion either.
> > 
> > me neither, flatter struct would be simple to work with either with jq
> > or hacky grepping, so I guess the question would be how much do we
> > lose by using flatter structure?
> 
> Okay, okay, noone wants to read jq manual, I get it :)
> 
> I assume that current plan is to consume this output by some CI script
> (and e.g. provide a foldable list of failed tests/sub-tests in the
> final output).

Correct.

> So, we should probably use whatever makes more sense
> for those scripts. If you and Manu think that flat structure works
> best -- so be it.

Nested is the most logical representation of the data. Given the
one-liner you provided, let me play a bit more with it and see what it
would take to get minimal info out of it.

