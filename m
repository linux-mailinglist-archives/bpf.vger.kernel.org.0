Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 945FA126652
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 17:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfLSQBW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 11:01:22 -0500
Received: from www62.your-server.de ([213.133.104.62]:52996 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfLSQBW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 11:01:22 -0500
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1ihyEh-0001XW-QH; Thu, 19 Dec 2019 17:01:11 +0100
Date:   Thu, 19 Dec 2019 17:01:11 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix test_attach_probe
Message-ID: <20191219160111.GA8564@linux-9.fritz.box>
References: <20191219020442.1922617-1-ast@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219020442.1922617-1-ast@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25668/Thu Dec 19 10:55:58 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 18, 2019 at 06:04:42PM -0800, Alexei Starovoitov wrote:
> Fix two issues in test_attach_probe:
> 1. it was not able to parse /proc/self/maps beyond the first line,
>    since %s means parse string until white space.
> 2. offset has to be accounted for otherwise uprobed address is incorrect.
> 
> Fixes: 1e8611bbdfc9 ("selftests/bpf: add kprobe/uprobe selftests")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Applied, thanks!
