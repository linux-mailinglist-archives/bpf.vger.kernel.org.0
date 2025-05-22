Return-Path: <bpf+bounces-58745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 001A2AC1322
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 20:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59999189207D
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 18:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AD618A6AD;
	Thu, 22 May 2025 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="FSPXd0Dw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0243F27715
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747937778; cv=none; b=smiOdQX5Czvj6puvPa6XrVisZx6iV6AQQ3tppfQVZrHui4V0/8HM5NCH3uM57HY53026FRXj6wQKBGcxIvRk6FuQ8rFUGsUSNPiYCT/ihwhDDmzcjDicPn97aD2KXVa47n3TOAVCFo6WoeitxSJr6krTtlr9JX5kkboeP6U9TVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747937778; c=relaxed/simple;
	bh=rFpFf6DfvP93VzhtwTOMGQykiDg3bB2ekKXn/KTzaL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiGrV2JqhlAAZ8PuHppf4k9kANqCNHFNuUXeVRcGu+rvCqirAXklvlqjzTX5SXtAERTEiIFjakDtXmzXSFY27uRaODxVaYwoJ2Mt4iOvEaoT8hqwh78Dt2o1dp25tyQx1in4NYIYd9pN4jMMUp9RhPjoxE8z0Qaiue48rInyCts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=FSPXd0Dw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-231c88cc984so8410915ad.1
        for <bpf@vger.kernel.org>; Thu, 22 May 2025 11:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1747937776; x=1748542576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WCblXOvYhrrV2buAc9npm77ACuvxjz/TDnGOaAc3HbQ=;
        b=FSPXd0DwJaV5wUY9txd9zUMTnkGihLEYgihHdX3hDce90O0tTUsyjd3bOV9JQlppL1
         BeeplpiUy25BS5kD1PBZppan3SJQm22+tX2eBMwGMKmUF8gB4KcS26G4c46y2TE3V5wv
         S1nrSIRrFrNN6/6HPmUW7E7Me0vqgxo6VQia/lBjp8/TIlLtDasAdvRi86YFn+vcXarg
         UkiSRiocbB4DqgdW1TIWhGuRrZ2Du9y4+j2/HpxLpvZTo3yMSJIBS6nR+gCwxeeYxcro
         D4Rbp26LFNqG2p4e8fGXXNByKgSK3KmC5tB0yn1oI/QP4ZHUSjEatSfRq0vFDNmBJ+RN
         MCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747937776; x=1748542576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCblXOvYhrrV2buAc9npm77ACuvxjz/TDnGOaAc3HbQ=;
        b=E0CDVfrt4eYT9pg7nvksA4pXUfh7d3thrLYZrRCxWRzcRZYtKcmfOtukFDWeySnyVg
         ZRSrZQGRZ8f53IkcuFvajT4neG1JUFm6+ke3oFGqhQLoiYF1wx1RbAq3NGVZP9tKoW76
         GiF75BSran3xcVKzemc/fKg5vKkobT91mSvbMpFgwOTUQGHxrTVSaJ6ZDHp5odkVU5b0
         e7qUR4onV55itwNmv+Nzuww0+7Y18ej0G2/l3conrXSz3e9anQC7hkm8GQYBRk6Z8shR
         i7BRyaTtubK7KHG6AHhKNp/ZRUgj53T+JHnFNg7ViKYs3JS9z9mNqiVKHuDskgPL+9Lm
         VGVA==
X-Forwarded-Encrypted: i=1; AJvYcCUn9h3/mjLDb2V9svQQVVw2SjaruTFV4F0Waq9MGDJ2XbCRtwyjiqptgWMYfG/snUoT5RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxME2tbYRedj78mu5Ft2+/JL+dj2Scb5YUOgeilnnjAvex7MmnL
	3aXOdXbO65U5b2bJrel+3+YO4ypqScqPO7zCuNhBb2qvOhYMXUhxRDWYOfFU3OSO0lA=
X-Gm-Gg: ASbGnctzw0QH/56MYbHcadM0Pfm3ZgrdvWMaozcwrnRoKLtBNL+rDZGYG1CRjPhf9S9
	BYqPtZZ02zno1upTRIKbBBxnYxXWByUXV8KTc1c6YMBPqQE36v4Ex3GLCWwnEDZabewrQG8qas+
	BILL1qyi4Ng1Vd224VEVY3+adBvJAQVMo3nzHQ7fKfAYfE4WaclpIuf5TKLrIYqBFgdLZ+Q3woA
	OFBe1sHHIfK6v3ni6fsxBSc7wOn3PhS9v5tWaYR+fkidjAuULWBPBvhl+eXDnFHHUZeBN4Xx44v
	1k/OimLJuVo8yExZr76J6YCTTj5OOKf+9TA4kHV92L/gteXw
X-Google-Smtp-Source: AGHT+IHMx48kdtWasuDuVfHWM/9O8pEkqvAHWuQ1Qz586qLWsOpVwK4Ooq/q1qynVkOTXeLY23i1RQ==
X-Received: by 2002:a17:903:3316:b0:231:e331:b7d0 with SMTP id d9443c01a7336-231e331bb9cmr103273545ad.10.1747937776132;
        Thu, 22 May 2025 11:16:16 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:185d:94c5:1075:e620])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eba49esm111671565ad.163.2025.05.22.11.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 11:16:15 -0700 (PDT)
Date: Thu, 22 May 2025 11:16:13 -0700
From: Jordan Rife <jordan@jrife.io>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexei.starovoitov@gmail.com, bpf@vger.kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, netdev@vger.kernel.org, 
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH v1 bpf-next 03/10] bpf: tcp: Get rid of st_bucket_done
Message-ID: <wxqtnfk2nkwfd3lybyyitawusswohp7hkaoszfxpfdsiuluilr@g3zlc3ojxjkv>
References: <20250521225800.89218-1-kuniyu@amazon.com>
 <20250521231755.91774-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521231755.91774-1-kuniyu@amazon.com>

> > >  static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
> > >  {
> > > -	while (iter->cur_sk < iter->end_sk)
> > > -		sock_gen_put(iter->batch[iter->cur_sk++]);
> > > +	unsigned int cur_sk = iter->cur_sk;
> > > +
> > > +	while (cur_sk < iter->end_sk)
> > > +		sock_gen_put(iter->batch[cur_sk++]);
> > 
> > Why is this chunk included in this patch ?
> 
> This should be in patch 5 to keep cur_sk for find_cookie

Without this, iter->cur_sk is mutated when iteration stops, and we lose
our place. When iteration resumes and we call bpf_iter_tcp_batch the
iter->cur_sk == iter->end_sk condition will always be true, so we will
skip to the next bucket without seeking to the offset.

Before, we relied on st_bucket_done to tell us if we had remaining items
in the current bucket to process but now need to preserve iter->cur_sk
through iterations to make the behavior equivalent to what we had before.

Jordan

