Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A98C585521
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 20:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiG2StZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 14:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiG2StX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 14:49:23 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B3D66108
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 11:49:22 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id tk8so10031593ejc.7
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+M9ZIQELi25VbeYHCrcEOtG7ZDU+E9+EdFuD7WPO3L8=;
        b=CfsLnqVldWVOGlGVdD+Up22DzpJdCy/hHZstIxnt4RZzWxX1nnx7sXThv4TM/LFMXQ
         Nz4orc1tj6oG1a/oL/Y38L7z5TA91XGe6ZuMWpuubwadQwb94PgN++BbCSHH3cFjYcGx
         Zr/Oq4nsxGNfuTQ7ypkz/NyvUbE4PJZS/hgmKqRmOl9owFIVxUi4etCp/+sZx4KwRBUc
         HzQ/1d+6j2GX0IZ7aORyHcKWlUjl5smC6ryzaQgRGLbCiH2RRy07Ey6RMpQdhjlNFSTn
         SRVTQjsK0e5wcQRBBdmmbWOklbu07EDIRva8VFKUM6+QNreOiOckz5rbXqo5Qq8r7hk3
         aZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+M9ZIQELi25VbeYHCrcEOtG7ZDU+E9+EdFuD7WPO3L8=;
        b=A4RTIvNb5vO7MKoqoJhkBOFwGgS4tDuOv7ExcwHNbdJkqxoZHWB2m2PtlFITHdk86o
         8wM5NjbRxAsR+UxN3dStoGP0nUlQKRssxB00TUQknYQSIm7i9KxPD+Da02d7M0Hiz15g
         Td18bdlvbTNQVYnuF24FvDjpiD1rikyEKH1sJpZyv0u61IAjb1kUv8mfOsSEjsXeyXro
         fX4SpZCXVZKu9DR5jceZqE5OVPfibAG4idw/OBP1KmxbvoPbQPKouSrIV42ZXdijZ5+w
         411sU+E0lz+F+DAtgJuyqQZ9xOIlE6IAuf+o3XR4P21aK2TODK7Zn34TCLdjpFZ7C9/P
         4f3A==
X-Gm-Message-State: AJIora9pAfyScc9sd4vHPGhNgCIaD6yK2l9Uk6XLFrGiRz9kVyADZmsf
        d7DqhzQoImZd1UWv1dkrNN+6gx/XaPSF6zTCgqU=
X-Google-Smtp-Source: AGRyM1uBwSWUFfOaEZz907272m/k14vxtIdXT0Czf7GSaDMqARNtjkbJf61XyfxRIKiUAUujtZqKQjz3hXpHueXbf6Q=
X-Received: by 2002:a17:907:6e1d:b0:72f:20ad:e1b6 with SMTP id
 sd29-20020a1709076e1d00b0072f20ade1b6mr3842758ejc.545.1659120561094; Fri, 29
 Jul 2022 11:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220722171836.2852247-1-roberto.sassu@huawei.com>
 <20220722171836.2852247-3-roberto.sassu@huawei.com> <20220722175528.26ve4ahnir6su5tu@macbook-pro-3.dhcp.thefacebook.com>
 <5c5cdf397a6e4523845d0a16117e3b81@huawei.com>
In-Reply-To: <5c5cdf397a6e4523845d0a16117e3b81@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 29 Jul 2022 11:49:09 -0700
Message-ID: <CAEf4BzYmomMAEEQYH+fGQeH-_+4oxsFYc+qbZyf1DgF1E_CuSw@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 02/15] bpf: Set open_flags as last bpf_attr field
 for bpf_*_get_fd_by_id() funcs
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "quentin@isovalent.com" <quentin@isovalent.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "jevburton.kernel@gmail.com" <jevburton.kernel@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 25, 2022 at 12:10 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> > From: Alexei Starovoitov [mailto:alexei.starovoitov@gmail.com]
> > Sent: Friday, July 22, 2022 7:55 PM
> > On Fri, Jul 22, 2022 at 07:18:23PM +0200, Roberto Sassu wrote:
> > > The bpf() system call validates the bpf_attr structure received as
> > > argument, and considers data until the last field, defined for each
> > > operation. The remaing space must be filled with zeros.
> > >
> > > Currently, for bpf_*_get_fd_by_id() functions except bpf_map_get_fd_by_id()
> > > the last field is *_id. Setting open_flags to BPF_F_RDONLY from user space
> > > will result in bpf() rejecting the argument.
> >
> > The kernel is doing the right thing. It should not ignore fields.
>
> Exactly. As Andrii requested to add opts to all bpf_*_get_fd_by_id()
> functions, the last field in the kernel needs to be updated accordingly.
>

It's been a while ago so details are hazy. But the idea was that if we
add _opts variant for bpf_map_get_fd_by_id() for interface consistency
all the other bpf_*_get_fd_by_id() probably should get _opts variant
and use the same opts struct. Right now kernel doesn't support
specifying flags for non-maps and that's fine. I agree with Alexei
that kernel shouldn't just ignore unrecognized field silently.

I think we still can add _opts() for all APIs, but user will need to
know that non-map variants expect 0 as flags. For now. If we
eventually add ability to specify flags for, say, links, then existing
API will just work. One can see how this get_fd_by_id() can use
read-only flags to return FDs that only support read-only operations
on objects (e.g., fetching link info for links, dumping prog
instructions for programs), but not modification operations (e.g.,
updating prog for links, or whatever write operation could be for
programs).

So I don't think there is contradiction here. We might choose to add
bpf_map_get_fd_by_id_opts() only, but we probably still should use
common struct name as if all bpf_*_get_fd_by_id_opts() exist.


> Roberto
