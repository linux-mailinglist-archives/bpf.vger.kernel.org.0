Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7248864C0A4
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 00:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiLMX2o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 18:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbiLMX2N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 18:28:13 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C67F26AFA
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:28:02 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d20so20220081edn.0
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 15:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLL6NpiVlz3JSgxhR9NXWq/Kte1dg/N08T75MFPWZkU=;
        b=K+iN4KfGt776SeWqOxWabEGwgWCKXJgxv+vdO9lMWW6OlFEFP51d9lJn0XHJT8j2sa
         mgw+EjA5SQbS6E+z6+zRVJvhPBN6TvM8O+n+1dkQy9DmaLUiRVwwOWCZeEFW7KlN2lpm
         oCS/gyJT0cu4YDx95XG+c9PNV7yWsGNZzLixnJ1+3DgddKa66uWOQJL2/IjiR/bfvlty
         s2AuuxSTPz6YsdgR4w5o4mI9MTHTjRz1P4ctRPhRXBX8ixwe82ljO04RtIfjRzQaMbp3
         lFDeEGMPikcQqP/gyRP7+k0oo/PqxECpEFvzjSOLMKL1Smm/kKnquM45e/tBFfrnOKLF
         H/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLL6NpiVlz3JSgxhR9NXWq/Kte1dg/N08T75MFPWZkU=;
        b=AfNxN+yxnDIFlKQ+N6MyCzorYh9z6Sg311Ms8Vx6wI1/Ex4alg+/pw9scgIQt8OGuR
         V6rWr9jtT5FqT5ItksvbpAqv7lrnu4E6lUQWVkd0nHmioBtDNenwb1qBByBJ4i7/5kek
         TozMu161az6eLginLHGfPrIhkFnrxXQmDaPidyvHIzfkq4woWtOJ1dpiK2/9CXWkfOiO
         gktUl2QErNZqFKYFwZiTOKXa4ODl5Y0CkGzFdwis9SkOhwX02ddVyvhs98vaDB120UKg
         sxdQlm/ZjOWQT3z6XfNjQsKPZrywsaARRc5SRwmkvsiXrqdJ6YhxazI1JI8sXEcpBtgg
         ehPw==
X-Gm-Message-State: ANoB5pmeI3DuxQeKllw3KZnIHGY58HCpL2qb/hPaNmHeuoTP/8dlEtEa
        a+pbXbNYxK2MkJupXsNwJ0F6yaTsH7NLKl5arps=
X-Google-Smtp-Source: AA0mqf5NHTSfK4GOrTBd7vLFmC/fq+fcsLMv6F8aPAP3EIGDhF2WkYF3ijc7tQxuH2REzW/xUcunNIViMnpb0gwyjq0=
X-Received: by 2002:aa7:d8d5:0:b0:46b:4156:76d2 with SMTP id
 k21-20020aa7d8d5000000b0046b415676d2mr42946274eds.224.1670974080879; Tue, 13
 Dec 2022 15:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20221213220500.3427947-1-song@kernel.org> <20221213232054.eaqsyinwtna5drmm@muellerd-fedora-PC2BDTX9>
In-Reply-To: <20221213232054.eaqsyinwtna5drmm@muellerd-fedora-PC2BDTX9>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Dec 2022 15:27:48 -0800
Message-ID: <CAEf4Bzb8bZZzxC-buZh1ytJq2m3OnCj0yXdOjBirbpxeShHdwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: select CONFIG_FUNCTION_ERROR_INJECTION
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 13, 2022 at 3:21 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> On Tue, Dec 13, 2022 at 02:05:00PM -0800, Song Liu wrote:
> > BPF selftests require CONFIG_FUNCTION_ERROR_INJECTION to work. However,
> > CONFIG_FUNCTION_ERROR_INJECTION is no longer 'y' by default after [1].
> > As a result, we are seeing errors like the following from BPF CI:
> >
> >    bpf_testmod_test_read() is not modifiable
> >    __x64_sys_setdomainname is not sleepable
> >    __x64_sys_getpgid is not sleepable
> >
> > Fix this by explicitly selecting CONFIG_FUNCTION_ERROR_INJECTION in the
> > selftest config.
> >
> > [1] commit a4412fdd49dc ("error-injection: Add prompt for function erro=
r injection")
> > Reported-by: Daniel M=C3=BCller <deso@posteo.net>
> > Signed-off-by: Song Liu <song@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/config | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftes=
ts/bpf/config
> > index 612f699dc4f7..5cbc975fd5c8 100644
> > --- a/tools/testing/selftests/bpf/config
> > +++ b/tools/testing/selftests/bpf/config
> > @@ -76,3 +76,4 @@ CONFIG_USERFAULTFD=3Dy
> >  CONFIG_VXLAN=3Dy
> >  CONFIG_XDP_SOCKETS=3Dy
> >  CONFIG_XFRM_INTERFACE=3Dy
> > +CONFIG_FUNCTION_ERROR_INJECTION=3Dy
> > \ No newline at end of file
>
> Thanks for the fix! I believe we try to keep the file sorted (although I =
do see
> one violation) to make it easy to diff against arch specific configs but =
also to
> minimize the risk of merge conflicts (more likely if everybody appends). =
Would
> you mind sorting the addition in?
>
> Looks good to me otherwise.
>
> Acked-by: Daniel M=C3=BCller <deso@posteo.net>

I've fixed up the patch (order, added Fixes: tag, etc) locally. But
I'm waiting for CI to confirm. Song, no need to resubmit this, but
please add a custom patch to BPF CI, so that this applies to both bpf
and bpf-next trees. Thanks!
