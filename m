Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0BB5F341C
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 17:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388065AbfKGQGJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 11:06:09 -0500
Received: from www62.your-server.de ([213.133.104.62]:44280 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbfKGQGI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 11:06:08 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iSkIP-00060P-Jt; Thu, 07 Nov 2019 17:06:05 +0100
Received: from [178.197.249.41] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iSkIP-000Hvf-AC; Thu, 07 Nov 2019 17:06:05 +0100
Subject: Re: [PATCH bpf-next] s390/bpf: wrap JIT macro parameter usages in
 parentheses
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20191107113211.90105-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7cf71dda-a156-b496-69bb-f922739b92ae@iogearbox.net>
Date:   Thu, 7 Nov 2019 17:06:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191107113211.90105-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25626/Thu Nov  7 10:50:48 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/7/19 12:32 PM, Ilya Leoshkevich wrote:
> This change does not alter JIT behavior; it only makes it possible to
> safely invoke JIT macros with complex arguments in the future.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied, thanks!
