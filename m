Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A36E7149035
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 22:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgAXVfr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 16:35:47 -0500
Received: from www62.your-server.de ([213.133.104.62]:48630 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAXVfr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 16:35:47 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iv6cD-0008FV-G0; Fri, 24 Jan 2020 22:35:45 +0100
Received: from [178.197.248.48] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1iv6cD-000GQr-7B; Fri, 24 Jan 2020 22:35:45 +0100
Subject: Re: [PATCH bpf-next] libbpf: fix realloc usage in bpf_core_find_cands
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, williampsmith@fb.com
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com
References: <20200124201847.212528-1-andriin@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <29074cbf-791c-8d3c-1b94-cd77e9a02c3f@iogearbox.net>
Date:   Fri, 24 Jan 2020 22:35:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200124201847.212528-1-andriin@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25705/Fri Jan 24 12:39:10 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/24/20 9:18 PM, Andrii Nakryiko wrote:
> Fix bug requesting invalid size of reallocated array when constructing CO-RE
> relocation candidate list. This can cause problems if there are many potential
> candidates and a very fine-grained memory allocator bucket sizes are used.
> 
> Fixes: ddc7c3042614 ("libbpf: implement BPF CO-RE offset relocation algorithm")
> Reported-by: William Smith <williampsmith@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied, thanks!
