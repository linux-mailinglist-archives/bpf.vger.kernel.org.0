Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C62263E6F4
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 02:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiLABMP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 20:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLABMO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 20:12:14 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638219077D
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:12:13 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n21so658987ejb.9
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mnOHlSbgWNGlTuLSKAr9w/gQTxjdszaO70yB5kKXlk4=;
        b=QuSDkEa4HdkznoUsvXDNpo23RguQRuL35fOKGW52e+ZSloQREOwiK9MayPsTV56XmT
         ID85fGnp8Sg8Pfj1VITOArNq8dFvNM7ap6EKsRStLU1f3XqgxV+M6xWOaTf+vPO6nhU8
         zSUq4fbroV8jwHq7EqiS+xbuj409HhkirFNplYWR8g1vbzsrqtX3XGfg3wWzagDQo6U4
         XMm0BVI7t85g0DdWaU0QreedAneMXxEcZWE08z2wAAKz6Zqg6/XYqkndKa7mKKbicExv
         tcjCF2ay32hq0/T180PCBCI/11U1/1dQ3tM/p8YQ1kXOD+XPEwIw239QChbbB3zrwCOM
         /WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnOHlSbgWNGlTuLSKAr9w/gQTxjdszaO70yB5kKXlk4=;
        b=vkbfAUL3brWmGA2NklzKxew6h1E+fE30QiNepgFKO21Av+wU0Cy3B+cmbMblHTBZEC
         mdVSOOxjshy4wGTkYBMDm6Ba1rUwS9TageI/6G3lLHy85Y1iWGyjR0Sy/KrDPWLFjZru
         zA4hdBSZH+tMkSQkJMrHRf2G6T7U/MGphBhihXcbbkspf7vOquMdPaSvj6AzZJXpA8/P
         Xuck08yGGiaHxdGnYWh94OOiRLmddDm1nW87Zm3/WPPFAk+ImKUgUITLDbwtqFkh5UfM
         YAg48a+gGOJx8uqKBk37xli+CDZrjswU95d8A/i+oKX+rGA0pRC0O2TX7uZVs1Ur4Z2r
         kdEA==
X-Gm-Message-State: ANoB5pmtzT4v+veRrkF6rqSDJ7h9M9l5wyGKkgbNB57+xv4BH8S6WD2z
        LRrjqv+3GrX/qAtjUofNNcahZzdULlkUmgctZQ280V4f
X-Google-Smtp-Source: AA0mqf68M1X8P3b3/q+7+bKx1Gs2/3DxFwckrJ6eySp4x1iD7Ea+qNc7BUQvujGbtf0020hGOT7txGOBXeZCYynOnLE=
X-Received: by 2002:a17:906:30c1:b0:7b7:eaa9:c1cb with SMTP id
 b1-20020a17090630c100b007b7eaa9c1cbmr39639842ejb.745.1669857131892; Wed, 30
 Nov 2022 17:12:11 -0800 (PST)
MIME-Version: 1.0
References: <20221128132915.141211-1-jolsa@kernel.org> <20221128132915.141211-3-jolsa@kernel.org>
 <CAEf4BzaZCUoxN_X2ALXwQeFTCwtL17R4P_B_-hUCcidfyO2xyQ@mail.gmail.com>
 <CA+khW7gAYHmoUkq0UqTiZjdOqARLG256USj3uFwi6z_FyZf31w@mail.gmail.com>
 <CAEf4Bza6R2uedPiKi_FXMPOVe-WGS5LO-EbBzpqK9T-xCybS5Q@mail.gmail.com> <CA+khW7jLegurLPiUkWx5-gVnS3rywB1NTO0dy5qDWSY+-R1mgA@mail.gmail.com>
In-Reply-To: <CA+khW7jLegurLPiUkWx5-gVnS3rywB1NTO0dy5qDWSY+-R1mgA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Nov 2022 17:11:59 -0800
Message-ID: <CAEf4BzaMjF1fZDO3qSBrVybov5yPVgTC9CBaVnQ0oRv9RfwKgw@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 2/4] bpf: Add bpf_vma_build_id_parse function
 and kfunc
To:     Hao Luo <haoluo@google.com>, Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>
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

On Tue, Nov 29, 2022 at 5:27 PM Hao Luo <haoluo@google.com> wrote:
>
> On Tue, Nov 29, 2022 at 4:35 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > This is hardly a generic solution, as it requires instrumenting every
> > application to do this, right? So what I'm proposing is exactly to
> > avoid having each individual application do something special just to
> > allow profiling tools to capture build_id.
>
> I agree. Because the mlock approach is working, we didn't look further
> or try improving it. But an upstreamable and generic solution would be
> nice. I think Jiri has started looking at it, I am happy to help
> there.
>

Ok, cool, it would be great to have this work reliably and not rely on
user-space apps doing something special here.

> > Is this due to remapping some binary onto huge pages?
>
> I think so, but I'm not sure.
>

We used to have this problem, but then Song added some in-kernel
support that we now preserve the original file information. Song, do
you mind providing details?

> > But regardless, your custom BPF applications can fetch this build_id
> > from vm_area_struct->anon_name in pure BPF code, can't it? Why do you
> > need to modify in-kernel build_id_parse implementation?
>
> The user is using bpf_get_stack() to collect stack traces. They don't
> implement walking the stack and fetching build_id from vma in their
> BPF code.

Ah, I see. Let's figure out why Song's approach doesn't work in your
case, because this anon_name hack is just that -- hack.
