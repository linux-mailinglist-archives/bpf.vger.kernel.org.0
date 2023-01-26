Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C7067D334
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 18:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjAZRbs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 12:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjAZRbr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 12:31:47 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E535E83CE
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 09:31:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso2413195pjp.3
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 09:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nBMy3jf5zMo9MD1D/Nf5zlopasS84Q6+UudTxcOwXVs=;
        b=L2sd8yVEAzJh2ZM4mOsEczAukPyWrYih/8Ujhr2Ix9glhAQDEf6d8ifietbAgExBiB
         Z5KKclAIGsn01b5b2vqLg3p81r4NDRSCg8We6RVAdLu/QZZPicETsMvdtIAfy0s8LupQ
         qqUsqMucfGmF5IZXDZVndket/Q3FBqLfgb6zya+xNjgsWkJfQj3fIHTNdFtlqSMY+SAE
         nCP4Swp3K79SgxONI6KlfP/E9UhycriQg+6Psgu/galo25MB6pK6f5/OfIrO1Z221HcR
         52De0tTF4kZUa2u5jMlWymvfYoeXtLHtHJSyyFV89mNdYhlz7cxOekeEKVvFSEX1/KY7
         7XRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBMy3jf5zMo9MD1D/Nf5zlopasS84Q6+UudTxcOwXVs=;
        b=TtDcPJxe/BhX42AS91fSvFFbpaD6vrYtN1Hi/FXbWALIjBytRA3dkmZWuztQvCBVfN
         SM27XodkQlGsaQPs+2dxkUHZBHh87zUgKWO0Xe9ZpZ/0XJfHZz7J3pM2PbFy0LVa2mz1
         Q/YhylHg4SNdUdXgwOEUSSQm7tdTUsiuw8FKNCYL9fq8tttqp3yDLhxoh0vM7hhVuq/n
         PKIVfud1rr20H+otLuaE99WqElvyxSZQgBMgaD3ckqyi5cC2NexX2P/KEOXOEFUGiukF
         FL8JcOdx6AZ/hjT+85FGwSyzEbNsJnOt7/kq7aAosMrr0KUZX46sw8AjzQSuQ6cM1c6Z
         GEqQ==
X-Gm-Message-State: AO0yUKXYF3nT1Lgausi0mdHhWfbUMIUFhjEyLqaq5TBEvcZSBPt9xclo
        UTF0Y3F7ugOhlfsq1JvXonOut+i+s/rLW21SBXPVFA==
X-Google-Smtp-Source: AK7set8yY3FttQQGYP9o63ZseODZBbczj7cIZ1SbGv6e8VIqRLCBFzgkVfc6DmAB0ipsjDc7pSkvzicQ+BneKtUupZU=
X-Received: by 2002:a17:90a:6f47:b0:22b:edb4:8015 with SMTP id
 d65-20020a17090a6f4700b0022bedb48015mr1840219pjk.155.1674754302053; Thu, 26
 Jan 2023 09:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20230125223205.3933482-1-sdf@google.com> <c2c7f7c7-4c36-c4de-332a-22531a53b7b6@linux.dev>
In-Reply-To: <c2c7f7c7-4c36-c4de-332a-22531a53b7b6@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 26 Jan 2023 09:31:31 -0800
Message-ID: <CAKH8qBvf0JJ-N8iWba2=VA22WfXkC0hdTVOF5AANbmwkBT9BBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Properly enable hwtstamp in xdp_hw_metadata
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 25, 2023 at 5:12 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 1/25/23 2:32 PM, Stanislav Fomichev wrote:
> > The existing timestamping_enable() is a no-op because it applies
> > to the socket-related path that we are not verifying here
> > anymore. (but still leaving the code around hoping we can
> > have xdp->skb path verified here as well)
> >
> >    poll: 1 (0)
> >    xsk_ring_cons__peek: 1
> >    0xf64788: rx_desc[0]->addr=100000000008000 addr=8100 comp_addr=8000
> >    rx_hash: 3697961069
> >    rx_timestamp:  1674657672142214773 (sec:1674657672.1422)
> >    XDP RX-time:   1674657709561774876 (sec:1674657709.5618) delta sec:37.4196
> >    AF_XDP time:   1674657709561871034 (sec:1674657709.5619) delta
> > sec:0.0001 (96.158 usec)
> >    0xf64788: complete idx=8 addr=8000
> >
> > Also, maybe something to archive here, see [0] for Jesper's note
> > about NIC vs host clock delta.
> >
> > 0: https://lore.kernel.org/bpf/f3a116dc-1b14-3432-ad20-a36179ef0608@redhat.com/
> >
> > Fixes: 297a3f124155 ("selftests/bpf: Simple program to dump XDP RX metadata")
> > Reported-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
> > Tested-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >   tools/testing/selftests/bpf/xdp_hw_metadata.c | 28 ++++++++++++++++++-
> >   1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > index 0008f0f239e8..dc899c53db5e 100644
> > --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > @@ -24,6 +24,7 @@
> >   #include <linux/net_tstamp.h>
> >   #include <linux/udp.h>
> >   #include <linux/sockios.h>
> > +#include <linux/net_tstamp.h>
> >   #include <sys/mman.h>
> >   #include <net/if.h>
> >   #include <poll.h>
> > @@ -278,13 +279,36 @@ static int rxq_num(const char *ifname)
> >
> >       ret = ioctl(fd, SIOCETHTOOL, &ifr);
> >       if (ret < 0)
> > -             error(-1, errno, "socket");
> > +             error(-1, errno, "ioctl(SIOCETHTOOL)");
> >
> >       close(fd);
> >
> >       return ch.rx_count + ch.combined_count;
> >   }
> >
> > +static void hwtstamp_enable(const char *ifname)
> > +{
> > +     struct hwtstamp_config cfg = {
> > +             .rx_filter = HWTSTAMP_FILTER_ALL,
> > +     };
> > +
> > +     struct ifreq ifr = {
> > +             .ifr_data = (void *)&cfg,
> > +     };
> > +     strcpy(ifr.ifr_name, ifname);
> > +     int fd, ret;
> > +
> > +     fd = socket(AF_UNIX, SOCK_DGRAM, 0);
> > +     if (fd < 0)
> > +             error(-1, errno, "socket");
> > +
> > +     ret = ioctl(fd, SIOCSHWTSTAMP, &ifr);
> > +     if (ret < 0)
> > +             error(-1, errno, "ioctl(SIOCSHWTSTAMP)");
> > +
> > +     close(fd);
> > +}
> > +
> >   static void cleanup(void)
> >   {
> >       LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
> > @@ -341,6 +365,8 @@ int main(int argc, char *argv[])
> >
> >       printf("rxq: %d\n", rxq);
> >
> > +     hwtstamp_enable(ifname);
>
> Will it to restore to the earlier setting when the process exits?

Nope, do you think we should? Probably a good idea, let me add that...
