Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472EE4F5E1C
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 14:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiDFM1E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 08:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiDFM0I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 08:26:08 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AD12EC127
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 01:12:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bh17so2585960ejb.8
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 01:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z1zCEuKVxwMDFlzC9xHuWhUKv2m+zAqr+sHqUSpNkFI=;
        b=C7fY8Y3OaT9YlcX8gcLZX7uGAa5AxVIFGAP3lPfNLDkJ1rbIsxs6h9MbutjIaHV8AY
         IvsbSa199v7mv0NmmzgOukEIJQmzkCQBE/PE8FGIJERQRefUriYkW2Ice6ZXb7M5Jo10
         fabkku5EWQ/DY/gHNKdNO1MH/vrm5Fo3Q2TlMgVl9nNNHrEa29xKoAnyAqvW7Bbo0Ri/
         sda3yRkNQMUJryyAUla+4jTdfjx4GQF1WvLwxyo7mCDvLUwHOAuITS0VUc+XVHsuu1Vl
         BCjW1EVKtmS6DphkTs4wd41Ui6PErE+7h0Mufn2DOQyRAG2nBkhQJeScjMccpnItXpFJ
         sXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z1zCEuKVxwMDFlzC9xHuWhUKv2m+zAqr+sHqUSpNkFI=;
        b=7Hwc5Vo9Tw7CDvLav+ECVn3yc7yO3uyaKGf0sbBGWELg8d3CYMYZ/0QdI2h4D9TtMO
         KH8WGm6lTZzqGKg+nM1Us4CwZZCgq72PXCtny95uQ8fN5Bx3uTajQauE3RdBYagEFlhZ
         dzFc8utbDVVN3E0ufF+BTqWdAIF8Bpi/+gbHlzR1As0ZJnj//JUor2zE5YR8Ue37+9Au
         CrcMCjdT7caSdVwb/ZJCCqNUTf4GBH+45XRqr4Uv47q4rsZu2EOJE2FhWEPbkaL0Wble
         nF1Ik+LFzm3/KFdvyYyyJEWSu6P1sD8W8DqSQjfBPpJEIZA+mU30RtcAf1/DMro46pT4
         6pFw==
X-Gm-Message-State: AOAM532MZK/j0E1gt+qZM/RFSl31KJuNgI63CILxh0SSw3o4aaFBsRAr
        DERrKn2zb++/UhaybBo1AT8=
X-Google-Smtp-Source: ABdhPJwK1/UAHiuuyG7dbqaRTks2Sz3jfV75Fp9fLsfDL4kPVAXdj0vztQTCi04sXfo1WhJDztOanw==
X-Received: by 2002:a17:907:7d91:b0:6d7:a1e:a47a with SMTP id oz17-20020a1709077d9100b006d70a1ea47amr7462308ejc.116.1649232736120;
        Wed, 06 Apr 2022 01:12:16 -0700 (PDT)
Received: from ddolgov.remote.csb (dslb-094-222-030-091.094.222.pools.vodafone-ip.de. [94.222.30.91])
        by smtp.gmail.com with ESMTPSA id m20-20020a170906235400b006e718d8b849sm4438929eja.45.2022.04.06.01.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 01:12:15 -0700 (PDT)
Date:   Wed, 6 Apr 2022 10:12:14 +0200
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>
Subject: Re: [RFC PATCH bpf-next 0/2] Priorities for bpf progs attached to
 the same tracepoint
Message-ID: <20220406081214.tifvpmjvq45jyl3l@ddolgov.remote.csb>
References: <20220403160718.13730-1-9erthalion6@gmail.com>
 <CAEf4BzZ7=AfL5fAU8aYT20RWY9tG5qU+Fgv-JC0GTLpGOGgAEg@mail.gmail.com>
 <20220404152953.6uu3sgqepo724yiu@ddolgov.remote.csb>
 <20220405172017.o3qi7v7edth2s7tr@MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405172017.o3qi7v7edth2s7tr@MacBook-Pro.local>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Tue, Apr 05, 2022 at 10:20:17AM -0700, Alexei Starovoitov wrote:
> > The immediate trigger for this idea was inconvenience we faced, trying
> > to instrument one bpf prog with another. I guess the best practice in
> > such case would be to attach to fentry/fexit of the target bpf prog,
>
> yes. that's a recommended way.
>
> > but
> > from what I understand in this case there is no way to get information
> > about tracepoint arguments the target prog has received.
>
> Not quite. fentry/fexit have access to the arguments of instrumented bpf prog.
> See fexit_bpf2bpf.c
> In case of tracepoint the fentry prog will see the same 'ctx' pointer as
> bpf prog attached to a tp.

Thanks for the clarification, I'll take a look at it.
