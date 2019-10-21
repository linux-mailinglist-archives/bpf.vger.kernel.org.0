Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA5BDDECDB
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2019 14:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfJUMzI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Oct 2019 08:55:08 -0400
Received: from www62.your-server.de ([213.133.104.62]:57666 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfJUMzI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Oct 2019 08:55:08 -0400
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iMXDF-00069R-Dr; Mon, 21 Oct 2019 14:55:05 +0200
Date:   Mon, 21 Oct 2019 14:55:05 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     pmladek@suse.com, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [bpf-next] tools lib bpf: Renaming pr_warning to pr_warn
Message-ID: <20191021125505.GL26267@pc-63.home>
References: <20191018185220.GE26267@pc-63.home>
 <20191021055532.185245-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021055532.185245-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25609/Mon Oct 21 10:57:36 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 21, 2019 at 01:55:32PM +0800, Kefeng Wang wrote:
> For kernel logging macro, pr_warning is completely removed and
> replaced by pr_warn, using pr_warn in tools lib bpf for symmetry
> to kernel logging macro, then we could drop pr_warning in the
> whole linux code.
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: bpf@vger.kernel.org
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Applied, thanks!
