Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46565BFE2
	for <lists+bpf@lfdr.de>; Tue,  3 Jan 2023 13:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbjACMcF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 07:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbjACMcE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 07:32:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1B6FD3A
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 04:32:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50CFD61234
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 12:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC111C433F0
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 12:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672749122;
        bh=ZfFVu6/VEmf01cNN3Hpd4+n2awjxm1gjNPAfMihfTgQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FWmbtCpIRiT22PIuiqUsNSzySDhsHsntl2xQM6VCUC6ToRD6mTvBurmWerHbekdfz
         6lLZ0NQq1RpBFMGZN6kxmqBeP/My3aU+uX6pD4qF8FDZuYRexPyGEmVmrprnEZxU2D
         pGw0QJW6pw2lOz+6fq8VUo2hMlFPn5xti5YWYLj3th5/mf0SfhTx/8OO8jNz2sirk1
         3KpzWC47XSt75JugboyMgMiYuyqc2nM2dOY/a42wOySB0baa1MhGljyPj/CRc9ABXZ
         9FGfKXKi33oeggGbxLPu2LtMH+0oAhAl4ybIVxUXFZnkShfaGPySRToZtXdCjpmkZa
         7+RH5mDCxKxng==
Received: by mail-ed1-f47.google.com with SMTP id m21so43530338edc.3
        for <bpf@vger.kernel.org>; Tue, 03 Jan 2023 04:32:02 -0800 (PST)
X-Gm-Message-State: AFqh2kpZD1dhB2OW4YuWd1VxXG/yXLC/MA7BujRV/2oNxCCiR9Qbap/w
        4GuzSL3505/yEu9Sakih2JsF0M9QbpMmxd2bMpU=
X-Google-Smtp-Source: AMrXdXvc+wmSp+1x4TmjAF1Z2JGlDV1vnAKvpt87+OFqwtTjwAXLZ010qiBExvlVNgI8zdrhkqPAwbrA+E29jLos2fM=
X-Received: by 2002:a05:6402:3809:b0:48a:5f4c:c1a with SMTP id
 es9-20020a056402380900b0048a5f4c0c1amr1361103edb.298.1672749120936; Tue, 03
 Jan 2023 04:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20221231100757.3177034-1-hengqi.chen@gmail.com>
 <CAAhV-H6hdXXE4EwFe66rUxJMixc=s7PYuxeyCjaQ5z3Fck40jA@mail.gmail.com> <9d2d3268-6558-2387-7d26-0fc51c365204@iogearbox.net>
In-Reply-To: <9d2d3268-6558-2387-7d26-0fc51c365204@iogearbox.net>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 3 Jan 2023 20:31:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7+XeCmxCbpEqWzDt+S_UabPLyyn+uGe7qCkr-HbYCRrQ@mail.gmail.com>
Message-ID: <CAAhV-H7+XeCmxCbpEqWzDt+S_UabPLyyn+uGe7qCkr-HbYCRrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Add LoongArch support to bpf_tracing.h
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
        loongarch@lists.linux.dev, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

OK, bpf-next is also fine for me.
Acked-by: Huacai Chen <chenhuacai@loongson.cn>

On Tue, Jan 3, 2023 at 8:28 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 1/3/23 7:53 AM, Huacai Chen wrote:
> > LGTM, I will queue this patch for loongarch-next if no one has
> > objections. Thank you.
>
> To avoid potential merge conflicts for the next dev cycle, any objections if
> you could Ack it and we'd take it via bpf-next tree instead?
>
> Thanks,
> Daniel
