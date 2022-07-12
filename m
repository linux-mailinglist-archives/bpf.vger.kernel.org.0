Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371EC5728CF
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 23:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiGLVxd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 17:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiGLVxd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 17:53:33 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AFB97497
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 14:53:31 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id AEB7D240107
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 23:53:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1657662808; bh=QlKU4WebIgxZLDFbmzld3RHLmGnpMKKS4yIK7LxPNl0=;
        h=Date:From:To:Cc:Subject:From;
        b=OwexSRpTS1BQ4ti2me3pwGCGBAW/BFxw1RMAy6zMqUvI+Jp9sxNWCMqK5Xsx6LZJZ
         yi/5/xxkGN/Iop0brLWTdIkBQQuthzcganGfOzG9SZ+qo+nDGhTOdPM8/J1rjc1V5B
         CQ+/J1pqhVtyDuwomRalNzYwGz0Q7AoDKUAYSr8u8RaR01Or3BD+Nu39cnoVGL3jAF
         X7h0DiPv/3nr0tHMnBrBqI9cTtei0hBexbUcnJPzg4k170k9ppS3qRROQy9z9HtQMV
         XSXsaFxGFa1hC878Xj2Ax+CexgxuUOO9eF16MOV//M/vjjP/rZ0OKCFAXp8gybChO7
         xS3siN02Z5+sQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LjDys4c78z6tnV;
        Tue, 12 Jul 2022 23:53:25 +0200 (CEST)
Date:   Tue, 12 Jul 2022 21:53:22 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Copy over libbpf configs
Message-ID: <20220712215322.rw3z6eoix3yagi2q@muellerd-fedora-MJ0AC3F3>
References: <20220712212124.3180314-1-deso@posteo.net>
 <20220712212124.3180314-2-deso@posteo.net>
 <CAADnVQLLNQHHJuqd-pKzU09Uw3N-kBsztPy0ysYEKVipP=yMqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLLNQHHJuqd-pKzU09Uw3N-kBsztPy0ysYEKVipP=yMqw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 02:27:47PM -0700, Alexei Starovoitov wrote:
> On Tue, Jul 12, 2022 at 2:21 PM Daniel Müller <deso@posteo.net> wrote:
> >
> > This change integrates the libbpf maintained configurations and
> > black/white lists [0] into the repository, co-located with the BPF
> > selftests themselves. The only differences from the source is that we
> > replaced the terms blacklist & whitelist with denylist and allowlist,
> > respectively.
> >
> > [0] https://github.com/libbpf/libbpf/tree/20f03302350a4143825cedcbd210c4d7112c1898/travis-ci/vmtest/configs
> >
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > ---
> >  .../bpf/configs/allowlist/ALLOWLIST-4.9.0     |    8 +
> >  .../bpf/configs/allowlist/ALLOWLIST-5.5.0     |   55 +
> >  .../selftests/bpf/configs/config-latest.s390x | 2711 +++++++++++++++
> >  .../bpf/configs/config-latest.x86_64          | 3073 +++++++++++++++++
> 
> Instead of checking in the full config please trim it to
> relevant dependencies like existing selftests/bpf/config.
> Otherwise every update/addition would trigger massive patches.

Thanks for taking a look. Sure. Do we have some kind of tooling for that or are
there any suggestions on the best approach to minimize?

Thanks,
Daniel
