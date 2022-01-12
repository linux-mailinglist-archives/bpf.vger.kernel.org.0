Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D6248CE99
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 23:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiALW4e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 17:56:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234772AbiALW4U (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 12 Jan 2022 17:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642028177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BnkpM+pGxrApbJHkm0M03d3jDQgbOfi2NwpUNQ1rReQ=;
        b=LwpFKEHl003X/IPXR1EmhNPX4yXaoGhN3nQJg/Zrqt/HdNJ6flcYyBVtg4s8l1zqIqf0sy
        6ScnSeM4fVuoI33zp2/dG5xbcRNdW4BB3qgQF0/3IMu/EBuARcZ1Knt89uwkLSOWLXRdXp
        HOZlKdSeiJr49tEiLeAROoKPX29qvzE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-aklbt0xgPR6zm6sO7QOBZQ-1; Wed, 12 Jan 2022 17:56:16 -0500
X-MC-Unique: aklbt0xgPR6zm6sO7QOBZQ-1
Received: by mail-ed1-f72.google.com with SMTP id ec25-20020a0564020d5900b003fc074c5d21so3528771edb.19
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 14:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BnkpM+pGxrApbJHkm0M03d3jDQgbOfi2NwpUNQ1rReQ=;
        b=5tCjT8X4aLLMiedmQmLdWKBZViMbo1pLFJkUxuGnfTQezqZFHBZsEfkiVqV5qagENF
         EXGUZiDps8DkC6Cb8AQN35vinqYH7b1G0Pj2CYc+1V2nO1FkOBI0juB70ieG3WTQ7q4y
         hc64AOhyLVylixjewkWsJO2O+LNiNgIStW5lFHF6k7FLwYLd4o9kTrBlEim7vqqN6Whf
         pASSf6MBXtlRR4Zmk2hGLrCW656+UYi68RbVROVBpIDq4hTuqAUzNLRKEIAFTVdsaSyO
         Q8dNU6S9O2Pod2Kq2km/RkJi6datoOIzbbu6mq1hSyZdhzdoN4JXBItGkl0tdi3qlJ07
         R5Hg==
X-Gm-Message-State: AOAM532XVL1CqkllR6XyuBOTBJmLdzsRF9jEfM3jyrfJKcC35o+UfIzD
        DCwrMfrWVmlJ3riDmPpM7WLLBZsk525vVtE4OMNg27B3c/IL4l+crhDgvsoRbgd8lO4jIe3X2ep
        zo7tzqtBEyJ0a
X-Received: by 2002:a17:906:158f:: with SMTP id k15mr1419788ejd.367.1642028174500;
        Wed, 12 Jan 2022 14:56:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzslN7ywjh8PbuXmxEdQtB8I0bf47LWMuq0xevWYn8N1avx8AZ2QP4uOzEEVzrJFXzW9EpY6g==
X-Received: by 2002:a17:906:158f:: with SMTP id k15mr1419770ejd.367.1642028174153;
        Wed, 12 Jan 2022 14:56:14 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u9sm301028ejh.195.2022.01.12.14.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 14:56:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1BE561802BD; Wed, 12 Jan 2022 23:56:13 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        linux-crypto@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH RFC v1 1/3] bpf: move from sha1 to blake2s in tag
 calculation
In-Reply-To: <20220112131204.800307-2-Jason@zx2c4.com>
References: <20220112131204.800307-1-Jason@zx2c4.com>
 <20220112131204.800307-2-Jason@zx2c4.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 12 Jan 2022 23:56:13 +0100
Message-ID: <87tue8ftrm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ adding the bpf list - please make sure to include that when sending
  BPF-related patches, not everyone in BPF land follows netdev ]  

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> BLAKE2s is faster and more secure. SHA-1 has been broken for a long time
> now. This also removes quite a bit of code, and lets us potentially
> remove sha1 from lib, which would further reduce vmlinux size.

AFAIU, the BPF tag is just used as an opaque (i.e., arbitrary) unique
identifier for BPF programs, without any guarantees of stability. Which
means changing it should be fine; at most we'd confuse some operators
who have memorised the tags of their BPF programs :)

The only other concern I could see would be if it somehow locked us into
that particular algorithm for other future use cases for computing
hashes of BPF programs (say, signing if that ends up being the direction
we go in). But obviously SHA1 would not be a good fit for that anyway,
so the algorithm choice would have to be part of that discussion in any
case.

So all in all, I don't see any issues with making this change for BPF.

-Toke

> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
> Cc: linux-crypto@vger.kernel.org
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  kernel/bpf/core.c | 39 ++++-----------------------------------
>  1 file changed, 4 insertions(+), 35 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 2405e39d800f..d01976749467 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -33,6 +33,7 @@
>  #include <linux/extable.h>
>  #include <linux/log2.h>
>  #include <linux/bpf_verifier.h>
> +#include <crypto/blake2s.h>
>  
>  #include <asm/barrier.h>
>  #include <asm/unaligned.h>
> @@ -265,24 +266,16 @@ void __bpf_prog_free(struct bpf_prog *fp)
>  
>  int bpf_prog_calc_tag(struct bpf_prog *fp)
>  {
> -	const u32 bits_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
>  	u32 raw_size = bpf_prog_tag_scratch_size(fp);
> -	u32 digest[SHA1_DIGEST_WORDS];
> -	u32 ws[SHA1_WORKSPACE_WORDS];
> -	u32 i, bsize, psize, blocks;
>  	struct bpf_insn *dst;
>  	bool was_ld_map;
> -	u8 *raw, *todo;
> -	__be32 *result;
> -	__be64 *bits;
> +	u8 *raw;
> +	int i;
>  
>  	raw = vmalloc(raw_size);
>  	if (!raw)
>  		return -ENOMEM;
>  
> -	sha1_init(digest);
> -	memset(ws, 0, sizeof(ws));
> -
>  	/* We need to take out the map fd for the digest calculation
>  	 * since they are unstable from user space side.
>  	 */
> @@ -307,31 +300,7 @@ int bpf_prog_calc_tag(struct bpf_prog *fp)
>  		}
>  	}
>  
> -	psize = bpf_prog_insn_size(fp);
> -	memset(&raw[psize], 0, raw_size - psize);
> -	raw[psize++] = 0x80;
> -
> -	bsize  = round_up(psize, SHA1_BLOCK_SIZE);
> -	blocks = bsize / SHA1_BLOCK_SIZE;
> -	todo   = raw;
> -	if (bsize - psize >= sizeof(__be64)) {
> -		bits = (__be64 *)(todo + bsize - sizeof(__be64));
> -	} else {
> -		bits = (__be64 *)(todo + bsize + bits_offset);
> -		blocks++;
> -	}
> -	*bits = cpu_to_be64((psize - 1) << 3);
> -
> -	while (blocks--) {
> -		sha1_transform(digest, todo, ws);
> -		todo += SHA1_BLOCK_SIZE;
> -	}
> -
> -	result = (__force __be32 *)digest;
> -	for (i = 0; i < SHA1_DIGEST_WORDS; i++)
> -		result[i] = cpu_to_be32(digest[i]);
> -	memcpy(fp->tag, result, sizeof(fp->tag));
> -
> +	blake2s(fp->tag, raw, NULL, sizeof(fp->tag), bpf_prog_insn_size(fp), 0);
>  	vfree(raw);
>  	return 0;
>  }
> -- 
> 2.34.1

