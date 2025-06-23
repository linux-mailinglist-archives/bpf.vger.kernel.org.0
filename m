Return-Path: <bpf+bounces-61317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA221AE51A8
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 23:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E485E1B63D9C
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 21:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02EC2222CA;
	Mon, 23 Jun 2025 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHbbmyMp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FD21EE7C6;
	Mon, 23 Jun 2025 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714569; cv=none; b=gPv5+okPuZOPQ4f0l7xGHo6ZL9vUoRHilrXLW1694yv4kWj/LBTttkXW6GceX/2SaRvX8AhvYsOXOQLgmC5sUvCJVS/lkfopwBAL71SRrVmSnvyn5p+FQpJyMLjFrKumIorMwMpjweaHm93mVoToN5D7uEKh0GMrOouCkeXSwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714569; c=relaxed/simple;
	bh=Aw4MZgbZviawTlhAbSDsi4MtaIZ1gTx176KNLzCFznc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwgTODEFgBn9eHtaWl/hdws49v9YF7SJwWAanLVWXUoD06GWE4f7ZhSdiBQEt23PJweJCKniyvSxv+6cIQyOTmYK7ix3j+ELVEmlqyE72WSz23w2vMDK0aSRwHt0V57PEz6XaVoZV4Xhkr6aiP9PXzu7NcMYwbTBj41rsnLkRJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHbbmyMp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2352400344aso48730435ad.2;
        Mon, 23 Jun 2025 14:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750714567; x=1751319367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O1KlgyZYwrm92QHQMmBy3svmxDS6vWE27wFXurZB5Pg=;
        b=aHbbmyMp8j50Vinrh68rZwueBAOoKN8IAKZPPjfB0/wrOufoAN15gee+jzrf8z3XS2
         W1PrIpiAnphUKK5K+HEoQOKtWojBk4UhjAlFOk2rP8A62j1vQFZIp3bCll5JsVz8XhaW
         ypteekShHuUEyXaUOYXWlgDlRw+E5tdUogz2dN/INxI8yeGcY7eD2T3DmSJ758wn7y9K
         45d+PVymO/W3BAsbNSOI9RlTS5jkAnxlm2PgcpLRbmJNGuaEb5Y7tlcpNydDGa2ytHVa
         bXmydh/mFQjytn8WXOt3ynLVfvWjqrUJVTI/ovGMyawHqoTTHMwX9C2j0HCzcX1ENfgy
         JgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750714567; x=1751319367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1KlgyZYwrm92QHQMmBy3svmxDS6vWE27wFXurZB5Pg=;
        b=RCOiD+NdmbLrbaw3D779B6vx0mT7igu0V3n0oVTmsjh33K1OBmfz4KchH8YugY9Q+Z
         Yh0C9iHc9/TNuJQ/aDYF1j7euM6cCuO/mhWFOvmeFpl0O8BEXhbfFgm4R1LNPfI0/LHC
         fbng8ZmeSo/d8oMfr7IwL8t3yDffwCMIkxW7p2AJdwU1LNgaUCdsDDWuvHhGWKZ1lIZX
         htn9IDEiV4JwuxZot0NZhpKIegtJGYeZ+KBYwuX6lz/VJnslSaSVbMXD0zAHDO+fCbV9
         R9ki0Y1eRB94m52spnJR4CTJHIy3yBRgOtcT/1rWp+6Tq+y2eNoI7jyTf0zgi+tj+RE6
         angw==
X-Forwarded-Encrypted: i=1; AJvYcCXkMqsmB0pV9uv+Akb4ROKN0m+YIgDaeLNRNTcMncdNVaQJJILMkycjrbrOp13KkrmUR50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9elKhTKZdzCKgF+U0kq7q/nkXUOozF0BwHt/E71Jwd9zXVSQX
	3+F8ogGbWO+2ySFL/u6fOmNsgkYz8nuiiplpSmhzPZ0A4vzEPUv8Wxk9mrVo
X-Gm-Gg: ASbGncvkhHIvLEIxRzPXA95tiqJtck6davwmgX9A8y50DTK/zyl0RbwrYmLqxEQR3MK
	FJz3Wi0Bx1h1cUJ5iNDW2n7sIu/XnCuv71NfQmvJ6Fz9lNj+0rfkJUItiVbtESZKR8NPxxRbxLo
	ahJZke72FO4kHgmQAANatf3uJhEl8ZzkdfDsln7ogxxMR7h66mi+j+0VagGERVRqP92Ya7YAywe
	hyD9jMgxH94wqNlyVJGdvMIK3lkIXduD4IMFqQm0u/RLwTKIXYzVIDZaUgFfVQNdCUAlKkllQsh
	YsYG/Gy+hLdKcnteoqEEuOzuwkJ9qFB4IWHJmeWnr2O0e5wTK+nDws01wKGbg+/PXOK+783mvP1
	AXD28MOOcX2HduEa8H9PffWCZwE47EANYHw==
X-Google-Smtp-Source: AGHT+IECNlW7E+momRCx49jAdehO6Fk6p2Rk1P5OPPKw0GAyUnHQy8GRD7A8JQ3aNmXK/G0PRT/Jug==
X-Received: by 2002:a17:903:4b27:b0:223:653e:eb09 with SMTP id d9443c01a7336-237d97c7f5dmr211626575ad.7.1750714566964;
        Mon, 23 Jun 2025 14:36:06 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237f5c7f4f3sm39010285ad.198.2025.06.23.14.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 14:36:06 -0700 (PDT)
Date: Mon, 23 Jun 2025 14:36:05 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [RESEND PATCH v2 bpf-next 02/12] bpf: tcp: Make sure iter->batch
 always contains a full bucket snapshot
Message-ID: <aFnIxcsROSNowexy@mini-arch>
References: <20250618162545.15633-1-jordan@jrife.io>
 <20250618162545.15633-3-jordan@jrife.io>
 <aFMJHoasszw3x2kX@mini-arch>
 <CABi4-ohShEVsXfNhMBHqsBFJ4NQUP9zq_Pq26WvFNohjoWFj9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABi4-ohShEVsXfNhMBHqsBFJ4NQUP9zq_Pq26WvFNohjoWFj9g@mail.gmail.com>

On 06/23, Jordan Rife wrote:
> > Untested code to illustrate the idea below. Any reason it won't work?
> 
> In theory, I like the idea of unrolling the code a bit here to make
> the flow more clear (and to make it clear what's happening to the
> locks!). IIRC there was some reason this was hard, but I will think
> about it a bit again.
> 
> I also want to make sure things stay relatively consistent between the
> UDP and TCP socket iterator code structure. The UDP socket iterators
> already do the `goto fill_batch` and `goto again` thing, which is
> where I borrowed this from. If we end up diverging here, I'd want to
> go back and update the UDP code as well.
> 
> Thanks for the suggestion. I'll take a closer look a bit later and see
> if I can work this in. In the meantime, hopefully Martin can chime in
> as well. We went back and forth on the code structure quite a bit in
> the patch series for UDP socket iterators, so he might have some
> opinions here.

Martin is OOO so you'll have to wait a bit for his feedback.
UDP iterator seems to be more low level to me (with explicit locking),
so maybe all this non-unrolled retry logic there is justified, but
I haven't looked too deep.

