Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC726B241C
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 13:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjCIM0d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 07:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCIM0V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 07:26:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C2DEAB97
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 04:26:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE7F3B81EDF
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 12:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A43C433D2;
        Thu,  9 Mar 2023 12:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678364772;
        bh=Oqk8Azjmvp35zHKdzJouSQ2y+xrmTqcAHDuoRkWN5dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eBasOg153uzh6coWSIWDUf8LwkFfXtA6+08YNy5xchsytYiFHODzFpaN0VEsxu8IP
         Y5KTPpP5+eRWlktgf/r2dqD1HcsUNsFncGIjvES6hxJdzgu2mAx1X8/BmUFz/2nLbD
         vKhkxMbqZqglNDAARf7l9wPETUwuvTN66UuA+mP70eC6abGiK9XqeC6yB0Sb0TII7Y
         Ga8rhvWBWS3lKUeSLTqHmx1XtZQf+39BiX4TJ+6D8w3v3uydPJz5/JSbJZsOc7I6Zd
         0N517PW6MNdeer94E6KPANTqXWEULltyfwkRyGMRH/6bTJ9S91Sd2gSrzUYP8u3578
         lmDFd0ae3PhgQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AC24A4049F; Thu,  9 Mar 2023 09:26:09 -0300 (-03)
Date:   Thu, 9 Mar 2023 09:26:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: add
 --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags
 for v1.25
Message-ID: <ZAnQYUPkUg0HBrlh@kernel.org>
References: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com>
 <CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com>
 <CAADnVQJe6dRnhbSk92g5Np0tXyMxWLD+8LqUxYfYPr7dWkxzSw@mail.gmail.com>
 <ZAk8L17/EfR8siaz@kernel.org>
 <ZAmV8luLw+umNGqd@krava>
 <ZAmwzzrBfmp2GQzr@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAmwzzrBfmp2GQzr@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Mar 09, 2023 at 11:11:27AM +0100, Jiri Olsa escreveu:
> On Thu, Mar 09, 2023 at 09:16:53AM +0100, Jiri Olsa wrote:
> > On Wed, Mar 08, 2023 at 10:53:51PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Mon, Feb 13, 2023 at 10:09:21PM -0800, Alexei Starovoitov escreveu:
> > > > On Mon, Feb 13, 2023 at 7:12 PM Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > > > Maybe we should make scripts/pahole-flags.sh selective
> > > > > and don't apply skip_encoding_btf_inconsiste to bpf_testmod ?

> > > > > Thoughts?

> > > > It's even worse with clang compiled kernel:

> > > I tested what is now in the master branch with both gcc and clang, on
> > > fedora:37, Alan also tested it, Jiri, it would be great if you could
> > > check if reverting the revert works for you as well.

> > ok, will check your master branch

> looks good.. got no duplicates and passing bpf tests for both
> gcc and clang setups

Thanks for testing!

Alexei, since you hit those problems, please consider redoing those
tests in your environment so that we triple check all this.

Thanks,

- Arnaldo
