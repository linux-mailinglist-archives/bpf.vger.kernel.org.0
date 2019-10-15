Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D874D848E
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2019 01:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfJOXpy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Oct 2019 19:45:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40367 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfJOXpy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Oct 2019 19:45:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so13475024pfb.7
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2019 16:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zde/2EvOGyJVHgELKq3tUH6iDHa5DC1abeaGck2Hkeg=;
        b=Zg86mDDWBEjHecKXKUnKcm6jCJvouNz1uVLYrpeKJBIEEpp1EdotbSguvhU8SYOAqz
         fIxIcRM8cMpjqAYuMfo4EPYNL/y752pVbIbOTXJHaIxd1dF6JN091zp/4mKULxxzW4+Z
         ZGQ66fkFzQLuo5hYoDYIV2K5vWWWIDodcQTYrv6B4l644zaeO8wn3XF51bMpf2C5GOzj
         qWZ4Y2uyVLObYYLPjl7Tq7j5kQrrq8LD47xZfSmksNadQb4A2HW/wDY67RgmLFtwD490
         NKi91yQfy9l1LZKgzfP6MCs4rvfbNBC6j+bEPQMFnoejhYO3Vq5EtN/oD4oFYMJyazaQ
         sMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zde/2EvOGyJVHgELKq3tUH6iDHa5DC1abeaGck2Hkeg=;
        b=DNHjQmzU2LrkLC2hjk42N3+uEd3BkNk2k/MDc2Upc+hPaVNGf3XuoOMTfUK4TnrCQU
         tePQnebAaoB/1OZNaZm9FtF26pdLFdTX9/7HGm68ZYzJItysvrmRJ513F9xcGlRlJzt0
         horqi6if5Hzy0DE3bA2BtBS5Dknaz6LNRGEMYzHXxkSdJPgU3a76Ud7w2dk6kU3Rf00p
         le5zulRcuUWxnoRllehmzkGIHgew44l4LGHIjKe82YuE7TBo+vrYeb5sRXA9cKlmIFEy
         U/u+o7XYySkiAslPYFlYr+czCq2v8DZ+bz++6Kc5f7RGQRiTmnOJzHiQNu/kvk82dKwP
         uCCg==
X-Gm-Message-State: APjAAAV9bQeql5n2uUS6UoX0i4nrRwpyZA8zdR/2O9z/UW6CGsVbx+TZ
        faHAP15GqfjX3npzucjPTEVyz+qeerA=
X-Google-Smtp-Source: APXvYqzen9OMXKNPAMisvZj8Ft/zTLPHT3WPx5UqTdL7nBQZJFMktDJFDKXRWA6oKSP72gjBwrICHQ==
X-Received: by 2002:a62:6842:: with SMTP id d63mr40591333pfc.16.1571183153820;
        Tue, 15 Oct 2019 16:45:53 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id w14sm42330817pge.56.2019.10.15.16.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 16:45:53 -0700 (PDT)
Date:   Tue, 15 Oct 2019 16:45:52 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 1/2] bpf: allow __sk_buff tstamp in
 BPF_PROG_TEST_RUN
Message-ID: <20191015234552.GC1897241@mini-arch>
References: <20191015183125.124413-1-sdf@google.com>
 <CAEf4Bzb+ZjwA-Jxd4fD6nkYnKGAjOt=2Pz-4GNWBbxtNZJ85UQ@mail.gmail.com>
 <CAADnVQKUV2TEDdekj0xApPqm6q0kCK-SvvpT5=80YQcsfuvXFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKUV2TEDdekj0xApPqm6q0kCK-SvvpT5=80YQcsfuvXFw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/15, Alexei Starovoitov wrote:
> On Tue, Oct 15, 2019 at 4:15 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Tue, Oct 15, 2019 at 2:26 PM Stanislav Fomichev <sdf@google.com> wrote:
> > >
> > > It's useful for implementing EDT related tests (set tstamp, run the
> > > test, see how the tstamp is changed or observe some other parameter).
> > >
> > > Note that bpf_ktime_get_ns() helper is using monotonic clock, so for
> > > the BPF programs that compare tstamp against it, tstamp should be
> > > derived from clock_gettime(CLOCK_MONOTONIC, ...).
> > >
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > >  net/bpf/test_run.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > > index 1153bbcdff72..0be4497cb832 100644
> > > --- a/net/bpf/test_run.c
> > > +++ b/net/bpf/test_run.c
> > > @@ -218,10 +218,18 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
> > >
> > >         if (!range_is_zero(__skb, offsetof(struct __sk_buff, cb) +
> > >                            FIELD_SIZEOF(struct __sk_buff, cb),
> > > +                          offsetof(struct __sk_buff, tstamp)))
> > > +               return -EINVAL;
> > > +
> > > +       /* tstamp is allowed */
> > > +
> > > +       if (!range_is_zero(__skb, offsetof(struct __sk_buff, tstamp) +
> > > +                          FIELD_SIZEOF(struct __sk_buff, tstamp),
> >
> > with no context on this particular change whatsoever: isn't this the
> > same as offsetofend(struct __sk_buff, tstamp)? Same above for cb.
> >
> > Overall, this seems like the 4th similar check, would it make sense to
> > add a static array of ranges we want to check for zeros and just loop
> > over it?..
> 
> I wouldn't bother, but offsetofend() is a good suggestion that
> can be done in a followup.
> 
> Applied both patches. Thanks
Thanks. I'll follow up with offsetofend, sounds like a good suggestion
that can eliminate a bit of copy paste.
