Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B615CA142
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2019 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbfJCPkr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Oct 2019 11:40:47 -0400
Received: from www62.your-server.de ([213.133.104.62]:51080 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfJCPkq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Oct 2019 11:40:46 -0400
Received: from 57.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.57] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iG3Da-0005V2-F8; Thu, 03 Oct 2019 17:40:38 +0200
Date:   Thu, 3 Oct 2019 17:40:38 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2] samples/bpf: Add a workaround for asm_inline
Message-ID: <20191003154038.GB18067@pc-63.home>
References: <20191002191652.11432-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002191652.11432-1-kpsingh@chromium.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25591/Thu Oct  3 10:30:38 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 02, 2019 at 09:16:52PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> This was added in:
> 
>   commit eb111869301e ("compiler-types.h: add asm_inline definition")
> 
> and breaks samples/bpf as clang does not support asm __inline.
> 
> Co-developed-by: Florent Revest <revest@google.com>
> Signed-off-by: Florent Revest <revest@google.com>
> Signed-off-by: KP Singh <kpsingh@google.com>

Applied, thanks!
