Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329F75A0368
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 23:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbiHXVul (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 17:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238715AbiHXVuk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 17:50:40 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554775A808
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 14:50:39 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id d1so13965112qvs.0
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 14:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ea0NY8Wcmrw8jiIeMxrgrbCuQlMf6QjBSe97YKFpa/I=;
        b=WPS0tAyQfC0zB28Q71UVvTup+2cOaGcGM2yOobh2rnb0Ev5V4uSGgRwkos26TWizPf
         5mXVNiDtsTZJ1qWrfuu5Qzz4dYRGn4NjVCPAo4bLN0Y/AZ3F1YkX3au5gdqbAuLHV7VK
         lgQvNu22ibznoLicPi2yR7AEuY4RXys7Sx9DOJdGYn11rmmZjgKn2vWXLYsIu0K4spH2
         uAIbqOfv0qJD1aCEcVwGiYVYV894n8JcYgR8G54BwERh/hZeRQtcWRlwCNoZu/mkL/5F
         FUSHBk7XVuE7k+ZyG19UWwRHreZ2DNEovJfUEu/GFXhAdXYsKaEERViA+n7ov8spqVQe
         vZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ea0NY8Wcmrw8jiIeMxrgrbCuQlMf6QjBSe97YKFpa/I=;
        b=xeZC560dU5635WSjXHDXm2ETZP++5F1TRMOh9q5GSgdLlV+kgyIfIIaItZtx2ukxAW
         ++VHbMe2IoQS9kadQnfwHh7Pe0qOorM4hrdc3saC3WB71mcB2/nQ+JQ3I5c+emSdpW63
         8L7nEjr5I4R4aL1R+B9MO6iZegcZGJZ5w+LUJEmjjhcQqApFd2nXtGp0TFLrkmZ5BPxm
         Kwmd+0xpmGKcD20ccRFby04mP2xHWmx2M6v2YwSykkg1drm63DKCSbZI4FmhrsO3ZKeS
         3BTXfYiilEyPT1siu7Tq6ZFVtOiuc0famgbb4EbJBmrEWyrhuvAfO25DH0fVU9tMSn5H
         eTkA==
X-Gm-Message-State: ACgBeo3ko8GkUrqD84lgGedm54ycXZJyLwc1V2Ez7sD899bJVBFWSMhf
        m1JjGKDfOon83+B5+W32HyfBlsIYinp7aEOupiUKfA==
X-Google-Smtp-Source: AA6agR48bpI09EmSaS+vjkAloxUWZiEJAHm6TeiyOSaxRtZHet7Dnkd7iH6j0c98qyu8vzceqiNRye73lPPrbxk4gl8=
X-Received: by 2002:ad4:5b8e:0:b0:496:b261:e4ce with SMTP id
 14-20020ad45b8e000000b00496b261e4cemr1096776qvp.107.1661377838450; Wed, 24
 Aug 2022 14:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220824181043.1601429-1-eyal.birger@gmail.com>
In-Reply-To: <20220824181043.1601429-1-eyal.birger@gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Wed, 24 Aug 2022 22:50:27 +0100
Message-ID: <CACdoK4K8KM=572FuYQ6NkHMHr_HtMwVY8ADYKF+rt8e0ATZJXA@mail.gmail.com>
Subject: Re: [PATCH bpf-next,v4] bpf/scripts: assert helper enum value is
 aligned with comment order
To:     Eyal Birger <eyal.birger@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 24 Aug 2022 at 19:11, Eyal Birger <eyal.birger@gmail.com> wrote:
>
> The helper value is ABI as defined by enum bpf_func_id.
> As bpf_helper_defs.h is used for the userpace part, it must be consistent
> with this enum.
>
> Before this change the comments order was used by the bpf_doc script in
> order to set the helper values defined in the helpers file.
>
> When adding new helpers it is very puzzling when the userspace application
> breaks in weird places if the comment is inserted instead of appended -
> because the generated helper ABI is incorrect and shifted.
>
> This commit sets the helper value to the enum value.
>
> In addition it is currently the practice to have the comments appended
> and kept in the same order as the enum. As such, add an assertion
> validating the comment order is consistent with enum value.
>
> In case a different comments ordering is desired, this assertion can
> be lifted.
>
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks!
