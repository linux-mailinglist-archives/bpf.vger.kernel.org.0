Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C4D204143
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 22:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgFVUIH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 16:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730020AbgFVUIH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 16:08:07 -0400
Received: from kicinski-fedora-PC1C0HJN (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63DA62076E;
        Mon, 22 Jun 2020 20:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592856486;
        bh=rQToPzgQxPvlfbmHGmBPhJaR+YMMVyj4+i+nGDQDjeA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vCEsNS3UEvvwRLblbVpg6sU+G4a5QcKeFKcIS/kgJAGr83niL7oT99Eq3kisW6MW2
         kAeoRAt8vmA98yqtBsP1v5Cds66pfy1WDWn5Im3bQVvKAbS9xb/Mp/Y1tVfdugmqE0
         G+YxIe/AHs0OH1uxkdjxozM/BMTIfXrogJ7G6BV0=
Date:   Mon, 22 Jun 2020 13:08:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next v2 00/15] implement bpf iterator for tcp and
 udp sockets
Message-ID: <20200622130804.62099862@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20200621055459.2629116-1-yhs@fb.com>
References: <20200621055459.2629116-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 20 Jun 2020 22:54:59 -0700 Yonghong Song wrote:
> Changelogs:
>   v1 -> v2:
>     - guard init_sock_cast_types() defination properly with CONFIG_NET (Martin)
>     - reuse the btf_ids, computed for new helper argument, for return
>       values (Martin)
>     - using BTF_TYPE_EMIT to express intent of btf type generation (Andrii)
>     - abstract out common net macros into bpf_tracing_net.h (Andrii)

netdev@ has not been CCed either on v1 or v2. 
Seems more than appropriate to do so.
