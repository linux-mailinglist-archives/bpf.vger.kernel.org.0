Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45152440C8
	for <lists+bpf@lfdr.de>; Thu, 13 Aug 2020 23:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHMVhU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Aug 2020 17:37:20 -0400
Received: from www62.your-server.de ([213.133.104.62]:47180 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgHMVhU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Aug 2020 17:37:20 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k6KuT-0007i3-RI; Thu, 13 Aug 2020 23:37:17 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k6KuT-0006hj-Mz; Thu, 13 Aug 2020 23:37:17 +0200
Subject: Re: [PATCH bpf] doc: Add link to bpf helpers man page
To:     Joe Stringer <joe@wand.net.nz>, bpf@vger.kernel.org
Cc:     ast@kernel.org
References: <20200813180807.2821735-1-joe@wand.net.nz>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7d5a8e3b-30da-2835-dab8-5e24aa440d8b@iogearbox.net>
Date:   Thu, 13 Aug 2020 23:37:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200813180807.2821735-1-joe@wand.net.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25901/Thu Aug 13 09:01:24 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/13/20 8:08 PM, Joe Stringer wrote:
> The bpf-helpers(7) man pages provide an invaluable description of the
> functions that an eBPF program can call at runtime. Link them here.
> 
> Signed-off-by: Joe Stringer <joe@wand.net.nz>

Applied, thanks! (I fixed up the newlines in this paragraph to make them
consistent with the rest of this doc.)
