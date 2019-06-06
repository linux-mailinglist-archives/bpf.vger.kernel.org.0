Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38732368B2
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 02:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfFFASG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jun 2019 20:18:06 -0400
Received: from www62.your-server.de ([213.133.104.62]:34756 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFFASG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jun 2019 20:18:06 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1hYg6X-0006XH-9e; Thu, 06 Jun 2019 02:18:05 +0200
Received: from [178.197.249.21] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hYg6X-000G5n-2O; Thu, 06 Jun 2019 02:18:05 +0200
Subject: Re: [PATCH bpf-next v2] samples: bpf: print a warning about
 headers_install
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        alexei.starovoitov@gmail.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
References: <20190605234722.2291-1-jakub.kicinski@netronome.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <aacd31df-0b4b-a7ec-62b2-18c098a320d6@iogearbox.net>
Date:   Thu, 6 Jun 2019 02:18:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190605234722.2291-1-jakub.kicinski@netronome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25471/Wed Jun  5 10:12:21 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/06/2019 01:47 AM, Jakub Kicinski wrote:
> It seems like periodically someone posts patches to "fix"
> header includes.  The issue is that samples expect the
> include path to have the uAPI headers (from usr/) first,
> and then tools/ headers, so that locally installed uAPI
> headers take precedence.  This means that if users didn't
> run headers_install they will see all sort of strange
> compilation errors, e.g.:
> 
>   HOSTCC  samples/bpf/test_lru_dist
>   samples/bpf/test_lru_dist.c:39:8: error: redefinition of ‘struct list_head’
>    struct list_head {
>           ^~~~~~~~~
>    In file included from samples/bpf/test_lru_dist.c:9:0:
>    ../tools/include/linux/types.h:69:8: note: originally defined here
>     struct list_head {
>            ^~~~~~~~~
> 
> Try to detect this situation, and print a helpful warning.
> 
> v2: just use HOSTCC (Jiong).
> 
> Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>

Applied, thanks!
