Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD65A53AA8F
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 17:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbiFAPzl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 11:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiFAPzk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 11:55:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F997A5AA1
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 08:55:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31361B81BA0
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 15:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A0FC3411C
        for <bpf@vger.kernel.org>; Wed,  1 Jun 2022 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654098936;
        bh=7fBcdVziqnil2PL5GZ2pxT50OLfVfkaCS840rtr8vJU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SVjcS3q3SjYgpTvAKMrtNxyDqzD2HOptF1urLrN/UIJtyJozKiZMuBZ5i8sJd9i+1
         4RPH5IyC2H9ZipFDYYZXXtI45W78nwJ47ahLpxDso1LzggJ7dMBCeAvpQihfKGfpS+
         +3pfbbXg7TFYRhcZ+bUP/0Zsat/K7FZIIETVRVuEMQBX6qs6LrgoXg0FZuuIFKsjSL
         I0C5P6HdmqR3rQ04PgrJuO2p9SbMKW2n8kprKYNZHm9l6GZJkWE26vRVUJrv5FH+WU
         Sef7cucYRZ0vBl//GvmzSVq7uQb2KcSCsAE/8enQvUWU4IzTIumuL9L7Z5AfGpO053
         SrVI0yTa/4mxw==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-30ec2aa3b6cso23219447b3.11
        for <bpf@vger.kernel.org>; Wed, 01 Jun 2022 08:55:36 -0700 (PDT)
X-Gm-Message-State: AOAM53275tVFoZ0/XuuTY7mm7GyBtV9wrLuP6rLR50IMBJKD2/3BF2pT
        9FqGTKCKDdkY5ZmvR41wjF47FjC6vjEphVevn00=
X-Google-Smtp-Source: ABdhPJwW/U22fmEMtIe70gOL+10zadQPwnBRPcczp5fLn25EUna21IIx9H5xYsqLOKeNGLIEM2thZ9pOjfa3lfZUhmw=
X-Received: by 2002:a0d:e6cf:0:b0:30c:7aa9:64c0 with SMTP id
 p198-20020a0de6cf000000b0030c7aa964c0mr146574ywe.148.1654098935787; Wed, 01
 Jun 2022 08:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220601154025.3295035-1-deso@posteo.net>
In-Reply-To: <20220601154025.3295035-1-deso@posteo.net>
From:   Song Liu <song@kernel.org>
Date:   Wed, 1 Jun 2022 08:55:24 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6pDpmXcnThWPHw4-nS5wHMxYT4kG2BDL5TBMsCUD9VzQ@mail.gmail.com>
Message-ID: <CAPhsuW6pDpmXcnThWPHw4-nS5wHMxYT4kG2BDL5TBMsCUD9VzQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix a couple of typos
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 1, 2022 at 8:40 AM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> This change fixes a couple of typos that were encountered while studying
> the source code.
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>

Acked-by: Song Liu <songliubraving@fb.com>
