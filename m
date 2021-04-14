Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECC635F06C
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 11:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhDNJHm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 05:07:42 -0400
Received: from mail.loongson.cn ([114.242.206.163]:49318 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232723AbhDNJHl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 05:07:41 -0400
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxLcjAsHZgVOsHAA--.11804S3;
        Wed, 14 Apr 2021 17:07:12 +0800 (CST)
Subject: Re: [PATCH bpf-next] MAINTAINERS: BPF: Update web-page bpf.io to
 ebpf.io to avoid redirects
To:     Daniel Borkmann <daniel@iogearbox.net>
References: <1611825204-14887-1-git-send-email-yangtiezhu@loongson.cn>
 <f7ab5a24-a4c8-5da3-cc37-f6729a0ce1ca@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <5ca44ee7-3bef-49cf-ec20-d26924e4a41a@loongson.cn>
Date:   Wed, 14 Apr 2021 17:07:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <f7ab5a24-a4c8-5da3-cc37-f6729a0ce1ca@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxLcjAsHZgVOsHAA--.11804S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZryUCry7AF1fuF4DKF1UGFg_yoW5Wr1DpF
        4ruF4xXrZYkrWUWFZ2kr4kWF13WF97JFWIv3srW34fA3s8Gwn5tr1kuw48Jwn5XF15tr1F
        vry0qrWDuF10qrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY
        02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUkeOJDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/05/2021 05:40 AM, Daniel Borkmann wrote:
> On 1/28/21 10:13 AM, Tiezhu Yang wrote:
>> When I open https://bpf.io/, it seems too slow.
>>
>> $ curl -s -S -L https://bpf.io/ -o /dev/null -w '%{time_redirect}\n'
>> 2.373
>
> Thanks for the report! I fixed some settings, should hopefully be 
> better now within
> next 24hrs; I do see minimal latency from my location, hopefully 
> that'll do also on
> your side..
>
> (before) $ curl -s -S -L https://bpf.io/ -o /dev/null -w 
> '%{time_redirect}\n'
> 0.548841
>
> (after)  $ curl -s -S -L https://bpf.io/ -o /dev/null -w 
> '%{time_redirect}\n'
> 0.105061

(1) bpf.io is very unstable:

[yangtiezhu@linux ~]$ curl -s -S -L https://bpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
22.309
[yangtiezhu@linux ~]$ curl -s -S -L https://bpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
2.092
[yangtiezhu@linux ~]$ curl -s -S -L https://bpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
22.578
[yangtiezhu@linux ~]$ curl -s -S -L https://bpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
2.086
[yangtiezhu@linux ~]$ curl -s -S -L https://bpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
1.836
[yangtiezhu@linux ~]$ curl -s -S -L https://bpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
32.363
[yangtiezhu@linux ~]$ curl -s -S -L https://bpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
2.087
[yangtiezhu@linux ~]$ curl -s -S -L https://bpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
0.000
curl: (6) Could not resolve host: bpf.io
[yangtiezhu@linux ~]$ curl -s -S -L https://bpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
7.292
[yangtiezhu@linux ~]$ curl -s -S -L https://bpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
0.000
curl: (6) Could not resolve host: bpf.io
[yangtiezhu@linux ~]$ curl -s -S -L https://bpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
17.381


[yangtiezhu@linux ~]$ curl -s -S -L https://bpf.io/ -o /dev/null -w 
'%{url_effective}\n'
https://ebpf.io/zh-cn/


(2) ebpf.io is relatively stable:

[yangtiezhu@linux ~]$ curl -s -S -L https://ebpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
1.011
[yangtiezhu@linux ~]$ curl -s -S -L https://ebpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
1.009
[yangtiezhu@linux ~]$ curl -s -S -L https://ebpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
1.016
[yangtiezhu@linux ~]$ curl -s -S -L https://ebpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
1.018
[yangtiezhu@linux ~]$ curl -s -S -L https://ebpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
1.013
[yangtiezhu@linux ~]$ curl -s -S -L https://ebpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
1.029
[yangtiezhu@linux ~]$ curl -s -S -L https://ebpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
1.034
[yangtiezhu@linux ~]$ curl -s -S -L https://ebpf.io/ -o /dev/null -w 
'%{time_redirect}\n'
1.015

