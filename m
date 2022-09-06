Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C715AE5F2
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 12:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiIFKwy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 06:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbiIFKwZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 06:52:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5347B29D;
        Tue,  6 Sep 2022 03:50:57 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bp20so14338866wrb.9;
        Tue, 06 Sep 2022 03:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=DeZeaGmLe3sAs17o9u4aA+9IGunBSiFEik8IifS7SLk=;
        b=N7RZ/0QQzjm+knbE/RlztSF707It1haNgKph+ZBYlZgjSTSpbFx7ALekjKZ1JSbqVj
         4OmM51mK2yEhaqZi7CZy8qDmn2dwQoBCZ9jAznomYjkO/Oh6zZ289ArQ5LwEUIWyQ+vT
         UE8x1rJWGMUpRjzB70jAJlhoZdg9GIUWAUAu+no9EePC6i09sIRqrOArGJJFt8HkdESg
         4DMzrswVY1LW0/yfMNHTB1AnnSHDNy+cQfBz0M0J0AGmPb4tN/ORMr/BNxVlOrOX7Wxv
         TGKuo/oK3zSNftUeSV9vol3cSbUfQip/uqJBRvbsk1bmWRmyClHFbl0XBgiqFgRI7h1U
         OiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=DeZeaGmLe3sAs17o9u4aA+9IGunBSiFEik8IifS7SLk=;
        b=bMm/SkxzfErBfXzEAx6Ba0GsGBiNhJmvNxP4Fxu+skgo/xOblDWQ1XhyJJJd+6oEVZ
         k5LC24qpdGm5hG6Ztuz5LqdxjC//I9LRznv3xQ0lfmBaQo8kn9LAbkqVJ2BjMY+9lMyP
         xDiQ95616fJOjty1Gu3fBIFjAnjjbaAflHXdmHK8xZhbajk1+lYJcVMS6OhjzLFDGv9C
         YdgTAVXNmM3fqdAotRClZDpDRE/hGN0Pyz69fYBykm4ihI53vvlYLNkv/rvtzMkvWQs1
         Y3TfSperx/G1s9xZcGROYjg1hBzlveUPaWwBTMRcQtLB7/cWhRBA9UsO32XqVdOQ0btJ
         7Gvg==
X-Gm-Message-State: ACgBeo0YYd8Xm13pPqfcCXn+VRW8X4AjbIszopijlyIVRm1FYlKYkzsf
        gNXqEKyXBMw/XWYjEO3azT0=
X-Google-Smtp-Source: AA6agR79p5K6VeBZ3o0ywObGZXXOxpg7PafY0OT9DSE6RWchw34Oq7Z7KDr/pgwu9Xvm9agFIeSsmA==
X-Received: by 2002:a5d:47c7:0:b0:225:8905:296 with SMTP id o7-20020a5d47c7000000b0022589050296mr27986402wrc.515.1662461455554;
        Tue, 06 Sep 2022 03:50:55 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d4c8e000000b0021e4829d359sm12179006wrs.39.2022.09.06.03.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 03:50:54 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] Add subdir support to Documentation
 makefile
In-Reply-To: <3d08894c-b3d1-37e8-664e-48e66dc664ac@iogearbox.net> (Daniel
        Borkmann's message of "Fri, 2 Sep 2022 17:08:09 +0200")
Date:   Tue, 06 Sep 2022 11:21:59 +0100
Message-ID: <m2h71k6bw8.fsf@gmail.com>
References: <20220829091500.24115-1-donald.hunter@gmail.com>
        <20220829091500.24115-2-donald.hunter@gmail.com>
        <3d08894c-b3d1-37e8-664e-48e66dc664ac@iogearbox.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 8/29/22 11:14 AM, Donald Hunter wrote:
>> Run make in list of subdirs to build generated sources and migrate
>> userspace-api/media to use this instead of being a special case.
>> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
>
> Jonathan, given this touches Documentation/Makefile, could you ACK if
> it looks good to you? Noticed both patches don't have doc: $subj prefix,
> but that's something we could fix up.
>
> Maybe one small request, would be nice to build Documentation/bpf/libbpf/
> also with every BPF CI run to avoid breakage of program_types.csv. Donald
> could you check if feasible? Follow-up might be ok too, but up to Andrii.

Sure, I can look at what is needed for the BPF CI run.

> Thanks,
> Daniel
