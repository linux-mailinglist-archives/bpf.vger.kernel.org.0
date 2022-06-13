Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A288548356
	for <lists+bpf@lfdr.de>; Mon, 13 Jun 2022 11:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbiFMJWa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jun 2022 05:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiFMJW3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jun 2022 05:22:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18FEA1262A
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 02:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655112147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dMsPhpNVvNr+iFjDlmObttc0WGu8hFlqVqfZpEVrzew=;
        b=c0k4+Qck2qqVzcDxZ/v4daban6XKrRM3uFtHW7c8WlcEGa3omEXTYettCz6pfPzNwnM53r
        59O3R9luzuR1e2dNvcIzzL+jasLkfjEUaT6pUvBfs0A60feaAPRUDMfPpuQUKGLJit3/uV
        I2+J3GDDC88lM5406f53Ru70kPbB7+4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-uN_YvowAMMizsk4hdZZm0Q-1; Mon, 13 Jun 2022 05:22:26 -0400
X-MC-Unique: uN_YvowAMMizsk4hdZZm0Q-1
Received: by mail-ej1-f71.google.com with SMTP id gr1-20020a170906e2c100b006fefea3ec0aso1547312ejb.14
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 02:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dMsPhpNVvNr+iFjDlmObttc0WGu8hFlqVqfZpEVrzew=;
        b=fXFNXk+XU85fzLz9y/7vbEoFNrDP3tkLtU/pzckJMB1YcFtebQ9BINwzFuVabZxfZQ
         GxMj+a2Ym2uaHQhF1QYMJufUPVOF/5oARMJgASYP9JrYwuHiqoRZwVigR9xqQXRrwG9d
         J/cADvQvO4h0g8E2JzVg+kEV87dAVfR6ut60GoPM2ydEJ4xToORgCRaZ+zLD3dAsR0Hd
         +qQO0FFnoiGatK40CIX4uVVkRv49yLhOqWHenh+wyIFCVGSs/S7ud70922WQ3MA5Rvgu
         r4/k3QOFkJTcwKkSrCkOpH3YozP1yDEPTGTE4wDq1K0566AShamVR6l/VlbVd25TuAYH
         yh+g==
X-Gm-Message-State: AOAM531sQSZCyTrYOC5y75GYnM5szmIGDcmo83hisA0MoxG4dpZWkYhE
        /fdT5+GF+tpmZR5SbkG1IsIa2rWqp82cAthjnsSJGT83liEA3pmvx0z+tqjvU1zRlZ3gIwdfGGd
        j6CS2oZGbiqmE
X-Received: by 2002:a05:6402:ca2:b0:433:4a31:d0ee with SMTP id cn2-20020a0564020ca200b004334a31d0eemr19030571edb.288.1655112142770;
        Mon, 13 Jun 2022 02:22:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY/g6w7khMaqsUdYgiQRYbXm6AODDlqhoYxvYkUq+nE43RhLQtKmwLbYMypMxWhac6YIsmQQ==
X-Received: by 2002:a05:6402:ca2:b0:433:4a31:d0ee with SMTP id cn2-20020a0564020ca200b004334a31d0eemr19030497edb.288.1655112141611;
        Mon, 13 Jun 2022 02:22:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709060f4800b0070a50832376sm3573051ejj.154.2022.06.13.02.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:22:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2FFBA406851; Mon, 13 Jun 2022 11:22:20 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        bpf@vger.kernel.org
Cc:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        joannelkoong@gmail.com, brouer@redhat.com
Subject: Re: [PATCH] bpf: fix rq lock recursion issue
In-Reply-To: <20220613025244.31595-1-quic_satyap@quicinc.com>
References: <20220613025244.31595-1-quic_satyap@quicinc.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 13 Jun 2022 11:22:20 +0200
Message-ID: <87r13s2a0j.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com> writes:

> Below recursion is observed in a rare scenario where __schedule()
> takes rq lock, at around same time task's affinity is being changed,
> bpf function for tracing sched_switch calls migrate_enabled(),
> checks for affinity change (cpus_ptr != cpus_mask) lands into
> __set_cpus_allowed_ptr which tries acquire rq lock and causing the
> recursion bug.

So this only affects tracing programs that attach to tasks that can have
their affinity changed? Or do we need to review migrate_enable() vs
preempt_enable() for networking hooks as well?

-Toke

