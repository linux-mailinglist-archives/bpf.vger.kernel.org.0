Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888A443D637
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 00:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhJ0WGM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 18:06:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229928AbhJ0WGK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Oct 2021 18:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635372223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ivJoc+D4kdpuDzvrSqI7vix80j2b31Z3Ev5flf6hx9I=;
        b=iUqS63JMPV401oss8N/wyvbCsBiRHYjnWL8kl0rycg3CnqP+T3XUO/niHDJnaWsCmlGXj9
        emSRn0jjZrDxhNwaf+mDie3gvgmiuC9Io10LkAe8HdTOSxYd+KWkzwyZ5bGOtmAtqzLMzd
        HQLD8Rm480vzz6r2gnl3BZnObzhSeZA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-_jXXZC66MS6wFdcnI2Uiqg-1; Wed, 27 Oct 2021 18:03:42 -0400
X-MC-Unique: _jXXZC66MS6wFdcnI2Uiqg-1
Received: by mail-ed1-f71.google.com with SMTP id i9-20020a508709000000b003dd4b55a3caso3619508edb.19
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 15:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ivJoc+D4kdpuDzvrSqI7vix80j2b31Z3Ev5flf6hx9I=;
        b=TNsdIeXnB3SCftx33iLhpm2ik5vimh0f7up9UsOty55Hxbnzs3euMh9RPHa0kPFHUM
         AK5HwyjmR5HmV2cmO8XEaQq3Z2gL2kEDsZrgmqARpZcib9qhEtLoIlqfkTBUA4OxWDTM
         A7DDvEHaNdaygMuabViDxlh/yDsxZBI3XtyN/f2Sj04PgCcu233FASbnIC+gAlomHwKd
         bBZiHdWezv1VOAODEg6HkNM/WZiRnDs1nPOBNiYN2fGCKa+y9aoOTYejKKNVBDDD/s9h
         jSKqRqqZ7kBaWsQMDD6qcMUdxWy0DlntlMPgx8z5FUN4jn+pzGc0B6XqW9ifLbR6N1SS
         KdqA==
X-Gm-Message-State: AOAM5306pD9vNIMzG/Dci2ZXoKaiepbrCbmtKSwMGqC7dmYwR5SyRt7k
        rbz249K+rbUw5Q7JXD+HYnaYYnB20G4p/zm7yPOQpfqVgG4dHqyxTKBkuoki9+aSfkmZ7OgmdRS
        daF89rIj2Q3sF
X-Received: by 2002:a17:906:2505:: with SMTP id i5mr300662ejb.450.1635372220221;
        Wed, 27 Oct 2021 15:03:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOFadTn1wI9p1W0PpE5i2kpyqQPmBKw7giZKvXodqFBvoZqJBFDxufHf6J0BnECfffgS0UMg==
X-Received: by 2002:a17:906:2505:: with SMTP id i5mr300564ejb.450.1635372219262;
        Wed, 27 Oct 2021 15:03:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i5sm454997ejw.24.2021.10.27.15.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:03:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 29A8B180262; Thu, 28 Oct 2021 00:03:38 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net
Cc:     kuba@kernel.org, daniel@iogearbox.net, ast@kernel.org,
        andrii.nakryiko@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: pull-request: bpf 2021-10-26
In-Reply-To: <20211026201920.11296-1-daniel@iogearbox.net>
References: <20211026201920.11296-1-daniel@iogearbox.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 28 Oct 2021 00:03:38 +0200
Message-ID: <87bl3a9lc5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> The following pull-request contains BPF updates for your *net* tree.
>
> We've added 12 non-merge commits during the last 7 day(s) which contain
> a total of 23 files changed, 118 insertions(+), 98 deletions(-).

Hi Daniel

Any chance we could also get bpf merged into bpf-next? We'd like to use
this fix:

> 1) Fix potential race window in BPF tail call compatibility check,
> from Toke H=C3=B8iland-J=C3=B8rgensen.

in the next version of the XDP multi-buf submission without creating
merge conflicts. Or is there some other way we can achieve this without
creating more work for you? :)

-Toke

