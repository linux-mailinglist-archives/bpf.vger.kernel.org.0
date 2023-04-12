Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436F36DF741
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 15:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjDLNeE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 09:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjDLNeC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 09:34:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725DC5586;
        Wed, 12 Apr 2023 06:33:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C66C262C1B;
        Wed, 12 Apr 2023 13:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE0EC433EF;
        Wed, 12 Apr 2023 13:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681306410;
        bh=jPhZ+vYcELisnUqbTmvB2M/+JoxSxb+g81de7EPVmWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GbgX2UAytswaQofx/YMthWjZh0hxp9/yCU+Dg3xtubw+gUMpn37gJJA7yTTfTegFc
         LkMizGerMEb1NZ74Z/Y1DfPgQ3OWeY/A09pCddLGMfdJcvqARTY/cOdUr5geRxQonp
         fN2bLYRQdgwriL1FR1UvG4UCYpydjmk+UWt6VpZOT0fKJ282Azq/zUJPDtBEncPTpg
         nsUCVvpnjPO/wBTj9gvMX6TGq0itIE56I92qSo38N/qMp31Jy8IOCmlWnoi5q8DxeZ
         5ARxlujYTSgK2JObsiD5URzL5Qsj6cKTWSVNLRDVuNJYrCCSKDLAkpu/T4Gp+ZgDbq
         +1EeGLhPneK2A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CB3DB40080; Wed, 12 Apr 2023 10:33:27 -0300 (-03)
Date:   Wed, 12 Apr 2023 10:33:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH bpf-next] tools headers: Remove s390 ptrace.h in
 check-headers.sh
Message-ID: <ZDazJ+Om7RgQwcZO@kernel.org>
References: <1680834090-2322-1-git-send-email-yangtiezhu@loongson.cn>
 <ZC/wA2NoO7yI/xNm@krava>
 <0f77e29c-e384-1d67-a99c-91e6091ec7db@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f77e29c-e384-1d67-a99c-91e6091ec7db@iogearbox.net>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Apr 11, 2023 at 07:35:02PM +0200, Daniel Borkmann escreveu:
> On 4/7/23 12:27 PM, Jiri Olsa wrote:
> > On Fri, Apr 07, 2023 at 10:21:30AM +0800, Tiezhu Yang wrote:
> > > After commit 1f265d2aea0d ("selftests/bpf: Remove not used headers"),
> > > tools/arch/s390/include/uapi/asm/ptrace.h has been removed, so remove
> > > it in check-headers.sh too, otherwise we can see the following build
> > > warning:
> > > 
> > >    diff: tools/arch/s390/include/uapi/asm/ptrace.h: No such file or directory
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Link: https://lore.kernel.org/oe-kbuild-all/202304050029.38NdbQPf-lkp@intel.com/
> > > Fixes: 1f265d2aea0d ("selftests/bpf: Remove not used headers")
> > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > 
> > not sure this should go through Arnaldo's tree instead,
> > either way is fine with me
> 
> Agree, perf tree is better given the script is located there, so:
> 
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Thanks, applied.

- Arnaldo

