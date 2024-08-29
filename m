Return-Path: <bpf+bounces-38389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7939964288
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 13:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B49BBB26D31
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EDC191F70;
	Thu, 29 Aug 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpapQYuR"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4A1917FB
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929353; cv=none; b=IMmr08qLD/FNnvOHVDNNPnvvugq1Pha2UN6SN4UESNhRNo1POBCzd0AzR69ZTjP2mS7U8uC3QM1FzpOdciEIULRDP/uhTI4FG6qId+5rp7z4My/XoSMCLS3+dbAoRHcpndQvCIEDbA+kej92QVWEBnXY63ewQOQwQUX3Cv2m2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929353; c=relaxed/simple;
	bh=ranjirdg1Agf8CkLKvjWUMXHcjWordwX5fkwJA2TPik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZU7E3wbB3zjDyhKnwdrDtWzUblNRe3Ffm3hhJ3UqAj7JS5wyPpQ2di5urvPb8mxrHa3z9zF42Ewi1sM4QCoSYXU49KsyaABwflO86dl3wDsk2N0r/DcXn6RvCuxG6STiSqmpkFYM1cG8PQE+0RzAi6WmQtw/LVi6Y7cWU+K5bwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpapQYuR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724929349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ranjirdg1Agf8CkLKvjWUMXHcjWordwX5fkwJA2TPik=;
	b=cpapQYuRzx14TH478/t5ab9csQzMzuB5u+rN4ydl/IOFrZWOjQ0q22zacxITUk+R/X5P7E
	7GXNjtUawBS9Um5jH2DNuL9+WDabWTsA9StWGrO8xzE/hMdJq2OdVAYD+36pz64AKqx41R
	LEI96amqfksDOpQ3OouEiA4pWX9scoI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-hDhRWuA_MdKR9RzeVHgkqA-1; Thu, 29 Aug 2024 07:02:28 -0400
X-MC-Unique: hDhRWuA_MdKR9RzeVHgkqA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42817980766so5401895e9.3
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 04:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724929347; x=1725534147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ranjirdg1Agf8CkLKvjWUMXHcjWordwX5fkwJA2TPik=;
        b=FberjC74lTNQM8f2MeNXc0ZaQ7xU9Mi8KbEW4hdv79cQ0IQWSD6fiMKnLvVahBJc98
         SuJMxBoj4lA5tiiLraMKmq7b1DAnuEj+XIACP5cTmftXezsgaH5quRzIntV1+7eDNLxK
         r31IuYLQ5jRTegMf5E6z9DnSHAHG3RDQY3vCItYisLBSmEw0/LKsLSAKJ8LAz6CGDXZr
         /Gs9IlCZlZPoI60adjfyItt0q+aNprKgYgGtZdlAtqFQLWljBvNOXvOAWnauLzuWA37w
         0EEcCL19RguQugPog9kmSDddoX0oWG3j0+ZI6vrjk45h4qSXpSFnpqpDuzn5p+Qqeos8
         jRiw==
X-Forwarded-Encrypted: i=1; AJvYcCX8kAApj+7ZGbSLteIXV3/Ll6rx25ol0+prpbDu7+ssR+O+roo48FDo1+oc4ai8POuWgwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPOpE90Ks9pFD8eTgqDuMdYeRixkFo7igD1a1lKI2zqe6qxoXz
	1CR6iiL4AZ9k+0aVnJgFdG1sOeEwn2v5Rgq7oQrm/l3mEMz7ALMDRYDKO+Gvat+MjrS7bGmDHfO
	drR6rY9T+lzZ7Tuzz/u+QlO2BiSjzQCq3R1KNXjDLaxYOZFdZcQ==
X-Received: by 2002:adf:f44f:0:b0:368:3f5b:2ae4 with SMTP id ffacd0b85a97d-3749b5615demr1637530f8f.36.1724929347338;
        Thu, 29 Aug 2024 04:02:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjFgXXnFysvtJ9yqzthz/bi/1l5irBWdODgggA8xXwvUbQyC2+4BF969CysEoAgf88vmUgRw==
X-Received: by 2002:adf:f44f:0:b0:368:3f5b:2ae4 with SMTP id ffacd0b85a97d-3749b5615demr1637485f8f.36.1724929346457;
        Thu, 29 Aug 2024 04:02:26 -0700 (PDT)
Received: from debian (2a01cb058918ce00dbd0c02dbfacd1ba.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dbd0:c02d:bfac:d1ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee7475dsm1107061f8f.27.2024.08.29.04.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:02:26 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:02:24 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 12/12] bpf: Unmask upper DSCP bits in
 __bpf_redirect_neigh_v4()
Message-ID: <ZtBVQECYJyaekFZY@debian>
References: <20240829065459.2273106-1-idosch@nvidia.com>
 <20240829065459.2273106-13-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829065459.2273106-13-idosch@nvidia.com>

On Thu, Aug 29, 2024 at 09:54:59AM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_flow() so that
> in the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


