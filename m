Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6918C32A46F
	for <lists+bpf@lfdr.de>; Tue,  2 Mar 2021 16:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578103AbhCBKfj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 05:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577744AbhCBJw3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 04:52:29 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601C4C061788
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 01:51:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d3so30283532lfg.10
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 01:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYdb2+PyqZjJWB/Odwn2t4em7UhRTCH4QwkBcfh2xqs=;
        b=wHROcZk1UaCsezQOjC/gspMphant6RbdPIEHM+BrDTBOMA9x2eqX2meqwxOeea5KsT
         nBSGgTXTz5Vw/QoBxhqm3PeJ3ad9+OafMVORg49xPxA3cpd0BbscCO4AnHHufbQPAlmq
         egj8l39KL4KiOOWVrMDoJ+Y+hcz0JDgADR+y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYdb2+PyqZjJWB/Odwn2t4em7UhRTCH4QwkBcfh2xqs=;
        b=YacMYBTyIx5I2NhzP0ifslYndwMdLEzaTH+q1BL0HBqCRB4LGivV42N2HOJ8xF5sl0
         CGbt81ox/nsUN+BgCjnoovLRo94KyBAQniUlwkDiKZb7XF0VcrjIEDmZESNZ0j0fI4gb
         UXmRnVJ5DvG54O1auSfy+8DL9lKwdni22R/EFnwGTuW69UfJ0n8HPeiRi+Z6jRfS2GBQ
         9inPPe/KsH2TOSMoYz/c3U9nxMM5dhXDXnQnga5HJIQpvovxBsIlN5CLU2GClpHY/mpH
         0vLwE3KW+Jur8DGjKj8udWJiVihWCo8MgWY+ZDBlcfp0raAnPbs/bIWrie/pJCOnU6jv
         oC+Q==
X-Gm-Message-State: AOAM530gNdiG2kvsGx4OuXZS4EPvdKHLdrrYpfW4Dds4sqBZ1DWi4msc
        jXvFxWriqDf5ztfNUU/ttGa9N++RF3go6Fkot+kBFw==
X-Google-Smtp-Source: ABdhPJyKpskuOcLTCTgG/7K0BnUUFuomZzHoFOHMYSzd9OgJj+qzVUPoM8bFejDoIT9WI7E1DLB5ymWc+t1ub6zSCbo=
X-Received: by 2002:a05:6512:12c3:: with SMTP id p3mr6306191lfg.97.1614678696886;
 Tue, 02 Mar 2021 01:51:36 -0800 (PST)
MIME-Version: 1.0
References: <CACAyw9-XZ4XqNP1MZxC1i7+zntVAivopkgRgc4yXaNtD8QcADw@mail.gmail.com>
 <05c0e4ff-3d93-00c8-b81b-9758c90deca8@fb.com> <CAEf4BzZVXtVnV9aSQLaQ=7qz-3E44gvMf-abHeHKLS3S4xjChg@mail.gmail.com>
 <3a6d2ee3-4ce0-0f8b-2ab4-dad77e6da42e@fb.com> <ffbd1904-ac22-7922-201d-a971c685d761@fb.com>
In-Reply-To: <ffbd1904-ac22-7922-201d-a971c685d761@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 2 Mar 2021 09:51:26 +0000
Message-ID: <CACAyw9_=xxpHFZcczyKV19S5Q1Agw4gaU8X6cnfb0P3Oqn1iLw@mail.gmail.com>
Subject: Re: Enum relocations against zero values
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2 Mar 2021 at 04:19, Yonghong Song <yhs@fb.com> wrote:
>
> Just pushed the fix (https://reviews.llvm.org/D97659) to llvm trunk
> this morning. Also filed a request
> (https://bugs.llvm.org/show_bug.cgi?id=49391) to backport the fix to
> 12.0.1 release.
> it is too late to be included in 12.0.0 release.
> Thanks!

Thank you for the quick fix :)

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
