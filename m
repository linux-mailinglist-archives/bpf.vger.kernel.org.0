Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4A532B32B
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352462AbhCCDse (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:48:34 -0500
Received: from www62.your-server.de ([213.133.104.62]:37998 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349635AbhCBK7d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 05:59:33 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lH2jj-00052w-2R; Tue, 02 Mar 2021 11:58:43 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lH2ji-000CQm-Rk; Tue, 02 Mar 2021 11:58:42 +0100
Subject: Re: [PATCH v5 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit
 cmpxchg
To:     Brendan Jackman <jackmanb@google.com>, bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Martin KaFai Lau <kafai@fb.com>
References: <20210302105400.3112940-1-jackmanb@google.com>
 <CA+i-1C3C7di0uEtMQHTbes_+BF8g8ZCN-bykkJLFHM1dk1ShTQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <950a965a-14a7-bfe8-f4aa-46745ebf0be2@iogearbox.net>
Date:   Tue, 2 Mar 2021 11:58:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CA+i-1C3C7di0uEtMQHTbes_+BF8g8ZCN-bykkJLFHM1dk1ShTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26095/Mon Mar  1 13:10:16 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/2/21 11:56 AM, Brendan Jackman wrote:
> On Tue, 2 Mar 2021 at 11:54, Brendan Jackman <jackmanb@google.com> wrote:
>> base-commit: f2cfe32e8a965a86e512dcb2e6251371d4a60c63
> 
> Oh yeah, this is based on Ilya's patch [1]. Is that OK or should I
> just resend it once that one is merged?
> 
> [1] https://lore.kernel.org/bpf/20210301154019.129110-1-iii@linux.ibm.com/T/#u

No need to resend, enough to have it stated here.

Thanks,
Daniel
