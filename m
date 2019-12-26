Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF1712AB65
	for <lists+bpf@lfdr.de>; Thu, 26 Dec 2019 10:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfLZJvd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Dec 2019 04:51:33 -0500
Received: from www62.your-server.de ([213.133.104.62]:37052 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfLZJvd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Dec 2019 04:51:33 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1ikPnm-0008B7-HS; Thu, 26 Dec 2019 10:51:30 +0100
Received: from [185.105.41.13] (helo=linux-9.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1ikPnm-00097Y-49; Thu, 26 Dec 2019 10:51:30 +0100
Subject: Re: [PATCH v2 bpf-next] bpf: Print error message for bpftool cgroup
 show
To:     Hechao Li <hechaol@fb.com>, bpf@vger.kernel.org
Cc:     rdna@fb.com, ast@kernel.org, kernel-team@fb.com
References: <20191224011742.3714301-1-hechaol@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cc43e37a-2ac3-36fc-e18f-59d42b2e5d8f@iogearbox.net>
Date:   Thu, 26 Dec 2019 10:51:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191224011742.3714301-1-hechaol@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25674/Wed Dec 25 10:52:07 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/24/19 2:17 AM, Hechao Li wrote:
> Currently, when bpftool cgroup show <path> has an error, no error
> message is printed. This is confusing because the user may think the
> result is empty.
> 
> Before the change:
> 
> $ bpftool cgroup show /sys/fs/cgroup
> ID       AttachType      AttachFlags     Name
> $ echo $?
> 255
> 
> After the change:
> $ ./bpftool cgroup show /sys/fs/cgroup
> Error: can't query bpf programs attached to /sys/fs/cgroup: Operation
> not permitted
> 
> v2: Rename check_query_cgroup_progs to cgroup_has_attached_progs
> 
> Signed-off-by: Hechao Li <hechaol@fb.com>

Applied, thanks!
