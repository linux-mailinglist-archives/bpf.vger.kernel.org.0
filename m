Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFE1911DDCD
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2019 06:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbfLMFgj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Dec 2019 00:36:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35410 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbfLMFgj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Dec 2019 00:36:39 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so996582pgk.2
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2019 21:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2h2UzjnHJYD9OywlVKlGrMyJ+h8TPcIfVfK0NBQxhKk=;
        b=eL8nD3INSlYoGP6XOy9vjvfu/iNP580EhzSIAfigvJqKqqIfdyblYY0QpjG1TZodFk
         kyH3vPj4EzHa154tppJHTVelVVUshBTOWgal4MtQIe4GgNZPv50puiqQC2q0U9XCyl3M
         Nh3Y0LR8Icn5C1tZ3Ye2/tkdv71vjNkgd0HZa26L3KSjUunF6faqsPDLRNoRR8a5uBYB
         JCOu2GZ6h6kzxhiolfVzcErnldkvRz7vm7Dt43eMWeql9ZxMAKovHtK+7xr4aneP8yA4
         SnP399WVDcESK1WBacvM6o07It0OUsWxkCrXfTEQ955dzmHp9mvU7VTdKtpYMLJCqdF5
         WxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2h2UzjnHJYD9OywlVKlGrMyJ+h8TPcIfVfK0NBQxhKk=;
        b=HYfAnhNufvmRBBvPupmxdPEgRIuYgLXB+HcKO3+dTX/CV68mGnB5rzUCYPHFBPtbYT
         VYPm9Tnzl00tRYKdK70/EIXFUtcMs56G5TEKjS/4/I8bZB7RPWFOxy61fsdZ9Hx4VGW/
         Fr1xNlmky0yin69l5jvdVjxpN5a0TsyQN4KYtY3qdzbIlEQ6Doh4xSU7e0X/VgePDtUN
         dquukgLxqaHi9P8L9L9Z1QKHumSPRS5bzEbLn2SjXGKIzEYiz6jhe9ywbBunmDlwfAVZ
         sWpRFRMdSubM4TxBWc5PunVp+X8A+vP3pgGGsqfdKFhehMJq6TVx2VrlZDiKD8f4Gs30
         AdFg==
X-Gm-Message-State: APjAAAXxuTAEroeuEixQmnTukFAlDpx++OGV9ImEu1Wrfg59PD8K7/zv
        rfaM29CjaaY3vmrsjToWA0rnROui
X-Google-Smtp-Source: APXvYqyLyFxLpqlTkpxv0UjLwXgp6NB+Bgrhm7zmR8GsQJLiKwWtiRDjX2yHwPnLi9FyQOd0MdLEYA==
X-Received: by 2002:a62:3784:: with SMTP id e126mr14220364pfa.228.1576215398961;
        Thu, 12 Dec 2019 21:36:38 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:180::c195])
        by smtp.gmail.com with ESMTPSA id k21sm8913066pgt.22.2019.12.12.21.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 21:36:38 -0800 (PST)
Date:   Thu, 12 Dec 2019 21:36:36 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     bpf@vger.kernel.org, Martin Lau <kafai@fb.com>,
        kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next 00/10] Switch reuseport tests for test_progs
 framework
Message-ID: <20191213053635.4k42db43u6jbivi5@ast-mbp>
References: <20191212102259.418536-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212102259.418536-1-jakub@cloudflare.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 12, 2019 at 11:22:49AM +0100, Jakub Sitnicki wrote:
> This change has been suggested by Martin Lau [0] during a review of a
> related patch set that extends reuseport tests [1].
> 
> Patches 1 & 2 address a warning due to unrecognized section name from
> libbpf when running reuseport tests. We don't want to carry this warning
> into test_progs.
> 
> Patches 3-8 massage the reuseport tests to ease the switch to test_progs
> framework. The intention here is to show the work. Happy to squash these,
> if needed.
> 
> Patches 9-10 do the actual move and conversion to test_progs.
> 
> Output from a test_progs run after changes pasted below.

Thank you for doing this conversion.
Looks great to me.

Martin,
could you please review ?

