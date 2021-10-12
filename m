Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CA642A0E7
	for <lists+bpf@lfdr.de>; Tue, 12 Oct 2021 11:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhJLJXB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Oct 2021 05:23:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21335 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235418AbhJLJXA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Oct 2021 05:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634030458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQvvX7DYevVvifiKrUIFSDiboyiIsSpy6G0Ys71FCOg=;
        b=T30TKiUxnllJDv6O9DwNZ2FofEe3FfOKwHwVpNNSKCADbQrU0RjEAeEqZfUar+iiSLMa2f
        H13Kqmm+/ScTROawM/rouTI9pEpRcEM1EJh77HSy2qpLnezQ/LSD4NEboct85IOuWpm4f5
        3ypQg8UhjwpSGegTMtO3udr7J3dcOWw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-6svPFOdrOSCWPfw9RcQMBg-1; Tue, 12 Oct 2021 05:20:56 -0400
X-MC-Unique: 6svPFOdrOSCWPfw9RcQMBg-1
Received: by mail-wr1-f72.google.com with SMTP id 75-20020adf82d1000000b00160cbb0f800so14552409wrc.22
        for <bpf@vger.kernel.org>; Tue, 12 Oct 2021 02:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NQvvX7DYevVvifiKrUIFSDiboyiIsSpy6G0Ys71FCOg=;
        b=gGY4JMN4KEv8LN1VWVmp+gslOUqjIMhXOpBG/1SyZbuJbIiUzxXNQ2s87jqBozWvOx
         006cyVmK2CvzMR9M77wLVO+PmtvTejs3qymGzS2LaZXGpeH2QdbaVYCqJknSBDgYuJ/r
         jUvLceBvufq2/vJIP8ogNC+uA6bbnzcNo90CLvQpdIWUtvIazdOvW9clIjlKMQdRd/er
         OEcWq82tkI4+jlzqTDbtaiNbGE3cdpPHXGcLsIHlpcYDFQBCgY/uGt4d0iHhNgg4o4i4
         jxyEcY+T5GcLZDPnBkTFrI2A4zlwE7Xcs4D2nCLlRBRYmihKRN+l1RSqK8MDLifYpOQL
         20ug==
X-Gm-Message-State: AOAM532QHlypoLscCmwEjUQiRo31FDwVOtSmo9mylcuiVM/18/iDy8J7
        RN7Rb0qICH8WDPiswVCAu64zswzZgko2u92nglb32OaydpXBUy7rOJ8x0S5zqviJsj8m5I1KE+t
        c84NYdMryc0U8
X-Received: by 2002:a1c:a9d5:: with SMTP id s204mr4267013wme.193.1634030455617;
        Tue, 12 Oct 2021 02:20:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywk9hzf7x2/zkP49ad7b+yMh+89MNX7bHIg+1V/CfDIKZ/l9tK1gZVUSfBDowQDZu+/gW3aA==
X-Received: by 2002:a1c:a9d5:: with SMTP id s204mr4266983wme.193.1634030455431;
        Tue, 12 Oct 2021 02:20:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-16.dyn.eolo.it. [146.241.231.16])
        by smtp.gmail.com with ESMTPSA id p11sm2137819wmi.0.2021.10.12.02.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 02:20:55 -0700 (PDT)
Message-ID: <b6441514ee17eb12934dad304854939308f5c4c1.camel@redhat.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in veth_xdp_rcv
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        syzbot <syzbot+67f89551088ea1a6850e@syzkaller.appspotmail.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>
Date:   Tue, 12 Oct 2021 11:20:53 +0200
In-Reply-To: <20211011164747.303ffcd0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <000000000000c1524005cdeacc5f@google.com>
         <20211011164747.303ffcd0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2021-10-11 at 16:47 -0700, Jakub Kicinski wrote:
> CC: Paolo, Toke

Thanks for the head-up! will look at this soon.

Cheers,

Paolo

