Return-Path: <bpf+bounces-68640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47077B7E083
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221AD4866FD
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 07:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114BD2E2845;
	Wed, 17 Sep 2025 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnk9Lf7o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B86226D04
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095488; cv=none; b=TUJAvh4ZHFZE949sJ6q7WAQzDwPe/VdWdo9F/kUo00Nfa+K2s5ARiZlveVpJLlNfHyVIOj9pwxqMopAH6sQzFCan69Shl9dpUPysg5PhhbOhHh/dCjRV8Cbim6DmSZPz3k1tfkiHBAY8DqhXzQvyjUTsa5MRbaEcW0MSqXsSCXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095488; c=relaxed/simple;
	bh=pgwolqbhgnvQ/nXPmeRrSZgPWnbCsA5+VxUr7pTncHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpkQQIJwxr16KsoXXBvAevjxRRczvLTib+qXTAKrQ4eQ7oizpTa6LsYBxjYeGxdVmG9tctS4EGewHFy7wm4YrhzoO0QqMQL2mGl/bUulVblH/RMy+rETToz6mjnywDTRE7MV13jTNV1NrYDlG47Jm9E7GOoieRj86X2kXte7pe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dnk9Lf7o; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45de56a042dso42945695e9.3
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758095485; x=1758700285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8HO0Ax4V+OAP3VCB0N4I2IN6OjJAKHo4zIP6sXe7O8k=;
        b=Dnk9Lf7oVQZX5fVp4EFOuqj51nVeIL0FHWQxIpaUxdhtKSVOckP5VPTLmeGzsqFOuf
         U8gDy3dRBGvzitWhU2P8lEPWiiVkmtNv4TUGUc54ccBxzdqdTXd4mB3i/k46fljD/f5V
         9uDzms2gHd8PU+XJKNnxJgeOHqFs7USrRQljPkMvvFOfqpfc28HDiAA+H4Ga+NxqJ7+N
         cJyvVyWr1EvZcmzIruujskBhirf2wHb81630CwStz/6opDxd5P0OaXjLr8z4k2c6jYuj
         54l8hO9WGUHWGDfX+KktJ3UaUh0+tpvmlcGvm7NzLLZ2PvfeZJX7Wxgwlp4EIl/t8CGN
         SOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758095485; x=1758700285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HO0Ax4V+OAP3VCB0N4I2IN6OjJAKHo4zIP6sXe7O8k=;
        b=JOFfyU4CZiuo5d0GBeVszfS8wTKO1HWELe6aVbmRVUldoas3p/wLwlGYzyJAnuqbyT
         3bMCZAtugnDzMKazxE/hLo6DfcOoo0Rc3q1yXoeIUuBxTpKKla0uQhcf7vGDe7PgU3X0
         43Xy4Gk1asYqvF2Cb7J0teIBdFEFI2My3t8NzGYNuaPTuOW6uCOsKEfQXYE9hXrYygaY
         IbwdUCyRL7/GlAmiOmfTOA9EIR8ufZZv7ur8rC3b9M1K0wu6w+BwiMO9aL3b3oaofO5N
         eAP7yJJRJi0mCDCtY+9IqqNX4OCbzwvPbsJS7/+gm1LevQGt+qoqCiF+ZlkK3nuMRAEb
         pROA==
X-Gm-Message-State: AOJu0YwuFQ/bD1Z2J51AHJfbl6/koWLehYaqMUN2PP57fMayVjHu7jh3
	0XQQqn9517Dn2F7bJHT68xH2rKTfMhh+3/oQXTp2TtRZlA7omfj3Y+y2
X-Gm-Gg: ASbGncsCzz76oVsDKHDajQnZcdzY/5SiQWlfRklfmPZsYmYRbKs2JDtZsElGZMjW6Uf
	14cczO2UzLsDsVcdgUhYbQLG9TeCYMRVGMJ1XfscC4elc3qIqhksn8NxUTtQ2n3ieHg/jws4Cjy
	XurrEpkZH8AHsv3XjCJ9H9HY86xoq8P/srylhe9cm0VqnEy0lvXBqq1PMXS8NJDjHs+fua+U8vm
	8RvIsnVDCfhH8tF+nU9/tdVkC2bDNTiLzLHE/xdRMquet5GE8wpwVSyOlEB1aYBIFz8uLBlQJXA
	4FTHsuCtteigSl1WrvxQJ6aF8QMq1cVgNPiL3Nn2js43WfIKwMdnQRx2HM0+vLdCiEI0TtZLb0y
	ZWQLSnH7OVXmL/YFaOp71ZAoEf7Dett6q+dZOLhUHaK+y1hLMlBrlx3Dr1t8DNuFtoNUx8esblz
	a2nwKqMu3S34Pa+KYkoKKf8Edzlq7gBfY=
