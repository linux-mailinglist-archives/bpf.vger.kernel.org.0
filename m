Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63DC1F6F9C
	for <lists+bpf@lfdr.de>; Thu, 11 Jun 2020 23:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgFKVzG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Jun 2020 17:55:06 -0400
Received: from www62.your-server.de ([213.133.104.62]:44240 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgFKVzG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Jun 2020 17:55:06 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jjVA8-0005fD-AK; Thu, 11 Jun 2020 23:55:04 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jjVA8-000AFI-2U; Thu, 11 Jun 2020 23:55:04 +0200
Subject: Re: [PATCH] tools, bpftool: Exit on error in function codegen
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
References: <20200610130807.21497-1-tklauser@distanz.ch>
 <20200611103341.21532-1-tklauser@distanz.ch>
 <CAEf4BzaHaHKSVuNt7kgFm53-byDro1ijADD+Q-i39yMfT9pT-g@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9761fb51-461e-1760-b357-a4865cd583ac@iogearbox.net>
Date:   Thu, 11 Jun 2020 23:55:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAEf4BzaHaHKSVuNt7kgFm53-byDro1ijADD+Q-i39yMfT9pT-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25840/Thu Jun 11 14:52:31 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/11/20 8:02 PM, Andrii Nakryiko wrote:
> On Thu, Jun 11, 2020 at 3:33 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>>
>> Currently, the codegen function might fail and return an error. But its
>> callers continue without checking its return value. Since codegen can
>> fail only in the ounlikely case of the system running out of memory or
>> the static template being malformed, just exit(-1) directly from codegen
>> and make it void-returning.
>>
>> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
>> ---
> 
> LGTM. Thanks!
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Applied, thanks!
