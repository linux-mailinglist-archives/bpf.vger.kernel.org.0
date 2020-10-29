Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3AD29E8EF
	for <lists+bpf@lfdr.de>; Thu, 29 Oct 2020 11:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgJ2K1Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Oct 2020 06:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbgJ2K1P (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Oct 2020 06:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603967234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CawZHAHsADnYGtPdnNVTledh1fXyNWfHH1USQ/nhD8M=;
        b=NyLRTzqOcRbJm9hHFQ9yJwqvgnDsawB1Pg2HnecsKL7M8s2GLm5C2Z7Qir7v2A1hq2d9Cu
        At+LhCwG2kPZyJp5snB72TREGwx5Ow31zVZm+naOlmDucalYBpBqQj1kgAdonNn2q65CPB
        gYAiS747P20JrKKCkf7BnAYz1orVNuQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-z73CGs09P9ejAUWV7DUfgQ-1; Thu, 29 Oct 2020 06:27:09 -0400
X-MC-Unique: z73CGs09P9ejAUWV7DUfgQ-1
Received: by mail-pf1-f198.google.com with SMTP id x24so1797123pfi.18
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2020 03:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CawZHAHsADnYGtPdnNVTledh1fXyNWfHH1USQ/nhD8M=;
        b=JOtkyy6E4RLhK6HHL34y0GcvSthax4xvkbGSXtF+7Np235Wb77qSE4WljEr1dtECr9
         nZ3mNawG79HwWWJ2hezT5o+Zg46YTAGG/UNXGaySyjNyB5xbvxxce/G9rgLgXPL2+7XC
         vEsN+e3Vq7h/roR9EUjd/4jrQhh83ac56igPoQOZ64FcLWw1xqBlZSA92xdOETdr/jaI
         EX3j+Lkn2AygDg7W1g6Olf1WRrjey91IyS71LJfLaFnzWTwW8Uv0Rnmn3MwmrcGfPglL
         /KQUOlen7HvqEpOmCFlCsKhMllV9YP2KRPZUOz0dTxVVPbEvrsvruga9ipy9SxCtaMhS
         iICA==
X-Gm-Message-State: AOAM531WOPu8koUUq4Fr9xLSptaKJhXc+SyPofeItSX7X9eRHjtVYw5G
        OOiFUEBQdvWpINvYWqPp0Fbkv14n/XqFhFaxx1u+7RYdNqeOFtPwkZgnlMZXohy4gKLD77ve9rQ
        a7FUeQNAtfqQ=
X-Received: by 2002:a62:6dc2:0:b029:152:637c:4cf5 with SMTP id i185-20020a626dc20000b0290152637c4cf5mr3662202pfc.15.1603967228914;
        Thu, 29 Oct 2020 03:27:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL5q1JJnLRnQTy+dkmTfd1Epzd58F2F8pDh8JBEdWz+QGU7Nz54Ud3XYChJCl4bRsQsiBIkg==
X-Received: by 2002:a62:6dc2:0:b029:152:637c:4cf5 with SMTP id i185-20020a626dc20000b0290152637c4cf5mr3662178pfc.15.1603967228668;
        Thu, 29 Oct 2020 03:27:08 -0700 (PDT)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x123sm2465927pfb.212.2020.10.29.03.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 03:27:08 -0700 (PDT)
Date:   Thu, 29 Oct 2020 18:26:56 +0800
From:   Hangbin Liu <haliu@redhat.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCHv2 iproute2-next 0/5] iproute2: add libbpf support
Message-ID: <20201029102656.GU2408@dhcp-12-153.nay.redhat.com>
References: <20201023033855.3894509-1-haliu@redhat.com>
 <20201028132529.3763875-1-haliu@redhat.com>
 <7babcccb-2b31-f9bf-16ea-6312e449b928@gmail.com>
 <20201029020637.GM2408@dhcp-12-153.nay.redhat.com>
 <7a412e24-0846-bffe-d533-3407d06d83c4@gmail.com>
 <20201029024506.GN2408@dhcp-12-153.nay.redhat.com>
 <99d68384-c638-1d65-5945-2814ccd2e09e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99d68384-c638-1d65-5945-2814ccd2e09e@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 28, 2020 at 09:00:41PM -0600, David Ahern wrote:
