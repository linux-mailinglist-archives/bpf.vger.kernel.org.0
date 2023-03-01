Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC356A75E3
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 22:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjCAVJd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 16:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjCAVJZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 16:09:25 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E507C2367D
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 13:09:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o12so59358971edb.9
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 13:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv9nsPWCbN1OnSLvyB/L9i7rwOi4JfiZpSDjI71GAjo=;
        b=Qq7zORgMP+kJlrfgJgDAU6mroqOrXfKeL0mTkKpK5F61R4QI/eydzS88oNqMphqTdp
         yabA56rRCGd+NTmcdYsyw0NvBXNVNsVCKp2ttTYrEkwb5j9tlJMad9vh9KTxVaVcwIb/
         UE/wX/cvIDbJKY2XEKGV7l3LH/O7/qwqXeYuDP3SYdbwSyRkZyVQNjjpWbX/dt5N8A6X
         Q3xh5oAF+MHMeFwR0cM0JK2hkn3C0UXyzOeHSAhP9Z3HGUBjyPXvixgl95SF/FZdhNFx
         mZEkZQXJj7H7CzObZ8U3ZAFI3+B205MKUz7dHurH7rXS8Fz7wFs9DD9fljYtYcXAXWwW
         X0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mv9nsPWCbN1OnSLvyB/L9i7rwOi4JfiZpSDjI71GAjo=;
        b=XAQApeUYawBINbxjF8LzGW4KHRzzBKS64Oy30oBOOkTyUkh4x2xdn4DwFU2WxGotAN
         Z6Qx9IVlON4cYX78vxN5w99QAGxt2OIWsWmff8TDzx/9vp1yyzyn+jW7exmUPdWC+Zkz
         OB/o7Onf/WeFg9ntc1+JdREpJ0fXXep8Cp/RTOaVUvpyRZTtZDBlSEJRWEJST0vfEGTN
         1xGkMZbaXl6Iwqwl354uu91UjwxU9KZRmjf3i/6+pdU3yvn993SyiMJrU1W8tOpd7PZH
         XVxhhMk3sHCokpV0z8nncgo/gKe+o+hViojt/FCWSQaqCejy7DCaZ4pEOYMgFAbwNfu9
         I0nw==
X-Gm-Message-State: AO0yUKWAoBOjDliOcgon6CnZjumn8LBc2K0G19P/OaFzr/OTIlH2UVMT
        EW/FeA2B6KALBRH2s1WGV5U=
X-Google-Smtp-Source: AK7set9bEYmhPaqmAY2Rhr5anjkx6fvljdPrFu+SO49+e2kfQuA2YKg2yKIUX/yIoQftbQjl7Z8r9A==
X-Received: by 2002:a17:906:2611:b0:8b1:326e:5374 with SMTP id h17-20020a170906261100b008b1326e5374mr7945746ejc.46.1677704959205;
        Wed, 01 Mar 2023 13:09:19 -0800 (PST)
Received: from erthalion.local (dslb-178-012-041-046.178.012.pools.vodafone-ip.de. [178.12.41.46])
        by smtp.gmail.com with ESMTPSA id e3-20020a50a683000000b004a27046b7a7sm6183346edc.73.2023.03.01.13.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 13:09:18 -0800 (PST)
Date:   Wed, 1 Mar 2023 22:07:26 +0100
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net
Subject: Re: [PATCH bpf-next] libbpf: Use text error for btf_custom_path
 failures
Message-ID: <20230301210726.vqdea7dksathapej@erthalion.local>
References: <20230228142531.439324-1-9erthalion6@gmail.com>
 <CAEf4BzYz5dmJBzTuEvihDqjYyWqUcQE6YLUH1WdC_RDifu7FpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYz5dmJBzTuEvihDqjYyWqUcQE6YLUH1WdC_RDifu7FpA@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Wed, Mar 01, 2023 at 11:02:25AM -0800, Andrii Nakryiko wrote:
>
> > Use libbpf_strerror_r to expand the error when failed to parse the btf
> > file at btf_custom_path. It does not change a lot locally, but since the
> > error will bubble up through a few layers, it may become quite
> > confusing otherwise. As an example here is what happens when the file
> > indicated via btf_custom_path does not exist and the caller uses
> > strerror as well:
> >
> >     libbpf: failed to parse target BTF: -2
> >     libbpf: failed to perform CO-RE relocations: -2
> >     libbpf: failed to load object 'bpf_probe'
> >     libbpf: failed to load BPF skeleton 'bpf_probe': -2
> >     [caller]: failed to load BPF object (errno: 2 | message: No such file or directory)
> >
> > In this context "No such file or directory" could be easily
> > misinterpreted as belonging to some other part of loading process, e.g.
> > the BPF object itself. With this change it would look a bit better:
> >
> >     libbpf: failed to parse target BTF: No such file or directory
> >     libbpf: failed to perform CO-RE relocations: -2
> >     libbpf: failed to load object 'bpf_probe'
> >     libbpf: failed to load BPF skeleton 'bpf_probe': -2
> >     [caller]: failed to load BPF object (errno: 2 | message: No such file or directory)
>
> I find these text-only error messages more harmful, actually. Very
> often their literal meaning is confusing, and instead the process is
> to guess what's -Exxx error they represent, and go from there.
>
> Recently me and Quentin discussed moving towards an approach where
> we'd log both symbolic error value (-EPERM instead of -1) and also
> human-readable text message. So I'd prefer us figuring out how to do
> this ergonomically in libbpf and bpftool code base, and start moving
> in that direction.

Fair enough, thanks. I would love to try out any suggestions in this
area -- we were recently looking into error handling, and certain parts
were suboptimal.

Talking about confusing text error messages, I'm curious about -ESRCH
usage. It's being used in libbpf and various subsystem as well to
indicate that something wasn't found, so I guess it's an established
practice. But then in case btf__load_vmlinux_btf can't find a proper
file and reports an error, the caller gets surprising "No such process"
out of strerror. Am I missing something, is it implemented like this on
purpose?
