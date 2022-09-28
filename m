Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D8D5EE977
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 00:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiI1Wfh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 18:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiI1WfM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 18:35:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3870F1130
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 15:34:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a41so19105337edf.4
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FKJSO/OSzfuxQUUgkmV0K+4CoUysa1EllTSDXKQ0pI8=;
        b=azpvHj1iPgbvo35X3taqEkDFdVJXxiTGGmFgXNd69VVuoxluZ4WcxIKJGYhPg8SULT
         zdDfQG3/f8PJr54sXXACwxyi3yFZJL8cwftg6xEXfrbaz4w85HKUJguv5m0v5ZARXLYv
         swV+22+AfCM5CWHdFJMQ3ClR17AkHaWOU+yyqRW+SYG/vb8Lqgle3GpmdXmO4VjtB5cL
         MmhJHEYCIFa8WFRW6/KiIADxlS3vAvwhTBX+kUUlluLfCbkAT21+Yu9+ZV1JKoTpIE8P
         GYJ3Bw9IiTMJ7TLp/botXB8XaAqQ8/vW9ee5woUatd/9xnEO8aszqGH/O769B2MtjUME
         ZY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FKJSO/OSzfuxQUUgkmV0K+4CoUysa1EllTSDXKQ0pI8=;
        b=4sDEpflwgWJjIwcvy7QtoVEughczagFCdA85tE9OIRrXhTMs1b+bgne637CDT6OVLJ
         3lLraqcbIHZ3gxMvZi1lRULqiMSUtuwZw/r3UXVda3GS+KRLkRijtrMSiCwOGoCAdFJn
         eOgDI1CtVprajSlouKwOPwwJxUpXYt0Mdrr8gK05ceNcKxOjnRArtp3Z9DB/qmlaAqK5
         XUbRYa0017JVjPqfeTkBuBL+sSq3YBDdHFMdcsPZ+eKv5q3XVo4Ijl8yF8Ha+HGEr+bi
         AbGirDNfLJiYqE9f4Sh3z4Na9sYmWhY/ebbMvvhyhX0qxclPeKJBumzOo9GHwHuvn08O
         nFSQ==
X-Gm-Message-State: ACrzQf3a9ohyjpUvhGdp01iHYCI4I09iJhXBvkI0mOiBWzDfisNHenGO
        ctqaHz+r40P37JWIvLVecOKm8GOUdrAo5yRvR7U=
X-Google-Smtp-Source: AMsMyM5gSlD1wEBc0dL6NwyzuVCCc+KWiHY2teZP0EAbKZa64GcsaVTxnrhze53JG/3hrGRUBI3MIY10MtPSTiqdmcM=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr232001edb.333.1664404472648; Wed, 28
 Sep 2022 15:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
 <20220908000254.3079129-6-joannelkoong@gmail.com> <20220909194138.46aea4cb@blondie>
 <CAJnrk1a53F=LLaU+gdmXGcZBBeUR-anALT3iO6pyHKiZpD0cNw@mail.gmail.com> <20220910083118.6591eca8@blondie>
In-Reply-To: <20220910083118.6591eca8@blondie>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 28 Sep 2022 15:34:20 -0700
Message-ID: <CAEf4BzYgitMQQ-Oij3-0XPjFrr+4XpF-JysDr4YYhyeQ3N0rqg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] bpf: Add bpf_dynptr_clone
To:     Shmulik Ladkani <shmulik.ladkani@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org, andrii@kernel.org,
        ast@kernel.org, Kernel-team@fb.com,
        Eyal Birger <eyal.birger@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 9, 2022 at 10:31 PM Shmulik Ladkani
<shmulik.ladkani@gmail.com> wrote:
>
> On Fri, 9 Sep 2022 15:18:57 -0700 Joanne Koong <joannelkoong@gmail.com> wrote:
>
> > I like the idea, where 'off' is an offset from ptr's offset and 'len'
> > is the number of bytes to trim.
>
> Actually parameters better be 'from' (inclusive) and 'to' (exclusive),
> similar to slicing in most languages. Specifying a negative 'to' provides
> the trimming functionality.

If we do [from, to) then user will have to make sure that they always
provide correct to, which might be quite cumbersome (you'll be calling
bpf_dynptr_get_size() - 1). Ideally this adjustment is optional, so
that user can pass 0, 0 and create exact copy.

So in that regard off_inc and sz_dec (just like I proposed for
internal bpf_dynptr_adjust()) makes most sense, but to be honest it's
quite confusing as they have "opposite directions". So it feels like
just simple bpf_dynptr_clone() followed by bpf_dynptr_{trim/advance}
might be best in terms of principle of least surprise in UAPI design.

>
> > Btw, I will be traveling for the next ~6 weeks and won't have access
> > to a computer, so v2 will be sometime after that.
>
> Enjoy
