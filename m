Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5B82A62EF
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 12:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgKDLJ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 06:09:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728029AbgKDLJZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 06:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604488164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mwFz6PHL5LvmiEInAN/VyJIuFAuUG8rjzo6eKGPB1u0=;
        b=FoC6RVRuKo2ibKi6cJlvHEr7/jrk/R4ORzf1oNq7h4jgTB4xELythGyZchuLwm7kT6QLdS
        zq0ddTQalqhB332tXxqwYUh2qP7U7y48Y7DGLMvc/TKyHLI81wtIz2OoMAH96nfxHXcLRE
        iAPppscWTgOaizhxRFZ6AZCWFOM3eeg=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-RW49G0NfNCu4NQNd2CRKzw-1; Wed, 04 Nov 2020 06:09:20 -0500
X-MC-Unique: RW49G0NfNCu4NQNd2CRKzw-1
Received: by mail-il1-f198.google.com with SMTP id u17so7407584ilb.4
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 03:09:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mwFz6PHL5LvmiEInAN/VyJIuFAuUG8rjzo6eKGPB1u0=;
        b=Y5g6gSW9gBOmc852uMEDTq1aUqgctht1ovtIDNWfwpDqfmSbaG3iIQUWRCMfvfXGh7
         2hxXD47hyg/Pt+L+MB2NqnEE5AVaJ/5vSgYYzW0fwh/6HyHb31C8PfwwwDMWSh4Uvx2C
         CApSK4EYfz4AyFSkM1nxlxxFPDqD0hJF74M4NP1vIRAL3oIitz69eN7EOuHBjYaOnguB
         +xn82L1rVvDtYuzkuuJ+/nuRXzGn7Fkf+TaqEQfDoheux9KIjw73Z2XlQSI/lU620liA
         15zO+/vWGw3VrEomjBeWilYg5KoKJBm8QIh4upkapMivbz8uV43iADeVbW/p8hNksBPE
         DiKw==
X-Gm-Message-State: AOAM532s++VNMZuNDpHEulpZ1l3PUUXVCdLRTgl09zOtjfNHpe6gSJU5
        US7zN8FMTuOiAMfhVCr+notw6ajx9IiMev/Uk5m+gF+BFroN+vkKzux80eBlWNlKbWxrJZk4X32
        bP2sqv+SDVAax
X-Received: by 2002:a05:6638:2110:: with SMTP id n16mr18823303jaj.61.1604488159736;
        Wed, 04 Nov 2020 03:09:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzj2sPfhdLovngsaUwxSlWdddc4cXRL+htgtAydUgUFnm9Ep6PtKqOwEfTZt9ocA3JZOy4YTQ==
X-Received: by 2002:a05:6638:2110:: with SMTP id n16mr18823280jaj.61.1604488159320;
        Wed, 04 Nov 2020 03:09:19 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j10sm973698iop.34.2020.11.04.03.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 03:09:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 862CB181CED; Wed,  4 Nov 2020 12:09:15 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Hangbin Liu <haliu@redhat.com>, David Ahern <dsahern@gmail.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
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
In-Reply-To: <20201104085149.GQ2408@dhcp-12-153.nay.redhat.com>
References: <20201028132529.3763875-1-haliu@redhat.com>
 <20201029151146.3810859-1-haliu@redhat.com>
 <20201029151146.3810859-2-haliu@redhat.com>
 <78c5df29-bf06-0b60-d914-bdab3d65b198@gmail.com>
 <20201103055419.GI2408@dhcp-12-153.nay.redhat.com>
 <e3368c04-2887-3daf-8be8-8717960e9a18@gmail.com>
 <20201104085149.GQ2408@dhcp-12-153.nay.redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 04 Nov 2020 12:09:15 +0100
Message-ID: <87361pwf8k.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hangbin Liu <haliu@redhat.com> writes:

> On Tue, Nov 03, 2020 at 10:32:37AM -0700, David Ahern wrote:
>> configure scripts usually allow you to control options directly,
>> overriding the autoprobe.
>
> What do you think of the follow update? It's a little rough and only controls
> libbpf.
>
> $ git diff
> diff --git a/configure b/configure
> index 711bb69c..be35c024 100755
> --- a/configure
> +++ b/configure
> @@ -442,6 +442,35 @@ endif
>  EOF
>  }
>
> +usage()
> +{
> +       cat <<EOF
> +Usage: $0 [OPTIONS]
> +  -h | --help                  Show this usage info
> +  --no-libbpf                  build the package without libbpf
> +  --libbpf-dir=DIR             build the package with self defined libbpf dir
> +EOF
> +       exit $1
> +}

This would be the only command line arg that configure takes; all other
options are passed via the environment. I think we should be consistent
here; and since converting the whole configure script is probably out of
scope for this patch, why not just use the existing FORCE_LIBBPF
variable?

I.e., FORCE_LIBBPF=on will fail if not libbpf is present,
FORCE_LIBBPF=off will disable libbpf entirely, and if the variable is
unset, libbpf will be used if found?

Alternatively, keep them as two separate variables (FORCE_LIBBPF and
DISABLE_LIBBPF?). I don't have any strong preference as to which of
those is best, but I think they'd both be more consistent with the
existing configure script logic...

-Toke

