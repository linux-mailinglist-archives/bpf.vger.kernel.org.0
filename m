Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7213116AB7
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2019 11:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfLIKQy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Dec 2019 05:16:54 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36550 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLIKQy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Dec 2019 05:16:54 -0500
Received: by mail-lf1-f66.google.com with SMTP id n12so10253414lfe.3
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2019 02:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qOKG0+zt5rwTj67LJxDX/qCimE6XOpAXlc+hx+8G88c=;
        b=mxPOdgo3h5IcRezHEIpYv72O7EeJPO7m6ruRm+zfckYMOe9GiFe9eOIc8c6/PD+D/6
         5b3lRFmdmVu4VZfg7EphJWq6xzbFZm6otThp2/Pkf+ENTfxfBxf2yOrw10OHn8pJsMWC
         vgYpPuXwppbs0ZdKbgI7sTU4fzjFyr+z78WS6ZNyx3SUxs+V+JcT2Wueo2KBLzJfvTPl
         xrtqWJFYgba/t8z1V207cxyKyfcRcKNXChzX/jVq3Q/FEvFjCx4baBa1lBV1oEBGGD95
         jvLbugQ06JC/N4e0FgiiNsK/w+Uw5mMfIvsmYB2NBCRAC3IyFYglhlNxRNvyc1ecHkud
         ceFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qOKG0+zt5rwTj67LJxDX/qCimE6XOpAXlc+hx+8G88c=;
        b=pdFSI7xmrS8upBqN88239J1xodSKDx7b5+7iAySOEakp4nug2urjY8rEp6in4rec2G
         qDJliHkRo4r75cBmZHQ1sDIbbR//t8b7cTKOJTsUDO8qUNTbV1GmW61XeAG2wu8ybmM4
         nx2C60XX/ul87aJy5iTc5onKrr8Of1fbQsamZ4wZI48uyf5LC5yE85intItV8OuXX/bJ
         CeIkkH5K7xMCm1Fz1q/6uiTkOAt9s2nFu9Cp9E3yDsRze/WtQv1VkmZm7BfgmWYYmw50
         vfVo4x9qbMP7T2V7HCIo5LT7EAlkrx9lWDUacgsPKYiD06ww3VHA8LkrRdyJLcAYLDZh
         d/Uw==
X-Gm-Message-State: APjAAAUngIUhVZGQg4leCy0L4qdVDqwSY+rpfje9gRxA2/Y4LPHL43NB
        oLoK8xDPqUDJPbsI6J+7Xtc/Nw==
X-Google-Smtp-Source: APXvYqzIxHKDdajLv/CInotTsm7OvAkaV83/NqqCG8MySSY6kGzvwI8OxUHuWx46aTKIpBRjjiuYrQ==
X-Received: by 2002:ac2:4adc:: with SMTP id m28mr14629166lfp.26.1575886612650;
        Mon, 09 Dec 2019 02:16:52 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:8d7:7661:9091:2bdc:ea2:564d? ([2a00:1fa0:8d7:7661:9091:2bdc:ea2:564d])
        by smtp.gmail.com with ESMTPSA id t2sm7171945ljj.11.2019.12.09.02.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 02:16:52 -0800 (PST)
Subject: Re: [PATCH bpf-next 05/12] xsk: eliminate the RX batch size
To:     Magnus Karlsson <magnus.karlsson@intel.com>, bjorn.topel@intel.com,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        jonathan.lemon@gmail.com
Cc:     bpf@vger.kernel.org, saeedm@mellanox.com,
        jeffrey.t.kirsher@intel.com, maciej.fijalkowski@intel.com,
        maciejromanfijalkowski@gmail.com
References: <1575878189-31860-1-git-send-email-magnus.karlsson@intel.com>
 <1575878189-31860-6-git-send-email-magnus.karlsson@intel.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <8e243b69-0642-962e-41b4-8d0107b960c6@cogentembedded.com>
Date:   Mon, 9 Dec 2019 13:16:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1575878189-31860-6-git-send-email-magnus.karlsson@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello!

On 09.12.2019 10:56, Magnus Karlsson wrote:

> In the xsk consumer ring code there is a variable call RX_BATCH_SIZE

    Called?

> that dictates the minimum number of entries that we try to grab from
> the fill and Tx rings. In fact, the code always try to grab the
   ^^^^^^^^^^^^^^^^^^^^^ hm, are you sure there's no typo here?

> maximum amount of entries from these rings. The only thing this
> variable does is to throw an error if there is less than 16 (as it is
> defined) entries on the ring. There is no reason to do this and it
> will just lead to weird behavior from user space's point of view. So
> eliminate this variable.
> 
> With this change, we will be able to simplify the xskq_nb_free and
> xskq_nb_avail code in the next commit.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
[...]

MBR, Sergei

