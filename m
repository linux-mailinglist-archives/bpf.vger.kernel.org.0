Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955DBFE7C7
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2019 23:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfKOW3H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Nov 2019 17:29:07 -0500
Received: from www62.your-server.de ([213.133.104.62]:50646 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfKOW3H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Nov 2019 17:29:07 -0500
Received: from sslproxy01.your-server.de ([88.198.220.130])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iVk5Q-0007QK-HM; Fri, 15 Nov 2019 23:29:04 +0100
Received: from [178.197.248.45] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iVk5Q-0002Ah-3c; Fri, 15 Nov 2019 23:29:04 +0100
Subject: Re: [PATCH bpf-next v2] bpf: support doubleword alignment in
 bpf_jit_binary_alloc
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20191115123722.58462-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a87984a2-701c-6e50-308a-09e427a52dbc@iogearbox.net>
Date:   Fri, 15 Nov 2019 23:29:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191115123722.58462-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25634/Fri Nov 15 10:44:37 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/15/19 1:37 PM, Ilya Leoshkevich wrote:
> Currently passing alignment greater than 4 to bpf_jit_binary_alloc does
> not work: in such cases it silently aligns only to 4 bytes.
> 
> On s390, in order to load a constant from memory in a large (>512k) BPF
> program, one must use lgrl instruction, whose memory operand must be
> aligned on an 8-byte boundary.
> 
> This patch makes it possible to request 8-byte alignment from
> bpf_jit_binary_alloc, and also makes it issue a warning when an
> unsupported alignment is requested.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied, thanks!
