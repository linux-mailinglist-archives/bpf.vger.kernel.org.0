Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE2256D9C
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2019 17:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfFZP0o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jun 2019 11:26:44 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45938 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbfFZP0o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jun 2019 11:26:44 -0400
Received: by mail-ot1-f67.google.com with SMTP id x21so580563otq.12
        for <bpf@vger.kernel.org>; Wed, 26 Jun 2019 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s0x4A/TQS1LfVdi1Xg+m1+bnLyVXHGVn2+UTeK68wvs=;
        b=Aqb5HWvLki1YGJ1YsVi+ATLV33Z+GW6mwwdsTYF7eeNXs2dwFXyeVQ93NgwafFAMGR
         4kLBOn3AaVd7oUDccklFTvlW1k1AeeEKK1B2KKSp2b/fyLp3WXB0q+nMCD7/zVkNMY3u
         hFPSaSyadSEATbu4Aq0P+DANb2Wb34lwF5Cig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s0x4A/TQS1LfVdi1Xg+m1+bnLyVXHGVn2+UTeK68wvs=;
        b=Y4atEzZg7abeqECuNpFpE3ajujHbxLLnberzjkv+WuIK2EBU5w12mh35OyykSA+E0d
         18sZs3wLN+qUSSYSaZi43Bnk1tBbDJQbc54S0zggKR8W+1dbyzJ2IKZRZMGlG+M2PsUm
         sUU1dsODS1pHUfKQ6Jt5KZ2sZS61XSaijDDszSgycQSOVBiDf+8K1a72N9ogbuKare43
         UCxxU+bIA8HWkH2yravmW9ByCGtaBEUVVRmrlLzAZJfSEakbz5fp3FHfDQJPWCAuukCq
         oCraRAJ1qtjT7i5wHWTJTm7JcPfkGWF+jwo4MztisrsdkzxckWIWzBki2xqHA8u1bst7
         19eQ==
X-Gm-Message-State: APjAAAUnaVB19J7t3ByyDU5W2o2ZbD6xpKPsLbadWBjOe4vzaGLG6nM5
        VPAtrHoCBxXX73Jj4JHqQzau8WOIm7+E22W/Jatdyw==
X-Google-Smtp-Source: APXvYqxgQL7aUuJp4ttGkstXm39VselsmJzbDYiNcY0AmiHXTy2/MYeK51fkoZtnMqFYOeBfxVTubhmfVtoXtpM6Ez8=
X-Received: by 2002:a05:6830:1485:: with SMTP id s5mr3682097otq.132.1561562803605;
 Wed, 26 Jun 2019 08:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190625182303.874270-1-songliubraving@fb.com>
 <20190625182303.874270-2-songliubraving@fb.com> <CACAyw99isFcFhnrmagmzPPR1vNGqcmDU+Pq7SWeeZV8RSpeBug@mail.gmail.com>
 <3AE4213C-9DFA-407F-B8D4-DB00950E577D@fb.com>
In-Reply-To: <3AE4213C-9DFA-407F-B8D4-DB00950E577D@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 26 Jun 2019 16:26:32 +0100
Message-ID: <CACAyw9-MAXOsAz7DnCBq+32yc575TEiwm_6P-3KWKmZWmAqUfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
To:     Song Liu <songliubraving@fb.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 26 Jun 2019 at 16:19, Song Liu <songliubraving@fb.com> wrote:
> > I know nothing about the scheduler, so pardon my ignorance. Does
> > TASK_BPF_FLAG_PERMITTED apply per user-space process, or per thread?
>
> It is per thread. clone() also clears the bit. I will make it more
> clear int the commit log.

In that case this is going to be very hard if not impossible to use
from languages that
don't allow controlling threads, aka Go. I'm sure there are other
examples as well.

Is it possible to make this per-process instead?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
