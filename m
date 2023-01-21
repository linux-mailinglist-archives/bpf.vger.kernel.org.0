Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D346762C9
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 03:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjAUCAj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 21:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjAUCAi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 21:00:38 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6466844B4
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 18:00:37 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mp20so18188618ejc.7
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 18:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W5AjEQMUms3wZAaQ0/+ai3+mScNvSG/FDQX2e05dFhY=;
        b=JdNOc5F/tuo49f4HkdS4UKzPUh7Yz9dHw4vTrf6KPbuFfpNbj+XKPwWZUnIAE3NkAo
         2ymnkMidQuFbIHFtBhIrAkzPsZ4IUaUheiwZ22QqvyylCT6JYJhOGYPYn8jRGfvm3MNZ
         V8DKdx9hjkl82Ou+Vlwpd2zJ9RoONskCcpCcCTavu7+Uc3VTYW7QgADy/mQklPTWoYJo
         BD3Aei6VVXX1YwCGrAXFdReivtmQR9qYbZNiAiJ9Mh5q36ag+xB3EojgeihYlo9n4hFr
         X+dXAcow58ieG/6kSLQWA6dyAaBDG+CvZB5poLqLcPaBRLnsW8IAAttGoBWSjC3juM39
         Q0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5AjEQMUms3wZAaQ0/+ai3+mScNvSG/FDQX2e05dFhY=;
        b=YoFa6hQQavM0QOqHWMSMV+BYPZ86OLtR3ZQmD4X+exp8J9zpMe1jsLpAS//53ih7G7
         CDqz3SPO133QIsYwCMmdpi4k4NirDFCODqWTPL39aRtVSxGhaPUjh1Jum9NkRU8/+GKD
         HR9zSC38cv3DAenBU8RbQM2kvd3fjXe0EmwJN5Uqq07bJa7TfvgCD3GpG8nwJ292OY/8
         y8wyg8pYU/j9rduZJr0HUwv/bsMbA4f7lO68fsYZ0W+Afmof1Yw5iQmYVS8Aj1Vu51Ll
         0eBcBT+S7i4KSXTnHGtw/YINjVKmw0kRn582TQBptnJmgVB4SOQeuu8niDwbs9pRDKs9
         pniA==
X-Gm-Message-State: AFqh2koP43YAzpBeCyrM8eBxvtTlY+UE6Z+Bc7wRIxUCAKTvVDDFN9nU
        tRkPNnJ4vKhfpq5LrWIwvHz5+qRkEpUi1tbX77XFeaHp
X-Google-Smtp-Source: AMrXdXueY5uARI8hVDI8TBD/bnQgoyD5ouxMAdg1AKhU8fObJ5XA8S+VhXqH3E8sVwv8cCUbrqPbackvuVU8hpCQ8OE=
X-Received: by 2002:a17:906:9417:b0:85f:f115:65d2 with SMTP id
 q23-20020a170906941700b0085ff11565d2mr1456140ejx.555.1674266435856; Fri, 20
 Jan 2023 18:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20230121002241.2113993-1-memxor@gmail.com>
In-Reply-To: <20230121002241.2113993-1-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 20 Jan 2023 18:00:24 -0800
Message-ID: <CAADnVQJWh3e7tx5id2Wan7Xdskt0SU89bHLBv+dYoEPnKjR2vg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 00/12] Dynptr fixes
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
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

On Fri, Jan 20, 2023 at 4:22 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> This is part 2 of https://lore.kernel.org/bpf/20221018135920.726360-1-memxor@gmail.com.
>
> Changelog:
> ----------
> v4 -> v5
> v5: https://lore.kernel.org/bpf/20230120070355.1983560-1-memxor@gmail.com
>
>  * Add comments, tests from Joanne
>  * Add Joanne's acks

This is great already.
Let's address any further comments in the follow up.
Thank you for fixing these issues.
Applied.
