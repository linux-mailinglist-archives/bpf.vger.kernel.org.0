Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F856BF165
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 20:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCQTEM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 15:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjCQTEL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 15:04:11 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0627A3E1DC
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 12:04:08 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id x36so6130506ljq.7
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679079847;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxWwhYtYMhTKLT+t03kqT9HvUsxnKyYicVxmtWlKd/U=;
        b=VaLCQLvTCM70AHROG4xz4tfrBF639waWz4KoWP8AzwXYthDGomNGp1T7jkmLSYG6ZL
         sQFvXnCJrqBICSwPvMM6a5OUdp9euuNEyXtvS6swIWpNLZtX+94mUEIdzi0vOzHTeDjh
         3JTXIbCJnfWdIZvosOOvSj9i6QeMcdMqZQro0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679079847;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxWwhYtYMhTKLT+t03kqT9HvUsxnKyYicVxmtWlKd/U=;
        b=YW5kdpT7dFivPP4sxPL1M/lx7T7bDfkAoj9gBNlC+ddZmfTyLm7IWwgS9NxQuqTZ7F
         20h5hwE3MC4ObfrRmj7vhhXkz/5fXg6KE1I4Sg0DsVRHIYCnlRHNe2Tyg3ODIRhpaVq6
         Hpg2HdflaekgjLNgl9Azgs3NJXG4RpS+pzHXxw4FE44a0UJyrz8OGnZrJnUmq0WrZ12R
         6+eupqfmReJD1U+1vubOR2eArTLVh2DhocbAjRNUXDP65AM1vaS+mbVPSxUggNcl0wfH
         OcqMSRda2JHwpu/nK0UeWiYCzvbo0RaQ6VXdH8M3HIwDw/7N2C1MfRMdwgwfWRFJMpON
         h+wA==
X-Gm-Message-State: AO0yUKXY1KA4/Y+5cJaUmUdz4if32eQXu4c/9/V2EaHYprs5ZOuabdre
        1eFbtqiF5YHZzc3BDsitobOplXaaZ8oyhnbKMjp4Rg==
X-Google-Smtp-Source: AK7set9HiEa6enkw+O8v0nH+vyluNOZUiaCR0NVYDozZkTby7pa60VguxOSXhQJyn+UdyYOLblrB7egT3k0I/PkyvWw=
X-Received: by 2002:a05:651c:48e:b0:295:95a8:c6a3 with SMTP id
 s14-20020a05651c048e00b0029595a8c6a3mr3635392ljc.10.1679079847107; Fri, 17
 Mar 2023 12:04:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Mar 2023 12:04:06 -0700
MIME-Version: 1.0
In-Reply-To: <20230315125256.22772-1-fmdefrancesco@gmail.com>
References: <20230315125256.22772-1-fmdefrancesco@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 17 Mar 2023 12:04:06 -0700
Message-ID: <CAE-0n50=j=GPQA=wQa5wE=P2T0ipOoOn6ekhPVAJhr5nMkiVnw@mail.gmail.com>
Subject: Re: [PATCH] module/decompress: Never use kunmap() for local un-mappings
To:     Chris Down <chris@chrisdown.name>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jiri Kosina <jikos@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>, Petr Mladek <pmladek@suse.com>,
        Tom Rix <trix@redhat.com>, bpf@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Piotr Gorski <piotrgorski@cachyos.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Quoting Fabio M. De Francesco (2023-03-15 05:52:56)
> Use kunmap_local() to unmap pages locally mapped with kmap_local_page().
>
> kunmap_local() must be called on the kernel virtual address returned by
> kmap_local_page(), differently from how we use kunmap() which instead
> expects the mapped page as its argument.
>
> In module_zstd_decompress() we currently map with kmap_local_page() and
> unmap with kunmap(). This breaks the code and so it should be fixed.
>
> Cc: Piotr Gorski <piotrgorski@cachyos.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Fixes: 169a58ad824d ("module/decompress: Support zstd in-kernel decompression")
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
