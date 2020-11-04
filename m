Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF282A6380
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 12:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgKDLkj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 06:40:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30971 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728508AbgKDLki (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 06:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604490037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BbXtJr1dHD0dQcJP1qBIGeMvFCv/x6tlJ+vHdKbEP2c=;
        b=MhoBzpPkUrwWiOayJfRu0fbUaiuPbcXAnSFQSNyD9LHUmpzshEK8Rw6zUjkkY51ZfMpqIy
        jZGoYaijGL4Ozk3SaBx0xIpEufkA4KVnFss+XrBas4p/2Hw0ENbYW3yHPm04ZbrOjQkqcA
        EElsUE9B2zSpN75WwNtmQc0nCRNfd0w=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-yhBkryElP8uUPp-CFF98uA-1; Wed, 04 Nov 2020 06:40:35 -0500
X-MC-Unique: yhBkryElP8uUPp-CFF98uA-1
Received: by mail-pl1-f199.google.com with SMTP id p15so9272287plr.2
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 03:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BbXtJr1dHD0dQcJP1qBIGeMvFCv/x6tlJ+vHdKbEP2c=;
        b=cD12y2FM+0d4cRplV3+poHynGyj3AdnN6eC3ZIixrutXXlyi3Sv5WdpDQPrkA55mW7
         9ejqMCLMZw4ZgHCt8AS/eequ5u7NEc3I/F2rFqEysRVPQXsD2FsbP0yVKO1ZaUvZgun2
         AfLwwD/L4wRyx3KCAqcaO4BVs9UMEZfc8QzNVgTU/oWQZdnJD0OXwE7dR7pmy3AzhpE8
         1wMy9+AsYtJlbVq9k4XzZKFxuGE3mMy/ihCcCYATL6uODUL5zWgiv0d6lkocG19davRI
         nqXatgL/ZuxjIMdK1TomN6Z8qUqOoNxUENaOqk/ugRTD2ncI426pMICi0F6WNK+t7JAm
         7KPw==
X-Gm-Message-State: AOAM530+rH6gpwbrVE0nfBakjpyqYix1UCLci63Kx1ECVDBeVVlXPxHK
        lM8zjhQortFrpsxnsGFP9qBsxkO5NMkmi41GrnH+qmkVVNQb2VqDzWyWTSyQiz9/UhFmtERWugN
        jTLg/TPQTGlY=
X-Received: by 2002:a17:902:aa97:b029:d5:ac09:c5ec with SMTP id d23-20020a170902aa97b02900d5ac09c5ecmr28486706plr.78.1604490034685;
        Wed, 04 Nov 2020 03:40:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzK1HpR5JogT3rQBpkEAcWfj0+LSPy8jNWpuodh+nKorkF/EJJoBpmGfvlQGlsW9ufuWBJ6Eg==
X-Received: by 2002:a17:902:aa97:b029:d5:ac09:c5ec with SMTP id d23-20020a170902aa97b02900d5ac09c5ecmr28486686plr.78.1604490034389;
        Wed, 04 Nov 2020 03:40:34 -0800 (PST)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y141sm2158651pfb.17.2020.11.04.03.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 03:40:33 -0800 (PST)
Date:   Wed, 4 Nov 2020 19:40:22 +0800
From:   Hangbin Liu <haliu@redhat.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     David Ahern <dsahern@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCHv3 iproute2-next 1/5] configure: add check_libbpf() for
 later libbpf support
Message-ID: <20201104114022.GS2408@dhcp-12-153.nay.redhat.com>
References: <20201028132529.3763875-1-haliu@redhat.com>
 <20201029151146.3810859-1-haliu@redhat.com>
 <20201029151146.3810859-2-haliu@redhat.com>
 <78c5df29-bf06-0b60-d914-bdab3d65b198@gmail.com>
 <20201103055419.GI2408@dhcp-12-153.nay.redhat.com>
 <e3368c04-2887-3daf-8be8-8717960e9a18@gmail.com>
 <20201104085149.GQ2408@dhcp-12-153.nay.redhat.com>
 <87361pwf8k.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87361pwf8k.fsf@toke.dk>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 04, 2020 at 12:09:15PM +0100, Toke Høiland-Jørgensen wrote:
> > +usage()
> > +{
> > +       cat <<EOF
> > +Usage: $0 [OPTIONS]
> > +  -h | --help                  Show this usage info
> > +  --no-libbpf                  build the package without libbpf
> > +  --libbpf-dir=DIR             build the package with self defined libbpf dir
> > +EOF
> > +       exit $1
> > +}
> 
> This would be the only command line arg that configure takes; all other
> options are passed via the environment. I think we should be consistent
> here; and since converting the whole configure script is probably out of
> scope for this patch, why not just use the existing FORCE_LIBBPF
> variable?

Yes, converting the whole configure script should be split as another patch
work.
> 
> I.e., FORCE_LIBBPF=on will fail if not libbpf is present,
> FORCE_LIBBPF=off will disable libbpf entirely, and if the variable is
> unset, libbpf will be used if found?

I like this one, with only one variable. I will check how to re-organize the
script.

> 
> Alternatively, keep them as two separate variables (FORCE_LIBBPF and
> DISABLE_LIBBPF?). I don't have any strong preference as to which of
> those is best, but I think they'd both be more consistent with the
> existing configure script logic...

Please tell me if others have any other ideas.

Thanks
Hnagbin

