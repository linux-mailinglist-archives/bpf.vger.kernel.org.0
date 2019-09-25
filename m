Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0467FBDC33
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2019 12:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389925AbfIYKdx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Sep 2019 06:33:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387892AbfIYKdx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Sep 2019 06:33:53 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAC97862E
        for <bpf@vger.kernel.org>; Wed, 25 Sep 2019 10:33:52 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id g65so5048111qkf.19
        for <bpf@vger.kernel.org>; Wed, 25 Sep 2019 03:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZZGk1175G8uwjvxdK1U1C4fRiS6VV+Ha9+4WTc5Wkb8=;
        b=tf2K1ELuc1Mz72M8A3SAzKA8dVDTOQBBWX06/mf2OYQRgXnH5cfybiIoXjZz8mZw7O
         FSgLwt9XqFBRELnC/Gs62ge6KO+aupGkPC6rdow+OQcUvHkJXEkKCkZJW6ZJy6oiGTmX
         cEB8SpsagB5MZsTzjkQcPjL+IN9sakFWFrblelnRtBYqcPNeLGrXFAUm9PfxgYzSAmxt
         BoMNTzWN6fwTzNJ2eDh5yC1CwGbmiOv6i5M459Id7FEoDV0dpXEGecOOcVXbpjSDDDqC
         fbgJuCZdum9ECuRzW5ARmAH5kgqj2sPuhNtpkgEd3S1PFsZhng8FtkqWVlf8C0MLxYBS
         +iVw==
X-Gm-Message-State: APjAAAWa38nFv3+2FcAvmb2cPz7hBzdg+sICDq1mgZgrMJV5CFlqsdoG
        J/LfbxO+xgzsc2mNKHhWlPFCGxOfDHDbVz/4Fo+VZAKGwrNrRvL14uhKC/6xYoCpuchWRpV/nfA
        3ZA5JLan/zR4c
X-Received: by 2002:ac8:16d9:: with SMTP id y25mr7908726qtk.72.1569407632038;
        Wed, 25 Sep 2019 03:33:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyx21jj+mlIngD68uZdaLQCpjtwuHMb97xiyJA7Kj8yCO0n3y++SdmxXgWgD4cZyTugtzknMw==
X-Received: by 2002:ac8:16d9:: with SMTP id y25mr7908708qtk.72.1569407631903;
        Wed, 25 Sep 2019 03:33:51 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id x59sm2645454qte.20.2019.09.25.03.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 03:33:51 -0700 (PDT)
Date:   Wed, 25 Sep 2019 06:33:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Matt Cover <werekraken@gmail.com>
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        Jason Wang <jasowang@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Matthew Cover <matthew.cover@stackpath.com>,
        mail@timurcelik.de, pabeni@redhat.com,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        wangli39@baidu.com, lifei.shirley@bytedance.com,
        tglx@linutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] tuntap: Fallback to automq on
 TUNSETSTEERINGEBPF prog negative return
Message-ID: <20190925063142-mutt-send-email-mst@kernel.org>
References: <20190920185843.4096-1-matthew.cover@stackpath.com>
 <20190922080326-mutt-send-email-mst@kernel.org>
 <CAGyo_hqGbFdt1PoDrmo=S5iTO8TwbrbtOJtbvGT1WrFFMLwk-Q@mail.gmail.com>
 <20190922162546-mutt-send-email-mst@kernel.org>
 <CAGyo_hr+_oSwVSKSqKTXaouaMK-6b8+NVLTxWmZD3vn07GEGWA@mail.gmail.com>
 <CAGyo_hpCDPmNvTau50XxRVkq1C=Qn7E8cVkE=BZhhiNF6MjqZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGyo_hpCDPmNvTau50XxRVkq1C=Qn7E8cVkE=BZhhiNF6MjqZA@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 22, 2019 at 03:46:19PM -0700, Matt Cover wrote:
> Unless of course we can simply state via
> documentation that any negative return
> for which a define doesn't exist is
> undefined behavior. In which case,
> there is no old vs new behavior and
> no need for an ioctl. Simply the
> understanding provided by the
> documentation.

Unfortunately this isn't sufficient: software can easily return a wrong
value by mistake, and become dependent on an undefined behaviour.

-- 
MST
