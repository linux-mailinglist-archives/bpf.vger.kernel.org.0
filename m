Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3362CB4BE
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 06:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgLBF4P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 00:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgLBF4P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 00:56:15 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED278C0613CF;
        Tue,  1 Dec 2020 21:55:34 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id o24so1325474ljj.6;
        Tue, 01 Dec 2020 21:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kF4MPMV0LOJFs58rVTILZsCl7WhPqj7BoWapl4MSIas=;
        b=LIKmg7gOf5TQqHOFN6bHxs0M12fOa+pXJ7zQlWfL1sTD+bnafY7ILuk7noKX8yem7/
         rcBma/TUWGFd38s0xp5T6sq+WmqxI/P3niWjVmTWKF49OfkRt7194nK/OzvKzRr/Ytzv
         bVV9OY86nwVPyvmU755Sj0i/yrGjerUGNAYCa0U/o8PW/HQLIe3Ihq+UsVw6myrstixc
         rzm2LkDj3hY36Io9HMyIjCvK7ElEap6qtqDuoJ7AjiL8X8DMkpPxUaPZatOySfWAnyjh
         0CxCkTnCtdjFBaXYcQNZ8SjGNmkfc7cYZi+UoqW6cAiGNPLqgjzRLBdCUYUlEj0Hs5bt
         9Erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kF4MPMV0LOJFs58rVTILZsCl7WhPqj7BoWapl4MSIas=;
        b=PV8SCHKH1KGP+AM7a7x9fgC15sn7o7Jys0Zip690qnYJgcmon++3+SX2yy9wP8PbhN
         xDOR/jbEp1Sog0m1cIgwBNQZ7jZvl0gPkmTg2swWheG3vMzshh9reH+5ARfOi8fd4vF7
         1lsGJ9ZSFZTNMOfbK9W0PY5NskFF5VlLNoMnUlCxbknvkKAlRwWV7974h3PAJWGLDaG8
         9Vwi8rShk6mAxepQ7egHp5++32t10FQDHY0KXH/JGMgzcclKmT+PPNKtwUtusSHMtdOn
         0s3IXFTZuPTy80+yi5efE6AiLoFKaCl1iF2JxT/kvh0TH20i8z8QGZEs6m8kS8CH64Kc
         mH7w==
X-Gm-Message-State: AOAM533oKsfonBlmwhzdW2HuO33m2OIRj0bVmtJYMzDWI0l9Q9hyNbHc
        wSwC1XDf2iqFf2tC1L+va1qyhdU3GmPHHCwv2UI=
X-Google-Smtp-Source: ABdhPJxpsSmdSgqny8SdbIFxHHYUYtZQ7tUeZribhUihDQV3zusMP9ezIy4Vv+1oLdorBk82qON8qsOQ/HV18yF6U74=
X-Received: by 2002:a2e:8982:: with SMTP id c2mr455784lji.121.1606888533502;
 Tue, 01 Dec 2020 21:55:33 -0800 (PST)
MIME-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com> <20201127175738.1085417-11-jackmanb@google.com>
 <0fd52966-24b2-c50c-4f23-93428d8993c4@fb.com> <20201129013420.yi7ehnseawm5hsb7@ast-mbp>
 <1dfd2e5e-f8d2-eac2-d6b2-7428ceb00c36@fb.com> <20201201123800.GG2114905@google.com>
In-Reply-To: <20201201123800.GG2114905@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 1 Dec 2020 21:55:22 -0800
Message-ID: <CAADnVQLYMKhC4D9AzcOEXM9s9LfdFo4sEL3hsU=UAzBOXGwb-A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/13] bpf: Add instructions for atomic[64]_[fetch_]sub
To:     Brendan Jackman <jackmanb@google.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 1, 2020 at 4:38 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> I guess it's also worth remembering other archs might have an atomic
> subtract.

which one?
arm64 LSE implements atomic_fetch_sub as neg+ldadd.
imo x64 and arm64 example outweighs choices by other archs if there are such.
Even without LSE it will be neg+llsc loop.
The reason I proposed bpf xsub insn earlier is that I thought that llvm
won't be able to emit it so easily and JIT/verifier would struggle.
