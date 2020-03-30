Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFFE61985EA
	for <lists+bpf@lfdr.de>; Mon, 30 Mar 2020 23:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgC3VAQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Mar 2020 17:00:16 -0400
Received: from www62.your-server.de ([213.133.104.62]:41432 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgC3VAQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Mar 2020 17:00:16 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jJ1W2-00008c-T2; Mon, 30 Mar 2020 23:00:14 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jJ1W2-000MLg-LA; Mon, 30 Mar 2020 23:00:14 +0200
Subject: Re: [PATCH bpf-next] bpf: lsm: Make BPF_LSM depend on BPF_EVENTS
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <20200330204059.13024-1-kpsingh@chromium.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a51da62a-03da-fae5-f6eb-9aacdd7861b2@iogearbox.net>
Date:   Mon, 30 Mar 2020 23:00:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200330204059.13024-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25767/Mon Mar 30 15:08:30 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/30/20 10:40 PM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> LSM and tracing programs share their helpers with bpf_tracing_func_proto
> which is only defined (in bpf_trace.c) when BPF_EVENTS is enabled.
> 
> Instead of adding __weak symbol, make BPF_LSM depend on
> BPF_EVENTS so that both tracing and LSM programs can actually share
> helpers.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: fc611f47f218 ("bpf: Introduce BPF_PROG_TYPE_LSM")

Applied, thanks!
