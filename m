Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04022319EA0
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 13:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhBLMjT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 07:39:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:55532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhBLMiO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BFDB64E9C;
        Fri, 12 Feb 2021 12:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613133444;
        bh=zLkBbqH3/E8oD7h5paJkGv6D2BZIigQpc4P5tJoPYm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIIFmVIpRt/Ys7VBDao7IpXVatkfGFlkcvJkL6tYNUoE5SZBfqTN6v5w0e8JZ3Lka
         QG4Q+6+MbRwNx5e/zwXByDQ88b6xEDQSLD7a3ODoQusqpvtO9+fRjws6j9ArWX1tQ1
         e1sdzK17xcdgfI9fjoNtT5NrUeKUBg0+Zk/vD8TF/js/0e1Rn6ZmSuBI+gLN9h2Ujs
         CzvJuQXwh98oRXR36dH9/YQRF7SyttrQi/emH30f8yMAQefLsinQpuxCQ6HNh5Id/K
         r0aHWpLhrnHiTdrchO5XotNXBkk2K1Aqz59IfPQQCmg3kDd51b8h+swY5Pg2X1fU1a
         yO4Dupv7lyxmw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 03CB340513; Fri, 12 Feb 2021 09:37:21 -0300 (-03)
Date:   Fri, 12 Feb 2021 09:37:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2] dwarf_loader: use a better hashing function
Message-ID: <20210212123721.GE1398414@kernel.org>
References: <20210210232327.1965876-1-morbo@google.com>
 <20210212080104.2499483-1-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212080104.2499483-1-morbo@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Feb 12, 2021 at 12:01:04AM -0800, Bill Wendling escreveu:
> This hashing function[1] produces better hash table bucket
> distributions. The original hashing function always produced zeros in
> the three least significant bits. The new hashing function gives a
> modest performance boost:

Some tidbits:

You forgot to CC Andrii and also to add this, which I'm doing now:

Suggested-by: Andrii Nakryiko <andrii@kernel.org>

:-)

- Arnaldo
 
>   Original: 0:11.373s
>   New:      0:11.110s
> 
> for a performance improvement of ~2%.
> 
> [1] From the hash function used in libbpf.
> 
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>  hash.h | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/hash.h b/hash.h
> index d3aa416..6f952c7 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -33,25 +33,7 @@
>  
>  static inline uint64_t hash_64(const uint64_t val, const unsigned int bits)
>  {
> -	uint64_t hash = val;
> -
> -	/*  Sigh, gcc can't optimise this alone like it does for 32 bits. */
> -	uint64_t n = hash;
> -	n <<= 18;
> -	hash -= n;
> -	n <<= 33;
> -	hash -= n;
> -	n <<= 3;
> -	hash += n;
> -	n <<= 3;
> -	hash -= n;
> -	n <<= 4;
> -	hash += n;
> -	n <<= 2;
> -	hash += n;
> -
> -	/* High bits are more random, so use them. */
> -	return hash >> (64 - bits);
> +	return (val * 11400714819323198485LLU) >> (64 - bits);
>  }
>  
>  static inline uint32_t hash_32(uint32_t val, unsigned int bits)
> -- 
> 2.30.0.478.g8a0d178c01-goog
> 

-- 

- Arnaldo
