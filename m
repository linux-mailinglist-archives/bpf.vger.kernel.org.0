Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B4025C94C
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgICTUl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Sep 2020 15:20:41 -0400
Received: from www62.your-server.de ([213.133.104.62]:52030 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgICTUl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Sep 2020 15:20:41 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kDumi-0007YF-3R; Thu, 03 Sep 2020 21:20:36 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kDumh-000DXn-UD; Thu, 03 Sep 2020 21:20:35 +0200
Subject: Re: [PATCH] tools build feature: cleanup feature files on make clean
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
References: <159851841661.1072907.13770213104521805592.stgit@firesoul>
 <20200903190350.GI3495158@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <eb3ad60a-68be-f350-9597-b999edae5244@iogearbox.net>
Date:   Thu, 3 Sep 2020 21:20:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200903190350.GI3495158@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25919/Thu Sep  3 15:39:22 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Arnaldo,

On 9/3/20 9:03 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 27, 2020 at 10:53:36AM +0200, Jesper Dangaard Brouer escreveu:
>> The system for "Auto-detecting system features" located under
>> tools/build/ are (currently) used by perf, libbpf and bpftool. It can
>> contain stalled feature detection files, which are not cleaned up by
>> libbpf and bpftool on make clean (side-note: perf tool is correct).
>>
>> Fix this by making the users invoke the make clean target.
>>
>> Some details about the changes. The libbpf Makefile already had a
>> clean-config target (which seems to be copy-pasted from perf), but this
>> target was not "connected" (a make dependency) to clean target. Choose
>> not to rename target as someone might be using it. Did change the output
>> from "CLEAN config" to "CLEAN feature-detect", to make it more clear
>> what happens.
> 
> Since this mostly touches BPF, should it go via the BPF tree?

Already applied roughly a week ago:

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=661b37cd437ef49cd28444f79b9b0c71ea76e8c8

Thanks,
Daniel
