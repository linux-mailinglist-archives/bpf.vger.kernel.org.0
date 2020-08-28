Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D415A2559E2
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 14:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgH1MPO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 08:15:14 -0400
Received: from www62.your-server.de ([213.133.104.62]:39342 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgH1MO7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 08:14:59 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kBdHT-0006Rt-Ok; Fri, 28 Aug 2020 14:14:55 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kBdHT-00043S-IQ; Fri, 28 Aug 2020 14:14:55 +0200
Subject: Re: [PATCH] tools build feature: cleanup feature files on make clean
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
References: <159851841661.1072907.13770213104521805592.stgit@firesoul>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <25774c26-6d87-9060-3871-d83c582746b8@iogearbox.net>
Date:   Fri, 28 Aug 2020 14:14:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <159851841661.1072907.13770213104521805592.stgit@firesoul>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25912/Thu Aug 27 15:16:21 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/27/20 10:53 AM, Jesper Dangaard Brouer wrote:
> The system for "Auto-detecting system features" located under
> tools/build/ are (currently) used by perf, libbpf and bpftool. It can
> contain stalled feature detection files, which are not cleaned up by
> libbpf and bpftool on make clean (side-note: perf tool is correct).
> 
> Fix this by making the users invoke the make clean target.
> 
> Some details about the changes. The libbpf Makefile already had a
> clean-config target (which seems to be copy-pasted from perf), but this
> target was not "connected" (a make dependency) to clean target. Choose
> not to rename target as someone might be using it. Did change the output
> from "CLEAN config" to "CLEAN feature-detect", to make it more clear
> what happens.
> 
> This is related to the complaint and troubleshooting in link:
> Link: https://lore.kernel.org/lkml/20200818122007.2d1cfe2d@carbon/
> 
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>

Applied to bpf-next, thanks!
