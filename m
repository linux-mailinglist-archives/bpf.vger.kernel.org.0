Return-Path: <bpf+bounces-42164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 488A09A03E3
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 10:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0201F22346
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 08:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B201D414F;
	Wed, 16 Oct 2024 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXwmJQWu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D24D1D278B;
	Wed, 16 Oct 2024 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066436; cv=none; b=h9b+Lln4fSGWK5fjNuOTMfmyZxqvGXxMaUni4hIpLrb60GfpAd32xdkOlRaouepPCpZfMpj+HrQ9ZKyIrggZ2eTZrrrXpRkAzRUdxM/P0XmXgeyBJuuY+sKlrjvpNTA/ThA8SS90qAXfllhq67gMVrGPLr6JMBsG2oL4JV0QyVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066436; c=relaxed/simple;
	bh=VE234QWU2c0jg8Kgp1MC6oRd9f1i7/85eMkUYLWq/NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeUT2EUgHSvE8z1Y/IgvbjgaOT+pFTQLku6WchrC6UduNhkR4dcr9zfpHdUucKL6dM9Om+Xk+czwY2JqMhI4biwUZrLmRNCrXEzrS/7Ah9ZiXth9IqA44eruGdjUROwqSVKshvy9sI9tM2QTbPF18/G72OZndME5QnEibsOdzsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXwmJQWu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ca7fc4484so31229455ad.3;
        Wed, 16 Oct 2024 01:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729066434; x=1729671234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uxqG0B8mR4fzbFEa0w+VCmcvQKzrvGlEU7Guq/5xOqA=;
        b=BXwmJQWuAS3Q+EWwEs/g95skiz55LvV8zFq66aJDow97VYVzSlj3oDeJCUXwedHHQ2
         5CFWzq2r0UgDdcGP59LPy3vcX85a33XW73E0p0+e0BKsc+eX/z5ayIj5Rd68HrctWVtd
         G8kXOCbz8WqOz4Sa77RYslb+X/+XL7aGV8OuAO4GdO9zOeo2ApcCRDDP5MOYcq38TSTr
         Il5W7zxSffx02ejmmrLMJw1si6rvlDRWdocPnLgsFMb9+YPlhDo9KFxWDJoVf9m5PU+E
         Nbu3xnxTjTMkDcyR34qNwJ9Lf5gj0sKYI83VFpoI7Bm6oVO9CCzFMjLEgsWFV19hOSH3
         pq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066434; x=1729671234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxqG0B8mR4fzbFEa0w+VCmcvQKzrvGlEU7Guq/5xOqA=;
        b=iXwgdxC/9qz3zoxviP9bB4cJ9Vbnp19Gt24dbuer0jMpk1k7ChCqi3IfwzqxzCEqCd
         aOYQADzUfcyrJgb4gjYGFyrhC5KgzxqjdYWxio9VqG9wihy9FwczoCtFSdnbsQQVYbvI
         vUj7D4GutSPpLgafOVd9OYaJjdJBevH1mDVavNfBEZzVGOja8jBo7zBFidXhQFkPCs9a
         hFX+KPZw61kVMdtJ6rfsMBs+Up9e6/tPV4/AH+/MqHzGZal73Bs880g7v6BQH0dG6gHu
         tukGZ/iaBlVpIa74N91L3juImLFivxtdXnM0EpXqX+hKJvdA5evaVxsQy68sGNAA0m1I
         jvDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW7Pe3PN4uQbvRq8KDNXsfRYBa+7YaDiq1uKH4FEs5Lm/+ZBWP9w66Y1r5FYT9ivbzcXh2BdNnumED@vger.kernel.org, AJvYcCXiMraFCN/mJL8uPPqGbL68h2aaz4topguqGBIJVpK5uauiHKqP0hPVIv3o1LQfJHEiRDlI4EE0kWhyEhml@vger.kernel.org, AJvYcCXygih76EfIO4d5ad97lGKm5VlJemWs2HwF24BHbrycHJOQ1zZCFqR+uVCSDqBsdruBOTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzteIDDW1YcM+vsi3hmh1QvxdJJQxBdhrTDZtWUzHK5KFEZpsBI
	Y2NlShfudeUKcrm9w29FojOTZgPEosM1HX0ly7CRzgRyefweXZ2A
X-Google-Smtp-Source: AGHT+IG6d27P9i5lG/uEayhLGFbXmAexef6ZEMQFrZoDVRNPG4gtPVA7uqXB7gWUqNXj/5nvzwaFUg==
X-Received: by 2002:a17:903:2406:b0:20c:a8cf:fa19 with SMTP id d9443c01a7336-20cbb198f19mr230740795ad.22.1729066434256;
        Wed, 16 Oct 2024 01:13:54 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d18036213sm23913525ad.168.2024.10.16.01.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:13:53 -0700 (PDT)
Date: Wed, 16 Oct 2024 08:13:44 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, Jussi Maki <joamaki@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] Documentation: bonding: add XDP support
 explanation
Message-ID: <Zw91uKWJMT7YlKd0@fedora>
References: <20241016031649.880-1-liuhangbin@gmail.com>
 <20241016031649.880-4-liuhangbin@gmail.com>
 <1e489737-fdd8-43a7-9abc-65599e1cfae1@blackwall.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e489737-fdd8-43a7-9abc-65599e1cfae1@blackwall.org>

On Wed, Oct 16, 2024 at 10:38:05AM +0300, Nikolay Aleksandrov wrote:
> > +9.  What modes does bonding have native XDP support?
> TBH this sounds strange and to be correct it probably needs
> to end with "for" (What modes does bonding have native XDP support for), but
> how about something straight-forward like:
> 
>  What bonding modes have native XDP support?
> 
> or
> 
>  What bonding modes support native XDP?

Thanks, I will use this one.

Hangbin

