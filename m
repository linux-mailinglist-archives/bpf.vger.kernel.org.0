Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A6897E97
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2019 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfHUPWW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 11:22:22 -0400
Received: from www62.your-server.de ([213.133.104.62]:45296 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfHUPWW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 11:22:22 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i0SRG-0005Qb-Rr; Wed, 21 Aug 2019 17:22:18 +0200
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=pc-66.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i0SRG-00011k-MF; Wed, 21 Aug 2019 17:22:18 +0200
Subject: Re: [PATCH bpf-next] btf: do not use CONFIG_OUTPUT_FORMAT
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20190820112939.84249-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0c16ca75-1a8c-d8a5-e485-4bd9fc51dcd4@iogearbox.net>
Date:   Wed, 21 Aug 2019 17:22:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190820112939.84249-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25548/Wed Aug 21 10:27:18 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/20/19 1:29 PM, Ilya Leoshkevich wrote:
> Building s390 kernel with CONFIG_DEBUG_INFO_BTF fails, because
> CONFIG_OUTPUT_FORMAT is not defined. As a matter of fact, this variable
> appears to be x86-only, so other arches might be affected as well.
> 
> Fix by obtaining this value from objdump output, just like it's already
> done for bin_arch. The exact objdump invocation is "inspired" by
> arch/powerpc/boot/wrapper.
> 
> Also, use LANG=C for the existing bin_arch objdump invocation to avoid
> potential build issues on systems with non-English locale.
> 
> Fixes: 341dfcf8d78e ("btf: expose BTF info through sysfs")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

LGTM, applied, thanks!
