Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFA13492C4
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 14:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCYNKz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 09:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhCYNKf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Mar 2021 09:10:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C96A619FE;
        Thu, 25 Mar 2021 13:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616677835;
        bh=x9/ctOmiqTX8TL2wHhSwa5SQdVJHH/h9JvqLxMcArdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tBnV0Cvr6kaR+sZL+iRbZ25iDZcuPu4t/L9RoOUnUfMHgN3VOt4KdEn2MWavixedc
         5gFchWIo+iB0EAMDKeGqz1Jt7Fv9Ip8Yq5oclxrrRk7Z95gmR1zaUhwhdQUeE+7rOf
         nFskFlUq62D2m3KKRSHaC/as6YulEGucti4do+sNeNB/qZud8X1uQrhlae31iDeAay
         OnisTZSdupHm3prIjRf9nomSdc68iKxWKAuHej+WUQbfJvj+GhM8Vjtxx1dkvgMEw6
         DFpBU/YKtZgQH/Wp75ZhVrRr8OAHkZwCo1D3hIMUO4N6w8FmKfQrrNOSlBLTBKog15
         FWNfOUsXRRLKQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7375740647; Thu, 25 Mar 2021 10:10:33 -0300 (-03)
Date:   Thu, 25 Mar 2021 10:10:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH dwarves 0/3] add option to merge more dwarf cu's into
Message-ID: <YFyLyfYCD131ZM5k@kernel.org>
References: <20210325065316.3121287-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325065316.3121287-1-yhs@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Mar 24, 2021 at 11:53:16PM -0700, Yonghong Song escreveu:
> For vmlinux built with clang thin-lto or lto for latest bpf-next,
> there exist cross cu debuginfo type references. For example,
>       compile unit 1:
>          tag 10:  type A
>       compile unit 2:
>          ...
>            refer to type A (tag 10 in compile unit 1)
> I only checked a few but have seen type A may be a simple type
> like "unsigned char" or a complex type like an array of base types.
> I am using latest llvm trunk and bpf-next. I suspect llvm12 or
> linus tree >= 5.12 rc2 should be able to exhibit the issue as well.
> Both thin-lto and lto have the same issues.
> 
> Current pahole cannot handle this. It will report types cannot
> be found error. Bill Wendling has attempted to fix the issue
> with [1] by permitting all tags/types are hashed to the same
> hash table and then process cu's one by one. This does not
> really work. The reason is that each cu resolves types locally
> so for the above example we may have
>   compile unit 1:
>     type A : type_id = 10
>   compile unit 2:
>     refer to type A : type A will be resolved as type id = 10
> But id 10 refers to compile unit 1, we will get either out
> of bound type id or incorrect one.
> 
> This patch set is a continuation of Bill's work. We still
> increase the hashtable size and traverse all cu's before
> recoding and finalization. But instead of creating one-to-one
> mapping between debuginfo cu and pahole cu, we just create
> one pahole cu, which should solve the above incorrect type
> id issue.
> 
> Patches #1 and #2 are refactoring the existing code
> and Patch #3 added an option "merge_cus" to permit
> merging all debuginfo cu's into one pahole cu.
> For vmlinux built, it can be detected that if LTO or Thin-LTO
> is enabled, "merge_cus" can be added into pahole
> command line.
> 
>   [1] https://www.spinics.net/lists/dwarves/msg00999.html

Thanks for working on this, I'll look at it today.

- Arnaldo