> >> nope. you need to be able to handle this. Ubuntu 20.10 was just
> >> released, and it has a version of libbpf. If you are going to integrate
> >> libbpf into other packages like iproute2, it needs to just work with
> >> that version.
> > 
> > OK, I can replace bpf_program__section_name by bpf_program__title().
> 
> I believe this one can be handled through a compatability check. Looks
> the rename / deprecation is fairly recent (78cdb58bdf15f from Sept 2020).

Hi David,

I just come up with another way. In configure, build a temp program and update
the function checking every time is not graceful. How about just check the
libbpf version, since libbpf has exported all functions in src/libbpf.map.

Currently, only bpf_program__section_name() is added in 0.2.0, all other
needed functions are supported in 0.1.0.

So in configure, the new check would like:

check_force_libbpf()
{
    # if set FORCE_LIBBPF but no libbpf support, just exist the config
    # process to make sure we don't build without libbpf.
    if [ -n "$FORCE_LIBBPF" ]; then
        echo "FORCE_LIBBPF set, but couldn't find a usable libbpf"
        exit 1
    fi
}

check_libbpf()
{
    if ! ${PKG_CONFIG} libbpf --exists && [ -z "$LIBBPF_DIR" ] ; then
        echo "no"
        check_force_libbpf
        return
    fi

    if [ $(uname -m) == x86_64 ]; then
        local LIBSUBDIR=lib64
    else
        local LIBSUBDIR=lib
    fi

    if [ -n "$LIBBPF_DIR" ]; then
        LIBBPF_CFLAGS="-I${LIBBPF_DIR}/include -L${LIBBPF_DIR}/${LIBSUBDIR}"
        LIBBPF_LDLIBS="${LIBBPF_DIR}/${LIBSUBDIR}/libbpf.a -lz -lelf"
    else
        LIBBPF_CFLAGS=$(${PKG_CONFIG} libbpf --cflags)
        LIBBPF_LDLIBS=$(${PKG_CONFIG} libbpf --libs)
    fi

    if ${PKG_CONFIG} libbpf --atleast-version 0.1.0 || \
        PKG_CONFIG_LIBDIR=${LIBBPF_DIR}/${LIBSUBDIR}/pkgconfig \
	${PKG_CONFIG} libbpf --atleast-version 0.1.0; then
        echo "HAVE_LIBBPF:=y" >>$CONFIG
        echo 'CFLAGS += -DHAVE_LIBBPF ' $LIBBPF_CFLAGS >> $CONFIG
        echo 'LDLIBS += ' $LIBBPF_LDLIBS >>$CONFIG
        echo "yes"
    else
        echo "no"
        check_force_libbpf
	return
    fi

    # bpf_program__title() is deprecated since libbpf 0.2.0, use
    # bpf_program__section_name() instead if we support
    if ${PKG_CONFIG} libbpf --atleast-version 0.2.0 || \
        PKG_CONFIG_LIBDIR=${LIBBPF_DIR}/${LIBSUBDIR}/pkgconfig \
	${PKG_CONFIG} libbpf --atleast-version 0.2.0; then
        echo 'CFLAGS += -DHAVE_LIBBPF_SECTION_NAME ' $LIBBPF_CFLAGS >> $CONFIG
    fi
}

And in lib/bpf_libbpf.c, we add a new helper like:

static const char *get_bpf_program__section_name(const struct bpf_program *prog)
{
#ifdef HAVE_LIBBPF_SECTION_NAME
	return bpf_program__section_name(prog);
#else
	return bpf_program__title(prog, false);
#endif
}

Thanks
Hangbin

