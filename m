Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95D6466FA3
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2019 15:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfGLNIQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jul 2019 09:08:16 -0400
Received: from www62.your-server.de ([213.133.104.62]:50902 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfGLNIQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Jul 2019 09:08:16 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hlvHa-0005ix-Ck; Fri, 12 Jul 2019 15:08:14 +0200
Received: from [2a02:1205:5069:fce0:c5f9:cd68:79d4:446d] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hlvHa-000F1L-5i; Fri, 12 Jul 2019 15:08:14 +0200
Subject: Re: [PATCH v2 bpf] selftests/bpf: fix bpf_target_sparc check
To:     Ilya Leoshkevich <iii@linux.ibm.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     andrii.nakryiko@gmail.com
References: <20190710115654.44841-1-iii@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <35c7f55e-d74d-d408-e444-8b87cc37e249@iogearbox.net>
Date:   Fri, 12 Jul 2019 15:08:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190710115654.44841-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25508/Fri Jul 12 10:10:04 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/10/2019 01:56 PM, Ilya Leoshkevich wrote:
> bpf_helpers.h fails to compile on sparc: the code should be checking
> for defined(bpf_target_sparc), but checks simply for bpf_target_sparc.
> 
> Also change #ifdef bpf_target_powerpc to #if defined() for consistency.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied, thanks!
