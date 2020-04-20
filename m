Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7581B19DD
	for <lists+bpf@lfdr.de>; Tue, 21 Apr 2020 00:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgDTW7v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Apr 2020 18:59:51 -0400
Received: from ms.lwn.net ([45.79.88.28]:54200 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgDTW7u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Apr 2020 18:59:50 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 30928823;
        Mon, 20 Apr 2020 22:59:50 +0000 (UTC)
Date:   Mon, 20 Apr 2020 16:59:49 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, linux-doc@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] docs: sysctl/kernel: document BPF entries
Message-ID: <20200420165949.14dc0752@lwn.net>
In-Reply-To: <20200315122648.20558-1-steve@sk2.org>
References: <20200315122648.20558-1-steve@sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 15 Mar 2020 13:26:48 +0100
Stephen Kitt <steve@sk2.org> wrote:

> Based on the implementation in kernel/bpf/syscall.c,
> kernel/bpf/trampoline.c, include/linux/filter.h, and the documentation
> in bpftool-prog.rst.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
> 
> Notes:
>     This patch is intended for docs-next, but I'd appreciate reviews from
>     BPF developers.

Haven't seen a whole lot of those...it's been a month, so I'll ahead and
apply this; it can be fixed up later if need be.

Thanks,

jon