X-Google-Smtp-Source: AGHT+IHsOg7uHNUFLiWbnBSVPuyxUcHYTjW7AR2w7L1l63q72rIlW/vtYRf9pBMU/z+NIaLBS6jo+w==
X-Received: by 2002:a05:600c:4fc8:b0:45d:d356:c358 with SMTP id 5b1f17b1804b1-4620348f47fmr12870855e9.16.1758095484905;
        Wed, 17 Sep 2025 00:51:24 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f6fdfecb9884ca93.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f6fd:fecb:9884:ca93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-461391232cesm25046375e9.18.2025.09.17.00.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 00:51:24 -0700 (PDT)
Date: Wed, 17 Sep 2025 09:51:22 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf 1/3] bpf: Explicitly check accesses to bpf_sock_addr
Message-ID: <aMpoepoZkXZ9qOmf@mail.gmail.com>
References: <f5310453da29debecc28fe487cd5638e0b9ae268.1758032885.git.paul.chaignon@gmail.com>
 <2e1f2075-bef0-456f-82c4-483b5db3dd11@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e1f2075-bef0-456f-82c4-483b5db3dd11@iogearbox.net>

On Tue, Sep 16, 2025 at 09:44:28PM +0200, Daniel Borkmann wrote:
> On 9/16/25 5:17 PM, Paul Chaignon wrote:
> > Syzkaller found a kernel warning on the following sock_addr program:
> > 
> >      0: r0 = 0
> >      1: r2 = *(u32 *)(r1 +60)
> >      2: exit
> > 
> > which triggers:
> > 
> >      verifier bug: error during ctx access conversion (0)
> > 
> > This is happening because offset 60 in bpf_sock_addr corresponds to an
> > implicit padding of 4 bytes, right after msg_src_ip4. Access to this
> > padding isn't rejected in sock_addr_is_valid_access and it thus later
> > fails to convert the access.
> > 
> > This patch fixes it by explicitly checking the various fields of
> > bpf_sock_addr in sock_addr_is_valid_access.
> > 
> > I checked the other ctx structures and is_valid_access functions and
> > didn't find any other similar cases. Other cases of (properly handled)
> > padding are covered in new tests in a subsequent patch.
> > 
> > Fixes: 1cedee13d25a ("bpf: Hooks for sys_sendmsg")
> > Reported-by: syzbot+136ca59d411f92e821b7@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=136ca59d411f92e821b7
> > Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> > ---
> >   net/core/filter.c | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index da391e2b0788..9ac58960e59e 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -9284,13 +9284,19 @@ static bool sock_addr_is_valid_access(int off, int size,
> >   			return false;
> >   		info->reg_type = PTR_TO_SOCKET;
> >   		break;
> > -	default:
> > +	case bpf_ctx_range(struct bpf_sock_addr, user_family):
> > +	case bpf_ctx_range(struct bpf_sock_addr, family):
> > +	case bpf_ctx_range(struct bpf_sock_addr, type):
> > +	case bpf_ctx_range(struct bpf_sock_addr, protocol):
> >   		if (type == BPF_READ) {
> >   			if (size != size_default)
> >   				return false;
> >   		} else {
> >   			return false;
> >   		}
> > +		break;
> 
> Looks good to me, we can probably also simplify this a bit into:

Thanks for the review!

> 
>                 if (type != BPF_READ)
>                         return false;
>                 if (size != size_default)
>                         return false;
>                 break;
> 
> Also, targeting bpf-next tree seems okay here since the verifier
> can gracefully handle and reject such program (and WARN_ONCE is
> only triggered on CONFIG_DEBUG_KERNEL)?

Yep, that makes sense. I did not think this through :')

> 
> > +	default:
> > +		return false;
> >   	}
> >   	return true;
> 
> Thanks,
> Daniel

