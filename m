Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88788652817
	for <lists+bpf@lfdr.de>; Tue, 20 Dec 2022 21:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiLTU5M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Dec 2022 15:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiLTU5L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Dec 2022 15:57:11 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011605592;
        Tue, 20 Dec 2022 12:57:10 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id g4so14342912ybg.7;
        Tue, 20 Dec 2022 12:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bUkn03iwM/nNfBCO+iGhWq6ef/XnNK5n+DQxFEfmg3g=;
        b=HMrJVAURj/rsdlW5EYw0Kka6zvfRvUHL6Bh1iT+lwRudv3WA/aeO00tqxZQ5C9lnt1
         arSIwF6sddJefqQIcHozAbqw026BRur0+sjOKXd6t5PKhzKMLLsKSjuw6NImtt1ly+XO
         9avgWxe6SSiSF6zF1BimkVkn4S/zYtLKKPrQIwT+mx56Bi1A2HTzU6Mx9bjnqSzl1adc
         AxIIjyneum9YihYcEewXloCn1yPn15SXNOgm3K7GBLPif9EOshHud2tZVTfvA8SSYhKu
         MHAi0MSM97d1BnnpXw7Ak34ZeLDBYawWndqnsKUgkz68qDxk0f+lcoQO6cSsJQGjGyg8
         y6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUkn03iwM/nNfBCO+iGhWq6ef/XnNK5n+DQxFEfmg3g=;
        b=CTXdru1+MFBRlMCnUAu/bwaYOUYnur5mpc8rJN0+Gqd2X/9lIol5JKVfKmP88Z5B71
         uzS6oaVJSa0VVMo6F71bTc9P22+t2419foHG0wiVHQwCqoUewaVlphmkdIbLvoqwyTfx
         8jwB4jyqurfsd7J6GcZTw6RqFjX69UeT97OGiIoLo4nVjGsOfI8MnYV1mdMQsP5kf3Gk
         21m5c2/WjZnDrM6d3vNZqw6SHL1z7mbW/rST2EwL4upi0qKpdftZdUo37b19AMJortR5
         Pb20jHwFqHzER6c12/MJ/2ha3o2k1T6mFD5g5ciM1feWMOWCkZZyplmlVFN9H7DlFt+m
         W76w==
X-Gm-Message-State: ANoB5pnf0m1ERwXY6S4He5msYi2XwagtMuZ9v94OqJolGaoMSCeRLXbS
        Wbyu1AvT06zhO/yHLPbj90txh6kKihimHMyttY0=
X-Google-Smtp-Source: AA0mqf7NiomawAAVH+m2N0U7QfOzQCfIhUZlWwQyWWXJ8IzEkRD0wgEp7e54dEl6U8TCA5PescpyZT/RMTi2gOOBFxQ=
X-Received: by 2002:a25:3483:0:b0:71f:d74e:f3f with SMTP id
 b125-20020a253483000000b0071fd74e0f3fmr5257423yba.75.1671569830191; Tue, 20
 Dec 2022 12:57:10 -0800 (PST)
MIME-Version: 1.0
References: <20221220203901.1333304-1-yakoyoku@gmail.com>
In-Reply-To: <20221220203901.1333304-1-yakoyoku@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 20 Dec 2022 21:56:59 +0100
Message-ID: <CANiq72mUOOeHgN8wM4d2Kf_XEEVCZNSOa5qxt08crPYV1TCQ-w@mail.gmail.com>
Subject: Re: [PATCH bpf] scripts: Exclude Rust CUs with pahole
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Eric Curtin <ecurtin@redhat.com>, Neal Gompa <neal@gompa.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
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

On Tue, Dec 20, 2022 at 9:39 PM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> Version 1.24 of pahole has the capability to exclude compilation units
> (CUs) of specific languages. Rust, as of writing, is not currently
> supported by pahole and if it's used with a build that has BTF debugging
> enabled it results in malformed kernel and module binaries (see
> Rust-for-Linux/linux#735). So it's better for pahole to exclude Rust
> CUs until support for it arrives.

Cc'ing Arnaldo explicitly since he added `--lang_exclude` support for
this (thanks again!).

Cheers,
Miguel
