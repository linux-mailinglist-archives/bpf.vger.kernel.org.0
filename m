Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD231215F07
	for <lists+bpf@lfdr.de>; Mon,  6 Jul 2020 20:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgGFSvj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jul 2020 14:51:39 -0400
Received: from www62.your-server.de ([213.133.104.62]:48284 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbgGFSvj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jul 2020 14:51:39 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jsWDI-0004Mm-BM; Mon, 06 Jul 2020 20:51:36 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jsWDI-000Rya-20; Mon, 06 Jul 2020 20:51:36 +0200
Subject: Re: [PATCH] bpf: lsm: Disable or enable BPF LSM at boot time
To:     Lorenzo Fontana <fontanalorenz@gmail.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
References: <20200706165710.GA208695@gallifrey>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9268bd47-93db-1591-e224-8d3da333636e@iogearbox.net>
Date:   Mon, 6 Jul 2020 20:51:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200706165710.GA208695@gallifrey>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25865/Mon Jul  6 16:07:44 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/6/20 6:57 PM, Lorenzo Fontana wrote:
> This option adds a kernel parameter 'bpf_lsm',
> which allows the BPF LSM to be disabled at boot.
> The purpose of this option is to allow a single kernel
> image to be distributed with the BPF LSM built in,
> but not necessarily enabled.
> 
> Signed-off-by: Lorenzo Fontana <fontanalorenz@gmail.com>

Well, this explains what the patch is doing but not *why* you need it exactly.
Please explain your concrete use-case for this patch.

Thanks,
Daniel
