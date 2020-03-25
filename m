Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC76193479
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 00:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCYXTj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 19:19:39 -0400
Received: from www62.your-server.de ([213.133.104.62]:48302 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgCYXTj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 19:19:39 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jHFJA-0003Ax-Vv; Thu, 26 Mar 2020 00:19:37 +0100
Received: from [85.7.42.192] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jHFJA-000ETE-LY; Thu, 26 Mar 2020 00:19:36 +0100
Subject: Re: [PATCH v3 bpf-next] bpf: Document bpf_inspect drgn tool
To:     Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, osandov@fb.com, kernel-team@fb.com, corbet@lwn.net,
        toke@redhat.com, brouer@redhat.com
References: <20200324185135.1431038-1-rdna@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e7e88b70-182b-fbb1-22ea-f77d2cd67446@iogearbox.net>
Date:   Thu, 26 Mar 2020 00:19:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200324185135.1431038-1-rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25762/Wed Mar 25 14:09:24 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/24/20 7:51 PM, Andrey Ignatov wrote:
> It's a follow-up for discussion in [1].
> 
> drgn tool bpf_inspect.py was merged to drgn repo in [2]. Document it in
> kernel tree to make BPF developers aware that the tool exists and can
> help with getting BPF state unavailable via UAPI.
> 
> For now it's just one tool but the doc is written in a way that allows
> to cover more tools in the future if needed.
> 
> Please refer to the doc itself for more details.
> 
> The patch was tested by `make htmldocs` and sanity-checking that
> resulting html looks good.
> 
> v2->v3:
> - two sections: "Description" and "Getting started" (Daniel);
> - add examples in "Getting started" section (Daniel);
> - add "Customization" section to show how tool can be customized.
> 
> v1->v2:
> - better "BPF drgn tools" section (Alexei)
> 
> [1]
> https://lore.kernel.org/bpf/20200228201514.GB51456@rdna-mbp/T/#mefed65e8a98116bd5d07d09a570a3eac46724951
> [2] https://github.com/osandov/drgn/pull/49
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>

Applied, thanks!
