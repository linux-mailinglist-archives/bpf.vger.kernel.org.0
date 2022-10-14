Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25815FF518
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 23:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJNVNK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 17:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJNVNJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 17:13:09 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F631D20D6;
        Fri, 14 Oct 2022 14:13:08 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id l28so4495191qtv.4;
        Fri, 14 Oct 2022 14:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3+AG7EMWjdFZS0VGmgadhPPtTAxkLg0Qok94UIPTA4=;
        b=seynXs7SAsNY/KSAhi4DiXbbIzmDtjoEx/KulQcQkjWaqIl23ybarEN2zTnd4e0GW0
         UbGN7eOR+fK2xWMdrwSdELGz3scBY7po8kIY6c0HyyAj7L+OSBJvE5CHglkNTjq57kG/
         MrliNAQT+5wpRZKVILGAyFV8T2NG658F1LEhGW3gjLLlPKAuUkspQMIPEUfW/1NKGDf3
         +vxmbmjwtHoWVFErOIbVw+KFcqg9S1Ma8AkC4hECYDwtMBpPqUz+CLDv9OQrK/DvYc6q
         iEfJaUQav+57UQO5q5m8g4edNhUWurvsdoQyKBrJyV5lGdxBky/F+TlGklqC9ddN5w1K
         5zbg==
X-Gm-Message-State: ACrzQf3wsAYIGkN2BTp1Utm2GgyMzEYH4m6AKLYJYigeUFawo/GznTtE
        dI1HlVPQWiTY6QgIxLaip8gZnAd4SAL0uQ==
X-Google-Smtp-Source: AMsMyM7jUvci2ZsmgrT6IkS8LQghw3JvhAuZxSlHnJ4BvARLKXbx36Z6qdtlVIVxusxq0KbRmAvL/g==
X-Received: by 2002:a05:622a:209:b0:39c:d88f:20ed with SMTP id b9-20020a05622a020900b0039cd88f20edmr4039759qtx.131.1665781987514;
        Fri, 14 Oct 2022 14:13:07 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::6918])
        by smtp.gmail.com with ESMTPSA id v17-20020a05620a441100b006ce813bb306sm3799876qkp.125.2022.10.14.14.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:13:07 -0700 (PDT)
Date:   Fri, 14 Oct 2022 16:13:06 -0500
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, tj@kernel.org, memxor@gmail.com
Subject: Re: [PATCH v4 2/3] Now that BPF supports adding new kernel functions
 with kfuncs, and storing kernel objects in maps with kptrs, we can add a set
 of kfuncs which allow struct task_struct objects to be stored in maps as
 referenced kptrs. The possible use cases for doing this are plentiful.
 During tracing, for example, it would be useful to be able to collect some
 tasks that performed a certain operation, and then periodically summarize
 who they are, which cgroup they're in, how much CPU time they've utilized,
 etc.
Message-ID: <Y0nQ4uc7iPHgelfP@maniforge.dhcp.thefacebook.com>
References: <20221014202852.2491657-1-void@manifault.com>
 <20221014202852.2491657-3-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014202852.2491657-3-void@manifault.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 14, 2022 at 03:28:51PM -0500, David Vernet wrote:
> In order to enable this, this patch adds three new kfuncs:
> 
> struct task_struct *bpf_task_acquire(struct task_struct *p);
> struct task_struct *bpf_task_kptr_get(struct task_struct **pp);
> void bpf_task_release(struct task_struct *p);
> 
> A follow-on patch will add selftests validating these kfuncs.
> 
> Signed-off-by: David Vernet <void@manifault.com>

And somehow I managed to remove the commit title for this one. Sincere
apologies for the noise everyone. Hopefully I'll stop going off the
rails in v5.
