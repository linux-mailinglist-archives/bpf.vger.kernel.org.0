Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FD52B1EDB
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 16:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKMPdn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 10:33:43 -0500
Received: from www62.your-server.de ([213.133.104.62]:56100 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgKMPdm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Nov 2020 10:33:42 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kdb52-0000Z9-KS; Fri, 13 Nov 2020 16:33:40 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kdb52-000XAi-CI; Fri, 13 Nov 2020 16:33:40 +0100
Subject: Re: [PATCH bpf-next 2/2] bpf: Expose bpf_d_path helper to sleepable
 LSM hooks
To:     Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@chromium.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
References: <20201112171907.373433-1-kpsingh@chromium.org>
 <20201112171907.373433-2-kpsingh@chromium.org>
 <63870297-fffe-f01e-9747-219b63c5d7f4@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8ca075b7-1fda-bd63-e2c2-68618d30b414@iogearbox.net>
Date:   Fri, 13 Nov 2020 16:33:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <63870297-fffe-f01e-9747-219b63c5d7f4@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25987/Fri Nov 13 14:19:33 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/13/20 4:18 AM, Yonghong Song wrote:
> 
> 
> On 11/12/20 9:19 AM, KP Singh wrote:
>> From: KP Singh <kpsingh@google.com>
>>
>> Sleepable hooks are never called from an NMI/interrupt context, so it is
>> safe to use the bpf_d_path helper in LSM programs attaching to these
>> hooks.
>>
>> The helper is not restricted to sleepable programs and merely uses the
>> list of sleeable hooks as the initial subset of LSM hooks where it can
> 
> sleeable => sleepable
> 
> probably not need to resend if no other major changes. The maintainer
> can just fix it up before merging.

Did while rebasing & applying, thanks everyone!

>> be used.
>>
>> Signed-off-by: KP Singh <kpsingh@google.com>
> 
> Acked-by: Yonghong Song <yhs@fb.com>

