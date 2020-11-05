Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604B92A8107
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 15:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgKEOfp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 09:35:45 -0500
Received: from www62.your-server.de ([213.133.104.62]:60618 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgKEOfp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 09:35:45 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kagMZ-00037S-Ph; Thu, 05 Nov 2020 15:35:43 +0100
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kagMZ-000MrI-KZ; Thu, 05 Nov 2020 15:35:43 +0100
Subject: Re: [PATCH bpf-next] Update perf ring buffer to prevent corruption
To:     KP Singh <kpsingh@chromium.org>,
        Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@google.com>
References: <VI1PR8303MB00802B04481D53CBBEBCF0DDFBEE0@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
 <CACYkzJ7uUb97TeWi+r8zLAOMUMk8z_zVvQ=c7p8z2gAP0X5C3A@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <81be3d16-8538-f6d6-180f-ff401df1d915@iogearbox.net>
Date:   Thu, 5 Nov 2020 15:35:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACYkzJ7uUb97TeWi+r8zLAOMUMk8z_zVvQ=c7p8z2gAP0X5C3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25978/Wed Nov  4 14:18:13 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/5/20 12:21 PM, KP Singh wrote:
> On Thu, Nov 5, 2020 at 11:41 AM Kevin Sheldrake
> <Kevin.Sheldrake@microsoft.com> wrote:
>>
>>  From 8425426d0fb256acf7c2e50f0aa642450adc366a Mon Sep 17 00:00:00 2001
>> From: Kevin Sheldrake <kevin.sheldrake@microsoft.com>
>> Date: Wed, 4 Nov 2020 15:42:54 +0000
>> Subject: [PATCH] Update perf ring buffer to prevent corruption from
>>   bpf_perf_output_event()
>>
>> The bpf_perf_output_event() helper takes a sample size parameter of u64, but
>> the underlying perf ring buffer uses a u16 internally. This 64KB maximum size
>> has to also accommodate a variable sized header. Failure to observe this
>> restriction can result in corruption of the perf ring buffer as samples
>> overlap.
>>
>> Truncate the raw sample type used by EBPF so that the total size of the
>> sample is < U16_MAX. The size parameter of the received sample will match the
>> size of the truncated sample, so users can be confident about how much data
>> was received.
> 
> I don't think truncation without any indication to the user is a good
> idea and can lead to other surprising problems
> (especially when the userspace expects the data to be in a certain format,
> which it almost always does).

+1

> I think the complete sample should be discarded if the size is too big and an
> E2BIG / or some error should be returned.

Right, just let the helper bail out early and then BPF prog would be able to react to
E2BIG exception internally (e.g. shrinking sample size, logging error, etc).

Thanks,
Daniel
