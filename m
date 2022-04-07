Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E254F7F65
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 14:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245381AbiDGMq6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 08:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245371AbiDGMq6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 08:46:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF7649697
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 05:44:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a6so10709007ejk.0
        for <bpf@vger.kernel.org>; Thu, 07 Apr 2022 05:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPu64UFDS7rCgjRK5dJIvJ6VGwJJ/QBnC7xrns1rVnk=;
        b=O7K+6Gr88mO60uH8Lyjnzm3nmcrz7F/35637Mx5VTct4zeS2qtrGSB/Ykr3r7zxnGd
         oEDbB3KgzTuqFN4mJNMPtQPeUjAwI3IzZNZ4KdLEZIjtPlc6JsHnmCJX3ogcHXvDjrLy
         gFLiJW+XVXuLpOIPixExr3PdgWVQnrGSKECqJycvXphrecSG4ZNeH4mAszx/vAW4LCyy
         aWi0xo/51pu2WWRK7Hor5AzJHoX+SbNCQETE/qaO70PA/LSN4tKuYWFBsp9wU+9UUHQk
         LvXN2W8IUGW7HKOwpoKk9DUm8ilXW+ALuPqUpMBUwu5XBrX+XuD+1ISqVKz0zruTYFxq
         8PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPu64UFDS7rCgjRK5dJIvJ6VGwJJ/QBnC7xrns1rVnk=;
        b=sBLgaSePT4LnhmxJvZW2UtuQLDMKs8Yzpj+EtYYXW5n7sglT0qeA3+3VUBnPq6iEQU
         VkIUSnazXh0+GqZA3LEWzO30OA3ZmKTCRDE1PCdMKxi+wX5g/KOrdi1KnQe9IOSLrOV5
         sFeBlZKDzh5FIuniixIpz8Hx32W91DjrEbI/lDMnI85LgfCxfUHDWkjODvI0VW6FFQtp
         WFsNZz1kEdJ7W8lwE1kouQSTh9KMt8DFrL6FjFUs1L6gHBumqxYVLHnJNmZGKlFVW/04
         PdM5sp2PjOjj1lRvWaDDUl1LS0IN0I/OTkLEKjTeFhRqsCZ3ZuWYdkZYbc27lbBVcseZ
         AACw==
X-Gm-Message-State: AOAM531ch+ET/GntV80fLy7olb5yXKE7Yd2anavd8zuh/7yrTXSqXcoh
        LlM2JN42PKWPYhZ2SMXi8LfeIoMzBJmlajgoQpUJMA==
X-Google-Smtp-Source: ABdhPJwuVd1b+36VpT3Y8PVZzoSl/JHbt5w3NL3Ky0D54Wotso1F0kelHwEuqYc7Lw4NGN+4LbFaDIENNgHH0KT84yw=
X-Received: by 2002:a17:907:d20:b0:6e8:4090:b9db with SMTP id
 gn32-20020a1709070d2000b006e84090b9dbmr1165258ejc.480.1649335496394; Thu, 07
 Apr 2022 05:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <CAEf4BzbfFtgebrWOyfOP71Cn6ZAYXGfjLDPDNmyhzTJ3uTPFpQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbfFtgebrWOyfOP71Cn6ZAYXGfjLDPDNmyhzTJ3uTPFpQ@mail.gmail.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Thu, 7 Apr 2022 14:44:45 +0200
Message-ID: <CA+i-1C1wjFcH5OMGVWt4+nB4hoSp_aVU=mv3LPtLq-5Ua-dggw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/7] Dynamic pointers
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, KP Singh <kpsingh@kernel.org>,
        Florent Revest <revest@chromium.org>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>
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

On Thu, 7 Apr 2022 at 01:13, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 1, 2022 at 6:59 PM Joanne Koong <joannekoong@fb.com> wrote:
> >
> > From: Joanne Koong <joannelkoong@gmail.com>
> KP, Florent, Brendan,
>
> You always wanted a way to work with runtime-sized BPF ringbuf samples
> without extra copies. This is the way we can finally do this with good
> usability and simplicity. Please take a look and provide feedback.
> Thanks!

Thanks folks, this looks very cool. Please excuse my ignorance, one
thing that isn't clear to me is does this work for user memory? Or
would we need bpf_copy_from_user_dynptr to avoid an extra copy?
