Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048102D4620
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 16:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbgLIPwy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 10:52:54 -0500
Received: from mx4.wp.pl ([212.77.101.12]:37585 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbgLIPwt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 10:52:49 -0500
Received: (wp-smtpd smtp.wp.pl 24471 invoked from network); 9 Dec 2020 16:51:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1607529109; bh=3FjT/q8mbkb2XyA2MEM4/BuPSHX2DrgXduiPY1UbFxg=;
          h=From:To:Cc:Subject;
          b=aWOibTlM23BJzFKeIxtiUyvmCh0s2p+MN1SBv4fVFYIcEJpBdr9w5K5HK8rV5OPG4
           PJtm+eF0dsMxueE/FAOoPaxZ6DKQqbQbIViVOjGa83n76IJxvpDoB0UD/+fuRO/Wq0
           iII6F1UvtKgqU0GWUujmzPzpXQ8pWV16qfwLJXv4=
Received: from ip4-46-39-164-203.cust.nbox.cz (HELO localhost) (stf_xl@wp.pl@[46.39.164.203])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <willy@infradead.org>; 9 Dec 2020 16:51:49 +0100
Date:   Wed, 9 Dec 2020 16:51:48 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Justin Forbes <jmforbes@linuxtx.org>,
        bpf <bpf@vger.kernel.org>, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] mm/filemap: add static for function
 __add_to_page_cache_locked
Message-ID: <20201209155148.GA5552@wp.pl>
References: <20201110115037.f6a53faec8d65782ab65d8b4@linux-foundation.org>
 <ddca2a9e-ed89-5dec-b1af-4f2fd2c99b57@linux.alibaba.com>
 <20201207081556.pwxmhgdxayzbofpi@lion.mk-sys.cz>
 <CAFxkdApgQ4RCt-J43cK4_128pXr=Xn5jw+q0kOaP-TYufk_tPA@mail.gmail.com>
 <CAADnVQK-EsdBohcVSaK+zaP9XuPZTBkGbQpkeYcrC9BzoPQUuw@mail.gmail.com>
 <20201207225351.2liywqaxxtuezzw3@lion.mk-sys.cz>
 <CAADnVQJARx6sKF-30YsabCd1W+MFDMmfxY+2u0Pm40RHHHQZ6Q@mail.gmail.com>
 <CAADnVQJ6tmzBXvtroBuEH6QA0H+q7yaSKxrVvVxhqr3KBZdEXg@mail.gmail.com>
 <20201209144628.GA3474@wp.pl>
 <20201209150826.GP7338@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209150826.GP7338@casper.infradead.org>
X-WP-MailID: 729eafaf8c9901c095d530a4dd2b5e0e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [4aPk]                               
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 09, 2020 at 03:08:26PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 09, 2020 at 03:46:28PM +0100, Stanislaw Gruszka wrote:
> > At this point of release cycle we should probably go with revert,
> > but I think the main problem is that BPF and ERROR_INJECTION use
> > function that is not intended to be used externally. For external users
> > add_to_page_cache_lru() and add_to_page_cache_locked() are exported
> > and I think those should be used (see the patch below).
> 
> FWIW, I intend to do some consolidation/renaming in this area.  I
> trust that will not be a problem?

If it does not break anything, it will be not a problem ;-)

It's possible that __add_to_page_cache_locked() can be a global symbol
with add_to_page_cache_lru() + add_to_page_cache_locked() being just
static/inline wrappers around it.

Stanislaw
