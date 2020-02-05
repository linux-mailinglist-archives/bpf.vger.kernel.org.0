Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE13C153A14
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2020 22:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgBEVWX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Feb 2020 16:22:23 -0500
Received: from www62.your-server.de ([213.133.104.62]:50824 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgBEVWX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Feb 2020 16:22:23 -0500
Received: from 33.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.33] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1izS7p-0007XL-Hw; Wed, 05 Feb 2020 22:22:21 +0100
Date:   Wed, 5 Feb 2020 22:22:21 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH v2 bpf] tools/bpf/runqslower: Rebuild libbpf.a on libbpf
 source change
Message-ID: <20200205212221.GB5358@pc-9.home>
References: <20200204215037.2258698-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204215037.2258698-1-songliubraving@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25716/Tue Feb  4 12:35:33 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 04, 2020 at 01:50:37PM -0800, Song Liu wrote:
> Add missing dependency of $(BPFOBJ) to $(LIBBPF_SRC), so that running make
> in runqslower/ will rebuild libbpf.a when there is change in libbpf/.
> 
> Fixes: 9c01546d26d2 ("tools/bpf: Add runqslower tool to tools/bpf")
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> Cc: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Applied, thanks!
