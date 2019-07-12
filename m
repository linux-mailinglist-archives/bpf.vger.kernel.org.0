Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE7366F9D
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2019 15:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfGLNHy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jul 2019 09:07:54 -0400
Received: from www62.your-server.de ([213.133.104.62]:50806 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbfGLNHy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Jul 2019 09:07:54 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hlvHE-0005gq-0r; Fri, 12 Jul 2019 15:07:52 +0200
Received: from [2a02:1205:5069:fce0:c5f9:cd68:79d4:446d] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hlvHD-000AsF-Om; Fri, 12 Jul 2019 15:07:51 +0200
Subject: Re: [PATCH bpf] xdp: fix potential deadlock on socket mutex
To:     Ilya Maximets <i.maximets@samsung.com>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        xdp-newbies@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>
References: <CGME20190708110350eucas1p16357da1f812ff8309b1edc98d4cdacc1@eucas1p1.samsung.com>
 <20190708110344.23278-1-i.maximets@samsung.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <93462d9f-dc37-fa5a-ae28-d5cad5aa2060@iogearbox.net>
Date:   Fri, 12 Jul 2019 15:07:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190708110344.23278-1-i.maximets@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25508/Fri Jul 12 10:10:04 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/08/2019 01:03 PM, Ilya Maximets wrote:
> There are 2 call chains:
> 
>   a) xsk_bind --> xdp_umem_assign_dev
>   b) unregister_netdevice_queue --> xsk_notifier
> 
> with the following locking order:
> 
>   a) xs->mutex --> rtnl_lock
>   b) rtnl_lock --> xdp.lock --> xs->mutex
> 
> Different order of taking 'xs->mutex' and 'rtnl_lock' could produce a
> deadlock here. Fix that by moving the 'rtnl_lock' before 'xs->lock' in
> the bind call chain (a).
> 
> Reported-by: syzbot+bf64ec93de836d7f4c2c@syzkaller.appspotmail.com
> Fixes: 455302d1c9ae ("xdp: fix hang while unregistering device bound to xdp socket")
> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>

Applied, thanks!
