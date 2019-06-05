Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCF7C35C10
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2019 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfFELvo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jun 2019 07:51:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40236 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfFELvn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jun 2019 07:51:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so14312704wre.7
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2019 04:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KJ3vSGgyORrvU6rv7Vd/aRyYxs/h9/TJdjXOUcZUHdg=;
        b=iJiHvCrASg90jqAAcFWfGNGsju46omR2yCfQINcDkRHNjx56o3zWqXT7uvAb/Li9vQ
         zEGeji+4nSWvp/Utep7wMso1P3EFCVga/j/ZZOnpO7VvgNOyFbrCT1pP3PaPOgDNcPmw
         JAYzCria9T77Q9XY2FpmNQRRXymO3ROzGV6T5OWr3D+YB29a6emG58FSVyyNHXJBzXdI
         kTVX4RbLl9mW1GU4O8frTq4hXsh9LQOwKQNYgcW/zJHTpQ+t1FTxQ5Xi5x2e3/qrC4zv
         8qqxBUXRn+Gmjs585F/jeotvYZO6QI4pj1FtHuEzQ84i2w5MecBXFEWFJfKeqY9gC3u2
         TcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KJ3vSGgyORrvU6rv7Vd/aRyYxs/h9/TJdjXOUcZUHdg=;
        b=kyXmKBjYwFgK0E2w9G1oxXgLajs3KsxtloYkKiikcvwkPZ+1dVwhYo2wNBN3TI9R6I
         xA8WzYfN037HodYJEEcvpLNJkRdbIPKXuRREzPuY4u/YNKrmlybQcH/jJX8FAMpID1bO
         wQrelhu8xmnWJS8sf3PCm/WYErd+3BcU1aAAUt3uUvjoyfMKvFsLaIN25yJOxZIeO9fa
         rM74Ve7cJ9fFNCoQaBF9SaqfmzwQwXM8HymPU0/F6AiGDTXCKJULsN4K8oNZbGc4EOHe
         Ka2apEibWGL0nsfvuIJvay9mYL5H7IS65ZPDu47CjORnJuoiURYYimG/de5fKbWAWvAC
         2LVA==
X-Gm-Message-State: APjAAAWvWZ2XWQnAEyaMHBuGFDiE/LKNzMNwvicgYKfqBONBTiSfA6k7
        LtYcH86SxS0tBRLt4Tp46vTqAgxagnE=
X-Google-Smtp-Source: APXvYqxmmwsxsPhKKvybZ7OoTCjJJefPEKhz5dNVQ551z/CnXZdi3hRDobh8ThZMftMCWsgitRK38w==
X-Received: by 2002:adf:ba47:: with SMTP id t7mr24177086wrg.175.1559735501458;
        Wed, 05 Jun 2019 04:51:41 -0700 (PDT)
Received: from ?IPv6:2a01:e35:8b63:dc30:c5ec:3696:b85c:3139? ([2a01:e35:8b63:dc30:c5ec:3696:b85c:3139])
        by smtp.gmail.com with ESMTPSA id r131sm9514282wmf.4.2019.06.05.04.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 04:51:40 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [RFC][PATCH kernel_bpf] honor CAP_NET_ADMIN for BPF_PROG_LOAD
To:     Andreas Steinmetz <ast@domdv.de>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <56c1f2f89428b49dad615fc13cc8c120d4ca4abf.camel@domdv.de>
 <1188fe85-d627-89d1-d56b-91011166f9c7@6wind.com>
 <f3b59d9ac00eec18bc62a75f2dd6dbba48da0b35.camel@domdv.de>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <f8488876-a507-2e27-b140-e8168a6f117c@6wind.com>
Date:   Wed, 5 Jun 2019 13:51:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f3b59d9ac00eec18bc62a75f2dd6dbba48da0b35.camel@domdv.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Le 05/06/2019 à 12:59, Andreas Steinmetz a écrit :
[snip]
> If there is a change for this to get accepted, sure, I'm willing to
> submit this formally (need some advice, though).
At least, you need to submit it without the RFC tag. RFC patches are not aimed
to be merged.


Regards,
Nicolas
