Return-Path: <bpf+bounces-38592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A869668AA
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 20:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A59F281B82
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 18:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EDC1BC9FF;
	Fri, 30 Aug 2024 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bP/ME3Mr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BD1BB688;
	Fri, 30 Aug 2024 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725041064; cv=none; b=d0BhZIJaDj8hQlzKkZqPQWXTRh2ozbsColkWTKETgZD6KKrte/kRzHjFG2LGdi0Dg55n3NgBm2sbXvb/RQpWo4WFqWsRdvHtKZwrKD3jPSaW3nUGUyMv+4/3x1SZv2FlYrDrgSVWvHdPkXH138QztuSc7td8irmZX14ARZmW6tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725041064; c=relaxed/simple;
	bh=DO2MF2ENpgKmnGWZYUV3eE1rjn1qT2BpKZMyXwMbm08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GzFQqnmt/8c3L2BzRkF7CQzgGUDDooruptflY2lorH064kaNIn3Q3Ncug3ZmlSzec7PglqnbN/sBLboYOeVmHH42SeHopNbPGqI0eFVVJUVYAvOIjZqKTKZJq3N0AM0uj44LU/L2TOlmhEYcYLfDw9JWcjyMGLtJM4/XWc9jvV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bP/ME3Mr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2020b730049so19385665ad.3;
        Fri, 30 Aug 2024 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725041063; x=1725645863; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DO2MF2ENpgKmnGWZYUV3eE1rjn1qT2BpKZMyXwMbm08=;
        b=bP/ME3MrosZDbda/uI2f+KTepPHyGr9/3lOVq0jo+HVxh/UzGgFfKojuzacbJdMVaz
         8mqrJAXNqoV8CYzTn4q5B2PFMR3yStWh8IRcnwCJ6230XK3kWSCY8jnSYE8z8LNuNSMw
         yyhE5sALXI5FppufkoHF2YSgi0fRa6bkD5iMNv9fvpdxia05X6J+VXFEgxPIusLTmQHT
         WL1o511pN/zvqewv81uLXq3PeRoZSFPgpef+AN1UDPTFP8KXkvCmypwE+vGTaHX96IUp
         M2UoRgHzws/wFTWSdJtKQVl4Ox4hJy6I09QL7hhmSuHKkYVq2yBQaZjVwZkJ5peJvSdB
         67Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725041063; x=1725645863;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DO2MF2ENpgKmnGWZYUV3eE1rjn1qT2BpKZMyXwMbm08=;
        b=XpoDCPwnyPw71QJ/J0sIWjhgN+0DAB6dP67oSDu2a/7OfjKVZo/awQvvbHkK17Z0u+
         zOZS/qWmiaBppDHKz18GhxFSSIXk1eXAF0pQnN/ootzG6sFHyVNIttq4XhgwXzrKpXNH
         wmGNADvR/X37XGToFSukzDC3a844V4vo/6Ski6Lnzt0XPm3bozKMFFFuEu95PWRistW5
         yQIfQfVaC6CRK9Qm/pCiEzDkgw1SrPdyu68EnqFjN9SOgJX3lGTXlCh42FXEppgOCz/3
         xuAHzNRHTDsa2kHRJ7OveoywxzBQ7dlxmNiFhU20AKrB+2XPRe76dCpmFEBwZrcRuBr8
         2ksQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUFDxoVcDB3VCGPKl2Q0ABHggj+i4/k9NqH8Jm7BoYl3hfpNXT/91NXeSXpX8yAtss5F7KvPY4bKDbMiwW@vger.kernel.org, AJvYcCUklru9/Yn9tzWs92VUOwRDCj/MNINr7Iw6+ogc0GsfHHQ22op1oRXJ0X3C9+qE7CEkSqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQH4+RgD6zSVCiWoPnOAEvpSOAlWyiIBBxGiwvEKN7w4RGjEpb
	BsQRFhKydDNaWtzbzyDMvMPGfnMdmta5+xfaSYKDap+/+SgXxZHk
X-Google-Smtp-Source: AGHT+IHVRX9p9tZeYXAVyQuJWwPhsCsar6C+wzA4Dy6PN4eyzzmnWsB+8m+xbPLte8KEG7U/NHa2XA==
X-Received: by 2002:a17:902:cf12:b0:202:4060:22cf with SMTP id d9443c01a7336-2050c215a14mr74940685ad.10.1725041062675;
        Fri, 30 Aug 2024 11:04:22 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152d6966sm29669515ad.115.2024.08.30.11.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 11:04:22 -0700 (PDT)
Message-ID: <cf8e7feb83f5f199db4f1b7489e48e89f8985c16.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: add check for invalid name in
 btf_name_valid_section()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, yonghong.song@linux.dev
Date: Fri, 30 Aug 2024 11:04:17 -0700
In-Reply-To: <CAO9qdTH5SgSy_Mn6VMUNnkKa-Dr9x2bpgG6q=_3K8jJJT1p6sQ@mail.gmail.com>
References: <3a48e38f29cc8c73e36a6d3339b9303571d522a8.camel@gmail.com>
	 <07EBE3E5-61A7-4F64-92BA-24A1DCA9583B@gmail.com>
	 <bd8a6dc3e52369a30c73578ea1144a48f736f393.camel@gmail.com>
	 <CAO9qdTH5SgSy_Mn6VMUNnkKa-Dr9x2bpgG6q=_3K8jJJT1p6sQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-30 at 20:41 +0900, Jeongjun Park wrote:

[...]

> So does that mean it's appropriate to add if(!isprint(*src)) instead
> of if(!*src)?

I'd prefer to add "if (!*src) return false" and remove "src++" in
order to not repeat isprint().

> As far as I know, the first character of name doesn't need isprint() chec=
k,
> so if that's true, it would be appropriate to use isprint. Once this
> is confirmed,

The intent of the buggy commit [1] was to check that all characters in
a section name are printable. But I can't even check name for
printable characters these days :(

[1] bd70a8fb7ca4 ("bpf: Allow all printable characters in BTF DATASEC names=
")

[...]


