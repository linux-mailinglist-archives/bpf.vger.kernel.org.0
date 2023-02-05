Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC7568B1EA
	for <lists+bpf@lfdr.de>; Sun,  5 Feb 2023 22:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBEVRg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Feb 2023 16:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBEVRg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Feb 2023 16:17:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07D914211
        for <bpf@vger.kernel.org>; Sun,  5 Feb 2023 13:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675631812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZdO+ViRX7h8F4005kAi6tep18hwJGDJ/MJnCF/B1SDA=;
        b=iXGiiwKNeZaTJEa5QIMgm/mxfWFJj0/fbvyLw96R+fjoM0cbVEC0OGR6qUCEYZBwqYpXfF
        8QQLy5DyWFaxFYHOz9m4jkSClXCEIX6TfiQkvPkitksY+oe8AdvHgdQUdfnazsWVqZZJV5
        ssVy3UePkKk3W17uaFmgAcl8gMPl03o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-98-75oRx2mVNJmnaAXOxK1naQ-1; Sun, 05 Feb 2023 16:16:49 -0500
X-MC-Unique: 75oRx2mVNJmnaAXOxK1naQ-1
Received: by mail-ej1-f72.google.com with SMTP id he34-20020a1709073da200b00887ced84328so7295315ejc.10
        for <bpf@vger.kernel.org>; Sun, 05 Feb 2023 13:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdO+ViRX7h8F4005kAi6tep18hwJGDJ/MJnCF/B1SDA=;
        b=fZSSBR59Ps3YBYgUjkl0vzcJeBh/oAJoDcftfy1O5KnxX9RDVkop8FkHLOHXqyH1q1
         a54ypCCLrRuiURUAQiZGoA/wIzut3PwqXuwQh6Jx2zpdCeIa+9PqZwVqiVfBVfgh4IYU
         q6GICD/Fo8rv+gv0BLhm4nsMsl4+j8rekKvYg2tCG2o4hOV6t0wPwajD8zFHVksl2BS1
         ckZDUlJrE0hOU+YNuPxTJulXwNdd+x8uP+e7dz8izD2vbNHc+WuIuMVfR91Bq0zv1XpK
         l3LQ0s97ADEygenP8/bdFFHxQtCBq8zmqptqSndiQ9Xno5oxO5zS+6S8SbNlHO6FK5kU
         yLgQ==
X-Gm-Message-State: AO0yUKWBb/df5UrtAhI9gx8SXdCxYYP9FMHgrOtx6qSipx0iqrGd8E2+
        DY7RNKiUyyGp37XOZ/Grl5WzpcuWZY6BKXt41l+fNdfYsKShpDFpQ3WqtVdnRhxez3L22iSEuKO
        6zSrGQFV/cxLn
X-Received: by 2002:a17:906:bc8d:b0:88a:a335:4921 with SMTP id lv13-20020a170906bc8d00b0088aa3354921mr18919910ejb.56.1675631808302;
        Sun, 05 Feb 2023 13:16:48 -0800 (PST)
X-Google-Smtp-Source: AK7set9BfKumG1AxyoKv3bIgiBbEiPC/KdmTTJT0gVtglQpcPr8KcESbvxU/PMNdhQT3alMCtqpKuA==
X-Received: by 2002:a17:906:bc8d:b0:88a:a335:4921 with SMTP id lv13-20020a170906bc8d00b0088aa3354921mr18919886ejb.56.1675631807942;
        Sun, 05 Feb 2023 13:16:47 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id pj23-20020a170906d79700b0086d70b9c023sm4567847ejb.63.2023.02.05.13.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 13:16:47 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0546A9730E2; Sun,  5 Feb 2023 22:16:45 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, brouer@redhat.com, bagasdotme@gmail.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH bpf-next v3] bpf/docs: Document kfunc lifecycle /
 stability expectations
In-Reply-To: <Y+AUm8cikB6m978j@pop-os.localdomain>
References: <20230203155727.793518-1-void@manifault.com>
 <20230203155727.793518-2-void@manifault.com>
 <Y+AUm8cikB6m978j@pop-os.localdomain>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 05 Feb 2023 22:16:45 +0100
Message-ID: <87mt5rdd8i.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cong Wang <xiyou.wangcong@gmail.com> writes:

> On Fri, Feb 03, 2023 at 09:57:27AM -0600, David Vernet wrote:
>> BPF kernel <-> kernel API stability has been discussed at length over
>> the last several weeks and months. Now that we've largely aligned over
>> kfuncs being the way forward, and BPF helpers being considered
>> functionally frozen, it's time to document the expectations for kfunc
>> lifecycles and stability so that everyone (BPF users, kfunc developers,
>> and maintainers) are all aligned, and have a crystal-clear understanding
>> of the expectations surrounding kfuncs.
>> 
>> To do that, this patch adds that documentation to the main kfuncs
>> documentation page via a new 'kfunc lifecycle expectations' section. The
>> patch describes how decisions are made in the kernel regarding whether
>> to include, keep, deprecate, or change / remove a kfunc. As described
>> very overtly in the patch itself, but likely worth highlighting here:
>> 
>> "kfunc stability" does not mean, nor ever will mean, "BPF APIs may block
>> development elsewhere in the kernel".
>> 
>> Rather, the intention and expectation is for kfuncs to be treated like
>> EXPORT_SYMBOL_GPL symbols in the kernel. The goal is for kfuncs to be a
>> safe and valuable option for maintainers and kfunc developers to extend
>> the kernel, without tying anyone's hands, or imposing any kind of
>> restrictions on maintainers in the same way that UAPI changes do.
>
> I think they are still different, kernel modules are still considered as
> a part of kernel development, while eBPF code is not that supposed to be
> kernel development, at least much further. Treating them alike is
> misleading, IMHO.

If you read the actual documentation text added to kfuncs.rst this
difference is indeed called out. But you're right that "treated like" in
the commit message is probably a bit strong.

>> In addition to the 'kfunc lifecycle expectations' section, this patch
>> also adds documentation for a new KF_DEPRECATED kfunc flag which kfunc
>> authors or maintainers can choose to add to kfuncs if and when they
>> decide to deprecate them. Note that as described in the patch itself, a
>> kfunc need not be deprecated before being changed or removed -- this
>> flag is simply provided as an available deprecation mechanism for those
>> that want to provide a deprecation story / timeline to their users.
>> When necessary, kfuncs may be changed or removed to accommodate changes
>> elsewhere in the kernel without any deprecation at all.
>
> This fundamentally contradicts with Compile-Once-Run-Everywhere
> https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-portability-and-co-re.html
> Could you add some clarification for this too? Especically how we could
> respect CO-RE meanwhile deprecating kfuncs?

Well, CO-RE doesn't work for kfuncs, currently, so... :)

What do you mean "respect CO-RE", though? CO-RE is a tool to make BPF
programs more portable, so not sure how one would "respect" that?

> BTW, not related to compatibility, but still kfuncs related confusion,
> it also contradicts with Documentation/bpf/bpf_design_QA.rst:
>
> "
> Q: Can BPF functionality such as new program or map types, new
> helpers, etc be added out of kernel module code?
>
> A: NO.
> "
>
> The conntrack kfuncs like bpf_skb_ct_alloc() reside in a kernel
> module.

Yup, good point, we should update that. I'll send a patch...

-Toke

