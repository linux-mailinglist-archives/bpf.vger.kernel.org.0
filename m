Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82CF312E7C
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 11:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhBHKCa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 05:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbhBHJ6S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 04:58:18 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0827C061756
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 01:50:47 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id f2so16136960ljp.11
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 01:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1R3u99eAXzq3hCZwph3dHOjT49WyFeiAnj/A60zx7J4=;
        b=MrHeG5VSushPEY7hFY9lwYEqeH0XuCtJXjLxFRW4OrFT1Td/etsHJmTM3gae2Fdkbd
         e57do5spRjHabODOvF/VNkF7DWMXCmU66u3AarfBOLz8dsdmoJdIXedB/HI/VEP9spM+
         pyYo0vsC4LpZcupMyuWLQmXeiTOjJ6Gis4MQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1R3u99eAXzq3hCZwph3dHOjT49WyFeiAnj/A60zx7J4=;
        b=N3dZuKnDyaO3tPXXTlgRCUPkbvwQYtF0ZAkToKbEFxgYBNl7Tf1033mtJx766o3aTQ
         UsP0g1v82Kyojl5cVuNxRcgd429htxSS6uV7lIXRP92Pnb4R/QJsaRm0+uZmpfiI2FGM
         lXKxymYfQDgFEIZ+WRk7K7OsLo4ot4c7plLiGqJrRczRtcY3ecPgi6eWOH+DQNl/j88H
         wK4ZTcXtka+5vA6xPe4JfsVCbsQck1l7p7xqo2BrjEgqsIIVFIjiyWAkmEzuur5IuwOu
         mFHM0gHgOiheGYqgzB5BYoL1s/ex7e9+GzpZIspwXoYOUuTEvLDB0ECoWawcEAXwfcLE
         pWUw==
X-Gm-Message-State: AOAM530nDoPDG/u9WCtdsHirvgSv4mW5iwdGIqAbZSodhT1K7izeBmS2
        qF/r09Dea2ZOnXSg1z8q77MqkNDLypjR1lJhoY5Cig==
X-Google-Smtp-Source: ABdhPJz2v60aah7dRFCowQfuEvM2wteLeonK74zrHdb89NE9ICp/3L616DGyFYiXiWS7vnlrLdafRMIN754A6Jt4hsg=
X-Received: by 2002:a2e:91d6:: with SMTP id u22mr5337718ljg.223.1612777846324;
 Mon, 08 Feb 2021 01:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20210203041636.38555-1-xiyou.wangcong@gmail.com>
 <20210203041636.38555-2-xiyou.wangcong@gmail.com> <6020f4793d9b5_cc86820866@john-XPS-13-9370.notmuch>
In-Reply-To: <6020f4793d9b5_cc86820866@john-XPS-13-9370.notmuch>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 8 Feb 2021 09:50:35 +0000
Message-ID: <CACAyw9-JJEPzvCbvgyNx6SFekiqC8nD=REQSEr9yOTHEYe68gw@mail.gmail.com>
Subject: Re: [Patch bpf-next 01/19] bpf: rename BPF_STREAM_PARSER to BPF_SOCK_MAP
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 8 Feb 2021 at 08:21, John Fastabend <john.fastabend@gmail.com> wrote:
...
>
> Rather than rename this, lets reduce its scope to just the set
> of actions that need the STREAM_PARSER, this should be just the
> stream parser programs. We probably should have done this sooner,
> but doing it now will be fine.

So sockmap would not be hidden behind a CONFIG anymore? That
would be great.


-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
