Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE3567EC25
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 18:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjA0RLE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 12:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbjA0RLD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 12:11:03 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0915B1449E
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 09:10:37 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g9so3716113pfo.5
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 09:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9t631sWKO6VGZiPczxFmKncZtgEefexKJVJdD3QCp4=;
        b=A/NK8cJfQSJGAq5vEt8aFIZi2MzVbUUIxWGYJ5S9Mf9nHcxDG3EuYzSM21qXwHyXJS
         1XTHEaI/rt9gEgNXE0SVPFNk+QBYuYtSdSWk/qH2aSBoVytCQ//2HmBuffSnabgC6D6P
         Fuv/AevbbvJbTiMa+4rkCtDemhAOA/MHUYl0YgjxiAxFHzWzNPkhk7eBBIEsfphvdNFr
         ogwRGmE+bikyyDYUjYMwuOZt1Fjg1l6pxkKIHmK+4Bl09AaimUkIrOw+SCc/1SKFCeqS
         MvTnbQPR777ZDX3HEIlWR68/Qg7Q5glZEczjuhJI43z36oxiF+bnRXUmHs7jSUnc8amm
         zqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9t631sWKO6VGZiPczxFmKncZtgEefexKJVJdD3QCp4=;
        b=3VoDx7FxL73lQsyOgkiGC/U1VJff/1/75KYWnVL3dO7JK7+1KCjIJ7ktPhmo2SkMND
         9M5aXh4ElBg0/1Sc/dD9JawS6Br+TxkIjCWkort1Tty16opn9ftj9f8PXoiccA7WvtAA
         Gt1eBTRnwq647LHY0jblcawgQ9LiFzWE9QG1NHGIzHW2eg50AehUdBXX+XBoS86Ue4i6
         m147SOo7r+2GD3XcJqXRg+RA2J73L/f4U6RpWPeSsVayyAvFdpU5rEE8CjFpqa4E2BN4
         Fkqn3S4P6SXgU/tczIb2vA3hjo7x9psQ9HY+7JRArdETIe0yDjqw33tM+Bq6E3cyotBI
         yYQQ==
X-Gm-Message-State: AFqh2kqRddPKXCbFUSA+aI3S4biwhB4B/RgBdzRHUR2VKnDaQd8KaZrN
        2PfjevIpkMsdXMYah36OnD9VNgtlRkiDjjan67LgOg==
X-Google-Smtp-Source: AMrXdXsvJSohgvN5yidHqBfN6PQypDjoXYDTC2fVpJl6ioFadaCFpXPSeyR+CwSfI2Gg3j2M0GALNqTBGlEAoj3C7gU=
X-Received: by 2002:a05:6a00:1f05:b0:58d:c610:43cf with SMTP id
 be5-20020a056a001f0500b0058dc61043cfmr4685664pfb.13.1674839368403; Fri, 27
 Jan 2023 09:09:28 -0800 (PST)
MIME-Version: 1.0
References: <20230126225030.510629-1-sdf@google.com> <150ce627-856d-d85a-61da-951ba3754537@redhat.com>
In-Reply-To: <150ce627-856d-d85a-61da-951ba3754537@redhat.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 27 Jan 2023 09:09:16 -0800
Message-ID: <CAKH8qBvjjMD50enRokuaULS2XBhO-ua4PQp+OCjvcd3L0=iHYA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Properly enable hwtstamp in xdp_hw_metadata
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     bpf@vger.kernel.org, brouer@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org
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

On Fri, Jan 27, 2023 at 5:36 AM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
>
>
> On 26/01/2023 23.50, Stanislav Fomichev wrote:
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
>
> Again for the record, this output is from my devel version of
> xdp_hw_metadata and not what is currently upstream.

Yeah, that's fine, I just wanted to record it somewhere :-)

> Small nit below, which is too late as this is already applied.
>
> > Also, maybe something to archive here, see [0] for Jesper's note
> > about NIC vs host clock delta.
> >
> > 0: https://lore.kernel.org/bpf/f3a116dc-1b14-3432-ad20-a36179ef0608@redhat.com/
> >
> > v2:
> > - Restore original value (Martin)
> >
> > Fixes: 297a3f124155 ("selftests/bpf: Simple program to dump XDP RX metadata")
> > Reported-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
> > Tested-by: Jesper Dangaard Brouer <jbrouer@redhat.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >   tools/testing/selftests/bpf/xdp_hw_metadata.c | 45 ++++++++++++++++++-
> >   1 file changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > index 0008f0f239e8..3823b1c499cc 100644
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
> > @@ -278,13 +279,53 @@ static int rxq_num(const char *ifname)
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
> > +static void hwtstamp_ioctl(int op, const char *ifname, struct hwtstamp_config *cfg)
> > +{
> > +     struct ifreq ifr = {
> > +             .ifr_data = (void *)cfg,
> > +     };
> > +     strcpy(ifr.ifr_name, ifname);
>
> I would use strncpy like:
>
>   strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);

Good point, maybe we can fold this into some of the next patches to
this file. Since this is for internal dev consumption, doesn't look
like a huge deal to me to deserve a separate patch.

> > +     int fd, ret;
> > +
> > +     fd = socket(AF_UNIX, SOCK_DGRAM, 0);
> > +     if (fd < 0)
> > +             error(-1, errno, "socket");
> > +
> > +     ret = ioctl(fd, op, &ifr);
> > +     if (ret < 0)
> > +             error(-1, errno, "ioctl(%d)", op);
> > +
> > +     close(fd);
> > +}
> > +
> > +static struct hwtstamp_config saved_hwtstamp_cfg;
> > +static const char *saved_hwtstamp_ifname;
> > +
> > +static void hwtstamp_restore(void)
> > +{
> > +     hwtstamp_ioctl(SIOCSHWTSTAMP, saved_hwtstamp_ifname, &saved_hwtstamp_cfg);
> > +}
> > +
> > +static void hwtstamp_enable(const char *ifname)
> > +{
> > +     struct hwtstamp_config cfg = {
> > +             .rx_filter = HWTSTAMP_FILTER_ALL,
> > +     };
> > +
> > +     hwtstamp_ioctl(SIOCGHWTSTAMP, ifname, &saved_hwtstamp_cfg);
> > +     saved_hwtstamp_ifname = strdup(ifname);
> > +     atexit(hwtstamp_restore);
> > +
> > +     hwtstamp_ioctl(SIOCSHWTSTAMP, ifname, &cfg);
> > +}
> > +
> >   static void cleanup(void)
> >   {
> >       LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
> > @@ -341,6 +382,8 @@ int main(int argc, char *argv[])
> >
> >       printf("rxq: %d\n", rxq);
> >
> > +     hwtstamp_enable(ifname);
> > +
> >       rx_xsk = malloc(sizeof(struct xsk) * rxq);
> >       if (!rx_xsk)
> >               error(-1, ENOMEM, "malloc");
>
