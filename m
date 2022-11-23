Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438EB636C4E
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 22:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbiKWVVh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 16:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbiKWVVe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 16:21:34 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A2A6BDE2
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 13:21:32 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id m22so41449eji.10
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 13:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=18XxjnrtYMHvixBC1AnlUT7qsE8xAV+ekLgsnBN4uks=;
        b=ZuAuJV0jUtW5osz+CxlTGeKAvS1+fTe7mnMTSTp5SOk2aGpJsFpH5n17sW2WADxxIu
         TERH3wMnsti2qfrlDV9RUsBsFV4B5qK4W3KAYVvTwNV5deqLrdTiAb8Rh9wxkLcgMuCT
         EgOrF26J2PGEM2nGIrk8JANrMNI1rhOA4BRrLsIpTdGbM/133qVqC+P0lUbF7MhIHVF2
         qlBdoHpAvXJ4/8xG471OUhoCVhA+tNH65XsHNGqZmzL85E4WZMkimS0W5aRI1tSrv2Wp
         +RPQkxdWNtkTThJEYjC/u/nS3cNXkBHMEAAkyuATHvDGeJFJh5H5+OMVTG6B2uMKdbME
         ZGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18XxjnrtYMHvixBC1AnlUT7qsE8xAV+ekLgsnBN4uks=;
        b=wlg2kodTh+Ra00xl5SSv33oWC+iad7afHBPhSqLAh5s+7rQsO1DVGqXIvkZ7XdFPtf
         zRo+VSB8jQaJ4+y22/EPcMWz4M1OMhETE4GJ2lQJlc6kcO2ZRGmeV4Q3Frj9YLtlGJHx
         ghAEuv4Diga5rA/Dj/uMhJfr+xx0+RzKpr02ybWwLsFW/XB0YIUrC8DraKz/bdKJkKjO
         hfz2RkdLjDYVOssqiFp1kagOi2fqyOosXRZqGriWz4dg7yNxnypFzNT2puZ98yIoryie
         033LVnQLsGvvPPXr8B/k92xKBaCgvFSKOThauCXK9LTbeUZPRwYBMYX7lZqEXPLNe14e
         afDQ==
X-Gm-Message-State: ANoB5pkXwJaAqpXSuS7ym53eTU3RKCirVQUE7Sfl5uecQWtxTpNuaEK+
        u/Akf9QzuOLuTSKx5F+VbjM=
X-Google-Smtp-Source: AA0mqf4UgU2TPgG+gCJtu64rGTWvBfddqzyn+5X5WHg/cfKjwssNy4dgPNrDGlPw72uC/g85aMzV6g==
X-Received: by 2002:a17:906:be9:b0:78d:3e11:1036 with SMTP id z9-20020a1709060be900b0078d3e111036mr25943069ejg.76.1669238490924;
        Wed, 23 Nov 2022 13:21:30 -0800 (PST)
Received: from krava ([83.240.62.201])
        by smtp.gmail.com with ESMTPSA id kz18-20020a17090777d200b007789e7b47besm1840310ejc.25.2022.11.23.13.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 13:21:30 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 23 Nov 2022 22:21:28 +0100
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Mount debugfs in setns_by_fd
Message-ID: <Y36O2PrkL8t526vC@krava>
References: <20221123200829.2226254-1-sdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123200829.2226254-1-sdf@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 23, 2022 at 12:08:29PM -0800, Stanislav Fomichev wrote:
> Jiri reports broken test_progs after recent commit 68f8e3d4b916
> ("selftests/bpf: Make sure zero-len skbs aren't redirectable").
> Apparently we don't remount debugfs when we switch back networking namespace.
> Let's explicitly mount /sys/kernel/debug.
> 
> 0: https://lore.kernel.org/bpf/63b85917-a2ea-8e35-620c-808560910819@meta.com/T/#ma66ca9c92e99eee0a25e40f422489b26ee0171c1
> 
> Fixes: a30338840fa5 ("selftests/bpf: Move open_netns() and close_netns() into network_helpers.c")
> Reported-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Jiri Olsa <olsajiri@gmail.com>
Tested-by: Jiri Olsa <olsajiri@gmail.com>

thanks,
jirka

> ---
>  tools/testing/selftests/bpf/network_helpers.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index bec15558fd93..1f37adff7632 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -426,6 +426,10 @@ static int setns_by_fd(int nsfd)
>  	if (!ASSERT_OK(err, "mount /sys/fs/bpf"))
>  		return err;
>  
> +	err = mount("debugfs", "/sys/kernel/debug", "debugfs", 0, NULL);
> +	if (!ASSERT_OK(err, "mount /sys/kernel/debug"))
> +		return err;
> +
>  	return 0;
>  }
>  
> -- 
> 2.38.1.584.g0f3c55d4c2-goog
> 
