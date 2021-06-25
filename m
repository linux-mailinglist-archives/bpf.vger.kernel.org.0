Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2B63B3D7B
	for <lists+bpf@lfdr.de>; Fri, 25 Jun 2021 09:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFYHiq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Jun 2021 03:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhFYHiq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Jun 2021 03:38:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1380FC061574
        for <bpf@vger.kernel.org>; Fri, 25 Jun 2021 00:36:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id i94so9516716wri.4
        for <bpf@vger.kernel.org>; Fri, 25 Jun 2021 00:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A+iYsxnNRChil1qMH5MHHpKdV0Rl30rr/MhL/n0ldpo=;
        b=OwabMajJMXwFXlsoPKacy7ZKWmFfW+oWJ21Q3d4KKvsGhyzEhATItY3xjHbr0gG7Ze
         yL5f93uQgC6lqZg5i4lrjdFHoczrlNvRisnKJ4b8LO5Q0ey3yYMdil9PMm5fm9txhx1a
         oirlatfmY919d1KX6n97MhlhL1o5Po+QP2TBKybwDaC+m7ofZ6/497Sl6GHQ1JJFbSHy
         fS61WF1bB+fyfe5cHEpgEaUM3Ywanpwr4JZscgUV1SkicD64tI8f2mUaK3yXhSedJ6+a
         DxUxN8MG3557snFkRRlzkT/qG2P4A60VrTPGFusuzM3vibbLCpZhAJBM3L0SlILGt2j1
         0f+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A+iYsxnNRChil1qMH5MHHpKdV0Rl30rr/MhL/n0ldpo=;
        b=jgPd4dVoQsobpqut0i2XYJhP8ktZ4Z3OvqA8N1yUqjagiLqRjzD1332T89QtpEX3E4
         L9eah9wc4sYTaacO5CthuyH9rb8L6coX3PXEvqgWymZTVOQS1ukie2NUMrnOD2k47RNU
         /VJm7ztqEqJqZuyObwKWs6AQz8Og/pBmtADCC0IA2VSYmU/fjrSX56s+29mpSmnkfF9z
         G+n6D8VruSuCUxNY86xkKhpO432fCByA/STEc340ePB3XvnT4yWf+ZJDUUQhAGQrO8U1
         /4I5z0xPW3vd35JrJiEF0Lh/intsH2IJvZ4PVf8w5liNvQFkWKlxLOmR0bT2O8ggUl07
         KvLA==
X-Gm-Message-State: AOAM530s7tyvurkOFv/fiUvVBQ8qXO7r0yubOMypTWZ95hsPYE1ECTZB
        pnVynNbX3mLeSOXRbHArFFkYUw==
X-Google-Smtp-Source: ABdhPJwbhMH8K0ko7h1DMvsBPkXfcdQWgEd8GSufhINDO4SZsP+VSNa9+m4a6/rLkDMoT68d4YcW0Q==
X-Received: by 2002:a5d:6a4e:: with SMTP id t14mr9258510wrw.211.1624606583710;
        Fri, 25 Jun 2021 00:36:23 -0700 (PDT)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id 61sm6023536wrp.4.2021.06.25.00.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 00:36:23 -0700 (PDT)
Date:   Fri, 25 Jun 2021 11:36:21 +0400
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Gary Lin <glin@suse.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Martin Loviska <mloviska@suse.com>
Subject: Re: [PATCH bpf] net/bpfilter: specify the log level for the kmsg
 message
Message-ID: <20210625073621.zmd2w33wi335lya3@amnesia>
References: <20210623040918.8683-1-glin@suse.com>
 <CAADnVQLpN993VpnPkTUxXpBMZtS6+h4CVruH33zbw-BLWj41-A@mail.gmail.com>
 <20210623065744.igawwy424y2zy26t@amnesia>
 <CAADnVQK2uQ3MvwaRztMtcw8SJz1r213hxA+vM2dCtr6RfpZnSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQK2uQ3MvwaRztMtcw8SJz1r213hxA+vM2dCtr6RfpZnSA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 24, 2021 at 08:47:06PM -0700, Alexei Starovoitov wrote:
> On Tue, Jun 22, 2021 at 11:57 PM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
> >
> > On Tue, Jun 22, 2021 at 09:38:38PM -0700, Alexei Starovoitov wrote:
> > > On Tue, Jun 22, 2021 at 9:09 PM Gary Lin <glin@suse.com> wrote:
> > > >
> > > > Per the kmsg document(*), if we don't specify the log level with a
> > > > prefix "<N>" in the message string, the default log level will be
> > > > applied to the message. Since the default level could be warning(4),
> > > > this would make the log utility such as journalctl treat the message,
> > > > "Started bpfilter", as a warning. To avoid confusion, this commit adds
> > > > the prefix "<5>" to make the message always a notice.
> > > >
> > > > (*) https://www.kernel.org/doc/Documentation/ABI/testing/dev-kmsg
> > > >
> > > > Fixes: 36c4357c63f3 ("net: bpfilter: print umh messages to /dev/kmsg")
> > > > Reported-by: Martin Loviska <mloviska@suse.com>
> > > > Signed-off-by: Gary Lin <glin@suse.com>
> > > > ---
> > > >  net/bpfilter/main.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/bpfilter/main.c b/net/bpfilter/main.c
> > > > index 05e1cfc1e5cd..291a92546246 100644
> > > > --- a/net/bpfilter/main.c
> > > > +++ b/net/bpfilter/main.c
> > > > @@ -57,7 +57,7 @@ int main(void)
> > > >  {
> > > >         debug_f = fopen("/dev/kmsg", "w");
> > > >         setvbuf(debug_f, 0, _IOLBF, 0);
> > > > -       fprintf(debug_f, "Started bpfilter\n");
> > > > +       fprintf(debug_f, "<5>Started bpfilter\n");
> > > >         loop();
> > > >         fclose(debug_f);
> > > >         return 0;
> > >
> > > Adding Dmitrii who is redesigning the whole bpfilter.
> >
> > Thanks. The same logic already exists in the bpfilter v1 patchset
> > - [1].
> >
> > 1. https://lore.kernel.org/bpf/c72bac57-84a0-ac4c-8bd8-08758715118e@fb.com/T/#mb36e20c4e5e4a70746bd50a109b1630687990214
> 
> Dmitrii,
> 
> what do you prefer we should do with this patch then?

There was an explicit request to make an event of loading a UMH
visible - [1]. Given that the default for MaxLevelConsole is info
and the patch makes the behavior slightly more accurate - ack
from me.

1. https://lore.kernel.org/netdev/CA+55aFx5Q8D3cmuoXJFV9Ok_vc3fd3rNP-5onqFTPTtfZgi=HQ@mail.gmail.com/

-- 

Dmitrii Banshchikov
