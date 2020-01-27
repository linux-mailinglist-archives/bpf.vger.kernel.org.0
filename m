Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEA814A24E
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 11:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgA0Kzm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 05:55:42 -0500
Received: from www62.your-server.de ([213.133.104.62]:42446 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgA0Kzl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 05:55:41 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iw23P-0006qG-Hj; Mon, 27 Jan 2020 11:55:39 +0100
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=linux-3.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1iw23P-0001m7-AB; Mon, 27 Jan 2020 11:55:39 +0100
Subject: Re: [PATCH bpf-next] tools/bpf: Allow overriding llvm tools for
 runqslower
To:     Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, kernel-team@fb.com
References: <20200124224142.1833678-1-rdna@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <126aca70-abdc-00ca-9a4a-9182e7a54c54@iogearbox.net>
Date:   Mon, 27 Jan 2020 11:55:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200124224142.1833678-1-rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25707/Sun Jan 26 12:40:28 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/24/20 11:41 PM, Andrey Ignatov wrote:
> tools/testing/selftests/bpf/Makefile supports overriding clang, llc and
> other tools so that custom ones can be used instead of those from PATH.
> It's convinient and heavily used by some users.
> 
> Apply same rules to runqslower/Makefile.
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>

Applied, thanks!
