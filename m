Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1661E17CF
	for <lists+bpf@lfdr.de>; Tue, 26 May 2020 00:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgEYWTC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 May 2020 18:19:02 -0400
Received: from www62.your-server.de ([213.133.104.62]:51866 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgEYWTB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 May 2020 18:19:01 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jdLQx-0002J5-Jr; Tue, 26 May 2020 00:18:59 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jdLQx-0007lt-DP; Tue, 26 May 2020 00:18:59 +0200
Subject: Re: [PATCH] bpftool: print correct error message when failing to load
 BTF
To:     Tobias Klauser <tklauser@distanz.ch>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org
References: <20200525135421.4154-1-tklauser@distanz.ch>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0cb5ba79-13ae-fedc-2c91-ad61dcac1255@iogearbox.net>
Date:   Tue, 26 May 2020 00:18:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200525135421.4154-1-tklauser@distanz.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25823/Mon May 25 14:23:53 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/25/20 3:54 PM, Tobias Klauser wrote:
> btf__parse_raw and btf__parse_elf return negative error numbers wrapped
> in an ERR_PTR, so the extracted value needs to be negated before passing
> them to strerror which expects a positive error number.
> 
> Before:
>    Error: failed to load BTF from .../vmlinux: Unknown error -2
> 
> After:
>    Error: failed to load BTF from .../vmlinux: No such file or directory
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied, thanks!
