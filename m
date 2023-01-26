Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65BE67CE90
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 15:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjAZOpr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 09:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjAZOpr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 09:45:47 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8ED3AB6
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 06:45:46 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id tz11so5801045ejc.0
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 06:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7nSsfyNEXPrSXuem+7chKXQR9LbBquP+RO1JogAR3bE=;
        b=h8Qst5Jm0t1zi0sxzwuxgrj7pPKzZMRYv9y+Bx5HfiANi42TZlj93ZMJ3C5QVaBnk5
         2+NwPuV7kyYWOl5DxTs3scKnaNxxJ0kxzHfGNHvdN5sZkqcukdRbmNvnbmSoQcKnWT8S
         8Zt+9SFjvi3Txo+vWCRA4Es6RwdYdDcW/yjIzkHh8rGyau6yfV2rGkYHR6PEcmsl9Ejp
         V3+G/eYeU6Z/QVPmC8qUGAebmt5uBGF2m13jZMXPEGSudiIILKDoe4uJ4JLnWRf6SFsP
         HZ8aG4yiVMB7lccePFkHCbanbKX/PDnOqzOXCdEbTcMEbMFedi/BYom0IO5gf/nc2EnP
         CN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nSsfyNEXPrSXuem+7chKXQR9LbBquP+RO1JogAR3bE=;
        b=JXYT4d2pqFYGBXzhFeM/bRjzknfz98yZMWn77OjsZ18Jzlm+sJmroZUnEx3NWKmjBV
         3f6XRRaWyhdknrGj2UUEMMwyBISD1KLkBr+r8vs7nvrNcyNtFRgxq4jzEPLorxH/61D6
         KVr3snptuCickMbJYz0efh5ohoHzKFwEzzHzmcgG+K4HeWMCLaKRVLinowTqed8dPXjU
         SbjeGM8s/kzK9fZ/mhkFPQEy6T3mnX/m+NixM8XNoZfB8B7Kh1NG1H3eF8ZeinriYeTw
         8JI15NZY5y4RXfDc1bkfbDxB0UHJJfQ2j19RCrKxmPGe5BVJC1gVY4TNJT+RXS3sZ+jt
         ciYA==
X-Gm-Message-State: AFqh2kqY71dz6EV39iXZH6P4OSF335hIxKIJD9iX8OZZI7N7rOei+FR9
        zw24u1Ib8YslCNxlEIWYQuc=
X-Google-Smtp-Source: AMrXdXvZhbqN7eMM7fynC8tMrz2TUg+pYb4hTdsQIfHB3735MpbRtOkg3tojGXXCQ9uqlOu2JiegRA==
X-Received: by 2002:a17:906:a051:b0:870:baa6:6762 with SMTP id bg17-20020a170906a05100b00870baa66762mr35944370ejb.14.1674744344524;
        Thu, 26 Jan 2023 06:45:44 -0800 (PST)
Received: from krava ([83.240.61.48])
        by smtp.gmail.com with ESMTPSA id f17-20020a170906049100b0083f91a32131sm710231eja.0.2023.01.26.06.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 06:45:44 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 26 Jan 2023 15:45:41 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: Move kernel test kfuncs into
 bpf_testmod
Message-ID: <Y9KSFaFYc4WLiCa9@krava>
References: <20230124143626.250719-1-jolsa@kernel.org>
 <CAADnVQLpk2-fcjgkOssuaT82Pdtu1KzgnxjHXiBV1TJzYXjtWQ@mail.gmail.com>
 <Y9DdDIpVfQ2f+b70@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9DdDIpVfQ2f+b70@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 25, 2023 at 08:41:00AM +0100, Jiri Olsa wrote:
> On Tue, Jan 24, 2023 at 07:49:38PM -0800, Alexei Starovoitov wrote:
> > On Tue, Jan 24, 2023 at 6:36 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > hi,
> > > I noticed several times in discussions that we should move test kfuncs
> > > into kernel module, now perhaps even more pressing with all the kfunc
> > > effort. This patchset moves all the test kfuncs into bpf_testmod.
> > >
> > > I added bpf_testmod/bpf_testmod_kfunc.h header that is shared between
> > > bpf_testmod kernel module and BPF programs, which brings some difficulties
> > > with __ksym define. But I'm not sure having separate headers for BPF
> > > programs and for kernel module would be better.
> > 
> > This part looks fine and overall it's great.
> > Thanks a lot for working on this.
> > But see failing tests.
> > test_progs-no_alu32 -t cb_refs
> 
> oops, forgot about alu32 :-\ will check

it seems to be related to missing commit in bpf-next/master:

  74bc3a5acc82 bpf: Add missing btf_put to register_btf_id_dtor_kfuncs

it's in bpf/master now and I have it on my branch,
when I revert it I see same errors as in CI

I can include it in next post or wait for bpf-next to catch up with bpf

jirka
