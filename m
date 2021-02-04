Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8EF30FF71
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 22:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbhBDVlU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 16:41:20 -0500
Received: from www62.your-server.de ([213.133.104.62]:41108 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhBDVlT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 16:41:19 -0500
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1l7mMc-0007kh-GO; Thu, 04 Feb 2021 22:40:34 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1l7mMc-000Ay5-BN; Thu, 04 Feb 2021 22:40:34 +0100
Subject: Re: [PATCH bpf-next] MAINTAINERS: BPF: Update web-page bpf.io to
 ebpf.io to avoid redirects
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
References: <1611825204-14887-1-git-send-email-yangtiezhu@loongson.cn>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f7ab5a24-a4c8-5da3-cc37-f6729a0ce1ca@iogearbox.net>
Date:   Thu, 4 Feb 2021 22:40:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1611825204-14887-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26070/Thu Feb  4 13:22:39 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/28/21 10:13 AM, Tiezhu Yang wrote:
> When I open https://bpf.io/, it seems too slow.
> 
> $ curl -s -S -L https://bpf.io/ -o /dev/null -w '%{time_redirect}\n'
> 2.373

Thanks for the report! I fixed some settings, should hopefully be better now within
next 24hrs; I do see minimal latency from my location, hopefully that'll do also on
your side..

(before) $ curl -s -S -L https://bpf.io/ -o /dev/null -w '%{time_redirect}\n'
0.548841

(after)  $ curl -s -S -L https://bpf.io/ -o /dev/null -w '%{time_redirect}\n'
0.105061
