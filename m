Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A70444DAFD
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 18:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhKKRNg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 12:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhKKRNg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 12:13:36 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA8CC061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 09:10:46 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f18so15749027lfv.6
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 09:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/tMo4LdLFUXpPGkuecIhsBnDmeoNXK4Yl06c5PEnHs=;
        b=aPO6x4dzXu7tvnLyQRz45ypJ7S5PdwqS/lGWsJXz+AW3AW6NlEojCCFxYU/LWtOSUF
         9uMmmIG1b8qTj3JxqvHgwS7prWiXC84lc3vHa05yQWZa7fikC7fAj4KWR4YP3Im5S5hT
         6rIe7W0i9yIZi9xD6aQnSpbA8twuC0hyOuhe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/tMo4LdLFUXpPGkuecIhsBnDmeoNXK4Yl06c5PEnHs=;
        b=AnoARnbqnFMr27J/RLRTrddnn5AzA4xBUWqVeWLGFY2aNFLLdxcwTFSQw1+XcMFIKe
         LzP74AoO5t1lqoa9P4WDqN6OPKDOH4unBxrdznzq8g5n8xGUglE7jShJirO4OVyFI8uI
         OXb1Fj2QQtH2UlJvsHHscUuc0Of/lKo69UX4GgUqDAs0DUK5cLYLdvVir7gkUFKnW9t6
         2a70JfOCM+z/8sGLS4FAUG28zzZdqZT56OkowbEbg/1Nt7hcXeSd3GjR3z5KnmT0rz1g
         wXk35DW8eapIM3HX0KmIn7jC5c9R23OuirgFKfa0ciNpnM/9NFXi33A/ZCJKHVxgry8g
         0FLg==
X-Gm-Message-State: AOAM532D5eWfJpA+N89SBHCGZYaln+Hwf3GKd7N7ZFo/kEosADRbufzZ
        P6UaTX9lGWfLr5JJMRjT/ymwj0X8aF/LDmrCuj5fM5xGOOw03A==
X-Google-Smtp-Source: ABdhPJz1XE/Sy05hmqwDJ2V2prrGkJe5GvkM+mom9D+cjyBjBOyhXA7zR485u7ju8qulUjkJdPnN97EGxCNauay9IhE=
X-Received: by 2002:a19:5e42:: with SMTP id z2mr8017740lfi.102.1636650645139;
 Thu, 11 Nov 2021 09:10:45 -0800 (PST)
MIME-Version: 1.0
References: <CACAyw99hVEJFoiBH_ZGyy=+oO-jyydoz6v1DeKPKs2HVsUH28w@mail.gmail.com>
 <CAADnVQKsK_2HHfOLs4XK7h_LC4+b7tfFw9261Psy5St8P+GWFA@mail.gmail.com>
 <CACAyw9_GmNotSyG0g1OOt648y9kx5Bd72f58TtS-QQD9FaV06w@mail.gmail.com>
 <20211105194952.xve6u6lgh2oy46dy@ast-mbp.dhcp.thefacebook.com>
 <CACAyw99KGdTAz+G3aU8G3eqC926YYpgD57q-A+NFNVqqiJPY3g@mail.gmail.com>
 <20211110042530.6ye65mpspre7au5f@ast-mbp.dhcp.thefacebook.com>
 <CACAyw9-s0ahY8m7WtMd1OK=ZF9w5gS9gktQ6S8Kak2pznXgw0w@mail.gmail.com>
 <20211110165044.kkjqrjpmnz7hkmq3@ast-mbp.dhcp.thefacebook.com>
 <7e7f180c-6cf6-ba86-e8fd-49b3b291e81e@leemhuis.info> <CAADnVQ+1xY2fGKH2=VxeukSwBUc0D=+6ChqCgwEMPGMPKeKiOA@mail.gmail.com>
 <b1b8bf55-1db5-3343-29da-d284a33d10d4@leemhuis.info>
In-Reply-To: <b1b8bf55-1db5-3343-29da-d284a33d10d4@leemhuis.info>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 11 Nov 2021 17:10:31 +0000
Message-ID: <CACAyw9-=JM9OeabH-xSaa00SzXUTzXkSN6A4nBY5Te8TD7RK3A@mail.gmail.com>
Subject: Re: Verifier rejects previously accepted program
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Thorsten,

On Wed, 10 Nov 2021 at 19:50, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> >
> > I don't think you're familiar with bpf process of applying patches.
>
> That's totally correct, but why should someone working as a regression
> tracker for all of the Linux kernel has to know the exact inner workings
> of all the various subsystems?

I think I'm responsible for a misunderstanding between you and Alexei,
sorry. I saw your regression tracker mentioned, and wanted to give it
a try. Alexei wasn't aware of this and therefore lacked context when
you replied.

For the purpose of this report I'll send an email to regzbot when the
commit has made its way into the bpf tree. I hope this works for you
and Alexei.

Thanks,
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
