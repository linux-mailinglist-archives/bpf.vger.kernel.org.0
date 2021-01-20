Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DC82FD248
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 15:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbhATODq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 09:03:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729761AbhATMv5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Jan 2021 07:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611147028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FgtmT7oyB4+BZGxXW283sMZNQtbZEDm4kcB1F6Sl1nI=;
        b=O3VQMnJ3liAqO8scBxm3Maqv35J6hgDc11lKJwQTnDlchSPI3eCG4sE7/evy1GjaMIUE3f
        LiGPnppFz9Ig2MZfe7aFQAsLJ2nGUTgNIsJhg8+tcYv8P+XX+Fajo/XIyVVLiJgWF1tbzV
        3gEDIwU7vcdDY4RRFxBaD4dKQwAxWNI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-yaHj9EVDOvOhk_cx8vuU8Q-1; Wed, 20 Jan 2021 07:50:26 -0500
X-MC-Unique: yaHj9EVDOvOhk_cx8vuU8Q-1
Received: by mail-ed1-f72.google.com with SMTP id n18so10995486eds.2
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 04:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FgtmT7oyB4+BZGxXW283sMZNQtbZEDm4kcB1F6Sl1nI=;
        b=C4DUNVYRYdzEhuk0+EWf+/0KMog/QSJRQe66AuMUq+DP27FuT7e5afw9Tig8S9ee2k
         /mh8hu0PMq9GAx95tJHfR4vrmUR3pvTsX6/E9GF5fat/ELRbmPsRlOB2+nbBthQrPCkQ
         pnxyNZc7agSrBFr8v7tEnP+yKw1P5JH6hWiAIVqCMe7s1kGW5Nv0wtPvS2TqSBdETJRn
         FVbwo+bLz2dxHRsFAd6zHM8ykqSqfAO5wDm4oR+xJeTI1qbvHfS4VMOpFr2xh9DUaDJ2
         d1O2Hb3tN4kopFyyj9DBLJJMuEs8ItDB+jh3RmEORlC1IE2spOu/yaG3vtnq1dwuQH/y
         eB8w==
X-Gm-Message-State: AOAM530LI2Y0wbgvdPpkbcQOiUsSnwQoBgjI5mNWtaVvZVxjpeBwBlFB
        Vh0J1vAVQX36BHI1TTag48qXCpU1Fu+MFgeUCFA0FKZApPBNc6zHNouc95aWDPks5TuGmFIWXcF
        6BACiewO2GYT6
X-Received: by 2002:a17:906:5ad0:: with SMTP id x16mr6040262ejs.135.1611147025316;
        Wed, 20 Jan 2021 04:50:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxaxZWl+/YMWwbuqraUC6T0NeROqhnDgyVf+0k+coBVMt2KohSEHaHtlv7ZWpCBfkajCid8Ng==
X-Received: by 2002:a17:906:5ad0:: with SMTP id x16mr6040247ejs.135.1611147025192;
        Wed, 20 Jan 2021 04:50:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z1sm1085637edm.89.2021.01.20.04.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 04:50:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 31D6D180331; Wed, 20 Jan 2021 13:50:24 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        kuba@kernel.org, jonathan.lemon@gmail.com, maximmi@nvidia.com,
        davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        ciara.loftus@intel.com, weqaar.a.janjua@intel.com
Subject: Re: [PATCH bpf-next v2 4/8] xsk: register XDP sockets at bind(),
 and add new AF_XDP BPF helper
In-Reply-To: <20210119155013.154808-5-bjorn.topel@gmail.com>
References: <20210119155013.154808-1-bjorn.topel@gmail.com>
 <20210119155013.154808-5-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 20 Jan 2021 13:50:24 +0100
Message-ID: <878s8neprj.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c001766adcbc..bbc7d9a57262 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3836,6 +3836,12 @@ union bpf_attr {
>   *	Return
>   *		A pointer to a struct socket on success or NULL if the file is
>   *		not a socket.
> + *
> + * long bpf_redirect_xsk(struct xdp_buff *xdp_md, u64 action)
> + *	Description
> + *		Redirect to the registered AF_XDP socket.
> + *	Return
> + *		**XDP_REDIRECT** on success, otherwise the action parameter is retur=
ned.
>   */

I think it would be better to make the second argument a 'flags'
argument and make values > XDP_TX invalid (like we do in
bpf_xdp_redirect_map() now). By allowing any value as return you lose
the ability to turn it into a flags argument later...

-Toke

