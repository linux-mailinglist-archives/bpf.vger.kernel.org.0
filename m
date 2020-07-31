Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3DE23486D
	for <lists+bpf@lfdr.de>; Fri, 31 Jul 2020 17:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbgGaP1j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Jul 2020 11:27:39 -0400
Received: from www62.your-server.de ([213.133.104.62]:55894 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732564AbgGaP1h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:37 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k1Wwa-0006rA-2A; Fri, 31 Jul 2020 17:27:36 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k1WwZ-0008Gx-TF; Fri, 31 Jul 2020 17:27:35 +0200
Subject: Re: [PATCH bpf v2] libbpf: Fix register in PT_REGS MIPS macros
To:     Jerry Crunchtime <jerry.c.t@web.de>, bpf@vger.kernel.org
References: <43707d31-0210-e8f0-9226-1af140907641@web.de>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bd6052a0-73af-d774-55aa-4a85e2c41751@iogearbox.net>
Date:   Fri, 31 Jul 2020 17:27:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <43707d31-0210-e8f0-9226-1af140907641@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25889/Thu Jul 30 17:03:53 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/31/20 1:13 PM, Jerry Crunchtime wrote:
> v1 -> v2: Also fixed missed PT_REGS_RC_CORE macro
> 
> Hi.
> 
> The o32, n32 and n64 calling conventions require the return
> value to be stored in $v0 which maps to $2 register, i.e.,
> the register 2.
> 
> Fixes: c1932cd ("bpf: Add MIPS support to samples/bpf.")
> Signed-off-by: Jerry Crunchtime <jerry.c.t@web.de>

Patch was whitespace damaged, but fixed it up manually this
time & applied, thanks!
