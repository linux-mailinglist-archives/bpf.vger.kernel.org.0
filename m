Return-Path: <bpf+bounces-47413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508A39F923D
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 13:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C85A1895B6B
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 12:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699A020DD7A;
	Fri, 20 Dec 2024 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWMuLYfH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A457720D4E4;
	Fri, 20 Dec 2024 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697869; cv=none; b=JTrwUz0oj03MFKTEAh9vWcdPfPlVK9NQEG1cm4Uo7HLaytQvV5pe1PWDYlDKsPwDckxrexEewdv7kretZFbIIemZbPOT1lilNN5LQABLI1YplV9k5VONK+ipCB32S8LdK+howgBv395mrAnGnMOFO/dEjjypIZwGUmRwuQSuDZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697869; c=relaxed/simple;
	bh=+eF1HArLPehq0X3xogX3R/QwmI0tpYmU783rhb9q7zw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjNukpuTEpsUgVYh9zh0hkhYVyshImW+I/5vYorxML7uPW+f+u7PtuZ20eUe6SRVx46vRaivfNWbQH49mkqe3N3F2ZDlwqpNpeCsB/eIKdUGK/Z3gZVWAcx85UhZ76cdrINu3npd7ezTSRDxGkS85VFd52o9r1OhcZ6A833f+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWMuLYfH; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so338290366b.2;
        Fri, 20 Dec 2024 04:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734697864; x=1735302664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7lOBblMD1Z+3nNWjzfDIGzNN4URNdmpackdxaxd5mI=;
        b=hWMuLYfHb2PobHOQtMbEJ35mGfuogPzkuTnjCEDXPRTAzwGyvDaGrrMz60o/m2Rf8v
         zObwymP441dwBuWK5HokaX0B4g+I0UmRo1dS2aanxTA2aEpWRYeQ8Ye0rM4w0X/rJUmw
         ZcPXSAZOUkIzyjx6cc+hDHXdyK842Qq3/dLKVJLUFK9qPnWShhMOvEKoOZoTj4FXBJh0
         8NMOpqame4ngVvjeuQ+TX9MPE5s2tDKPpbBStr1TtKIRV4J/8ZwkJV6ugitSDW+lQU5+
         pzJ6k0ttMi8OkbaCpcCy03RcicCjQ6X+zjQkkSLApVH2rsRFA2LnOtxs+M9wCpUHcQmr
         VzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697864; x=1735302664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7lOBblMD1Z+3nNWjzfDIGzNN4URNdmpackdxaxd5mI=;
        b=XstNo6XS1JB2QqY6A5Wp8rAUIeeAwfEN05ByZilv0+DawqyQh1Aopaaz8oxAZqI8Df
         xClYg/GHJJixU90u5YuEk0FWE9iHCSsbmF8FPCy4U6neVp63Y55pKQcllqFPGBkHWu6B
         vlwvQsXSlnMCUKYqT8ZZ0BKFve9yf89nzFRI6hvvpyyYXRDBSZpRPGxeC+Snp17hrObw
         GnN2e4dPi9qdYpQjkscf5+wwhdYUXg4cXFcfSZSOBIiUp6lNoOIT52ybpVQ+k7OtRAs5
         SLjTVpil0qA2Aw1aQq3o/lvYJifHFxnG2QnljDba4Uwy+RlfOITUFiKHVKe2LWesmauH
         JO2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUNcQsOntE5ilypVbLsx168/8RmbI8/QaJoVE2deB9n7wPCxsZ7SFV1qgfVE2i3NJYObU=@vger.kernel.org, AJvYcCXhyTkAa6MgzfWpJlxXgyw31mOczfLs7vZIkanGvY3GmUrc5N8FmJ9PxuZmAy8yWDYMMvVCNczDew==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrwDlKASyliKph0DtqpO9MeumuiA82Zny0sZhQDxuLLI3ooRUA
	s491z6o/xY9qsCGgZnrn9W8xiM7pjZGoyZvztL6c8BqfP59PwO3i
X-Gm-Gg: ASbGnctHrozOpwRTxSRI+ixlDDQQ2ip1VKkXwyveNhrfBRDIb7Sk9nf8Q+97ZTulUEL
	CHsYASlD6UMxWi+DvvLqNn4whx6+h9a91dp/qPz7srQGDZ/aaoT/SIJs6co5WwVYkQCj5oDkHjM
	+x4I3PYtHCKMizyvetmKrTMn0B2qsjAKxVO57oFTnGtP+xKGDK17ahOWQDjm1OLceH29n0rLSil
	K1vmvBicxr522/seDdsIdA1iogq/bax3V2Mld8I8jWRZm++07e1XlxJe0LAxbTrheMkJAhkf+Ze
	Y5Z12homcBkbcLCtaDQpJhmT+ABskw==
X-Google-Smtp-Source: AGHT+IHnSKuKHvji39kaVGbO9ZOWQVHQebT3WYfJBroORoXmPCLc2Ogd3bzYDPr3T52XxBiEQmzsKg==
X-Received: by 2002:a17:907:7da5:b0:aa6:8781:9909 with SMTP id a640c23a62f3a-aac2d32837amr212270666b.29.1734697863656;
        Fri, 20 Dec 2024 04:31:03 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e89490dsm172877266b.45.2024.12.20.04.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 04:31:03 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 20 Dec 2024 13:31:01 +0100
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org,
	acme@kernel.org, alan.maguire@oracle.com, andrii@kernel.org,
	mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v2 00/10] pahole: shared ELF and faster
 reproducible BTF encoding
Message-ID: <Z2VjhVlagkpjDzvq@krava>
References: <20241213223641.564002-1-ihor.solodrai@pm.me>
 <1b1b094ce1e0592c6185c292b2a7692c35dc7e56.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b1b094ce1e0592c6185c292b2a7692c35dc7e56.camel@gmail.com>

On Mon, Dec 16, 2024 at 11:00:08PM -0800, Eduard Zingerman wrote:
> On Fri, 2024-12-13 at 22:36 +0000, Ihor Solodrai wrote:
> 
> for allyesconfig, with your patch-set I get the following stats:
> 
> jobs 1, mem 7080048 Kb, time 97.24 sec
> jobs 3, mem 7091360 Kb, time 60.10 sec
> jobs 6, mem 7153848 Kb, time 49.73 sec
> jobs 12, mem 7264036 Kb, time 54.67 sec
> 
> w/o your patch-set, using current pahole 'next', I get out memory both
> with and without reproducible_build flag.
> 
> The vmlinux size is 7.6G.
> 
> 

I did quick test with vmlinux size 11.8G and it looks great

current pahole (v1.28 tag):

	 Performance counter stats for '/home/jolsa/kernel/pahole/build/pahole -J -j17 --btf_features=encode_force,
	 var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs --lang_exclude=rust vmlinux':

	     178.081877484 seconds time elapsed

	     479.529725000 seconds user
	      26.583607000 seconds sys


new pahole:

	 Performance counter stats for '/home/jolsa/kernel/pahole/build/pahole -J -j17 --btf_features=encode_force,
	 var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func,decl_tag_kfuncs --lang_exclude=rust vmlinux':

	     111.976182062 seconds time elapsed

	     242.342891000 seconds user
	      24.254289000 seconds sys

thanks,
jirka

