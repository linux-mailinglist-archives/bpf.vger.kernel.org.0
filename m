Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CE96E86A5
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 02:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjDTAjY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 20:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDTAjX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 20:39:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CBE172E
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 17:39:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5069097bac7so453359a12.0
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 17:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681951161; x=1684543161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq2MxTD2oPHOP5sXkC216p/J7z0rPCBfe+ys3QDaYjo=;
        b=KE4e62tbG7me4bC2SY0kaLf9CVR0kKqYb9Uhrc7DUxP7nUIL2e6TRqZKUfi9lxhj1K
         BrzW1kwHkfR94WEwuMpElgEW9o3lvmQxaz124A6ptkNWHuJJvaDQKE867GaVgAFpqpkt
         9SlPwvg0+m09lYirtAFXrcmw9KIOM7znIa/xs7C4YvAKFGxyw0vO9BoLaZE3kncXar5q
         nWTggFrTUlynpXkeXAh1iRhDbFY8B/ekpRUme1e2mA5501CLrV3ZLxYvtAnCiR7c4NS8
         txaBwyGC5J5nvPw2QHWsjaKjxd80Sj85TzpzIhFpjkgM4QLdUqvww9eAoguXrvKrb4Wx
         HlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681951161; x=1684543161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jq2MxTD2oPHOP5sXkC216p/J7z0rPCBfe+ys3QDaYjo=;
        b=ASr1fS8+gAb9qdBYi66uY06YY2+Iw9JzVAACLoC87SQAGw/XzBro/Rlq9qrNjK3kUw
         eejdjdySc4RY8Cx70JcQoG8XCrGP8ZcmDPlQOuEyd11b9UiDFXjT+9I6ey6Af/cmHzsi
         pteE8nUURVqB2WeaB1At1N6Dia5MVV2WDXjkw+YtPTJ7Mz71LFUHNtU7zGlPDTzgkHA0
         lJmpCvrme2aiyZTIcb+akA44BaAp2Gurg10EBlBdaqVnZ6fTu48oGs2kFU3ofKFdjnuY
         jHIqfj5H+bxvKr9cHiHWuba0FR9j5XnOl3mz2jGH6ltCP5pXKInqmTOB4jsxztT1R4P8
         tw+A==
X-Gm-Message-State: AAQBX9fn+znANnUfdYEbNTxgqtJiGHfOd67SporLBpAtnzgky8Sj1vf7
        jq+6hvp1XljYEyXTf9BT/kJwMVM9vw5JToF3hak19ChXBNg0/YC51FudwdMV
X-Google-Smtp-Source: AKy350ZCHNqxdGPWY54tCrAan29d8uA+6QCxUFt/vbEZ9nDVZY2M2BX7PFJ36Esq7wrUYVaLfJwPeWXulw/2chJpTS0=
X-Received: by 2002:aa7:cd0b:0:b0:504:b177:3eee with SMTP id
 b11-20020aa7cd0b000000b00504b1773eeemr6323677edw.33.1681951160818; Wed, 19
 Apr 2023 17:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230418085516.1104514-1-tmricht@linux.ibm.com> <233a0b88-6857-0a1d-3609-6a74fa50c28c@iogearbox.net>
In-Reply-To: <233a0b88-6857-0a1d-3609-6a74fa50c28c@iogearbox.net>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Thu, 20 Apr 2023 01:39:09 +0100
Message-ID: <CACdoK4K=zU8dqpVM33sCrLq1aWRxg1x=3Rg2RYgm+SY4NDtM_Q@mail.gmail.com>
Subject: Re: [PATCH] bpftool: fix broken compile on s390 for linux-next repository
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Thomas Richter <tmricht@linux.ibm.com>, broonie@kernel.org,
        hca@linux.ibm.com, sfr@canb.auug.org.au, liam.howlett@oracle.com,
        acme@redhat.com, ast@kernel.org, bpf@vger.kernel.org,
        linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 19 Apr 2023 at 15:51, Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 4/18/23 10:55 AM, Thomas Richter wrote:

> > -                     __fallthrough;
> > +                     fallthrough;
>
> The problem is however for current bpf-next, where this change breaks CI:
>
> https://github.com/kernel-patches/bpf/actions/runs/4737651765/jobs/8410684531
>
>    [...]
>      CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/bpftool/feature.o
>      CC      /tmp/work/bpf/bpf/tools/testing/selftests/bpf/tools/build/bpftool/disasm.o
>    btf_dumper.c:838:4: error: use of undeclared identifier 'fallthrough'
>                            fallthrough;
>                            ^
>    1 error generated.
>    [...]
>
> I would suggest as a clean path that'll work for both to just change from
> fallthrough; into /* fallthrough */ as done in objtool, then we can also
> work around BPF CI issue and merge this change in time.
>
> >               default:
> >                       putchar(*s);
> >               }
> >
>

Thanks Daniel for pointing this out. I just submitted the patch you suggested:
https://lore.kernel.org/bpf/20230420003333.90901-1-quentin@isovalent.com/

Quentin
