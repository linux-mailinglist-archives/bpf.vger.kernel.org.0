Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4976E08E9
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 10:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDMI2k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 04:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDMI2j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 04:28:39 -0400
X-Greylist: delayed 146627 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Apr 2023 01:28:38 PDT
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4172697;
        Thu, 13 Apr 2023 01:28:38 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id B447C10006C; Thu, 13 Apr 2023 09:28:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1681374516; bh=/bsXNdu/Px3r4xTemFbWe8G4OVPi4dsB2MIJrch1uwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gFCcgMfz6a7VwtaL0Vy/FlNJOG9emcw5CvB+GLcPe1qgDQbAtoq1ubec9JakUsa7f
         KyL/lNbHYgMEAsbftRJEwousF4acaYL4j+ulcNwg4V9Mhd83xnODBSIo3VWnFxgX7d
         QEPJRqCnlqtC6cUBguppMWXSAfBv8VTZ47GL6Us29eKK3sxkkBa/2PLP7NH/snM9u/
         Wm97DtvhSzx0r+cM6pxHTtAD5y3QEsKwz3Bgvma519IzU03P5nQI3z2FUb0YDyAuS9
         TGuPwiphfPZkO9Q2pu+wpYgx0sDpiM/4lZ3enELPj6ay1ySevfjnfHjrbtd81ghepi
         WzeUt7/18rRrw==
Date:   Thu, 13 Apr 2023 09:28:36 +0100
From:   Sean Young <sean@mess.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH] bpf: lirc program type should not require SYS_CAP_ADMIN
Message-ID: <ZDe9ND/M4I9ll1xV@gofer.mess.org>
References: <ZDWAcN6wfeXzipHz@gofer.mess.org>
 <CAADnVQJ-zzzTxDj8_7WKW-o3BDsU=DNAnvSEZGNHswbhGA8xhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ-zzzTxDj8_7WKW-o3BDsU=DNAnvSEZGNHswbhGA8xhA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 04:14:05PM -0700, Alexei Starovoitov wrote:
> On Tue, Apr 11, 2023 at 8:45 AM Sean Young <sean@mess.org> wrote:
> >
> > Make it possible to load lirc program type with just CAP_BPF.
> 
> Is it safe?
> If the user can load with just CAP_BPF the FD to the prog and target_fd
> will allow attach as well.

Exactly, that's the $1m question of course. 

I think it's safe from a lirc perspective because you need to be able to
open the /dev/lirc0 device in the first place; if you can open it, you
alter all sorts of lirc receiving options already. Changing the IR protocol
decoder is no different in that perspective.

The other side of course, is it save to load a bpf lirc program as a normal
user. I don't see any issue with this; I guess this depends on whether the
subset of functions in lirc_mode2_func_proto() is safe. I am hoping that
the expert opinion everyone here can help answer that question.

Thanks,

Sean

> 
> 
> > Signed-off-by: Sean Young <sean@mess.org>
> > ---
> >  kernel/bpf/syscall.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index adc83cb82f37..19d9265270b3 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2439,7 +2439,6 @@ static bool is_net_admin_prog_type(enum bpf_prog_type prog_type)
> >         case BPF_PROG_TYPE_LWT_SEG6LOCAL:
> >         case BPF_PROG_TYPE_SK_SKB:
> >         case BPF_PROG_TYPE_SK_MSG:
> > -       case BPF_PROG_TYPE_LIRC_MODE2:
> >         case BPF_PROG_TYPE_FLOW_DISSECTOR:
> >         case BPF_PROG_TYPE_CGROUP_DEVICE:
> >         case BPF_PROG_TYPE_CGROUP_SOCK:
> > --
> > 2.39.2
> >
