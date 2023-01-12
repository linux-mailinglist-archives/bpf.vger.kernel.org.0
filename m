Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8B9667E37
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 19:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbjALSiV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 13:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238542AbjALShz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 13:37:55 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91E268CB4
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 10:09:35 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x4so10246443pfj.1
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 10:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t5QBMr0sFk9XRgwIjiMT2tjfg7T94fJD5dd8LZESWzw=;
        b=EGNwY0DCO8idBlmOgRTnbr2+2Hi3QRuLGLlFONP3uXnMFbSk4B0glkItsDkVlXxxcV
         asXL/RZQH1qXcWTYGYX5xdr1iBYmkVazXCdDTU7/iLkKjFjS67AWxZvNxlRY4BS7ZzBQ
         fLoLmrA2Mf9RE9lnrzsKY72wBej3ezlhdJQQrlkXzQzaytdEJxlZ1thtevCgJknHGnU6
         5SU0jDstU66bKFYHex6iIVEfFuL41CySCsyWi8U/tWhGHRAu30WgBInWTUNUuWWdftri
         4UMjPfsJNnRjijb/jSmDTq5Lzi1Fe4gmM6rhZnWqf6GeFTwKgKwdk03+Ufc/lfY+if2w
         aRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5QBMr0sFk9XRgwIjiMT2tjfg7T94fJD5dd8LZESWzw=;
        b=4vE9gBqXcEHk0/9umG9Ql/xwaBHGLidBc91+LbEuXnZj9mE4plXRPIyUqf7nI7oV8C
         DnXejDD+O2QLxfHQuV2zWGj7OdO89ng3TDu9L4p9kjjabzOhTTWNnumC1QErHqaBA0Hp
         TkWlAXWXMiIK8PIRG3dHsrP+6cSB7SNd/U2UbFJlodsmYDVJlImHknkVAiG0DySh+5+V
         cYhPap/d3PJ2zBQtV0ioWrZ7f+23SL8L8dPk5hdIp8XxaET3uzDfF2EJWQUhc0eh0U2R
         3VzYIXZLfEBctLm6UgbsFtiQWdhUCwFJdaRdzVQRDc+CR1GhoRy5TYlCEOMzvaFe9hd1
         1h/g==
X-Gm-Message-State: AFqh2kolXiW4VnVofZhJ92uZ8Pv6AB/MQWZQv6ElncSbBh4bJLTJZAti
        EP+YeWz1saTBJ+SE+gAw0OIAi7lDQ6Mxzk2eedLVuw==
X-Google-Smtp-Source: AMrXdXu++3Jmlz5p16BLzI03q73YycsK1MGuj3lkgQ3wo57iGRPaENAIwmYCqwFP5/VC2KYMqzQsRQ8WgCRYKCO4mJo=
X-Received: by 2002:a63:9d0a:0:b0:49f:478d:a72c with SMTP id
 i10-20020a639d0a000000b0049f478da72cmr3327579pgd.250.1673546975069; Thu, 12
 Jan 2023 10:09:35 -0800 (PST)
MIME-Version: 1.0
References: <20230112003230.3779451-1-sdf@google.com> <f074b33d-c27a-822d-7bf6-16a5c8d9524d@linux.dev>
 <2f76e7d6-1771-a8f5-4bd1-6f7cd0b59173@gmail.com>
In-Reply-To: <2f76e7d6-1771-a8f5-4bd1-6f7cd0b59173@gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 12 Jan 2023 10:09:23 -0800
Message-ID: <CAKH8qBtg-SW4PcQ+EbqoQCme38kgh4gkj-698Wmg8iWLA8qtNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 00/17] xdp: hints via kfuncs
To:     Tariq Toukan <ttoukan.linux@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>, bpf@vger.kernel.org,
        xdp-hints@xdp-project.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 12, 2023 at 12:19 AM Tariq Toukan <ttoukan.linux@gmail.com> wrote:
>
>
>
> On 12/01/2023 9:29, Martin KaFai Lau wrote:
> > On 1/11/23 4:32 PM, Stanislav Fomichev wrote:
> >> Please see the first patch in the series for the overall
> >> design and use-cases.
> >>
> >> See the following email from Toke for the per-packet metadata overhead:
> >> https://lore.kernel.org/bpf/20221206024554.3826186-1-sdf@google.com/T/#m49d48ea08d525ec88360c7d14c4d34fb0e45e798
> >>
> >> Recent changes:
> >>
> >> - Bring back parts that were removed during patch reshuffling from "bpf:
> >>    Introduce device-bound XDP programs" patch (Martin)
> >>
> >> - Remove netdev NULL check from __bpf_prog_dev_bound_init (Martin)
> >>
> >> - Remove netdev NULL check from bpf_dev_bound_resolve_kfunc (Martin)
> >>
> >> - Move target bound device verification from bpf_tracing_prog_attach into
> >>    bpf_check_attach_target (Martin)
> >>
> >> - Move mlx5e_free_rx_in_progress_descs into txrx.h (Tariq)
> >>
> >> - mlx5e_fill_xdp_buff -> mlx5e_fill_mxbuf (Tariq)
> >
> > Thanks for the patches. The set lgtm.
> >
> > The selftest patch 11 and 17 have conflicts with the recent changes in
> > selftests/bpf/xsk.{h,c} and selftests/bpf/Makefile. eg. it no longer
> > needs XSK_LIBBPF_FLAGS__INHIBIT_PROG_LOAD, so please respin. From a
> > quick look, it should be some minor changes.
> >
> > Not sure if Tariq has a chance to look at the mlx5 changes shortly. The
> > set is getting pretty long and the core part is ready with veth and mlx4
> > support. I think it is better to get the ready parts landed first such
> > that other drivers can also start adding support for it. One option is
> > to post the two mlx5 patches as another patchset and they can be
> > reviewed separately.
> >
>
> Hi,
> I posted new comments.
> I think they can be handled quickly, and still be part of the next respin.
>
> I'm fine with both options though. You can keep the mlx5e patches or
> defer them to a followup series. Whatever works best for you.

Either way is fine with me also. I can find some time today to address
Tariq's comments and respin if that works for everybody.

> Tariq
