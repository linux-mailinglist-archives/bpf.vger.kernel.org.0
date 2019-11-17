Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D754FFFB8A
	for <lists+bpf@lfdr.de>; Sun, 17 Nov 2019 21:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfKQUGO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 17 Nov 2019 15:06:14 -0500
Received: from www62.your-server.de ([213.133.104.62]:54514 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfKQUGN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 17 Nov 2019 15:06:13 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iWQo5-0001A5-7p; Sun, 17 Nov 2019 21:06:01 +0100
Received: from [178.197.248.45] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1iWQo4-000X9C-UM; Sun, 17 Nov 2019 21:06:00 +0100
Subject: Re: pull-request: bpf 2019-11-15
To:     David Miller <davem@davemloft.net>
Cc:     jakub.kicinski@netronome.com, ast@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20191115221855.27728-1-daniel@iogearbox.net>
 <20191115.150906.1714221627473925259.davem@davemloft.net>
 <aa01a6e5-e155-af3d-5b74-77bff8d679ea@iogearbox.net>
 <20191117.102710.2088931518235560478.davem@davemloft.net>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a3884f35-af1b-7c9d-4448-c560e7b97cb1@iogearbox.net>
Date:   Sun, 17 Nov 2019 21:05:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191117.102710.2088931518235560478.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25636/Sun Nov 17 10:57:06 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/17/19 7:27 PM, David Miller wrote:
> From: Daniel Borkmann <daniel@iogearbox.net>
> Date: Sun, 17 Nov 2019 13:25:24 +0100
> 
>> Do you have a chance to double check, seems the PR did not yet get
>> pushed
>> out to the net tree [0,1].
> 
> I don't know how that happened, sorry.
> 
> It should be there now :-/

Awesome, thanks a lot, no worries!

Best,
Daniel
