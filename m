Return-Path: <bpf+bounces-69767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A76BA104E
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 20:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE6F17B3C17
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DFB31690A;
	Thu, 25 Sep 2025 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0FJtEel"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2E315D33
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824939; cv=none; b=VDBMFVv851U7GjWa6mf+26s8vUHFm1IwA6v8RK7ZbWbO8sFUZ8JiA5avkTGISgIu/XeeFDeaWJUZkBS2KJmmBSS+CMEnZJpn1m+7oGvSdRgwV9T2bIR5NW1/wCcfPAsBYFGrE10GzUxB6Q7SQdclIkKx1w0CVGZJoGRlEHLBvxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824939; c=relaxed/simple;
	bh=1nr6UiL0tyQ+0aJSlnfdUcMVSTpFvmIzYQrq5SrDkXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5tbKD0OCGva9pRShinCPKLEaucHolPTFi6NiJRRLslODJDBUW8ad6f4u20ao5qPgJeMm/9OMeF7kRKyfMMaHLf04iip1LT6nO2y6vyOSA5fqCOqq5uBjAYFs/W0oyKuM4fDXy+8Hwsl7i/3L8rUudan+F/aWxReZueX5rYEukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0FJtEel; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7810289cd4bso1124363b3a.2
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758824937; x=1759429737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYnCr9LBwa+zohnNGGqjbDVQQNg+nC+1DZrTTslb0CI=;
        b=O0FJtEelN9f3ywD94qS7IBOG/bTa+mFdBm6hPWXTBRODyVS+VwKRUf5ZHma/ooTmKP
         Y1DpBqzNzFOesoKDvoaFrqRtOlFs72jhzdxHqfjgysCBsWZETH4Sc12phuBnX/mZV2TF
         3X7KhNK2WGYJjOUjxhDG6T34QvlK22g6YhFCRvhNtm4J+1PV69OfpMP1U5s6wejOvvge
         N6vEhl7Y90N5XQyRFqWQVLlwvH1UmMFjDHE4tLYZBdUEl0mjRCddLOeubZZGlFqFPky1
         dq/mV4OsAKHpNem9b1gU4n27P79sSlNP/n6jjf+X43NUYrjCzmsxoI3ZYsq0Vob1blGe
         zpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758824937; x=1759429737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYnCr9LBwa+zohnNGGqjbDVQQNg+nC+1DZrTTslb0CI=;
        b=vdn3vU2odjVHYMs5NRNTJXnXpwCRMPKgVjuim1dKUUdkCYiE0m7/0DJzt5mG/FWgPs
         p50DKRrvPDbwfLnRZq5FvAVD1ZUCcNPhpA2B/8LtOPN0fIUcVp35Z+rHSxrntGr6dgKM
         y7W9G5ukpYS41iqJnDrA1w78xY4OozKK1gzMGH70IiokxDzMGkNNWuzbPzN8mNMvmzcK
         5Gb4MuZUNmwMp+8sGxVPhPf5M0GWhoi1ockxUfbB7M1YTduhMEG8TUaXULg8EUBTlHmV
         8DtWf/uDlrzm75CAno2+Z3WmV6RMgnx7DN7Nr3EBSDiMYlqmpJzkAloJNrn5sPedQ8sm
         JcbQ==
X-Gm-Message-State: AOJu0YxsqR5mh2evTJOF7Sl+kLiM3CYudm5emhy5Zzf6WgMOv9489RGX
	obfz+QcE+A5zNH2y5b2z5ysBb2Z18K3a3QQru1twnWm72cV7esZR8iQ=
X-Gm-Gg: ASbGnctJLfaWsyXV2Y+s/4WWk8c6AM1XYuq+S2rTbNZpVaM9Ixwa84NqNBiTZbORMnr
	aWDvU9zK690JVJjpMnfM5BtMBf0HOXgXSQQ9D4qZA2NgE5ZKQOI3fSAeTR3exwcgxfDc+sbHW2g
	lgEEgJYYlJ5Vqf7070pNjzThx1I7HERAbRrrW6I5CA3Wtz5JN39rQWz0AiUi9r0kEad5HcaVNuu
	oINzuq5MLU8RkD80GPxOBGoYvAwQ2NR4YhaY5BSgqJD01Iarbkm8rayWxyN6TpW+/qKGFK2mvBJ
	gjpv1kTahOLQS0UAUrHkZXy/I2fUvI2f4eTh2bgMPeK4bMtd4cjYC6hVkg4cVNkzR/47l2WA7VE
	ZmkBq0+VYSX1IT/+RaMsYm035vEy/7lk5UGlp9e7u4LSB7RU6vfhG84nCH6gi7NPCD+Fr40BdEr
	Ne2HfBDJUTXzjz+uO8vXo987xxIV0P6O72I4/HWE7tO/zqqcXlydvPrZE6kWH+nMklh4XN52efC
	k1/
X-Google-Smtp-Source: AGHT+IGs7opWWff+bb7bUYaQzMzMGxk2nmquY73QNVXgVlvbPnuAJ5ZcfR7pxd/fm1x93mlovokxsw==
X-Received: by 2002:a05:6a20:e212:b0:24d:56d5:3693 with SMTP id adf61e73a8af0-2e7c44124e3mr4671670637.9.1758824937196;
        Thu, 25 Sep 2025 11:28:57 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-78102b23092sm2580058b3a.60.2025.09.25.11.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:28:56 -0700 (PDT)
Date: Thu, 25 Sep 2025 11:28:56 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, kerneljasonxing@gmail.com
Subject: Re: [PATCH v2 bpf-next 2/3] xsk: remove @first_frag from
 xsk_build_skb()
Message-ID: <aNWJ6KcLpdVNom82@mini-arch>
References: <20250925160009.2474816-1-maciej.fijalkowski@intel.com>
 <20250925160009.2474816-3-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250925160009.2474816-3-maciej.fijalkowski@intel.com>

On 09/25, Maciej Fijalkowski wrote:
> Instead of using auxiliary boolean that tracks if we are at first frag
> when gathering all elements of skb, same functionality can be achieved
> with checking if skb_shared_info::nr_frags is 0.
> 
> Remove @first_frag but be careful around xsk_build_skb_zerocopy() and
> NULL the skb pointer when it failed so that common error path does not
> incorrectly interpret it during decision whether to call kfree_skb().
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

