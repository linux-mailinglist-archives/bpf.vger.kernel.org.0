Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C6E355B69
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 20:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhDFSbj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 14:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhDFSbj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Apr 2021 14:31:39 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE45C06174A
        for <bpf@vger.kernel.org>; Tue,  6 Apr 2021 11:31:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o126so24381853lfa.0
        for <bpf@vger.kernel.org>; Tue, 06 Apr 2021 11:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=euRo0fFZW1XQm6HPp79K+3LluoMpXlXxzV1+Kzw4l1U=;
        b=ap1mpGSaMnVKbk1wKPql8sMs4MA2LO03upICp5gY0NdhClfvjKjX3PvvrSL8yWYncn
         WuAZwKULDXFj7juBZdoZtSPZOFJLrCIKR4Bh+XvvYItum2e1k2TG4IlhiQKyhAbfsgam
         V7AQprdrzUTOf/NaGcjir9f8Y/1usIPs4Y1bKDRtQid2q7Iv+bk1GvAu5OlR3inTqeGj
         x6cVjDjD7U3cAXUSTyWFhuoBrfP3mhfYVOvoxG+Z4KGQnHIn2xcgf7POqF8nGFoqwxsC
         5OtLLAqfKKnaPfpRTCEQa6DlTH3qvQw7irO2O4fzGvA+f46JUtcIYVYqeWBUD2wwpyab
         XwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=euRo0fFZW1XQm6HPp79K+3LluoMpXlXxzV1+Kzw4l1U=;
        b=ArOUBTrwY1nZO7OvcfHzIWyp6oox4OWAzY9DfxpKcpDG3oAv2oo+RJL2ywZwJhvLh+
         HDROddRVs/6nbM0NgINJvy7c0tV1PFoGSHYEgBUfgNoNxkM6ioR4WQoNPJmDxyWk5Fvl
         bqgCAkXBkND3hU50cth9t9v1u1KB/cqG5QxjtjJvPz0GfVkPJVqiY+9yUNJ/hGj39/vD
         Mdlxb4qoyaGwJ+dgWjPXzyIkkX1dVeVP84aww5CqN59NAbP3Jw51QMbRqbtiqdIGOuY8
         QKUus1jbF7VfySPegR77GomA/mAHKOMzfBJUMXSOm53C1SuGMgdYuGEGL43PLgYH+No8
         mtmg==
X-Gm-Message-State: AOAM530y/TP2naFXbW9rUJ/2scwEIEj9u+V30bHJO3ICZ1L8C54LLot5
        WtPwr46GOWYeIKAvoo+af3zfifH/p/IKgc7BIG7tmA==
X-Google-Smtp-Source: ABdhPJw+0wjMbthWQznQ4MeKcArGPuhj+Jm6HV9o3uq8zPVkkqJffJ3ehBxJ/t3F8LQFbULOKk4N1UPNp9bQv4j36wg=
X-Received: by 2002:a05:6512:94d:: with SMTP id u13mr20191207lft.368.1617733889510;
 Tue, 06 Apr 2021 11:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <06ba2ed4-2730-9ce8-0665-3c720bc786a3@fb.com> <CAGG=3QXkvwrm_tnsYtJ-gvHw8Emv5xFWeckoPoD4PhEud7v8EA@mail.gmail.com>
 <YGxgnQyBPf5fxQxM@kernel.org> <YGyO9KzDoxu5zk33@kernel.org>
 <YGySmmmn4J43I0EG@kernel.org> <YGyTco9NvT8Bin8i@kernel.org>
 <YGyUbX/HRBdGjH3i@kernel.org> <3a6aa243-add9-88a5-b405-85fd8bfbe21d@fb.com>
 <4eda63d8-f9df-71ab-d625-dcc4df429a89@fb.com> <YGyicDTUkPNhab4K@kernel.org> <YGyis5/OlebLxYQQ@kernel.org>
In-Reply-To: <YGyis5/OlebLxYQQ@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 6 Apr 2021 11:31:18 -0700
Message-ID: <CAKwvOdmU3-hY=xJVAwTuJ+3A6MG=-3AbvukqXs1kYLEXANWhow@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/2] dwarf_loader: improve cus__merging_cu()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>, Bill Wendling <morbo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 6, 2021 at 11:04 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Apr 06, 2021 at 03:03:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> > /me goes back to building clang/llvm HEAD, reducing the number of linker
> > instances to 1 as I have just 32GB of ram in this Ryzen machine... ;-)
>
> And guess what takes a long time?
>
> [ 61%] Linking CXX executable ../../bin/llvm-lto

During configuration of LLVM (cmake):

$ cmake ... -DLLVM_ENABLE_LLD=ON

to link the binaries with LLD, which should be able to link using all cores.
https://llvm.org/docs/CMake.html

-- 
Thanks,
~Nick Desaulniers
