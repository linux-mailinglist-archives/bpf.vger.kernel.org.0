Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDDA40B47E
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 18:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhINQY3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 12:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhINQY3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 12:24:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67437C061574;
        Tue, 14 Sep 2021 09:23:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t8so16140574wrq.4;
        Tue, 14 Sep 2021 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3rpCFgurfCcMTA5Y1AV5A9LWR6I8thChoVoEzloTJLg=;
        b=bNO28cBIJ+CjPUn/HMTo3D7sYxP8usoazjqIOy2TJM9dvkBkGl+m6PdI5mESRCfRud
         Npz+qjBf01gVq63Fjje0FA8SiOWmwd58xZKSuqHKCjXwv2C1dpbOtBoQWnuDA5wmDNvV
         G8WSTBpE4OrRdJ+XV+xrY1ePBKfEjkO+2zXeUVWYe+toBURAWOMLHOrsXYvlJuD0+ybC
         khAecquh0XpJaYHnlWnH7fV8OwD7C7R6H1A1TD/CDYDgbFJdJj+JyBjqZqZRC4LZLcnu
         Fpdg/1yYbaUyiAAl2Rhu6R+Bp5Uij5RlE/D65da0GDNSPht497ne7lLnnRVkwEYBzElm
         VoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3rpCFgurfCcMTA5Y1AV5A9LWR6I8thChoVoEzloTJLg=;
        b=5icPigHdvgW4k854ieA/cZEUERHYuCNtEbvLKoUldYTPVZS+SahFmTMFY0d5n+kdIM
         mfqJn3KPj8GwA6/WHRyB+QDjGvivCq3dOcuLXtQUkP1ia2LV8WF1xCIzpsS1UUR/TLtw
         fKeTKP/lISOvsGjZ97ehtD9+QdopnCsh6yRihQ30E9FTsZo4lyL12aqdUAYRgGv0ovo4
         JGn5kyb9QPjJE3aYm+P6WQvHPm6aEvXRw+zkeXW93Ar8iUBM5dwPUsL3864zgzTwDNu7
         7lGzDnUjQkRVf1On4OsNzo1c8XXq8domTohrjvBs/TqE8mr6Dwh2AtAXZWPd9ZQRXePP
         hodQ==
X-Gm-Message-State: AOAM533EHoTFLcKjDUGNcJY4Vnyq56KVVKNpcUDCANC2uA5Di1w9oWVu
        fl5F+K0HHLSaCcgG2/hLTZYSc9sJ9f0=
X-Google-Smtp-Source: ABdhPJx0JoKZAwWg25DXyLowAawPw732sYa5rC4edTWA41aib5b9a9k1QBe7nfCleKkZwc0XJ8ijNA==
X-Received: by 2002:adf:c144:: with SMTP id w4mr20229627wre.398.1631636589684;
        Tue, 14 Sep 2021 09:23:09 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f08:4500:c813:4da2:f58a:a1e2? (p200300ea8f084500c8134da2f58aa1e2.dip0.t-ipconnect.de. [2003:ea:8f08:4500:c813:4da2:f58a:a1e2])
        by smtp.googlemail.com with ESMTPSA id u6sm12976270wrp.0.2021.09.14.09.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 09:23:09 -0700 (PDT)
To:     Guilin Tang <tangguilin@uniontech.com>, nic_swsd@realtek.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <cover.1631610501.git.tangguilin@uniontech.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 0/2] Implement XDP in r8169
Message-ID: <7b36b2ac-223f-a34a-4f86-7f4f0b027898@gmail.com>
Date:   Tue, 14 Sep 2021 18:22:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cover.1631610501.git.tangguilin@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 14.09.2021 11:31, Guilin Tang wrote:
> I implemented XDP on the r8169 driver so that people in need can use it.
> 
> Guilin Tang (2):
>   r8169:Add XDP support for pass and drop actions
>   r8169: ADD XDP support for redirect action
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 161 ++++++++++++++++++++--
>  1 file changed, 151 insertions(+), 10 deletions(-)
> 

I don't know XDP, therefore my review comments don't cover the
functionality. As prerequisite for merging this series somebody
knowing XDP would have to review the functional part.

Some comments would be helpful on which platforms and with which 
chip versions you tested.

Last but not least: I can't support the XDP extension. Therefore I'd ask you
to provide the needed support (incl. monitoring bugzilla.kernel.org) in case
of any problem reports, even if not directly related to XDP.
The XDP changes may brake other stuff.
