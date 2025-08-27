Return-Path: <bpf+bounces-66703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B27B38A5E
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 21:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39F27C2015
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 19:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A1C2F1FC5;
	Wed, 27 Aug 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIziRyhU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3B62F0C75;
	Wed, 27 Aug 2025 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756323680; cv=none; b=ApZD08MbZaDZ8m5Tb4HzN5sTfhlqzq20HoPANAKVx7xTfr/MBDPCrY7+6ytGr7DtpV8U0m+BHtPkVm++xc180643C4OqL0SmDuV5tg8v3gLnha+Lj3bQta4aUXMMV81pN+JCezxTxnwgGCJpjvmrpfdbVY0T8MKI8dURy1VZf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756323680; c=relaxed/simple;
	bh=vEcTX+IJtC4tyEReyxPu5FFU0lfPZov13eFWWbxnWDc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QGvV488HOtH3SVUcj/WwmauRtIO+gZDjK2MdlBBtftv2m/6qJMlmUvUQH0HEKkqB8mYIKElVadASB2d1SIP9IdC86XEAXeqGI1OkdIcDAXIt03x2hY/p6J0kv43daXqSJur9XY047U5+NGLI14IHVJaWR37hLRdlVbT+OhnWFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIziRyhU; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4c645aaa58so32733a12.2;
        Wed, 27 Aug 2025 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756323678; x=1756928478; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vEcTX+IJtC4tyEReyxPu5FFU0lfPZov13eFWWbxnWDc=;
        b=kIziRyhU8FVRo3AwqKg1KbDsUi7cGXxUcl6JK1UfgDika8Lo4XTb/YkPTpztzSnmLY
         cjviOzWZZpyPYgkqxqE4ek0Nu50JTjKuFXg2kTKwaVPruxGmfzfM6TiE2jsa/WoSOiLt
         8cfZNAZIQNE+NVfniSnN8q6Rt+RO/l06mJN3qJPAsy8CJDzBhsy1DzoUdIwolYObY3Cb
         igL8mfAEk4K+UGWLss8d6eDNwK9LYjw5vbo+qvr/RQY7+NcqnfvqFdkIybVhqJMKSydr
         sN3D+CPEzacTiBddtc+/cyg3nrbjT+OfGgrrsBTBgoMpGPm1SjJYkKqdMxG7BeILdeko
         Mn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756323678; x=1756928478;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vEcTX+IJtC4tyEReyxPu5FFU0lfPZov13eFWWbxnWDc=;
        b=gIjXytZIk44j5NwNU0Fy5aS3Tmp0Y/1/apqFVERTbZg3x7bo5sqwFmazQ+9D+UvlAa
         KI1VAcZhexBItQjuVUH1nW4RBgDYCd3cdb5vkKgJ0qrm67TgZWOkFR5DE8PUN7fYrZVt
         /m4Mr4nbVRCkAlq8RbLilihlZ0uzC8TEfHzUgvrrJoKEM1td/HA9jk1GwFZaoTlztcue
         hVymTpeNNnpfMIP7nSlef7WyrEHqGj7xW6nifQH7ECS0WG3UiqJsSRlbPFkSL6sR+BX8
         2DQOxsvIDrLvjpEFB2JRoz/Q7RzQhU/4yTZnDCWECupfecTpOKC7LtdMzLKHoEOZleso
         gwRA==
X-Forwarded-Encrypted: i=1; AJvYcCWvR3W+HrG5pYi5DLyL2ISg/9I9kC///ywvf9SPJmdPKHu6RZQGYjNDGGjdhtrqZxx/6pI=@vger.kernel.org, AJvYcCXKolM3CA+PEHN4c5+H5paCBfniju1sta7RYVFNWfh0MOZFJ8T7W3c7/1+LJOy7do926UB0eflGBsxjZace@vger.kernel.org
X-Gm-Message-State: AOJu0YwsRwAdXPOYfnRnIw+MxMq7NMATIOMcDjPRErLqiLbrMXY5zDMJ
	mrPDervoWx+A86cLTac8QbX2LUPqpJIL1sIcjwCaeJ+8ML5lOf/jo2wh
