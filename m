Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BF36A5C9F
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 16:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjB1P6Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 10:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjB1P6G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 10:58:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049C81C5B0
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 07:57:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7033B80E6B
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 15:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47005C433EF;
        Tue, 28 Feb 2023 15:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677599867;
        bh=0w81dp8nLjvl1IQpOoOAkbbUTnD1uaudS6HgCeG9ySw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aBrOH70hXoY+UF0gYQmvvcMZUCy/XcLQbtNI5aDRx5eNUDFKpPzK0qlKZkOM5ULu8
         kcTyCRmXoWdjY6r9uDMQlzmqiPeTfAsmYneK/bzwh5+URsyvLxeBeVhOLOL/+GSquf
         moy+SXG9dnu9j+dxICGetfac1N3mPu4r1CE+g3a94t0zTdDSLrQVa08qg/Ma6aCP09
         +fpzY04ngkVCfwd1Wriz0/qm3IUlLyDj5Jnmke5bvAzHId31R3G1n5JIcSFf+WI3qm
         uaQp1z+vp+qckaJYMd0pF0DY/rq+s8lZIJ26rhLGfBAxBBZQ4BoptkXuFqoPXXPxKH
         LTbj5LS+UnSJA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 54BCB4049F; Tue, 28 Feb 2023 12:57:44 -0300 (-03)
Date:   Tue, 28 Feb 2023 12:57:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        haoluo@google.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [RFC dwarves 0/3] dwarves: improvements/fixes to BTF function
 skip logic
Message-ID: <Y/4keBu6eHXsXVUL@kernel.org>
References: <1676994522-1557-1-git-send-email-alan.maguire@oracle.com>
 <Y/fj28OdEdKJBLcy@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/fj28OdEdKJBLcy@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Feb 23, 2023 at 11:10:07PM +0100, Jiri Olsa escreveu:
> On Tue, Feb 21, 2023 at 03:48:39PM +0000, Alan Maguire wrote:
> > As discussed in [1], there are a few issues with how we determine
> > whether to skip functions for BTF encoding:
> > 
> > - when detecting unexpected registers, functions which have
> >   struct parameters need to be skipped as they can use
> >   multiple registers to pass the struct, and as a result
> >   later parameters use unexpected registers.  However,
> >   struct detection does not always work; it needs to be fixed for
> >   const struct parameters and cases where a parameter references
> >   the original parameter (which has the type info) via abstract
> >   origin (patch 1)
> > - when looking for unexpected registers, location lists are not
> >   supported.  Fix that by using dwarf_getlocations() (patch 2).
> > - when marking parameters as using unexpected registers, we should
> >   stick to the case where we expect register x and register y is
> >   used; other cases such as optimized-out parameters are no
> >   guarantee that we were not _passed_ the correct parameters
> >   (patch 3).
> > 
> > This series can be applied on top of the dwarves "next" branch,
> > as a follow-on to [2]
> > 
> > [1] https://lore.kernel.org/bpf/20230220190335.bk6jzayfqivsh7rv@macbook-pro-6.dhcp.thefacebook.com/
> > [2] https://lore.kernel.org/bpf/1676675433-10583-1-git-send-email-alan.maguire@oracle.com/
> > 
> > Alan Maguire (3):
> >   dwarf_loader: fix detection of struct parameters
> >   dwarf_loader: fix parameter location retrieval for location lists
> >   dwarf_loader: only mark parameter as using an unexpected register when
> >     it does
> 
> I'm getting more functions in with this patchset
> 
>   1666 for gcc   (with 61678, without 60012)
>   9390 for clang (with 62128, without 52738)
> 
> but no duplicates and selftests are passing
> 
> Tested-by: Jiri Olsa <jolsa@kernel.org>

Oh, I saw this and your comment about not using the branch 'next' and
thought these were already there :-\

I reviewed the patches now and I'm testing them, soon will push to the
'next' branch for some testing on the libbpf CI.

- Arnaldo
