Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F826638919
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 12:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKYLxh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 06:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiKYLxh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 06:53:37 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7CD15A1D
        for <bpf@vger.kernel.org>; Fri, 25 Nov 2022 03:53:36 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id c140so4795606ybf.11
        for <bpf@vger.kernel.org>; Fri, 25 Nov 2022 03:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JBBi7pDWfq6sGDydKPbZFITTK3jiT4/iDkdedJsjm7o=;
        b=U1XzQMuautL7ZgQPs+1CoTezYdue2nb7l3wU30pH8uDsTTW0bfUrKT07QHI88VwL8X
         8ILjs6eO5A5dtXSzwx47GSeRoUyzQljkwZt8jIemWL5YwFYDhA5GTKemTvZHFcMEsDTK
         TllTmOqHotTq4H4DWDA/g/rvQcHR+0uRNQ1G1zeQ+3hyU/bR8i+eX9JPRAmaAj0OMNDp
         zMiuLx3pznd3N3EczthVRJIF6uFS2BV/k897P8tgH/djdED9FeyBAM2VgERJxxwPUwmz
         TilAV7Nbqjz0khq0Q66N2fw3sFfDQlgHs+64ZtQRohwG8ns9DoVB7sQmYbW8FpLm8Ctj
         MKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBBi7pDWfq6sGDydKPbZFITTK3jiT4/iDkdedJsjm7o=;
        b=esdV5BQ4r4L3tV/+a4X/Hg/IJClVbMulTWngbvtSLw63tV/q9cGXJtEoePBx/FsuIG
         1LZyrhJ648Lx8WyqvqmNKT8WTNtYSSquUqZamfNbxCzBtitnXZsrH+ot7RQrzYuM/Ztk
         Po1xmTvOm9YoSb37e6icj1zauFX1dok9vu10U4ffwPGPB5Mc3IvUbGipKPbzQ4etmxtc
         JGE5f1WEoIkY/j7Mt8jvNzdzeUYVONVulodSGBxxhDeTeECo0nYTD2XQVxV0SAzkIcuo
         pWZoXa1LoQNrGTDZZUYYF7Zs+KKZg9BGXvDbp9bH6IRKoZd/J+RHhDIc9tYXRnq3aZxS
         BzqQ==
X-Gm-Message-State: ANoB5pmVr3SIJnsoEVqPSFw8GTqisLpR5aws/kU5VhmG2lq/j8kBPI1Z
        JuyLV0xrOHQX9JOlTGusv04qAZjyKlyFdme61MDMBZt3fVPXBg6P
X-Google-Smtp-Source: AA0mqf7lfWFWJ7HQjt63fCPqyMV612l4Un7POdQFqltpkiy2uJMGCk1DeDroDTwqtpkRM5QuRtRhDoMW1gT8m9bJiaQ=
X-Received: by 2002:a05:6902:128f:b0:6dd:329f:cf1 with SMTP id
 i15-20020a056902128f00b006dd329f0cf1mr16228786ybu.22.1669377215585; Fri, 25
 Nov 2022 03:53:35 -0800 (PST)
MIME-Version: 1.0
References: <CAC=wTOgOMCh7bBdiQMLPPKRUui53oQUKtBUim5LVZz3w9Aqp5w@mail.gmail.com>
In-Reply-To: <CAC=wTOgOMCh7bBdiQMLPPKRUui53oQUKtBUim5LVZz3w9Aqp5w@mail.gmail.com>
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Date:   Fri, 25 Nov 2022 11:53:24 +0000
Message-ID: <CAC=wTOg9jH=HctoPYZGCKZDck9bPdPA6w9h81h9RctLUVabxkg@mail.gmail.com>
Subject: Re: xdp/bpf application getting unexpected ENOTSOCK
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After more debugging, the reason turned out to be related to the level
of libxdp called out by the bpf-examples. 'master' level of libxdp
works; the first commit level of libxdp that works for me is
tjcw@tjcw-KVM:~/workspace/bpf-examples/lib/xdp-tools$ git bisect old
b572cd6b5a6462280db389b94586c2b5450887a9 is the first new commit
commit b572cd6b5a6462280db389b94586c2b5450887a9
Author: Magnus Karlsson <magnus.karlsson@intel.com>
Date:   Mon Sep 12 12:32:26 2022 +0000

    xsk: remove unused variable outstanding_tx

    Remove the unused variable outstanding_tx.

    Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

 lib/libxdp/xsk.c | 2 --
 1 file changed, 2 deletions(-)
tjcw@tjcw-KVM:~/workspace/bpf-examples/lib/xdp-tools$

I believe Toke is going to adjust the submodule level of libxdp that
is selected for bpf-examples to use.

On Thu, 24 Nov 2022 at 15:21, Chris Ward <tjcw01@gmail.com> wrote:
>
> The reason was a mismatch between the levels of libxdp and libbpf in
> use. To fix this it was necessary to add -fPIC to the CFLAGS when
> building libbpf. I have raised a PR
> https://github.com/libbpf/libbpf/pull/631 with the fix and a little
> more detail as to why I need it. Please review and merge.
>
> Chris Ward, IBM
