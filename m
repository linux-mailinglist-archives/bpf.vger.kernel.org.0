Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85703E502B
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 01:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbhHIXzi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 19:55:38 -0400
Received: from www62.your-server.de ([213.133.104.62]:41572 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhHIXzi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 19:55:38 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDF6x-000BJB-Pa; Tue, 10 Aug 2021 01:55:15 +0200
Received: from [85.5.47.65] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mDF6x-00072s-Kq; Tue, 10 Aug 2021 01:55:15 +0200
Subject: Re: [PATCH bpf-next 4/5] Display test number when listing test names
To:     Yucong Sun <fallentree@fb.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, sunyucong@gmail.com
References: <20210809233633.973638-1-fallentree@fb.com>
 <20210809233633.973638-4-fallentree@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9d7cf6ad-00ee-0ad0-99c9-04eb8ef4896c@iogearbox.net>
Date:   Tue, 10 Aug 2021 01:55:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210809233633.973638-4-fallentree@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.2/26258/Mon Aug  9 10:18:46 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Yucong,

thanks for your patches!

On 8/10/21 1:36 AM, Yucong Sun wrote:
> ---

Please make sure all of your patches have proper Signed-off-by and at least a
minimal commit message (instead of empty one).

Thanks,
Daniel

>   tools/testing/selftests/bpf/test_progs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index 82d012671552..5cc808992b00 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -867,7 +867,8 @@ int main(int argc, char **argv)
>   		}
>   
>   		if (env.list_test_names) {
> -			fprintf(env.stdout, "%s\n", test->test_name);
> +			fprintf(env.stdout, "# %d %s\n",
> +				test->test_num, test->test_name);
>   			env.succ_cnt++;
>   			continue;
>   		}
> 

