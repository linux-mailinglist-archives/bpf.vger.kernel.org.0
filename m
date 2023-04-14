Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120686E2165
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 12:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDNK6y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Apr 2023 06:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDNK6x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Apr 2023 06:58:53 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0BC35B1;
        Fri, 14 Apr 2023 03:58:51 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 1F8B110006C; Fri, 14 Apr 2023 11:58:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1681469929; bh=xKiD6D1LLlILVuQ63mXofNbz+Er3mjpqtu6nPh1Rix4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DASlhFii98NU/JfhobCC0DOl9M0BmHu4kE4MAY2cThrVTDyYDK0/h7yuHUT31E/gj
         Ir66Tf09vvBeXCOMvv4sfg68RdeM3+hweFIqWv7M/dfIDLtUEQiXogUcAr+uuLoMVA
         xiaGVNmnWU0s9+g/gMPNaNkMSJUCwkIU+iZRKFJtUUNcJDi8YNggyaFU4/it3D6+BP
         4qBXgc0ecSLvTKab3fBjj+Rlu4Pq0wfQ0Qd/dfj3ZQit/a2D31yKLxtIjU9BwRxO1q
         l/6HmButEPLq2NV9CnoFMitN+cpV6JUSDilPngcEBmlHOjYCf87+Ac16OPP/DokbTw
         brmBhlGK9qDrg==
Date:   Fri, 14 Apr 2023 11:58:49 +0100
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
Message-ID: <ZDkx6WAWmwHpBJ6m@gofer.mess.org>
References: <ZDWAcN6wfeXzipHz@gofer.mess.org>
 <CAADnVQJ-zzzTxDj8_7WKW-o3BDsU=DNAnvSEZGNHswbhGA8xhA@mail.gmail.com>
 <ZDe9ND/M4I9ll1xV@gofer.mess.org>
 <CAADnVQLOmDEQsHX4XfgETXUte9mJ+-qphR_E7dcjXB2PMDaZnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLOmDEQsHX4XfgETXUte9mJ+-qphR_E7dcjXB2PMDaZnA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 13, 2023 at 04:54:21PM -0700, Alexei Starovoitov wrote:
> On Thu, Apr 13, 2023 at 1:28 AM Sean Young <sean@mess.org> wrote:
> >
> > On Wed, Apr 12, 2023 at 04:14:05PM -0700, Alexei Starovoitov wrote:
> > > On Tue, Apr 11, 2023 at 8:45 AM Sean Young <sean@mess.org> wrote:
> > > >
> > > > Make it possible to load lirc program type with just CAP_BPF.
> > >
> > > Is it safe?
> > > If the user can load with just CAP_BPF the FD to the prog and target_fd
> > > will allow attach as well.
> >
> > Exactly, that's the $1m question of course.
> >
> > I think it's safe from a lirc perspective because you need to be able to
> > open the /dev/lirc0 device in the first place; if you can open it, you
> > alter all sorts of lirc receiving options already. Changing the IR protocol
> > decoder is no different in that perspective.
> >
> > The other side of course, is it save to load a bpf lirc program as a normal
> > user. I don't see any issue with this; I guess this depends on whether the
> > subset of functions in lirc_mode2_func_proto() is safe. I am hoping that
> > the expert opinion everyone here can help answer that question.
> 
> That part is fine under CAP_BPF.
> I don't know how lirc devices are typically setup.
> If they need root to open them
> then why bother relaxing bpf loading part?

I'd like to get a point where /dev/lircN can have the same permissions as
for example /dev/videoN devices: group read/write, so that local users
don't have to become root to use them.

Without relaxing the bpf side, this seems like a chicken and egg problem
(tiktaalik and egg?).

Also - the CAP_NET_ADMIN requirement seems completely arbitrary compared
to other program types.


Sean
