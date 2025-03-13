Return-Path: <bpf+bounces-53998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9E1A6013C
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4D97AE90D
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC2F1F1931;
	Thu, 13 Mar 2025 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwwOgLd2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB3D1F1303
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741894142; cv=none; b=eoWT6RDlBqA4d342xEPEYJy+pFWaAfdEmi6ZcmrFkgGimXIlkTfqrHq+bYrXBJ/KcAbYm+CAoTH2zaVDDNPXxOJa927LbzXRZjuj/VBBSUGKC4neAa8agEzdOLjhgt7LBOZbF+rN7Gc2Yg2F3FSKLnRO8NjKnmsvHWWajhtTZt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741894142; c=relaxed/simple;
	bh=x7Yk55LHkgQ52daVFMKoT2FDuQuAloadZadogEUSkrs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hr959x7Xb5wCUmCY3We5PnDlwFvBFvkwEnxfnXMRCT+moT+BsbCpxlnqUG6oUL46A+n9eNgE4sEc2X+rizmorU51mXyricfleUMXQSxXcnyhJwUMMNgNoCg2Mu9Q6I1AK07aWhaggrPR+axtCjkycuam/Fx7eZm1YIsOwGbd8y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwwOgLd2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225b5448519so26393375ad.0
        for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741894140; x=1742498940; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3dfku0Hje38VwB6g6HTNqYIRwoXSzbQAj43RKCFLVcw=;
        b=IwwOgLd2k2p1pQtY8RQmcAw7VNGhvY98Ucv5vVU06I7do8sNgzUDGBdoNhV3H8BEwV
         xBZBwyBTjr6j1R0eL/YHY9Btg+lQd6YaZwG+fhyd1itJp1STXnoFSjiKVA3+4Q+jqdDj
         ylEt57KJMAm6o3a3wxTufAUSMrDwwTYDJlt91yqnQfwthjoTl+c9BcWpoFNYUKIWBq19
         4jKk8ZaOR4nfI0TrfOcHeklwbIQ1GqvH7lZGE03Bnqf9hPcFtrF8krIds3oCVDMwsyi4
         uqu1398V3JAmrrqpxYlyB0Y3ww/cLxhhtv713tuwz0Je2Mp68zvafgsrIiXg12GbNCvk
         /2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741894140; x=1742498940;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3dfku0Hje38VwB6g6HTNqYIRwoXSzbQAj43RKCFLVcw=;
        b=QeFysu/x2oQ1r2i4BSpXdj+rLv8oFt7LUWglxe2dvEXLA6PsIZynr/OXXx84ZnNkIS
         0jvJO4wO3UpO+i5ON7F2MVdhQKssiDy3lVtv9DNqNCUw//yFzNnglkQIkExnGAGOaAmG
         Lf13se2gh4/Syw9//9qqJjKF8jB7Du21UPFQOLzDH/QQIE//QPyiIunngz9y5Nf3hoJo
         7H9kdGH1GasN5d+0gsSBerCYj2OoGRy4dssvZtdhwUa110AlLIjHeJL+X6JPwAVkWfwW
         bQhm7vPjM55l0GyIZw9eOrro0VhP4Lt+w8Gi2ZworodqdZdwyDQGMbp3J7O8cILJwmtJ
         gDbg==
X-Gm-Message-State: AOJu0Ywz2550Cftpgie73nj8HYr5ut874bU3SS+DKTJaoFuijezUBtTD
	vaOet3/t1rqLmP2WNQDffKl61ynxJbt658CX+z292Sxi7lsRq0yzj+RsPg==
X-Gm-Gg: ASbGncswYjN7Ta4YtrrCL9JdKM/iNAACWYzemBX29rgVl5S4/AdUiJhrHphx3j/NpzD
	bv5FAev80OiofsofqP7STBQ2FnNBKm+4jXzfMsuwbU+mPCzglCx3B3E7xpXsAiR1rVMbQ0WgzOV
	nTSkKSXYgJqcNcyve7DBAX3X60LmPYVJ+kjgQEBKBjTQ5oEJeIqJJlx7yNjE6WD7YRaUiOcI9+a
	VIRFRaQiqIRVCXFBeqUV9AgCt4y/k1V2RAwnDAyH+2sVI0TybSlo4WEkJJBxhDSYzL2AFDsLjbO
	zCJgdWMyzQ8WWVrQYvjBkk3fzPJUYcrqr/QRU6Io
X-Google-Smtp-Source: AGHT+IEIMXWPqvuTiZS2wu/CChN1ZvJWRVYnHGLLdtYauBWyFdXwj7K1WK0yNL6e+f0HxBgwZFfsGA==
X-Received: by 2002:aa7:930a:0:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-7371f0eccbfmr848704b3a.10.1741894140500;
        Thu, 13 Mar 2025 12:29:00 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371167df0esm1773090b3a.93.2025.03.13.12.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:29:00 -0700 (PDT)
Message-ID: <3c6ac16b7578406e2ddd9ba889ce955748fe636b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: states with loop entry have
 incomplete read/precision marks
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Date: Thu, 13 Mar 2025 12:28:56 -0700
In-Reply-To: <20250312031344.3735498-1-eddyz87@gmail.com>
References: <20250312031344.3735498-1-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-11 at 20:13 -0700, Eduard Zingerman wrote:
> Suppose the verifier state exploration graph looks as follows:
>=20
>     .-> A --.    Suppose:
>     |   |   |    - state A is at iterator 'next';
>     |   v   v    - path A -> B -> A is verified first;
>     '-- B   C    - path A -> C is verified next;
>                  - B does not impose a read mark for register R1;
>                  - C imposes a read mark for register R1;
>=20
> Under such conditions:
> - when B is explored and A is identified as its loop entry, the read
>   marks are copied from A to B by propagate_liveness(), but these
>   marks do not include R1;
> - when C is explored, the read mark for R1 is propagated to A,
>   but not to B.
> - at this point, state A has its branch count at zero, but state
>   B has incomplete read marks.
>=20
> The same logic applies to precision marks.
> This means that states with a loop entry can have incomplete read and
> precision marks, regardless of whether the loop entry itself has
> branches.

Which makes me wonder.
If read/precision marks for B are not final and some state D outside
of the loop becomes equal to B, the read/precision marks for that
state would be incomplete as well:

        D------.  // as some read/precision marks are missing from C
               |  // propagate_liveness() won't copy all necessary
    .-> A --.  |  // marks to D.
    |   |   |  |
    |   v   v  |
    '-- B   C  |
        ^      |
        '------'

This makes comparison with 'loop_entry' states contagious,
propagating incomplete read/precision mark flag up to the root state.
This will have verification performance implications.

Alternatively read/precision marks need to be propagated in the state
graph until fixed point is reached. Like with DFA analysis.

=D0=A0=D0=B5=D1=88=D0=B5=D1=82=D0=BE.

> The current verification logic does not account for this. An example
> of an unsafe program accepted by the verifier is the selftest included
> in the next patch.

[...]


