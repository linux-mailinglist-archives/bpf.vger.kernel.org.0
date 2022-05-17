Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D658652AB99
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 21:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiEQTJS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 15:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiEQTJR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 15:09:17 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AEFB1E1
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 12:09:16 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 6D0E824010A
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 21:09:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652814555; bh=Pk0hFb+qM3oMob0OEMSogYr1v1jog+Bh37buDo+jJMo=;
        h=Date:From:To:Cc:Subject:From;
        b=gV9z8oJg+QQqmI+q7TIU27d7QbO5Snclq+VfpOhmLS9wucp4z1wuptX5RxLU10nMQ
         eYv4KFuFQKP/nawYn07Jtb+ma4YVLGS2z2wKgbLGUNAb6DtMGeuWOt6VD15CeG4j7m
         Jj6eTbDWUmGiSTtPglTJ7w3rArHMXwFZvV+6Tgddco11MdBSCunosNgeZjyvSw//2h
         Rw0FirAjIU+t0qMp+Ihz4Yj7AIQGuFE4Jyg0JWU5WZrakmbVjQAhHxzxZFmaT1xtfQ
         E5yPlPVi+KZsOpFHQ3SbU1m/Qr9rLUHNO34NhQjcWIGw9oJ2Pa/nQpBMEnNlYlEPvl
         Eyu9XqDxlqVAg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L2lzF4Qj0z6tmT;
        Tue, 17 May 2022 21:09:13 +0200 (CEST)
Date:   Tue, 17 May 2022 19:09:11 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 03/12] bpftool: Use libbpf_bpf_prog_type_str
Message-ID: <20220517190911.qgakxbrqsbobwxvr@devvm5318.vll0.facebook.com>
References: <20220516173540.3520665-1-deso@posteo.net>
 <20220516173540.3520665-4-deso@posteo.net>
 <fce7ec43-4fae-ead8-df79-3f76fe9f173b@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fce7ec43-4fae-ead8-df79-3f76fe9f173b@isovalent.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 17, 2022 at 03:18:24PM +0100, Quentin Monnet wrote:
> 2022-05-16 17:35 UTC+0000 ~ Daniel Müller <deso@posteo.net>
> > This change switches bpftool over to using the recently introduced
> > libbpf_bpf_prog_type_str function instead of maintaining its own string
> > representation for the bpf_prog_type enum.
> > 
> > Signed-off-by: Daniel Müller <deso@posteo.net>
> > ---
> >  tools/bpf/bpftool/feature.c | 57 +++++++++++++++++++++++--------------
> >  tools/bpf/bpftool/link.c    | 19 +++++++------
> >  tools/bpf/bpftool/main.h    |  3 --
> >  tools/bpf/bpftool/map.c     | 13 +++++----
> >  tools/bpf/bpftool/prog.c    | 51 ++++++---------------------------
> >  5 files changed, 64 insertions(+), 79 deletions(-)
> > 
> > diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> > index d12f460..a093e1 100644
> > --- a/tools/bpf/bpftool/feature.c
> > +++ b/tools/bpf/bpftool/feature.c
> 
> > @@ -728,10 +724,10 @@ probe_helper_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
> >  }
> >  
> >  static void
> > -probe_helpers_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
> > +probe_helpers_for_progtype(enum bpf_prog_type prog_type,
> > +			   char const *prog_type_str, bool supported_type,
> 
> Nit: "const char*" for consistency?

Good catch. Yes, will make the change.

Thanks,
Daniel
