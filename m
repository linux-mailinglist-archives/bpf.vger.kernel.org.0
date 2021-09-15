Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3EE40CE5F
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 22:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhIOUpU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 16:45:20 -0400
Received: from www62.your-server.de ([213.133.104.62]:35432 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhIOUpT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Sep 2021 16:45:19 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mQbl6-0006Ju-Lr; Wed, 15 Sep 2021 22:43:56 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mQbl6-000AG8-FC; Wed, 15 Sep 2021 22:43:56 +0200
Subject: Re: [PATCH bpf-next v2] bpf: update bpf_get_smp_processor_id()
 documentation
To:     Yonghong Song <yhs@fb.com>,
        Matteo Croce <mcroce@linux.microsoft.com>, bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20210914235400.59427-1-mcroce@linux.microsoft.com>
 <94b5dd50-ac04-de03-996b-899f7c19a6da@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a14362ef-eceb-b5ea-0b1c-3be37d2d9a3d@iogearbox.net>
Date:   Wed, 15 Sep 2021 22:43:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <94b5dd50-ac04-de03-996b-899f7c19a6da@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26295/Wed Sep 15 10:22:57 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/15/21 2:07 AM, Yonghong Song wrote:
> On 9/14/21 4:54 PM, Matteo Croce wrote:
>> From: Matteo Croce <mcroce@microsoft.com>
>>
>> BPF programs run with migration disabled regardless of preemption, as
>> they are protected by migrate_disable().
>> Update the documentation accordingly.
>>
>> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> 
> Acked-by: Yonghong Song <yhs@fb.com>

Applied, thanks & also copied this over to the tools/include/uapi/linux/bpf.h .
