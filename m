Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 148C038201
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2019 02:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfFGAAX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 20:00:23 -0400
Received: from www62.your-server.de ([213.133.104.62]:49298 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfFGAAX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 20:00:23 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hZ2Iv-00063l-2q; Fri, 07 Jun 2019 02:00:21 +0200
Received: from [178.197.249.21] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hZ2Iu-0008B5-Rw; Fri, 07 Jun 2019 02:00:20 +0200
Subject: Re: [PATCH bpf-next] bpf: allow CGROUP_SKB programs to use
 bpf_skb_cgroup_id() helper
To:     Roman Gushchin <guro@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Yonghong Song <yhs@fb.com>
References: <20190606203012.130071-1-guro@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a9a8d1ec-f0ce-6cde-31f1-9003c6b2c64a@iogearbox.net>
Date:   Fri, 7 Jun 2019 02:00:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190606203012.130071-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25472/Thu Jun  6 10:09:59 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/06/2019 10:30 PM, Roman Gushchin wrote:
> Currently bpf_skb_cgroup_id() is not supported for CGROUP_SKB
> programs. An attempt to load such a program generates an error
> like this:
> 
>     libbpf:
>     0: (b7) r6 = 0
>     ...
>     9: (85) call bpf_skb_cgroup_id#79
>     unknown func bpf_skb_cgroup_id#79
> 
> There are no particular reasons for denying it, and we have some
> use cases where it might be useful.
> 
> So let's add it to the list of allowed helpers.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>

Applied, thanks!
