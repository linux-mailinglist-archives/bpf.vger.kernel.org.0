Return-Path: <bpf+bounces-55182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D869A796EF
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 22:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453503B37BF
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 20:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCEB1F3BBA;
	Wed,  2 Apr 2025 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfBDTIz2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7045A1EB182;
	Wed,  2 Apr 2025 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627409; cv=none; b=CRoTTS3FUjs0Dg0cmsXmOzwvhBjclYHn4R9KpwQ74PhESiDyoIcMLDR3ew59yWnkzIMNUwsztgsU7Has8xK1keBXrO1yi5YnF41ZuWv1za9FfDbluT7YRcpdfPEAnwKTJH8CZq/H82EBaPMfNvu/L4uNEigB7cN3pMr58ZmkRHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627409; c=relaxed/simple;
	bh=7b178FymiVTKJIVbEZEK4LifWYIg7wabzqBAxITRouU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwC87CGAD7XM935tddBKALgZgsgSUNUaOuU/x5f1zPvQt1qFaX1FrGgPENjEh2aV/LwVsYlvWboQmMXXO5jyDtmU8s6xBl/5nmnpexF/tnR1TxTCsSsXWYkj6SDGByFxeRUcYoBRz3sP4yE7gjpFnct4Xvs2r/8id9QgVQH+hqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfBDTIz2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736c3e7b390so189752b3a.2;
        Wed, 02 Apr 2025 13:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743627408; x=1744232208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6H9lg2RZh4ZHiEv8Kqa+UR0aSpTT/Kfq4waHfMS/6k=;
        b=GfBDTIz2W31LBosLcypsFV+RLR2ivCQraGGWUbvh1lxtohPOya477GVh+bSJrFFROh
         FvXQz1VzWkzYearR7/IWdl+BNg/yNNmcSZyY/h7fZtzYhP+6aT1bCP2NguZdTxilBoi/
         Oi1C/jURXy1/k+a5txO7ULz/8JyOzNn4Mj9/3bWF3+OxmFk9HuSVSOyurSOptsLulHgY
         bL66V/nfD3WDdLkOtb12tu7FRnkKQ4O2wlZcpEz2vydPsLVY6Ci9Ia7HjN5Se/QQWY4z
         ftGKELRqGnSPZxn/5vjNphN1kV4q13o8wsCE1VMHdySM1m99NSJlWYDw7RQzI2+KCqoH
         k+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743627408; x=1744232208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6H9lg2RZh4ZHiEv8Kqa+UR0aSpTT/Kfq4waHfMS/6k=;
        b=Y576b7KBJEgo8e9Xr+TGRXkuXHYIvRPLhhdhKcRc1XaI8pClEx1stwH8xQyu9lV2zO
         BkS/CKvmTdvYfRNgcCB5Y1AiGxF4oo8DarDvoI5kjIqApklkBsVCuHfVLRLmUs+Y+pWR
         qGpdtDkWiVslkmNiX3DewdtPQ4nQYOItjUfQ7DxyTMdwqJPCFlt1vxDUddOqXA8K66LF
         5aMHfQnZN2O8roPamTfSgXa5qoZaFgc2VQUy1LklMsm2lGAP3K+ayFQV0zRAx+lhqwsb
         fkTlP/wWVoph9l/yaMEGmEMhiCGOVFxnC1YnBqSpJkDq5jEumqcZKc+PAYyM8ksG4Rn5
         l3WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrIeJWwffFjuJe6j8d3NsuAwcwbOjllUTAE2jedCq0H6g7HX1dUD5bnUpp12A/vk97X3g=@vger.kernel.org, AJvYcCXpqKkemM/TPOR9eJTkmJ5BGFpTGQIkxx5TiIp71zYAXPRsQMVQHL+U4nGAa3ie8QOEqVHrmqFG@vger.kernel.org
X-Gm-Message-State: AOJu0YxaLR9mch+ZoBK06aliLWWKFLpABtqaz25YemJ0MJBFrj+aU/FZ
	ED6h1vLHCq8pPRu5m7yVKEpSF+vPA8p+chwgTc3XVcUtgg7/hPim
X-Gm-Gg: ASbGnctoh1T6324/Eewv4LHxaM6X2ftmmWCg0PTbFMcCQk1/ytM5Wu7BmKAzxQkNKgD
	EX6TRo8Ecgzbaauzppu3WgJYpnzl2NUzpprA5I7URFZiNLxz39gx8h7K7XE3b/C27t13IDz3mp4
	CRqpRYC+aYKt3WkAIx3Hyf6NpSjh55A8nWHSKeLzVAlICaWXGGd92rl1aXFoply0/ef/xA6zTlK
	epP8bghjWpA8WK8iLcOaPF0CNtlP9lUZhEMavsXT+htiEK7N7W0dV3KYmLe0rNDTIdFEIV/RFLF
	tZ3LkhGPmF1h1TveZlfe1uCecPgit9GpcbMlLEv9rwlO
X-Google-Smtp-Source: AGHT+IH7YAE+oS+GTWmh2OqJhDwX0yBPUMDZseaLgabblgMJk8xA9sl9w1PGo1hyJyOFzCWdtrQUnA==
X-Received: by 2002:a05:6a00:3d12:b0:736:32d2:aa93 with SMTP id d2e1a72fcca58-73980461abfmr30569862b3a.20.1743627407578;
        Wed, 02 Apr 2025 13:56:47 -0700 (PDT)
Received: from gmail.com ([98.97.40.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e27129sm11870292b3a.57.2025.04.02.13.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 13:56:46 -0700 (PDT)
Date: Wed, 2 Apr 2025 13:56:36 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: edumazet@google.com, kuniyu@amazon.com, pabeni@redhat.com,
	willemb@google.com, jakub@cloudflare.com, davem@davemloft.net,
	kuba@kernel.org, horms@kernel.org, daniel@iogearbox.net,
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
	bpf@vger.kernel.org, stfomichev@gmail.com, mrpre@163.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net v2 2/2] selftests: bpf: Add case for sockmap_ktls set
 when verdict attached
Message-ID: <20250402205608.kz2pwsetleu2ssmo@gmail.com>
References: <20250331012126.1649720-1-dongchenchen2@huawei.com>
 <20250331012126.1649720-3-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331012126.1649720-3-dongchenchen2@huawei.com>

On 2025-03-31 09:21:26, Dong Chenchen wrote:
> Cover the scenario when close a socket after inserted into the sockmap
> (verdict attach) and set ULP. It will trigger sock_map_close warning.
> 
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> ---

Nice Thanks.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

