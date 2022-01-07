Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAE448755C
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 11:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbiAGKVr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 05:21:47 -0500
Received: from www62.your-server.de ([213.133.104.62]:42484 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbiAGKVr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jan 2022 05:21:47 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1n5mNR-000D6H-Be; Fri, 07 Jan 2022 11:21:41 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1n5mNR-000Tka-2V; Fri, 07 Jan 2022 11:21:41 +0100
Subject: Re: [PATCH 04/13] tools/bpf: Rename 'struct event' to avoid naming
 conflict
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, ykaliuta@redhat.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        song@kernel.org, johan.almbladh@anyfinetworks.com,
        Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
 <c13cb3767d26257ca4387b8296b632b433a58db6.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8915d556-3bd4-d45c-ffb7-8ab0d498b9f7@iogearbox.net>
Date:   Fri, 7 Jan 2022 11:21:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c13cb3767d26257ca4387b8296b632b433a58db6.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26415/Fri Jan  7 10:26:59 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/6/22 12:45 PM, Naveen N. Rao wrote:
> On ppc64le, trying to build bpf seltests throws the below warning:
>    In file included from runqslower.bpf.c:5:
>    ./runqslower.h:7:8: error: redefinition of 'event'
>    struct event {
> 	 ^
>    /home/naveen/linux/tools/testing/selftests/bpf/tools/build/runqslower/vmlinux.h:156602:8:
>    note: previous definition is here
>    struct event {
> 	 ^
> 
> This happens since 'struct event' is defined in
> drivers/net/ethernet/alteon/acenic.h . Rename the one in runqslower to a
> more appropriate 'runq_event' to avoid the naming conflict.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
