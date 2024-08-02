Return-Path: <bpf+bounces-36302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D7C9462C1
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 19:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9D02824E2
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 17:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72ED15C122;
	Fri,  2 Aug 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="et0HRwr9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29801AE024
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722621329; cv=none; b=sXf9lquE0s3jQiRdXvQAMxDUYYPMjeV7wHgLjvbdOyRc0UuKCd2K+rhc9bqwltnNd+s/KqqH3F+0Z+NbS9EV+IhCnvojAmmn7gsJ4TBRve2pe86cO1QslWt5UVgNxYLo0haRgU8Aodes7IqweH7tL/sjr4M1NCIBnmJaspYACzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722621329; c=relaxed/simple;
	bh=BUt+yk47QC8u8sxCCzSSGLY3xmfY6eBtRyfTRA+BW70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqk57Qnv8yP5t8gT/DRUYBuqtcoakm7A/YpX5HkLQIJJc7UdXPDOSyE6JFEhZ+V/PKYS1evBBiGRRlnFGKGR3ZqXrXfrH2N5CWctdCEfO+QJHQ3iuRs3lmJfJKh9cc1q81I+zjVSYTE9OZvckfx24GVMfsowsuQ9cCoud7TIAyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=et0HRwr9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722621326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mSKMynH7mqtKWkD5s3WwP3QMfudW/geCCwMv+N77MHg=;
	b=et0HRwr9juix77jxhvxhU/qc/9OYLIvxDK71ZNCF/8dAAaiu+n5zpk+HYH4F6ZPzJ56ySJ
	1L9oa3NvKOmbzgLIJOq4BUKGt2jDX1OiDaxeTs3bofSilX8NmYj61VV9ti+IoV8fnJdkuJ
	eKn+9OXsccpaA5Ea79qrusvCy3hvQ34=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-O2X7mV5RP---zaNEr7Q5zQ-1; Fri, 02 Aug 2024 13:55:25 -0400
X-MC-Unique: O2X7mV5RP---zaNEr7Q5zQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b79d1eb896so115201346d6.0
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2024 10:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722621325; x=1723226125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSKMynH7mqtKWkD5s3WwP3QMfudW/geCCwMv+N77MHg=;
        b=XLBze5AIdFqAOqysh710aT3Xl++w12MKPuO6aGBEuiGX+Oac/YrDcYXd3RtwZhTI+o
         0LQa0/KgYFcLXonSyWCQt0IgZWV0s7NG93jcgmu1/boKi7xPbwikc3TGq9fFO/K7tVne
         pw1JbovAjFdy4NTObnw/UOKbp5J860DyIbAku4jJhln/BpTDmy6PqfeHoYbkKEObQjrA
         X1p9ukVLe8g2YItcmZqil/HBonHTuHRuoVUQ2XIs3YvrvSDZoFd/wqTgKOoLXCr0gxqq
         V2tmNCUqB9JesquknVPrxbt3KTNdILWIit7i1+w/7vM8croQDoHtiLCvk8aV4yBATUTT
         /iMA==
X-Forwarded-Encrypted: i=1; AJvYcCWLVf27LK0YtxYPGMTsgXwLCz2gdEzYzXOaiSvPIZK9aDRh1EGi1ROy7yV1RqehsFL2fDfeck02Ui7CubfoYkGyXBIn
X-Gm-Message-State: AOJu0Yx/Zvk1zchlTFv6Q4Sand0/xF7sjUUhxuv8xbT5/HgZu8M0TxRU
	O1KZWjrTNCMaQIrhrg62OoSX1HUckbNx7Y/ma/MyJNZ+e+XXFGitPWc8i9b4QajM1HfsHehD4YI
	hLxRXuewRHbyJYoLKd83yzDJk177O7SYbQuXliMa4vxC35wUFGw==
X-Received: by 2002:a05:6214:4906:b0:6b7:a1aa:994f with SMTP id 6a1803df08f44-6bb984930cbmr43871586d6.45.1722621325078;
        Fri, 02 Aug 2024 10:55:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvfmiXBn0WLDUS/+iZqeB7tPbwkJPYVpv9lxcQTRxIly8p6qsOwWEvqQVQyo1Xl6zPYGN0/g==
X-Received: by 2002:a05:6214:4906:b0:6b7:a1aa:994f with SMTP id 6a1803df08f44-6bb984930cbmr43871396d6.45.1722621324736;
        Fri, 02 Aug 2024 10:55:24 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c839787sm9000496d6.99.2024.08.02.10.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 10:55:24 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:55:22 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jose Abreu <joabreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next 01/14] net: stmmac: qcom-ethqos: add
 ethqos_pcs_set_inband()
Message-ID: <fc77km3ws5ucl7w2oyi3w6gvr6ovkzrt5tlhzh47qyowrak4hg@bqpjm5jgygbx>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
 <E1sZpnq-000eGq-U0@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sZpnq-000eGq-U0@rmk-PC.armlinux.org.uk>

On Fri, Aug 02, 2024 at 11:46:30AM GMT, Russell King (Oracle) wrote:
> Add ethqos_pcs_set_inband() to improve readability, and to allow future
> changes when phylink PCS support is properly merged.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>


