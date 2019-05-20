Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFD324046
	for <lists+bpf@lfdr.de>; Mon, 20 May 2019 20:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfETSZ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 May 2019 14:25:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33749 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfETSZ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 May 2019 14:25:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so7182674pgv.0
        for <bpf@vger.kernel.org>; Mon, 20 May 2019 11:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=b+R02j4/uF0EBO8erZc6QpLT1KkcKmjQEE/WVjBwbqw=;
        b=2A564VW7Oyzj0BgET4LsDx48f+Hw3pSS6w3xynY5mMy5xtcRM1B8MZPQUUcEjQ2xWA
         1F6qNxmN5PaUvBFi1/HV2xFjYgY/FSVMlGTa6qQzYhPR3+EeXG57ojk/bhl6XngO2oHD
         zWQMRkkstcr1EDQWm2qs5v9mSYaa6OT7qGFgaV1RHqtExsH6+OWqpNHPFJ1jeJCxuhBJ
         Q24+7G1XEHIIw7sVUiSgNv2ng1ZvfumTfRKOJva5z6erCwNZXiYakka7zi+ykhykCfQz
         vZMQbxQI7RMghlwJTTBQZIgf0T1rG0MC4wPF6bNxlrDkIuvOa0lc6dNP+CpS5gc0Fwmd
         Zflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=b+R02j4/uF0EBO8erZc6QpLT1KkcKmjQEE/WVjBwbqw=;
        b=rB+a5hzoExGkdyTr0qOLZwrcTCc1usw20QAyyr2O7WTKtB9a38LRG5swSkvmb39B7+
         48dzbhJym2fVp4BvXgtxir7LIajMJYJVCIgZ38NQTAU/g35/flc804p/BExjxyUEWR1S
         N44BK3KuUwtvEzey3zpy6EJYk0MW/DJublayFKnDlvXvfv1d/o+8LpNMGTOXAk+GYurw
         G6RFHxmG9L3m1tNsRN0d1xcOivDvqyiHV0VjrmdPjKR0Fm5+ZWpGL9jyKUV0sCjTeOHM
         k5J/wngLnMqpEetAmsih/VJL6qYsdYlCoWDmhHSYaNmFhS2G1axGFFFRFvuOlfjiVPaV
         NUIg==
X-Gm-Message-State: APjAAAXsmmTH4QxS2aBp7WJXmroH3ndFFZ38+nN6HnxkZSGLRZprd6Vf
        6T3Y1EWwq5oqV+Cg0Mkge3ikzJAFmtI=
X-Google-Smtp-Source: APXvYqy+h7aOKSTpc9FbuMEelpZCzxxfLULlbA1XwBW1GmxOy5JwFWue60yJ1JXHzJ7VZze8Rc4osg==
X-Received: by 2002:a62:7fcd:: with SMTP id a196mr32974973pfd.195.1558376755698;
        Mon, 20 May 2019 11:25:55 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id z7sm23516073pfr.23.2019.05.20.11.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 11:25:55 -0700 (PDT)
Date:   Mon, 20 May 2019 11:25:54 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     xdp-newbies@vger.kernel.org, bpf@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 2/5] libbpf: add missing typedef
Message-ID: <20190520182554.GI10244@mini-arch>
References: <20190518004639.20648-1-mcroce@redhat.com>
 <20190518004639.20648-2-mcroce@redhat.com>
 <20190520165322.GH10244@mini-arch>
 <CAGnkfhzEZokRWMtTdbHzy1JZVVEzEPuY2oWL-9LzjRVgG0Y05Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGnkfhzEZokRWMtTdbHzy1JZVVEzEPuY2oWL-9LzjRVgG0Y05Q@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/20, Matteo Croce wrote:
> On Mon, May 20, 2019 at 6:53 PM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > On 05/18, Matteo Croce wrote:
> > > Sync tools/include/linux/types.h with the UAPI one to fix this build error:
> > >
> > > make -C samples/bpf/../../tools/lib/bpf/ RM='rm -rf' LDFLAGS= srctree=samples/bpf/../../ O=
> > >   HOSTCC  samples/bpf/sock_example
> > > In file included from samples/bpf/sock_example.c:27:
> > > /usr/include/linux/ip.h:102:2: error: unknown type name ‘__sum16’
> > >   102 |  __sum16 check;
> > >       |  ^~~~~~~
> > > make[2]: *** [scripts/Makefile.host:92: samples/bpf/sock_example] Error 1
> > > make[1]: *** [Makefile:1763: samples/bpf/] Error 2
> > >
> > > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> > > ---
> > >  tools/include/linux/types.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
> > > index 154eb4e3ca7c..5266dbfee945 100644
> > > --- a/tools/include/linux/types.h
> > > +++ b/tools/include/linux/types.h
> > > @@ -58,6 +58,9 @@ typedef __u32 __bitwise __be32;
> > >  typedef __u64 __bitwise __le64;
> > >  typedef __u64 __bitwise __be64;
> > >
> > > +typedef __u16 __bitwise __sum16;
> > > +typedef __u32 __bitwise __wsum;
> > If you do that, you should probably remove 'typedef __u16 __sum16;'
> > from test_progs.h:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/tools/testing/selftests/bpf/test_progs.h#n13
> >
> > > +
> > >  typedef struct {
> > >       int counter;
> > >  } atomic_t;
> > > --
> > > 2.21.0
> > >
> 
> Hi,
> 
> I see test_progs.h only included in tools/testing/selftests/bpf/prog_tests/*,
> so maybe it's unreladed to my change in samples/bpf/.
> Maybe in a different patchset.
Yes, I'm just saying that now that you have __sum16 defined in
tools/include/linux/types.h you can have another patch to remove
that custom __sum16 typedef from tests_progs.h
