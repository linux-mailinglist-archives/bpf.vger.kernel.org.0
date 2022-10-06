Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DD85F5E1F
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 02:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJFA7L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 20:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJFA7K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 20:59:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519032DB
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 17:59:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19B0DB81FC5
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 00:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7B4C433D6
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 00:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665017947;
        bh=ZvSIYXlSnKWnl5O8WfMm0k3qXjZYTovjDBWxDqD2MTc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QH7c/iUd4mEBZCo4y4Yc6NKc6zPlw8iiI9yIIedH4houkyYhVcTxMiaNxqrsaRjcW
         OWjOJh/jKkRUZ0g4yUhP9VsQVDx8K8buJeNUbdXeXKr0TxQvO+5fca29TBNbOZkfXa
         Zsb4E772sLwAobp71ZT1rmYTeH4L3r3zOu7z2hmBrgpW5c8OMFPtxj7VZo1LNW2yt7
         /H7PdIRX3X5iFUp5X/NX2nlx5fqCxPKqGvOF8AwHa5Uf1AgNl0kvWHbocCSnsgpjkQ
         rwGTYjjlJZHSjaQg/8ytGraoykN8QXRiz5HeYJQ8d9YbEBWYT9CI5Q5aa6yMEkA6J4
         0OwbI+E1ji4Ow==
Received: by mail-lf1-f44.google.com with SMTP id bu25so507562lfb.3
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 17:59:07 -0700 (PDT)
X-Gm-Message-State: ACrzQf24LsCf/DOAxUUBFZL7SdsIJhiu+R7Y0WvNGY708jxQSgKWa65Y
        Yzn057olEazWgW3ZV8sd2eDgf3bUBoX0pnTAXJebsQ==
X-Google-Smtp-Source: AMsMyM70SjD+l3Gt1PY51LHgR0PUvkq/zc9I963udBnVbZmA8v94RBShn9i5/Ji8+L5AiuvUF30I3hsNsR2m0aeIakU=
X-Received: by 2002:ac2:50da:0:b0:4a2:44dc:b719 with SMTP id
 h26-20020ac250da000000b004a244dcb719mr799671lfm.652.1665017945601; Wed, 05
 Oct 2022 17:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <CACYkzJ5X-ShtGKHshSt74=5faZW5jWUBWyq7bzfs6x1f4jb65Q@mail.gmail.com>
 <20221005170039.3936894-1-jmeng@fb.com>
In-Reply-To: <20221005170039.3936894-1-jmeng@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 5 Oct 2022 17:58:53 -0700
X-Gmail-Original-Message-ID: <CACYkzJ4si6YcfKOVWMTHW2kVFcG5HuNS2CJ+LSaDhv4nT_sJFg@mail.gmail.com>
Message-ID: <CACYkzJ4si6YcfKOVWMTHW2kVFcG5HuNS2CJ+LSaDhv4nT_sJFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf,x64: Remove unnecessary check on
 existence of SSE2
To:     Jie Meng <jmeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 5, 2022 at 10:01 AM Jie Meng <jmeng@fb.com> wrote:
>
> SSE2 and hence lfence are architectural in x86-64 and no need to check
> whether they're supported in CPU. SSE2's CPUID flag is still set to
> maintain backward compatibility with older code or code shared with x86,
> but bpf_jit_comp.c is compiled under x86-64 exclusively so the check is
> redundant.
>
> Signed-off-by: Jie Meng <jmeng@fb.com>

Acked-by: KP Singh <kpsingh@kernel.org>
