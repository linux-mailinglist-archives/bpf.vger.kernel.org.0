Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CB2319EDC
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 13:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhBLMmj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 07:42:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231713AbhBLMkf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5E6860C41;
        Fri, 12 Feb 2021 12:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613133593;
        bh=1KuuAqnBtSyxF3JZiAL0SdDLRsVF9Rim9RiN+MJxNjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fx+Rcss3u7lSPLcFY1KfEunMhoRHtZ1TXAkgZqkq6sV2ZGjQzTybg97UpB6WycZic
         jhSQBshVAosjEJlTFzdoPa+POYC+uF2C58VTgGskg4B3IB7taAMxkcOgvRJLO+FiCf
         MB2DNFQpeJ0YEH71OwOvBinFbpldarJCA0Q9UPcA3H3eXFH+R6otx9x0hYIThW1Ql1
         FYp4A8Zd0P+/E1pe3akbFZ2BZvrAYBJUdr8g4srpck++abIRttlcR2+Z18l09Ot3S8
         L+8VH/42ZI85nTBIlo7aIqhgWCalisPV+/7uUX1H0X7FKV3ofmc5tR22d5zbD5HtqJ
         fVODTYrDG8/zw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9DAB240513; Fri, 12 Feb 2021 09:39:51 -0300 (-03)
Date:   Fri, 12 Feb 2021 09:39:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2] dwarf_loader: use a better hashing function
Message-ID: <20210212123951.GF1398414@kernel.org>
References: <20210210232327.1965876-1-morbo@google.com>
 <20210212080104.2499483-1-morbo@google.com>
 <20210212123721.GE1398414@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212123721.GE1398414@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Feb 12, 2021 at 09:37:22AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 12, 2021 at 12:01:04AM -0800, Bill Wendling escreveu:
> > This hashing function[1] produces better hash table bucket
> > distributions. The original hashing function always produced zeros in
> > the three least significant bits. The new hashing function gives a
> > modest performance boost:
> 
> Some tidbits:
> 
> You forgot to CC Andrii and also to add this, which I'm doing now:
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> 
> :-)

See below the full cset, that will go public after some more tests here.

- Arnaldo

commit 9fecc77ed82d429fd3fe49ba275465813228e617 (HEAD -> master)
Author: Bill Wendling <morbo@google.com>
Date:   Fri Feb 12 00:01:04 2021 -0800

    dwarf_loader: Use a better hashing function, from libbpf
    
    This hashing function[1] produces better hash table bucket
    distributions. The original hashing function always produced zeros in
    the three least significant bits. The new hashing function gives a
    modest performance boost:
    
      Original: 0:11.373s
      New:      0:11.110s
    
    for a performance improvement of ~2%.
    
    [1] From the hash function used in libbpf.
    
    Committer notes:
    
    Bill found the suboptimality of the hash function being used, Andrii
    suggested using the libbpf one, which ended up being better.
    
    Signed-off-by: Bill Wendling <morbo@google.com>
    Suggested-by: Andrii Nakryiko <andrii@kernel.org>
    Cc: bpf@vger.kernel.org
    Cc: dwarves@vger.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

