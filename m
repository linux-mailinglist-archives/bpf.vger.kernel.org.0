Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3838C197122
	for <lists+bpf@lfdr.de>; Mon, 30 Mar 2020 01:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgC2XrF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 29 Mar 2020 19:47:05 -0400
Received: from www62.your-server.de ([213.133.104.62]:60528 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgC2XrF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Mar 2020 19:47:05 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jIhds-0002or-KC; Mon, 30 Mar 2020 01:47:00 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jIhds-000Kii-7C; Mon, 30 Mar 2020 01:47:00 +0200
Subject: Re: [PATCH bpf-next v9 0/8] MAC and Audit policy using eBPF (KRSI)
To:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200329004356.27286-1-kpsingh@chromium.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <766930a0-7aa5-c9f1-75e4-0bb4e4486613@iogearbox.net>
Date:   Mon, 30 Mar 2020 01:46:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200329004356.27286-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25766/Sun Mar 29 15:08:22 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/29/20 1:43 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> # v8 -> v9
> 
>    https://lore.kernel.org/bpf/20200327192854.31150-1-kpsingh@chromium.org/
> 
> * Fixed a selftest crash when CONFIG_LSM doesn't have "bpf".
> * Added James' Ack.
> * Rebase.

Applied, thanks for all the hard work!
