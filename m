Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74878305DE3
	for <lists+bpf@lfdr.de>; Wed, 27 Jan 2021 15:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhA0OJF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Jan 2021 09:09:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233692AbhA0OGr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Jan 2021 09:06:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14094207FC;
        Wed, 27 Jan 2021 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611756366;
        bh=ylOoQpR7qPT5Nn7i9GFNNmW4Sr130iR6baDWQtgow8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=izZB8Y18qSgFbXFjGy1oySCI/YhPyK4QOllP/4zOC8J/1hcPDW8xc4lNFQx1RTTSO
         swxyiGsa4jaNK+clWBeOmcgAdZHoYcyGV/lzvdiRJGGt13Y6eDaAjRvpfp0GtynLag
         i2Jsq6KpVul2nOYUGzukkhTTMRDLeCPqwkXpMnI1BRefH1h1hP+fia4Q+TkO71ESOY
         Sn4D/uZwbopMfvceiqH4YtykMkQdn9g1e8VYcc5giWCFy2h1bTc2U/LpEZQvTl6//o
         Gk8nq915wHZrt0Gyu82vVm4hvj/cdwbBqTllLRZ2lzKRUR9qzMC/vj/bK90AN/BIlb
         HQY/GJ+MfjkvA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1967740513; Wed, 27 Jan 2021 11:06:01 -0300 (-03)
Date:   Wed, 27 Jan 2021 11:06:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Giuliano Procida <gprocida@google.com>
Cc:     dwarves@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        maennich@google.com, kernel-team@android.com, kernel-team@fb.com,
        bpf@vger.kernel.org
Subject: Re: [PATCH dwarves 0/4] BTF ELF writing changes
Message-ID: <20210127140601.GA752795@kernel.org>
References: <20210125130625.2030186-1-gprocida@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125130625.2030186-1-gprocida@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jan 25, 2021 at 01:06:21PM +0000, Giuliano Procida escreveu:
> Hi.
> 
> This follows on from my change to improve the error handling around
> llvm-objcopy in libbtf.c.
> 
> Note on recipients: Please let me know if I should adjust To or CC.
> 
> Note on style: I've generally placed declarations as allowed by C99,
> closest to point of use. Let me know if you'd prefer otherwise.
> 
> 1. Improve ELF error reporting

applied
 
> 2. Add .BTF section using libelf
> 
> This shows the minimal amount of code needed to drive libelf. However,
> it leaves layout up to libelf, which is almost certainly not wanted.
> 
> As an unexpcted side-effect, vmlinux is larger than before. It seems
> llvm-objcopy likes to trim down .strtab.

We have to test this thoroughly, I'm adding support to gcc's -gdwarf-5
DW_AT_data_bit_offset, I think I should get that done and release 1.20,
if some bug is still left on that new code, we can just fallback to
-gdwarf-4.

Then get back to the last 2 patches in your series, ok?

- Arnaldo
 
> 3. Manually lay out updated ELF sections
> 
> This does full layout of new and updated ELF sections. If the update
> ELF sections were not the last ones in the file by offset, then it can
> leave gaps between sections.
> 
> 4. Align .BTF section to 8 bytes
> 
> This was my original aim.
> 
> Regards.
> 
> Giuliano Procida (4):
>   btf_encoder: Improve ELF error reporting
>   btf_encoder: Add .BTF section using libelf
>   btf_encoder: Manually lay out updated ELF sections
>   btf_encoder: Align .BTF section to 8 bytes
> 
>  libbtf.c | 222 +++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 175 insertions(+), 47 deletions(-)
> 
> -- 
> 2.30.0.280.ga3ce27912f-goog
> 

-- 

- Arnaldo
