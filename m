Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B13A48AED2
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 14:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbiAKNsd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 08:48:33 -0500
Received: from www62.your-server.de ([213.133.104.62]:57856 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241004AbiAKNsc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jan 2022 08:48:32 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1n7HVm-0009LP-1m; Tue, 11 Jan 2022 14:48:30 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1n7HVl-000PVP-Ty; Tue, 11 Jan 2022 14:48:29 +0100
Subject: Re: [bug report] bpf: Make 32->64 bounds propagation slightly more
 robust
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     bpf@vger.kernel.org, john.fastabend@gmail.com
References: <20220111082054.GA20305@kili>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1941b7b2-beb7-ff3f-ee55-70b5d4e028df@iogearbox.net>
Date:   Tue, 11 Jan 2022 14:48:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220111082054.GA20305@kili>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26419/Tue Jan 11 10:24:18 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/11/22 9:20 AM, Dan Carpenter wrote:
> Hello Daniel Borkmann,

[+John]

> The patch e572ff80f05c: "bpf: Make 32->64 bounds propagation slightly
> more robust" from Dec 15, 2021, leads to the following Smatch static
> checker warning:
> 
> 	kernel/bpf/verifier.c:1412 __reg32_bound_s64()
> 	warn: always true condition '(a <= (((~0) >> 1))) => (s32min-s32max <= s32max)'
> 
> kernel/bpf/verifier.c
>    1410        static bool __reg32_bound_s64(s32 a)
>    1411        {
>    1412                return a >= 0 && a <= S32_MAX;
> 
> Obviously an s32 is going to be <= S32_MAX

It's aligned with similar helpers such as __reg64_bound_u32() / __reg64_bound_s32() and
when discussing we went for leaving this explicitly documented in here (aside being true).

>    1413        }
>    1414
>    1415        static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
>    1416        {
>    1417                reg->umin_value = reg->u32_min_value;
>    1418                reg->umax_value = reg->u32_max_value;
>    1419
>    1420                /* Attempt to pull 32-bit signed bounds into 64-bit bounds but must
>    1421                 * be positive otherwise set to worse case bounds and refine later
>    1422                 * from tnum.
>    1423                 */
>    1424                if (__reg32_bound_s64(reg->s32_min_value) &&
>    1425                    __reg32_bound_s64(reg->s32_max_value)) {
>    1426                        reg->smin_value = reg->s32_min_value;
>    1427                        reg->smax_value = reg->s32_max_value;
>    1428                } else {
>    1429                        reg->smin_value = 0;
>    1430                        reg->smax_value = U32_MAX;
> 
> Should this be S32_MAX instead of U32_MAX?

U32_MAX is correct here.

>    1431                }
>    1432        }
> 
> regards,
> dan carpenter
> 

