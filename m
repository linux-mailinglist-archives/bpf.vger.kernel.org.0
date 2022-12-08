Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8361764665E
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 02:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiLHBQO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 20:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLHBQN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 20:16:13 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296726343;
        Wed,  7 Dec 2022 17:16:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id s7so72816plk.5;
        Wed, 07 Dec 2022 17:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=do12zT2hH+Wtg5Vu6b69CtdNJSonl4ptgBKTFMFW5Mk=;
        b=NhyrGpABphSulQDFAl1ZeIZRU5WRlSPRog5zfio8GM6AkdJWeMKSYguwGbG2n6dBlZ
         8gAqUBtUR4aH+uNwr90cxx7DEDc5HDdlxpvkAvrrJdoQGmt6H4fnE9pYuMY6jnn0gIUD
         1uTKg6Z8GSuZkbBvgKR85QRm61fDm4YfFWblX3NRUly9uCpg/GtXENZBWOxAgVwaF+4s
         gdi4ciWIa1Lss2BdSXjH1d4iaDdAaSSnuiBZ3JTGCiK1hL41zE6/BNuAh8Gq07nL9QRU
         dCOfmtJdFBAPWWUEBPVKv7hW6THo0rYVPuAzYFCYuuTsUgXGU2e3ThutnVzYvxxyZvf3
         qPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=do12zT2hH+Wtg5Vu6b69CtdNJSonl4ptgBKTFMFW5Mk=;
        b=kNIY2Z/s36rB+JEuIsxg3Dwsosp2vhXtfFewBStFEQ8qpgEo7Ps780IQ21I4a13yIM
         YTUfLBDXG6CBC3EBtetaDO15lZAWVKY8jJ6cKwvrrngEoym5pJtSj3XYFTRf1AgprAmK
         +sfAJC/J3CN9ZGoVpcS6RV6C01Jp9UcXAeOY65fhnq5HtvWWflkncTupFs9H9jL7WIia
         SuHAKJCPXNT85Ht+OW55nOLXR3fGzj9y96zgnvFTFhR9z8tvoAw/V63QJcj5iBR8KCrZ
         0KLGei6K7fkUxG+Su/5Vr2uJBWn+w3JuUaGDMylsUQvNmxxnBXhHfZkFbWKtoE/9bt0Z
         qBYA==
X-Gm-Message-State: ANoB5pk8UKD7rySbp/Sxu8y90wQCk00xYSc+hBuWX2tRgyBZTvdzbsNm
        inSZnUFW/VSzhMsYcskyUYM=
X-Google-Smtp-Source: AA0mqf5XA1EPh6hiZTAr79huHc0sHb9N13Jue1i2JXe4Qzv12T+HYwdgwhcOvTAAoCeNAHBiLOCbdA==
X-Received: by 2002:a17:90b:1058:b0:219:9a95:ac1b with SMTP id gq24-20020a17090b105800b002199a95ac1bmr1289606pjb.21.1670462172494;
        Wed, 07 Dec 2022 17:16:12 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id gq21-20020a17090b105500b00219220edf0dsm1719066pjb.48.2022.12.07.17.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 17:16:09 -0800 (PST)
Date:   Wed, 7 Dec 2022 17:16:06 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next v3 2/2] bpf/docs: Document struct cgroup * kfuncs
Message-ID: <20221208011606.btp3ua5i3vagvigi@macbook-pro-6.dhcp.thefacebook.com>
References: <20221207204911.873646-1-void@manifault.com>
 <20221207204911.873646-3-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207204911.873646-3-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 02:49:11PM -0600, David Vernet wrote:
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1e4bf466b08f..1478862702fc 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1960,7 +1960,7 @@ struct cgroup *bpf_cgroup_kptr_get(struct cgroup **cgrpp)
>  }
>  
>  /**
> - * bpf_cgroup_release - Release the reference acquired on a struct cgroup *.
> + * bpf_cgroup_release - Release the reference acquired on a struct cgroup kptr.

While applying I've changed above to be 'on a cgroup' to match what you have in
patch 1 for bpf_task_release and existing bpf_cgroup_acquire doc.
bpf_cgroup_kptr_get doc stays as "on a struct cgroup kptr.". Which makes sense.
Please let me know if I misunderstood the intent.
