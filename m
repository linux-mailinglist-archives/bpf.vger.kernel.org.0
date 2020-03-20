Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C518D9B2
	for <lists+bpf@lfdr.de>; Fri, 20 Mar 2020 21:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgCTUtp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Mar 2020 16:49:45 -0400
Received: from www62.your-server.de ([213.133.104.62]:46354 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgCTUtp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Mar 2020 16:49:45 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jFOaN-0002Jt-PK; Fri, 20 Mar 2020 21:49:43 +0100
Received: from [85.7.42.192] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jFOaN-000U82-Ic; Fri, 20 Mar 2020 21:49:43 +0100
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix mix of tabs and spaces
To:     Bill Wendling <morbo@google.com>, bpf@vger.kernel.org
Cc:     sdf@google.com, gthelen@google.com
References: <20200320201510.217169-1-morbo@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1013bd58-be23-1fe3-2b93-b3c51489e831@iogearbox.net>
Date:   Fri, 20 Mar 2020 21:49:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200320201510.217169-1-morbo@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25757/Fri Mar 20 14:13:59 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/20/20 9:15 PM, Bill Wendling wrote:
> Clang's -Wmisleading-indentation warns about misleading indentations if
> there's a mixture of spaces and tabs. Remove extraneous spaces.
> 
> Signed-off-by: Bill Wendling <morbo@google.com>

Applied, thanks!
