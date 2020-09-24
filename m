Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6801276B74
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 10:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgIXIHf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 04:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgIXIHf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 04:07:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0814BC0613CE;
        Thu, 24 Sep 2020 01:07:35 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d13so1431329pgl.6;
        Thu, 24 Sep 2020 01:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SREJUM/2T/IFvbNUgYQe7MPC6WtRuEMBlyz8JPh0RI8=;
        b=Mnc+BC6FoAz03iKMGZfNCLiJ0hcECAQItB8p3zC7NQkU7aOIjVnu4MQQApiKu8VkdD
         IIbfAI5fACDSFTmNXSY2BP5jYZTYoh+H7Nufn+A/Eyf9JUSMarPYRHf0WfKR6PV9VVKx
         4eVOTx0SJ6tbgYYR8LShT3V6LZo3FywyOvm6gyFSVnHQXucycp1xLdlmQpVE+xxeTpDI
         Vn4OIg5eRiA6sxRTLhmf2rbLQeB8aQS/1mJhff2kWLWxUhDHJToSjCqq8EMjfoFMr/cA
         pRF9+pdALsdYgc/ACOpNS3ZybtsRlnTTs9QRWEoaTCYfEbpqMxB6oCMFuSCQzDotR+Pr
         kI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SREJUM/2T/IFvbNUgYQe7MPC6WtRuEMBlyz8JPh0RI8=;
        b=j3wIq+qnpYM8by/JtOKPSyhKc1TRSu01Cp+cNwddGj6//d6wa/OOou+Lf6IKNNLePl
         e8yni2BcQKbVqn9QM2b4fuOcBqsZtqz56gQpATWvwPrtYz0qzvy5uIG2OBkWXuLxbk6R
         V4YcPqvVYa39fUpUDUQpoiblrFrDY3sS9nsqmbtYHyPGbOQwfQDE0n1qAvm/suv1RmN4
         MFcCJzhfa/8puIoESxnX0PSParb280qLp2AoJirTZsoreNfANkZa3F7ki0hzl4GMTTrt
         Nr/59jMzu/HzoDKGlpLmA9F26m3zilQpEHX4z7tvnSDGsA8++8+gMfelKYqSUZ6bCHlk
         Hy/g==
X-Gm-Message-State: AOAM5330m5V2jgRJd0w6ncOlU9+p+8jbVCI8+bXyLAk4r71eJil6s1Qa
        0/6xtJYpe7IVkGIRhvhfnDSDrmaPnJGPSINTucQ=
X-Google-Smtp-Source: ABdhPJzZ3GxH/oMcyPcHsQNCDSKN+Hop/BoyiHOBELjZoiXsEPwNcDL/lPsrx3FEqSA+3lQeJ3rj/jYXD7zR6Yfvz7k=
X-Received: by 2002:aa7:8645:0:b029:13c:de96:6fde with SMTP id
 a5-20020aa786450000b029013cde966fdemr3426229pfo.14.1600934854466; Thu, 24 Sep
 2020 01:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-4-keescook@chromium.org> <CAG48ez0d80fOSTyn5QbH33WPz5UkzJJOo+V8of7YMR8pVQxumw@mail.gmail.com>
 <202009240018.A4D8274F@keescook>
In-Reply-To: <202009240018.A4D8274F@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 24 Sep 2020 03:07:23 -0500
Message-ID: <CABqSeARV4prXOWf9qOBnm5Mm_aAdjwquqFFLQSuL0EegqeWEkA@mail.gmail.com>
Subject: Re: [PATCH 3/6] seccomp: Implement constant action bitmaps
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Valentin Rothberg <vrothber@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 2:37 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > This belongs over into patch 1.
>
> Thanks! I was rushing to get this posted so YiFei Zhu wouldn't spend
> time fighting with arch and Kconfig stuff. :) I'll clean this (and the
> other random cruft) up.

Wait, what? I'm sorry. We have already begun fixing the mentioned
issues (mostly the split bitmaps for different arches). Although yes
it's nice to have another implementation to refer to so we get the
best of both worlds (and yes I'm already copying some of the code I
think are better here over there), don't you think it's not nice to
say "Hey I've worked on this in June, it needed rework but I didn't
send the newer version. Now you sent yours so I'll rush mine so your
work is redundant."?

That said, I do think this should be configurable. Users would be free
to experiment with the bitmap on or off, just like users may turn
seccomp off entirely. A choice also allows users to select different
implementations, a few whom I work with have ideas on how to
accelerate / cache argument dependent syscalls, for example.

YiFei Zhu
