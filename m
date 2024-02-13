Return-Path: <bpf+bounces-21918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C299885402C
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F36A1F25224
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 23:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F99863108;
	Tue, 13 Feb 2024 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoVJTn2T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980562800
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867424; cv=none; b=XVHp0YcRsp0q4R+1CoBT84Evfxx03RIXUwXmXlrJd7ucNxDFmB/L8aVyLkW77snTICEdp9EKZUOZIcykR7rEcXrZ1Po1KhcG9U6/Qz1/Rj6Gou8maCLVndUoGGsoozz3a7CMM7OdAoIjakJJg6KJsmQSS5ws74T4cAI/BXn6b9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867424; c=relaxed/simple;
	bh=1Rc1hARS6sAlkc4aeT8oygkAbF66RgXa6R65/E5ChGc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jkDADiPobsKA7HEH9fFOsL5Mgjjg/5/o8ltn3Fc//pTZ6VPVADCR9cnMcmTR1Q8iNBYudRH3N4l1hFJ7AoRRl+2Wy066hR6MhH+FMyYScs9hB7uso+Rvg1b1SkvGn29ZlNAIYX5AZcwQ7WAFmn7wK8K80g+fFTvlOwqpNNnbTHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoVJTn2T; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so45254466b.1
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 15:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707867420; x=1708472220; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0hUIE1923gX+gA5HGcjiSgZNGpLyrW2DgkN4abw2SgA=;
        b=GoVJTn2T06xYiKPXzzFkCuiOfZYF6GL07ZH4Et49kXxDMK/FOx+3Cy3PdbYhnmES4i
         zWSwoD4PVKL+TOQmlXJFORUsG09EeT1gMQ1y6yDsuM6bXyN8vuNEt7wZOFH/99Gl/SmT
         /is7qLqxdImoUSX+1LgvFIn8SFs7OqPUPuL3W2c0N0WdP0OkTZpCdSZHItwn0N8o1/XC
         hOr4EZ/wyAyU3OKMts6FLc7xhLp487hatY7fzp62FXbQDJcj+ArXuvycbDZWdNCS9arI
         rtbI0YATmbdotnzk/Gp+Rs5UIDcMpelwqFAlUwZxi1HFgWeV6h/cpLP7hxj4u58UG2s4
         aZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707867420; x=1708472220;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hUIE1923gX+gA5HGcjiSgZNGpLyrW2DgkN4abw2SgA=;
        b=oD6U94xHZ6DvZfePgc9FVyo0RUT+xM7YBt/S4ZvXrJ5YZIjshX5JmggL9i+fAEDbnN
         IFojrGTnpXf9yjblcMrh1UkCV/K1aG2hbmMNpM2yGh1taYUsLX5PUda8bDFFNbdYDJUo
         6E1tJV8crSWIn68pmq+DwFSJnmmzB66c2+Igj7Y5K+xA9lpI7TYSiBJb8jMDniGBuU62
         fp38/7rGzYY6XQByfQU5BCQdIJ8K+MmrMLcLaeriKu/mFaFAemrMMTplRV1/+OUf/XWa
         h/ka/E/6Tl9oCzv2A1PNLliUEypNHfjXQgC1vkqvQ4UpcUF9DH0q3kdtUJRWC95Sls0K
         hWEg==
X-Forwarded-Encrypted: i=1; AJvYcCW26ab6uLS6ysskIRde3S9a7bPLMpmYrgjh4lzOYyMS2qTVsQCyMfFUfrQoA0koY9o5dB9TEUbqbPQeuUCWVhhNnWZj
X-Gm-Message-State: AOJu0YxcerKfogswFIH7Qbc5fpFHOzm4UtRH+uTIjXVmyD7qNYu8zjMs
	HpHkZe9t8zsLNP6SpPScR+HkQLETapCnhQmZk+Gx5zsnWYBFA04f
X-Google-Smtp-Source: AGHT+IFTaInuALn86gf9IsOHIEM+1oYdK2sjaUevLA7x4FM8C65vk2n6RdtSFxvcyTxu+us7bxqx+Q==
X-Received: by 2002:a17:906:35c7:b0:a3c:55e4:eed7 with SMTP id p7-20020a17090635c700b00a3c55e4eed7mr251476ejb.21.1707867420473;
        Tue, 13 Feb 2024 15:37:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQ09dIIoZNA4mT/d3xWESJ5UuEIyUTQDBr3a9UnrM/PFNjk3Dd3fE7IUOPnS05Esft8/eSkODzzgIyvVcQnj/LjVOto0t0lDhHgS4K0ZPhkenyO3ESCVRLI+vf378HwuGT5HRjljrjUo214fVsxMLQTcfKoWW6vnBPdj7lIe/mKOO69s9TvSWS1nOORLkTMRJuNeGyktgDNiNjzscmkhXUEwnQqdKRE0y/1X6tQy4AlkAPhbBUMgoFgyQW8Mp9xFfs1o8cNjw53NPveIuw5IGLUHzUflRvKCw+rXRYtNus28TlLlx7RQtHDwr4dE4AW9bwhoq5b8Dp/qFMTYh1cMJ/io9IDcvxKfwJQ5Eeuag+dv765C+JmkNtAsGthg36hqJ5wjYYBGFsqAjUBoMYwg==
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id lf8-20020a170906ae4800b00a3c6528ec4csm1737908ejb.135.2024.02.13.15.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 15:36:59 -0800 (PST)
Message-ID: <7af0d2e0cc168eb8f57be0fe185d7fa9caf87824.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global
 varaibles.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
 daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, tj@kernel.org, 
 brho@google.com, hannes@cmpxchg.org, lstoakes@gmail.com,
 akpm@linux-foundation.org,  urezki@gmail.com, hch@infradead.org,
 linux-mm@kvack.org, kernel-team@fb.com
Date: Wed, 14 Feb 2024 01:36:58 +0200
In-Reply-To: <CAEf4BzYbkqhrPCY1RfyHHY1nq-fmpxP2O-n0gMzWoDFe4Msofw@mail.gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
	 <20240209040608.98927-15-alexei.starovoitov@gmail.com>
	 <e9fbe163f0273448142ba70b2cf8a13b6cca57ad.camel@gmail.com>
	 <CAEf4BzYbkqhrPCY1RfyHHY1nq-fmpxP2O-n0gMzWoDFe4Msofw@mail.gmail.com>
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

On Tue, 2024-02-13 at 15:17 -0800, Andrii Nakryiko wrote:

[...]

> > So, at first I thought that having two maps is a bit of a hack.
>=20
> yep, that was my instinct as well
>=20
> > However, after trying to make it work with only one map I don't really
> > like that either :)
>=20
> Can you elaborate? see my reply to Alexei, I wonder how did you think
> about doing this?

Relocations in the ELF file are against a new section: ".arena.1".
This works nicely with logic in bpf_program__record_reloc().
If single map is used, we effectively need to track two indexes for
the map section:
- one used for relocations against map variables themselves
  (named "generic map reference relocation" in the function code);
- one used for relocations against ".arena.1"
  (named "global data map relocation" in the function code).

This spooked me off:
- either bpf_object__init_internal_map() would have a specialized
  branch for arenas, as with current approach;
- or bpf_program__record_reloc() would have a specialized branch for arenas=
,
  as with one map approach.

Additionally, skel generation logic currently assumes that mmapable
bindings would be generated only for internal maps,
but that is probably not a big deal.

