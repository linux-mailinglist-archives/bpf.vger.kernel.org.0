Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9A0546E7E
	for <lists+bpf@lfdr.de>; Fri, 10 Jun 2022 22:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347934AbiFJUeb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jun 2022 16:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350378AbiFJUea (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jun 2022 16:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC62C302233
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 13:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654893265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+aGFkn3MMYrpYUMA1fpcNyVhojWLAMYD9npxZIcNjY=;
        b=inj+FjTL2Zgjyvy8+cFIKVwue6d5r2zU6R+/GpVI8qkhVqsZk95qvM2lJamI7XSClChP+T
        wMBFhGThj95y76w0LfI0zx4SjUoGMuZ+diursiqHCDugbrlfysJJAhQvaGLW602myoN1SH
        0YUO6S56eonQy44YqyxNRrRCcxF3mSg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-QGuvHLU0O5u1ltSp7PCvRA-1; Fri, 10 Jun 2022 16:34:23 -0400
X-MC-Unique: QGuvHLU0O5u1ltSp7PCvRA-1
Received: by mail-ed1-f69.google.com with SMTP id x8-20020a056402414800b0042d8498f50aso141924eda.23
        for <bpf@vger.kernel.org>; Fri, 10 Jun 2022 13:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=D+aGFkn3MMYrpYUMA1fpcNyVhojWLAMYD9npxZIcNjY=;
        b=rwxh+ITunZj78jfK/g0eTe/cw7VGVepId5JwrhxbWpv5k8rY1uUECVK203rBfDql9Q
         wQOk5I7NA1USIrqn7HOqCYw2DkKYqaAAHKuwAeXfRv7HQkq/uGDW3V49qVJ/mqnUPY5A
         dv2i41hodP7ZKU1eTkh/bvDPG3q6aGT36pTCuB8va4JF1HDE/GO8NQ5uNAbaCkuyPRmx
         g5OUuEbUHz7gGAf4fMedlu+/dswGOAIce+GO2Xi7tiVcN6K3XOeSzAYCHINTxBKWoweY
         V0Ttbo+3nN188gBVvsoG95wEO9ig2SPYdq51FKgPUyOsXOADSjM3qMkjwvx98RQkjCqC
         cgZw==
X-Gm-Message-State: AOAM532DCh5HYi8tjsdrsjk+Z/W4u08Up1kkFvT+XBLw17OWrvl8mEeT
        sS61ZO+VyPBE2UINpvGbjQsE4SCRXnbBr6Sj/umlKT9Vn1HPK5pMyEfPacPK2LgWNpooXau8mq+
        jnhRJG1Vr2caK
X-Received: by 2002:a17:906:6a23:b0:711:ea9b:89ba with SMTP id qw35-20020a1709066a2300b00711ea9b89bamr16479281ejc.740.1654893262623;
        Fri, 10 Jun 2022 13:34:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy54XjL5JCCSDth3af7e2nucI8bVR0HXVWY21qrdLfe3Lb/fYbqAbb0m4MQ/MCGGL7tfpObLA==
X-Received: by 2002:a17:906:6a23:b0:711:ea9b:89ba with SMTP id qw35-20020a1709066a2300b00711ea9b89bamr16479269ejc.740.1654893262291;
        Fri, 10 Jun 2022 13:34:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id jw15-20020a17090776af00b006fec9cf9237sm29367ejc.130.2022.06.10.13.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 13:34:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8E880405EFB; Fri, 10 Jun 2022 22:34:20 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        kpsingh@kernel.org
Cc:     weiyongjun1@huawei.com, shaozhengchao@huawei.com,
        yuehaibing@huawei.com
Subject: Re: [PATCH v6,bpf-next] samples/bpf: check detach prog exist or not
 in xdp_fwd
In-Reply-To: <20220606005425.261967-1-shaozhengchao@huawei.com>
References: <20220606005425.261967-1-shaozhengchao@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 10 Jun 2022 22:34:20 +0200
Message-ID: <87edzw2r77.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Zhengchao Shao <shaozhengchao@huawei.com> writes:

> Before detach the prog, we should check detach prog exist or not.
>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

LGTM!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

