Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71C1219E7B
	for <lists+bpf@lfdr.de>; Thu,  9 Jul 2020 12:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgGIK6h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jul 2020 06:58:37 -0400
Received: from mail.katalix.com ([3.9.82.81]:33710 "EHLO mail.katalix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgGIK6g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jul 2020 06:58:36 -0400
Received: from localhost (unknown [IPv6:2a02:8010:6359:1:21b:21ff:fe6a:7e96])
        (Authenticated sender: james)
        by mail.katalix.com (Postfix) with ESMTPSA id 91EAE91533;
        Thu,  9 Jul 2020 11:58:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=katalix.com; s=mail;
        t=1594292313; bh=M42LuGOML2ltF7KHw5lwhmsnznXUYtYGge15d/m6rbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AEHTYoqeDYbSRuAAgOqgGlH9/Xq/97z71pNIfYDs7xNT2W2nUGRexwmovgtq4yzT+
         GEqArjYQEEpeQXQqsX/tlnSoi4ry8z7S4DU2pVpKiEEK39Wa/ZlsCZR3s+CBzSFCKh
         w1Tg6cONe4y2WQOWnzIlomlk2U41cQLZdYupcnGGT40vQmzszC4W/Imb6ft7t7pUv5
         5Wm8QPgHCvv/8s4u9pzACTKZKvizasoPnKhtOLU2mH5TEOGHLLS4szz9cMJO6QN0Yi
         TdXoOetN0ci2rw4ic3K9qVEJHv1rFhzEg741bwKuSJVSHrIey6Hpn4FMuyHCTKI0Ip
         I/cibIUVCBPFQ==
Date:   Thu, 9 Jul 2020 11:58:33 +0100
From:   James Chapman <jchapman@katalix.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 bpf 2/2] bpf: net: Avoid incorrect
 bpf_sk_reuseport_detach call
Message-ID: <20200709105833.GA1761@katalix.com>
References: <20200709061057.4018499-1-kafai@fb.com>
 <20200709061110.4019316-1-kafai@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709061110.4019316-1-kafai@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On  Wed, Jul 08, 2020 at 23:11:10 -0700, Martin KaFai Lau wrote:
> bpf_sk_reuseport_detach is currently called when sk->sk_user_data
> is not NULL.  It is incorrect because sk->sk_user_data may not be
> managed by the bpf's reuseport_array.  It has been reported in [1] that,
> the bpf_sk_reuseport_detach() which is called from udp_lib_unhash() has
> corrupted the sk_user_data managed by l2tp.
> 
> This patch solves it by using another bit (defined as SK_USER_DATA_BPF)
> of the sk_user_data pointer value.  It marks that a sk_user_data is
> managed/owned by BPF.

I have reservations about using a bit in sk_user_data to indicate
ownership of that pointer. But putting that aside, I confirm that the
patch fixes the problem.

Acked-by: James Chapman <jchapman@katalix.com>
Tested-by: James Chapman <jchapman@katalix.com>
Reported-by: syzbot+9f092552ba9a5efca5df@syzkaller.appspotmail.com
