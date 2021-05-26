Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342003910C4
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 08:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhEZGiR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 02:38:17 -0400
Received: from www62.your-server.de ([213.133.104.62]:43266 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhEZGiN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 02:38:13 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lln8S-0006Sp-Bn; Wed, 26 May 2021 08:35:20 +0200
Received: from [85.7.101.30] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lln8S-000G7z-5Y; Wed, 26 May 2021 08:35:20 +0200
Subject: Re: [PATCH bpf v2] libbpf: Move BPF_SEQ_PRINTF and BPF_SNPRINTF to
 bpf_helpers.h
To:     Florent Revest <revest@chromium.org>, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, kpsingh@kernel.org,
        jackmanb@google.com, linux-kernel@vger.kernel.org
References: <20210525201825.2729018-1-revest@chromium.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f3e6c21e-8d6e-2665-770c-65f9b98ccf93@iogearbox.net>
Date:   Wed, 26 May 2021 08:35:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210525201825.2729018-1-revest@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26181/Tue May 25 13:17:38 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/25/21 10:18 PM, Florent Revest wrote:
> These macros are convenient wrappers around the bpf_seq_printf and
> bpf_snprintf helpers. They are currently provided by bpf_tracing.h which
> targets low level tracing primitives. bpf_helpers.h is a better fit.
> 
> The __bpf_narg and __bpf_apply macros are needed in both files so
> provided twice and guarded by ifndefs.
> 
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Florent Revest <revest@chromium.org>

Given v1/v2 both target bpf tree in the subject, do you really mean bpf or
rather bpf-next?

Thanks,
Daniel
