Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC76690894
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 13:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjBIMWt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 07:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBIMWs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 07:22:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E00125A8
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 04:22:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C41CAB8211B
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 12:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4200AC433EF;
        Thu,  9 Feb 2023 12:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675945364;
        bh=rbqPYoI45RlgdUQccPrHA41WJasJ1mB08BySnr+jNgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6S2n+Mmk7w9/bL7LjxV13ae8x8+A0+QtoY7U4JRFw1W285bDXNkEMvU2zIwOMbMr
         VzNmprGk7pDEAAd1XtMvnLXYowW9uViaA206HWeDm96PAa4qWewlxPQlv6ncuhgIgk
         5ThNHOnsgq0O5nT6HYzvuK6s3toADDjNc2bqUAZZv3v/2jiJEiMkko18Nk0NTZVqQd
         oaehmhnqG2AXAkj8JfctRRgU3LPWeGNs2Oxa1jAat746nKgnx1EnCRQgpsLcAM4Dhu
         h4N4DIOvf9NXAD+1EgRLedkNCTap9TjKpObBsf9aMODdjYZV2XMzMTU2b2XKNyUCRp
         yIe9YdeQgXEcw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C1AB7405BE; Thu,  9 Feb 2023 09:22:41 -0300 (-03)
Date:   Thu, 9 Feb 2023 09:22:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        haoluo@google.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 dwarves 0/8] dwarves: support encoding of
 optimized-out parameters, removal of inconsistent static functions
Message-ID: <Y+TlkQkNGIFFp3pE@kernel.org>
References: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
 <Y+PL18hvJ7WwncGR@kernel.org>
 <Y+PS01eC1i75nBM0@kernel.org>
 <Y+S+s0a8ym6/f+Z1@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+S+s0a8ym6/f+Z1@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Feb 09, 2023 at 10:36:51AM +0100, Jiri Olsa escreveu:
> On Wed, Feb 08, 2023 at 01:50:27PM -0300, Arnaldo Carvalho de Melo wrote:
> > No functions with more than one entry:

> > [acme@pumpkin ~]$ pfunct /sys/kernel/btf/vmlinux  | sort | uniq -c | sort -n | grep -v ' 1 '
> > [acme@pumpkin ~]$ pfunct /sys/kernel/btf/vmlinux  | sort | uniq -c | sort -n | grep ' 1 ' | wc -l
> > 54558
> > [acme@pumpkin ~]$ pfunct /sys/kernel/btf/vmlinux  | wc -l
> > 54558
> > [acme@pumpkin ~]$

> > So I'll bump the release as we did in the past when testing features
> > that we need to test against a release on the pahole-flags.sh script so
> > that we can do further tests.

> I did similar test and ran bpf selftests built with new pahole,
> all looks good

> Acked/Tested-by: Jiri Olsa <jolsa@kernel.org>

Thanks, added to the patches in this series.

- Arnaldo
