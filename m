Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56204546C32
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 20:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243664AbiFJSPx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 14:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241445AbiFJSPw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 14:15:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E8912D17F
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 11:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29574B83476
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 18:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25B9C34114
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 18:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654884947;
        bh=sfgYaZfU/X3/VXfixxZvpsfBnZG4UHFlJU80tnJ2FSU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FBesHJlCr45HGMuWAr3FRR72gObZPdb4nprW3+x5VYQZ2lCNsMEW+wwPbBsDvdAMH
         F5+ecsTO6Bk73DxDKtvFjQpNdQqZEUnO3SwCMmfLyQLvMul2lO1vR56+MSRrSvixga
         fE4QmPVkQ9bN2e1eA/Xg3e3Jme9kvmsxoTrzJAJIeCqwOcPMlrNscoePXso3OGWHlJ
         tAotqEPhzcDW3MHHXzIdc6NPDBUWBElQCyXINUMsPHT2vWL+NddqRQmrwewJ1zoMTp
         HlinVBMh8UbrsdS6dx5fOx8QQtcG3m2E/1vht0f8q5PLLT7sR28airzzhHXntgAS2J
         8Cs5H3/fqG30A==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3135519f95fso281337b3.6
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 11:15:47 -0700 (PDT)
X-Gm-Message-State: AOAM533yc+b8CauDnqLR7PXgrIgPkADXXiLeMXltbgoAN2yRevFk27CK
        WMrdDkoc5kP+nmeH0i85p2A4bEHzqNPL1B6W82U=
X-Google-Smtp-Source: ABdhPJxEIqASHjn1OlIZF5xIrzFGRL7E/Qr0Yd3ZxKrvGuauYTo7N7zPmONJ+iOEj3y9LDwBJzkzyE0AQErwITTQ/pw=
X-Received: by 2002:a0d:eb4d:0:b0:30c:9849:27a1 with SMTP id
 u74-20020a0deb4d000000b0030c984927a1mr48906809ywe.472.1654884946923; Fri, 10
 Jun 2022 11:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220608192630.3710333-1-eddyz87@gmail.com> <20220608192630.3710333-6-eddyz87@gmail.com>
In-Reply-To: <20220608192630.3710333-6-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 10 Jun 2022 11:15:36 -0700
X-Gmail-Original-Message-ID: <CAPhsuW49qMA-ZmdHe=eyWk3gkBn7kNQo3i+90x_=o29BWQVxvg@mail.gmail.com>
Message-ID: <CAPhsuW49qMA-ZmdHe=eyWk3gkBn7kNQo3i+90x_=o29BWQVxvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/5] selftests/bpf: BPF test_prog selftests
 for bpf_loop inlining
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 8, 2022 at 12:27 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Two new test BPF programs for test_prog selftests checking bpf_loop
> behavior. Both are corner cases for bpf_loop inlinig transformation:
>  - check that bpf_loop behaves correctly when callback function is not
>    a compile time constant
>  - check that local function variables are not affected by allocating
>    additional stack storage for registers spilled by loop inlining
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>
