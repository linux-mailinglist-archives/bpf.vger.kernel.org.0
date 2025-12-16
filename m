Return-Path: <bpf+bounces-76764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E15CC5231
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52A033041999
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 21:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037A2286425;
	Tue, 16 Dec 2025 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PA4UJez/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044C83A1E81
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765918834; cv=none; b=GQaC5kEbLlj/7miUQ4UDqBtTMTjAimp6Q0rk4f1jS3ncf9x/EoIvl4hphWSkW8l/Sg2G4yGgXtMyKJNvv8Ez4WfwhkJgDGrjwPbN0sJcSJA0VuBoCk/UrQaAp3DPDLPjJ0Zu7Z/IpXTwcAK60jv52ATixnbff7O/8/F7pPxTDgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765918834; c=relaxed/simple;
	bh=VH1xl5++9O6ZB5umO6kcdRVDWOTwcHp5qpV2emSsFxk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=G1Y3KG82+SyVDEUQRAmrpub5BFtuW6rnIkeKrwDtAfIJACefEwCRuAb5xW7rFiGwU1a+QciToF1mdDIEUC6jqUXCaHRL6n5ljrswFUt48u+xBDMJbvvFFI1MVvGS8KakJE8shyi/rmouASl14lHxgzFe3rBuxr/7TAZIN4tkrUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PA4UJez/; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8bb6a27d3edso358517785a.3
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 13:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1765918830; x=1766523630; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWGNFMYxe9TyC/7sdiL3Nby8ShHIEtMiyaZ/uOUZvdQ=;
        b=PA4UJez/Ad5kFa4Cfh4HGs6X3IQytnJoS0AC2UCou9NUhqgJbCEkg6wuIDpeqILozH
         c9SOiQT8NvJMWxBX/Es++xfr5g4EucFiOSwR8kVQvB9a+a2LEWSrgLthRmzoFXNvTk89
         4r2mzdfTk4fTgkVub0bk32mE0Bv6kibOWbNus7oVVbIFE6t4r2mHpd9ptANB5GRSBA2f
         hWzDFAu0DRur8/CWFN+FhFaRjyutec9WvnZ0n/dFlBBZlvpprEKfMx2+7Pg4UiY6O5eq
         ++pMaThgHcMHBVcdOJ9xGhjaEr0JrfbSBGJd9efIsSNfv49KALg3XGn2aU+mp3M4X4gz
         hTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765918830; x=1766523630;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWGNFMYxe9TyC/7sdiL3Nby8ShHIEtMiyaZ/uOUZvdQ=;
        b=rE9gqdsy3UIVKu1YF2atV8phhMZ54qV/S9PDJ2qp2bLAwVoG9t4UG61lWRsza7Ghl4
         yCoJ4YpIllzu+AtrO7+sFIb9mIZiMGV8FScsZoYSFuLGFj5Ofum7fvf3c2Z1BHeg1eFM
         XT9PzhHwzuLVDzMqkuktjmHuYvzvpHPY213Oem5/9CdP/V19vWRkbTBUduJFN40SjIjh
         PMiNn1goCefh6t/5ClOcSGYtW6K0wxtlBN0smvFN6umUyC7IpPzScJ2zZWoz9zaZsFxL
         oaLqbvNtNXijsy3TRRhjrCN0j+VIyZpndf54J3WXaMWLh8ML4+DNdKuJtElrh3dR6nzY
         jDFw==
X-Forwarded-Encrypted: i=1; AJvYcCVG2kfZfWkXxUAjCbgG9MK16+1+9RRlk+/cheWUGKuAxgwo9u7Z/4pOE0VVQ2Rti2/vc68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyadxj7mKAutJe1RSnb333auD0tEH8T+FpK+5bGFKSPKemtYeJQ
	EKJWALNa/0fEog0oRcLsRPZ757vBvPC/4lviM5HZlr3VCX1knTUGMQ9pBfCuTh/3Iw==
X-Gm-Gg: AY/fxX42suhdTOGAaA6ZfJVp7mT9epa2x/4IB3fFsNPRrRJcLiix+rvxjp1rfNa6V9n
	ECQGFjfSB3W/s1RGbEmBGMS92x9m0lspGti5Pq9rxrB1SWkWJXTciKZ1AC7OXoBda35T8VYLaOW
	aSj/eU3hdl8J41jY1AosW/usOWVqFVA4iZiDMP9GMC9Yb9jC1c60c3mdTvc9qHhi5U/WXctDpS9
	eF0B2mEP/v4sRqakSQFWTXuGFL2YTf7b2f/rw5Iketkhq1+YjZvTuTDo0UMM0be7K6yUxEEPzeO
	GEE1C6Fz++kwPO+Qh+f2s+sL4Uak+TS6lC3jAePMBpYllQAWJOxpE9HnwksNVnV9+B/sh+oiC73
	B8gp30Bmr1B4bnUnsrkYU8VAyToqL5mhIwOeW6IxeMISujM70cCXx5Ds/0yC+hEHNgrwNvvn6Ix
	EuQYRwTSVswResBEywO1cmoBcb9z1mrDdz94XWIqtR6QVYW+2BH3S730nV
