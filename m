Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B14E2B3C1B
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 05:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgKPEaV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 15 Nov 2020 23:30:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbgKPEaV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 15 Nov 2020 23:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605501019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lyS4NdMLj/LDYntXNCRwGzuXW3sed4eHkvU0vJkVJio=;
        b=AStxlmDLAuXpKU1weY5+0ArBh4ylnIWSP+A8oUPRL2FRVCdOt9TUoYq0vg+Gi1BZtfu1I0
        jlvmmxGooXI0rWGAgFGXoicbPsmSkYm0p8RZ6BA4JnFIheGdiJ3ejeWvbe4ET8zW2pu+jF
        HB5KMnb3kvrucgeGOtnA5q0ONF9HNQM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-ZVOSL1RzOyei6T5Izj5eZg-1; Sun, 15 Nov 2020 23:30:14 -0500
X-MC-Unique: ZVOSL1RzOyei6T5Izj5eZg-1
Received: by mail-pf1-f200.google.com with SMTP id g14so11185273pfb.8
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2020 20:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lyS4NdMLj/LDYntXNCRwGzuXW3sed4eHkvU0vJkVJio=;
        b=iYY+GflyS77gOBvDKhXPneo+jOOzrYAN8I8aJbuQ1dOwMJErcBvn07gZbE9AwIiupn
         AYO9s3ug3msO6axmte/DsKglWuMi9DYiVYXFZH8CjAAtpaFlR3AbbuWKUwDqVA1C3xYJ
         tKplCBHxiNOJ1CxygRNIITyJzE4VjW9bZtFTqCD9DQaITN4sPBO24uz1KA4rV12yPNfD
         mATuk+MWFA6mdM7pI/yV2kTP3BlNnWpQ/267sAGvzU6hRLFNJ8OiznMfdFMck8BPz7AC
         vvoQ+1MdoGI8sIAmidbiRh/f00KAFzZUi2M9Y4ypHOj8WQf9+8BM0ZYDy/rMO/kkT4gD
         isfQ==
X-Gm-Message-State: AOAM532N1B4PPcUpoZWPm9eMU4tWh3TvMuWsp8F4OrGJqq3U6fXtRsGo
        aEnMXhzYn84Yyw8+sgODcKLxu4AFly4hmM4yujvt2PFbv9mtAElRlAc6dqEq+2CMHHPzJVat4ZB
        ndhF8+o91y7c=
X-Received: by 2002:a17:902:788e:b029:d6:9a57:ccab with SMTP id q14-20020a170902788eb02900d69a57ccabmr11266144pll.41.1605501013298;
        Sun, 15 Nov 2020 20:30:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJBU5iBm+S79Gp1/EkhBqycX1D+Pcrjw1dONZgnbOu0okJA3ctUY2pjMpapJ68WPkd34Mvxg==
X-Received: by 2002:a17:902:788e:b029:d6:9a57:ccab with SMTP id q14-20020a170902788eb02900d69a57ccabmr11266121pll.41.1605501012989;
        Sun, 15 Nov 2020 20:30:12 -0800 (PST)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o62sm8480327pjo.7.2020.11.15.20.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 20:30:12 -0800 (PST)
Date:   Mon, 16 Nov 2020 12:30:01 +0800
From:   Hangbin Liu <haliu@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCHv4 iproute2-next 1/5] configure: add check_libbpf() for
 later libbpf support
Message-ID: <20201116043001.GG2408@dhcp-12-153.nay.redhat.com>
References: <20201029151146.3810859-1-haliu@redhat.com>
 <20201109070802.3638167-1-haliu@redhat.com>
 <20201109070802.3638167-2-haliu@redhat.com>
 <8443c959-2ab5-0963-120e-b278e8bac360@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8443c959-2ab5-0963-120e-b278e8bac360@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 13, 2020 at 08:26:51PM -0700, David Ahern wrote:
> > +# Influential LIBBPF environment variables:
> > +#   LIBBPF_FORCE={on,off}   on: require link against libbpf;
> > +#                           off: disable libbpf probing
> > +#   LIBBPF_LIBDIR           Path to libbpf to use
> > +

...
> > +check_libbpf()
> > +{
> > +    # if set LIBBPF_FORCE=off, disable libbpf entirely
> > +    if [ "$LIBBPF_FORCE" = off ]; then
> > +        echo "no"
> > +        return
> > +    fi
> > +
> > +    if ! ${PKG_CONFIG} libbpf --exists && [ -z "$LIBBPF_DIR" ] ; then
> > +        echo "no"
> > +        check_force_libbpf_on
> > +        return
> > +    fi

...

> 
> Something is off with the version detection.
> 
> # LIBBPF_LIBDIR=/tmp/libbpf ./configure

My copy-past error. It should take LIBBPF_DIR, but I wrote LIBBPF_LIBDIR in
the description... Also the folder should be libbpf dest dir, not libbpf
dir directly. To be consistent with the libbpf document. I will change
LIBBPF_DIR to LIBBPF_DESTDIR(Please tell me if you think the name is not
suitable). The fix diff will looks like

diff --git a/configure b/configure
index 3081a2ac..5ca10337 100755
--- a/configure
+++ b/configure
@@ -5,7 +5,7 @@
 # Influential LIBBPF environment variables:
 #   LIBBPF_FORCE={on,off}   on: require link against libbpf;
 #                           off: disable libbpf probing
-#   LIBBPF_LIBDIR           Path to libbpf to use
+#   LIBBPF_DESTDIR          Path to libbpf dest dir to use
 
 INCLUDE=${1:-"$PWD/include"}
 
@@ -301,20 +301,20 @@ check_libbpf()
         return
     fi
 
-    if ! ${PKG_CONFIG} libbpf --exists && [ -z "$LIBBPF_DIR" ] ; then
+    if ! ${PKG_CONFIG} libbpf --exists && [ -z "$LIBBPF_DESTDIR" ] ; then
         echo "no"
         check_force_libbpf_on
         return
     fi
 
     if [ $(uname -m) = x86_64 ]; then
-        local LIBBPF_LIBDIR="${LIBBPF_DIR}/lib64"
+        local LIBBPF_LIBDIR="${LIBBPF_DESTDIR}/usr/lib64"
     else
-        local LIBBPF_LIBDIR="${LIBBPF_DIR}/lib"
+        local LIBBPF_LIBDIR="${LIBBPF_DESTDIR}/usr/lib"
     fi
 
-    if [ -n "$LIBBPF_DIR" ]; then
-        LIBBPF_CFLAGS="-I${LIBBPF_DIR}/include"
+    if [ -n "$LIBBPF_DESTDIR" ]; then
+        LIBBPF_CFLAGS="-I${LIBBPF_DESTDIR}/usr/include"
         LIBBPF_LDLIBS="${LIBBPF_LIBDIR}/libbpf.a -lz -lelf"
         LIBBPF_VERSION=$(PKG_CONFIG_LIBDIR=${LIBBPF_LIBDIR}/pkgconfig ${PKG_CONFIG} libbpf --modversion)
     else

When you compile libbpf, it should like

$ mkdir /tmp/libbpf_destdir
$ cd libbpf/src/
$ make
...
  CC       libbpf.so.0.2.0
$ DESTDIR=/tmp/libbpf_destdir make install

Then in iproute2, configure it with

$ LIBBPF_DIR=/tmp/libbpf_destdir ./configure
TC schedulers
 ATM    no

libc has setns: yes
SELinux support: no
libbpf support: yes
        libbpf version 0.2.0
ELF support: yes
libmnl support: yes
Berkeley DB: no
need for strlcpy: yes
libcap support: yes

Thanks
Hangbin

