Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8AD645258
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 03:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLGC6l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 21:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLGC6k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 21:58:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C560652142
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 18:58:39 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id e13so23029650edj.7
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 18:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Clygi83A8MpV1rkWNOF1P0l9GPbU5ZoZ1SBbS/oeot8=;
        b=WB5ULzyCren5nfhW1fe0Xvl5vSVX4j+E3RYYtyqBLP3UOXUoDeSYR8l+H/NWZqa+0s
         FnvzRWyLeVhabeHvEmAdt1hciZoHCWI5MJlWOjrwttT2lbLnhhp+GSglfZdmFzCocp4q
         lMFKXZgTi15ZyJnLqNS0Bpp65O0hJukgcKGQCEkJiTEooIUE4dGEazYAI9BzWTbum/15
         0I2zQE0dd4Xl+JG9OtIm3V5AAn0DfjFuniDbsf68KweO1GISJmxpDHpe5vb87BCXWhHx
         Knxxa5QZFFKRZnD/DjtaMGcFbtbq7AzdnIsjByRS2o8bXgssKM+svqQPU3K/OaWXqJLR
         JIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Clygi83A8MpV1rkWNOF1P0l9GPbU5ZoZ1SBbS/oeot8=;
        b=ebl5ELb+WC952Cl+lBz+ay4X0nkpWJuwGrjDnZLUd6BIKhhVmIeCO5eIjNbBp1uBSD
         Sc8fcFo/qJuBUA5QqH41Q/HGsRNifLSODjZYg0frNte22dTaGE9Q1Vswnl/EDqxt+DCJ
         YYWFoF5EAtmjZqYIOZxxKv0mFlljxAPMd5nONyAKAM72H6twBNpguE2zEGKAQ1b/mtfn
         X1N4kZ8G0Zu1i3NcHywnLA0ImHnmxVnrsQ8VncE4c9aHR1sj/tR8PQP6Rm74cOEd7/dk
         DSF/2P6KzSWFHtO4tam5ImC4NlxH5VDCbI0QLYzhfRKrJQQ3d+LzUSF5qfTEp1TKhYLX
         viCQ==
X-Gm-Message-State: ANoB5pnvnWkv5AifDvjIOL6kZhizIcLBCN7Lnr07nVGHJclHxBGf/6Rr
        +wh08B27B2uU54GpumVdYqlmTQ5gYuXfMUh2AUc=
X-Google-Smtp-Source: AA0mqf6TCgWvqIIBX8B97lUI4nN4miglj6llUFq5CT3/cjMGcyL4AYw1YdeeAVhHbQcpc93PaTPJr0plAP5eSW0n4Ls=
X-Received: by 2002:a50:ed90:0:b0:46a:e6e3:b3cf with SMTP id
 h16-20020a50ed90000000b0046ae6e3b3cfmr43378648edr.333.1670381918094; Tue, 06
 Dec 2022 18:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20221206042946.686847-1-houtao@huaweicloud.com>
 <20221206042946.686847-2-houtao@huaweicloud.com> <05d1f326-55cc-d327-9e0a-e93add2a29cf@meta.com>
 <86fd4485-a016-d6f6-c31b-3aa76c261e91@huaweicloud.com>
In-Reply-To: <86fd4485-a016-d6f6-c31b-3aa76c261e91@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 6 Dec 2022 18:58:26 -0800
Message-ID: <CAADnVQ+zWyP9Hy--RLyZ6-VUEr-D6kXoFmV2L1Y4b0H=RHQbCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Reuse freed element in free_by_rcu
 during allocation
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Hou Tao <houtao1@huawei.com>
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

On Tue, Dec 6, 2022 at 6:20 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 12/7/2022 9:52 AM, Yonghong Song wrote:
> >
> >
> > On 12/5/22 8:29 PM, Hou Tao wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> When there are batched freeing operations on a specific CPU, part of
> >> the freed elements ((high_watermark - lower_watermark) / 2 + 1) will
> >> be moved to waiting_for_gp list and the remaining part will be left in
> >> free_by_rcu list and waits for the expiration of RCU-tasks-trace grace
> >> period and the next invocation of free_bulk().
> >
> > The change below LGTM. However, the above description seems not precise.
> > IIUC, free_by_rcu list => waiting_for_gp is controlled by whether
> > call_rcu_in_progress is true or not. If it is true, free_by_rcu list
> > will remain intact and not moving into waiting_for_gp list.
> > So it is not 'the remaining part will be left in free_by_rcu'.
> > It is all elements in free_by_rcu to waiting_for_gp or none.
> Thanks for the review and the suggestions. I tried to say that moving from
> free_by_rcu to waiting_for_gp is slow, and there can be many free elements being
> stacked on free_by_rcu list. So how about the following rephrasing or do you
> still prefer "It is all elements in free_by_rcu to waiting_for_gp or none."  ?
>
> When there are batched freeing operations on a specific CPU, part of the freed
> elements ((high_watermark - lower_watermark) / 2 + 1) will be moved to
> waiting_for_gp list  and the remaining part will be left in free_by_rcu list.

I agree with Yonghong.
The above sentence is not just not precise.
'elements moved to waiting_for_gp list' part is not correct.
The elements never moved into it directly.
Only via free_by_rcu list.

All or none also matters.