X-Google-Smtp-Source: AGHT+IFVHSA7PuH01Up3KfTlcb3j+0mW1Rx9zFMCTOKbQwolakScOWOD34veXElG5sffzdLQ5yZVzw==
X-Received: by 2002:a05:620a:17a6:b0:892:ce2b:f84d with SMTP id af79cd13be357-8bb39fb1fb6mr2209857185a.33.1765918829690;
        Tue, 16 Dec 2025 13:00:29 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31b66942sm259527085a.42.2025.12.16.13.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 13:00:28 -0800 (PST)
Date: Tue, 16 Dec 2025 16:00:27 -0500
Message-ID: <7ab3093710dc84dcd5b3fdeca106e469@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251216_1504/pstg-lib:20251216_1504/pstg-pwork:20251216_1504
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Andrew Morton <akpm@linux-foundation.org>, James.Bottomley@HansenPartnership.com, dhowells@redhat.com, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH RFC 8/11] security: Hornet LSM
References: <20251211021257.1208712-9-bboscaccy@linux.microsoft.com>
In-Reply-To: <20251211021257.1208712-9-bboscaccy@linux.microsoft.com>

On Dec 10, 2025 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> This adds the Hornet Linux Security Module which provides enhanced
> signature verification and data validation for eBPF programs. This
> allows users to continue to maintain an invariant that all code
> running inside of the kernel has actually been signed and verified, by
> the kernel.
> 
> This effort builds upon the currently excepted upstream solution. It

s/excepted/accepted/ ;)

> further hardens it by providing deterministic, in-kernel checking of
> map hashes to solidify auditing along with preventing TOCTOU attacks
> against lskel map hashes.
> 
> Target map hashes are passed in via PKCS#7 signed attributes. Hornet
> determines the extent which the eBFP program is signed and defers to
> other LSMs for policy decisions.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  Documentation/admin-guide/LSM/Hornet.rst |  38 +++++
>  Documentation/admin-guide/LSM/index.rst  |   1 +
>  MAINTAINERS                              |   9 +
>  include/linux/oid_registry.h             |   3 +
>  include/uapi/linux/lsm.h                 |   1 +
>  security/Kconfig                         |   3 +-
>  security/Makefile                        |   1 +
>  security/hornet/Kconfig                  |  11 ++
>  security/hornet/Makefile                 |   7 +
>  security/hornet/hornet.asn1              |  13 ++
>  security/hornet/hornet_lsm.c             | 201 +++++++++++++++++++++++
>  11 files changed, 287 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
>  create mode 100644 security/hornet/Kconfig
>  create mode 100644 security/hornet/Makefile
>  create mode 100644 security/hornet/hornet.asn1
>  create mode 100644 security/hornet/hornet_lsm.c

...

> diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
> index b44ef68f6e4da..57f6e9fbe5fd1 100644
> --- a/Documentation/admin-guide/LSM/index.rst
> +++ b/Documentation/admin-guide/LSM/index.rst
> @@ -49,3 +49,4 @@ subdirectories.
>     SafeSetID
>     ipe
>     landlock
> +   Hornet
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3da2c26a796b8..64c9aaff6a219 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11399,6 +11399,15 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
>  F:	drivers/iio/pressure/mprls0025pa*
>  
> +HORNET SECURITY MODULE
> +M:	Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> +L:	linux-security-module@vger.kernel.org
> +S:	Supported
> +T:	git https://github.com/blaiseboscaccy/hornet.git
> +F:	Documentation/admin-guide/LSM/Hornet.rst
> +F:	scripts/hornet/
> +F:	security/hornet/

I know we talked about this last time Hornet was proposed, but as a
reminder, here are the guidelines for new LSMs:

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md

> diff --git a/security/hornet/Kconfig b/security/hornet/Kconfig
> new file mode 100644
> index 0000000000000..19406aa237ac6
> --- /dev/null
> +++ b/security/hornet/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config SECURITY_HORNET
> +	bool "Hornet support"
> +	depends on SECURITY
> +	default n
> +	help
> +	  This selects Hornet.
> +	  Further information can be found in
> +	  Documentation/admin-guide/LSM/Hornet.rst.
> +
> +	  If you are unsure how to answer this question, answer N.

Pointing people at the docs is good, but there really should be a couple
lines about Hornet here.  At the very least explain that it does BPF
signature verification and allows for other LSMs to enforce policy on
this integrity verification checks.

> diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
> new file mode 100644
> index 0000000000000..a8499ee108ad3
> --- /dev/null
> +++ b/security/hornet/hornet_lsm.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Hornet Linux Security Module
> + *
> + * Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> + *
> + * Copyright (C) 2025 Microsoft Corporation
> + */
> +
> +#include <linux/lsm_hooks.h>
> +#include <uapi/linux/lsm.h>
> +#include <linux/bpf.h>
> +#include <linux/verification.h>
> +#include <crypto/public_key.h>
> +#include <linux/module_signature.h>
> +#include <crypto/pkcs7.h>
> +#include <linux/sort.h>
> +#include <linux/asn1_decoder.h>
> +#include <linux/oid_registry.h>
> +#include "hornet.asn1.h"
> +
> +#define MAX_USED_MAPS 64
> +
> +struct hornet_maps {
> +	bpfptr_t fd_array;
> +};
> +
> +struct hornet_parse_context {
> +	size_t indexes[MAX_USED_MAPS];
> +	bool skips[MAX_USED_MAPS];
> +	unsigned char hashes[SHA256_DIGEST_SIZE * MAX_USED_MAPS];
> +	int hash_count;
> +};
> +
> +static int hornet_verify_hashes(struct hornet_maps *maps,
> +				struct hornet_parse_context *ctx)
> +{
> +	int map_fd;
> +	u32 i;
> +	struct bpf_map *map;
> +	int err = 0;
> +	unsigned char hash[SHA256_DIGEST_SIZE];

I'd suggest a comment block here explaining that the hash choice is
fixed to SHA256 to remain compatible with the existing BPF signature
mechanism.

> +	for (i = 0; i < ctx->hash_count; i++) {
> +		if (ctx->skips[i])
> +			continue;
> +
> +		err = copy_from_bpfptr_offset(&map_fd, maps->fd_array,
> +					      ctx->indexes[i] * sizeof(map_fd),
> +					      sizeof(map_fd));
> +		if (err < 0)
> +			return LSM_INT_VERDICT_BADSIG;
> +
> +		CLASS(fd, f)(map_fd);
> +		if (fd_empty(f))
> +			return LSM_INT_VERDICT_BADSIG;
> +		if (unlikely(fd_file(f)->f_op != &bpf_map_fops))
> +			return LSM_INT_VERDICT_BADSIG;
> +
> +		if (!map->frozen)
> +			return LSM_INT_VERDICT_BADSIG;
> +
> +		map = fd_file(f)->private_data;
> +		map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash);
> +
> +		err = (memcmp(hash, &ctx->hashes[ctx->indexes[i] * SHA256_DIGEST_SIZE],
> +			      SHA256_DIGEST_SIZE));
> +		if (!err)
> +			return LSM_INT_VERDICT_BADSIG;
> +	}
> +	return LSM_INT_VERDICT_OK;
> +}
> +
> +int hornet_next_map(void *context, size_t hdrlen,
> +		     unsigned char tag,
> +		     const void *value, size_t vlen)
> +{
> +	struct hornet_parse_context *ctx = (struct hornet_parse_context *)value;
> +
> +	ctx->hash_count++;
> +	return 0;
> +}
> +
> +
> +int hornet_map_index(void *context, size_t hdrlen,
> +		     unsigned char tag,
> +		     const void *value, size_t vlen)
> +{
> +	struct hornet_parse_context *ctx = (struct hornet_parse_context *)value;
> +
> +	ctx->hashes[ctx->hash_count] = *(int *)value;
> +	return 0;
> +}
> +
> +int hornet_map_hash(void *context, size_t hdrlen,
> +		    unsigned char tag,
> +		    const void *value, size_t vlen)
> +
> +{
> +	struct hornet_parse_context *ctx = (struct hornet_parse_context *)value;
> +
> +	if (vlen != SHA256_DIGEST_SIZE && vlen != 0)
> +		return -EINVAL;

It seems like one could incorporate the sanity checking into the
if-statement below.

> +	if (vlen != 0) {
> +		ctx->skips[ctx->hash_count] = false;
> +		memcpy(&ctx->hashes[ctx->hash_count * SHA256_DIGEST_SIZE], value, vlen);
> +	} else
> +		ctx->skips[ctx->hash_count] = true;
> +
> +	return 0;
> +}
> +
> +static int hornet_check_program(struct bpf_prog *prog, union bpf_attr *attr,
> +				struct bpf_token *token, bool is_kernel)
> +{
> +	struct hornet_maps maps = {0};
> +	bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
> +	struct pkcs7_message *msg;
> +	struct hornet_parse_context *ctx;
> +	void *sig;
> +	int err;
> +	const void *authattrs;
> +	size_t authattrs_len;
> +
> +	if (!attr->signature)
> +		return LSM_INT_VERDICT_UNSIGNED;

Do we need to check the "is_kernel" flag so we don't signal UNSIGNED
to an enforcing LSM on the second half of a lskel program load where
the original BPF program is being loaded?

I'm also not a big fan of mixing int error codes and enums in the return
value, I'd rather see those split out into separate vars.  Perhaps
still return the error codes, like the -ENOMEM below, but pass the
verdict info back as a pointer in the arg list?  This applies
elsewhere in this file/patch too.

> +	ctx = kzalloc(sizeof(struct hornet_parse_context), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	maps.fd_array = make_bpfptr(attr->fd_array, is_kernel);
> +	sig = kzalloc(attr->signature_size, GFP_KERNEL);
> +	if (!sig) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +	err = copy_from_bpfptr(sig, usig, attr->signature_size);
> +	if (err != 0)
> +		goto out;
> +
> +	msg = pkcs7_parse_message(sig, attr->signature_size);
> +	if (IS_ERR(msg)) {
> +		err = LSM_INT_VERDICT_BADSIG;
> +		goto out;
> +	}
> +
> +	if (validate_pkcs7_trust(msg, VERIFY_USE_SECONDARY_KEYRING)) {
> +		err = LSM_INT_VERDICT_PARTIALSIG;
> +		goto out;
> +	}

Personally, I'd be much happier only allowing the secondary keyring on
my systems, but we know that some people are not as concerned about
allowing user and session keys, so we should think about ways to allow
Hornet to support multiple keyrings so long as the keyring is factored
into Hornet's integrity verdict.

This is worth some discussion, but we could potentially encode this into
the integrity verdict (e.g. VERDICT_GOODSIG_TRUSTEDKEY, _GOODSIG_USRKEY,
__GOODSIG_GRPKEY, __GOODSIG_SESKEY, etc.).  We could also leave that up
to the enforcement LSMs that care as they are passed the bpf_attr in
security_bpf_prog_load_post_integrity() already.  Or something else?

I'm also not sure how much key type granularity we want.  We definitely
want trusted key vs others, but do we care about user vs session keys?
Perhaps that is an argument for deferring to the enforcing LSM.

If all else fails, we could add some Hornet specific configuration knobs
for this, but considering the simplicity of Hornet, I think it would be
nice if we can keep the zero-config nature of Hornet.

> +	if (pkcs7_get_authattr(msg, OID_hornet_data,
> +			       &authattrs, &authattrs_len) == -ENODATA) {
> +		err = LSM_INT_VERDICT_PARTIALSIG;
> +		goto out;
> +	}
> +
> +	err = asn1_ber_decoder(&hornet_decoder, ctx, authattrs, authattrs_len);
> +	if (err < 0 || authattrs == NULL) {
> +		err = LSM_INT_VERDICT_PARTIALSIG;
> +		goto out;
> +	}
> +	err = hornet_verify_hashes(&maps, ctx);
> +out:

Style nitpick - a line of vertical space between the
hornet_verify_hashes() call and the jump label would be a nit nicer
visually.

While I'm talking about style, I know the old days of a strict 80-char
line length are no more, but I still prefer the 80-char limit for code
I'm maintaining.  As you would be maintinaing Hornet that decisions is
up to you, but 80-char lines are nice ;)

> +	kfree(ctx);
> +	return err;
> +}

