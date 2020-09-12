Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B570267A35
	for <lists+bpf@lfdr.de>; Sat, 12 Sep 2020 14:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgILMNs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Sep 2020 08:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgILMNq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Sep 2020 08:13:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13787C061573;
        Sat, 12 Sep 2020 05:13:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w7so9153201pfi.4;
        Sat, 12 Sep 2020 05:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6iamJ+CPgTGx0IN+LNnGj7Oz2Z9AmP/boJFOuQdvGTs=;
        b=h4hVTG1Jc9FKA3P9PQh72bfuOtSJ5tMVuVEBO+E/Ng83VD9L8i4VQSpCB4NOGFiDnY
         bsAFxqvlhPUpEszLUGtkUtIsN4Z/Xo+AM13oCu1UAqcaFcSZeMapCDvO3+kr64+nHUCW
         8DoXDuyY4+NR2y4gQOWOxAstAmRVJoY9Yc35jwZmyaT4eJUt8pHsnqoooVqNneHv5/Ci
         2iarWAZtvlXzDSENIgYpVxlXU/b3nAlmMB56ZwFytEtTXDzLLM/KoakWE4usY5sNxcH8
         4vDg3zBEbNze/Rhj+xrmbO27ppt9RKYQTj625n8HzBdDBCv+qFrllG0L2L4fbVvgzwrk
         mxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6iamJ+CPgTGx0IN+LNnGj7Oz2Z9AmP/boJFOuQdvGTs=;
        b=CNK3bYSEduTKRo+oiB+9phNX9kx101FpilroHbioMDRA2QFO2xXP46H3dCUqsdwq5v
         ABEQrR61yvu2ANIZV6r8GGRTjQhJn+QrBAZ+ZjET6CA9ayt0ptAY1IyMMwhA5Uqfixeh
         GoRYLa2fXM6gYgIUuRulkXwNrGmsQVypNlNdgq22o22VebtkIWinkdzDYtAzlsvDeiVC
         OYciMvKbUZycPEofL07lqeyvFI+fcZkdjOZbaeDsbDTA7cJvn7+IYDS0acHrIIlPzddi
         jqDETWurSM5MOYANMEgUawZcrweN5ZcjzA03thV2fD66V4m/Tg2q/Ro0GMtRqI7GvEj1
         zgXg==
X-Gm-Message-State: AOAM532OlsmBVm+9QTtsTQJjpyE29am8ncYeHwL1raqmWDfCf9f4PAci
        G2fsRYVY6NzCiUGaaGiPUfSwu3eRBQq0hJZgyhM=
X-Google-Smtp-Source: ABdhPJymUo09GQ6iiOIob0IVg8nEmABEr8waE5YJ5uissFILanil7KQJ/bM/eReDSiy1OldlpfW6LA==
X-Received: by 2002:a63:5703:: with SMTP id l3mr4738826pgb.329.1599912824758;
        Sat, 12 Sep 2020 05:13:44 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.202.95])
        by smtp.gmail.com with ESMTPSA id 203sm5043839pfz.131.2020.09.12.05.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2020 05:13:44 -0700 (PDT)
Subject: Re: [PATCH] Using a pointer and kzalloc in place of a struct directly
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org
References: <000000000000c82fe505aef233c6@google.com>
 <20200912113804.6465-1-anant.thazhemadam@gmail.com>
 <20200912114706.GA171774@kroah.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <09477eb1-bbeb-74e8-eba9-d72cce6104db@gmail.com>
Date:   Sat, 12 Sep 2020 17:43:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200912114706.GA171774@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 12/09/20 5:17 pm, Greg KH wrote:
> Note, your "To:" line seemed corrupted, and why not cc: the bpf mailing
> list as well?
Oh, I'm sorry about that. I pulled the emails of all the people to whom
this mail was sent off from the header in lkml mail, and just cc-ed
everyone.

> You leaked memory :(
>
> Did you test this patch?  Where do you free this memory, I don't see
> that happening anywhere in this patch, did I miss it?

Yes, I did test this patch, which didn't seem to trigger any issues.
It surprised me so much, that I ended up sending it in, to have
it checked out.

I wasn't sure where exactly the memory allocated here was
supposed to be freed (might be why the current implementation
isn't exactly using kzalloc). I forgot to mention it in the initial mail,
and I was hoping that someone would point me in the right direction
(if this approach was actually going to be considered, that is, which in
retrospect I now feel might not be the best thing)

> And odds are this change will slow things down, right?  Why make this
> change, what's wrong with the structure being on the stack?

For more clarity, I'm not exactly pushing for this patch to get accepted,
as much as I'm trying to understand what exactly is going on, and maybe
even understand syzbot's working a little better in the process.

At the time when I did send in this patch, the error seemed to be
present as far as syzbot was concerned. (I had sent in a test request not
too long before I sent this in, which returned a positive).
I just wanted to know, in the off-chance that the commit fix that was
pointed out wasn't merged in the tree yet when syzbot tested it, why
exactly would a patch like this lead to no issues getting triggered?
(I understand that if the fix was in the tree when syzbot ran the next test,
this patch immediately is rendered obsolete, ofcourse)

It felt somewhat a bit like an anomaly to me, and I figured it might be
worth investigating, is all; and I'd either infer something about syzbot,
or about whatever just happened there.

Now that I say it out loud, I realize it might sound a little silly, but
then again, I had tested the 'validity' of the bug, not too long before I
sent in the patch for syzbot to test too, and it seemed to be present when I did.

Thanks,
Anant


