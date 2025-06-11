Return-Path: <bpf+bounces-60313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903A3AD555C
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 14:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4243D3ABDFA
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 12:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF9427E1CA;
	Wed, 11 Jun 2025 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW3yRWkB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D523AB86
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644483; cv=none; b=UUdnp56wDgVFbiKiyaiMzQrU5CJ00xm5M3Ohe292+ondPxGiqPO7e2Zt4yobUOa8AXyAgEaANQ30IZlZqWTIcIYAsIJWecs7Cve8gZZRJ9ikVZTRYaOFTS4YHiv6AtWOOv0SJ/1mzIrF8a9x8qWG6jIr0+JyoEwzczAXfSf1vz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644483; c=relaxed/simple;
	bh=K9rwAHDLDs2lzgnKjaAsjH6iFs1RTsMso7nypALzI4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jHhbaTc9Sg2wZ5jewMj4teIvbQ0+38q9wZFh8b9zzEpFlNn9yRjOnLLaxPAm72NCBfNKzp0RvveYuBa05x24cdp9loIOCyZGxRHxjs38q3jHbV+OKjCUoDwuAU/NtRGf0opTVfpH+bvzUtPt6ptaqzLnAtJAkXnBgyfNlwN8xY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW3yRWkB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-312116d75a6so5135006a91.3
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 05:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749644481; x=1750249281; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E1B7DnBXy0IdcP/jrCL8jZJHqdRALJZzS/AHCMhDUxs=;
        b=NW3yRWkBNY1xCHPP6wfA9jk1iN9E1j4W5vtd+K1Yv9QOMfHG/BERGhu8xc9pDmgwdM
         B6brdv1I32IckMToZLruaK1NyTUl9WLLv2rI6PzYlRSov9IMnRRVYE3NYNlrAJepGF33
         +kY4D6cgC+YMBxG1+zYNZ9NCX2jbxE5whCMt/pdAgYDY00+tASP/Vr3OJvMK2bK7WKWc
         dWzFAmnWM2iZ0diBXtCniUklv1yC6LdG5DkjIfK3D6LZUXrZeycCNvtcpfq0LGg+7V9U
         SQ9LTjQGvWQ13PKBg7LQ0lL9N9jVCrQWllC/JXLOcrSiErxkP+huhjgNXp5QGJN2WN9f
         m90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749644481; x=1750249281;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1B7DnBXy0IdcP/jrCL8jZJHqdRALJZzS/AHCMhDUxs=;
        b=fwS6vrwjxSRvTNdSmyjQXGyjTk+rGcd+ilTt7fmD72h1JWF/4RBaDBTW8gbXl/Hr1x
         rcbW4r3hJV75cZk6IcGWMJwsrjybathK8uj0puKkCxjVBc1q5HLs0thfyNJf1BIUpOuY
         eu6IfBCHif4F8/HhsRH30koN7WdfeyOjdoGhPjFcAJpurTO74UtgU810jMSE1RgCEe7R
         +x1qAwY4lvZVEplmdG6tsGpRCY2PQ1/GrSEBLIHDsWOrRgAJpfc081AQE+sY1EW/jct+
         8EqKAsnNimO1/fjXu0swBlTRIsXM7GkdPRLeibbq391cbUGj5xzkRB3qLutaa+ByPtnd
         9h/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEhM9KmXxRSk2W3XbeuZJkRpJ6F+VsMFj0Bi7i4C1dhty1rY/KCfDQWDRvsv2bd3YDXtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFoCO6/9cQ6wPxWEvYyIIat8ZfFLXk42KYPus16tQ/tArnb/3X
	9u+bRKf3JCuC2wlXLaM4aWITxPAdi/Vgqj6O4K9d3w5IAQn4dDg+0sur
X-Gm-Gg: ASbGnctxvmO7DnYWuNr2Pg5yghfLv+PWZ/FTxBnFP3Dr8D7dZJPI7iDVEwlYr3JHlSc
	cU2sxDUnNipVvPApbFRRglhtQRBxCq23UDnarr39++RdkImGI+Ri3AsAkeFhq7re2D+4QKwzJrc
	OIDJtmRk1VkgrojY1YKS03kM2FotedltUEk096NGGsIug13XuOpcNCmv9eWPyfMDhjlqdEW5kD5
	qmGD09L6nafGShrV8PK1oMQdi85MIOc6cWofgxSK2th187T9zgEN6lA7tifriThw8Xs187blcPt
	0fRtSto+F+CjsdxUG6FkpI2mHECnsopwNJW/uvRE2jPGsb664S/izMalrg==
X-Google-Smtp-Source: AGHT+IGbUQo1xGdrVwb8b8NwbMXS0J9qAxcb5SMY5jzCP7dTZJpP/Y6HCT28dMPdp28wdP2MfR0RwA==
X-Received: by 2002:a17:90b:582e:b0:313:1c7b:fc62 with SMTP id 98e67ed59e1d1-313af1afbd5mr3752888a91.22.1749644481334;
        Wed, 11 Jun 2025 05:21:21 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313b201d324sm1278484a91.22.2025.06.11.05.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 05:21:20 -0700 (PDT)
Message-ID: <8134154a25af0153411c263df923acd350253c25.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: support array presets in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 11 Jun 2025 05:21:18 -0700
In-Reply-To: <c1cb9bd3-c99d-4af3-bbcc-2ff3c2250ca1@gmail.com>
References: <20250610190840.1758122-1-mykyta.yatsenko5@gmail.com>
	 <20250610190840.1758122-3-mykyta.yatsenko5@gmail.com>
	 <4ff2fafb99131f599901580eac96dca34ca20cc0.camel@gmail.com>
	 <c1cb9bd3-c99d-4af3-bbcc-2ff3c2250ca1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

What do you think about a more recursive representation for presets?
E.g. as follows:

  struct rvalue {
    long long i; /* use find_enum_value() at parse time to avoid union */
  };
 =20
  struct lvalue {
    enum { VAR, FIELD, ARRAY } type;
    union {
      struct {
        char *name;
      } var;
      struct {
        struct lvalue *base;
        char *name;
      } field;
      struct {
        struct lvalue *base;
        struct rvalue index;
      } array;
    };
  };
 =20
  struct preset {
    struct lvalue *lv;
    struct rvalue rv;
  };

It can handle matrices ("a[2][3]") and offset/type computation would
be a simple recursive function.


