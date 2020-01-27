Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7952B14A259
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 11:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgA0K5W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 05:57:22 -0500
Received: from www62.your-server.de ([213.133.104.62]:42842 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbgA0K5V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 05:57:21 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iw251-0006z7-Ia; Mon, 27 Jan 2020 11:57:19 +0100
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=linux-3.fritz.box)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1iw250-0009Lg-Ku; Mon, 27 Jan 2020 11:57:19 +0100
Subject: Re: [PATCH v2] map_seq_next should increase position index
To:     Vasily Averin <vvs@virtuozzo.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
References: <a17c846a-f957-1506-d397-bdc1ee957fab@iogearbox.net>
 <eca84fdd-c374-a154-d874-6c7b55fc3bc4@virtuozzo.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <69488537-7175-1607-f8fc-c8775b15e5c8@iogearbox.net>
Date:   Mon, 27 Jan 2020 11:57:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <eca84fdd-c374-a154-d874-6c7b55fc3bc4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25707/Sun Jan 26 12:40:28 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/25/20 10:10 AM, Vasily Averin wrote:
> v2: removed missed increment in end of function
> 
> if seq_file .next fuction does not change position index,
> read after some lseek can generate unexpected output.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=206283
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Applied, thanks!
