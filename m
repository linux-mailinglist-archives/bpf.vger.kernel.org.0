Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 422E9C1D8D
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2019 10:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfI3I6S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Sep 2019 04:58:18 -0400
Received: from www62.your-server.de ([213.133.104.62]:59750 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729968AbfI3I6S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Sep 2019 04:58:18 -0400
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iErVY-0000oM-0o; Mon, 30 Sep 2019 10:58:16 +0200
Date:   Mon, 30 Sep 2019 10:58:15 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     ast@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools: bpf: Use !building_out_of_srctree to determine
 srctree
Message-ID: <20190930085815.GA7249@pc-66.home>
References: <20190927011344.4695-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927011344.4695-1-skhan@linuxfoundation.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25587/Sun Sep 29 10:25:24 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 26, 2019 at 07:13:44PM -0600, Shuah Khan wrote:
> make TARGETS=bpf kselftest fails with:
> 
> Makefile:127: tools/build/Makefile.include: No such file or directory
> 
> When the bpf tool make is invoked from tools Makefile, srctree is
> cleared and the current logic check for srctree equals to empty
> string to determine srctree location from CURDIR.
> 
> When the build in invoked from selftests/bpf Makefile, the srctree
> is set to "." and the same logic used for srctree equals to empty is
> needed to determine srctree.
> 
> Check building_out_of_srctree undefined as the condition for both
> cases to fix "make TARGETS=bpf kselftest" build failure.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Applied, thanks!
