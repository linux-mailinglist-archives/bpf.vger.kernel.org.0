Return-Path: <bpf+bounces-27137-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 233758A9A51
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 14:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36122843E7
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 12:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1705315D5AE;
	Thu, 18 Apr 2024 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IJrJkNON"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A1158849
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444403; cv=none; b=d+Idu/ZiL1Vifa9RDDzEc7mqR1z6YvRyKNtTqoi6j8YTEv5eWZdxu1ZLNkzEMrLb8PtqunOUOY1u1iOlcYHN9ts9GKHFeW07U9zlVPXb0kSr1MEc+JGMky5g4Tq+oPNyIy0RsLEVOE9SXhK/7sI0kGH3Lqh2OcitFtiKmi0itgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444403; c=relaxed/simple;
	bh=AS5SxMXGcrO91LnCOcUj7QnqlzGCqZXoeT1579YFhr4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ksx1rfb4QNl0b1D01zrNlIzM0v7t2nuyeAJ4W2BqDu9i3OyfziegtGxLoYXTx+5Bwvq0FxRBer9b5lByqC6wrc1651bZFlXNQsEu7XXhKJykoEr8ZGKtHOrI0aff53qQzgUs1a9u0z6OhE8euFAIxo0fNsKbCq/pjaBaPhh/nmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IJrJkNON; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so452927a12.0
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 05:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1713444402; x=1714049202; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AS5SxMXGcrO91LnCOcUj7QnqlzGCqZXoeT1579YFhr4=;
        b=IJrJkNONjYI+NCy4JPSDo4VkJ4V7jN6JlIvScM4Y6eCLm74UozJVNOKvFs+i4hlaVj
         6BwmTiaDa1bV/c/qeZZhTGryhTT0/b1glLwwMu11prDZK1kKIfBJJSiFTVkLUF23OVaQ
         3fIZG6NNnFeaMPU6iOHJ8jt2HtwhYpR6Ee/QxP/ng9VdxeDduaqs3ZnWOIMa5K5Frsx+
         UuF889Ype4fh3jvQ6L4r7TtNxleCZAzSWNln3wARmREHliDKcwHzgvza7q1DtjC84/eW
         nn2ykzwoO8lNH7DJQAjNKfxsKqKn0ejQBELZ99/kxpj6ilK4hkpNqzfBTNcfWsO2MA/V
         /FHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444402; x=1714049202;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AS5SxMXGcrO91LnCOcUj7QnqlzGCqZXoeT1579YFhr4=;
        b=OP73a1GlSU3DrmyzHRtSpWT/Hw9VSY8+7KO4sn3eCiFo+hAIpPXYhvwsEIxvT+gNsA
         WMdAMClBzODOGs8jzVfil5JUiEYVExImaefYqvZT8mBNh6BF4rg62sxadU1t6aA5nKZa
         1MGA5iJPitC9PU1aFo11YTJlSvGeVadNRAW8hWELh3rZRBFOWZVkg2XjvibZlRkpm7kE
         sxoLHn+4ca+TVTjaHTYfH3a+9tDywmveMRsoAD1nAuyMDGcDtpOQ/YqJipjAnJZ/raCE
         +2ch57DjoTYR2eWkgnJbScmUNw1cYNBjL3YnFwwbrb1B7j/wcNeKmArs5Ae8WNsF3aFQ
         jHQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT5M381z2edDL6MnygM7yEphTnH/tpRUvSOiQ3R9a8lDg+EJhebdi8ZIK1elWeAKX4zwNoRGM6xfLyMOtcTbCt/1UZ
X-Gm-Message-State: AOJu0YyaaQulD4pChTSOx4Slf5I+sX52Ytm6s7EgCnWcizJR+2CCRpXd
	xdKoilYDsNRlLlEnDgZDKsa8cgWSK3OKGbACPElr4nr1LV3a5Opt
X-Google-Smtp-Source: AGHT+IHGB2xteWs17x8CKXd6eMv3zNzPXyIlPHSItkrMfu31Xblx203SmlDGLi09a3r0trtmOUQArQ==
X-Received: by 2002:a17:90a:c688:b0:2a2:fc17:db81 with SMTP id n8-20020a17090ac68800b002a2fc17db81mr2326992pjt.40.1713444401673;
        Thu, 18 Apr 2024 05:46:41 -0700 (PDT)
Received: from ArmidaleLaptop ([12.129.159.194])
        by smtp.gmail.com with ESMTPSA id b24-20020a17090aa59800b002a67b6f4417sm3089544pjq.24.2024.04.18.05.46.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2024 05:46:41 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Christoph Hellwig'" <hch@infradead.org>,
	<dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: "'Watson Ladd'" <watsonbladd@gmail.com>,
	"'David Vernet'" <void@manifault.com>,
	<bpf@vger.kernel.org>,
	<bpf@ietf.org>
References: <0a0f01da8795$5496b250$fdc416f0$@gmail.com> <20240405215044.GC19691@maniforge> <CACsn0cmWzT4-+g0w0-ETC5ZMC1hdW0v-Rh1ZNCG2O23m9YCALQ@mail.gmail.com> <003001da8907$efd41140$cf7c33c0$@gmail.com> <ZiDFRI3sdClyG-dj@infradead.org>
In-Reply-To: <ZiDFRI3sdClyG-dj@infradead.org>
Subject: RE: [Bpf] Follow up on "call helper function by address" terminology
Date: Thu, 18 Apr 2024 05:46:38 -0700
Message-ID: <004d01da918e$74b407b0$5e1c1710$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQGym9lSVor9R6wjkVDgbvdbCMHIbgJp4F1KApIu0eEBfB5hlwKy7T0BsXSL+2A=

Christoph Hellwig <hch@infradead.org> wrote:
> Maybe "static ID", or "pre-assigned" id?

I'd be ok with either of those. If I don't hear
otherwise, I'll create a patch using "static ID".

Dave


