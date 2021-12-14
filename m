Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A7447465E
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 16:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhLNPY2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 10:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhLNPY1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 10:24:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2F6C061574
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 07:24:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFEFA61584
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 15:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE8BC34605;
        Tue, 14 Dec 2021 15:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639495466;
        bh=DnSTTSPo9KeljY389jiQbEFaXKiFOsvsmvup/5GiPX4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ePXweA4kloGZ2Q9t18JDHV7melrTHaj9a8Yxe3nawgmqQXbvwpIvx+HFSGSP3SsXK
         z/WOYFXmLSuhfbis0fcHC/K2cRHVTsvpFiisg58e6Q/bvZsJ/TuIhYwCgxseEI066B
         VA7h0emRVNnGAvu91dm4CE1reeHOljE2KPbIL11+6NTN/t50PjU3uXibCx7wU59siD
         Q6Jr141aI4HRYro08uumqHXrKDnOHFmaDVOh/lm+m5UQWThy8O1n9x52CgXMnMT4i5
         U4Ex3HcvSRC10RJR9E0c8UtziQFMBWyT/Ej6sOrwTx6EAmjN5fu5pgiLbs/XWLA7Dn
         mkElcvBRBha9g==
Date:   Tue, 14 Dec 2021 07:24:25 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 3/5] bpf: create a header for struct bpf_link
Message-ID: <20211214072425.78fb24b3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20211214071850.175707e5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211213234223.356977-1-kuba@kernel.org>
        <20211213234223.356977-4-kuba@kernel.org>
        <CAADnVQ+6Qmm9b3Jf_BHCn_PFxs00NK71K235zQYc=_PufkOPAQ@mail.gmail.com>
        <20211214070435.7f07e2ac@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20211214071850.175707e5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 14 Dec 2021 07:18:50 -0800 Jakub Kicinski wrote:
> The dependency tree is
> 
> 
>          bpf-link.h  bpf-cgroup-types.h                                              
>               ^       ^
>               |      /                                  
>  bpf.h     bpf-cgroup.h  
>     ^           ^                             
>     |           |                          
>     |           |                          
>   bpf-cgroup-storage.h

 bpf-cgroup-types.h    bpf-link.h                                                
    ^          ^        ^
    |          |       /                                  
  bpf.h     bpf-cgroup.h  
     ^           ^                             
     |           |                          
     |           |                          
  bpf-cgroup-storage.h

To be exact, bpf.h include cgroup-types, but not bpf-link, doesn't
change the question below, tho.

> I can't merge bpf-cgroup-storage.h with the rest, it'd be a loop.
> Should I leave that one be separate? Any other ideas?

