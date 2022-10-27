Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064DC61037F
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 22:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbiJ0UzN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 16:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237491AbiJ0Uyd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 16:54:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB724A2A83
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 13:46:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kt23so8053878ejc.7
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oLClB1ARpHkTkku/IM30L9kBGVS2xVXx5L98MjyTQSg=;
        b=U6XqbbRkry+LhrafHU56Fhq8jOBG12GFl+Hf98pzSLSLjvhrBabiDKovl0cVfmfZ0H
         6OKgXIiFV5w8TWSkz8/ZLJhxMz50OnI9VncW4vikGIXl6YJcc7zeVyGNRgrWPWS0v+ss
         L0JDKSszYygP3KEda9iQNeQhIqTxAqYBGjDH/jpzET2Q0V/CT3Jr1LUO1UMjlUBQ9Jkj
         9HLj3N+0YnJGbeMWs+pRaeFnlGj7C1Jm1ODoz4uZn68YzvS59fmZVVWWoW1BATg1rTQz
         F8qNlImA6rxFZ1bU7f/gE3E8+brLYFRx/O38gz5VmCNgg6TTmBX7feQP3gyePjz/fhmq
         6ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLClB1ARpHkTkku/IM30L9kBGVS2xVXx5L98MjyTQSg=;
        b=e+JcoX4k3BjjpoqTqArj7uYxbsMilcvuOfUSNonhrFDDWXsYqWBHPAlRSvqGLbR4A1
         Ne4+0izPwnnkOJC+2h9GFU8Vg626bdq8j+7Um9iT/f8tJ+buigjsyzu8YamxOlzyc5XC
         yg6395oKrmC+vGlYzkPRdcflZTb5TMCLdfe3P8HJwJARwei6xiEUmjNjf8iPNBjcCzqo
         nM9b6J2Qtba/WNIx6QWgGx233pERaFl6Sx4gQN66Fdu10XLFqaIla3ZtB5L69ggamloS
         g1rjnj3vHT5IMv1Ew40mOPXWovRAT0MZ3gZa/UcWNdGE5AU/rgMPKs/mvfT/QgpyCBiu
         YELQ==
X-Gm-Message-State: ACrzQf38cdCnS199grRCendykXHhQljuk23dlObEmu9fD7lFop+yX0b8
        e2+XKiC+Eybgcx+oeSkXLf82fp2O8CdGHjwAXkU=
X-Google-Smtp-Source: AMsMyM6MtERyDRvOU982ZbFM3x2m8GE3/kh4kVKTc0aNmWWx6Z2QytDvyLvJLJcKIB2lyWhtVw+EMi4b+rhyIMVYLJI=
X-Received: by 2002:a17:907:1c88:b0:7ad:8f76:699e with SMTP id
 nb8-20020a1709071c8800b007ad8f76699emr4323820ejc.114.1666903593450; Thu, 27
 Oct 2022 13:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <5c8b7d59-1f28-2284-f7b9-49d946f2e982@linux.dev>
In-Reply-To: <5c8b7d59-1f28-2284-f7b9-49d946f2e982@linux.dev>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Oct 2022 13:46:21 -0700
Message-ID: <CAEf4BzbsjBfFaf0M8_qLaEYAcUn4J9275tp0GEt5vb8hBg6Z9w@mail.gmail.com>
Subject: Re: [Question]: BPF_CGROUP_{GET,SET}SOCKOPT handling when optlen > PAGE_SIZE
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
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

On Wed, Oct 26, 2022 at 6:17 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> The cgroup-bpf {get,set}sockopt prog is useful to change the optname behavior.
> The bpf prog usually just handles a few specific optnames and ignores most
> others.  For the optnames that it ignores, it usually does not need to change
> the optlen.  The exception is when optlen > PAGE_SIZE (or optval_end - optval).
> The bpf prog needs to set the optlen to 0 for this case or else the kernel will
> return -EFAULT to the userspace.  It is usually not what the bpf prog wants
> because the bpf prog only expects error returning to userspace when it has
> explicitly 'return 0;' or used bpf_set_retval().  If a bpf prog always changes
> optlen for optnames that it does not care to 0,  it may risk if the latter bpf
> prog in the same cgroup may want to change/look-at it.
>
> Would like to explore if there is an easier way for the bpf prog to handle it.
> eg. does it make sense to track if the bpf prog has changed the ctx->optlen
> before returning -EFAULT to the user space when ctx.optlen > max_optlen?

Maybe optlen + optval/optval_end could be replaced with dynptr? If we
do a new type of dynptr (DYNPTR_CTXBUF or something like that), we can
implement tracking of whether it was ever modified through
bpf_dynptr_write() or if direct memory access was ever used (was
bpf_dynptr_data() called). Not sure how you'd know if
bpf_dynptr_data() was used to modify data, though (this is where
bpf_dynptr_data_rdonly() vs bpf_dynptr_data() would be helpful,
perhaps). But just a seed of an idea, maybe you guys can somehow fit
it here?
