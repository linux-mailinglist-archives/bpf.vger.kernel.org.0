Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E184C2C32C
	for <lists+bpf@lfdr.de>; Tue, 28 May 2019 11:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfE1J1f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 May 2019 05:27:35 -0400
Received: from www62.your-server.de ([213.133.104.62]:38400 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfE1J1f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 May 2019 05:27:35 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hVYOL-00081n-Pg; Tue, 28 May 2019 11:27:33 +0200
Received: from [178.197.249.12] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hVYOL-000WVB-J6; Tue, 28 May 2019 11:27:33 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: fail test_tunnel.sh if subtests
 fail
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org
References: <20190524222856.60646-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a95a2e81-aaa2-f990-303c-5eb5a4f75646@iogearbox.net>
Date:   Tue, 28 May 2019 11:27:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190524222856.60646-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25463/Tue May 28 09:57:22 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/25/2019 12:28 AM, Stanislav Fomichev wrote:
> Right now test_tunnel.sh always exits with success even if some
> of the subtests fail. Since the output is very verbose, it's
> hard to spot the issues with subtests. Let's fail the script
> if any subtest fails.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Applied, thanks!
