Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70751B2EED
	for <lists+bpf@lfdr.de>; Tue, 21 Apr 2020 20:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDUSUs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Apr 2020 14:20:48 -0400
Received: from www62.your-server.de ([213.133.104.62]:43680 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgDUSUr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Apr 2020 14:20:47 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jQxVk-0001Ee-B1; Tue, 21 Apr 2020 20:20:44 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jQxVj-000Bte-VX; Tue, 21 Apr 2020 20:20:44 +0200
Subject: Re: [PATCH stable 4.19] bpf: fix buggy r0 retval refinement for
 tracing helpers
To:     Lorenzo Fontana <fontanalorenz@gmail.com>
Cc:     gregkh@linuxfoundation.org, alexei.starovoitov@gmail.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, jannh@google.com,
        leodidonato@gmail.com, yhs@fb.com, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
References: <20200421125822.14073-1-daniel@iogearbox.net>
 <20200421163100.GA2792583@gallifrey>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <06a1ce83-ccf2-b3fe-9d05-ee76377578af@iogearbox.net>
Date:   Tue, 21 Apr 2020 20:20:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200421163100.GA2792583@gallifrey>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25789/Tue Apr 21 13:55:14 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/21/20 6:31 PM, Lorenzo Fontana wrote:
[...]
> Hi Daniel,
> Leonardo and I applied this on top of 8e2406c85187 and our old probe works as
> expected, as well as the new one.
> We produced a dot graph [0] of the in memory xlated representation [1], it clearly
> shows that this patch solves the bug. A rendered [2] version is
> available for the lazy.

Perfect, thanks for double-checking!

> So, Daniel please add a Tested-by for each one of us.

Here we go:

Tested-by: Lorenzo Fontana <fontanalorenz@gmail.com>
Tested-by: Leonardo Di Donato <leodidonato@gmail.com>

> Thanks Daniel!
> Lorenzo and Leonardo
> 
> [0] https://fs.fntlnz.wtf/kernel/bpf-retval-refinement-4-19/prog.dot
> [1] https://fs.fntlnz.wtf/kernel/bpf-retval-refinement-4-19/xlated.txt
> [2] https://fs.fntlnz.wtf/kernel/bpf-retval-refinement-4-19/render.png
> 

