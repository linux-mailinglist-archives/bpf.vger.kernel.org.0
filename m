Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F0A4073CD
	for <lists+bpf@lfdr.de>; Sat, 11 Sep 2021 01:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhIJXYX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 19:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbhIJXYR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 19:24:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2E9C061574;
        Fri, 10 Sep 2021 16:23:05 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id j16so3244062pfc.2;
        Fri, 10 Sep 2021 16:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8Nm0hLYksfNthawk6Krwt62VT8XOIlxDrMAJH+VYgps=;
        b=N5V+KCdsfUx5v0OAtOaJpLOyWhfp2PFnTDIlXSfYl6DhWMWY2OA6H7h6umO2TXxRT/
         49nXIVUa5GR46TWfet4+KNH+r62lpZFr6wi1DTUSutyLMRJhRyIO5XmALb4y3m/03Skd
         AeVKKWr82P9ZHprxWBlJ85khqt6elbfpOcVbfDwrwXb+yOBo5Va/o+aKETRjv0nOTlb7
         36e+hMIx8fd+ZuRK+YWLgOHTTYvvb6CVQoA0BgC+LgJeVfyJ0legT7ZaJPjs5bK19X3P
         fmVEUftPr2HVZ6h6JwKJSgu6CKlUV6/wA/9N6NSIo3iDrF4pq9gBoMlF0fbzl6MQF6iq
         b4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Nm0hLYksfNthawk6Krwt62VT8XOIlxDrMAJH+VYgps=;
        b=LSouG6jRhr74r7qufuyL8+RN+UyVcG2LUlVQRTc6yLqUtkv+M/Jh9LNDwbAHYXPxWf
         gzpnNt62QA9YHSvxzHaqeMfWOq5ntu/oXdDo33Uma7SDDsG8QBOnZaOrMGuF/Xn9niB0
         8h6h1wUY+oqylvViiIN/965F8Ubojjw+OobOgtYL02+W/A3KqQFLc0FnWWuVdT3mq972
         30XTW2YD7cHBr1yXGM9DdwC+LGXXcbuP+nNiQroBC+N39f7hzJbqeomeoys+cAyK0iMy
         77UlEsJA0qqhvkZenIqKqvdnw+4MDTmldocUjMmcrfdnoRwjJUJkR/EpKV7lUiTeQFwu
         PLuA==
X-Gm-Message-State: AOAM531DHjE94/HolVtqqPByuW5BjhYl5IcSg5Q+W51kAMRxGrZcocry
        HaaKTqi8Az+chlf+dHiAySM=
X-Google-Smtp-Source: ABdhPJwrI+P4sIrm36OEQcMJbs9b+blsntJXiPWjIGX17mkNBaW3eacpOKw/O0GDa6tigKfbnfjxew==
X-Received: by 2002:a63:7e11:: with SMTP id z17mr139932pgc.436.1631316185321;
        Fri, 10 Sep 2021 16:23:05 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:5d1f])
        by smtp.gmail.com with ESMTPSA id f6sm5058pfa.110.2021.09.10.16.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 16:23:05 -0700 (PDT)
Date:   Fri, 10 Sep 2021 16:23:03 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Subject: Re: [PATCH] treewide: Remove unnamed static initializations to 0
Message-ID: <20210910232303.vzwzoo2vvyga6jjs@ast-mbp.dhcp.thefacebook.com>
References: <20210910225207.3272766-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910225207.3272766-1-keescook@chromium.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 10, 2021 at 03:52:07PM -0700, Kees Cook wrote:
> GCC 4.9 does not like having struct assignments to 0 when members may be
> compound types. For example, there are 186 instances of these kinds of
> errors:
> 
> drivers/virtio/virtio_vdpa.c:146:9: error: missing braces around initializer [-Werror=missing-braces ]
> drivers/cxl/core/regs.c:40:17: error: missing braces around initializer [-Werror=missing-braces]
> 
> Since "= { 0 }" and "= { }" have the same meaning ("incomplete
> initializer") they will both initialize the given variable to zero
> (modulo padding games).
> 
> After this change, I can almost build the "allmodconfig" target with
> GCC 4.9 again.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

...

>  .../selftests/bpf/prog_tests/perf_branches.c  |   4 +-
>  .../selftests/bpf/prog_tests/sk_lookup.c      |  12 +-
>  .../selftests/bpf/prog_tests/sockmap_ktls.c   |   2 +-
>  .../selftests/bpf/prog_tests/sockmap_listen.c |   4 +-
>  .../selftests/bpf/progs/test_sk_assign.c      |   6 +-
>  .../selftests/bpf/progs/test_xdp_vlan.c       |   8 +-

Those have nothing to do with GCC. They are compiled with clang with -target bpf.
Did you check that bpf selftests still pass?
We've had issues with older clang generating different code with zero and non-zero
assignments and libbpf was confused.
It should all work now, but please run the tests.
