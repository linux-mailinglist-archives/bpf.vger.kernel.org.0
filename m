Return-Path: <bpf+bounces-27842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EABF78B2873
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 20:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1AB11F2244C
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 18:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4EA14D444;
	Thu, 25 Apr 2024 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuSx3VYq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8D83A1BB
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070993; cv=none; b=lIORnnBWgjRePGKlFUt8CzA7csx4JC2caVU0Qtegu/dEu3WED0rlMvqm3rZ4eZs/CkZbW7LpFGPw2GQaCqNeX4bmW+FWqEcw/bWBVLDSzFg75LgE0ykeRj2lXrzcrdJCrW4gHmAtyegtH8HHbUYFAgK+wKPCbmKCX6AzaZY6qYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070993; c=relaxed/simple;
	bh=BbAtnIxoyUfB5I3eCsDxo9JTtTmlpXNnoLqVQcI8xE0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N3yrcxYvjcLrZ9BzzNzfQOmpRzktNVIKYkSBokk2MeBLtWvfSl4ti7SmxxdZxZ+X96cSd/2roTq69t3KRo9dG007Kl1JfMRNfqaUEn3LzOXrTXB0vpkdYNDHFHnURMqgvYwdAoqtTVIHxXZjPJNNafaVpU7ZgoWFyu6OiR4HJ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuSx3VYq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecec796323so1455579b3a.3
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 11:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714070991; x=1714675791; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BbAtnIxoyUfB5I3eCsDxo9JTtTmlpXNnoLqVQcI8xE0=;
        b=VuSx3VYqBVp+fSOXdruhnoX8oMZpkkhNftmfL7LamMZOtxQX7IWKIwD9FSiSwgguzy
         FaIuPYoXYw3o28xPcQahA4W5f7YokXSLuPdd9yRq9p+LJSAYJJ0I0Zh2sUp4i3NxR5wx
         DR3mbEg8qOdKOJFURoXOvMwcYMz9yKu+PSpncYAkNkGWTs4XG/DgPpI+/9F3mXsdmbIl
         S/W3fq1YAXnOcENNunTmybOjp772dada+4sskEmG4rZqWXJujq4f2eF1+tuSuMjnJNnS
         9PSlfLi7EbeCkSlp1N4fhzpTaW4USU3XCzai1mDlu8Ai2d9Adqa/650ObYTFQFeD0nmm
         rcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714070991; x=1714675791;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BbAtnIxoyUfB5I3eCsDxo9JTtTmlpXNnoLqVQcI8xE0=;
        b=Gt1W4901iUq5oKsRtJCZvr/zKtDEKmooTKsrFtWtzG6+gbRK08A5pyiUQ+rOBfRRpW
         bR/1phkJSoDJea0vRCPi/oKG5/aRGbPgN0PctwZjmmqJZbWCMg6MZDni2DFT+yUbxLYJ
         JeqolwszgTnjY0bX/kiDjKTNd+VeK2qRL5dvDJkzKDbHWmQsICnAtxUMDX/fYafLApoi
         bni+qCOI6flLdJYK3uK9wvrgvWLG0jeUnU2tuYIRWggE3v4XOMzXmC9am5tdKrxNnGI6
         WnVr/cvVmnSgI0uHosC/B3ME9cqOrHL0x+8RoTe5K5QhKjuwci/Js8LnRAfqpTi/rcp0
         CK7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWj1YxRMKth/dYhDYQ585YvYZX0fi3dJOeGYHsqW2x/14cQdHCg4LOQP7AMvK+KC9C+1RN+KmMwA7RPD+hzTFppC0ss
X-Gm-Message-State: AOJu0Yyog22TUwPBdeObYYwJmaw4ySUBxPt9AfIOefl0EFjX5AZKk50T
	DvlzFrF1GSWAIyrDwPkZkVHJKYKyHKr6DeWNt0BM0AQBR3J2HEh4hUFDgyfn
X-Google-Smtp-Source: AGHT+IGIjPPH+WGkEuutjmBsGDOns9s4wSFYPcwpYppriBDmC/a37LCPakDGM1b2XoQZ8Vs9Gtlppg==
X-Received: by 2002:a05:6a00:2d1c:b0:6ed:def7:6ae2 with SMTP id fa28-20020a056a002d1c00b006eddef76ae2mr834346pfb.6.1714070991578;
        Thu, 25 Apr 2024 11:49:51 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:b5d8:5a56:aaf7:f817? ([2604:3d08:9880:5900:b5d8:5a56:aaf7:f817])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00218300b006ed4aa9d48esm13432324pfi.212.2024.04.25.11.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 11:49:51 -0700 (PDT)
Message-ID: <78fd7fb5cd128467c298fd646ae5d61d89a3231a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf/verifier: refactor checks for range
 computation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, Jose
 Marchesi <jose.marchesi@oracle.com>, Elena Zannoni
 <elena.zannoni@oracle.com>
Date: Thu, 25 Apr 2024 11:49:50 -0700
In-Reply-To: <20240424224053.471771-3-cupertino.miranda@oracle.com>
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
	 <20240424224053.471771-3-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 23:40 +0100, Cupertino Miranda wrote:
> Split range computation checks in its own function, isolating pessimitic
> range set for dst_reg and failing return to a single point.
>=20
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


