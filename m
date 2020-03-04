Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5FB17981E
	for <lists+bpf@lfdr.de>; Wed,  4 Mar 2020 19:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgCDSkI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Mar 2020 13:40:08 -0500
Received: from www62.your-server.de ([213.133.104.62]:58484 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbgCDSkI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Mar 2020 13:40:08 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1j9Yw9-0006kb-UP; Wed, 04 Mar 2020 19:40:05 +0100
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=linux.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1j9Yw9-000A66-LO; Wed, 04 Mar 2020 19:40:05 +0100
Subject: Re: [PATCH bpf-next v2] kbuild: Remove debug info from kallsyms
 linking
To:     Kees Cook <keescook@chromium.org>, bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-kbuild@vger.kernel.org, andriin@fb.com
References: <202003031814.4AEA3351@keescook>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9dd690e8-868d-d463-6b85-14270fdcc210@iogearbox.net>
Date:   Wed, 4 Mar 2020 19:40:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <202003031814.4AEA3351@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25741/Wed Mar  4 15:15:26 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/4/20 3:18 AM, Kees Cook wrote:
> When CONFIG_DEBUG_INFO is enabled, the two kallsyms linking steps spend
> time collecting and writing the dwarf sections to the temporary output
> files. kallsyms does not need this information, and leaving it off
> halves their linking time. This is especially noticeable without
> CONFIG_DEBUG_INFO_REDUCED. The BTF linking stage, however, does still
> need those details.
> 
> Refactor the BTF and kallsyms generation stages slightly for more
> regularized temporary names. Skip debug during kallsyms links.
> Additionally move "info BTF" to the correct place since commit
> 8959e39272d6 ("kbuild: Parameterize kallsyms generation and correct
> reporting"), which added "info LD ..." to vmlinux_link calls.
> 
> For a full debug info build with BTF, my link time goes from 1m06s to
> 0m54s, saving about 12 seconds, or 18%.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Applied, thanks!
