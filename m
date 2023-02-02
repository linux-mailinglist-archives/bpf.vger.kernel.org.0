Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4E168856D
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 18:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjBBRcb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 12:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjBBRcZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 12:32:25 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C065B74A4E
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 09:32:15 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so2497763pjb.5
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 09:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HuyVsSMV1aQwyV3j6toXzGhoibHAp15bMSPIrl5X/iQ=;
        b=ogaLpO6+zk+gU/nMTEHsHZ0Dj7a1J/5FfpnNFOxFzqy2KmIp7DIQzK8Gju+lzl+mqJ
         tyXoS6NouFltkqIyV+lAryzhRxQ0Uh6tU7+obaR9nuBITSj5y3MPEdCecLGc7/D2VlpE
         C3Z4ZD+qfSbbanI8pPaFbDTMrSTXoiJGWoXTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HuyVsSMV1aQwyV3j6toXzGhoibHAp15bMSPIrl5X/iQ=;
        b=bo9zDzOc/MWbKPxmY0GN1DwabaBTGxXVxfATtsynPj435pEZeyhnzxXaf84eHAOB6Q
         ATVVFkUYobpYk9bFoC5T3e1VigJzI+sG6cnFLgRKVWVF92R1P28t2g5cm4NnbgndTYU1
         rN09J3f13G+C/++mok541jph5ytoTVQTkpVoU3/z+Dx7cq0gAer3eLW5IGShsW26cBZY
         H+buVkWVoY10M0kgpzFXRmSGVM3+6a+9TAxFmoNg9TL9fK1mAKMT+UgOcuZeofz6vqDu
         HG8kCzGIhJCVsdqP1lHuGBEt25dIQdVFVIkZ8EuDlLrJ8429b+0lJPKDBXghHv4Gg6at
         hfWg==
X-Gm-Message-State: AO0yUKWfbW6XnnUrQUPzXglspW8ayqXXx8BMT3ly8UQ4d1qd6/E73HTQ
        B+gyqnozDOnqDNrkS0APdM3/gSqi6cK8LMFZgTuNQA==
X-Google-Smtp-Source: AK7set/ouNligxe7/BceEKZ3iqgAgATXe+6gHnQD9Jx1q+jiw39aWDBDBvb0I7nDvH3TWpIMEhRlwmW+FZLADcRqReg=
X-Received: by 2002:a17:90a:6986:b0:22c:71ed:629d with SMTP id
 s6-20020a17090a698600b0022c71ed629dmr716540pjj.10.1675359135127; Thu, 02 Feb
 2023 09:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20230201163420.1579014-1-revest@chromium.org> <85af713d-00fe-b113-1331-1a44480c016f@huawei.com>
 <eacfbd23-da92-3572-7f57-3de425117c8a@iogearbox.net>
In-Reply-To: <eacfbd23-da92-3572-7f57-3de425117c8a@iogearbox.net>
From:   Florent Revest <revest@chromium.org>
Date:   Thu, 2 Feb 2023 18:32:04 +0100
Message-ID: <CABRcYmK8AP7_aL_NqJfNYgGzzpDp2x33qdzOkDxbUECxj2F-RQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add ftrace direct call for arm64
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Xu Kuohai <xukuohai@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        andrii@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
        xukuohai@huaweicloud.com, Manu Bretelle <chantra@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 2, 2023 at 11:50 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 2/2/23 9:36 AM, Xu Kuohai wrote:
> > On 2/2/2023 12:34 AM, Florent Revest wrote:
> >> This series adds ftrace direct call support to arm64.
> >> This makes BPF tracing programs (fentry/fexit/fmod_ret/lsm) work on arm64.
> >>
> >> It is meant to apply on top of the arm64 tree which contains Mark Rutland's
> >> series on CALL_OPS [1] under the for-next/ftrace tag.
> >> > The first three patches consolidate the two existing ftrace APIs for registering
> >> direct calls. They are split to make the reviewers lives easier but if it'd be a
> >> preferred style, I'd be happy to squash them in the next revision.
> >> Currently, there is both a _ftrace_direct and _ftrace_direct_multi API. Apart
> >> from samples and selftests, there are no users of the _ftrace_direct API left
> >> in-tree so this deletes it and renames the _ftrace_direct_multi API to
> >> _ftrace_direct for simplicity.
> >>
> >> The main benefit of this refactoring is that, with the API that's left, an
> >> ftrace_ops backing a direct call will only ever point to one direct call. We can
> >> therefore store the direct called trampoline address in the ops (patch 4) and
> >> look it up from the ftrace trampoline on arm64 (patch 7) in the case when the
> >> destination would be out of reach of a BL instruction at the ftrace callsite.
> >> (in this case, ftrace_caller acts as a lightweight intermediary trampoline)
> >>
> >> This series has been tested on both arm64 and x86_64 with:
> >> 1- CONFIG_FTRACE_SELFTEST (cf: patch 6)
> >> 2- samples/ftrace/*.ko (cf: patch 8)
> >> 3- tools/testing/selftests/bpf/test_progs (both -t lsm and -t fentry_fexit)
>
> Thanks a ton for working on this!
>
> > so it's time to update DENYLIST.aarch64 to unblock tests that failed due to lack of direct call.

That's a good point Xu, thanks! I'll update the deny list in my next revision.
It looks like this series fixes *a lot* of these tests, so that's exciting. :)

> +1, with regards to logistics, if possible it might be nice to eventually gets
> this into a feature branch on arm64 tree, then we could pull it too from there
> for bpf-next and hash out the BPF CI bits for arm64 in the meantime.

I believe that Manu Bretelle already wired up the BPF CI for arm64, is
there more work required ?
Regarding the logistics, whatever works sgtm... :) I suppose it's up
to Catalin or Will.
