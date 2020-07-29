Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399AD2327AB
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 00:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgG2Wok (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jul 2020 18:44:40 -0400
Received: from www62.your-server.de ([213.133.104.62]:49980 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgG2Wok (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jul 2020 18:44:40 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k0uoQ-0004rS-9f; Thu, 30 Jul 2020 00:44:38 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k0uoQ-000VoF-5O; Thu, 30 Jul 2020 00:44:38 +0200
Subject: Re: [PATCH bpf-next 1/2] bpf: add missing newline characters in
 verifier error messages
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, kernel-team@fb.com
References: <20200728221801.1090349-1-yhs@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4d356964-c843-d32d-47b5-2c819143dbda@iogearbox.net>
Date:   Thu, 30 Jul 2020 00:44:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200728221801.1090349-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25888/Wed Jul 29 16:57:45 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/29/20 12:18 AM, Yonghong Song wrote:
> Newline characters are added in two verifier error messages,
> refactored in Commit afbf21dce668 ("bpf: Support readonly/readwrite
> buffers in verifier"). This way, they do not mix with
> messages afterwards.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>

Both applied, thanks!
