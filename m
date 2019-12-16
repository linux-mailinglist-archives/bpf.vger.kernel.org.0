Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C21C120712
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2019 14:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfLPNZO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Dec 2019 08:25:14 -0500
Received: from www62.your-server.de ([213.133.104.62]:51114 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfLPNZO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Dec 2019 08:25:14 -0500
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1igqN6-0002sC-RQ; Mon, 16 Dec 2019 14:25:12 +0100
Date:   Mon, 16 Dec 2019 14:25:12 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Prashant Bhole <prashantbhole.linux@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] libbpf: fix build by renaming variables
Message-ID: <20191216132512.GD14887@linux.fritz.box>
References: <20191216082738.28421-1-prashantbhole.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191216082738.28421-1-prashantbhole.linux@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25665/Mon Dec 16 10:52:23 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 16, 2019 at 05:27:38PM +0900, Prashant Bhole wrote:
> In btf__align_of() variable name 't' is shadowed by inner block
> declaration of another variable with same name. Patch renames
> variables in order to fix it.
> 
>   CC       sharedobjs/btf.o
> btf.c: In function ‘btf__align_of’:
> btf.c:303:21: error: declaration of ‘t’ shadows a previous local [-Werror=shadow]
>   303 |   int i, align = 1, t;
>       |                     ^
> btf.c:283:25: note: shadowed declaration is here
>   283 |  const struct btf_type *t = btf__type_by_id(btf, id);
>       |
> 
> Fixes: 3d208f4ca111 ("libbpf: Expose btf__align_of() API")
> Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>

Applied, thanks!
