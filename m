Return-Path: <bpf+bounces-77674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03987CEE774
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 13:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77C34302F829
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 12:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466AB30F52B;
	Fri,  2 Jan 2026 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJwsYjUo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290BE30DEC6
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767355867; cv=none; b=bzegfIqVrDUabwwAcNLobPyWycWSBATaPeA3WIET/3DcXTREIZ/Eg6jvAUtf+zxTnGaQTFx3l7KDs/ZiDjdFgbNdZQycj2R8Nxq4WOmLaKgYLj6+774d9A3sGnclFLH+rJcSz24PL/SkI+ceO2ktKfuNGnhNDn4DPa7gEpv6qrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767355867; c=relaxed/simple;
	bh=YkwKeora1mLV9PdHzkifnJhsG7z5aIrHh9/DgI4be78=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Axd0mEKldKRcjqmU6iYK/Ocs4kllS5d3RHN1pbUXkvlDwsipKfCEWH3Nvh//u+REuNQ0pHho4l60rhY0INLUZ8C/SXn2LG8fLBgGlVcXhKnhjWjDnEe2xPQxVyO2mUTIz6hlqTOg5LjcTQR6GsG1IZXBZZlPBe49RuMSGPB5iv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJwsYjUo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47796a837c7so77408685e9.0
        for <bpf@vger.kernel.org>; Fri, 02 Jan 2026 04:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767355864; x=1767960664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KsymdoSnuKbN2NyfZ9ktVw8fTlQLoP9UwvhxFPZnyng=;
        b=gJwsYjUot6uGYLkdPEp1fL2VaUjINgI6EoXe6r49RY4/CAScgwZ2JGH5PqLTkczMHN
         Y3DWHz3V5hmT6mW3SrRgMAFJxA5ypPeMaZFJc0Tycf+/9iCTzgAIZ9zsnxgpQNcVzDfm
         b0ylHo/sGtwf2pujiyE70XiE6OhiscUNcLof02vSMdZMxaMWZQKaGOzsWNh9MXRuYaYw
         B+4KYiz3q15fS4OPLiE5IzkvZ/PBt0cVaAvHYfhdNEMt2Kj2nsMcPjENbvKLQmq9VUiZ
         uPnU+JewKgJifpoMQhJ9/rv/YfvZoZENxscp/1z+J7liutaASjWIurP4qbunG/KDnsHG
         PXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767355864; x=1767960664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsymdoSnuKbN2NyfZ9ktVw8fTlQLoP9UwvhxFPZnyng=;
        b=rcKY+aGYFx8NYnmntrjvk3NmHosK6GHk78hMV2jnF6Fh2lbjBP5mfOdMAZysOGADS+
         7b8oh1bIRzqY5hzx6+gNcsG3hqCM82v+fK9WWhcjPLpWHLZ8Cu99CYHfW7gQ9Oy/Lemi
         v5qwn7Q7EJ3coPP9+zc1Vv+FxRZTvqoMeQIEB2S8q1yMlcxkk33BiUBO5Kcp7ICLWkfN
         1dlJ/BwjtAr134e3iGdK9MOE4li1AMWaWxfc5bbewNUNgaTNnKYT9Huvh/MWjIR3UxDr
         9lae14n7zz42qybYMnUbdz+gmNynl//Oqmzk5h7sHFP+Eo04Lrt1xIPXLn6MQu33ZGoL
         IFjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc39m8ZRyX49iuGWgNrm8KHPcZN6uuShzWk4yEcbkOjPxysTXOyjXsPOAuq31nQYMgrio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBLdOkWGp90i9C/WIpUV0Bq62Uz3sd0M7Y2gQaP1rs3KVnbXGq
	bqv+KJ2IdMEk+Ex+aiHnQ2jMfNxHAWUh13kyqfrRi40+Jr1HqTxtXyBH
X-Gm-Gg: AY/fxX42CWjEMynpnMCCr+Q8V3QnnM28SrjUxDtcNKpuprTqZUkTwryiRTzRO0b0GpC
	FABR/CVjwvT8eRqNnDxRgxnw3YfaMP+P6ln954Q6FsSSVL5idxqLS6UPv+2Tfppmdu2E4J/qaA/
	wl7oHze35B6oHtvHUK1pHYv8gbF3qfpK52zimVcxdC0zbx4Q6Fvm5ftdLMzDz/2lbthpqjF403X
	E6sY0X5jUaM60f2FyPXH9gJumGl6qM/slyHBasd1d8cmH7jbpGLvZ1T/RwTPL6oN8hqCBFQY9o6
	iRwVExIc1NJliPbOMG3oUQM7bm4kbsgPVPezKpQlLrt69taydPg+kufO854ZNQPz5b4tTbE+g6E
	soDTTNFovh1anCTGh70nt5V6BrOGoUi3eV4JiMxIQ+ximx6nzllOPe3kggTRy
X-Google-Smtp-Source: AGHT+IGeHD9QGEO0EfQ4SPnoATfBRsOVSiPNLkPDj1EO6UPvf2BjuDLtdPNOtD42UKdvOUOZls5LEg==
X-Received: by 2002:a05:600c:818f:b0:477:a0dd:b2af with SMTP id 5b1f17b1804b1-47d195920damr519524465e9.33.1767355864261;
        Fri, 02 Jan 2026 04:11:04 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa2bdfsm85321033f8f.32.2026.01.02.04.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 04:11:03 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 2 Jan 2026 13:11:02 +0100
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	davem@davemloft.net, dsahern@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, jiang.biao@linux.dev, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 01/10] bpf: add fsession support
Message-ID: <aVe11o2SFzjEnGpw@krava>
References: <20251224130735.201422-1-dongml2@chinatelecom.cn>
 <20251224130735.201422-2-dongml2@chinatelecom.cn>
 <aVZ8LQXPhRqUz5dO@krava>
 <2251274.irdbgypaU6@7940hx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2251274.irdbgypaU6@7940hx>

On Fri, Jan 02, 2026 at 05:21:42PM +0800, Menglong Dong wrote:

SNIP

> > ---
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 4e7d72dfbcd4..7479664844ea 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1309,6 +1309,7 @@ enum bpf_tramp_prog_type {
> >  	BPF_TRAMP_MODIFY_RETURN,
> >  	BPF_TRAMP_MAX,
> >  	BPF_TRAMP_REPLACE, /* more than MAX */
> > +	BPF_TRAMP_FSESSION,
> >  };
> >  
> >  struct bpf_tramp_image {
> > @@ -1861,6 +1862,7 @@ struct bpf_link_ops {
> >  struct bpf_tramp_link {
> >  	struct bpf_link link;
> >  	struct hlist_node tramp_hlist;
> > +	struct hlist_node extra_hlist;
> >  	u64 cookie;
> >  };
> 
> In this way, it indeed can make the update of the hlist more clear. However,
> I think that you missed the reading of the hlist as I mentioned above.
> You can't add both the "tramp_hlist" and "extra_hlist" to the same hlist. If
> so, how do we iterate the hlist? Do I miss something?

ugh, it's on the same list.. nevermind then ;-)

jirka

