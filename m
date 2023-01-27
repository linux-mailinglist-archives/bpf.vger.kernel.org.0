Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F1767DADE
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 01:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjA0Amf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 19:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjA0Amf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 19:42:35 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF32044BD8
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 16:42:32 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id nm12-20020a17090b19cc00b0022c2155cc0bso3386897pjb.4
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 16:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WkV0Vj5dyxiXPVTEWhcP56A0XGHS6/cRcRvlImxyCM8=;
        b=cVzQ3DnJuG5egUNgyr5cNUdjRq2nnY1di5WxyHWlY5UnpIhax9608gS5tBOgS40fNo
         vSsRVYi+Xuv8aSWQto/IzvJVI9JagHFKwoGQ/ATo3SvTsiTv27NAoQ+iHnVxwkz1rFSt
         JULbuSbrsVScfH9CUlb1F/mWZWRj99sk8FvkFkwNZXfbTp/CRMG4+CsBKiRnd5eP8z5J
         OSMyoBd3HQABBGDz4ZCtgWxEfoj5G9H0IIRfP6kTqB6TXrW9gIYhzBr+QHr9lhVzA2Xv
         EZylzRKV/X7K8F2TCXa+/fKZGf1t6m80bEuY6jp38opdOAh84Q4PKxM6mU4E1pEWbqj2
         a61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WkV0Vj5dyxiXPVTEWhcP56A0XGHS6/cRcRvlImxyCM8=;
        b=BT3CTyR3+fl3u851jcIXPVW6nkR2Ec8whPhE9jpKrI2TfPRKEYJBsPjTOG4FmXCc0n
         4mwifEWiMvv3v4f9/GDjrtDTtqELEDlKd9rGEu12RTk2I9eYd2+bP82g7s8PykKaP8Xi
         2UzNjda7IVr+3q42ZSWWbJNSE2srC26ZCmF805HsY0scYrA5cLJP56WNLlBqod4gXW/6
         MpN5jYLjtTRL0Lx2YY/pnRXBLsvn7lUvC+Shj0te9XNP607HzgrYp1CT9KZ/lSMd3Z3g
         JIwiWENShlUh2z/L1xV02iZoWh3n8mNadM4nFWt4JdBir/aXwU5qGwASwyvuEEqxMZ5y
         08zQ==
X-Gm-Message-State: AO0yUKU4Pry5LncHY7SZeSqGHS06BUmAGTUnWS4ma6TWtakbeWcfzYQQ
        4jG6AhLZ9RSH4oHu1PUebG4aDf7lw5YV2Lhxzhxemc9sHkKXOiw9O1I=
X-Google-Smtp-Source: AK7set9V+VEJizSvvv25OfgSHSRfMMFCwL/7AzrPTmck8hyO7NQ0JdLJchs4/78eCaFGwok5S64Q5s5a9uzDqsOhdx0=
X-Received: by 2002:a17:90b:e97:b0:22b:f337:ce9b with SMTP id
 fv23-20020a17090b0e9700b0022bf337ce9bmr2000377pjb.6.1674780152062; Thu, 26
 Jan 2023 16:42:32 -0800 (PST)
MIME-Version: 1.0
References: <Y9LQVU2uz9SzYARP@maniforge>
In-Reply-To: <Y9LQVU2uz9SzYARP@maniforge>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 26 Jan 2023 16:42:20 -0800
Message-ID: <CA+khW7iLVbK-QSgfR6OwUb_Hzs__=qsH6ho8gKf2vVqkp6Z9LQ@mail.gmail.com>
Subject: Re: Mapping local-storage maps into user space
To:     David Vernet <void@manifault.com>
Cc:     lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 26, 2023 at 11:11 AM David Vernet <void@manifault.com> wrote:
>
> Hi everyone,
>
> Another proposal from me for LSF/MM/BPF, and the last one for the time
> being. I'd like to discuss enabling local-storage maps (e.g.
> BPF_MAP_TYPE_TASK_STORAGE and BPF_MAP_TYPE_CGRP_STORAGE) to be r/o
> mapped directly into user space. This would allow for quick lookups of
> per-object state from user space, similar to how we allow it for
> BPF_MAP_TYPE_ARRAY, without having to do something like either of the
> following:
>
> - Allocating a statically sized BPF_MAP_TYPE_ARRAY which is >= the # of
>   possible local-storage elements, which is likely wasteful in terms of
>   memory, and which isn't easy to iterate over.
>
> - Use something like https://docs.kernel.org/bpf/bpf_iterators.html to
>   iterate over tasks or cgroups, and collect information for each which
>   is then dumped to user space. This would probably work, but it's not
>   terribly performant in that it requires copying memory, trapping into
>   the kernel, and full iteration even when it's only necessary to look
>   up e.g. a single element.
>
> Designing and implementing this would be pretty non-trivial. We'd have
> to probably do a few things:
>
> 1. Write an allocator that dynamically allocates statically sized
>    local-storage entries for local-storage maps, and populates them into
>    pages which are mapped into user space.
>
> 2. Come up with some idr-like mechanism for mapping a local-storage
>    object to an index into the mapping. For example, mapping a task with
>    global pid 12345 to BPF_MAP_TYPE_TASK_STORAGE index 5, and providing
>    ergonomic and safe ways to update these entries in the kernel and
>    communicate them to user space.
>
> 3. Related to point 1 above, come up with some way to dynamically extend
>    the user space mapping as more local-storage elements are added. We
>    could potentially reserve a statically sized VA range and map all
>    unused VA pages to the zero page, or instead possibly just leave them
>    unmapped until they're actually needed.
>
> There are a lot of open questions, but I think it could be very useful
> if we can make it work. Let me know what you all think.
>

Hi David,

I remember, I had a similar idea and played with it last year. I don't
recall why I needed that feature back then, probably looking for ways
to pass per-task information from userspace and read it from within
BPF. I sent an RFC to the mailing list [1]. You could take a look, see
whether it is of help to you.

[1] https://www.spinics.net/lists/bpf/msg57565.html
