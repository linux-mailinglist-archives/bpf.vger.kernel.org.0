Return-Path: <bpf+bounces-37730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA5D95A0E7
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 17:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A637B23D4F
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 15:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1819913BC39;
	Wed, 21 Aug 2024 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auDlWr9w"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B50913049E
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252815; cv=none; b=Kk2ocVYCSRDXpROXEHLD+uXSe5mfJLttpmB6M7jxHBuKn8SavXlvPFWbnf1JKXlq3AAre61vR8s+UG2h5s3mfGSjWhjL3d9XsrgUCoU2HInPtfzgGausxzjLWC6YfkcWx6cOsxg2FB3IkABJ8tiMWGARWNZ7cx50nbaFJgMFaoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252815; c=relaxed/simple;
	bh=to97TeDicJXmAINHPIglAv1Z3AAxVgTCyxjcxwzQ+WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbUpZwCUYz1VvNS4CCUKphPL39IWqS64OIa+uFaBsoCBaEPicn+83ECqoZqu4qjVrqLH9W3952dJz63KklGJ/0H7MtyONWh+L0GEaEkaBNpONCdkXoQwOU9tfIXKVfT/5gDiG7COnGXspLpmuCy45PTCHHn4shkQrINxsRRrIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=auDlWr9w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724252813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=to97TeDicJXmAINHPIglAv1Z3AAxVgTCyxjcxwzQ+WA=;
	b=auDlWr9w9EjKPccmk/N0969yXS+4ap7TQsoJrA/x7lOIQGHL21E+fLg3muxlTg3T52ilct
	9IURHxRzesC0njiCZwVPCO6FIRBSIYUoZMYaXk6654SxCxDgybHd9A6uY9HSE8HJtjYQvo
	+vzIi+A5ozXvRBRb9jybYSWcBddY4Hw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-uHmsrpwsOc6Q8ckv3ua9hw-1; Wed, 21 Aug 2024 11:06:51 -0400
X-MC-Unique: uHmsrpwsOc6Q8ckv3ua9hw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4280a434147so57336635e9.3
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 08:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724252810; x=1724857610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=to97TeDicJXmAINHPIglAv1Z3AAxVgTCyxjcxwzQ+WA=;
        b=cQ/9n/yj8rdutbs6Uk/Gfk+T6oFc5aupFN3q7XJj3mOEX0OI4UyhXkU268qQhj7TLh
         6CVR17bPPuwPG7JwgSOllQlKOVDgKaFFiDksoBjICgZf1xmp4uJCzNqQYkT/iX0LDAV9
         HmenX7FEjWL5SltUvm5GjN85Lvv+YvncWVabBP+Omfyc9KKs3gWvVhn9zwqK5rnjlyRt
         WZJNlxcXL6xBzkMLriYaiYeTn5wgzGUOvh/rc4Tqy/GDeCT/6+E5wBSj/01zg7YfKz7D
         RoVDK11rSUXTXeIMvR1jTFiAz+lEd6BYljBffAszZKDfcrAFcTOzRdIFGc31wX4b69u4
         M9EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXkyBKRcCSo0oE20iMT3ptACoyHxJIET7+Rf+ED8129iFk264yyo1Dq9l5lMjivTvWrnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFxT0saLlcg1VCw39JCESiLtehN6DDgkWC9+BlWzvB3ywkDEA4
	cqCtKNZcZXXe4ZZ7l8ju569d64VzhPCb/NC1CW34bO55J3eWKD1/MSf+WlnmXoOTuIXdYAjCwzW
	bW9riwMfQ9ZTWLRsIbPegbOwb4GS0g9TOavGKCzJaVSnu24OARw==
X-Received: by 2002:a05:600c:3c94:b0:428:23c8:1e54 with SMTP id 5b1f17b1804b1-42abf05ba0emr18022095e9.18.1724252810622;
        Wed, 21 Aug 2024 08:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEiCsk9azLAavc2eGd1Zdp4wTY9+FLkpAEYZujUzgvcmE4b3AkL9yBV4AJjIH5CjD5eKxTqg==
X-Received: by 2002:a05:600c:3c94:b0:428:23c8:1e54 with SMTP id 5b1f17b1804b1-42abf05ba0emr18021655e9.18.1724252809808;
        Wed, 21 Aug 2024 08:06:49 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abefc626fsm29116605e9.31.2024.08.21.08.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 08:06:49 -0700 (PDT)
Date: Wed, 21 Aug 2024 17:06:47 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 07/12] ipv4: Unmask upper DSCP bits in
 fib_compute_spec_dst()
Message-ID: <ZsYChzAbHQzR8bX+@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-8-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-8-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:46PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits of the DS field of the packet that triggered
> the reply so that in the future the FIB lookup could be performed
> according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


