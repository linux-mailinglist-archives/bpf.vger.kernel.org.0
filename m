Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4068A261
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2019 17:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfHLPgA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Aug 2019 11:36:00 -0400
Received: from www62.your-server.de ([213.133.104.62]:40844 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfHLPgA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Aug 2019 11:36:00 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hxCMW-0004cU-4Y; Mon, 12 Aug 2019 17:35:56 +0200
Received: from [178.193.45.231] (helo=pc-63.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hxCMV-000URR-Uv; Mon, 12 Aug 2019 17:35:55 +0200
Subject: Re: Sending s390 eBPF JIT patches via bpf@vger.kernel.org
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
References: <5EC6E1F2-DBE4-42AB-B3F8-C6E78F52A7BF@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ca7328a6-679a-0de0-2cdd-8aa4bcd816f2@iogearbox.net>
Date:   Mon, 12 Aug 2019 17:35:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5EC6E1F2-DBE4-42AB-B3F8-C6E78F52A7BF@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25539/Mon Aug 12 10:15:24 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/12/19 5:30 PM, Ilya Leoshkevich wrote:
> Hello Daniel and Alexei,
> 
> We would like to send s390 eBPF JIT patches through your bpf tree (as
> opposed to our s390 tree), since even though they mostly deal with s390
> instruction set, we believe you might spot more potential issues than
> we do. We also hope that this would allow to identify potential
> conflicts with generic bpf changes earlier. Would that be OK?

Sounds good, this also aligns with pretty much all other JITs that patches
are routed via bpf/bpf-next.

Thanks,
Daniel
