Return-Path: <bpf+bounces-22097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0114785699C
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 17:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07304B2679C
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7566D1353F7;
	Thu, 15 Feb 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ligqpZZO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376A1DFE4
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708014710; cv=none; b=ixuqawfV1gD9edW4F5Ioi/0Xb3KEuGOV6aATs3V+VQRrSJT9ZXwy8qJV/8Rc36ZXtWtTfAX6wiRsbFc+zb6yfWIT9f7DKUT6RfvkGTcQcmxQu4kJrEtE7Q1VewZ9P7/wJ2NYLS21Voobq2wJcZn6lxcPchq9X4dTBwy9OxRcpgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708014710; c=relaxed/simple;
	bh=8hTW03EyvJOfj796PBbP80vFWEaALIJjSyNkTfzLZ7g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HjseSz8OU8VgHwKPwK6RgSFJW2yaDrmZ+TLV6oczNsWjDLN0dww7hNKf7ef92Vo2NShQfcyPE/96rJYX3bhzsLWANlRZEWZvtVdTa0TSjwbBHvolfSNFJ5cUVMChNncfGPKDkD5m99f1MbnccEMvNPUBW1YsZjWiCGYimjsv61A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ligqpZZO; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7baa8da5692so50494139f.0
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 08:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708014708; x=1708619508; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=liqOngPWYl+OBSYvx1rf/M5jGtaRuPUoggsqvGkAQhU=;
        b=ligqpZZO7DcpoOSauYcEvipQ1C0ToxUVY+lfm4FVSPq9rnsUxYt1rgrUPi3JsrMlzm
         R/nWMarfg8tbFAsodW8/2VaywZENV4isPSrRNVPSVV0185jo0OF0O4kNV/2PbhQKQbyt
         maKH+JdlxQOgbL1OVmT+ZLFWoApAQJMWrSdEP6D9u/D5XmMo8fVILRzXP91NinZ4NJNE
         HONc4KsFmx7o+HVotQw6og8nEu1cXPhOeXq34PzLscBty6XS0sB0+sIhZCSDtUrBgClR
         JKEpw3uzI5koS1CGd3F775agydoRMWF28CH6XTxT+4i2o55QG3+Z/spkLsTRPJUT7bsE
         cK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708014708; x=1708619508;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=liqOngPWYl+OBSYvx1rf/M5jGtaRuPUoggsqvGkAQhU=;
        b=Rmrr3DwUc932SDDfie4qNOUgKJuKoFcnMZCpbQVuwU/jYQjZzRaJF6+RRrrqjCIAJd
         ERC+uOn0NHx2dNobULI/yeCxDyl1jsZNtm8OgF8LdA3kLRGpiouwiZSMen7dhDsFTRf+
         qE5p+Gzty/3khqBAhQQeJuQdFNR+4rg6AqtUIs9ecg1O8+fiDfVckaEPzvix//4Oelv8
         2Cwy8WAwtFuBOZ0IiieSjYroXi4uGKqx9ydXhAowidznacVJvIkXVTX5o9O09vKQ2+Xd
         IPKR3ckySGKCsYBKs8aHIv9CVflaHrg6C3PiPnW5je5NLYFf83BMdRnTjctPQRt5R/nV
         0fdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQaKmpFf+qbNn1l/Ta9C/K6UGYe51XYmDkXx8cTP3YLjAz1uscZ53aaJdM+V/zKyN4AcXV0llyt1fq4ckm36HK81ID
X-Gm-Message-State: AOJu0YwzKKEb8qYarXM47F+pDtHudzOiJcV/SbNM6u1BiOPcfkeyXKg5
	ZkKO6LpJbpPFb/lONkPM/t+nf2oxbdZG9Ny51hUwF6tLJYDR/ZQu
X-Google-Smtp-Source: AGHT+IG6F1HLx0HMViVnJnS49/r26RG0T3z7SrGZz5NacVH3gXVsuO6tBWiNj8zUv3dyVac7/ZKR5w==
X-Received: by 2002:a6b:7b47:0:b0:7c4:9545:824f with SMTP id m7-20020a6b7b47000000b007c49545824fmr2332060iop.5.1708014707694;
        Thu, 15 Feb 2024 08:31:47 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c3-20020a6bfd03000000b007c4883809f6sm400311ioi.18.2024.02.15.08.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 08:31:47 -0800 (PST)
Message-ID: <8cb6e0ffa4810396ef618bfc92449dfd54d47043.camel@gmail.com>
Subject: Re: [RFC PATCH v1 06/14] bpf: Adjust frame descriptor pc on
 instruction patching
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>,  Tejun Heo
 <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>,
 Rishabh Iyer <rishabh.iyer@epfl.ch>, Sanidhya Kashyap
 <sanidhya.kashyap@epfl.ch>
Date: Thu, 15 Feb 2024 18:31:43 +0200
In-Reply-To: <20240201042109.1150490-7-memxor@gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-7-memxor@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 04:21 +0000, Kumar Kartikeya Dwivedi wrote:

[...]

> +static int adjust_subprog_frame_descs_after_remove(struct bpf_verifier_e=
nv *env, u32 off, u32 cnt)
> +{
> +	for (int i =3D 0; i < env->subprog_cnt; i++) {
> +		struct bpf_exception_frame_desc_tab *fdtab =3D subprog_info(env, i)->f=
dtab;
> +
> +		if (!fdtab)
> +			continue;
> +		for (int j =3D 0; j < fdtab->cnt; j++) {
> +			/* Part of a subprog_info whose instructions were removed partially, =
but the fdtab remained. */
> +			if (fdtab->desc[j]->pc >=3D off && fdtab->desc[j]->pc < off + cnt) {
> +				void *p =3D fdtab->desc[j];
> +				if (j < fdtab->cnt - 1)
> +					memmove(fdtab->desc + j, fdtab->desc + j + 1, sizeof(fdtab->desc[0]=
) * (fdtab->cnt - j - 1));
> +				kfree(p);

Is it necessary to release btf references for desc entries that are removed=
?
Those that were grabbed by add_used_btf() in gen_exception_frame_desc_iter_=
entry().

> +				fdtab->cnt--;
> +				j--;
> +			}
> +			if (fdtab->desc[j]->pc >=3D off + cnt)
> +				fdtab->desc[j]->pc -=3D cnt;
> +		}
> +	}
> +	return 0;
> +}
> +

[...]

