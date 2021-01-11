Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986782F17CF
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 15:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbhAKOOq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 09:14:46 -0500
Received: from www62.your-server.de ([213.133.104.62]:49476 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbhAKOOq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 09:14:46 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kyxxI-000GOk-Ds; Mon, 11 Jan 2021 15:14:00 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kyxxI-0000Y5-9c; Mon, 11 Jan 2021 15:14:00 +0100
Subject: Re: [PATCH bpf v1] Add `core_btf_path` to `bpf_object_open_opts` to
 pass BTF path from skeleton program
To:     Vamsi Kodavanty <vamsi@araalinetworks.com>, bpf@vger.kernel.org,
        andrii.nakryiko@gmail.com
References: <B8801F77-37E8-4EF8-8994-D366D48169A3@araalinetworks.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f5d58b88-cd96-4c78-ff22-4989c6b2ec96@iogearbox.net>
Date:   Mon, 11 Jan 2021 15:13:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <B8801F77-37E8-4EF8-8994-D366D48169A3@araalinetworks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26046/Mon Jan 11 13:34:14 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/9/21 3:36 AM, Vamsi Kodavanty wrote:
[...]
>       Please do take a look. Also, I am not sure what the procedure is for submitting patches/reviews.
> If anyone has any pointers to a webpage where this is described I can go through it. But, below are
> the proposed changes.

For submitting patches there is an official write-up here [0]. An example of a commit message
can be found here [1]. Please make sure to add your own Signed-off-by before officially submitting
the patch. If you are stuck somewhere please let us know so we can help.

Cheers,
Daniel

   [0] https://www.kernel.org/doc/html/latest/process/submitting-patches.html
   [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/patch/?id=e22d7f05e445165e58feddb4e40cc9c0f94453bc
