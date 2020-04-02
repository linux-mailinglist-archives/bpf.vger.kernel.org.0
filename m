Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6CE19CD0E
	for <lists+bpf@lfdr.de>; Fri,  3 Apr 2020 00:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389034AbgDBWuE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 18:50:04 -0400
Received: from www62.your-server.de ([213.133.104.62]:34828 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387919AbgDBWuE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 18:50:04 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jK8et-0004Gd-BY; Fri, 03 Apr 2020 00:49:59 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jK8es-000S0u-Vb; Fri, 03 Apr 2020 00:49:59 +0200
Subject: Re: [PATCH v5 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
To:     Slava Bacherikov <slava@bacher09.org>, andriin@fb.com
Cc:     keescook@chromium.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, jannh@google.com,
        alexei.starovoitov@gmail.com, kernel-hardening@lists.openwall.com,
        liuyd.fnst@cn.fujitsu.com, kpsingh@google.com
References: <202004021328.E6161480@keescook>
 <20200402204138.408021-1-slava@bacher09.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f55123e4-4034-b22a-a509-4ddf40f1ca22@iogearbox.net>
Date:   Fri, 3 Apr 2020 00:49:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200402204138.408021-1-slava@bacher09.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25770/Thu Apr  2 14:58:54 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/2/20 10:41 PM, Slava Bacherikov wrote:
> Currently turning on DEBUG_INFO_SPLIT when DEBUG_INFO_BTF is also
> enabled will produce invalid btf file, since gen_btf function in
> link-vmlinux.sh script doesn't handle *.dwo files.
> 
> Enabling DEBUG_INFO_REDUCED will also produce invalid btf file, and
> using GCC_PLUGIN_RANDSTRUCT with BTF makes no sense.
> 
> Signed-off-by: Slava Bacherikov <slava@bacher09.org>
> Reported-by: Jann Horn <jannh@google.com>
> Reported-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
> Acked-by: KP Singh <kpsingh@google.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for vmlinux")

Applied, thanks!
