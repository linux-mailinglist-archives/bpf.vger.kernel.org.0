Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB4B58CF3C
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 22:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbiHHUfy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 16:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244215AbiHHUfw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 16:35:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A7162DC
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 13:35:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a7so18709037ejp.2
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 13:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=kfFEtHyc3gZ6xHknNRGbaUblJjZXHKOqNTUB9SaZLag=;
        b=jBy9C4V/yWuQ2+hhJ0THMIrcnqspxdDiYQZKi6Rz/YTpVb5Bhr2QSa+Z0wa3TR9Xy8
         O/S+YqDws0l4D+ovhd/z/LoJoxAccH3CUH7R23QnBkpkKFVV6T8P8kb+YAQGMkRyBzLx
         Jy5q86XrOBg0HpF2p6+FSZqm7nB3xFFeFL6hflkTFLt+z7vAPJ4/drz2rd9K1icUIskX
         QKgAMt/ogGpfDhFyuRc5gvvaAGAgeFPk3ASzV31pdBQg5MYEu+cVGhW8yEGQ0pfqPUuC
         mJHoOzwLACMeFltZHMxmuD5LaKgWHtdePFN+Erc4pdmzDl5DP7cvZx0vU9NmpTR+lzRS
         Djfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=kfFEtHyc3gZ6xHknNRGbaUblJjZXHKOqNTUB9SaZLag=;
        b=p44vkWsU2ZAY/AXQ3xUjufq+IDeeBWvZEK1Cq5Sk/iGbJW1vkB+SKvpRFPofeTSc90
         hFg23Z5BAAvrqFDE9/yBNo5EcUasSVWiFVvg+QJ0vGLZdEF5pqap5RhjUlxqfduezIy3
         AA8W6kO+NQaYoKsIuV/aal+2bCX/Zs/C8Dlr2F/W7NXsDW0teVUPnIwmYqymsSJSYywx
         1ZeTrTi8V72fRPxIn8su1nONcyW6THTspDGh3iVniby74Pq4Q07nNELckYm40BsvUogh
         leJDYctRQNWOZ9O5B5sGKxeuHC+S+loEFtIvmG8TG2uKj4wcqrfrXKSSDTwxie+tLerj
         FKPA==
X-Gm-Message-State: ACgBeo0fK0BSC8Njn2CkkumJv8OGMIKLig15ZXLmXeBSGjnKKCjgiwss
        vwajpf+UhKtkJPS0uTz8TOsa+t2FFKBcxw==
X-Google-Smtp-Source: AA6agR5Qb/n+xhXV2zCdnjlfticO7MuBVBxFkMQn+MrhzSgcmKU6SzAJIssMGtaPj/Mf+QklsjrIbQ==
X-Received: by 2002:a17:907:75e8:b0:730:ccd3:2683 with SMTP id jz8-20020a17090775e800b00730ccd32683mr15128637ejc.329.1659990950359;
        Mon, 08 Aug 2022 13:35:50 -0700 (PDT)
Received: from krava ([83.240.62.146])
        by smtp.gmail.com with ESMTPSA id ah4-20020a1709069ac400b0073145afd156sm250645ejc.80.2022.08.08.13.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 13:35:49 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 8 Aug 2022 22:35:48 +0200
To:     Song Liu <song@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [RFC PATCH bpf-next 00/17] bpf: Add tracing multi link
Message-ID: <YvFzpK00k+F2FGwt@krava>
References: <20220808140626.422731-1-jolsa@kernel.org>
 <CAPhsuW79BmASh7M79DG7O2AT60op5unujeHKe33BUhZdr+wd9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW79BmASh7M79DG7O2AT60op5unujeHKe33BUhZdr+wd9A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 08, 2022 at 10:50:28AM -0700, Song Liu wrote:
> On Mon, Aug 8, 2022 at 7:06 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> [...]
> >
> > Maybe better explained on following example:
> >
> >   - you want to attach program P to functions A,B,C,D,E,F
> >     via bpf_trampoline_multi_attach
> >
> >   - D,E,F already have standard trampoline attached
> >
> >   - the bpf_trampoline_multi_attach will create new 'multi' trampoline
> >     which spans over A,B,C functions and attach program P to single
> >     trampolines D,E,F
> 
> IIUC, we have 4 trampolines (1 multi, 3 singles) at this moment?

yes

> 
> >
> >  -  another program can be attached to A,B,C,D,E,F multi trampoline
> >
> >   - A,B,C functions are now 'not attachable' by any trampoline
> >     until the above 'multi' trampoline is released
> 
> I guess the limitation here is, multi trampolines cannot be splitted after
> attached. While multi trampoline is motivated by short term use cases
> like retsnoop, it is allowed to run them for extended periods of time.
> Then, this limitation might be a real issue in production.

I think it'd be possible to allow adding single trampoline on top of
multi trampoline by removing that single id from it and creating single
trampoline for that

I also thought of possibility to convert intersection IDs of two
multi trampolines into single trampolines.. but that might get slow 
if the common set is too big

the difficulty for the common solution was that if you allow to
split trampolines then bpf link can't carry pointers to trampolines
because they can be split into multiple new trampolines, so link
would need to store just array of IDs and use it to attach a program

then un/linking program and doing intersections with stored trampolines
and handling all the split cases turned out to be nightmare

but perhaps there's another solution

jirka
