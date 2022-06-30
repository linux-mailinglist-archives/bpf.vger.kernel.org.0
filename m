Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275DE562144
	for <lists+bpf@lfdr.de>; Thu, 30 Jun 2022 19:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbiF3R3h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jun 2022 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiF3R3g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jun 2022 13:29:36 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E6E6546
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 10:29:35 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id u7so202513qvm.4
        for <bpf@vger.kernel.org>; Thu, 30 Jun 2022 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCX5AD+7BPxtXcbN0QsHx8k2HDJqPhSW6e8Dkm8vJ28=;
        b=MJewVVvjOw1xWcjvdBjjK3eiNoaHuTXKrkDWracYAYkWsIoZPR1a18yYXDuhJLkJRE
         pUsiSa3jbcO4K6QYP//ygxum92rYucuMIOZ7jhlLMlV8SrqJmSP2d2k+ufD2redlIjz2
         V2F0uFzVsxYot4oMShApOhtTRQerGNfjKY6Su1c+5gWx4BHUK/pj69qucEqHw2nzdOA9
         J9+Soq8rMKJKExCBUa/oh0wmJPpav4I1yHIImahcxDedSZWSZRL9TIthrnja6ThO8uf3
         EA3UqYWERtuPCbzMwkgMigsLN/kGLqG/AFM8XfKYX8TrG2WEaYrm/Feg3c+h4alrzxGl
         JcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCX5AD+7BPxtXcbN0QsHx8k2HDJqPhSW6e8Dkm8vJ28=;
        b=FYuTpQT0wEYIoGjIVDKMuUR99dC/2F396PNzxhORLNFDFEJGBF9pId3QnN2PnC2QUj
         JqWVQWSqMKjG/Kqu3P9/tcg2aQhmGzOws47ZM3jnlFICwGMjRpkYdMX6C50PoaieY7K3
         HxsOytKz/hwkbMzVYoYUyGtqkPAuttR5lYozl4vAVQ4sSNnbXjq1LTw6Pvrn73Yqj9GN
         CvYQgEumpP2SXhx/C15/etvv9rpr1nULfaK5KWk7ds+gSdInn3+4fIE0OT2SSjrEkeHN
         232bX/hqVWnfBgywBW1xHllcY87rT0u0WbLIR/jufbH8VlgJXIMFV5QWO7U2CTW6MCI8
         A4mw==
X-Gm-Message-State: AJIora9yScVVdiUSaJq9/LI4+ilLMJG8XSVcf/fUV88A8mha/7qOI7Fc
        C0H9hdJd8p+V888+dQwUFx69bagT3pdejw/lHiWObaWidSw=
X-Google-Smtp-Source: AGRyM1ut7FNF3yjPGSia1qjwS1WzEHpreTB4zMZVlsJO3aX1E/mAy3briGTeAoi+vXt1cLn33oyzJ8C9YC+8zWXgKek=
X-Received: by 2002:a05:622a:1d2:b0:31d:2987:4c29 with SMTP id
 t18-20020a05622a01d200b0031d29874c29mr6586550qtw.565.1656610174344; Thu, 30
 Jun 2022 10:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <aa98e9e1a7f440779d509046021d0c1c@huawei.com>
In-Reply-To: <aa98e9e1a7f440779d509046021d0c1c@huawei.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 30 Jun 2022 10:29:23 -0700
Message-ID: <CA+khW7i39MXy4aTFCGeu+85Shyd47A+0w5EAA5qL7v+n4S74dA@mail.gmail.com>
Subject: Re: libbfd feature autodetection
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Roberto,

On Thu, Jun 30, 2022 at 6:55 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> Hi everyone
>
> I'm testing a modified version of bpftool with the CI.
>
> Unfortunately, it does not work due to autodetection
> of libbfd in the build environment, but not in the virtual
> machine that actually executes the tests.
>
> What the proper solution should be?

Can you elaborate by not working? do you mean bpftool doesn't build?
or bpftool builds, but doesn't behave as you expect when it runs. On
my side, when I built bpftool, libbfd was not detected, but I can
still bpftool successfully.

Hao
