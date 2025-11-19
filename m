Return-Path: <bpf+bounces-75103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F66EC70B85
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 19:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7032D354C88
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 18:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D706431354F;
	Wed, 19 Nov 2025 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2y5Z6L+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C5223C516
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763578534; cv=none; b=gY1ZgbnZ9y58tDAslRDcRvQZ0ZaD42dbt6LhA14s1fM+EMixMoe5G6f8dYzsz3qHkfJ5vWaUiAyzoc9tRvDmpAuJtI8sP6FHDDAw+dSb0gOz16Ub6C3nkcR6Vs5dYPVxy2Gcbo5ggdgE05SmHMcsYZFF3V/gqGcu9UiMSi1YeGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763578534; c=relaxed/simple;
	bh=9v0djC3j4UdC0t5of+7eTF62EBu112vbh4SXSgoEENs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxB3EiRRqL4Zo/aD/fKQ63fLvnitXlKJ5NAMMl7lRxB9zUWh3i79iBYvV4QnKOyHdZeAAE5lBhzVeHWp+xd/0cdnAiaJYcHOOeedFlN89/afphit3rpxXBsaEPrgIyrRa1ihLEFJxgKa8hp6HTIxUixyF21/H81IyVYGrPEnquY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2y5Z6L+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b98983bae8eso21517a12.0
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 10:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763578525; x=1764183325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=edQ3lAhPLjZZSk1oSVWuvnsvYz+DEp4d1vNMqDu5ED0=;
        b=f2y5Z6L+kLyXRojnbWggFSxJmrU6qFh1ngJsga7teH3sIzPOFpaUXpg6my3r1GrT+h
         QYedur5evNIqg2Q9FC+BucBax8qGGC+tHKqaePdntEt5rJICcdXWHGhIrdrw0Vxinfib
         UsZHYviIGIR/jalPnc6lFmmDRfn4Yw7RtANSccMlOUE/0p1zcjft94WLO3gasEFpcdKz
         spVFOXGglIrBITjPBrnX9qvOy2nNRcj3CYc8O8TZIt0uRAKuyzkKif2w0pCadaLeotbp
         DkWZ2V6FjT75381Hw4nTQ4KBgbE/C74XdsZLiziZ3oW5p6GxO6Hi55X4tvcwpkq+vTd9
         h/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763578525; x=1764183325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edQ3lAhPLjZZSk1oSVWuvnsvYz+DEp4d1vNMqDu5ED0=;
        b=TcPGfLEozRfaDdts4qYn8vj8c/1x5GavduibRAgIpvQSCqZ62srF2ZVV9U5n/dD3m4
         /JPBap5GeTOsBibPaFTQOY/lCJ5HhNAggNl5fwXIVT7W0aMxST05fwmZpBi4u5m7GR8D
         DVML59+SEZurrGmdTIcNXgSc6q3L5qbpHU/f92iJ6jmd9bzLm1kmonu6LlCVkzFJpKAY
         PfxfebdQ1OMVC8m5pDjxpC8WRavJ2TegyQAQl6qmsHppLTsO5HVaxTa3mZOH1rhX5bRf
         8PyISeA8KUyA4zqWrqr6v6pL/zFYUdWD8hVZuW2OUCFoDzpqfgfzseImWOYN6DFdvn5q
         mU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZ+PVI5SK2YwdY7pe0rSjeo43ERWTLE80qUrDlz7rAf3KBhVncbfYoDM7JJeUi7N5GzcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkIIzDepilqUy63DsAId+F9uKnv7QMpNx0pVZntg4xVh3zfT2
	/TUrDnu725da1VW1yooQTE99hGtJxncCyr9to2gBgTdeOOhsSYYu4vca
X-Gm-Gg: ASbGnctOo/M26wRHIOfCvYFTnG3QuDsLBdsVLEHfX+reUk9iA4asLR66t+qiC2he1Fh
	iMsL354id+w/9fJj3rib+Cr0rHSkwoRGV5ifuQQDTTeoYedUBlm6yEdyP6Ass3EJ6yVmDq6WPHU
	Kj4hPpcxe7rWk0aP/Ism9G603F8cKCeat42Mue/Z0jFDYqn+tQB52q8a6QyJpgJO48+iNG4JwrK
	05bDIF3/NG7vVPLrW9Fk2iPsgDrrl/gt2rw0IGNZuwv6ZJXuLH6p0D7pJxztYM5Vv2PidwhIKvY
	S4QGLyx/c42QVRC4O+hfDHV7PnjFf+t0DVUeSCvyvncfdt4V87EbSlRm2JxBWRVkXuZ7FOSOnmV
	v55boJx74O9yduNhpt3W32vD+AZAChfy8naRhM8TK2KP0jtg6DIcoG8VWzF3NOpkZSgLwt2mg/7
	gKKWFfGr12KD+OOpMUXKfQL0ISZ+mUyuHiqfcLYxFYx8o=
X-Google-Smtp-Source: AGHT+IGBQeqSMvGoivhKypewRSEuuSGzQM6EQybj3ad+ID5hnktZP2Z/3EF+i6z/IdXkB6hPA0OLmA==
X-Received: by 2002:a05:7022:1e11:b0:119:e56b:c754 with SMTP id a92af1059eb24-11c9387cf19mr128055c88.25.1763578524596;
        Wed, 19 Nov 2025 10:55:24 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e3e945sm323775c88.6.2025.11.19.10.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 10:55:23 -0800 (PST)
Date: Wed, 19 Nov 2025 10:55:21 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>,
	linux-xfs@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [PATCH v3 0/4] make vmalloc gfp flags usage more apparent
Message-ID: <aR4SmclGax8584IJ@fedora>
References: <TY3PR01MB11346E8536B69E11A9A9DAB0886D6A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <aRyn7Ibaqa5rlHHx@fedora>
 <aRzPqYfXc6mtR1U9@casper.infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRzPqYfXc6mtR1U9@casper.infradead.org>

On Tue, Nov 18, 2025 at 07:57:29PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 18, 2025 at 09:07:56AM -0800, Vishal Moola (Oracle) wrote:
> > On Tue, Nov 18, 2025 at 04:14:01PM +0000, Biju Das wrote:
> > > Hi All,
> > > 
> > > I get below warning with today's next. Can you please suggest how to fix this warning?
> > 
> > Thanks Biju. This has been fixed and will be in whenever Andrews tree
> > gets merged again.
> 
> I see:
> 
> Unexpected gfp: 0x1000000 (__GFP_NOLOCKDEP). Fixing up to gfp: 0x2dc0 (GFP_KERNEL|__GFP_ZERO|__GFP_NOWARN). Fix your code!
> 
> I suspect __GFP_NOLOCKDEP should also be permitted by vmalloc.

As far as I can tell, theres only 1 caller of this.
Christoph started using vmalloc for this xfs call in commit
e2874632a621 ("xfs: use vmalloc instead of vm_map_area for buffer backing memory").

Looks like xfs uses the flag to prevent false positives. Do
we want to continue this? If so, I'll send a patch adding the flag to
the whitelist.

