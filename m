Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65427397A4E
	for <lists+bpf@lfdr.de>; Tue,  1 Jun 2021 20:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhFAS7y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Jun 2021 14:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhFAS7y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Jun 2021 14:59:54 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81687C061574;
        Tue,  1 Jun 2021 11:58:12 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 27606750;
        Tue,  1 Jun 2021 18:58:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 27606750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622573892; bh=56iJKguwV+t7o6fuVd3IIFIuWhnqqtZ2cfjSVsXB9Jc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dlQbgGh/s1fFSjqU0oGSwrGBEeDHXGGfUY9j43mIOiL9fWC/fv4K1dqnJ24e8pHpC
         KetO1lGW9EfgurETwetpyEayA8Tm244A8drAMT44nPx87ta+Xbxv3T/a8lwLuuaHTe
         3IC9YWi8mRZV3ecAUxTEsUf6MuVRZslqUX/2FQywapk0hc/pvyB4iIQ1VQtFvxClIA
         jZ4OYuU3pDHi5ADmpKARjG3JsDI4OXDuS87+r3M0K3K/ugSLHhQDnaOVzJ3OX/g/iK
         ++BFRSa0Kqu88IuxzrNNcctp+0a7oVkSNHOA08VtbHS9dhiDxYPsuErhJ4vIVWxLQf
         vpVeuAAXL9Kzw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     grantseltzer <grantseltzer@gmail.com>, andrii@kernel.org,
        daniel@iogearbox.net
Cc:     linux-doc@vger.kernel.org, grantseltzer@gmail.com,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/2] Autogenerating libbpf API documentation
In-Reply-To: <20210531195553.168298-1-grantseltzer@gmail.com>
References: <20210531195553.168298-1-grantseltzer@gmail.com>
Date:   Tue, 01 Jun 2021 12:58:11 -0600
Message-ID: <871r9lbef0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

grantseltzer <grantseltzer@gmail.com> writes:

> This patch series is meant to start the initiative to document libbpf.
> It includes .rst files which are text documentation describing building, 
> API naming convention, as well as an index to generated API documentation.
>
> In this approach the generated API documentation is enabled by the kernels
> existing kernel documentation system which uses sphinx. The resulting docs
> would then be synced to kernel.org/doc
>
> You can test this by running `make htmldocs` and serving the html in 
> Documentation/output. Since libbpf does not yet have comments in kernel
> doc format, see kernel.org/doc/html/latest/doc-guide/kernel-doc.html for
> an example so you can test this.
>
> The advantage of this approach is to use the existing sphinx
> infrastructure that the kernel has, and have libbpf docs in
> the same place as everything else.
>
> The perhaps large disadvantage of this approach is that libbpf versions
> independently from the kernel. If it's possible to version libbpf
> separately without having duplicates that would be the ideal scenario.

I'm happy to see things going this direction; it looks like a good start
to me.

Let me know if you'd like this to go through the docs tree, or feel free
to add:

  Acked-by: Jonathan Corbet <corbet@lwn.net>

if you want to route it via some other path.

Thanks,

jon
