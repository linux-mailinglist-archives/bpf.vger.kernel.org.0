Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920414751DF
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 06:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239837AbhLOFP2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 00:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbhLOFP1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 00:15:27 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44796C061574
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 21:15:27 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso18091115pjl.3
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 21:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yp2Hvg3Y74kAHSKwP+NncFPWJ32ng+EPbWfitCr7WM0=;
        b=FC9aBekgi6buG4xTZX5q2X4CV5eHfLCxA5Kh0TwUeTZReQ+U4raOg84bdBKtlYdRv5
         w2IcZTc2RObkG1PU1guhvxqsde4RK+V4swFElWohArmg0VQWeFB2+K64YaJqOUjTItwD
         Cz7Fh96E8lcZknyC5tCVQZODHvUpLcIwzyCkWhznR/of0QAyXnyZoukmyzC3q5IGXtlA
         1CpMpH29zsDBhtmvgHV9XYkPwsPnajXJVKEWY+VRb/CWnwI6MxgnIZCrN5C+JTOnsvRw
         onrari/TGON1oGhu7fhgDlsRUtCafZjWgs1EWBGgAtamrFqpZnNE6TbD4rY35pC4nodS
         MfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yp2Hvg3Y74kAHSKwP+NncFPWJ32ng+EPbWfitCr7WM0=;
        b=0gOn/RPvQEUx3lAxZ5DQkP6fe0KCBHmHGMUhhQ77oia0tG6Fz3zcBdx+qSfj0BgTwS
         NQLrQSNxNkH/43YIAp9TZ6/lBQrpN6yL+jBAnHCFB6uqfrmnGkoS5W/I2zTVzQD71LFV
         sirR1x3qrfMPN1KLdt/NcsgWahfGB28gmfg2Uuy0PcDjPMX51O2WMDH4eIs442I8IZjL
         6SYWaIrvx7I6JWvofV9YCTaLG39mBlECozpeQhoXfxFQFFIcy6m5qMnXjpEip8LZJq+h
         YT7UtCz4TgWENstsqPBLL5aAByth/zeV5fDtQ6NGnW8NEZ3QdWsC2X+Y+t4TZi6aChte
         SOuA==
X-Gm-Message-State: AOAM5332RkbjjNVfC2hc5KDeTgA7w3swE9YoSHKRgfQuRM5NR04u7FWJ
        aclOVD1i0dim+WdeyQJhVDfqsYoYvJk5pgyiGmE=
X-Google-Smtp-Source: ABdhPJzvclVHSTtgMwQbwwXyhg9Ayu2PbPTk0aolDvS3YrtsY4tU4rHEn1NQGJGixSn4IsZQvOz0777BRrf7thVxqlY=
X-Received: by 2002:a17:902:da8a:b0:148:a2e7:fb33 with SMTP id
 j10-20020a170902da8a00b00148a2e7fb33mr2791612plx.116.1639545326607; Tue, 14
 Dec 2021 21:15:26 -0800 (PST)
MIME-Version: 1.0
References: <20211215023126.659200-1-kuba@kernel.org> <20211215023126.659200-5-kuba@kernel.org>
In-Reply-To: <20211215023126.659200-5-kuba@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 14 Dec 2021 21:15:15 -0800
Message-ID: <CAADnVQKfi9BFxjEjvRLLdimoF5Rrbe8LnX+g94MbGCt6_NTomw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] bpf: remove the cgroup -> bpf header dependecy
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 14, 2021 at 6:31 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Now that the stage has been set and actors are in place
> remove the header dependency between cgroup and bpf.h.
>
> This reduces the incremental build size of x86 allmodconfig
> after bpf.h was touched from ~17k objects rebuilt to ~5k objects.
> bpf.h is 2.2kLoC and is modified relatively often.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/bpf-cgroup.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 12474516e0be..4c932d47e7f2 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -2,7 +2,8 @@
>  #ifndef _BPF_CGROUP_H
>  #define _BPF_CGROUP_H
>
> -#include <linux/bpf.h>
> +#include <linux/bpf-cgroup-types.h>
> +#include <linux/bpf-link.h>

Borked rebase with stale header I guess ?

Could you try just patch 1 with bpf-cgroup-types.h
and do s/bpf.h/bpf-cgroup-types.h/ here in bpf-cgroup.h
as patch 2
while moving cgroup_storage_type() function to bpf.h ?
Patch 1 will add +#include <linux/bpf-cgroup-types.h>
to linux/bpf.h,
so cgroup_storage_type() will have everything it needs there.

I could be still missing something.
