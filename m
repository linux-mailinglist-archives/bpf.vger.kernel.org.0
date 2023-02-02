Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BF168722E
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 01:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjBBAJD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 19:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBBAJC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 19:09:02 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F3469B3D
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 16:09:01 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id w11so517784lfu.11
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 16:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jsDaysBR1niC6OaKEz7AaDUvECBLeh6C54c1hhKFwM=;
        b=T5hk0D7+dAcKJzJXXqMG0FchLqF6hESH+oq927Sl573AWqS+wySvgyUirSB71L8JyX
         VLguhiifclfi2BbfRunVEF1gaDkz3s7ScrFYEAcH8MEt7pqq8sqiQf13aYsXlTMGitka
         td0REOsrk2GdeZCaFpiTz08P2YwcipjVT4K5pHdNzwmTeuFTUupYynBV1ic/aMzMxFSx
         p52AQiSvbXbaTu6OGbdnHj9yzvzNy1Kf2VMfqa8GHLCYMHLiJFTL68Txlra+OoWUDbXx
         cOrsI119vCQ2ukQbftaWeafX1GwxpX/ubCRaaXrJGDgS/4MNXFfzYw3uB6sy0Vm2A/Xp
         o09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jsDaysBR1niC6OaKEz7AaDUvECBLeh6C54c1hhKFwM=;
        b=f77xc/A2WYsrmit8gcv59AdVSVqKUTGjWCmx7TOTQZ09/GSHiLTJqVCwOUu155coUV
         r1NGG1gNv/JL7zcV/tpVT7QOq7Ap/pYP+qoQcSnovL+LoQLvh5oLyidFXaM0P1I4ZAWs
         zH8YatOwXEOjXRbmuyeU/DV2dyfg6y1NlHVRIfRp43vC7nDoNUEFl9BKOq46NixiwiQk
         RmY3JSoQ5zz8G86+RqCoLhswof++VyVj8pJzXH/58ySzh1t+jcrvQ1eLBvnNmRCbA990
         RSBBVcYtr6YJcZlH76Y0mmPCXyoWiHStgeeFqrkk5ORe8jGWgAO/IJZ4o2CmroBGmL8Y
         pvFA==
X-Gm-Message-State: AO0yUKXqVTh45yM/ndpqUpFhHLc6SBkpDjjUo4AsK0TnX+YQHlPK2MPS
        e548saqkaulkf93+eJEuVTZOY8GWHKDSWmiaLCE=
X-Google-Smtp-Source: AK7set85xy0LMjiOROJyaNi2Zy8ig3WoiMH1nAQY737i7dHELOja1n7eZWHOmPRCzGKX1x1fRcc2UOy7bOrFMcAeK3c=
X-Received: by 2002:ac2:4985:0:b0:4b5:886b:d4af with SMTP id
 f5-20020ac24985000000b004b5886bd4afmr771485lfl.276.1675296539491; Wed, 01 Feb
 2023 16:08:59 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUVbv2T7SExVULn6Bh1mB=VpmYGbH-4U63PKrHPyi6uULQ@mail.gmail.com>
 <Y8rTcfB78f0G7C1j@kernel.org>
In-Reply-To: <Y8rTcfB78f0G7C1j@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 2 Feb 2023 01:08:22 +0100
Message-ID: <CA+icZUVBh6MgXWuXTOW7kUqAmH8RJ93upfnp8g2rfkwLoG+6Xg@mail.gmail.com>
Subject: Re: pahole: New version 1.25 release?
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 6:46 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Probably next week, I just have to differentiate a file with split dwarf
> to remove a slight hack I have right now.
>

Thanks for pushing "dwarf_loader: Sync with LINUX_ELFNOTE_LTO_INFO
macro from kernel".

I see some updates in pahole.git#next with some Tested.by#s of you.
So, we are very close to a pre-1.25 release :-)?
Planning to test with Linux-v6.2-rc7...

-Sedat-

[1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=next
