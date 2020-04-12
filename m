Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 057CE1A5C5C
	for <lists+bpf@lfdr.de>; Sun, 12 Apr 2020 05:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgDLDqT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Apr 2020 23:46:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgDLDqT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Apr 2020 23:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=vJV2sskGdjlw+kOvDhQmVNP+BFLYwNYdtvsBTdQ5v8U=; b=SzFxrbw9XPZlLOaIBqMdXG86d4
        DzpUrHMnZWIGVvgwlm9mwj8MPOksWqTCXo77sKu2+oXO/+Bz0qMCeWhqF9ymq/BrmYpt9QIp+FLyQ
        nwd5r0QY7hXH1xd0HrIrgeABnTNMfa9Ix+YBEjsHzY6hOWgOkTrsL7FwCVCUADbQ1dh8CPzTh4s8I
        2EqApbYmkxw9Wjj7rh4A59Gd6ngJce3kt+drc/RxvQrilXYD12gU57rvQKLF7ZTXP0QJQCB7RVD85
        j+q+uISU9/jx8xUbSuN+fZEQwHJC8jVOIob9MABxEqeUTplOZW+hX7+TA/hmgj/zKkgXetqjas6Cj
        4zIYmZdg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNTZa-0006Ux-S0; Sun, 12 Apr 2020 03:46:18 +0000
Subject: Re: linux-next: Tree for Apr 10 (warning: objtool: ___bpf_prog_run())
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        bpf <bpf@vger.kernel.org>
References: <20200410132706.170811b7@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e9e6b603-4bd3-bf42-443c-10fae629680a@infradead.org>
Date:   Sat, 11 Apr 2020 20:46:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200410132706.170811b7@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/9/20 8:27 PM, Stephen Rothwell wrote:
> Hi all,
> 
> The merge window has opened, so please do not add any material for the
> next release into your linux-next included trees/branches until after
> the merge window closes.
> 
> Changes since 20200409:
> 

Hi Josh,

In an x86_64 kernel built with FRAME_POINTER=y and UNWINDER_ORC not set,
do we care about this warning?

kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x33: call without frame pointer save/setup


thanks.
-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
