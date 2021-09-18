Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CB14108B6
	for <lists+bpf@lfdr.de>; Sat, 18 Sep 2021 23:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbhIRVhA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Sep 2021 17:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232932AbhIRVg7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Sep 2021 17:36:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96A456101B;
        Sat, 18 Sep 2021 21:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632000935;
        bh=UnEpiSbupwmLUwGdo9LZxGJhT4QWasUr3xb6mum/6Os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GyshazH52FRtYUe+dyYzSlJx7fYZgJ0nHKJODY+Eehs34WQRV/RVbA6d3BVajJ03t
         2IYB0vKJhS/3wrIXJPgyg9qMq4sL45sq384kfrlSgFy6br9woI2izg9NAt3Ms8hd5Q
         tzkepfCkMXHOW4NiGZAnHLyBZwuVO41vaFfmb2FKVVFnan/w+PGka0jxWj8T6wWCNQ
         +HWgTnLF/alG8cQWiB5x1yXLekg8iZT/LPB/E7s9vOOriTtH9j/hlp8oWg2OJKKeMQ
         LEHC/zp8Mg7JJKzChyn+F53W9abfMqdRZFfUH+hm7ItqTfH9pA61viKHrCcFVEWoHf
         m7UaLVWE+AOJw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 261EC410A1; Sat, 18 Sep 2021 18:35:33 -0300 (-03)
Date:   Sat, 18 Sep 2021 18:35:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH dwarves] libbpf: Get latest libbpf
Message-ID: <YUZbpcO1il2WgNR8@kernel.org>
References: <20210917224818.733897-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917224818.733897-1-yhs@fb.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Sep 17, 2021 at 03:48:18PM -0700, Yonghong Song escreveu:
> Latest upstream LLVM now supports to emit btf_tag to
> dwarf ([1]) and the kernel support for btf_tag is also
> landed ([2]). Sync with latest libbpf which has
> btf_tag support. Next step will be to implement
> dwarf -> btf conversion for btf_tag.

Thanks, applied and pushed out. Looking forward to the upcoming btf_tag
patches!

- Arnaldo
 
>  [1] https://reviews.llvm.org/D106621
>  [2] https://lore.kernel.org/bpf/20210914223015.245546-1-yhs@fb.com
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  lib/bpf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bpf b/lib/bpf
> index 986962f..980777c 160000
> --- a/lib/bpf
> +++ b/lib/bpf
> @@ -1 +1 @@
> -Subproject commit 986962fade5dfa89c2890f3854eb040d2a64ab38
> +Subproject commit 980777cc16db75d5628a537c892aefc2640bb242
> -- 
> 2.30.2

-- 

- Arnaldo