X-Gm-Gg: ASbGnctbzwzFhB7F8tDjhp6nOpjU2+DJPQUrNpWWjf65S8U8/rZnjwq9DpWZkwWRFUx
	8OqNT03MAOtagyOhtCxj+eVKo76QEKSM5zxiA/IX3vi1LbfDm1knkBKNd5FWdyywinltGQyGBrn
	vYTO4drztud0tjXp/+O6RnWtZwwpcNgTH12U/QLxnN34CgiM95Eu383KjKsWOq1J6tB+dXHkG7W
	2IXfpfnJxJvAwfAxtUXluMU263PbsDDUy0e3G5BEuYKyUvvs535F6CRNYj+6EOCQH/VZcGg+Ijc
	qtDf0NWI7HADBq5E4OQwoC7m87WVF17v6ODLSpgmMZWx50AeZEbXwlGR/2CU0gEtkoC/6JUcc/1
	mWMiFB5iRrs1KvgB/e+dqKHcVIn4qOtnhq/TJFHckdppJZoRH
X-Google-Smtp-Source: AGHT+IH7s2AamNTWrMrRU8dm7+lopFjTiWnQX3FlTF9l3zemtnrsM6foPkGGDujLP9d/vkBOvlSuiw==
X-Received: by 2002:a17:90b:3d89:b0:31f:42e8:a899 with SMTP id 98e67ed59e1d1-32515e37405mr26463549a91.13.1756323677848;
        Wed, 27 Aug 2025 12:41:17 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:6ed5:bfbc:8f3d:6d63? ([2620:10d:c090:500::4:16a5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327ab0dbe86sm22612a91.21.2025.08.27.12.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 12:41:17 -0700 (PDT)
Message-ID: <0d5c5cf8e1f3efb35b1f597dae2ae2bf0fb9a346.camel@gmail.com>
Subject: Re: [PATCH] bpf: Mark kfuncs as __noclone
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, Yonghong Song	
 <yonghong.song@linux.dev>, Andrea Righi <arighi@nvidia.com>, Alexei
 Starovoitov	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko	 <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 27 Aug 2025 12:41:15 -0700
In-Reply-To: <c41268ae-e09c-43e3-9bd3-89b762989ec0@oracle.com>
References: <20250822140553.46273-1-arighi@nvidia.com>
	 <86de1bf6-83b0-4d31-904b-95af424a398a@linux.dev>
	 <45c49b4eedc6038d350f61572e5eed9f183b781b.camel@gmail.com>
	 <a3dabb42-efb5-4aea-8bf8-b3d5ae26dfa1@linux.dev>
	 <a7bcc333d54501d544821b5feeb82588d3bc06cb.camel@gmail.com>
	 <c41268ae-e09c-43e3-9bd3-89b762989ec0@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-27 at 20:28 +0100, Alan Maguire wrote:

[...]

> I'm working on a small 2-patch series at the moment to improve this. The
> problem is we currently have no way to associate the DWARF with the
> relevant ELF function; DWARF representations of functions do not have
> "." suffixes either so we are just matching by name prefix when we
> collect DWARF info about a particular function.

Oh, I see, there is no way to associate DWARF info with either
'bpf_strnchr' or 'bpf_strnchr.constprop.0' w/o checking address.
Thank you.

> The series I'm working on uses DWARF addresses to improve the DWARF/ELF
> association, ensuring that we don't toss functions that look
> inconsistent but just have .part or .cold suffixed components that have
> non-matching DWARF function signatures. ".constprop" isn't covered yet
> however.

Is ".constprop" special, or just has to be allowed as one of the prefixes?

[...]

