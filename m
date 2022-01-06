Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEA6486C6A
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 22:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244612AbiAFVqu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 16:46:50 -0500
Received: from www62.your-server.de ([213.133.104.62]:59720 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244595AbiAFVq3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 16:46:29 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1n5aaK-000DAv-QH; Thu, 06 Jan 2022 22:46:12 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1n5aaK-000Xvd-GZ; Thu, 06 Jan 2022 22:46:12 +0100
Subject: Re: [PATCH 00/13] powerpc/bpf: Some fixes and updates
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, ykaliuta@redhat.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        song@kernel.org, johan.almbladh@anyfinetworks.com,
        Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f4f3437d-084f-0858-8795-76e4a0fa5627@iogearbox.net>
Date:   Thu, 6 Jan 2022 22:46:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26414/Thu Jan  6 10:26:00 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Naveen,

On 1/6/22 12:45 PM, Naveen N. Rao wrote:
> A set of fixes and updates to powerpc BPF JIT:
> - Patches 1-3 fix issues with the existing powerpc JIT and are tagged
>    for -stable.
> - Patch 4 fixes a build issue with bpf selftests on powerpc.
> - Patches 5-9 handle some corner cases and make some small improvements.
> - Patches 10-13 optimize how function calls are handled in ppc64.
> 
> Patches 7 and 8 were previously posted, and while patch 7 has no
> changes, patch 8 has been reworked to handle BPF_EXIT differently.

Is the plan to route these via ppc trees? Fwiw, patch 1 and 4 look generic
and in general good to me, we could also take these two via bpf-next tree
given outside of arch/powerpc/? Whichever works best.

Thanks,
Daniel
