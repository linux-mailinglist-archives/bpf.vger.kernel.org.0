Return-Path: <bpf+bounces-19730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4FB8306EB
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 14:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A221F262DA
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 13:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D291EB4D;
	Wed, 17 Jan 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx+YHGis"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B221F927;
	Wed, 17 Jan 2024 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705497603; cv=none; b=IE22sogkRvBWt36/MHfmsptFuQSsmgy1vXQYZlGv+DqkBrynJeTndRX+0OJXF7X3i5CnXNKRuRco6VqejgRA6yM8UUVcPnki4rmI90pCEP9PTv4niD/DPD4gIkoJ+Xkk7Kh+2B+wpvcCU3efeboVQWFpr/giTHfG1jG8V4q1tiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705497603; c=relaxed/simple;
	bh=G8kZdad0aczvfXNNGPwgHap9kMeQUUqUiPlMQ0JKgDM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=UAKEfQqgOQisRtgrqL9tt4RVkzUqNL+vaVkYGQhTHS6AVfDHKCSxOwK3FLbC60ticzne1vWrbQW6s+Es7ijXNrASJgg2RKOotB9JCi2a++zyXbSPLE4eeuPuulpWrfFiddF+TpuTBMb7ekk4dRTqoMorBWglm2Xg1RoNPDW5Q1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tx+YHGis; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2cad931c50so568721166b.1;
        Wed, 17 Jan 2024 05:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705497600; x=1706102400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZukOAV7k2JJyGVhoGaETaf32fuvp4Uqed8ZDE2qWmU=;
        b=Tx+YHGisnWTAJw0551WDljSSLRHcc3fPUi3pyDA16n/gzL4Exz7bpgtPRJYDKgNTQr
         p6N3inGs9cTRYNNT2Sc3iO2QY0cIYxFvus4/EBzcTBsK2QQT7NS/ojRBYt2DpBrHAmf4
         RZ2IW28SyciRpmXKx0P2FbH/zvSfs5FyPaca2UcjUbx74W6WAPouI4hIoXjk9PrWxYE6
         guvES8u45QqN90c2x9bc27+m+b0Soxsik3LcQv519fzgNOusiqHGuTts/BFGK+Zebuc6
         FbJ4r0T0G1XvMadCd/h2ZH5klonLgVlCPwkqYrIFvKXCxVNM/Z9FetmWyYTpseQlwXH4
         qELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705497600; x=1706102400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZukOAV7k2JJyGVhoGaETaf32fuvp4Uqed8ZDE2qWmU=;
        b=LruF7CkIKBDFFDRgnagJrdcExOScyZ0FLN4ZKyqyHfJyeTqjQBy4zm1oczWABLgDSw
         Jtej4ZgWH0agcHjmxsO1GQ1r9M6KTfMx6xYaQE7fLPvdzx0slphZHPgVOL4mGV4OwfL+
         hKfqjIKJ58GSukCtXZoT1/Am0D7DRpMD2TEiQeKQ4b8vlO3eg2QyVxhUOWoh03q47x4u
         eC6uKJtgtl+jogFHprJ5ft/lKSIrqSN2kaj9qyo2eF4RwBnTbSh9wPW6dSywy4m+wNQu
         yD6EdGeRoGSmRcKRSrSpJ3E8ZZdZAZXzD9KH/5xtYGYfNdlBtSSWRWUYEVuhnEZwblsD
         AeDw==
X-Gm-Message-State: AOJu0YzVLUYwtIytTutWZfsmlbZDd8JDf8QOaeLPqhdv3hJ5pqzHsW9v
	mHWAWA3S1JofUjTgdHFcQr4=
X-Google-Smtp-Source: AGHT+IFS4MxnrEYh0SwgSP9gH6IV3ADVTHqCaIYUdamwi5D3Lo2xnqDS+qKngdiaLUzV98irX3zCGQ==
X-Received: by 2002:a17:906:ba84:b0:a2e:d58c:54f3 with SMTP id cu4-20020a170906ba8400b00a2ed58c54f3mr605556ejd.8.1705497599642;
        Wed, 17 Jan 2024 05:19:59 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id vs5-20020a170907a58500b00a2cbbebedc1sm6679828ejc.53.2024.01.17.05.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 05:19:59 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 17 Jan 2024 14:19:58 +0100
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH stable 6.1 2/2] bpf: Add
 --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags
 for v1.25
Message-ID: <ZafT_qyZyQoEsZYb@krava>
References: <20240117094424.487462-1-jolsa@kernel.org>
 <20240117094424.487462-3-jolsa@kernel.org>
 <2024011730-droplet-related-5a61@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024011730-droplet-related-5a61@gregkh>

On Wed, Jan 17, 2024 at 12:02:44PM +0100, Greg KH wrote:
> On Wed, Jan 17, 2024 at 10:44:24AM +0100, Jiri Olsa wrote:
> > From: Alan Maguire <alan.maguire@oracle.com>
> > 
> > commit 7b99f75942da332e3f4f865e55a10fec95a30d4f upstream.
> > 
> > v1.25 of pahole supports filtering out functions with multiple inconsistent
> > function prototypes or optimized-out parameters from the BTF representation.
> > These present problems because there is no additional info in BTF saying which
> > inconsistent prototype matches which function instance to help guide attachment,
> > and functions with optimized-out parameters can lead to incorrect assumptions
> > about register contents.
> > 
> > So for now, filter out such functions while adding BTF representations for
> > functions that have "."-suffixes (foo.isra.0) but not optimized-out parameters.
> > This patch assumes that below linked changes land in pahole for v1.25.
> > 
> > Issues with pahole filtering being too aggressive in removing functions
> > appear to be resolved now, but CI and further testing will confirm.
> > 
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > Link: https://lore.kernel.org/r/20230510130241.1696561-1-alan.maguire@oracle.com
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  scripts/pahole-flags.sh | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Again, a signed-off-by please.
> 
> Resend the whole series?

ah right.. sure, np

jirka

