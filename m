Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3193849C93A
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 13:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbiAZMEE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 07:04:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233883AbiAZMED (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Jan 2022 07:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643198643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rxu+xIvjFnCWUUg4LR7b57e/T2dW4crjuCGw7/sZ+G4=;
        b=N6r9fjS+ez5FX1entzSDn6MVERP6RvTkohHonhbEdVjxzCn2THQ0J6TwBNopR32dfQf7Ad
        wZIDvRDheucNpSsTZ6rCDXHm5mstLmvmZpieXMHWfDvXxq+fXrxstvaA+KV8mRatU1wqLP
        5bh+QxvoFgYpglmIas0JiQppRSX5ZEo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-o3WurZrOO5yT_eOKFKRP4w-1; Wed, 26 Jan 2022 07:04:01 -0500
X-MC-Unique: o3WurZrOO5yT_eOKFKRP4w-1
Received: by mail-ej1-f72.google.com with SMTP id o4-20020a170906768400b006a981625756so4785772ejm.0
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 04:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Rxu+xIvjFnCWUUg4LR7b57e/T2dW4crjuCGw7/sZ+G4=;
        b=yA8Tk0VbXibpthJSb2IxgS5gktkeWk3VjUB8ZC1OHGS7f5JBuwQD7mMUco65yA17GV
         GlwVxik9OjiTQDZ25GmsCFmzlubjeh4r1BPT+tcjdIbTTbxsm2RaqDU1dnzcnaPoiNvr
         QX/nEuV/3tG8Kk4dKNps3nEU3X4DwxqJqaYFKfCDU19e75+bJFhQIZWEwGj0/q9A2Cml
         trmxbZ2jGVz7lTx78Wct5hzSJXSjKbU9aRexQlxGHnowJHx2LIAkh3y7h+ESU1pNb0iB
         z4W1bBmu1xecm+Us0nqkrYH7n0w1HL2pF7K8JpPUpkgXb/9fVtsKujRiTSdrwBvtkWlw
         zVgA==
X-Gm-Message-State: AOAM533BDc6PLhxk5mD9kasa2kfGjHVn5ydcpxHnE/o1h4pzEt1rxUGS
        FoUQW23+0L9fWbAL/R179Lh4pE6RMi+e0JjhjEEdEFgs4WS8HP35MfJob7XyJ0qABLNfdCw9fIA
        0YAMqD6ue1/Ye
X-Received: by 2002:a17:906:5208:: with SMTP id g8mr19288932ejm.634.1643198639445;
        Wed, 26 Jan 2022 04:03:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx20qiGcount9gXgCJ4X5aF3vX+eaFsSPFELTeKR1M5Z7OzD9puXNwQl5QGT0zPpIiW6u90uw==
X-Received: by 2002:a17:906:5208:: with SMTP id g8mr19288858ejm.634.1643198638008;
        Wed, 26 Jan 2022 04:03:58 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b7sm6493432edv.58.2022.01.26.04.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 04:03:57 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EEF051805FA; Wed, 26 Jan 2022 13:03:56 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, dsahern@kernel.org,
        komachi.yoshiki@gmail.com, brouer@redhat.com, memxor@gmail.com,
        andrii.nakryiko@gmail.com
Subject: Re: [RFC bpf-next 1/2] net: bridge: add unstable
 br_fdb_find_port_from_ifindex helper
In-Reply-To: <YfEzl0wL+51wa6z7@lore-desk>
References: <cover.1643044381.git.lorenzo@kernel.org>
 <720907692575488526f06edc2cf5c8f783777d4f.1643044381.git.lorenzo@kernel.org>
 <878rv558fy.fsf@toke.dk> <YfEzl0wL+51wa6z7@lore-desk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 26 Jan 2022 13:03:56 +0100
Message-ID: <87bkzy3dqr.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> > +	rcu_read_lock();
>> 
>> This is not needed when the function is only being called from XDP...
>
> don't we need it since we do not hold the rtnl here?

No. XDP programs always run under local_bh_disable() which "counts" as
an rcu_read_lock(); I did some cleanup around this a while ago, see this
commit for a longer explanation:

782347b6bcad ("xdp: Add proper __rcu annotations to redirect map entries")

-Toke

