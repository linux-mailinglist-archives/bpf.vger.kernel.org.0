Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E49697EFA
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 15:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjBOO7s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 09:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBOO7r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 09:59:47 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9987EF7;
        Wed, 15 Feb 2023 06:59:45 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id c1so18703439edt.4;
        Wed, 15 Feb 2023 06:59:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJEd3xf0w2y1UrC2QqcN8kYtS3GpAcL6pZcspWXDrFE=;
        b=5j0VN3R3kYQ3F0nH8kV7kNTZz+SuM57VhAnM4C9Y8aE1dC2bS9vB813IaFirTkQvBP
         6+KTcI0LwSnVuhHSWTzqUFOrs+FVWXCHySJwou3IL39e3NafjLUBvA2sms2XnaJRmjIn
         cYiLa1kj3xXofd8j9Lz7CKbAuJDkLZyvz+rGTiOOfdVA+lE9i2nz2eCjD6D41oOjw9B8
         umP0Z4tOvcl3FWd+xDPWphlxV9P9k6RJv45xuMbIUeqgMckLJa026NOY2TYMVp77tY1e
         wy0N5AmJNlmTqnuUVjAhXAt5JsUm48pCFGjKLdp3IXuRQl1aP6WpPh/Ya1WSumDkbxYL
         bmag==
X-Gm-Message-State: AO0yUKXxU7FR1pttPXf1yP8mS2lRZv7VBJ17C3obK23F19uyoKjmTeug
        zV4rM6gvf9zQ0q4jfXJTeGQd5kLQimN/xqeD6WI=
X-Google-Smtp-Source: AK7set/7Sd+0n3IR1XuI2Nft/LvrCloss5wlyYLmGs5b5V96smi/VRFv26exlqom9DfKqZS4gO42m5/LKHmuJeERXRE=
X-Received: by 2002:a50:ce42:0:b0:4ad:4c0:c4f9 with SMTP id
 k2-20020a50ce42000000b004ad04c0c4f9mr1153565edj.3.1676473183964; Wed, 15 Feb
 2023 06:59:43 -0800 (PST)
MIME-Version: 1.0
References: <20230215123253.41552-1-bagasdotme@gmail.com> <20230215123253.41552-4-bagasdotme@gmail.com>
 <Y+zqKk1BTvIe5+5r@amd.com>
In-Reply-To: <Y+zqKk1BTvIe5+5r@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Feb 2023 15:59:32 +0100
Message-ID: <CAJZ5v0i_+rutzGF05XdEJ5e6dN6PYegX7+0FuoaGBrvizFFS=w@mail.gmail.com>
Subject: Re: [PATCH 3/3] Documentation: amd-pstate: disambiguate user space sections
To:     Huang Rui <ray.huang@amd.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux BPF Development <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 15, 2023 at 3:21 PM Huang Rui <ray.huang@amd.com> wrote:
>
> On Wed, Feb 15, 2023 at 08:32:53PM +0800, Bagas Sanjaya wrote:
> > kernel test robot reported htmldocs warning:
> >
> > Documentation/admin-guide/pm/amd-pstate.rst:343: WARNING: duplicate label admin-guide/pm/amd-pstate:user space interface in ``sysfs``, other instance in Documentation/admin-guide/pm/amd-pstate.rst
> >
> > The documentation contains two sections with the same "User Space Interface
> > in ``sysfs``" title. The first one deals with per-policy sysfs and the
> > second one is about general attributes (currently only global attributes
> > are documented).
> >
> > Disambiguate title text of both sections to fix the warning.
> >
> > Link: https://lore.kernel.org/linux-doc/202302151041.0SWs1RHK-lkp@intel.com/
> > Fixes: b9e6a2d47b2565 ("Documentation: amd-pstate: introduce new global sysfs attributes")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>
> Acked-by: Huang Rui <ray.huang@amd.com>

Applied as 6.3 material, thanks!
