Return-Path: <bpf+bounces-42993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65469AD967
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 03:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D411F2457E
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7C6026A;
	Thu, 24 Oct 2024 01:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFect2xl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5887F6;
	Thu, 24 Oct 2024 01:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729734509; cv=none; b=G7zJ8AN+DvqaJOWUttaTRW5J6PrVYlYOJErDnqJfquD2LBzQRZmk5Iw/4hQNOLcCwibcyuWOwJh8pzoH1ogdF1XlZWlcnZehpz2WgxtrbD30pwRsPkelWLTmfpPgNqmhLbQ1W4GDFHbFzmDktB0qmhlf/trtd4I7/PhqdZ9eeqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729734509; c=relaxed/simple;
	bh=qT48AR+0rxtKzW0XCG1ZYtAMXIHHdSDuAeLfquwAhd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FieA/IDdoeMZbqtk/8iZgMZmX5WIRcekCxyOBd4H0pHtSi785wKeJoevQis3NY2SHiB8rF+tWHW8itlCnm6jgv5fdq5BKUcF7AUOdvL1F5cTJYMLsU+NGHh6A21n4jZQrTwNLBW6TCUfvW04mQXtZblSZPmoGoy5rSNnIoWUC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFect2xl; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e59746062fso348506a91.2;
        Wed, 23 Oct 2024 18:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729734507; x=1730339307; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z42aC/7IDHLm42tQo15+22NWyiOEa13ujN3zgTa/fzs=;
        b=ZFect2xlZn+FQhU3BOEzS6t6se7NvjLOidublrW0AOm3F1Qn4H3T/rmxXNPkvtnD5+
         R3hWns0XpBVUlXYp+kYHvABcmNTwQyOYS6Ks1Mh5clSI9QS+PMQ4Y8Oi/apXRsCPoJ/d
         kBnNmHtxI8lhr6qUWuZqeNz6mzbtJD+/w3NFxQ/F+bm7Y9X68KXXlb91y3WXRaoFcdkt
         eL5ScjggvjqGmzGJ0/eGJpBmeUX4cbVTezZwvtWzLKzg3LipXw9ttOGCysEkRNMhhy24
         DkEp/d0Wt+awQxStKdnv2boUSgpplZKtRiicSar0OCbfOR2i/TFGuOYq2qO9i4xkG7i1
         nWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729734507; x=1730339307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z42aC/7IDHLm42tQo15+22NWyiOEa13ujN3zgTa/fzs=;
        b=C1Sw/OdIt/b4CxLfmANSRtwgoCaPnstmJLThwGUTxAeg64n1OgfKwBT10RHwD1GvvU
         E7yWixX8ZmrkYHIPjf5AvrrkoGNgDocj2yjILr5IM//SYehWwfUMntOn+lb7C+uJfY+S
         f9QBr4ruEi729hDVNSpbuyqJIpSlu01zR/JhFw+GgghL12cyagvPFJqBuCpW66SGKIiK
         gPkBRVRd5eZOOkgfimBpgZP4ys6Mfj6h0vFPM3DGBvnMqkz7bUVg4FitjubaKQtDQjUO
         KD52ZQLQKu5jfl82AIn/zknTbCbkW4pw6rPkJxlm3o5RxbzdQT8C3aaKsalUw16JCsxI
         wAyg==
X-Forwarded-Encrypted: i=1; AJvYcCW6kQr2GtXUAvX1T8ruZRvB5HJtd7+aEBxg0OdQlqRopV7vuIrXFYxW3F69clHVxS4De2+yTzMSdLpIUblx@vger.kernel.org, AJvYcCWPRnDgXpI6cGYBaULwUx5lXpqjkH6Z/Wkrn3pbyrJNKudAjCYKZ6+CpV38LFr1sZiYK8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL57g0ub5/MzwzyDYmPhWg80WscKghaYx7uv69+fLjlQifH0+Q
	zb2NhPcO6MfzebOd26Gpyzpy96fLDbiF6wu46K6+psngGZwxYTTxf1JguMdM
X-Google-Smtp-Source: AGHT+IEOQSZ7+VCh88o7KI0cYFWTo7ARIviVylmKITm4TYVQ92DkPSYqSsjc2HRrQD4YPqrrNsvSjw==
X-Received: by 2002:a05:6a20:e196:b0:1d9:3456:b6f4 with SMTP id adf61e73a8af0-1d978b13b89mr4680399637.11.1729734506886;
        Wed, 23 Oct 2024 18:48:26 -0700 (PDT)
Received: from localhost.localdomain ([210.205.14.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabdb7absm7434737a12.92.2024.10.23.18.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 18:48:26 -0700 (PDT)
Date: Thu, 24 Oct 2024 10:48:21 +0900
From: Byeonguk Jeong <jungbu2855@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Fix out-of-bounds write in trie_get_next_key()
Message-ID: <ZxmnZWjSRVHgtbGZ@localhost.localdomain>
References: <ZxcDzT/iv/f0Gyz0@localhost.localdomain>
 <26f04a6b-4248-6898-8612-793e02712017@huaweicloud.com>
 <Zxil/uyqq5qDHuRX@localhost.localdomain>
 <da89a4cb-1824-2228-31ef-ad33ad6099cd@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da89a4cb-1824-2228-31ef-ad33ad6099cd@huaweicloud.com>

Hi,

On Wed, Oct 23, 2024 at 05:59:53PM +0800, Hou Tao wrote:
> Alexei suggested adding a bpf self-test for the patch.  I think you
> could reference the code in lpm_trie_map_batch_ops.c [1] or similar and
> add a new file that uses bpf_map_get_next_key to demonstrate the
> out-of-bound problem. The test can be run by ./test_maps. There is some
> document for the procedure in [2].
> 
> [1]:  tools/testing/selftests/bpf/map_tests/lpm_trie_map_batch_ops.c
> [2]:
> https://github.com/torvalds/linux/blob/master/Documentation/bpf/bpf_devel_QA.rst

Okay, I will add a new test. Thanks for the detailed guideline.

> Which procedure will return -ENOENT ? I think the element with
> prefixlen=0 could still be found through the key with prefixlen = 0.

I mean, BPF_MAP_GET_NEXT_KEY with .prefixlen = 0 would give us -ENOENT,
as it follows postorder. BPF_MAP_LOOKUP_ELEM still find the element
with prefixlen 0 through the key with prefixlen 0 as you said.

