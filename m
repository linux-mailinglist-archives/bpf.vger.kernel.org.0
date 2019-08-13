Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D998B42D
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2019 11:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfHMJdc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Aug 2019 05:33:32 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:53789 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfHMJdc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Aug 2019 05:33:32 -0400
Received: by mail-wm1-f49.google.com with SMTP id 10so846644wmp.3
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2019 02:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MlR2rn9zThqqmBqWlzW7EqR2TgaSWvTZCGypbjFEDiY=;
        b=X4zF5sDgHXJn+8pNouCDO0v+RWNoI9+wEHnZS12zqg8b5GYhO+/nvXXbbm5kV4LEcj
         pDNBvS/n54JrgwETuMMOEP9Z3mHftdRJLwzM7Z6I1Ljj+ps9zFEOQ2NIhErYNrDqtHqz
         d/Z1pswbGT/99Hmo7qXZfSyvJILBIkIl8tY7DKqTF2Ii3vWbBllGKg/UX00e6zfgPC7r
         Ef8rEamr29/RcID0eFKbeUzlQE9u1ZgO5pCn3M/uKr4MIw4F+HEi9RLRM0wy0ORxkMYN
         ULgBKjAR07jKQIGQTYdHnCrZKht+lbrBR56skGnNinMbnOiXrqbFAz+4pbkRq0ycxjar
         pHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MlR2rn9zThqqmBqWlzW7EqR2TgaSWvTZCGypbjFEDiY=;
        b=fFqthZzzbRw37rtL6xDj8WIEH8rKQwJJs1GZd96J++Nh1fxmsTmQmR+REAQJNF87l6
         +NeOKHYTS35KKWkDbwF7NH0lvJCn3X0fCT/qC0cIEgrCRRwheWdX5Gp4g1bI9UfZkC8f
         XPQlU42Q2iXjWFWRsP+34IS5/7o09udSiJWZE7eBBdw1qex+dgdbYTeHPwliPV00ykMU
         0smnqT43+6BOU60qsJG8uVAde3eUbrnEif12obPAaEQXl0tm34d1+m/yA2rdjXUfyyVy
         3igRUMlrQmmutIHGJ7axvLokyccbXWSnTiABg2mRy3NHH6JskmXJ5m05cJV/QCCMvOiE
         zVzA==
X-Gm-Message-State: APjAAAVchU/LOU/L+M35Zlyb+s0wAMuTvGUpdaVq9BENjj2SgR/aVkwZ
        2tSt/QJzm8/nUopnbroWkpo2i29PVbs=
X-Google-Smtp-Source: APXvYqxmAMHNUTlNacw/cR8fY/SukXmqu+Q979YuGUmmgGaWBLmN1RZl+Xu+CzHgOsXsN755PKuYjA==
X-Received: by 2002:a05:600c:24cf:: with SMTP id 15mr2074434wmu.76.1565688810013;
        Tue, 13 Aug 2019 02:33:30 -0700 (PDT)
Received: from [172.20.1.137] ([217.38.71.146])
        by smtp.googlemail.com with ESMTPSA id k124sm2146043wmk.47.2019.08.13.02.33.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 02:33:29 -0700 (PDT)
Subject: Re: Taking a day off...
To:     jakub.kicinski@netronome.com
Cc:     bpf@vger.kernel.org
References: <20190812.212659.1072592048193337024.davem@davemloft.net>
From:   =?UTF-8?Q?Pablo_Casc=c3=b3n?= <pablo.cascon@netronome.com>
Message-ID: <77f93fa7-c4a6-39a5-32c2-e82c61f9fcf9@netronome.com>
Date:   Tue, 13 Aug 2019 10:33:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190812.212659.1072592048193337024.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Wow this is big! Congratulations Kuba!

On 13/08/2019 05:26, David Miller wrote:
> Hello everyone,
>
> Tomorrow I will be letting Jakub Kicinski manage the net and net-next
> GIT trees.  So he will be integrating patches into GIT and doing git
> pulls from people.  He will alway keep the patchwork states up to
> date, just like I do.
>
> I completely expect everyone to give Jakub the same respect and
> consideration they usually give to me, because he deserves it.
>
> In the future, when I need to take a few days off, I will hand things
> over to Jakub in a similar way.
>
> Thank you.

