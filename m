Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A484D8869
	for <lists+bpf@lfdr.de>; Mon, 14 Mar 2022 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242651AbiCNPoU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Mar 2022 11:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242713AbiCNPoS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 11:44:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880E631DFC;
        Mon, 14 Mar 2022 08:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E089F612DA;
        Mon, 14 Mar 2022 15:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E09C340E9;
        Mon, 14 Mar 2022 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647272585;
        bh=gKzKqCiR7fZc9bVkrFEhSbgB2AEs8J7awpaCyQnJdig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QfExv8oFXeMQ/j3mCNM9jtdBlG/wd2Z6j94B4kciWSGq7IemRduc0tRG7wVbdo6AH
         NmSg0tVeekCpmbcKTmRr+xllO3etggZ31mL3SgXluvHfurNN3s/fYtzqUDmVB1Vvu8
         z2rePdvYYwxyWL+nykP93MP7YxhYezIUrACx5jie93tLJu/582Q7Uy6L64yyChOCGf
         lhMve3fQJ2+QRdN65c/F5/oOZQFfmoS3siCd8fMDLEqEhtAnrTVxGmWflxBip7qtaD
         QUNRfQvt+Sw+o9mdMT+fc0dePst6XB0kUWDaBI4Bl0JJYOPHv6Dqba8nFqfaB3k8iq
         +ZY7P+nwqY4Bg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7CA6F40407; Mon, 14 Mar 2022 12:43:02 -0300 (-03)
Date:   Mon, 14 Mar 2022 12:43:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH dwarves v4 1/4] dwarf_loader: Receive per-thread data on
 worker threads.
Message-ID: <Yi9ihn4nnI7ylIb2@kernel.org>
References: <20220126192039.2840752-1-kuifeng@fb.com>
 <20220126192039.2840752-2-kuifeng@fb.com>
 <CAEf4BzarN4L8U+hLnvZrNg0CR-oQr25OFs_W_tfW3aAHGAVFWw@mail.gmail.com>
 <YfJudZmSS1yTkeP/@kernel.org>
 <CAEf4Bza8xB+yFb4qGPvM7YwvHCb1zQ8yosGbKj63vcRM7d9aLg@mail.gmail.com>
 <Yij/BSPgMl8/HEhg@kernel.org>
 <CAEf4BzZX8Q5MPt62+68nRoQNPe=3jnVkcEMMJwPzoU51YCBszg@mail.gmail.com>
 <Yi9hk2DXhmtL91D5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yi9hk2DXhmtL91D5@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Mar 14, 2022 at 12:38:59PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Mar 09, 2022 at 04:14:40PM -0800, Andrii Nakryiko escreveu:
> > I did check locally with latest pahole master, and it seems like
> > something is wrong with generated BTF. I get three selftests failure
> > if I use latest pahole compiled from master.

> > Kui-Feng, please take a look when you get a chance. Arnaldo, please
> > hold off from releasing a new version for now.

> Sure, will wait.

> Also will try to test/fix this as time permits.

The tests at
https://github.com/libbpf/libbpf/actions/workflows/pahole.yml are all
happy with what we have, so maybe a new test is needed for checking
these three selftests into what is being tested there?

And just so that we're all on the same page, this is the current status
in the various branches and git servers:

⬢[acme@toolbox pahole]$ git log --oneline -10
65d7273668ded59b (HEAD -> master, quaco/master, quaco/HEAD, github/tmp.master, github/next, github/master, acme/tmp.master, acme/next, acme/master) pahole: Introduce --compile to produce a compilable output
4d004e2314f3252e core: Ditch 'dwarves__active_loader' extern declaration, it was nuked
4f332dbfd02072e4 emit: Notice type shadowing, i.e. multiple types with the same name (enum, struct, union, etc)
0a82f74ce25a5904 core: Make type->packed_attributes_inferred a one bit member
fac821246c582299 core: type->declaration is just one bit, make it a bitfield member
742f04f89da03665 emit: Search for data structures using its type in addition to its name
32cc1481721c4b11 fprintf: Consider enumerations without members as forward declarations
6afc296eeb180e25 emit: Fix printing typedef of nameless struct/union
49a2dd657728675b fprintf: Check if conf->conf_fprintf is not NULL when resolving cacheline_size
46cec35ff0411e0f fprintf: Fix division by zero for uninitialized conf_fprintf->cacheline_size field
⬢[acme@toolbox pahole]$

- Arnaldo
