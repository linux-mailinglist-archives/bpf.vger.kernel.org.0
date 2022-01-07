Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B4F48755D
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 11:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbiAGKWF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 05:22:05 -0500
Received: from www62.your-server.de ([213.133.104.62]:42546 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbiAGKWF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jan 2022 05:22:05 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1n5mNj-000D7w-Ok; Fri, 07 Jan 2022 11:21:59 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1n5mNj-000VjQ-EM; Fri, 07 Jan 2022 11:21:59 +0100
Subject: Re: [PATCH 01/13] bpf: Guard against accessing NULL pt_regs in
 bpf_get_task_stack()
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, ykaliuta@redhat.com,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        song@kernel.org, johan.almbladh@anyfinetworks.com,
        Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
 <d5ef83c361cc255494afd15ff1b4fb02a36e1dcf.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b15d77fb-4730-60ba-babe-b1c007be998b@iogearbox.net>
Date:   Fri, 7 Jan 2022 11:21:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d5ef83c361cc255494afd15ff1b4fb02a36e1dcf.1641468127.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26415/Fri Jan  7 10:26:59 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/6/22 12:45 PM, Naveen N. Rao wrote:
> task_pt_regs() can return NULL on powerpc for kernel threads. This is
> then used in __bpf_get_stack() to check for user mode, resulting in a
> kernel oops. Guard against this by checking return value of
> task_pt_regs() before trying to obtain the call chain.
> 
> Fixes: fa28dcb82a38f8 ("bpf: Introduce helper bpf_get_task_stack()")
> Cc: stable@vger.kernel.org # v5.9+
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
