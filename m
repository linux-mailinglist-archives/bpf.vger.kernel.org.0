Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D2C55DFC7
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbiF0XHB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 19:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiF0XHB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 19:07:01 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C595922506
        for <bpf@vger.kernel.org>; Mon, 27 Jun 2022 16:06:59 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 3C74E240029
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 01:06:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1656371218; bh=EJjQWQwEFlUOU2BgCUlHCP/q60X/XC/j8n+/NfcpzMU=;
        h=Date:From:To:Cc:Subject:From;
        b=HZvAOqJ99Dxyk1roCRMWq2OeZBu+w3E42rF4haRz8kTrvTaWYJAXnXYjUk/rfcnVQ
         dEgb1E3HMGJV5TcmJCfTy0lPHcJUVnbVHsC8nzQIQ2FGy5ZlcnxW/waMg36wxzFUYB
         zN6pcj6ydg3fZK0mjuPHb3PZ4fU35L3gqhCfbAgHMDTnLuU0vwEi0D+VMF8UhSU9b5
         OomQC6sdIaa3P9Dz6wqbBqJcL//zGXicGMhGB8QOMky1GnA5lMYW2igDQIM4MhlJqi
         nXAaOBrJzbgidqgBzfMDjlAcikEeZZIgAfudh5K9w3Yp2/p35ijVeaanALJ404EacE
         n+ehZwOcY/zCQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LX3Jb2zKvz6tmL;
        Tue, 28 Jun 2022 01:06:55 +0200 (CEST)
Date:   Mon, 27 Jun 2022 23:06:51 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v2 9/9] selftests/bpf: Add nested type to type
 based tests
Message-ID: <20220627230651.aqtqavqh3yvezzbf@muellerd-fedora-MJ0AC3F3>
References: <20220623212205.2805002-1-deso@posteo.net>
 <20220623212205.2805002-10-deso@posteo.net>
 <CAEf4BzY14nHcG8FoGXX_5reQDdq2a7st9ECG8fgn2zGcmx4t1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY14nHcG8FoGXX_5reQDdq2a7st9ECG8fgn2zGcmx4t1g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 24, 2022 at 02:45:47PM -0700, Andrii Nakryiko wrote:
> On Thu, Jun 23, 2022 at 2:22 PM Daniel Müller <deso@posteo.net> wrote:
> >
> > This change extends the type based tests with another struct type (in
> > addition to a_struct) to check relocations against: a_complex_struct.
> > This type is nested more deeply to provide additional coverage of
> > certain paths in the type match logic.
> >
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > ---
> 
> I'd like us to have a TYPE_MATCHES test against struct task_struct,
> something like below:
> 
> struct mm_struct___wrong {
>     int abc_whatever_should_not_exist;
> };
> 
> struct task_struct____local {
>     int pid;
>     struct mm_struct___wrong *mm;
> };
> 
> 
> and then use struct task_struct____local with bpf_core_type_matches()
> and check that it succeeds. This will show that TYPE_MATCHES can be
> used practically. Can you please add it to
> progs/test_core_reloc_kernel.c?

Thanks for the suggestion! I will include that test.

[...]

Daniel
