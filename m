Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EB96F07B8
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 16:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243918AbjD0Own (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243687AbjD0Owm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 10:52:42 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7C63A91
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 07:52:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24b725d6898so4531180a91.2
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682607160; x=1685199160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZCjiiUEhocJh8EcIZIdRkNd6F/bSQ0KBGqjZwD6z08=;
        b=cdFLQiRuHp/Z3bh6f4c/MsqzKq8CUSLEjtazY4Q4/pcLfXnUihWIvkMl6fTJ6lr1a4
         1YF1h3iPsCINeI8Dt/kNFLj7rOA7LqWbMRpISPYjZgg1gqj6CB21uH7+CjRboPOsqVnr
         JemkiZPZrZEpMBOQucc5vG8zQyj7q5TGnEAQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682607160; x=1685199160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZCjiiUEhocJh8EcIZIdRkNd6F/bSQ0KBGqjZwD6z08=;
        b=N2WzG+5+2ZrvrakhNCyZtvBkS0xfSlCqO1on2ZoKw6YJLNRcUxG/qyEAmQVA6JeQCq
         tiyZ6HjFcJ8SucTdDyX9BIwF/nZ1vq8sD3tE9QMYi1ooCJRNCvd4qQZQOQ0Zm8UtjyzY
         IFjOpUuXUN3juNCwi1QMx5THVSaOMz+QPX6PmPe7dJ1i1bD4Lch4rd+1Nhsh2j9OZ5ds
         q2AaCQ9h3/F3NVYZqkdOz9IptN7yjRzIp5In9rVKq/MIaCH76wsOe0gJimb3gmneomW4
         qnqjbfAPOBJrwCP4VSatGrT026gMSiH2+Q5xAScWxEIcSOx2aR4mnDiZw5ugI2YisnK9
         XW+g==
X-Gm-Message-State: AC+VfDycLGx1XBjQU/SaB68+NhW9TnPT6LZJQIM9JfPY9EG0oCra0fV1
        bWlYc7qCWG+cP8Y+LryB2Mb36S6w2FKeEozg41ndwGGSCzgUHHXCt1k=
X-Google-Smtp-Source: ACHHUZ5+pBl5s15fvZt5buu5ioeTiVQ7TmPuztirUpwa4fO6WAd6oHuubAUTDvjGemGZfqi6ZpFvepLNqRvmQBBWJQU=
X-Received: by 2002:a17:90b:8d3:b0:23b:2f4a:57bb with SMTP id
 ds19-20020a17090b08d300b0023b2f4a57bbmr2189756pjb.10.1682607160614; Thu, 27
 Apr 2023 07:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230427143207.635263-1-revest@chromium.org>
In-Reply-To: <20230427143207.635263-1-revest@chromium.org>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 27 Apr 2023 16:52:29 +0200
Message-ID: <CABRcYm+O-_GGhnAmJW6_=9vKeKSvzVLcxBRq3Pfjb3W0_HNjhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Update the aarch64 tests deny list
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, mykolal@fb.com, martin.lau@linux.dev,
        song@kernel.org, xukuohai@huaweicloud.com, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 27, 2023 at 4:32=E2=80=AFPM Florent Revest <revest@chromium.org=
> wrote:
>
> This patch updates the list of BPF selftests which are known to fail so
> the BPF CI can validate the tests which pass now.

Note: I tested this denylist a few months back by sending a manual PR
to https://github.com/kernel-patches/bpf.
At the time, it worked
https://github.com/kernel-patches/bpf/actions/runs/4106542133/jobs/70855147=
61
(even though there seemed to be a known flake in the gcc variant but
unrelated to the new arch support)

Every time I wanted to have the CI run on my PRs, I had to annoy Manu
by email (I wouldn't have the rights to trigger the CI by myself
otherwise). So I haven't tested this *actual* patch rebased on the
current CI before sending it to the list. (e.g. the
module_fentry_shadow test has been added since then and I just assumed
it would pass in CI like the rest)

My understanding is that this patch should soon be picked up by the
testing bot and we can use that CI run to check that everything works
as intended. Let's wait for a CI green light before merging this! :)
If there are errors I'll send a v2
