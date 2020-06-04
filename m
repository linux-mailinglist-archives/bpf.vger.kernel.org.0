Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161D61EED74
	for <lists+bpf@lfdr.de>; Thu,  4 Jun 2020 23:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgFDVnd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Jun 2020 17:43:33 -0400
Received: from www62.your-server.de ([213.133.104.62]:51232 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgFDVnd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Jun 2020 17:43:33 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jgxe2-0007pu-Nn; Thu, 04 Jun 2020 23:43:26 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jgxe2-000OOD-Bz; Thu, 04 Jun 2020 23:43:26 +0200
Subject: Re: [PATCH v2 bpf-next] bpf: Fix an error code in check_btf_func()
To:     Song Liu <song@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <CAADnVQJPwtan12Htu-0VhvuC3M-o_kbnPpN=SXVC-amn9BcZCw@mail.gmail.com>
 <20200604085436.GA943001@mwanda>
 <CAPhsuW7BK+4sJ42YpseWkHf0brW65se5HkQCkq-ONHx--sW4iw@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1834d76c-dfff-20ca-370c-443f42968588@iogearbox.net>
Date:   Thu, 4 Jun 2020 23:43:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAPhsuW7BK+4sJ42YpseWkHf0brW65se5HkQCkq-ONHx--sW4iw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25833/Thu Jun  4 14:45:29 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/4/20 8:37 PM, Song Liu wrote:
> On Thu, Jun 4, 2020 at 1:55 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>
>> This code returns success if the "info_aux" allocation fails but it
>> should return -ENOMEM.
>>
>> Fixes: 8c1b6e69dcc1 ("bpf: Compare BTF types of functions arguments with actual types")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Acked-by: Song Liu <songliubraving@fb.com>

Applied, thanks (my personal style preference would have been v1, but fair enough).