Some of this would be mitigated by the fact that Hornet verifies the
lskel loader and all the maps, but should we worry about nested loaders?

> +static const struct lsm_id hornet_lsmid = {
> +	.name = "hornet",
> +	.id = LSM_ID_HORNET,
> +};
> +
> +static int hornet_bpf_prog_load_integrity(struct bpf_prog *prog, union bpf_attr *attr,
> +					  struct bpf_token *token, bool is_kernel)
> +{
> +	int result = hornet_check_program(prog, attr, token, is_kernel);
> +
> +	if (result < 0)
> +		return result;
> +
> +	return security_bpf_prog_load_post_integrity(prog, attr, token, is_kernel,
> +						     &hornet_lsmid, result);
> +}
> +
> +static struct security_hook_list hornet_hooks[] __ro_after_init = {
> +	LSM_HOOK_INIT(bpf_prog_load_integrity, hornet_bpf_prog_load_integrity),
> +};
> +
> +static int __init hornet_init(void)
> +{
> +	pr_info("Hornet: eBPF signature verification enabled\n");
> +	security_add_hooks(hornet_hooks, ARRAY_SIZE(hornet_hooks), &hornet_lsmid);
> +	return 0;
> +}
> +
> +DEFINE_LSM(hornet) = {
> +	.name = "hornet",
> +	.init = hornet_init,
> +};
> -- 
> 2.52.0

--
paul-moore.com

