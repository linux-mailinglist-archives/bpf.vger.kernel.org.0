Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0821B407491
	for <lists+bpf@lfdr.de>; Sat, 11 Sep 2021 04:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhIKCJn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 22:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhIKCJm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 22:09:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAFFC061574
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 19:08:30 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id oc9so2553000pjb.4
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 19:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TYEcQmflhYE+hyurBKutm0eJn4sDsVi6RJl7l/U9hR0=;
        b=oU+vvaU6UXZ454CWHEU8C7Dm51INXTn0lZhCgiimvidERmL5V1RibI7BIro1jijnXW
         nyrvAHj37fzp0A3jd+JQJA7xjNFscIEO/SATurM0k2VFs1htwZBwzElpTpFozmEMk3r4
         MMpW2MDlveEL/LrFVkuPh/S6K7wZhF/67T8j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TYEcQmflhYE+hyurBKutm0eJn4sDsVi6RJl7l/U9hR0=;
        b=lcyOwPinvXbZuQnjRXMgeVHvTZlxzMZi04hTxM/8kURnqEFL8Z07m9poey03EykQO+
         d3ZoBaXNlr3goMsIXiybiJuRH03Rj7mUKJOLO80CikmRopfldbq56FpGWiAVIcBaPfo+
         uSLV1cEeghR5XV7cUN/zatvQuYYyN+Zzbxkgl4gSZ0V1fIqhbkVzbwMrsncCgqHR//D8
         7EO2re9yN5wkJxOdhvkDZYiHmJCQ/8b9iMHP9dS3dq13BYUxXjtTqIjR/unVbuQ3FbXE
         5n5Hl1Upd/Smj17+byEuEE47CgXz83iVGG6uEugFT9PRM35Wk3MBcMjXloEd7J++m/Ll
         a8AA==
X-Gm-Message-State: AOAM530a2DNlSVmmjMqS/gnMOdQd5nuZmmKbRvw9PNOLzuxGxLtA0JDk
        5Mgbr13yRBk5Clcwx2nIlpMRCNWD9PqENw==
X-Google-Smtp-Source: ABdhPJyhfzq9ovFR5pjw2h3Qosze96EEiaBU3gtg2iZDaXaBfS7G8RV3Gu1WBdVCpOzdHhCltxL9+w==
X-Received: by 2002:a17:902:7e47:b0:137:60bd:c08f with SMTP id a7-20020a1709027e4700b0013760bdc08fmr663909pln.8.1631326110294;
        Fri, 10 Sep 2021 19:08:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s3sm161516pfd.188.2021.09.10.19.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 19:08:29 -0700 (PDT)
Date:   Fri, 10 Sep 2021 19:08:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Subject: Re: [PATCH] treewide: Remove unnamed static initializations to 0
Message-ID: <202109101845.FF22342@keescook>
References: <20210910225207.3272766-1-keescook@chromium.org>
 <20210910232303.vzwzoo2vvyga6jjs@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910232303.vzwzoo2vvyga6jjs@ast-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 10, 2021 at 04:23:03PM -0700, Alexei Starovoitov wrote:
> On Fri, Sep 10, 2021 at 03:52:07PM -0700, Kees Cook wrote:
> > GCC 4.9 does not like having struct assignments to 0 when members may be
> > compound types. For example, there are 186 instances of these kinds of
> > errors:
> > 
> > drivers/virtio/virtio_vdpa.c:146:9: error: missing braces around initializer [-Werror=missing-braces ]
> > drivers/cxl/core/regs.c:40:17: error: missing braces around initializer [-Werror=missing-braces]
> > 
> > Since "= { 0 }" and "= { }" have the same meaning ("incomplete
> > initializer") they will both initialize the given variable to zero
> > (modulo padding games).
> > 
> > After this change, I can almost build the "allmodconfig" target with
> > GCC 4.9 again.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> ...
> 
> >  .../selftests/bpf/prog_tests/perf_branches.c  |   4 +-
> >  .../selftests/bpf/prog_tests/sk_lookup.c      |  12 +-
> >  .../selftests/bpf/prog_tests/sockmap_ktls.c   |   2 +-
> >  .../selftests/bpf/prog_tests/sockmap_listen.c |   4 +-
> >  .../selftests/bpf/progs/test_sk_assign.c      |   6 +-
> >  .../selftests/bpf/progs/test_xdp_vlan.c       |   8 +-
> 
> Those have nothing to do with GCC. They are compiled with clang with -target bpf.
> Did you check that bpf selftests still pass?
> We've had issues with older clang generating different code with zero and non-zero
> assignments and libbpf was confused.
> It should all work now, but please run the tests.

Sure! I think selftests/bpf/config is missing:

CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_BTF=y

I can't get much further, though:

$ make -C tools/testing/selftests gen_tar TARGETS="bpf" FORMAT=.xz
make: Entering directory '/srv/code/tools/testing/selftests'
make --no-builtin-rules ARCH=x86 -C ../../.. headers_install
make[1]: Entering directory '/srv/code'
  INSTALL ./usr/include
make[1]: Leaving directory '/srv/code'
make: *** [Makefile:162: all] Error 1
make: Leaving directory '/srv/code/tools/testing/selftests'

I'm not sure what's breaking ...

-- 
Kees Cook
