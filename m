Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26345EC287
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 14:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiI0MWl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 08:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiI0MWQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 08:22:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77E7E62E5;
        Tue, 27 Sep 2022 05:22:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F62260EF1;
        Tue, 27 Sep 2022 12:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776C0C433C1;
        Tue, 27 Sep 2022 12:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664281320;
        bh=Md92oNwZ1hiITnrlHo0gSdJQdkrFWI4DogYSf+Wdako=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YlQhtCcqTr3l7h9vi9ocIduv2pQzyo023UyA5cS/f3JgoRnYTHVNHBPVEtTnrCx+b
         yrcWGgACJAy74FaMODlAL7n2/1qrwz6sEUHieQrUxKAmIvYFhQZ0eWE6foJsnsbbO2
         r7UDjpkK3ks+TI5qbO2IUCdejkTaCcMldRiOrl+eNDdPuZBTeHoyTTUW03yQ/S1q32
         bOSpHEGKygLVfiRFlNvAiojSfUO9kleTLy6g53PzVcmvysi5OhokWflbjIFS0c0zVt
         SRSMeyTjUpRfWajGCF37CPKOaY4Yvw/KMGhZiWLDlgslF6H5WvkL0oNBHlqSOqAWDd
         Kic23/HSk/vbA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3EB26403B0; Tue, 27 Sep 2022 13:21:58 +0100 (IST)
Date:   Tue, 27 Sep 2022 13:21:58 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        Jiri Olsa <olsajiri@gmail.com>, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        quentin@isovalent.com, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH 3/3] tools/build: Display logical OR of a feature flavors
Message-ID: <YzLq5uar4dZlT1s6@kernel.org>
References: <20220818120957.319995-1-roberto.sassu@huaweicloud.com>
 <20220818120957.319995-3-roberto.sassu@huaweicloud.com>
 <YwNhabqHEq3PfNM8@krava>
 <64352c51c5dcbab389201a16733f3157a1ea591e.camel@huaweicloud.com>
 <75986095d7ada2b24784ef356abc6ce17307575d.camel@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75986095d7ada2b24784ef356abc6ce17307575d.camel@huaweicloud.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Sep 27, 2022 at 09:14:34AM +0200, Roberto Sassu escreveu:
> On Mon, 2022-08-22 at 13:24 +0200, Roberto Sassu wrote:
> > On Mon, 2022-08-22 at 12:58 +0200, Jiri Olsa wrote:
> > > On Thu, Aug 18, 2022 at 02:09:57PM +0200, 
> > 
> > [...]
> > 
> > > > In verbose mode, of if no group is defined for a feature, show
> > > > the
> > > > feature
> > > > detection result as before.
> > 
> > Thanks Jiri.
> > 
> > 'or' instead of 'of', if the patch can be edited.
> 
> Hi Arnaldo
> 
> will you take these patches?

The tools/build one I have in my perf/core branch, for v6.1.

⬢[acme@toolbox perf]$ git log --oneline --author roberto.sassu@huawei.com tools/{build,perf,lib}
924b0da1154fa814 tools build: Display logical OR of a feature flavors
1903f4ac2f3a6d33 tools build: Increment room for feature name in feature detection output
48ab65e0fec644b4 tools build: Fix feature detection output due to eval expansion
5b245985a6de5ac1 tools build: Switch to new openssl API for test-libcrypto
dd6775f986144a9e perf build: Remove FEATURE_CHECK_LDFLAGS-disassembler-{four-args,init-styled} setting
629b98e2b1c6efcf tools, build: Retry detection of bfd-related features
⬢[acme@toolbox perf]$

Quentin, may I pick the ones that touch bpftool?

- Arnaldo
