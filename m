Return-Path: <bpf+bounces-74478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B0FC5BC6D
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 08:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C81CE3463BB
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 07:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8AD2E613C;
	Fri, 14 Nov 2025 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SERAx9P8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838A3218ADD
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763105210; cv=none; b=mqllWJdxP7CkdsqxMKqmlshqGJzLo31TQrYM5LPWo0bNHp1BAqmErgaY3weVsfkQiONH+8pwT3Shwn5qcoyiijYAgy+ICaOS+xJ3bAPHUbWOIA9RLaAmKMvzJ8Shx8/D8NjnnW7xIj4op9eEDCJip3WX6qf8A21HHErSlEk9spQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763105210; c=relaxed/simple;
	bh=XTp2k2ibA53gk0oFCNEgJAgIH3Ao3lvDEXOzxQ1rj10=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IgmqUeTzjHSUcomf/o9l8zj173wtv5tSsGxtSWiukaeAmrgkbGpFa2ybELHLuS4IDH91qS0JKXDIZqa3NI6S8QYEvYdIkOSZPGv4v1rCknZ7l7VtuBqPdRhILa1PWlMYFb/R4Yefdh4R6CtBxKxqN3s7RqX9qtsH3zPGYneMcdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SERAx9P8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-298287a26c3so19853675ad.0
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 23:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763105209; x=1763710009; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XTp2k2ibA53gk0oFCNEgJAgIH3Ao3lvDEXOzxQ1rj10=;
        b=SERAx9P8JPWBZn+BOyJfPNxDB0Y++eqjpycRbq5V0W/7Cre0nqRLCe63Jn2b243cu7
         3jWGIFiCBpUbsSxRZcGTlzUgwJm3xP54PG37TwYVXvMkRtxxN2djKFhDdFPfo+yC03oZ
         iJs4WkRe6GEpGpDiVK7aRKtgUP335UG6rn4A+SKPVzS8kVRYW6RtFKtVkD9bCcvKBjF1
         d9npDViWwZr9fQrg9/zDkTrusE2+qv99LN/jIdIu3IhqUaFAnWrCElWaLHMuNjvj8Eo1
         Xy1W3B06CcJQy3kehFBMYdcN28190RNTFT+G3j0YrSsQfyI+WGPPqCpAuMvq1jTEloXr
         Z+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763105209; x=1763710009;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTp2k2ibA53gk0oFCNEgJAgIH3Ao3lvDEXOzxQ1rj10=;
        b=viMnvLef+zLnWnRaA7nOXUFt6KNST2tCwi1TDjUsLBoFVH/4k6KmyUcXY1o3nSFbrj
         mPkyWUwZ+2FhOms0RyFPZe4w0lAjoJcZkwrNbv0urRbT7C/rnKuS+4bGaE+jcORvZD/S
         lLXN5YiRRWhrrCSu6EyoA4JimRVV0/TBH+CYaeaYCW/2rpCQI0+GhxpyQF5chsEMMPiP
         0KAoW/TksBb0kFrd5or5YU40f/bG05DSCcKFWlLH8GLGMLRONYNcJzRiTPY7/2lByKEK
         zrvIphrKBKj8GZA25/nFXd3ILpmIx06YjVZ128Y3zqruWBwwrdhpeAIKuR5CmWwjWj0c
         EoVw==
X-Forwarded-Encrypted: i=1; AJvYcCW1xJH9JbMp4TV2e6T3bJeO4ixjceXIJvS/x3d1L2LiGuuwIBHTnvf9ji/BhwHKC2JDkg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlRncLs245fgn9w2glJ3VLmtNeuHZ2XM2BRw+sVqQyglRiLH8i
	V8gSdbwUMmy+2B0bjW0wGqiAJNZUkGNQUvzPZSuORoVYsfxU8JTVe8HQ
X-Gm-Gg: ASbGnct16aRN9Uc7dRy2agNxGe5VxnvZKM5ejdOJ/hNyX9i6bgUvXqMjCV88PNnWE9B
	0ks1F9YndkL0gDv3CLPaK/G4RtRhuLtdvch5oWb6P11IOn9i52nTx+K0ARuAKr+m1EwcCTJJyEZ
	6vwgkmPjqCdw2dVCahzYVC53q4MqKUoImJpwnnH0A5+q13RMPFFVyzNGlCksTNbxrdZ95DjaHOS
	I+HHCI3ffxwpW9RQNETpyuP0KtBRzZbgsg5PltRVk8Zyafcf9XD+QaVW3RDM6Ogr9wa+M1bZNLs
	kBUuhUjuu4RPbczEegfLXVOdLrzbBbTz3+Wni8F0mM0+SotK5ySgtSSCvqhIMsFNKdqZrFhst5P
	ewNyIH+PGmwdiCgZsEIzpcC3fLexsDCJSNXcfC6DYB9yDcXkRqPWtKhVCGYXxwuLzJFkLbx7I
X-Google-Smtp-Source: AGHT+IHrrvBrof7HIccXLuzpMiX4PGJgRl6E2cEFByzJrPF0EwFnLM72wHjQ5lwYGYO1OcsUxip24A==
X-Received: by 2002:a17:903:2b07:b0:295:2cb6:f4a8 with SMTP id d9443c01a7336-2986a76a1edmr23196095ad.51.1763105208585;
        Thu, 13 Nov 2025 23:26:48 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c234809sm45737415ad.19.2025.11.13.23.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 23:26:48 -0800 (PST)
Message-ID: <f273691ffc4f2ca3a4f6b16abb50804f60aa4fe9.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Recognize special arithmetic shift in
 the verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	sunhao.th@gmail.com, kernel-team@fb.com
Date: Thu, 13 Nov 2025 23:26:45 -0800
In-Reply-To: <20251114031039.63852-1-alexei.starovoitov@gmail.com>
References: <20251114031039.63852-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-13 at 19:10 -0800, Alexei Starovoitov wrote:

[...]

> 227: (85) call bpf_skb_store_bytes#9
> 228: (bc) w2 =3D w0
> 229: (c4) w2 s>>=3D 31=C2=A0=C2=A0 ;
> R2=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D-1,smax32=3D0,var_=
off=3D(0x0; 0xffffffff))
> 230: (54) w2 &=3D -134=C2=A0=C2=A0 ;
> R2=3Dscalar(smin=3D0,smax=3Dumax=3Dumax32=3D0xffffff7a,smax32=3D0x7fffff7=
a,var_off=3D(0x0; 0xffffff7a))

Forking states is an interesting idea, however something is fishy with
the way we handle &=3D. After arithmetic shift the range is known to be [-1=
,0].
I would assume that binary 'and' operation cannot widen the range,
at-least if it preserves the sign bit, as it does here.
But verifier infers the range to be [S32_MIN,S32_MAX-133].
How is this possible?
I'm asking, because preserving the [-1,0] range and having tnum for
-134 actually represents two values. And it has all information
necessary to figure out !=3D -136.

[...]

