Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7892E1560EB
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2020 22:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgBGV4a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Feb 2020 16:56:30 -0500
Received: from www62.your-server.de ([213.133.104.62]:50976 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbgBGV4a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Feb 2020 16:56:30 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1j0Bbw-00070W-Ni; Fri, 07 Feb 2020 22:56:28 +0100
Received: from [85.7.42.192] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1j0Bbw-000Da0-FV; Fri, 07 Feb 2020 22:56:28 +0100
Subject: Re: [PATCH bpf 0/3] Fix locking order and synchronization on
 sockmap/sockhash tear-down
To:     Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>
References: <20200206111652.694507-1-jakub@cloudflare.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0ba3f880-78b8-9a24-74d1-d17b38ed5174@iogearbox.net>
Date:   Fri, 7 Feb 2020 22:56:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200206111652.694507-1-jakub@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25717/Fri Feb  7 12:45:15 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/6/20 12:16 PM, Jakub Sitnicki wrote:
> Couple of fixes that came from recent discussion [0] on commit
> 7e81a3530206 ("bpf: Sockmap, ensure sock lock held during tear down").

Series applied, thanks!
